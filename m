Return-Path: <linux-kernel+bounces-248027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F992D781
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E67B1C21143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71D197A7D;
	Wed, 10 Jul 2024 17:32:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242719754A;
	Wed, 10 Jul 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632754; cv=none; b=oVZNKFo5uuTWnEnzVwSqi3Y6HNiMew/20R/axRmVvea79MdIaaqSULZ6PHB5q791Fsmly8bKliazBEeVVFZYYwWmzZ/t3mlxFw4qShOW1ny83ahfa4vO5iLK/1ErFn59M2m7Q3q016cyO2DxD9hLPa9e2DM+XM78yYJ5KYZspRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632754; c=relaxed/simple;
	bh=urB+uZmdlD4H4cQWwlKp3yaz4rDLCUcESltCMtcnl8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR1+aFfL9Lza51rdSACv6ojwqKH99QfiCADdGnh988h2i9f2Etnocf3bhxYMPNW44N93BvBfroIZSuLkN8nBEY6TPeykHsY7l2oM4KfIUOrXNzFHDId4S0wmqKJS1h1x/ydCFY8h6ohxLIOqgudgJJxL25HSVyEV6jgTZHPAjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBED1063;
	Wed, 10 Jul 2024 10:32:57 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2347B3F766;
	Wed, 10 Jul 2024 10:32:29 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 5/8] firmware: arm_scmi: Make SMC transport a standalone driver
Date: Wed, 10 Jul 2024 18:31:50 +0100
Message-ID: <20240710173153.4060457-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710173153.4060457-1-cristian.marussi@arm.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make SCMI SMC transport a standalone driver that can be optionally
loaded as a module.

CC: Peng Fan <peng.fan@nxp.com>
CC: Nikunj Kela <quic_nkela@quicinc.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- make scmi_smc_desc static
---
 drivers/firmware/arm_scmi/Kconfig             |  4 ++-
 drivers/firmware/arm_scmi/Makefile            |  2 +-
 drivers/firmware/arm_scmi/common.h            |  3 --
 drivers/firmware/arm_scmi/driver.c            |  5 ---
 .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 33 +++++++++++++++----
 5 files changed, 30 insertions(+), 17 deletions(-)
 rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (89%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 135e34aefd70..a4d44ef8bf45 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -102,7 +102,7 @@ config ARM_SCMI_TRANSPORT_OPTEE
 	  transport based on OP-TEE SCMI service, answer Y.
 
 config ARM_SCMI_TRANSPORT_SMC
-	bool "SCMI transport based on SMC"
+	tristate "SCMI transport based on SMC"
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	select ARM_SCMI_HAVE_TRANSPORT
 	select ARM_SCMI_HAVE_SHMEM
@@ -112,6 +112,8 @@ config ARM_SCMI_TRANSPORT_SMC
 
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on SMC, answer Y.
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_transport_smc.
 
 config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
 	bool "Enable atomic mode support for SCMI SMC transport"
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 121612d75f0b..6868a47fa4ab 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,7 +5,6 @@ scmi-core-objs := $(scmi-bus-y)
 scmi-driver-y = driver.o notify.o
 scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
-scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
@@ -13,6 +12,7 @@ scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o vol
 scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 0f2256a61622..edb786cde25c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
 int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 					    struct scmi_xfer *xfer,
 					    unsigned int timeout_ms);
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
-extern const struct scmi_desc scmi_smc_desc;
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 extern const struct scmi_desc scmi_virtio_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 96cf8ab4421e..b14c5326930a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3254,11 +3254,6 @@ static const struct of_device_id scmi_of_match[] = {
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
 	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
 #endif
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
-	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
-	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
-	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
 #endif
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
similarity index 89%
rename from drivers/firmware/arm_scmi/smc.c
rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
index 4cb86386c490..291e33207536 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
@@ -3,7 +3,7 @@
  * System Control and Management Interface (SCMI) Message SMC/HVC
  * Transport driver
  *
- * Copyright 2020 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #include <linux/arm-smccc.h>
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/limits.h>
+#include <linux/platform_device.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 
@@ -69,12 +70,14 @@ struct scmi_smc {
 	unsigned long cap_id;
 };
 
+static struct scmi_transport_core_operations *core;
+
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
 {
 	struct scmi_smc *scmi_info = data;
 
-	scmi_rx_callback(scmi_info->cinfo,
-			 scmi_shmem_ops.read_header(scmi_info->shmem), NULL);
+	core->rx_callback(scmi_info->cinfo,
+			  core->shmem->read_header(scmi_info->shmem), NULL);
 
 	return IRQ_HANDLED;
 }
@@ -141,7 +144,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!scmi_info)
 		return -ENOMEM;
 
-	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx, &res);
+	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
 	if (IS_ERR(scmi_info->shmem))
 		return PTR_ERR(scmi_info->shmem);
 
@@ -226,7 +229,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	 */
 	smc_channel_lock_acquire(scmi_info, xfer);
 
-	scmi_shmem_ops.tx_prepare(scmi_info->shmem, xfer, cinfo);
+	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
 
 	if (scmi_info->cap_id != ULONG_MAX)
 		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
@@ -250,7 +253,7 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	scmi_shmem_ops.fetch_response(scmi_info->shmem, xfer);
+	core->shmem->fetch_response(scmi_info->shmem, xfer);
 }
 
 static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
@@ -270,7 +273,7 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.fetch_response = smc_fetch_response,
 };
 
-const struct scmi_desc scmi_smc_desc = {
+static const struct scmi_desc scmi_smc_desc = {
 	.ops = &scmi_smc_ops,
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
@@ -286,3 +289,19 @@ const struct scmi_desc scmi_smc_desc = {
 	.sync_cmds_completed_on_ret = true,
 	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
 };
+
+static const struct of_device_id scmi_of_match[] = {
+	{ .compatible = "arm,scmi-smc" },
+	{ .compatible = "arm,scmi-smc-param" },
+	{ .compatible = "qcom,scmi-smc" },
+	{ /* Sentinel */ },
+};
+
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_of_match, &core);
+module_platform_driver(scmi_smc_driver);
+
+MODULE_ALIAS("scmi-transport-smc");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_AUTHOR("Nikunj Kela <quic_nkela@quicinc.com>");
+MODULE_DESCRIPTION("SCMI SMC Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


