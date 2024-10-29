Return-Path: <linux-kernel+bounces-387088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1649B4BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297761C2241F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D0206E8B;
	Tue, 29 Oct 2024 14:11:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED91BA2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211085; cv=none; b=BT0vo3oD9FHSCk+5sj2fUhXQTbCInC1bu4t3OEtAe14Cq4HEKTWf5BvQh6sbcurCm3YiIP0ggSOi4Diepfiduwj20FfxUcMPrJy5jdW3i7l4gVC+iGyE0qwXh6tmQfhIHIB4+oWRh4ZLwuEVvGkCcYp7j8TB6c1yFJitM3pvaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211085; c=relaxed/simple;
	bh=sbRiA5AupD7lPPBP+1DTbZV36D3k1wM9CyHAfE5urzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYZiP3GFzwUNnKcGw9bOqYBboa9ctwOgSe0LrS2yO3QtsTHuBvAYD8uc0Ra5jJImR+CSbuxhe/CxlEVhNyzseSpilsV4l8RwU6D45KYKgsct65bnZYxwpbkKtOv73GGV2I3R3p3nJrmpYRLUgK9SNG7Udd9CwHWrA0g2Ugz4d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A48113E;
	Tue, 29 Oct 2024 07:11:52 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF393F528;
	Tue, 29 Oct 2024 07:11:22 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com,
	suzuki.poulose@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	gshan@redhat.com,
	sami.mujawar@arm.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
Date: Tue, 29 Oct 2024 09:11:14 -0500
Message-ID: <20241029141114.7207-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TSM module provides both guest identification as well as
attestation when a guest is run in CCA mode. Lets assure by creating a
dummy platform device that the module is automatically loaded during
boot. Once it is in place it can be used earlier in the boot process
to say decrypt a LUKS rootfs.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/rsi.h                    |  2 ++
 arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index 188cbb9b23f5..1b14a4c4257a 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -10,6 +10,8 @@
 #include <linux/jump_label.h>
 #include <asm/rsi_cmds.h>
 
+#define ARMV9_RSI_PDEV_NAME "arm-cca-dev"
+
 DECLARE_STATIC_KEY_FALSE(rsi_present);
 
 void __init arm64_rsi_init(void);
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 3031f25c32ef..ad963eb12921 100644
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
+	.name = ARMV9_RSI_PDEV_NAME,
+	.id = -1
+};
+
+static int __init rsi_init(void)
+{
+	if (is_realm_world())
+		if (platform_device_register(&rsi_dev))
+			pr_err("failed to register rsi platform device");
+	return 0;
+}
+
+arch_initcall(rsi_init)
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 488153879ec9..e7ef3b83d5d9 100644
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
@@ -219,6 +220,12 @@ static void __exit arm_cca_guest_exit(void)
 }
 module_exit(arm_cca_guest_exit);
 
+static const struct platform_device_id arm_cca_match[] = {
+	{ ARMV9_RSI_PDEV_NAME, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(platform, arm_cca_match);
 MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
 MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
 MODULE_LICENSE("GPL");
-- 
2.46.0


