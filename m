Return-Path: <linux-kernel+bounces-238007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F1924211
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EF4288B93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78D1BB6AE;
	Tue,  2 Jul 2024 15:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225221BB695;
	Tue,  2 Jul 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933298; cv=none; b=ew6k8+FbWZDVetd7c/nY6jV09YKJmqDz4LU43CMsLCS9nLrDmc9U4ygQMqwjd8KHxqsO+VGsuFIEsy+XC9vumClZScMOFQjKNfcQgL315QkDbk2oJAmP3T0q6XuKiDLsoRYKbYs+FNplipzYJC+7bL3bfQ52wCF7StsGd6DOU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933298; c=relaxed/simple;
	bh=xmfELzaz5LamrVXLrAIMck3j6UTUdJZCP384C33Ma6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q241KxsQditALYYTgpfjJfUDYEOnReuTZZUtUGJYq9Yatl5uWzCi8ooIpgylNfFthY+YDMc4pRhdfllqkrBCxOGcSqzhlGceKT3YWoVw0bBGSBUqRrzp9NM783lmy1Pj/ST6COYLGsNCoTjvF8x3pKybJnx4mu37QR0/EjQn3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4626CC116B1;
	Tue,  2 Jul 2024 15:14:55 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add ARCH_HAS_DEBUG_VM_PGTABLE support
Date: Tue,  2 Jul 2024 23:14:46 +0800
Message-ID: <20240702151446.1161159-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ARCH_HAS_DEBUG_VM_PGTABLE selection in Kconfig, in order to make
corresponding vm debug features usable on LoongArch. Also update the
corresponding arch-support.txt document.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
 arch/loongarch/Kconfig                                         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index bbf029f095cb..156687a7436d 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -12,7 +12,7 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |   loongarch: | TODO |
+    |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d8ca8b1b01f3..e346b5b0a5ca 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -16,6 +16,7 @@ config LOONGARCH
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
-- 
2.43.0


