Return-Path: <linux-kernel+bounces-435828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B89E7DB4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F0285AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA219460;
	Sat,  7 Dec 2024 01:21:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A317BA3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534502; cv=none; b=iLbxf3r52044DQmScxlvbGfTMaSrBiE4UsExmltpam02lAF9/Z4EGRpUueWzYMwkKcaDrs5w4nSe8KMRj/FQ6ZVJ/ZSBesE2Bw3p84q35/x7l5B5y/Lls4AXFDkJev1MNLsP+J3e7Bv6SEGfb2QCWYzlfnK/L3Xja76+tnKu3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534502; c=relaxed/simple;
	bh=1BHpzhlmXMBKAy9iOjhUIGUD5/Q9bpyHXoqQdyCPlNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAf0mgEFolDY4/xR8t8XmfCJm+dd8uh685uy4v3xpbSZwqPiV3MbYyBaPZ6jgQzcXDNuSIpVnUlTPp5N0rlZ8OfSoWIR9MTfPyo1nxNt5rH6P/wQO9bT6MPxYmACTfm0eADFID6vMzsuT7KKdDPmadPSCX7jpxv2XLATKXVqphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7D512FC;
	Fri,  6 Dec 2024 17:22:07 -0800 (PST)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53613F5A1;
	Fri,  6 Dec 2024 17:21:39 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: suzuki.poulose@arm.com,
	gshan@redhat.com,
	steven.price@arm.com,
	sami.mujawar@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 1/1] arm64: rsi: Add automatic arm-cca-guest module loading
Date: Fri,  6 Dec 2024 19:21:28 -0600
Message-ID: <20241207012128.247522-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241207012128.247522-1-jeremy.linton@arm.com>
References: <20241207012128.247522-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TSM module provides guest identification and attestation when a
guest runs in CCA mode. By creating a dummy platform device, let's
ensure the module is automatically loaded. The udev daemon loads the
TSM module after it receives a device addition event. Once that
happens, it can be used earlier in the boot process to decrypt the
rootfs.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/rsi.h                    |  2 ++
 arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index 188cbb9b23f5..b42aeac05340 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -10,6 +10,8 @@
 #include <linux/jump_label.h>
 #include <asm/rsi_cmds.h>
 
+#define RSI_PDEV_NAME "arm-cca-dev"
+
 DECLARE_STATIC_KEY_FALSE(rsi_present);
 
 void __init arm64_rsi_init(void);
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 3031f25c32ef..5434e5496ac2 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -8,6 +8,7 @@
 #include <linux/psci.h>
 #include <linux/swiotlb.h>
 #include <linux/cc_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/mem_encrypt.h>
@@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
 	static_branch_enable(&rsi_present);
 }
 
+static struct platform_device rsi_dev = {
+	.name = RSI_PDEV_NAME,
+	.id = PLATFORM_DEVID_NONE
+};
+
+static int __init rsi_init(void)
+{
+	if (is_realm_world() &&
+	    platform_device_register(&rsi_dev))
+		pr_err("failed to register rsi platform device\n");
+	return 0;
+}
+
+arch_initcall(rsi_init)
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 488153879ec9..87f162736b2e 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
@@ -6,6 +6,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/cc_platform.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/tsm.h>
@@ -219,6 +220,13 @@ static void __exit arm_cca_guest_exit(void)
 }
 module_exit(arm_cca_guest_exit);
 
+/* modalias, so userspace can autoload this module when RSI is available */
+static const struct platform_device_id arm_cca_match[] __maybe_unused = {
+	{ RSI_PDEV_NAME, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(platform, arm_cca_match);
 MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
 MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
 MODULE_LICENSE("GPL");
-- 
2.46.0


