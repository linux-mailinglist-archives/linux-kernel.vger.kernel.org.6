Return-Path: <linux-kernel+bounces-169850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FDD8BCE7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC128A693
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FD78C90;
	Mon,  6 May 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TtPIt+K0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A576919
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999954; cv=none; b=oz9Alg7+nAbA2vL1jSvUjIDHb8xFGxunWS7cKlBxPrPfAH8prmnowMfbo5kgtoM02QSwE0s0diWvNIGTpnTNVFgfG99KIFDowZ3xnoLK6LLC8XuuI4ELsg2sKkBHYhGVeOWZa6+53x/f6ycSpIrn3csYJNDcnU23SKKysATAwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999954; c=relaxed/simple;
	bh=Ce/fP6xScE3aVS8h902sx71LyCkgrk5kieJe+AKc8CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwY1+fsHV25uxIwqmHjP0cDREqsc7iL18dQyYb0jGI3KuHRQCX6SpgNNlo/wK2JP4ahz/p5Guo5w2VTT3kra41zg3YcMQO1zK2lNtofemp/cTYlYHpNnsjeuoACxTT3BNDUQXBssaMMVx5BTPLpSdwpawD1+yBZ7sccH4F1V/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TtPIt+K0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714999946;
	bh=GBEPaRZyteJkC6BUvRNboaSanQS3npKz4CeG4H3+xfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtPIt+K0SqSoCNTxcJORwMADAGf0tHsQURR0AaDYWDwvQBs1v9f3XfxoKy1V9MhHO
	 JxVhxprRn9VvuPZmt9Dpcyi4GWItHMOOT8s/1cmt6zSC6D5VCXmBkrTy78a+00euyR
	 PCbyv/UYqlfG/9nNl1M0Ra+xlSRApuWMWrL7r0vNSFJGRjvk0fyb4dbgJb1uf5zRgv
	 HB8+sReTuP8KqssK7MPMXPEYY8kmC2TpK37h29W3dEZeDBjq84YUMyZOpPEkCKH/wY
	 p6QkLYs7BTOGVcOP4qH6Pi0jmCD52bM4aSAsei7GMJrJ7mWX5OH+M4fl17A0RODdYN
	 G7NhHXU8au7Kw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VY1XB0rHjz4x2y;
	Mon,  6 May 2024 22:52:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<christophe.leroy@csgroup.eu>
Subject: [PATCH 7/7] powerpc/platforms: Move files from 4xx to 44x
Date: Mon,  6 May 2024 22:51:52 +1000
Message-ID: <20240506125152.78174-8-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506125152.78174-1-mpe@ellerman.id.au>
References: <20240506125152.78174-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Only 44x uses 4xx now, so only keep one directory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/44x/Makefile           |  6 ++++-
 arch/powerpc/platforms/{4xx => 44x}/cpm.c     |  0
 arch/powerpc/platforms/{4xx => 44x}/gpio.c    |  0
 .../powerpc/platforms/{4xx => 44x}/hsta_msi.c |  0
 arch/powerpc/platforms/44x/machine_check.c    | 15 ++++++++++++
 arch/powerpc/platforms/{4xx => 44x}/pci.c     |  0
 arch/powerpc/platforms/{4xx => 44x}/pci.h     |  0
 arch/powerpc/platforms/{4xx => 44x}/soc.c     |  0
 arch/powerpc/platforms/{4xx => 44x}/uic.c     |  0
 arch/powerpc/platforms/4xx/Makefile           |  7 ------
 arch/powerpc/platforms/4xx/machine_check.c    | 23 -------------------
 arch/powerpc/platforms/Makefile               |  1 -
 12 files changed, 20 insertions(+), 32 deletions(-)
 rename arch/powerpc/platforms/{4xx => 44x}/cpm.c (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/gpio.c (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/hsta_msi.c (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/pci.c (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/pci.h (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/soc.c (100%)
 rename arch/powerpc/platforms/{4xx => 44x}/uic.c (100%)
 delete mode 100644 arch/powerpc/platforms/4xx/Makefile
 delete mode 100644 arch/powerpc/platforms/4xx/machine_check.c

diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 5ba031f57652..ca7b1bb442d9 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y	+= misc_44x.o machine_check.o
+obj-y	+= misc_44x.o machine_check.o uic.o soc.o
 ifneq ($(CONFIG_PPC4xx_CPM),y)
 obj-y	+= idle.o
 endif
@@ -12,3 +12,7 @@ obj-$(CONFIG_CANYONLANDS)+= canyonlands.o
 obj-$(CONFIG_CURRITUCK)	+= ppc476.o
 obj-$(CONFIG_AKEBONO)	+= ppc476.o
 obj-$(CONFIG_FSP2)	+= fsp2.o
+obj-$(CONFIG_PCI)		+= pci.o
+obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
+obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
+obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/arch/powerpc/platforms/4xx/cpm.c b/arch/powerpc/platforms/44x/cpm.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/cpm.c
rename to arch/powerpc/platforms/44x/cpm.c
diff --git a/arch/powerpc/platforms/4xx/gpio.c b/arch/powerpc/platforms/44x/gpio.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/gpio.c
rename to arch/powerpc/platforms/44x/gpio.c
diff --git a/arch/powerpc/platforms/4xx/hsta_msi.c b/arch/powerpc/platforms/44x/hsta_msi.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/hsta_msi.c
rename to arch/powerpc/platforms/44x/hsta_msi.c
diff --git a/arch/powerpc/platforms/44x/machine_check.c b/arch/powerpc/platforms/44x/machine_check.c
index 5d19daacd78a..85ff33a8d9b6 100644
--- a/arch/powerpc/platforms/44x/machine_check.c
+++ b/arch/powerpc/platforms/44x/machine_check.c
@@ -9,6 +9,21 @@
 #include <asm/reg.h>
 #include <asm/cacheflush.h>
 
+int machine_check_4xx(struct pt_regs *regs)
+{
+	unsigned long reason = regs->esr;
+
+	if (reason & ESR_IMCP) {
+		printk("Instruction");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	} else
+		printk("Data");
+
+	printk(" machine check in kernel mode.\n");
+
+	return 0;
+}
+
 int machine_check_440A(struct pt_regs *regs)
 {
 	unsigned long reason = regs->esr;
diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/44x/pci.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/pci.c
rename to arch/powerpc/platforms/44x/pci.c
diff --git a/arch/powerpc/platforms/4xx/pci.h b/arch/powerpc/platforms/44x/pci.h
similarity index 100%
rename from arch/powerpc/platforms/4xx/pci.h
rename to arch/powerpc/platforms/44x/pci.h
diff --git a/arch/powerpc/platforms/4xx/soc.c b/arch/powerpc/platforms/44x/soc.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/soc.c
rename to arch/powerpc/platforms/44x/soc.c
diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/44x/uic.c
similarity index 100%
rename from arch/powerpc/platforms/4xx/uic.c
rename to arch/powerpc/platforms/44x/uic.c
diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx/Makefile
deleted file mode 100644
index 7f57c35f8dec..000000000000
--- a/arch/powerpc/platforms/4xx/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y				+= uic.o machine_check.o
-obj-$(CONFIG_44x)		+= soc.o
-obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
-obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
-obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/platforms/4xx/machine_check.c
deleted file mode 100644
index a905da1d6f41..000000000000
--- a/arch/powerpc/platforms/4xx/machine_check.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- */
-
-#include <linux/kernel.h>
-#include <linux/printk.h>
-#include <linux/ptrace.h>
-
-#include <asm/reg.h>
-
-int machine_check_4xx(struct pt_regs *regs)
-{
-	unsigned long reason = regs->esr;
-
-	if (reason & ESR_IMCP) {
-		printk("Instruction");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	} else
-		printk("Data");
-	printk(" machine check in kernel mode.\n");
-
-	return 0;
-}
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index d1a417b301b6..786d374bff31 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
-obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_44x)		+= 44x/
 obj-$(CONFIG_PPC_MPC512x)	+= 512x/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
-- 
2.45.0


