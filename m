Return-Path: <linux-kernel+bounces-445712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3E9F1A35
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63D5188E1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4351F2393;
	Fri, 13 Dec 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="caWNA1jO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5E1EC014
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132963; cv=none; b=PvxlgVWOtyIOIYE4asQxDSjMg6F9OC2yrU3Yvyu3xSf7e8WkRK2EUHPIPcASeaSO2s1iGggQFCv4ykKLvbwwINfZ01CVlfN0G+6QjOfBlkur/K/syGxtIGinqbBtLP7mfsBSb6eTEyOOGVcSKqbkQ63e2e8TN1H/5lVNqSIhIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132963; c=relaxed/simple;
	bh=Y4izmnQahZkJHSwfi21LYUxjShPO/57RUq6XejYZG3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWGR8dvEh+Oa9LYr6aknmk1CffYVv+Qz9eNbyYaYg1seP0fNXFJ0DhEkQrz5KUaDj4JWaabfKM5BA5WGsveBy4Q7H0WrhjhxhlyT/FMhZ35RP38Ic/87P9gVhmMFWK07eAnn6Lz431fAjEzPk3Z14ZlJByYYh0tSLzG4/EC1vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=caWNA1jO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216281bc30fso25730325ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132960; x=1734737760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp4O4NVhXi2glWr53Xq47xS5hhnpO0vudtk7HNerngI=;
        b=caWNA1jOXJKYqfqA5oClrTNmRM3aGxMvGXgk8Q004zeqMUK71lYwfTAVt1ZnyZcEVg
         YgNxtLcRU/myKppnJt/7FT065ivt6QYyh85N6Ulw+jxsAlYMughN8t8vfw9Am4ctSfAW
         sQRzko5s13DSO7Nbp9VrCe0SCsjwbwbVjywTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132960; x=1734737760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp4O4NVhXi2glWr53Xq47xS5hhnpO0vudtk7HNerngI=;
        b=nQOuyRfK1RtQoEhuW9d3x+U5JNzmncXj5TYOGMryGON8n/RdhlwFi/mVOOm0R4E89O
         sbOH51pSGIlHOhxmRPAVdKNDSJSEDwDO1kltyNBvh3QmKLDBsdPbFbJV8SAAN77Q0jKg
         IaM7Qh4DThaOsIFGA+JEYuaCweyr62hDEOdZMG/mu9dJSPB42X0wUlCbpysG4oWinXVp
         YqkTWB2OiKgtdu0/0474UaOHOvl46EwAYG6xzKdQpIulb2Sqtc5NJx1bChGLF5m2XM2m
         MRoE+AEpHgqSH3l7IU5wKqzJWe1jmR8L1bALAWAxxAUaiu86+/duTagduUM5KrTvkbmz
         rgaw==
X-Forwarded-Encrypted: i=1; AJvYcCXgpIUtQlI78WsKmzvqizEM0vhPVPow88WnvOiqZqQeITeKjDunfld7ImY0yPNCQHhjJB/gV1gVde3jKrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WGHvEkRowrgcD2rckG7u7x7jSlKO+uQmlmJ4+OZxusOiTpiG
	4v+Xz+UYYjBXIxwwoYUgzgfIKEoDpnqRHMzbUhUp/johgY3JM3licsNBqB8qnQ==
X-Gm-Gg: ASbGnctCOcXz9lymDXaW+TQeBHJUDtCEcfDHHOiz7g9JcVnofEYtgxveH/ohKjTwKkA
	FBwGWmggr5aSFtW12/P9cTfgOt7l0jnPTbukRTJD2WdUYIjwrG3fqVKtCVRPK9l4xtAQEwK7/gv
	P4rP08zCw7V4x4ZnKot3FCagGurqd9/wJvD/ZFggGVmQZo8l/BW9wdLPrez5m13bgnGERJPpqiP
	eRVdPJt9HoNXhtHsuApKVhW1Tfipy8wMy62+YQQ91Dgq1DTu0/53ava4t9yevFtZ5wBq1UhJnpz
	hZJ8Ot6m+Cxh3CCeDVf2Y0D+3WC3WKU=
X-Google-Smtp-Source: AGHT+IHUOk7HT+Qssku8WOcXKMS2YCbAX43HYt1ag9wsdLaE4yal35Bof8rrlHpR/HpJi7v1M0qQfQ==
X-Received: by 2002:a17:902:e747:b0:216:5002:7341 with SMTP id d9443c01a7336-21892acab36mr55526375ad.44.1734132960430;
        Fri, 13 Dec 2024 15:36:00 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e72111sm2837505ad.271.2024.12.13.15.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:36:00 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	sboyd@kernel.org,
	pmalani@chromium.org,
	badhri@google.com,
	rdbabiera@google.com,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] platform/chrome: cros_ec_typec: Displayport support
Date: Fri, 13 Dec 2024 15:35:47 -0800
Message-ID: <20241213153543.v5.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213233552.451927-1-abhishekpandit@chromium.org>
References: <20241213233552.451927-1-abhishekpandit@chromium.org>
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

Changes in v5:
- Include missing headers for altmodes
- Consistent use of `adata` for altmode data
- Fix incorrect alloc size of dp_data

Changes in v4:
- memset struct typec_altmode_desc
- Add CONFIG_CROS_EC_TYPEC_ALTMODES for Makefile use
- Move ap_driven_altmode check to common vdm function
- Add locking to protect shared data
- Update enter/exit error messages

Changes in v3:
- Refactored typec_altmode_dp_data per review request
- Removed unused vdm operations during altmode registration

Changes in v2:
- Refactored displayport into cros_typec_altmode.c to extract common
  implementation between altmodes

 MAINTAINERS                                  |   3 +
 drivers/platform/chrome/Kconfig              |   6 +
 drivers/platform/chrome/Makefile             |   4 +
 drivers/platform/chrome/cros_ec_typec.c      |  13 +-
 drivers/platform/chrome/cros_ec_typec.h      |   1 +
 drivers/platform/chrome/cros_typec_altmode.c | 285 +++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  37 +++
 7 files changed, 346 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..f90a92d62ce0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5434,9 +5434,12 @@ F:	include/linux/platform_data/cros_usbpd_notify.h
 
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
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index b7dbaf77b6db..23aa594fbb5b 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -237,12 +237,18 @@ config CROS_EC_SYSFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_sysfs.
 
+config CROS_EC_TYPEC_ALTMODES
+	bool
+	help
+	  Selectable symbol to enable altmodes.
+
 config CROS_EC_TYPEC
 	tristate "ChromeOS EC Type-C Connector Control"
 	depends on MFD_CROS_EC_DEV && TYPEC
 	depends on CROS_USBPD_NOTIFY
 	depends on USB_ROLE_SWITCH
 	default MFD_CROS_EC_DEV
+	select CROS_EC_TYPEC_ALTMODES if TYPEC_DP_ALTMODE
 	help
 	  If you say Y here, you get support for accessing Type C connector
 	  information from the Chrome OS EC.
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index fb8335458a22..1a5a484563cc 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -19,7 +19,11 @@ obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
+ifneq ($(CONFIG_CROS_EC_TYPEC_ALTMODES),)
+	cros-ec-typec-objs		+= cros_typec_altmode.o
+endif
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
+
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 77f748fc8542..1bcaa7269395 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -18,6 +18,7 @@
 
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
+#include "cros_typec_altmode.h"
 
 #define DRV_NAME "cros-ec-typec"
 
@@ -290,15 +291,15 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	struct typec_altmode *amode;
 
 	/* All PD capable CrOS devices are assumed to support DP altmode. */
+	memset(&desc, 0, sizeof(desc));
 	desc.svid = USB_TYPEC_DP_SID;
 	desc.mode = USB_TYPEC_DP_MODE;
 	desc.vdo = DP_PORT_VDO;
-	amode = typec_port_register_altmode(port->port, &desc);
+	amode = cros_typec_register_displayport(port, &desc,
+						typec->ap_driven_altmode);
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
 	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
-	typec_altmode_set_drvdata(amode, port);
-	amode->ops = &port_amode_ops;
 
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
@@ -576,6 +577,10 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
 
+	if (!ret)
+		ret = cros_typec_displayport_status_update(port->state.alt,
+							   port->state.data);
+
 	return ret;
 }
 
@@ -1253,6 +1258,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
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
index 000000000000..6e736168ccc3
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Alt-mode implementation on ChromeOS EC.
+ *
+ * Copyright 2024 Google LLC
+ * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
+ */
+#include "cros_ec_typec.h"
+
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/pd_vdo.h>
+
+#include "cros_typec_altmode.h"
+
+struct cros_typec_altmode_data {
+	struct work_struct work;
+	struct cros_typec_port *port;
+	struct typec_altmode *alt;
+	bool ap_mode_entry;
+
+	struct mutex lock;
+	u32 header;
+	u32 *vdo_data;
+	u8 vdo_size;
+
+	u16 sid;
+	u8 mode;
+};
+
+struct cros_typec_dp_data {
+	struct cros_typec_altmode_data adata;
+	struct typec_displayport_data data;
+	bool configured;
+	bool pending_status_update;
+};
+
+static void cros_typec_altmode_work(struct work_struct *work)
+{
+	struct cros_typec_altmode_data *data =
+		container_of(work, struct cros_typec_altmode_data, work);
+
+	mutex_lock(&data->lock);
+
+	if (typec_altmode_vdm(data->alt, data->header, data->vdo_data,
+			      data->vdo_size))
+		dev_err(&data->alt->dev, "VDM 0x%x failed\n", data->header);
+
+	data->header = 0;
+	data->vdo_data = NULL;
+	data->vdo_size = 0;
+
+	mutex_unlock(&data->lock);
+}
+
+static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = adata->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
+	};
+	int svdm_version;
+	int ret;
+
+	if (!adata->ap_mode_entry) {
+		dev_warn(&alt->dev,
+			 "EC does not support AP driven mode entry\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (adata->sid == USB_TYPEC_DP_SID)
+		req.mode_to_enter = CROS_EC_ALTMODE_DP;
+	else
+		return -EOPNOTSUPP;
+
+	ret = cros_ec_cmd(adata->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
+			  &req, sizeof(req), NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	mutex_lock(&adata->lock);
+
+	adata->header = VDO(adata->sid, 1, svdm_version, CMD_ENTER_MODE);
+	adata->header |= VDO_OPOS(adata->mode);
+	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+	adata->vdo_data = NULL;
+	adata->vdo_size = 1;
+	schedule_work(&adata->work);
+
+	mutex_unlock(&adata->lock);
+	return ret;
+}
+
+static int cros_typec_altmode_exit(struct typec_altmode *alt)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = adata->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_EXIT_MODES,
+	};
+	int svdm_version;
+	int ret;
+
+	if (!adata->ap_mode_entry) {
+		dev_warn(&alt->dev,
+			 "EC does not support AP driven mode exit\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = cros_ec_cmd(adata->port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
+			  &req, sizeof(req), NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	mutex_lock(&adata->lock);
+
+	adata->header = VDO(adata->sid, 1, svdm_version, CMD_EXIT_MODE);
+	adata->header |= VDO_OPOS(adata->mode);
+	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+	adata->vdo_data = NULL;
+	adata->vdo_size = 1;
+	schedule_work(&adata->work);
+
+	mutex_unlock(&adata->lock);
+	return ret;
+}
+
+static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct cros_typec_dp_data *dp_data = typec_altmode_get_drvdata(alt);
+	struct cros_typec_altmode_data *adata = &dp_data->adata;
+
+
+	int cmd_type = PD_VDO_CMDT(header);
+	int cmd = PD_VDO_CMD(header);
+	int svdm_version;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	mutex_lock(&adata->lock);
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
+			dp_data->data.conf = *data;
+			adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+			dp_data->configured = true;
+			schedule_work(&adata->work);
+			break;
+		case DP_CMD_STATUS_UPDATE:
+			dp_data->pending_status_update = true;
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
+	mutex_unlock(&adata->lock);
+	return 0;
+}
+
+static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
+
+	if (!adata->ap_mode_entry)
+		return -EOPNOTSUPP;
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
+	struct cros_typec_dp_data *dp_data =
+		typec_altmode_get_drvdata(altmode);
+	struct cros_typec_altmode_data *adata = &dp_data->adata;
+
+	if (!dp_data->pending_status_update) {
+		dev_dbg(&altmode->dev,
+			"Got DPStatus without a pending request\n");
+		return 0;
+	}
+
+	if (dp_data->configured && dp_data->data.conf != data->conf)
+		dev_dbg(&altmode->dev,
+			"DP Conf doesn't match. Requested 0x%04x, Actual 0x%04x\n",
+			dp_data->data.conf, data->conf);
+
+	mutex_lock(&adata->lock);
+
+	dp_data->data = *data;
+	dp_data->pending_status_update = false;
+	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+	adata->vdo_data = &dp_data->data.status;
+	adata->vdo_size = 2;
+	schedule_work(&adata->work);
+
+	mutex_unlock(&adata->lock);
+
+	return 0;
+}
+
+struct typec_altmode *
+cros_typec_register_displayport(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc,
+				bool ap_mode_entry)
+{
+	struct typec_altmode *alt;
+	struct cros_typec_dp_data *dp_data;
+	struct cros_typec_altmode_data *adata;
+
+	alt = typec_port_register_altmode(port->port, desc);
+	if (IS_ERR(alt))
+		return alt;
+
+	dp_data = devm_kzalloc(&alt->dev, sizeof(*dp_data), GFP_KERNEL);
+	if (!dp_data) {
+		typec_unregister_altmode(alt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	adata = &dp_data->adata;
+	INIT_WORK(&adata->work, cros_typec_altmode_work);
+	mutex_init(&adata->lock);
+	adata->alt = alt;
+	adata->port = port;
+	adata->ap_mode_entry = ap_mode_entry;
+	adata->sid = desc->svid;
+	adata->mode = desc->mode;
+
+	typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
+	typec_altmode_set_drvdata(alt, adata);
+
+	return alt;
+}
+#endif
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
new file mode 100644
index 000000000000..ed00ee7a402b
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __CROS_TYPEC_ALTMODE_H__
+#define __CROS_TYPEC_ALTMODE_H__
+
+#include <linux/kconfig.h>
+#include <linux/usb/typec.h>
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
2.47.1.613.gc27f4b7a9f-goog


