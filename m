Return-Path: <linux-kernel+bounces-443134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C19EE7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFD7161ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51087214A7D;
	Thu, 12 Dec 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="J6H+uTHd"
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net [87.98.181.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390B213E9C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010558; cv=none; b=O4vfuyGvUX6R6SwIq2jcGU5qoJrm1Ccf/0UOANRTgSpJJX88mn7xNhF08PYH8DWbAJ8SsJX8PrUNvoFpryVEEidoBtCsZgeF5MAKyEKkROGgvHdjBARNL3tZo5IC2BFxR+xuCizrE/f8zRxyz3V6yjH1EdcLKeUKNv4mGii9PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010558; c=relaxed/simple;
	bh=DhLN23+I67NLh5tNngCQEJccuYLqkrbKZMqpgnLboMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1JYc7YDabd0YJz2fBNHb14H6sxUAM665NhX/z1IOLT+sI93RbR3tqtKacmNyN72hW662V1EvKUMjBEFEK3/+803jCB1iryOYrWfsIdz2Ei/E+q+asyXHkEAHTVnmBBeYybJZfZTNmYxMjFGLgBCDL++IKlzdTBSlK1UeD+eYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=J6H+uTHd; arc=none smtp.client-ip=87.98.181.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.148.110])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4f4VJNz1jFB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:46 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-kw7dr (unknown [10.111.174.111])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9083A1FD45;
	Thu, 12 Dec 2024 13:35:45 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.103])
	by ghost-submission-5b5ff79f4f-kw7dr with ESMTPSA
	id dTWDA7HmWmdUAgAARSgzHg
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:45 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-103G005865b1033-cc3b-44ce-a960-c2ced23a2f41,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 9/9] psp: Perform kernel portion of DRTM procedures
Date: Thu, 12 Dec 2024 15:35:07 +0200
Message-ID: <1121b11e45c495c7b99b4e3b77ed5ef95903dabc.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16623349178858714268
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=p4X1QecRsJNPcv0nCV7Ipc+QM8itz88m5FTdlaf/Su8=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010546; v=1;
 b=J6H+uTHd/CJO87nzEPmEJ5cKYHlH3crM120vP0LHRGZeEHKE+vW7i5ccJcbtEGC75WEGmVq3
 NCl6C3tA87utsJ+nqgRneb+cP0ag9cV4nZrecaZKZy2W+nYXK9EWI1hrSJNfBTWS1/2o8+fJrvK
 WeX2yHC2hsJrO/i2hN3gPVs1etrcYTvLeMlpqvZlKHzNdkfWdASF8MJXYPqF5TcJgEXQBPElu9H
 GH21OxbGFdmn5L/J35SLlKvM3l8F6WH4wZ9X2+KLgTkHVPX6jaq/G2vLIFaFARD2eMvT5evOETj
 /jxxtNwdRNACM248FiUlZaFzO4LShRg1L6ZZ8Y2Tl64KA==

From: Jagannathan Raman <jag.raman@oracle.com>

GRUB and AMD-SL would have executed the SKINIT instruction and performed
DRTM setup procedures. As part of DRTM, GRUB sets up TMRs to cover the
whole of the system's physical memory regions. The Kernel should release
these TMRs to facilitate communication between devices and drivers. TMRs
are released after the Kernel sets up IOMMU.

Releasing TMRs concludes DRTM. The Kernel should also execute
DRTM_CMD_TPM_LOCALITY_ACCESS to lock TPM locality two before removing
TMRs. But this prevents the Kernel's TPM driver (which loads
subsequently) from extending PCRs. As such, we are skipping the TPM
locality access command.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 arch/x86/kernel/Makefile  |   1 +
 arch/x86/kernel/sl-psp.c  | 239 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/slaunch.c |   4 +-
 drivers/iommu/amd/init.c  |  12 ++
 4 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/sl-psp.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6028903d6661..972396d96b0b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -74,6 +74,7 @@ obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= sl-psp.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/sl-psp.c b/arch/x86/kernel/sl-psp.c
new file mode 100644
index 000000000000..69d24f275042
--- /dev/null
+++ b/arch/x86/kernel/sl-psp.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch early setup.
+ *
+ * Copyright (c) 2024, Oracle and/or its affiliates.
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/slaunch.h>
+#include <asm/cpufeatures.h>
+#include <asm/msr.h>
+#include <asm/pci_x86.h>
+#include <asm/svm.h>
+
+#define	DRTM_MBOX_READY_MASK		0x80000000
+#define	DRTM_MBOX_TMR_INDEX_ID_MASK	0x0F000000
+#define	DRTM_MBOX_CMD_MASK		0x00FF0000
+#define	DRTM_MBOX_STATUS_MASK		0x0000FFFF
+
+#define	DRTM_MBOX_CMD_SHIFT		16
+
+#define	DRTM_NO_ERROR			0x00000000
+#define	DRTM_NOT_SUPPORTED		0x00000001
+#define	DRTM_LAUNCH_ERROR		0x00000002
+#define	DRTM_TMR_SETUP_FAILED_ERROR	0x00000003
+#define	DRTM_TMR_DESTROY_FAILED_ERROR	0x00000004
+#define	DRTM_GET_TCG_LOGS_FAILED_ERROR	0x00000007
+#define	DRTM_OUT_OF_RESOURCES_ERROR	0x00000008
+#define	DRTM_GENERIC_ERROR		0x00000009
+#define	DRTM_INVALID_SERVICE_ID_ERROR	0x0000000A
+#define	DRTM_MEMORY_UNALIGNED_ERROR	0x0000000B
+#define	DRTM_MINIMUM_SIZE_ERROR		0x0000000C
+#define	DRTM_GET_TMR_DESCRIPTOR_FAILED	0x0000000D
+#define	DRTM_EXTEND_OSSL_DIGEST_FAILED	0x0000000E
+#define	DRTM_SETUP_NOT_ALLOWED		0x0000000F
+#define	DRTM_GET_IVRS_TABLE_FAILED	0x00000010
+
+#define DRTM_CMD_GET_CAPABILITY		0x1
+#define	DRTM_CMD_TMR_SETUP		0x2
+#define	DRTM_CMD_TMR_RELEASE		0x3
+#define	DRTM_CMD_LAUNCH			0x4
+#define	DRTM_CMD_GET_TCG_LOGS		0x7
+#define	DRTM_CMD_TPM_LOCALITY_ACCESS	0x8
+#define	DRTM_CMD_GET_TMR_DESCRIPTORS	0x9
+#define	DRTM_CMD_ALLOCATE_SHARED_MEMORY	0xA
+#define	DRTM_CMD_EXTEND_OSSL_DIGEST	0xB
+#define	DRTM_CMD_GET_IVRS_TABLE_INFO	0xC
+
+#define DRTM_TMR_INDEX_0		0
+#define DRTM_TMR_INDEX_1		1
+#define DRTM_TMR_INDEX_2		2
+#define DRTM_TMR_INDEX_3		3
+#define DRTM_TMR_INDEX_4		4
+#define DRTM_TMR_INDEX_5		5
+#define DRTM_TMR_INDEX_6		6
+#define DRTM_TMR_INDEX_7		7
+
+#define	DRTM_CMD_READY			0
+#define	DRTM_RESPONSE_READY		1
+
+static bool slaunch_psp_early_setup_done;
+
+static u32 __iomem *c2pmsg_72;
+
+static void slaunch_smn_register_read(u32 address, u32 *value)
+{
+	u32 val;
+
+	val = address;
+	pci_direct_conf1.write(0, 0, 0, 0xB8, 4, val);
+	pci_direct_conf1.read(0, 0, 0, 0xBC, 4, &val);
+
+	*value = val;
+}
+
+#define IOHC0NBCFG_SMNBASE		0x13B00000
+#define PSP_BASE_ADDR_LO_SMN_ADDRESS	(IOHC0NBCFG_SMNBASE + 0x102E0)
+
+static u32 slaunch_get_psp_bar_addr(void)
+{
+	u32 pspbaselo = 0;
+
+	slaunch_smn_register_read(PSP_BASE_ADDR_LO_SMN_ADDRESS, &pspbaselo);
+
+	/* Mask out the lower bits */
+	pspbaselo &= 0xFFF00000;
+
+	return pspbaselo;
+}
+
+static void slaunch_clear_c2pmsg_regs(void)
+{
+	if (c2pmsg_72)
+		iounmap(c2pmsg_72);
+
+	c2pmsg_72 = NULL;
+}
+
+static bool slaunch_setup_c2pmsg_regs(void)
+{
+	phys_addr_t bar2;
+
+	bar2 = (phys_addr_t)slaunch_get_psp_bar_addr();
+	if (!bar2)
+		return false;
+
+	c2pmsg_72 = ioremap(bar2 + 0x10a20, 4);
+	if (!c2pmsg_72) {
+		slaunch_clear_c2pmsg_regs();
+		return false;
+	}
+
+	return true;
+}
+
+static const char *const slaunch_status_strings[] = {
+	"DRTM_NO_ERROR",
+	"DRTM_NOT_SUPPORTED",
+	"DRTM_LAUNCH_ERROR",
+	"DRTM_TMR_SETUP_FAILED_ERROR",
+	"DRTM_TMR_DESTROY_FAILED_ERROR",
+	"UNDEFINED",
+	"UNDEFINED",
+	"DRTM_GET_TCG_LOGS_FAILED_ERROR",
+	"DRTM_OUT_OF_RESOURCES_ERROR",
+	"DRTM_GENERIC_ERROR",
+	"DRTM_INVALID_SERVICE_ID_ERROR",
+	"DRTM_MEMORY_UNALIGNED_ERROR",
+	"DRTM_MINIMUM_SIZE_ERROR",
+	"DRTM_GET_TMR_DESCRIPTOR_FAILED",
+	"DRTM_EXTEND_OSSL_DIGEST_FAILED",
+	"DRTM_SETUP_NOT_ALLOWED",
+	"DRTM_GET_IVRS_TABLE_FAILED"
+};
+
+static const char *slaunch_status_string(u32 status)
+{
+	if (status > DRTM_GET_IVRS_TABLE_FAILED)
+		return "UNDEFINED";
+
+	return slaunch_status_strings[status];
+}
+
+static bool slaunch_wait_for_psp_ready(u32 *status)
+{
+	u32 reg_val = 0;
+	int retry = 5;
+
+	if (readl(c2pmsg_72) == 0xFFFFFFFF)
+		return false;
+
+	while (--retry) {
+		reg_val = readl(c2pmsg_72);
+		if (reg_val & DRTM_MBOX_READY_MASK)
+			break;
+
+		/* TODO: select wait time appropriately */
+		mdelay(100);
+	}
+
+	if (!retry)
+		return false;
+
+	if (status)
+		*status = reg_val & 0xffff;
+
+	return true;
+}
+
+static bool slaunch_tpm_locality_access(void)
+{
+	u32 status;
+
+	writel(DRTM_CMD_TPM_LOCALITY_ACCESS << DRTM_MBOX_CMD_SHIFT, c2pmsg_72);
+
+	if (!slaunch_wait_for_psp_ready(&status)) {
+		pr_err("Failed to execute DRTM_CMD_TPM_LOCALITY_ACCESS\n");
+		return false;
+	}
+
+	if (status != DRTM_NO_ERROR) {
+		pr_err("DRTM_CMD_TPM_LOCALITY_ACCESS failed - %s",
+		       slaunch_status_string(status));
+		return false;
+	}
+
+	return true;
+}
+
+bool slaunch_psp_tmr_release(void)
+{
+	u32 status;
+
+	if (!slaunch_psp_early_setup_done)
+		return false;
+
+	writel(DRTM_CMD_TMR_RELEASE << DRTM_MBOX_CMD_SHIFT, c2pmsg_72);
+
+	if (!slaunch_wait_for_psp_ready(&status)) {
+		pr_err("Failed to execute DRTM_CMD_TMR_RELEASE_ACCESS\n");
+		return false;
+	}
+
+	if (status != DRTM_NO_ERROR) {
+		pr_err("DRTM_CMD_TMR_RELEASE failed - %s",
+		       slaunch_status_string(status));
+		return false;
+	}
+
+	return true;
+}
+
+void slaunch_psp_setup(void)
+{
+	if (slaunch_psp_early_setup_done)
+		return;
+
+	if (!slaunch_setup_c2pmsg_regs())
+		return;
+
+	if (!slaunch_wait_for_psp_ready(NULL)) {
+		pr_err("PSP not ready to take commands\n");
+		return;
+	}
+
+	slaunch_psp_early_setup_done = true;
+}
+
+void slaunch_psp_finalize(void)
+{
+	if (!slaunch_tpm_locality_access()) {
+		pr_err("PSP failed to lock TPM DRTM localities\n");
+		return;
+	}
+
+	slaunch_clear_c2pmsg_regs();
+}
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 3a6e4d22b54d..bfd96f75c089 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -701,13 +701,15 @@ static void slaunch_finalize_txt(int do_sexit)
 }
 
 /*
- * Used during kexec and on reboot paths to finalize the SKINIT.
+ * Used during kexec and on reboot paths to finalize the SKINIT PSP state.
  */
 static void slaunch_finalize_skinit(void)
 {
 	/* AMD CPUs with PSP-supported DRTM */
 	if (!slaunch_is_skinit_psp())
 		return;
+
+	slaunch_psp_finalize();
 }
 
 void slaunch_finalize(int do_sexit)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c89d85b54a1a..2bb753283f84 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -22,6 +22,7 @@
 #include <linux/kmemleak.h>
 #include <linux/cc_platform.h>
 #include <linux/iopoll.h>
+#include <linux/slaunch.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -3347,6 +3348,17 @@ int __init amd_iommu_enable(void)
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	if (slaunch_is_skinit_psp()) {
+		/* Initialize PSP access to SKINIT DRTM functions */
+		slaunch_psp_setup();
+
+		/* Release the Trusted Memory Region since IOMMU is configured */
+		if (!slaunch_psp_tmr_release())
+			return -ENODEV;
+	}
+#endif
+
 	irq_remapping_enabled = 1;
 	return amd_iommu_xt_mode;
 }
-- 
2.47.1


