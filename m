Return-Path: <linux-kernel+bounces-339412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7719864C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDF61F257D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CEB13DB9F;
	Wed, 25 Sep 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L301Iirq"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D213AD2A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281524; cv=none; b=ZlR8awFL2cbD9p3g4EofSuEtuVWTRtX99bLfbUFEJgwvrhivBQoooctNWSJKVnQnOp6uMKGRK/vGeyBWfc/N+yadmCmrA/Ko6KIB461FayQi+MfXGlVFM8YapnTCXnJBSbE1JI+vIHAuyNB5sqLKEGFMfo2sXkLHLVAWVoDgfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281524; c=relaxed/simple;
	bh=XShPODdNj2Tf9rZfMcEFuuLjURIarutPgKFC56sORnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUcco/pmzAYLfr4k0ZJdYaYlJuM3B3ZayMjcQV0klf3ZuazUJ2JLwpVWs6gfSWowjbfE1fV62H461Bnj9vt8xvAZH7HWg/FPul2MVr3UclKGmk5XCYBXG+wSU0p5SMcst1j+0Sy7pDFw74rerLziiWRQ2/uFES+yzWLGATQwFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L301Iirq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2dee9d86f4dso65686a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281522; x=1727886322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K73Cjc7PLjHS+1dDna4qVLCGonPYM/7iYy8MOw2IBTo=;
        b=L301IirqtxZAfaO71EUsINwWxlewKhbJ4WsmtZjlBrbwEBJCXJ7AUs1U650WGWFfM0
         7XxKOFbN14vtpwnGhwjUd+lZ/DHqOkLVJ+twMihzoKr1hKk5OQAp8e4vxO5FgStoJjfL
         FLynQHJX8Sl6GXd8Txf18UjBqXHhBSJJVINbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281522; x=1727886322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K73Cjc7PLjHS+1dDna4qVLCGonPYM/7iYy8MOw2IBTo=;
        b=kqGpIkM4nsz+xny2N26XgfkFfUSm/lnpWzUhWMC+z+6aaKc6I6ZPvlvTGGmOxYYT3y
         aurQD/k9iyM8UNpLU7Tmh2EdRG551e5vjq6QRt6pJNZL7OAWEddaTApS9stKKoFlnRxd
         YaFpdxQaEr3cnis4w2CR+aYzBktRbkIR6Mq6LCpekLDs9tuiPYlAJEkcqdpsS5rujOjC
         l5F8iJv77Hahr7cyDhAsii6ZEE4ZcCARxJ/3XK6AtecaxGi3CHHce08bh9DYG9PfWIL+
         pyriVAPB7uXzVF6BCZCr5XVHZLyFwmTiceHDEp9uld/8Z3xU2MGoUrfb2yE0SMN+YNlE
         49jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFjbWwnRx5PmZ45PU6ZJXYqgDrojqEY6ekKyGvr1pdyutgcvyXnxUXDUN4JUL5fUop/SysjcAm2oSPY+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJZIviv8TNFfVYP1KTM5FFzJJ3I0p+pCiyFMRdmVis/qQNENw
	zI1X6CvDNJFGgPW7HBxn1XbFf16+OLZnCV7s6BeMRFhAiHAwkORMR5GYUqS95Q==
X-Google-Smtp-Source: AGHT+IEHZ96lmdEI1m3y/ql4Lx3rthD1wM7Mk3XKb4mr67RO++qDDNKQCQNPjUKcSRGpHp5K+WTlYw==
X-Received: by 2002:a17:90a:ca91:b0:2d8:27c1:1d4a with SMTP id 98e67ed59e1d1-2e06ae79400mr3891142a91.24.1727281521942;
        Wed, 25 Sep 2024 09:25:21 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e06ccf0505sm1750144a91.0.2024.09.25.09.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:21 -0700 (PDT)
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
Subject: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
Date: Wed, 25 Sep 2024 09:25:08 -0700
Message-ID: <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
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

Add support for entering and exiting Thunderbolt alt-mode using AP
driven alt-mode.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_typec.c       |  29 +--
 drivers/platform/chrome/cros_typec_altmode.h  |  14 ++
 .../platform/chrome/cros_typec_thunderbolt.c  | 184 ++++++++++++++++++
 4 files changed, 216 insertions(+), 12 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_thunderbolt.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index fe6c5234ac27..da7a44738171 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 cros-ec-typec-objs			:= cros_ec_typec.o cros_typec_vdm.o
 cros-ec-typec-$(CONFIG_TYPEC_DP_ALTMODE) += cros_typec_displayport.o
+cros-ec-typec-$(CONFIG_TYPEC_TBT_ALTMODE) += cros_typec_thunderbolt.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros-ec-typec.o
 
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f9221d0d95f5..ec13d84d11b8 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -304,21 +304,26 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	typec_altmode_set_drvdata(amode, port);
 	amode->ops = &port_amode_ops;
 #endif
-
 	/*
 	 * Register TBT compatibility alt mode. The EC will not enter the mode
-	 * if it doesn't support it, so it's safe to register it unconditionally
-	 * here for now.
+	 * if it doesn't support it and it will not enter automatically by
+	 * design so we can use the |ap_driven_altmode| feature to check if we
+	 * should register it.
 	 */
-	memset(&desc, 0, sizeof(desc));
-	desc.svid = USB_TYPEC_TBT_SID;
-	desc.mode = TYPEC_ANY_MODE;
-	amode = typec_port_register_altmode(port->port, &desc);
-	if (IS_ERR(amode))
-		return PTR_ERR(amode);
-	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
-	typec_altmode_set_drvdata(amode, port);
-	amode->ops = &port_amode_ops;
+	if (typec->ap_driven_altmode) {
+		memset(&desc, 0, sizeof(desc));
+		desc.svid = USB_TYPEC_TBT_SID;
+		desc.mode = TYPEC_ANY_MODE;
+		amode = cros_typec_register_thunderbolt(port, &desc);
+		if (IS_ERR(amode))
+			return PTR_ERR(amode);
+		port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
+
+#if !IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
+		typec_altmode_set_drvdata(amode, port);
+		amode->ops = &port_amode_ops;
+#endif
+	}
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
index a8b37a18c83a..24e766189211 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -31,4 +31,18 @@ int cros_typec_displayport_status_update(struct typec_altmode *altmode,
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
+struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc);
+#else
+struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc)
+{
+	return typec_port_register_altmode(port->port, desc);
+}
+#endif
+
 #endif /* __CROS_TYPEC_ALTMODE_H__ */
diff --git a/drivers/platform/chrome/cros_typec_thunderbolt.c b/drivers/platform/chrome/cros_typec_thunderbolt.c
new file mode 100644
index 000000000000..b399237b773f
--- /dev/null
+++ b/drivers/platform/chrome/cros_typec_thunderbolt.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Alt-mode implementation for Thunderbolt on ChromeOS EC.
+ *
+ * Copyright 2024 Google LLC
+ * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
+ */
+#include "cros_ec_typec.h"
+
+#include <linux/usb/typec_tbt.h>
+#include <linux/usb/pd_vdo.h>
+
+#include "cros_typec_altmode.h"
+
+struct typec_tbt_data {
+	struct work_struct work;
+
+	struct cros_typec_port *port;
+	struct typec_altmode *alt;
+
+	u32 header;
+	u32 *vdo_data;
+	u8 vdo_size;
+};
+
+static void cros_typec_thunderbolt_work(struct work_struct *work)
+{
+	struct typec_tbt_data *data =
+		container_of(work, struct typec_tbt_data, work);
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
+static int cros_typec_thunderbolt_enter(struct typec_altmode *alt, u32 *vdo)
+{
+	struct typec_tbt_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_ENTER_MODE,
+		.mode_to_enter = CROS_EC_ALTMODE_TBT,
+	};
+	int svdm_version;
+	int ret;
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
+	data->header = VDO(USB_TYPEC_TBT_SID, 1, svdm_version, CMD_ENTER_MODE);
+	data->header |= VDO_OPOS(TYPEC_TBT_MODE);
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
+static int cros_typec_thunderbolt_exit(struct typec_altmode *alt)
+{
+	struct typec_tbt_data *data = typec_altmode_get_drvdata(alt);
+	struct ec_params_typec_control req = {
+		.port = data->port->port_num,
+		.command = TYPEC_CONTROL_COMMAND_EXIT_MODES,
+	};
+	int svdm_version;
+	int ret;
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
+	data->header = VDO(USB_TYPEC_TBT_SID, 1, svdm_version, CMD_EXIT_MODE);
+	data->header |= VDO_OPOS(TYPEC_TBT_MODE);
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
+static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct typec_tbt_data *tbt_data = typec_altmode_get_drvdata(alt);
+
+	int cmd_type = PD_VDO_CMDT(header);
+	int cmd = PD_VDO_CMD(header);
+	int svdm_version;
+
+	svdm_version = typec_altmode_get_svdm_version(alt);
+	if (svdm_version < 0)
+		return svdm_version;
+
+	switch (cmd_type) {
+	case CMDT_INIT:
+		if (PD_VDO_SVDM_VER(header) < svdm_version) {
+			typec_partner_set_svdm_version(tbt_data->port->partner,
+						       PD_VDO_SVDM_VER(header));
+			svdm_version = PD_VDO_SVDM_VER(header);
+		}
+
+		tbt_data->header = VDO(USB_TYPEC_TBT_SID, 1, svdm_version, cmd);
+		tbt_data->header |= VDO_OPOS(TYPEC_TBT_MODE);
+
+		/*
+		 * TODO - Just always reply to the VDMs that we are done.
+		 */
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			/* Don't respond to the enter mode vdm because it
+			 * triggers mux configuration. This is handled directly
+			 * by the cros_ec_typec driver so the Thunderbolt driver
+			 * doesn't need to be involved.
+			 */
+			break;
+		default:
+			tbt_data->header |= VDO_CMDT(CMDT_RSP_ACK);
+			schedule_work(&tbt_data->work);
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
+static const struct typec_altmode_ops cros_typec_thunderbolt_ops = {
+	.enter = cros_typec_thunderbolt_enter,
+	.exit = cros_typec_thunderbolt_exit,
+	.vdm = cros_typec_thunderbolt_vdm,
+};
+
+struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc)
+{
+	struct typec_altmode *alt;
+	struct typec_tbt_data *data;
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
+	INIT_WORK(&data->work, cros_typec_thunderbolt_work);
+	data->alt = alt;
+	data->port = port;
+
+	typec_altmode_set_ops(alt, &cros_typec_thunderbolt_ops);
+	typec_altmode_set_drvdata(alt, data);
+
+	return alt;
+}
-- 
2.46.0.792.g87dc391469-goog


