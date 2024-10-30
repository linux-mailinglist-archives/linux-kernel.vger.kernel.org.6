Return-Path: <linux-kernel+bounces-389601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B79B6ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23FA1C21A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3E218D88;
	Wed, 30 Oct 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esPjuJPf"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319921893D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323757; cv=none; b=F4PKgQrPjBdyMgUAoRoWKpVP4vu4h9JWtstohp+Rp5ZDuApw+nbgOTA7qCGwpvjaypstVeRAmBFeR88D6QYQN3gG00lFMzyRzgf4p+HOR/7z+uQiyKbbSMMhlvJD4yFFTNRyg5A+gywa+XmEhsejcvfgDqBbsAPVT+FwGesIfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323757; c=relaxed/simple;
	bh=omExQ4fXBrGKFkhUOcF2QtIVYwoNMUYC+ZmXtt0yiTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBY0epEsINKODpFOs88XWV5EzZ7ilRTmBGiUm/EHbHrMEIaRoo9kWenYuNnEs7Hul8OCIdpk6BGpbfZNueMMl8JDXoiz1z4+LGVOip1GoT6BaWSLXdH+LncQcNHWK3IGiAzI1TYgAN7ryKuiRcV0Py3uXL8Y7bSgpa4ui6zCXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=esPjuJPf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so202830a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323755; x=1730928555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPKYpsefWRFNcyZV29jn0Qpqfxxh2cQB2XHzcOA2LTA=;
        b=esPjuJPfrX1guNAB7S9K09gT+9+K9OJlBWiboTexq4kTU6SRitLXKyfiPoGNml3cHy
         vqE5Lqvrzi9nku2Pn0ib5VJOAEzI7H7FQmYAo2OSYMR2zUP2DMpbOw/arDUE7hMU32Qk
         V7uSNWpzAlHc2M+TF9xZQ5CLdMn10AQNMsinY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323755; x=1730928555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPKYpsefWRFNcyZV29jn0Qpqfxxh2cQB2XHzcOA2LTA=;
        b=LRVn/3RGONG7qsly1xaqr6Sb5tRHlHbBOOS/J+1jJLAAzE2v/GB2v9zUqAilm3LNGJ
         +YDiF3cXjj3Mbaa/3pAsm3Qz4LlVaSOi5hSt8GyiV0a21D2scVTZbPr4Yy4MOeNo5JWS
         ETyZDyF/lZPHv5hcLFp8f09IW3a1v//jTw/LCKhz0oHLQKzoulpjmlop1Rnr0yIdI9sm
         HUVZF0hRdnv3JYI637PUB3i0j3brWGmKgAM12g2sgLbL7bZdqoWapb7hAa0qjGQwUXYB
         hrNRJwKuZQ5Czk9b+R3r0JS5qgYhYdolvAAzupflja2bYl4lNRKksPZudS0ZzZEFKZOV
         fZqg==
X-Forwarded-Encrypted: i=1; AJvYcCVty4GOlm3y6BCssayFUseGfYV66l6EwshhH0pekIT3n/THv36g6MLPuxJsZra7/x4obO5/S9W9pi9gsN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVjrR+mG9m37Pr7qw8BEV83oBKHdsvTkzHg+x5CYFXkbSOl3y
	OtACUnJj2OMFb90lMIO3F2tkFB7Ce7edRJkrQ85zu37V80ssch3MHr3P/KVWSg==
X-Google-Smtp-Source: AGHT+IFlY/igGtC8ACf1t1ncIipTUUeVB1dKonJWB7PHygnEcbPHAco/gt4xLpUFAPp3zDZE2VDH2g==
X-Received: by 2002:a17:90a:e295:b0:2e2:e2f1:aee with SMTP id 98e67ed59e1d1-2e8f1077416mr18096749a91.22.1730323754798;
        Wed, 30 Oct 2024 14:29:14 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e92fbfa8a4sm2365726a91.53.2024.10.30.14.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:14 -0700 (PDT)
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
Subject: [PATCH v2 6/7] platform/chrome: cros_ec_typec: Thunderbolt support
Date: Wed, 30 Oct 2024 14:28:37 -0700
Message-ID: <20241030142833.v2.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
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

Add support for entering and exiting Thunderbolt alt-mode using AP
driven alt-mode.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Refactored thunderbolt support into cros_typec_altmode.c

 drivers/platform/chrome/cros_ec_typec.c      | 29 ++++---
 drivers/platform/chrome/cros_typec_altmode.c | 85 ++++++++++++++++++++
 drivers/platform/chrome/cros_typec_altmode.h | 14 ++++
 3 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7997e7136c4c..3e043b1c1cc8 100644
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
diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index af2f077674f1..6cb1e1320d6c 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -8,6 +8,7 @@
 #include "cros_ec_typec.h"
 
 #include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_tbt.h>
 #include <linux/usb/pd_vdo.h>
 
 #include "cros_typec_altmode.h"
@@ -71,6 +72,8 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
 
 	if (data->sid == USB_TYPEC_DP_SID)
 		req.mode_to_enter = CROS_EC_ALTMODE_DP;
+	else if (data->sid == USB_TYPEC_TBT_SID)
+		req.mode_to_enter = CROS_EC_ALTMODE_TBT;
 	else
 		return -EOPNOTSUPP;
 
@@ -198,6 +201,53 @@ static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
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
+	switch (cmd_type) {
+	case CMDT_INIT:
+		if (PD_VDO_SVDM_VER(header) < svdm_version) {
+			typec_partner_set_svdm_version(adata->port->partner,
+						       PD_VDO_SVDM_VER(header));
+			svdm_version = PD_VDO_SVDM_VER(header);
+		}
+
+		adata->header = VDO(USB_TYPEC_TBT_SID, 1, svdm_version, cmd);
+		adata->header |= VDO_OPOS(USB_TYPEC_TBT_MODE);
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
+	return 0;
+}
+
+
 static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
 				      const u32 *data, int count)
 {
@@ -206,6 +256,9 @@ static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
 	if (adata->sid == USB_TYPEC_DP_SID)
 		return cros_typec_displayport_vdm(alt, header, data, count);
 
+	if (adata->sid == USB_TYPEC_TBT_SID)
+		return cros_typec_thunderbolt_vdm(alt, header, data, count);
+
 	return -EINVAL;
 }
 
@@ -275,3 +328,35 @@ cros_typec_register_displayport(struct cros_typec_port *port,
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
+	data->ap_mode_entry = true;
+	data->sid = USB_TYPEC_TBT_SID;
+	data->mode = USB_TYPEC_TBT_MODE;
+
+	typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
+	typec_altmode_set_drvdata(alt, data);
+
+	return alt;
+}
+#endif
diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
index c6f8fb02c99c..c71568314e3f 100644
--- a/drivers/platform/chrome/cros_typec_altmode.h
+++ b/drivers/platform/chrome/cros_typec_altmode.h
@@ -31,4 +31,18 @@ static inline int cros_typec_displayport_status_update(struct typec_altmode *alt
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
-- 
2.47.0.163.g1226f6d8fa-goog


