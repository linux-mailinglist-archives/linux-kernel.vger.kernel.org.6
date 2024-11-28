Return-Path: <linux-kernel+bounces-425039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA19DBCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B403164877
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2981C2457;
	Thu, 28 Nov 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AKhLWFHd"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C709145323
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824636; cv=none; b=qzB259oeW4t6Sg8kvlPNxFv4imfYC1crLL4DBisM64g7X2XXt7C7E3ZmgE5aYOHOlQRCmCqsTcRQN/X5DzEqx0VZDYT1Q0nlgadx44guhCI7dRL5maItiVNJGdQVEMAQl+3Q9cq5FSJHnxeMDfptL7twTxyCLJVv6Jgcn1lwUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824636; c=relaxed/simple;
	bh=5KiG7zzYxYkrromkp9tKIw2W1gcyJFCJQG6c3Bcn4Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ledIldsMCj++Fa86k6qRskHR8N9mijFqkWkwOeSNaYgBzmtP+NZ+wqO6Td0kn1lp8NbAKtHF/yJ4tFNL31FPmpK9ATTxgvyFbr6asRBf3MJFtNVexoB+NREh2fByBvbkWtV0Bg5DjyQk2PDpLfOWfXrl/Z2Ps+0+1ce2ZmEqpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AKhLWFHd; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732824635; x=1764360635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l86XJw2zl5RMCsAJYGRzrxx2y2yPBRK+02pPUOrN8FA=;
  b=AKhLWFHd9zp9x6teXuPyZNyMnlif1agOoJDjWozGUv32bXemu0LBojzJ
   8xN2xBFgaCeJDHBCu+NJu46JSp+GDwRjljvXaAeh1Snsd2XFcN982ftvK
   kP1/e/tvAwaGeAjunJLVSzCpWs35KeTyVqgVPXpZh/NqMeDo76jsTYOwU
   8=;
X-IronPort-AV: E=Sophos;i="6.12,193,1728950400"; 
   d="scan'208";a="452016254"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:10:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:54823]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 7d845fb6-a2a4-4ba0-b994-ec63e5a88ad3; Thu, 28 Nov 2024 20:10:29 +0000 (UTC)
X-Farcaster-Flow-ID: 7d845fb6-a2a4-4ba0-b994-ec63e5a88ad3
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:28 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 28 Nov 2024 20:10:28 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTP id 82B3F40490;
	Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 421392481; Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<ebiederm@xmission.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<farbere@amazon.com>, <hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v3 1/2] kexec: Consolidate machine_kexec_mask_interrupts() implementation
Date: Thu, 28 Nov 2024 20:10:26 +0000
Message-ID: <20241128201027.10396-2-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241128201027.10396-1-farbere@amazon.com>
References: <20241128201027.10396-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move the machine_kexec_mask_interrupts function to a common location in
kernel/kexec_core.c, removing duplicate implementations from architecture
specific files (arch/arm, arch/arm64, arch/powerpc, and arch/riscv).

This consolidation reduces code duplication and improves maintainability.

The unified function includes an architecture-specific behavior for
CONFIG_ARM64 by conditionally clearing the active interrupt state before
handling other interrupt masking operations.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V2 -> V3: This patch is new and didn't exist in V2.

 arch/arm/kernel/machine_kexec.c   | 23 ----------------------
 arch/arm64/kernel/machine_kexec.c | 31 ------------------------------
 arch/powerpc/include/asm/kexec.h  |  1 -
 arch/powerpc/kexec/core.c         | 22 ---------------------
 arch/riscv/kernel/machine_kexec.c | 23 ----------------------
 include/linux/kexec.h             |  2 ++
 kernel/kexec_core.c               | 32 +++++++++++++++++++++++++++++++
 7 files changed, 34 insertions(+), 100 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 80ceb5bd2680..dd430477e7c1 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -127,29 +127,6 @@ void crash_smp_send_stop(void)
 	cpus_stopped = 1;
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	local_irq_disable();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203d86a3..6f121a0164a4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -207,37 +207,6 @@ void machine_kexec(struct kimage *kimage)
 	BUG(); /* Should never get here. */
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-		int ret;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		/*
-		 * First try to remove the active state. If this
-		 * fails, try to EOI the interrupt.
-		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
-
-		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
-		    chip->irq_eoi)
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 /**
  * machine_crash_shutdown - shutdown non-crashing cpus and save registers
  */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 270ee93a0f7d..601e569303e1 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -61,7 +61,6 @@ struct pt_regs;
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
 extern void default_machine_kexec(struct kimage *image);
-extern void machine_kexec_mask_interrupts(void);
 
 void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_code_buffer,
 			 unsigned long start_address) __noreturn;
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index b8333a49ea5d..58a930a47422 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -22,28 +22,6 @@
 #include <asm/setup.h>
 #include <asm/firmware.h>
 
-void machine_kexec_mask_interrupts(void) {
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 #ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 3c830a6f7ef4..2306ce3e5f22 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -114,29 +114,6 @@ void machine_shutdown(void)
 #endif
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 /*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..9dac0524c0be 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -375,6 +375,8 @@ extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
+extern void machine_kexec_mask_interrupts(void);
+
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..6e1e420946e0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1072,3 +1072,35 @@ int kernel_kexec(void)
 	kexec_unlock();
 	return error;
 }
+
+void machine_kexec_mask_interrupts(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+		int check_eoi = 1;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		if (IS_ENABLED(CONFIG_ARM64)) {
+			/*
+			 * First try to remove the active state. If this fails, try to EOI the
+			 * interrupt.
+			 */
+			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+		}
+
+		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}
-- 
2.40.1


