Return-Path: <linux-kernel+bounces-283520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACED94F5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433B4B211DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0518CBE1;
	Mon, 12 Aug 2024 17:34:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48918B49C;
	Mon, 12 Aug 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484071; cv=none; b=MYB+tOqMX4LShY7OwW+pN2/bV281KqEnay9PXzZTIa+UyotR4jIGps9FDT2vh9TyBU9ejQnpCL6P8JKkV1ufIjIVVaxPWXbzWg1SswdZkVooC0NF5d+7VyD/K8hySV8z7HLcvepTNd3rqzqInmjcLdfLo/N0lxrREPt0f5PsgIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484071; c=relaxed/simple;
	bh=s8ImnWem46ydnlQaG1dewzNpXEq5PxoyeeZrionbd+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8TRYDVT2TkrfuodQEUfSCuh9on0si0rVvuISfhW742z3iGZHnJqimkq/SN5w70afMOjO2TBAQfoeKaDGlzRaCxFMWDYQ3pPHBjjxk0hvh/iKnEEo1IMmPa4Nck//YIOYElqhaQli9xAeOp4CJ4y4R6Y4bFVVSfAnV8VzM2EDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9A05FEC;
	Mon, 12 Aug 2024 10:34:54 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D8BE3F40C;
	Mon, 12 Aug 2024 10:34:25 -0700 (PDT)
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
Subject: [PATCH v4 6/9] firmware: arm_scmi: Make SMC transport a standalone driver
Date: Mon, 12 Aug 2024 18:33:37 +0100
Message-ID: <20240812173340.3912830-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812173340.3912830-1-cristian.marussi@arm.com>
References: <20240812173340.3912830-1-cristian.marussi@arm.com>
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
v3 --> v4
- dropped MODULE_ALIAS
- moved SMC transport driver into new transports subdir and Kconfig submenu
v2 --> v3
- fixed spacing in Kconfig and Copyright
- use new params in DEFINE_SCMI_TRANSPORT_DRIVER
v1 --> v2
- make scmi_smc_desc static
---
 drivers/firmware/arm_scmi/Kconfig             | 26 ---------------
 drivers/firmware/arm_scmi/Makefile            |  1 -
 drivers/firmware/arm_scmi/common.h            |  3 --
 drivers/firmware/arm_scmi/driver.c            |  5 ---
 drivers/firmware/arm_scmi/transports/Kconfig  | 28 ++++++++++++++++
 drivers/firmware/arm_scmi/transports/Makefile |  2 ++
 .../firmware/arm_scmi/{ => transports}/smc.c  | 33 +++++++++++++++----
 7 files changed, 56 insertions(+), 42 deletions(-)
 rename drivers/firmware/arm_scmi/{ => transports}/smc.c (89%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index e9a7c9aaa956..27de15ad6444 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -84,32 +84,6 @@ config ARM_SCMI_TRANSPORT_OPTEE
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on OP-TEE SCMI service, answer Y.
 
-config ARM_SCMI_TRANSPORT_SMC
-	bool "SCMI transport based on SMC"
-	depends on HAVE_ARM_SMCCC_DISCOVERY
-	select ARM_SCMI_HAVE_TRANSPORT
-	select ARM_SCMI_HAVE_SHMEM
-	default y
-	help
-	  Enable SMC based transport for SCMI.
-
-	  If you want the ARM SCMI PROTOCOL stack to include support for a
-	  transport based on SMC, answer Y.
-
-config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
-	bool "Enable atomic mode support for SCMI SMC transport"
-	depends on ARM_SCMI_TRANSPORT_SMC
-	help
-	  Enable support of atomic operation for SCMI SMC based transport.
-
-	  If you want the SCMI SMC based transport to operate in atomic
-	  mode, avoiding any kind of sleeping behaviour for selected
-	  transactions on the TX path, answer Y.
-	  Enabling atomic mode operations allows any SCMI driver using this
-	  transport to optionally ask for atomic SCMI transactions and operate
-	  in atomic context too, at the price of using a number of busy-waiting
-	  primitives all over instead. If unsure say N.
-
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
 	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index beaa55c146b8..524a8ff381db 100644
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
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 2bca62a8ecde..231b061dadb9 100644
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
index c13bef8a1796..bdb952c385d2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3321,11 +3321,6 @@ static const struct of_device_id scmi_of_match[] = {
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
diff --git a/drivers/firmware/arm_scmi/transports/Kconfig b/drivers/firmware/arm_scmi/transports/Kconfig
index 96c0d76b3042..85d693811a1c 100644
--- a/drivers/firmware/arm_scmi/transports/Kconfig
+++ b/drivers/firmware/arm_scmi/transports/Kconfig
@@ -34,4 +34,32 @@ config ARM_SCMI_TRANSPORT_MAILBOX
 	  This driver can also be built as a module. If so, the module
 	  will be called scmi_transport_mailbox.
 
+config ARM_SCMI_TRANSPORT_SMC
+	tristate "SCMI transport based on SMC"
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
+	default y
+	help
+	  Enable SMC based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on SMC, answer Y.
+	  This driver can also be built as a module. If so, the module
+	  will be called scmi_transport_smc.
+
+config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	bool "Enable atomic mode support for SCMI SMC transport"
+	depends on ARM_SCMI_TRANSPORT_SMC
+	help
+	  Enable support of atomic operation for SCMI SMC based transport.
+
+	  If you want the SCMI SMC based transport to operate in atomic
+	  mode, avoiding any kind of sleeping behaviour for selected
+	  transactions on the TX path, answer Y.
+	  Enabling atomic mode operations allows any SCMI driver using this
+	  transport to optionally ask for atomic SCMI transactions and operate
+	  in atomic context too, at the price of using a number of busy-waiting
+	  primitives all over instead. If unsure say N.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/transports/Makefile b/drivers/firmware/arm_scmi/transports/Makefile
index cb40be8955be..2c8b38a2d598 100644
--- a/drivers/firmware/arm_scmi/transports/Makefile
+++ b/drivers/firmware/arm_scmi/transports/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi_transport_mailbox-objs := mailbox.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
+scmi_transport_smc-objs := smc.o
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
 
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/transports/smc.c
similarity index 89%
rename from drivers/firmware/arm_scmi/smc.c
rename to drivers/firmware/arm_scmi/transports/smc.c
index 4cb86386c490..6fc3e1973c58 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/transports/smc.c
@@ -16,10 +16,11 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/limits.h>
+#include <linux/platform_device.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 
-#include "common.h"
+#include "../common.h"
 
 /*
  * The shmem address is split into 4K page and offset.
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
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_smc_driver, scmi_smc_desc,
+			     scmi_of_match, core);
+module_platform_driver(scmi_smc_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_AUTHOR("Nikunj Kela <quic_nkela@quicinc.com>");
+MODULE_DESCRIPTION("SCMI SMC Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


