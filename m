Return-Path: <linux-kernel+bounces-246250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8C792BF90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB56F1C2106F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94E19D88A;
	Tue,  9 Jul 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Reahh9T9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8FA34
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541987; cv=none; b=gyh/TLeEZ66Rr1zbrMLM/IZySv/ulOl4BWnH9WrsFZqXMKdQ3pFY2GKNK5TwQ5MZANlX+3lVIbPdxrpIkrp5JXaEfNnYbVvFAaVSivb5EHWEGicUJCVQhkF0G89iHXnT7XFAR8RzNd7DFlG8zdAtrOi6Jbtp7es+2POr4JyjSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541987; c=relaxed/simple;
	bh=xQ+k+zt3rSJvrwI1kO05fsSZ6yXFCul+pYXVqgNcdwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8MwixSQNUh1hF6VQz1qkUr/Z1CX7I60dcuWNamkk1oIk+M43txYR4KPHOsRj9+qiqQTBbuVok1ZTycE7Qn91wL76vZrdFHzA3DAUxdnBvFqMhw+avib50ku+qlClwWWCbkogVLsaZAsSp6HFKdGxtcQxGFvgdVDTbHsjb6oQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Reahh9T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D030C32786;
	Tue,  9 Jul 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541985;
	bh=xQ+k+zt3rSJvrwI1kO05fsSZ6yXFCul+pYXVqgNcdwI=;
	h=From:To:Cc:Subject:Date:From;
	b=Reahh9T9SgtFgoASAQ6WLIjFl+HaVAU8+qtVT+gq/QlE0L8FovbFiTmKyMA1N4t89
	 fTAoBEpk2l1JEkFi66Wee248xXZxXRwQi7vsRGADj/dg7nv+m1A/Dj3igIlIuqrE/F
	 TGYhGW6LPIQpdAnB6C36z0HdXPych59QefiEjWrYfgehUJwjwH3690hl7dZjjqShj4
	 u9Lr2Y3O7uEvzl2JQS7fm/cRTiC0YheKldiBJ8PP5II6dv2d72hVg/MNdqkMEQoYKR
	 nnqhKumiZS5q4NLpM+fjNlLORJfQojE6hjYVRCuXDtWo6l6ztf2jI6XXtrI3yniUxx
	 s4mgzfLiU8GXA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: select ARCH_USE_SYM_ANNOTATIONS
Date: Wed, 10 Jul 2024 00:05:20 +0800
Message-ID: <20240709160536.3690-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 76329c693924 ("riscv: Use SYM_*() assembly macros instead
of deprecated ones"), most riscv has been to converted the new style
SYM_ assembler annotations. The remaining one is sifive's
errata_cip_453.S, so convert to new style SYM_ annotations as well.
After that select ARCH_USE_SYM_ANNOTATIONS.


Since v1:
  - add new patch to convert sifive's errata_cip_453.S, thank Clément
  - update patch2 commit msg

Jisheng Zhang (2):
  riscv: errata: sifive: Use SYM_*() assembly macros
  riscv: select ARCH_USE_SYM_ANNOTATIONS

 arch/riscv/Kconfig                        | 1 +
 arch/riscv/errata/sifive/errata_cip_453.S | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.0


