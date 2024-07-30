Return-Path: <linux-kernel+bounces-267600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A5941337
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BE1C2353B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981201A071F;
	Tue, 30 Jul 2024 13:34:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A41A08B5;
	Tue, 30 Jul 2024 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346442; cv=none; b=eoZANFmdfz2yxDquN1NTy4thL3b0Ee5pVYp1bZgTStBYt0DG9aQ+2vZcKTeU8hU4iYe4XkMUWWtP5RExTr1RA8RKbWl21gLDYt3AiFxE76evNv/PQ9PfaTgqvjp9kVRg4YS8v6VszA/3PjeJUvPz/wFVAl0j/ZsekrXj6Hb35Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346442; c=relaxed/simple;
	bh=5FIksF/KU0+nb4wa9QbNrPkjt6vdx2/HTR2ofeKeyzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEM7Ev/W82/fcQX9mpuNgPw0LiA5K3CELUjhwW6pxVmeyWk6S9IQSsU6IvjxT1gLMsXeN2moJjTAJJ64xpz7MhTNcpDL9BA0WfuVPeB2PqHm75zEt8n71DdL4a+z42AlvdEFFH1aEial6iI6AWXZTW7N+zIUWM8m0HKOdBEX2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 524C61007;
	Tue, 30 Jul 2024 06:34:25 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD123F5A1;
	Tue, 30 Jul 2024 06:33:56 -0700 (PDT)
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
Subject: [PATCH v3 6/9] firmware: arm_scmi: Make SMC transport a standalone driver
Date: Tue, 30 Jul 2024 14:33:15 +0100
Message-ID: <20240730133318.1573765-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730133318.1573765-1-cristian.marussi@arm.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
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
v2 --> v3
- fixed spacing in Kconfig and Copyright
- use new params in DEFINE_SCMI_TRANSPORT_DRIVER
v1 --> v2
- make scmi_smc_desc static
---
 drivers/firmware/arm_scmi/Kconfig             |  4 ++-
 drivers/firmware/arm_scmi/Makefile            |  2 +-
 drivers/firmware/arm_scmi/common.h            |  3 --
 drivers/firmware/arm_scmi/driver.c            |  5 ---
 .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 32 +++++++++++++++----
 5 files changed, 30 insertions(+), 16 deletions(-)
 rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (88%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index f03875169215..f634c5af1912 100644
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
+	  This driver can also be built as a module. If so, the module
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
index abaf7ce6fbab..f44763bfec16 100644
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
index 9d869ab2d003..c4d0195f0fdb 100644
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
similarity index 88%
rename from drivers/firmware/arm_scmi/smc.c
rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
index 4cb86386c490..1c203a68acd4 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
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
@@ -286,3 +289,20 @@ const struct scmi_desc scmi_smc_desc = {
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
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_smc_driver, scmi_smc_desc,
+			     scmi_of_match, core);
+module_platform_driver(scmi_smc_driver);
+
+MODULE_ALIAS("scmi-transport-smc");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_AUTHOR("Nikunj Kela <quic_nkela@quicinc.com>");
+MODULE_DESCRIPTION("SCMI SMC Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


