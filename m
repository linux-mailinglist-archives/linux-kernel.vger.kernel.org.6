Return-Path: <linux-kernel+bounces-339411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8E9864C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D770D1F2579D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF113D89D;
	Wed, 25 Sep 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRQ9sOzM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8A12CDBF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281523; cv=none; b=TPgeDIgUuL4bSBgyLdFOwGGLhDniwdt8zzWJy+brpnoH8x9nnLhqjMFU1+dBTFXNjAyIwQfYDjK2IL9V2GRZreshtWNeLniUIQOO9WMRCm6szCvxDvZcNXZWsSzwPVx+iFhQq5hftc8wJkjtVSkBTpbQVTP6Gxi8o3jsqw1DqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281523; c=relaxed/simple;
	bh=bkyZ9ZDSwtJW3YVcxQDnmy3QDNnpmwj3JZoEu7Pj5cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw4Lx3/gBmj6lwBG4ao3enQeVA01CeYG9RiFBkQnkNnyuYLO/vQ+UzLV/GaQY2FfkZo3CZLCbR1AKCIo1OjGXyHcpC69oaSpw+JeBOOdBQ4GRxlqLaUc8esmrOBGJGyPA0pfMkB4wMj21/NyfPBD5hjpVnSU2Fhq+bYZe5duJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RRQ9sOzM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71798661a52so97637b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281521; x=1727886321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7njd5uGAB08nW3CyyAe8XQE/+AB60p3g0lfb6j9aI4=;
        b=RRQ9sOzMRePpavKs96W5FQjxftmfOR0lOxxFJQ6lVbKaw5PTuUvE3OF6u7FhxmVEuS
         82wZVROXJRbdP4HVnrt8MCrXYEQcJSLeAb3mXOM6CAbXETzqqo3czy//qPu2jOBg5BzK
         Gqn81CmJDoqg0HuwPvtrSD/yiI0RwIOsL6CrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281521; x=1727886321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7njd5uGAB08nW3CyyAe8XQE/+AB60p3g0lfb6j9aI4=;
        b=pnFSHFRGJS05AtHn/+cBxNhpNhTmpTfgJ0VMpcShNJ/vjb+jslg6njfvbrqWeZSkiJ
         B6+kYQVRfdhi2DZ9Ct7R/3k0abEffxWMmobTSVxv+K0q9gvW7jv9Er900f8MWVUARSjn
         wrmFOODCLhq5rMssjTMYswM8L6nHOf7mhCxh4FptMDhzcHnFcCWR37BxgEE0Yd2osCdQ
         SM743hJOVo9zJHPl2skiWGfhD39m450+lndGzKedj18X4mPuip/tI0Mmuxj9Bo8GDJTc
         2l0++FsrKgk1mtJVFj0ipCQEvKjYbu8CKggKL4RSm5obZdk4Sbn6oV/D3ACiGh7bLrp/
         xLRw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zQJTy7ktdJP37QPxEYljxjcfDapPJNZeM+fvLj7C7cfA6mSL6cbLotwQFtTmo2OuVnenWRphbmTUMw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4jpgkkxE1qONoIa40PqLBMdtSDPKL468a/J3cAynxpdlm78f
	kE1l+TT2sp9sjP/ToMCtKDhGeTeOOLcU2RewMWyMxNHuiIfVnoOskoFQ6TdSnw==
X-Google-Smtp-Source: AGHT+IEaVeEK6z0ZYLb5SCEy1Mb0P3dcErpBaGT2V8h4jllv9PEeYo8ay6xtZlOSUTmdt0lIwAG7HA==
X-Received: by 2002:a05:6a00:10d0:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-71b1931af7dmr302805b3a.7.1727281521035;
        Wed, 25 Sep 2024 09:25:21 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71afc834196sm3045610b3a.13.2024.09.25.09.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:20 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] platform/chrome: cros_ec_typec: Displayport support
Date: Wed, 25 Sep 2024 09:25:07 -0700
Message-ID: <20240925092505.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for entering and exiting displayport alt-mode on systems
using AP driven alt-mode.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 MAINTAINERS                                   |   5 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec_typec.c       |  13 +-
 drivers/platform/chrome/cros_ec_typec.h       |   1 +
 drivers/platform/chrome/cros_typec_altmode.h  |  34 +++
 .../platform/chrome/cros_typec_displayport.c  | 247 ++++++++++++++++++
 6 files changed, 299 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
 create mode 100644 drivers/platform/chrome/cros_typec_displayport.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10430778c998..d8baf38cacc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5282,11 +5282,12 @@ F:	include/linux/platform_data/cros_usbpd_notify.h
 
 CHROMEOS EC USB TYPE-C DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
+M:	Benson Leung <bleung@chromium.org>
+M:	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.*
-F:	drivers/platform/chrome/cros_typec_switch.c
-F:	drivers/platform/chrome/cros_typec_vdm.*
+F:	drivers/platform/chrome/cros_typec_*
 
 CHROMEOS HPS DRIVER
 M:	Dan Callaghan <dcallagh@chromium.org>
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..fe6c5234ac27 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -18,7 +18,9 @@ obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
+cros-ec-typec-$(CONFIG_TYPEC_DP_ALTMODE) += cros_typec_displayport.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
+
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 6c0228981627..f9221d0d95f5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -18,6 +18,7 @@
 
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
+#include "cros_typec_altmode.h"
 
 #define DRV_NAME "cros-ec-typec"
 
@@ -293,12 +294,16 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	desc.svid = USB_TYPEC_DP_SID;
 	desc.mode = USB_TYPEC_DP_MODE;
 	desc.vdo = DP_PORT_VDO;
-	amode = typec_port_register_altmode(port->port, &desc);
+	amode = cros_typec_register_displayport(port, &desc,
+						typec->ap_driven_altmode);
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
+
+#if !IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
 	typec_altmode_set_drvdata(amode, port);
 	amode->ops = &port_amode_ops;
+#endif
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
@@ -575,6 +580,10 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
 
+	if (!ret)
+		cros_typec_displayport_status_update(port->state.alt,
+						     port->state.data);
+
 	return ret;
 }
 
@@ -1254,6 +1263,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	typec->ap_driven_altmode = cros_ec_check_features(
+		ec_dev, EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY);
 
 	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 			  &resp, sizeof(resp));
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
index deda180a646f..9fd5342bb0ad 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -39,6 +39,7 @@ struct cros_typec_data {
 	struct work_struct port_work;
 	bool typec_cmd_supported;
 	bool needs_mux_ack;
+	bool ap_driven_altmode;
 };
 
 /* Per port data. */
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
new file mode 100644
index 000000000000..a8b37a18c83a
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __CROS_TYPEC_ALTMODE_H__
+#define __CROS_TYPEC_ALTMODE_H__
+
+struct cros_typec_port;
+struct typec_altmode;
+struct typec_altmode_desc;
+struct typec_displayport_data;
+
+#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
+struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry);
+
+int cros_typec_displayport_status_update(struct typec_altmode *altmode,
+					 struct typec_displayport_data *data);
+#else
+struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry)
+{
+	return typec_port_register_altmode(port->port, desc);
+}
+
+int cros_typec_displayport_status_update(struct typec_altmode *altmode,
+					 struct typec_displayport_data *data)
+{
+	return 0;
+}
+#endif
+#endif /* __CROS_TYPEC_ALTMODE_H__ */
diff --git a/drivers/platform/chrome/cros_typec_displayport.c b/drivers/platform/chrome/cros_typec_displayport.c
new file mode 100644
index 000000000000..bccd57290601
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_displayport.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Alt-mode implementation for Displayport on ChromeOS EC.
+ *
+ * Copyright 2024 Google LLC
+ * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
+ */
+#include "cros_ec_typec.h"
+
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/pd_vdo.h>
+
+#include "cros_typec_altmode.h"
+
+struct typec_dp_data {
+	struct typec_displayport_data data;
+	struct work_struct work;
+
+	struct cros_typec_port *port;
+	struct typec_altmode *alt;
+	bool ap_mode_entry;
+	bool configured;
+	bool pending_status_update;
+
+	u32 header;
+	u32 *vdo_data;
+	u8 vdo_size;
+};
+
+static void cros_typec_displayport_work(struct work_struct *work)
+{
+	struct typec_dp_data *data =
+		container_of(work, struct typec_dp_data, work);
+
+	if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
+			      data->vdo_size))
+		dev_err(&data->alt->dev, "VDM 0x%x failed", data->header);
+
+	data->header = 0;
+	data->vdo_data = NULL;
+	data->vdo_size = 0;
+}
+
+static int cros_typec_displayport_enter(struct typec_altmode *alt, u32 *vdo)
+{
+	struct typec_dp_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
+		.mode_to_enter = CROS_EC_ALTMODE_DP,
+	};
+	int svdm_version;
+	int ret;
+
+	if (!data->ap_mode_entry) {
+		const struct typec_altmode *partner =
+			typec_altmode_get_partner(alt);
+		dev_warn(&partner->dev,
+			 "EC does not support ap driven mode entry\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
+			  &req, sizeof(req), NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	data->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, CMD_ENTER_MODE);
+	data->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
+	data->header |= VDO_CMDT(CMDT_RSP_ACK);
+
+	data->vdo_data = NULL;
+	data->vdo_size = 1;
+
+	schedule_work(&data->work);
+
+	return ret;
+}
+
+static int cros_typec_displayport_exit(struct typec_altmode *alt)
+{
+	struct typec_dp_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_EXIT_MODES,
+	};
+	int svdm_version;
+	int ret;
+
+	if (!data->ap_mode_entry) {
+		const struct typec_altmode *partner =
+			typec_altmode_get_partner(alt);
+		dev_warn(&partner->dev,
+			 "EC does not support ap driven mode entry\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = cros_ec_cmd(data->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
+			  &req, sizeof(req), NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	data->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, CMD_EXIT_MODE);
+	data->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
+	data->header |= VDO_CMDT(CMDT_RSP_ACK);
+
+	data->vdo_data = NULL;
+	data->vdo_size = 1;
+
+	schedule_work(&data->work);
+
+	return ret;
+}
+
+int cros_typec_displayport_status_update(struct typec_altmode *altmode,
+					 struct typec_displayport_data *data)
+{
+	struct typec_dp_data *dp_data = typec_altmode_get_drvdata(altmode);
+
+	if (!dp_data->pending_status_update) {
+		dev_dbg(&altmode->dev,
+			"Got DPStatus without a pending request");
+		return 0;
+	}
+
+	if (dp_data->configured && dp_data->data.conf != data->conf)
+		dev_dbg(&altmode->dev,
+			"DP Conf doesn't match. Requested 0x%04x, Actual 0x%04x",
+			dp_data->data.conf, data->conf);
+
+	dp_data->header |= VDO_CMDT(CMDT_RSP_ACK);
+	dp_data->data = *data;
+	dp_data->vdo_data = &dp_data->data.status;
+	dp_data->vdo_size = 2;
+	dp_data->pending_status_update = false;
+
+	schedule_work(&dp_data->work);
+	return 0;
+}
+
+static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct typec_dp_data *dp_data = typec_altmode_get_drvdata(alt);
+
+	int cmd_type = PD_VDO_CMDT(header);
+	int cmd = PD_VDO_CMD(header);
+	int svdm_version;
+
+	if (!dp_data->ap_mode_entry) {
+		const struct typec_altmode *partner =
+			typec_altmode_get_partner(alt);
+		dev_warn(&partner->dev,
+			 "EC does not support ap driven mode entry\n");
+		return -EOPNOTSUPP;
+	}
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	switch (cmd_type) {
+	case CMDT_INIT:
+		if (PD_VDO_SVDM_VER(header) < svdm_version) {
+			typec_partner_set_svdm_version(dp_data->port->partner,
+						       PD_VDO_SVDM_VER(header));
+			svdm_version = PD_VDO_SVDM_VER(header);
+		}
+
+		dp_data->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, cmd);
+		dp_data->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
+
+		/*
+		 * DP_CMD_CONFIGURE: We can't actually do anything with the
+		 * provided VDO yet so just send back an ACK.
+		 *
+		 * DP_CMD_STATUS_UPDATE: We wait for Mux changes to send
+		 * DPStatus Acks.
+		 */
+		switch (cmd) {
+		case DP_CMD_CONFIGURE:
+			dp_data->data.conf = *data;
+			dp_data->header |= VDO_CMDT(CMDT_RSP_ACK);
+			dp_data->configured = true;
+			schedule_work(&dp_data->work);
+			break;
+		case DP_CMD_STATUS_UPDATE:
+			dp_data->pending_status_update = true;
+			break;
+		default:
+			dp_data->header |= VDO_CMDT(CMDT_RSP_ACK);
+			schedule_work(&dp_data->work);
+			break;
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct typec_altmode_ops cros_typec_displayport_ops = {
+	.enter = cros_typec_displayport_enter,
+	.exit = cros_typec_displayport_exit,
+	.vdm = cros_typec_displayport_vdm,
+};
+
+struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry)
+{
+	struct typec_altmode *alt;
+	struct typec_dp_data *data;
+
+	alt = typec_port_register_altmode(port->port, desc);
+	if (IS_ERR(alt))
+		return alt;
+
+	data = devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		typec_unregister_altmode(alt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_WORK(&data->work, cros_typec_displayport_work);
+	data->alt = alt;
+	data->port = port;
+	data->ap_mode_entry = ap_mode_entry;
+	data->configured = false;
+
+	typec_altmode_set_ops(alt, &cros_typec_displayport_ops);
+	typec_altmode_set_drvdata(alt, data);
+
+	return alt;
+}
-- 
2.46.0.792.g87dc391469-goog


