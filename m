Return-Path: <linux-kernel+bounces-389600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4816E9B6ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070F7280E39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDE218D75;
	Wed, 30 Oct 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oHK1j9A4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE521765A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323756; cv=none; b=h2ZL4qdDI/oo6TiGKgeaCvh8Twbm5yekLZaeBu0WIBM6fl6MDPqCTQgtTm0qUhk9zJ51Se83lDrV9vqp877sT8oRVvkt/QcsnTfP5uCiwNXwMuhE7q3kEvHGPD3al8tvv026OgmEUkUWiNB3z4d1uX3+W9LrJ2nlKMq+uhbVJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323756; c=relaxed/simple;
	bh=uMeysR189IthOyETjVc8vjImbzvEmWjmALZpdXtfhNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8S9cfMpH1DmLquKzYG/WLGxEdqkTg1b7efKEWG6D5OielMMLqi5JoR4X5+1GQZSDzESHdKBus/5xg+/2+djOvDHjbiKk995koU5hnCrAHKTneP0urIl555vEUkN7WbUQzFgGMRetuhevQoZHF6W5YcBk6lfzDt31aOWz3IiID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oHK1j9A4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so212620b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323753; x=1730928553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5F33qV6ofAibcr8moJJ8wWx5Tp3luAqpEsJU6dkvkI=;
        b=oHK1j9A4dF0/7/GdsnB9Oxk2PLibwVtBJRlD46y/jLsSW2h/6vyQpt8GCQP5yFdrJY
         IJQfeYgB94cLCtVA60nwpJtphM3P3Oim+P6Pzgy8zaF/5FdQ9FWSDc1908YmJG+ZHoof
         OQLi2c39iBI7aMM4AwV1RePsi4Qu4H/qvzMtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323753; x=1730928553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5F33qV6ofAibcr8moJJ8wWx5Tp3luAqpEsJU6dkvkI=;
        b=ucIgTnqklh3F+japAgCC0RwHThYMkOl+RZFtv/dh2Jx7gfSbCCkpyEUiCJxenscSiW
         7qkLvBW8tUaVFHa1j368u4A9+HE7HaVoxuvpFU6tQckqU2Q/MkaxMStrpGlxaEQxomdE
         lFLwphX4PwxwdGo4+q6ufae2MFMo41zJ8MvkM2MJ80veutZotZrDa0nYMd6GJKFXwm0Z
         KqZ+klOxd+R/dRBEg6Pp5pc5wyUy0z4jB1d8UymoQIbOydjL+UEgGy9FA/r3+iht5nnI
         PPDCrtpx1ca+2vSv9KnQXcSoTZUe7KS40NtTWqTi7lSPeEtcbfuGrGhSsWZRaz6HmnEm
         T1CA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8Z4OvarL+5IswR1PG4VXLjxHU8XZdTnHPzAAoMEGwgcwyxSyS5tIUn7ZCBnkLywhaWeeMrL+Nj8dsQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhAVewWun0KuZdY3tInnoW6rJoxYlfRvYwUwUrtps5bFSHQJP
	6hV1CHodeKsTDKb52qontGJe/aA6OSYTux9Ls741Q1auWT8SIr4VlbkNsjS4ZA==
X-Google-Smtp-Source: AGHT+IG3h/s8BEHneIECR74Vhcotk/tJPVp1H5/oohF4H43/iSeH9VOVd5Em8mOeT0ufiALdl9qWUQ==
X-Received: by 2002:a05:6a00:80c:b0:71e:5d1d:1aa0 with SMTP id d2e1a72fcca58-72062f4e529mr24388059b3a.6.1730323753267;
        Wed, 30 Oct 2024 14:29:13 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-720bc31b40csm74200b3a.209.2024.10.30.14.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:12 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] platform/chrome: cros_ec_typec: Displayport support
Date: Wed, 30 Oct 2024 14:28:36 -0700
Message-ID: <20241030142833.v2.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030212854.998318-1-abhishekpandit@chromium.org>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
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

Changes in v2:
- Refactored displayport into cros_typec_altmode.c to extract common
  implementation between altmodes

 MAINTAINERS                                  |   3 +
 drivers/platform/chrome/Makefile             |   3 +-
 drivers/platform/chrome/cros_ec_typec.c      |  13 +-
 drivers/platform/chrome/cros_ec_typec.h      |   1 +
 drivers/platform/chrome/cros_typec_altmode.c | 277 +++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  34 +++
 6 files changed, 329 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..de99bcbda7d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5369,9 +5369,12 @@ F:	include/linux/platform_data/cros_usbpd_notify.h
 
 CHROMEOS EC USB TYPE-C DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
+M:	Benson Leung <bleung@chromium.org>
+M:	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.*
+F:	drivers/platform/chrome/cros_typec_altmode.*
 F:	drivers/platform/chrome/cros_typec_switch.c
 F:	drivers/platform/chrome/cros_typec_vdm.*
 
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..8b007404c024 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -17,8 +17,9 @@ obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
-cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
+cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o cros_typec_altmode.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
+
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c8db11bd8a4..7997e7136c4c 100644
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
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
new file mode 100644
index 000000000000..af2f077674f1
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Alt-mode implementation on ChromeOS EC.
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
+struct cros_typec_dp_data {
+	struct typec_displayport_data data;
+
+	bool configured;
+	bool pending_status_update;
+};
+
+struct cros_typec_altmode_data {
+	struct work_struct work;
+	struct cros_typec_port *port;
+	struct typec_altmode *alt;
+	bool ap_mode_entry;
+
+	u32 header;
+	u32 *vdo_data;
+	u8 vdo_size;
+
+	u16 sid;
+	u8 mode;
+
+	union am_specific {
+		struct cros_typec_dp_data dp;
+	} am_data;
+};
+
+static void cros_typec_altmode_work(struct work_struct *work)
+{
+	struct cros_typec_altmode_data *data =
+		container_of(work, struct cros_typec_altmode_data, work);
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
+static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
+{
+	struct cros_typec_altmode_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
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
+	if (data->sid == USB_TYPEC_DP_SID)
+		req.mode_to_enter = CROS_EC_ALTMODE_DP;
+	else
+		return -EOPNOTSUPP;
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
+	data->header = VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE);
+	data->header |= VDO_OPOS(data->mode);
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
+static int cros_typec_altmode_exit(struct typec_altmode *alt)
+{
+	struct cros_typec_altmode_data *data = typec_altmode_get_drvdata(alt);
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
+	data->header = VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE);
+	data->header |= VDO_OPOS(data->mode);
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
+static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+
+	int cmd_type = PD_VDO_CMDT(header);
+	int cmd = PD_VDO_CMD(header);
+	int svdm_version;
+
+	if (!adata->ap_mode_entry) {
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
+			typec_partner_set_svdm_version(adata->port->partner,
+						       PD_VDO_SVDM_VER(header));
+			svdm_version = PD_VDO_SVDM_VER(header);
+		}
+
+		adata->header = VDO(adata->sid, 1, svdm_version, cmd);
+		adata->header |= VDO_OPOS(adata->mode);
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
+			adata->am_data.dp.data.conf = *data;
+			adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+			adata->am_data.dp.configured = true;
+			schedule_work(&adata->work);
+			break;
+		case DP_CMD_STATUS_UPDATE:
+			adata->am_data.dp.pending_status_update = true;
+			break;
+		default:
+			adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+			schedule_work(&adata->work);
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
+static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+
+	if (adata->sid == USB_TYPEC_DP_SID)
+		return cros_typec_displayport_vdm(alt, header, data, count);
+
+	return -EINVAL;
+}
+
+static const struct typec_altmode_ops cros_typec_altmode_ops = {
+	.enter = cros_typec_altmode_enter,
+	.exit = cros_typec_altmode_exit,
+	.vdm = cros_typec_altmode_vdm,
+};
+
+#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
+int cros_typec_displayport_status_update(struct typec_altmode *altmode,
+					 struct typec_displayport_data *data)
+{
+	struct cros_typec_altmode_data *adata =
+		typec_altmode_get_drvdata(altmode);
+
+	if (!adata->am_data.dp.pending_status_update) {
+		dev_dbg(&altmode->dev,
+			"Got DPStatus without a pending request");
+		return 0;
+	}
+
+	if (adata->am_data.dp.configured && adata->am_data.dp.data.conf != data->conf)
+		dev_dbg(&altmode->dev,
+			"DP Conf doesn't match. Requested 0x%04x, Actual 0x%04x",
+			adata->am_data.dp.data.conf, data->conf);
+
+	adata->am_data.dp.data = *data;
+	adata->am_data.dp.pending_status_update = false;
+	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+	adata->vdo_data = &adata->am_data.dp.data.status;
+	adata->vdo_size = 2;
+
+	schedule_work(&adata->work);
+	return 0;
+}
+
+struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry)
+{
+	struct typec_altmode *alt;
+	struct cros_typec_altmode_data *data;
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
+	INIT_WORK(&data->work, cros_typec_altmode_work);
+	data->alt = alt;
+	data->port = port;
+	data->ap_mode_entry = ap_mode_entry;
+	data->sid = USB_TYPEC_DP_SID;
+	data->mode = USB_TYPEC_DP_MODE;
+
+	data->am_data.dp.configured = false;
+	typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
+	typec_altmode_set_drvdata(alt, data);
+
+	return alt;
+}
+#endif
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
new file mode 100644
index 000000000000..c6f8fb02c99c
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
+static inline struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry)
+{
+	return typec_port_register_altmode(port->port, desc);
+}
+
+static inline int cros_typec_displayport_status_update(struct typec_altmode *altmode,
+					 struct typec_displayport_data *data)
+{
+	return 0;
+}
+#endif
+#endif /* __CROS_TYPEC_ALTMODE_H__ */
-- 
2.47.0.163.g1226f6d8fa-goog


