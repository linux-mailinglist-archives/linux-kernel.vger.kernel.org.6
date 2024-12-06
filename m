Return-Path: <linux-kernel+bounces-435802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C79E7CBA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2F188797E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0D215050;
	Fri,  6 Dec 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TgfYLpDF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1466212F9E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528333; cv=none; b=KRGVzESpNN/0rEQXdoQ3vkbvNG1e5BAvSr1pUlWYkSfF7hoblNevE8E5n8EmXrn/wPtcrFQxFMLslr1B1c3x6PMRFgAbhJ2P5LgCDHAm96CEFyGZDE7YYeg1763ZPvk4ZAkXlUskHiKWSKEnnttRjTNjzg5caAh0r9TUWNSKxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528333; c=relaxed/simple;
	bh=2+wBq8u+eD2ermclDg0jFeGME49qev4T7mEgijTUuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOC8WajLuSbh1oLO/6M7HFUzog/e/A+OguLyuCC3jMr2GQst3sJ1myAntQ2owB0bzsRNoDZGmBD34ylGpL2gSERUNTkIzAgJzwD8f2B9fn2gcbv4hQ7e03YJtYaITx9MiPjdyoZB8DvBvVHtsuwA4/uSdm1lbjSsc19xEFF8ZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TgfYLpDF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725b3b9fa6cso1631506b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528331; x=1734133131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdVPVTBpSHJ+79KT4El6LsZDWrZDHedECOLs0CT3WJ4=;
        b=TgfYLpDFsMpnsXHX0lxz+SIngq+phE14ovn6l+A6ci5Say5pusPxUh17enUsD47W+s
         Adw40b4oBuC7qSIy9KOw2zgShdzw7UoZUC2iN9Vyo7FKBoKLftTodxwOfw3ekaHqbzVy
         l34rruPgodfO4+g7mGq3xOiuvcVwHGepCEySM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528331; x=1734133131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdVPVTBpSHJ+79KT4El6LsZDWrZDHedECOLs0CT3WJ4=;
        b=xTv0iQVguzJZhz1iqrX+aaEMADsi1b0SO77bl8/qSlREDnLtkV/cFImCvi0KUVHwkI
         eBZaN5sT/BriZckCteQj0JP9aS9cAqexQDLALkY6Ouq1L8w2+12M0lvzW3BOPxKftXMj
         XbCQFwdH01qzYPCMVvtAaBpDP2bZJb89vX3fxZWsNxJ6fLxP7lxXaezDw67MXmXGpLyU
         7LIqvo6H9abSq7P3TChLOkaMe006qXnBSfJEwQGFB/qzABnSqsSj8a0SpPTchnM9gRPn
         12oscv3lVhpHr+EJFzrUJ1gikiZUvDM+O8Xp8Ld2NaEjRxjzYjvTs+sxxE0wexGW3O+7
         7TxA==
X-Forwarded-Encrypted: i=1; AJvYcCVOiIW4dbW6N8Y9vTC34FQtwIyYyejnU6S+qV9thWnvtfVRJJvDIIQDH8n8ewlOB4EW2ftUxkaoEntxEyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRUsebHK6M43CPj2K4QUW4sny5r6/Kso/LhCNc5iknMocGVx1
	N+RNdE5D+WNQO/M824xPQopSI9cfhB6ANfQYlm3T12NFkTHhzq6aGwSiSNQT0Q==
X-Gm-Gg: ASbGncvL/ZGL9zMvWmoGQcCFQxyZBfrLrYvImh1pEJbwb0CLqAbFK6mQXZHpXtrYfc5
	ka7En3OBpwX5NtjE1pIXin4nOruQYeqm004Hd7Z9FIcIE37xHfIBNIyr9iM+cmnPNj2/gc4RMpQ
	m/tu2evBlR9W/IO8wYfl+hWcBBWKVfNKWKDvv8d9km+k3Is+0cge/InnfsnyoN3o6Mfm2VpGnKO
	bZdH2DYZr4nZtDFdZMg2WHiG0oDs+80ykZ95TdYCcOSdfv/SFa+GGHJr4Q01SiZ+zVzX0X/T2RA
	MhpaVWE8sdZ69vdKyHOL6y4F
X-Google-Smtp-Source: AGHT+IH1WcTWH/AnvqB14ooojDiG20Od9CpEHQt6ICLFCNdse1mkRXoI9sx7hDec7O26SURGe5T/6Q==
X-Received: by 2002:a05:6a00:92a6:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-725b81a3f83mr7284055b3a.19.1733528331002;
        Fri, 06 Dec 2024 15:38:51 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725bcee5f2esm1728558b3a.54.2024.12.06.15.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:50 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	pmalani@chromium.org,
	jthies@google.com,
	dmitry.baryshkov@linaro.org,
	badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] platform/chrome: cros_ec_typec: Displayport support
Date: Fri,  6 Dec 2024 15:38:16 -0800
Message-ID: <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206233830.2401638-1-abhishekpandit@chromium.org>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
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
 drivers/platform/chrome/cros_typec_altmode.c | 281 +++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  34 +++
 7 files changed, 339 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.c
 create mode 100644 drivers/platform/chrome/cros_typec_altmode.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd6aa609deba..5f9d8b8f1cb3 100644
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
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 7dbeb786352a..984f843ea7a2 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -226,12 +226,18 @@ config CROS_EC_SYSFS
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
index 2dcc6ccc2302..aec2d043a0fe 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -18,7 +18,11 @@ obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
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
index e3eabe5e42ac..0f3bc335f583 100644
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
@@ -575,6 +576,10 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
 
+	if (!ret)
+		cros_typec_displayport_status_update(port->state.alt,
+						     port->state.data);
+
 	return ret;
 }
 
@@ -1254,6 +1259,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
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
index 000000000000..bb7c7ad2ff6e
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -0,0 +1,281 @@
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
+		dev_err(&data->alt->dev, "VDM 0x%x failed", data->header);
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
+	struct cros_typec_altmode_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
+	};
+	int svdm_version;
+	int ret;
+
+	if (!data->ap_mode_entry) {
+		dev_warn(&alt->dev,
+			 "EC does not support AP driven mode entry\n");
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
+	mutex_lock(&data->lock);
+
+	data->header = VDO(data->sid, 1, svdm_version, CMD_ENTER_MODE);
+	data->header |= VDO_OPOS(data->mode);
+	data->header |= VDO_CMDT(CMDT_RSP_ACK);
+	data->vdo_data = NULL;
+	data->vdo_size = 1;
+	schedule_work(&data->work);
+
+	mutex_unlock(&data->lock);
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
+		dev_warn(&alt->dev,
+			 "EC does not support AP driven mode exit\n");
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
+	mutex_lock(&data->lock);
+
+	data->header = VDO(data->sid, 1, svdm_version, CMD_EXIT_MODE);
+	data->header |= VDO_OPOS(data->mode);
+	data->header |= VDO_CMDT(CMDT_RSP_ACK);
+	data->vdo_data = NULL;
+	data->vdo_size = 1;
+	schedule_work(&data->work);
+
+	mutex_unlock(&data->lock);
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
+			"Got DPStatus without a pending request");
+		return 0;
+	}
+
+	if (dp_data->configured && dp_data->data.conf != data->conf)
+		dev_dbg(&altmode->dev,
+			"DP Conf doesn't match. Requested 0x%04x, Actual 0x%04x",
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
+	mutex_init(&data->lock);
+	data->alt = alt;
+	data->port = port;
+	data->ap_mode_entry = ap_mode_entry;
+	data->sid = desc->svid;
+	data->mode = desc->mode;
+
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
2.47.0.338.g60cca15819-goog


