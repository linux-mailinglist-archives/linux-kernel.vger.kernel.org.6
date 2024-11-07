Return-Path: <linux-kernel+bounces-400540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F19C0EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1DBB22DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEE218934;
	Thu,  7 Nov 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTvkNs8B"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76D218339
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007911; cv=none; b=Y5FjX+yS98pmKN7Pb9JWMpreBhZs3jTj6zoLEpuAqbzxg5/EpMqVFhMZ+czK512xeG0u+c2EWsuIBG+OF2ill4z++aayEoP+zkApAlq6KkGWzemWqnoJupmW7NfthwaTTIM4tCAbzlRrU/1nY0RkCGcyEky+SrDCUtRX0LQ4tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007911; c=relaxed/simple;
	bh=n8KJY3J9iv2lpBcZuKW5kNPAa04zqHHybIY+sJNd8J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2r1aMYjKa/sDuGdK5HyQn2MfrSw0lsyRAFpeamkhhdQA1DcR52aAz5DPYZWjUzoyWt/DbnjhyDDC9UtYYQH3eUAhzSSGYrlXCfr4ANPe+lvoPpKszaMPmXPFIoN4WdVN2usk314uw/zfAx/kjcYaLUDNa2+4RzkzvoaIAa9R6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fTvkNs8B; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720e94d36c8so2250760b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731007909; x=1731612709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXLwVpSoeftRoET3ccC5saeWASd5OdykBU3Zi9Wk7FE=;
        b=fTvkNs8BX9pKsOmaeWqfgxYzFZnfGsz7ELdOuRIdS5noby3JSRoiVTXdPYunfK2pSH
         z/3RpUePEKSmJtiNUlfMhbKLHg2pfyUXMTsJBm+36D9YKOfNiVzglkh1JKIhRHZbW3wa
         N2n7Xc7GhzixintdVdGe00PZxsuwoHITENiTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007909; x=1731612709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXLwVpSoeftRoET3ccC5saeWASd5OdykBU3Zi9Wk7FE=;
        b=fpwuK3H4oGnIEDT8ZDJyxaC7cM8tjuK6/kq8nYwhCrtMNvazEp0PViYx2s2kbeukS8
         J84eM6fvVUkF+2TK4V8UO2svmtL/yLLko1HGWT1fnA4uTXhIzY4JW1IwfGrE2tQ3X7yu
         bjSPG9R6fFK2dHX0xLFT85OlapJXf1dW+VaWSFmQwHrnT6kryAw1VIPQohP/QT4DhaWb
         9euO9sYky2DlgGipNhf944Z8WLI1NCU9cqfUt0DMT+wpARscvQ72rz8ie/DApop6872Y
         ScdAeR5ckdc7hnqHrp69JEVQy/QT2e7HFUQgJAogXuzppr30yHBJCeLq7kk/4dwatAd5
         2UFA==
X-Forwarded-Encrypted: i=1; AJvYcCU6w0z/sfHo7UjXMrizx5z8tHUyOWUD10ECpHRjFfmumuOSutxqz5wjkN2K+q0muwPgV47KSFajCHEHHxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLoPdRcdEGMIZKsvF4VHeP/Lr9zkFHb1qAZdMkkQcvBKsomeMB
	9GakShyR8mZX5Z25yVsfz7C3xOh5/qxGPxSsM+dXrr19PXmLjWVs4CuWuE5EqA==
X-Google-Smtp-Source: AGHT+IEzLgAEfMGzFznaFn3bTLRyae18n1VFGCeP42BEZFpREYg7bSCd8zK2x0KaKUJw6VFBifesYA==
X-Received: by 2002:a05:6a20:7f97:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1dc232d81afmr22786637.2.1731007908603;
        Thu, 07 Nov 2024 11:31:48 -0800 (PST)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f41f5e7350sm1844353a12.44.2024.11.07.11.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:31:48 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	dmitry.baryshkov@linaro.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] platform/chrome: cros_ec_typec: Displayport support
Date: Thu,  7 Nov 2024 11:29:58 -0800
Message-ID: <20241107112955.v3.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241107193021.2690050-1-abhishekpandit@chromium.org>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
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

Changes in v3:
- Refactored typec_altmode_dp_data per review request
- Removed unused vdm operations during altmode registration

Changes in v2:
- Refactored displayport into cros_typec_altmode.c to extract common
  implementation between altmodes

 MAINTAINERS                                  |   3 +
 drivers/platform/chrome/Makefile             |   4 +
 drivers/platform/chrome/cros_ec_typec.c      |  12 +-
 drivers/platform/chrome/cros_ec_typec.h      |   1 +
 drivers/platform/chrome/cros_typec_altmode.c | 275 +++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h |  34 +++
 6 files changed, 326 insertions(+), 3 deletions(-)
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
 
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..2f90d4db8099 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -18,7 +18,11 @@ obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
+ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
+	cros-ec-typec-objs		+= cros_typec_altmode.o
+endif
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
+
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e3eabe5e42ac..3a6f5f2717b9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -18,6 +18,7 @@
 
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
+#include "cros_typec_altmode.h"
 
 #define DRV_NAME "cros-ec-typec"
 
@@ -293,12 +294,11 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
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
@@ -575,6 +575,10 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
 
+	if (!ret)
+		cros_typec_displayport_status_update(port->state.alt,
+						     port->state.data);
+
 	return ret;
 }
 
@@ -1254,6 +1258,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
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
index 000000000000..3598b8a6ceee
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -0,0 +1,275 @@
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
+	struct cros_typec_dp_data *dp_data = typec_altmode_get_drvdata(alt);
+	struct cros_typec_altmode_data *adata = &dp_data->adata;
+
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
+	dp_data->data = *data;
+	dp_data->pending_status_update = false;
+	adata->header |= VDO_CMDT(CMDT_RSP_ACK);
+	adata->vdo_data = &dp_data->data.status;
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
2.47.0.277.g8800431eea-goog


