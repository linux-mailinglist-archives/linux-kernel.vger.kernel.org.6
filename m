Return-Path: <linux-kernel+bounces-242772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371D928CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F74287734
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3E16D9DA;
	Fri,  5 Jul 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBxQ5vZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2D145B10
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199786; cv=none; b=YwwGW+eWBcRdDb7X5YYT6t1/sZyEcyF4WcBTUmjf7HyJgHLQyIFxMiRZ++uTIXVTrcUGc+MR5u30/SOVfSTj2NuX94evHz2/2QvusYdOGFDAsMLdbF5TIoQk24tk+RI1eie7f58hbstP8zGSWaJZgIuM5+wEGQlYVN/ghmN0TN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199786; c=relaxed/simple;
	bh=dZatnfiMmvVyQvxnLAthSs7cidZ3zTY2scBacLP4/ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLJCyL19ndAlfTEg6trMSE29LeLOFN6CyNP2TGExtTafxo+HTDuh4a8eutnvcA+BTYUUQPWjb0blxnJZJdIn/YAM4bAs2sQZf194QlBWr4EuAhh925xXjhu5vM+0y9IiuL9cZ3PzRqOViY8k7FAtcxeZzN1pWQG9PyeqWI/egqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBxQ5vZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C1C116B1;
	Fri,  5 Jul 2024 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720199785;
	bh=dZatnfiMmvVyQvxnLAthSs7cidZ3zTY2scBacLP4/ts=;
	h=From:To:Cc:Subject:Date:From;
	b=XBxQ5vZk06C/im5YRl0yWGYNvv0atoeptxbTu4NwBVIwU81cBtCssfbSFKOsbT/HP
	 taUOUud4Ve618OwKydjUqDeX+kIT32CJypeqGHztysz83f2CfKJCtkfMoAfV5ybCai
	 9/ujs7olM0wjJBwpzwNF7JOoAAx1EI0angj7BUpMnSdwEMOec3sqRtYbxp2dRkRIV9
	 KbBaPCG/zhTYV2kGRm/ORhONd2oFmbry5LWeJ6jWaMU2XTwto8qQyXrkwMW+QGZ7v4
	 gEzSTwooOConLeYdZruaNy6hKNYXyALJ2JQVQ1xb1Xc0TopnEUAIrNVMFee+I+7QLN
	 YobCcQYBsGdGA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: define ILLEGAL_POINTER_VALUE for 64bit
Date: Sat,  6 Jul 2024 01:02:10 +0800
Message-ID: <20240705170210.3236-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used in poison.h for poison pointer offset. Based on current
SV39, SV48 and SV57 vm layout, 0xdead000000000000 is a proper value
that is not mappable, this can avoid potentially turning an oops to
an expolit.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

Since v1:
 - fix typo:s/SV59/SV57

 arch/riscv/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c51b32a8ddff..c992eabbd002 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -313,6 +313,11 @@ config GENERIC_HWEIGHT
 config FIX_EARLYCON_MEM
 	def_bool MMU
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0 if 32BIT
+	default 0xdead000000000000 if 64BIT
+
 config PGTABLE_LEVELS
 	int
 	default 5 if 64BIT
-- 
2.43.0


