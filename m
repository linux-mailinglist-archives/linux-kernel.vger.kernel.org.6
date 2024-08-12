Return-Path: <linux-kernel+bounces-283522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D094F5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC97B283A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02151898E3;
	Mon, 12 Aug 2024 17:34:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF554189530;
	Mon, 12 Aug 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484077; cv=none; b=XdHDv4MgpXqi/YcZhpW57Kk2eUmycappYNYax7rAY9hJnTxgpizKPH37DqLgDFjkOo3Cv8xddvhh2zR9t1LUsBb2YAnkXtdjQmOA0QHlC8mswGaK8XIHLuZ5dbGHZCdkSEyeX3w5IMJVaVf3vFnBm8XKWWzT70CiSTh1qiqons0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484077; c=relaxed/simple;
	bh=1s+3uBeaykMLzUQUbJ0e98eyEEAzvL6rq41OTgXKFBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meOUMwhvW6fxneQ+IVgVsOtgp+IGfS7Y17gRDs9PhWIhr2r1Sf1PfgUj65sV/+Dk4JyDwH3EM5dP9P1QSdYEkYnVJNHxQrQ5Z8Kx1Bhjjn8uq4JTkfFmML62zM7sk3Pv/7cjz9UySy3+enSRnw9WXa9YMHXH7/A/r4buMVc/Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB53FEC;
	Mon, 12 Aug 2024 10:35:01 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30CC03F40C;
	Mon, 12 Aug 2024 10:34:32 -0700 (PDT)
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
	"Michael S . Tsirkin" <mst@redhat.com>,
	Igor Skalkin <igor.skalkin@opensynergy.com>,
	Peter Hilber <peter.hilber@opensynergy.com>
Subject: [PATCH v4 8/9] firmware: arm_scmi: Make VirtIO transport a standalone driver
Date: Mon, 12 Aug 2024 18:33:39 +0100
Message-ID: <20240812173340.3912830-9-cristian.marussi@arm.com>
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

Make SCMI VirtIO transport a standalone driver that can be optionally
loaded as a module.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Igor Skalkin <igor.skalkin@opensynergy.com>
CC: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- dropped MODULE_ALIAS
- moved VIRTIO transport to its own subdir and submenu
v2 --> v3
- fixed spacing in Kconfig and Copyright
- use new params in DEFINE_SCMI_TRANSPORT_DRIVER
v1 --> v2
- handle platform_driver_register() failures
- make scmi_virtio_desc static
  | Reported-by: kernel test robot <lkp@intel.com>
  | Closes:
  https://lore.kernel.org/oe-kbuild-all/202407081344.9OceqFie-lkp@intel.com/
---
 drivers/firmware/arm_scmi/Kconfig             |  41 -------
 drivers/firmware/arm_scmi/Makefile            |   1 -
 drivers/firmware/arm_scmi/common.h            |   3 -
 drivers/firmware/arm_scmi/driver.c            |   3 -
 drivers/firmware/arm_scmi/transports/Kconfig  |  43 ++++++++
 drivers/firmware/arm_scmi/transports/Makefile |   2 +
 .../arm_scmi/{ => transports}/virtio.c        | 103 +++++++++---------
 7 files changed, 99 insertions(+), 97 deletions(-)
 rename drivers/firmware/arm_scmi/{ => transports}/virtio.c (94%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index b5e3634a8399..67053c1862d1 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -71,47 +71,6 @@ config ARM_SCMI_DEBUG_COUNTERS
 
 source "drivers/firmware/arm_scmi/transports/Kconfig"
 
-config ARM_SCMI_TRANSPORT_VIRTIO
-	bool "SCMI transport based on VirtIO"
-	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
-	select ARM_SCMI_HAVE_TRANSPORT
-	select ARM_SCMI_HAVE_MSG
-	help
-	  This enables the virtio based transport for SCMI.
-
-	  If you want the ARM SCMI PROTOCOL stack to include support for a
-	  transport based on VirtIO, answer Y.
-
-config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
-	bool "SCMI VirtIO transport Version 1 compliance"
-	depends on ARM_SCMI_TRANSPORT_VIRTIO
-	default y
-	help
-	  This enforces strict compliance with VirtIO Version 1 specification.
-
-	  If you want the ARM SCMI VirtIO transport layer to refuse to work
-	  with Legacy VirtIO backends and instead support only VirtIO Version 1
-	  devices (or above), answer Y.
-
-	  If you want instead to support also old Legacy VirtIO backends (like
-	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
-	  take care of the needed conversions, say N.
-
-config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
-	bool "Enable atomic mode for SCMI VirtIO transport"
-	depends on ARM_SCMI_TRANSPORT_VIRTIO
-	help
-	  Enable support of atomic operation for SCMI VirtIO based transport.
-
-	  If you want the SCMI VirtIO based transport to operate in atomic
-	  mode, avoiding any kind of sleeping behaviour for selected
-	  transactions on the TX path, answer Y.
-
-	  Enabling atomic mode operations allows any SCMI driver using this
-	  transport to optionally ask for atomic SCMI transactions and operate
-	  in atomic context too, at the price of using a number of busy-waiting
-	  primitives all over instead. If unsure say N.
-
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_CONTROL
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b80b302186da..dc786f8215b6 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -6,7 +6,6 @@ scmi-driver-y = driver.o notify.o
 scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
-scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 18026d446b59..7a53412fc41c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
 int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 					    struct scmi_xfer *xfer,
 					    unsigned int timeout_ms);
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
-extern const struct scmi_desc scmi_virtio_desc;
-#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 084936e9575d..12643b4c0db3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3318,9 +3318,6 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
-	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
-#endif
 	{ /* Sentinel */ },
 };
 
diff --git a/drivers/firmware/arm_scmi/transports/Kconfig b/drivers/firmware/arm_scmi/transports/Kconfig
index 7d478a4f69df..57eccf316e26 100644
--- a/drivers/firmware/arm_scmi/transports/Kconfig
+++ b/drivers/firmware/arm_scmi/transports/Kconfig
@@ -77,4 +77,47 @@ config ARM_SCMI_TRANSPORT_OPTEE
 	  This driver can also be built as a module. If so, the module
 	  will be called scmi_transport_optee.
 
+config ARM_SCMI_TRANSPORT_VIRTIO
+	tristate "SCMI transport based on VirtIO"
+	depends on VIRTIO
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_MSG
+	help
+	  This enables the virtio based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on VirtIO, answer Y.
+	  This driver can also be built as a module. If so, the module
+	  will be called scmi_transport_virtio.
+
+config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
+	bool "SCMI VirtIO transport Version 1 compliance"
+	depends on ARM_SCMI_TRANSPORT_VIRTIO
+	default y
+	help
+	  This enforces strict compliance with VirtIO Version 1 specification.
+
+	  If you want the ARM SCMI VirtIO transport layer to refuse to work
+	  with Legacy VirtIO backends and instead support only VirtIO Version 1
+	  devices (or above), answer Y.
+
+	  If you want instead to support also old Legacy VirtIO backends (like
+	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
+	  take care of the needed conversions, say N.
+
+config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
+	bool "Enable atomic mode for SCMI VirtIO transport"
+	depends on ARM_SCMI_TRANSPORT_VIRTIO
+	help
+	  Enable support of atomic operation for SCMI VirtIO based transport.
+
+	  If you want the SCMI VirtIO based transport to operate in atomic
+	  mode, avoiding any kind of sleeping behaviour for selected
+	  transactions on the TX path, answer Y.
+
+	  Enabling atomic mode operations allows any SCMI driver using this
+	  transport to optionally ask for atomic SCMI transactions and operate
+	  in atomic context too, at the price of using a number of busy-waiting
+	  primitives all over instead. If unsure say N.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/transports/Makefile b/drivers/firmware/arm_scmi/transports/Makefile
index 7c06d36a38fb..b08686571712 100644
--- a/drivers/firmware/arm_scmi/transports/Makefile
+++ b/drivers/firmware/arm_scmi/transports/Makefile
@@ -5,3 +5,5 @@ scmi_transport_smc-objs := smc.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
 scmi_transport_optee-objs := optee.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += scmi_transport_optee.o
+scmi_transport_virtio-objs := virtio.o
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += scmi_transport_virtio.o
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
similarity index 94%
rename from drivers/firmware/arm_scmi/virtio.c
rename to drivers/firmware/arm_scmi/transports/virtio.c
index e8d38e822c7e..c107579e7fe7 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -4,7 +4,7 @@
  * (SCMI).
  *
  * Copyright (C) 2020-2022 OpenSynergy.
- * Copyright (C) 2021-2022 ARM Ltd.
+ * Copyright (C) 2021-2024 ARM Ltd.
  */
 
 /**
@@ -19,6 +19,7 @@
 
 #include <linux/completion.h>
 #include <linux/errno.h>
+#include <linux/platform_device.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/virtio.h>
@@ -27,7 +28,7 @@
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_scmi.h>
 
-#include "common.h"
+#include "../common.h"
 
 #define VIRTIO_MAX_RX_TIMEOUT_MS	60000
 #define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
@@ -108,6 +109,8 @@ struct scmi_vio_msg {
 	refcount_t users;
 };
 
+static struct scmi_transport_core_operations *core;
+
 /* Only one SCMI VirtIO device can possibly exist */
 static struct virtio_device *scmi_vdev;
 
@@ -294,8 +297,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 
 		if (msg) {
 			msg->rx_len = length;
-			scmi_rx_callback(vioch->cinfo,
-					 scmi_msg_ops.read_header(msg->input), msg);
+			core->rx_callback(vioch->cinfo,
+					  core->msg->read_header(msg->input),
+					  msg);
 
 			scmi_finalize_message(vioch, msg);
 		}
@@ -339,8 +343,9 @@ static void scmi_vio_deferred_tx_worker(struct work_struct *work)
 		 * is no more processed elsewhere so no poll_lock needed.
 		 */
 		if (msg->poll_status == VIO_MSG_NOT_POLLED)
-			scmi_rx_callback(vioch->cinfo,
-					 scmi_msg_ops.read_header(msg->input), msg);
+			core->rx_callback(vioch->cinfo,
+					  core->msg->read_header(msg->input),
+					  msg);
 
 		/* Free the processed message once done */
 		scmi_vio_msg_release(vioch, msg);
@@ -366,23 +371,6 @@ static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
 	return vioch->max_msg;
 }
 
-static int virtio_link_supplier(struct device *dev)
-{
-	if (!scmi_vdev) {
-		dev_notice(dev,
-			   "Deferring probe after not finding a bound scmi-virtio device\n");
-		return -EPROBE_DEFER;
-	}
-
-	if (!device_link_add(dev, &scmi_vdev->dev,
-			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
-		dev_err(dev, "Adding link to supplier virtio device failed\n");
-		return -ECANCELED;
-	}
-
-	return 0;
-}
-
 static bool virtio_chan_available(struct device_node *of_node, int idx)
 {
 	struct scmi_vio_channel *channels, *vioch = NULL;
@@ -510,10 +498,10 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 		return -EBUSY;
 	}
 
-	scmi_msg_ops.tx_prepare(msg->request, xfer);
+	core->msg->tx_prepare(msg->request, xfer);
 
-	sg_init_one(&sg_out, msg->request, scmi_msg_ops.command_size(xfer));
-	sg_init_one(&sg_in, msg->input, scmi_msg_ops.response_size(xfer));
+	sg_init_one(&sg_out, msg->request, core->msg->command_size(xfer));
+	sg_init_one(&sg_in, msg->input, core->msg->response_size(xfer));
 
 	spin_lock_irqsave(&vioch->lock, flags);
 
@@ -560,7 +548,7 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
 	struct scmi_vio_msg *msg = xfer->priv;
 
 	if (msg)
-		scmi_msg_ops.fetch_response(msg->input, msg->rx_len, xfer);
+		core->msg->fetch_response(msg->input, msg->rx_len, xfer);
 }
 
 static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
@@ -569,7 +557,8 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
 	struct scmi_vio_msg *msg = xfer->priv;
 
 	if (msg)
-		scmi_msg_ops.fetch_notification(msg->input, msg->rx_len, max_len, xfer);
+		core->msg->fetch_notification(msg->input, msg->rx_len,
+					      max_len, xfer);
 }
 
 /**
@@ -669,7 +658,7 @@ static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
  * the message we are polling for could be alternatively delivered via usual
  * IRQs callbacks on another core which happened to have IRQs enabled while we
  * are actively polling for it here: in such a case it will be handled as such
- * by scmi_rx_callback() and the polling loop in the SCMI Core TX path will be
+ * by rx_callback() and the polling loop in the SCMI Core TX path will be
  * transparently terminated anyway.
  *
  * Return: True once polling has successfully completed.
@@ -790,7 +779,6 @@ static bool virtio_poll_done(struct scmi_chan_info *cinfo,
 }
 
 static const struct scmi_transport_ops scmi_virtio_ops = {
-	.link_supplier = virtio_link_supplier,
 	.chan_available = virtio_chan_available,
 	.chan_setup = virtio_chan_setup,
 	.chan_free = virtio_chan_free,
@@ -802,6 +790,23 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.poll_done = virtio_poll_done,
 };
 
+static const struct scmi_desc scmi_virtio_desc = {
+	.ops = &scmi_virtio_ops,
+	/* for non-realtime virtio devices */
+	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
+	.max_msg = 0, /* overridden by virtio_get_max_msg() */
+	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
+};
+
+static const struct of_device_id scmi_of_match[] = {
+	{ .compatible = "arm,scmi-virtio" },
+	{ /* Sentinel */ },
+};
+
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_virtio, scmi_virtio_driver, scmi_virtio_desc,
+			     scmi_of_match, core);
+
 static int scmi_vio_probe(struct virtio_device *vdev)
 {
 	struct device *dev = &vdev->dev;
@@ -861,14 +866,27 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	}
 
 	vdev->priv = channels;
+
 	/* Ensure initialized scmi_vdev is visible */
 	smp_store_mb(scmi_vdev, vdev);
 
+	ret = platform_driver_register(&scmi_virtio_driver);
+	if (ret) {
+		vdev->priv = NULL;
+		vdev->config->del_vqs(vdev);
+		/* Ensure NULLified scmi_vdev is visible */
+		smp_store_mb(scmi_vdev, NULL);
+
+		return ret;
+	}
+
 	return 0;
 }
 
 static void scmi_vio_remove(struct virtio_device *vdev)
 {
+	platform_driver_unregister(&scmi_virtio_driver);
+
 	/*
 	 * Once we get here, virtio_chan_free() will have already been called by
 	 * the SCMI core for any existing channel and, as a consequence, all the
@@ -913,23 +931,10 @@ static struct virtio_driver virtio_scmi_driver = {
 	.validate = scmi_vio_validate,
 };
 
-static int __init virtio_scmi_init(void)
-{
-	return register_virtio_driver(&virtio_scmi_driver);
-}
-
-static void virtio_scmi_exit(void)
-{
-	unregister_virtio_driver(&virtio_scmi_driver);
-}
+module_virtio_driver(virtio_scmi_driver);
 
-const struct scmi_desc scmi_virtio_desc = {
-	.transport_init = virtio_scmi_init,
-	.transport_exit = virtio_scmi_exit,
-	.ops = &scmi_virtio_ops,
-	/* for non-realtime virtio devices */
-	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
-	.max_msg = 0, /* overridden by virtio_get_max_msg() */
-	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
-	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
-};
+MODULE_AUTHOR("Igor Skalkin <igor.skalkin@opensynergy.com>");
+MODULE_AUTHOR("Peter Hilber <peter.hilber@opensynergy.com>");
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("SCMI VirtIO Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


