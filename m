Return-Path: <linux-kernel+bounces-445713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95749F1A36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFC9162759
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99F1F2C2D;
	Fri, 13 Dec 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXGN7F1t"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED111EF080
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132964; cv=none; b=adx9xS4ju8QKI8owFawnWYeEys4uXRhM/mlUXPIIp9Xi/CH/5D4UAMqTW9aSQozIXAlC3aDn7ZIX3Rxs2FsXvr2493pIJ85KW9tpkCpsnfsuCViUxzuwlAnTgZqXDtpqSBViFWqWFh5L00V3Eqf37iiG0zoDU7a02MmDF/Q+Qcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132964; c=relaxed/simple;
	bh=WBy8a1nwOnOJ5PuN8LzEfRg8osxSOfWhfOEs7bD1uPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsohHxrcpeay/8NjOhpSDaNRefpGGGLKP6Xx6RdTE93uI+tHA+2EgpeKGDooXYL1zxDYaYnaiGhDU1RqBGRhT980XbGUieyggKkP1QRj4TkyVJMx9ioWv8u4FULVENJO5gqT9rLlK7IgWTO2Z9Ttvy+yCTGx37dh096w8mBleXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TXGN7F1t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so1985811b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132961; x=1734737761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRprcN4gAxrcp8qfIsK08RpJLsgSnjzl89W7aECmEZo=;
        b=TXGN7F1tCdKmot1qHlm4CWFRykHjWtiP0qhIvfcAgfismaNDMhHy8RzSqhXwb0WTbL
         mvYZTMmVR1ON4lcN0g4NjnDySXexOxhhDqJ+N+47QGpxP/aNRCK+lvIPCIlFJpzZGBnZ
         XUyz2vDM3UHaSvub3YhXHFTUkf3VVLQCN1TOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132961; x=1734737761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRprcN4gAxrcp8qfIsK08RpJLsgSnjzl89W7aECmEZo=;
        b=Et4uCmVh8hJH5HYecPazg51PEi6kWXb2jbNHKTkVCH/MVQmu/8tAnK+Zxl4SeyyMSA
         3v21PKoAk+X6duT7OwOC5OO3fXu+MsYUkSI794OYz9KQJiO5C1qSkA8vg4Z8ki5jyV6R
         KNnr3l6kSKAu5HpvvCCgC1+FD5imC5doAnP75s7PkFMzWqoqzBL4xCmxEiPib/3PLOuZ
         E4aahUrqcauH5wCmieLAch+7wssgzSqAhJmadoIaZqFwOQQ8qnjoa4zyRV+l0xs+oFS7
         N8GzH1AtBD7VDukInzsZdZDLWczXO3w4opmf9z4pma+PVy07B72QeqlkTO4VnPQj/bry
         Juxg==
X-Forwarded-Encrypted: i=1; AJvYcCWL+efpzXUB5wCj+GZ5NM+WN0zVhLZJ1pdW3ZGeOBWDgJ/DvjzOzNz6Dlr87P8R3j+udTbXtvXEoox9OwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymAiyMBuNHzESyiZJKmIlR/hP1694ikNhofsH8TS4Bx7aJRyv4
	NL+dyn/wc2mpLe0LtmhbWftQgqXlWKwN6zth6JXdVdS0wnYf9wcIQH/gGHogPg==
X-Gm-Gg: ASbGnct+es4vEeikSO5MOMNs6tYRRjyHQ+QEeIJbE8UAqkPvROMkmcdTSmXcPOLHjRL
	uHgluwJB9waguvewvBHwxvkh35kUX89ls0ugGqfxcx26mje654YAW3+lmPeiqwFEG7jeWIDwNVz
	B78yhc6y/wmgkG17r3tzAKwNnQMUAchhBVbcXToFAvhv9Q6lYWPYYB2AzqG/JGTaqf99c+gg79A
	xDsjScOA8PyIOOylzytaq0thP9ljaYE9KrkdhLmH6rTXWEpH6s4zkPW8CoEHapVGmIu6AL3YLe2
	liopbDg1q2IBYDpyMJ0qv/45ZIedtIw=
X-Google-Smtp-Source: AGHT+IGT/88hjANI6U8zGVuZIS53BXDo4Y7zL1DFNTnJEHEL1TseI0T6pqT2LT4xZJWmIPULUc4vCQ==
X-Received: by 2002:a05:6a00:3309:b0:727:3ac3:7f9c with SMTP id d2e1a72fcca58-7290c12ee39mr6917200b3a.10.1734132961334;
        Fri, 13 Dec 2024 15:36:01 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72918bcea7bsm327796b3a.198.2024.12.13.15.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:36:01 -0800 (PST)
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
Subject: [PATCH v5 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
Date: Fri, 13 Dec 2024 15:35:48 -0800
Message-ID: <20241213153543.v5.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
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

Add support for entering and exiting Thunderbolt alt-mode using AP
driven alt-mode.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v4)

Changes in v4:
- Update Makefile + Kconfig to use CONFIG_CROS_EC_TYPEC_ALTMODES
- Add locking in vdm function

Changes in v3:
- Fix usage of TBT sid and mode.
- Removed unused vdm operations during altmode registration

Changes in v2:
- Refactored thunderbolt support into cros_typec_altmode.c

 drivers/platform/chrome/Kconfig              |  1 +
 drivers/platform/chrome/cros_ec_typec.c      | 23 ++---
 drivers/platform/chrome/cros_typec_altmode.c | 88 ++++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h | 14 ++++
 4 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 23aa594fbb5b..1b2f2bd09662 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -249,6 +249,7 @@ config CROS_EC_TYPEC
 	depends on USB_ROLE_SWITCH
 	default MFD_CROS_EC_DEV
 	select CROS_EC_TYPEC_ALTMODES if TYPEC_DP_ALTMODE
+	select CROS_EC_TYPEC_ALTMODES if TYPEC_TBT_ALTMODE
 	help
 	  If you say Y here, you get support for accessing Type C connector
 	  information from the Chrome OS EC.
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 1bcaa7269395..1ac5798d887f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -303,18 +303,19 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 
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
+		desc.mode = TBT_MODE;
+		amode = cros_typec_register_thunderbolt(port, &desc);
+		if (IS_ERR(amode))
+			return PTR_ERR(amode);
+		port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
+	}
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 6e736168ccc3..557340b53af0 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_tbt.h>
 #include <linux/usb/pd_vdo.h>
 
 #include "cros_typec_altmode.h"
@@ -72,6 +73,8 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
 
 	if (adata->sid == USB_TYPEC_DP_SID)
 		req.mode_to_enter = CROS_EC_ALTMODE_DP;
+	else if (adata->sid == USB_TYPEC_TBT_SID)
+		req.mode_to_enter = CROS_EC_ALTMODE_TBT;
 	else
 		return -EOPNOTSUPP;
 
@@ -196,6 +199,56 @@ static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
 	return 0;
 }
 
+static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt, u32 header,
+				      const u32 *data, int count)
+{
+	struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
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
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			/* Don't respond to the enter mode vdm because it
+			 * triggers mux configuration. This is handled directly
+			 * by the cros_ec_typec driver so the Thunderbolt driver
+			 * doesn't need to be involved.
+			 */
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
+
 static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
 				      const u32 *data, int count)
 {
@@ -207,6 +260,9 @@ static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
 	if (adata->sid == USB_TYPEC_DP_SID)
 		return cros_typec_displayport_vdm(alt, header, data, count);
 
+	if (adata->sid == USB_TYPEC_TBT_SID)
+		return cros_typec_thunderbolt_vdm(alt, header, data, count);
+
 	return -EINVAL;
 }
 
@@ -283,3 +339,35 @@ cros_typec_register_displayport(struct cros_typec_port *port,
 	return alt;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
+struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc)
+{
+	struct typec_altmode *alt;
+	struct cros_typec_altmode_data *adata;
+
+	alt = typec_port_register_altmode(port->port, desc);
+	if (IS_ERR(alt))
+		return alt;
+
+	adata = devm_kzalloc(&alt->dev, sizeof(*adata), GFP_KERNEL);
+	if (!adata) {
+		typec_unregister_altmode(alt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_WORK(&adata->work, cros_typec_altmode_work);
+	adata->alt = alt;
+	adata->port = port;
+	adata->ap_mode_entry = true;
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
index ed00ee7a402b..3f2aa95d065a 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -34,4 +34,18 @@ static inline int cros_typec_displayport_status_update(struct typec_altmode *alt
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
+struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc);
+#else
+static inline struct typec_altmode *
+cros_typec_register_thunderbolt(struct cros_typec_port *port,
+				struct typec_altmode_desc *desc)
+{
+	return typec_port_register_altmode(port->port, desc);
+}
+#endif
+
 #endif /* __CROS_TYPEC_ALTMODE_H__ */
-- 
2.47.1.613.gc27f4b7a9f-goog


