Return-Path: <linux-kernel+bounces-228273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A5915D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810CDB21FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76213A253;
	Tue, 25 Jun 2024 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfWDKXZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E612FB2A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289145; cv=none; b=rlDl5k+I/BQUb13Cv+2Xq2Tgcik7dBgdRL7RMQW8H5mXjXpJq+kv+tsiunidyiGJrvtXAuYJhhseVJv7sRYIhUuGrFgox/odvPIx40vqYwxlvmR46I+q61m8QdK6SUJ4k0eFK5YN29ZtB6VMLDQKNsC7cYCWzItOM6cir8XBmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289145; c=relaxed/simple;
	bh=GrEKh3PyvywkkJCCh0CV+o3/R9l1xc2hMRsBib/V7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akI1YTRHq83UXAemQDM7Z/Xi1DZpFEi+QMUA2ukI4tmxgqsrnfgLS0xke+AEWXVmb8GKDsUNGRA/ZaWrLPv9DbnzFAZolFCsSSh+x67OXSJKoFUfI2vpTzwk9NuvI+wKEC3h9mLqKrh6GxrQZQiCxD9BpAUmkMehASPhX3zub+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfWDKXZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF558C32782;
	Tue, 25 Jun 2024 04:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719289144;
	bh=GrEKh3PyvywkkJCCh0CV+o3/R9l1xc2hMRsBib/V7hc=;
	h=From:To:Cc:Subject:Date:From;
	b=PfWDKXZ19DFkqKQAgl0JsO0UW8gw1L/cwoYdGwWjnSkaxuc668olCccWsqbQ3K7Db
	 /HCua12lXUZtN50DKmm43lplZ0vISoBLbxM514jSz7KhC0mV6Vj5+D4mpoKMoOrs5R
	 Tp8/JCHcqNNu95S7A+rVzGwc22AP5K1Rp9Aob82hqOAiH26A4DaSpPW5Xnc3Gqz0NB
	 u/7IgJbcdhY7ZT+DB8W7Spv3KVkBi6JKw3dtcnjpIMgQ0P2X44wWXkjjoMUNHvQ6xR
	 PQKa7fOZn7+QWY2Hp3sg4rMzH/GAJx4XE2YD1Jul4YtgAmA5BxfeyNPlJHQAhJypQt
	 LIuEp+c2Gi6Iw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] riscv: uaccess: optimizations
Date: Tue, 25 Jun 2024 12:04:56 +0800
Message-ID: <20240625040500.1788-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to optimize riscv uaccess in the following way:

patch1 implement the user_access_begin and families, I.E the unsafe
accessors. when a function like strncpy_from_user() is called,
the userspace access protection is disabled and enabled for every
word read. After patch1, the protection is disabled at the beginning
of the copy and enabled at the end.

patch2 is a simple clean up

patch3 uses 'asm goto' for put_user()
patch4 uses 'asm goto output' for get_user()

Both patch3 and patch4 are based on the fact -- 'asm goto' and
'asm goto output'generates noticeably better code since we don't need
to test the error etc, the exception just jumps to the error handling
directly.


Jisheng Zhang (4):
  riscv: implement user_access_begin and families
  riscv: uaccess: use input constraints for ptr of __put_user
  riscv: uaccess: use 'asm goto' for put_user()
  riscv: uaccess: use 'asm goto output' for get_user

 arch/riscv/include/asm/uaccess.h | 201 +++++++++++++++++++++++--------
 1 file changed, 149 insertions(+), 52 deletions(-)

-- 
2.43.0


