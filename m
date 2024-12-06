Return-Path: <linux-kernel+bounces-435803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A429E7CBC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB0616C8A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5D215713;
	Fri,  6 Dec 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DPwSNaB0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD3213E74
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528334; cv=none; b=UT8VcIvJmBy9aT6udFIQk557IBwUM0X4yd8+oUh7bUesvmezj0AYsLceY0YnTlXMS7Y227/am8gcVUKgHjcGAqxzGSVVoq7F2+dEHBakbHIHY5iRkSZt4EiBeXB6ZfjY0XxiAzWZiT7hfQR1CuzuLbgGHyD6rLpRDQfcF1YuVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528334; c=relaxed/simple;
	bh=6+NyEvL6eAZBPFSmY7mhSC2CsuuggjLJwPgnKwMrMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU1gbLOxySc2s3BMtOocj4mgKWV74ymXP8D4fyBrbP/vD9sON9N1bU3Eq/8ifaD8WJAVxmV14oZCJruPLdrdTxIkB+klk80GA8+724Vw1EbmGav4mxW4Ec19wyCNjafJ2X29rrxBua6Y4e0zerg/rNgSWpfnI2keHfb2uo9s4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DPwSNaB0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725abf74334so2252038b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528332; x=1734133132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cXxXwV88rKJWL8fa6OSxTwQgplbClYmPHZMXrsR3gI=;
        b=DPwSNaB0gyrQBqYinkChfZrOzrdPAbbX5H5qjmwvGY5iQ2LvcjNnbtfGwa/vC71zJM
         jyiEPoCAZ7tZkPOvS3HcldaqscaJDGkDIAuwFVMQXcBAMg6HyWMEXwwzKYCRBNA2Dl1P
         IONJEDSxZNtYgXC/nIQ2CkaUZrFefMhATZrKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528332; x=1734133132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cXxXwV88rKJWL8fa6OSxTwQgplbClYmPHZMXrsR3gI=;
        b=pRFW+4Xl6H7TBJEY+WiJbie58x5PJYFAVKWq7KTR4IwGVjh61mphKk/EcZe5T06Ow0
         21FKvGE0RQLUqwhG5N8K6p3p6Std+dJaslcHm1Scy3ykMUt1F7iB71NR50f16k945eZq
         WswQvVAITa36L8dq5XqDgweXYRoExgjaJU1moOkbqt2is7iy0XHhfpqBSvpSiBG7LrYY
         pEBOTqphBbbfyDyNThmuMFDifrqJXLEcd+BBVGnNBS7JAl5LXhAOPNq746J85zFW5MGY
         ByrMvRG8mCmPQLWV2SqmrhPLz/VvOoTN6ykgmtyCjxZZWaO3kBqG6HNYSAtj8IAIJsxW
         2RTA==
X-Forwarded-Encrypted: i=1; AJvYcCXtLPHHAondQLYM4I8JyJ21r/Fc98kSRecKLldXXiHNB41tA/KfjW0+fKjfTpp1GAaR226bZyVtqHZuwLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RdmWt1a4tllq9t/YX0EHeSkMnwsOusygE5ZEP9bTMrHCTdRJ
	Q+aQMADNz6GALk3jt8ob8eSK1zk/voRNT+Uq5SOJF12qtUq2X1RzpHHO8ACQsw==
X-Gm-Gg: ASbGncueSJYSoKothJJqk7uHZU1qwV28PqDt3Wiaq59VHYLrdMm4Mjf3kDd8uwZe37S
	HUg/tAe8hQQ+56SblYdAAkC27/xW18AM43QvAafIE7XRU87Avf6WkusqUgjYhO48kqhbwE+ycmp
	L0IPh+MFZddus0uZn9tOXeNlvHfDIKisOKkeV2U4Vu9jS5jMYUXWJART+Lec1gZEJVvUqNxhdLC
	5zAE5nUdfSn+qRqpDBkoKPayUf4b7ZUwz3wp2pA3sBMPsl9vKg29g4VycLUfpxGONfG3Efq21Cq
	dH9J1RD2+tt2S8HrTMED/gnl
X-Google-Smtp-Source: AGHT+IH8xcV7cYwWQtC1JOe0BM7HHwigw7bQUPK2dXGpE1ZFhAik0USRvFsiz7kjlqwsVcZvthr8sQ==
X-Received: by 2002:a05:6a00:2d0b:b0:724:6cd2:cdcf with SMTP id d2e1a72fcca58-725b81f2d33mr7077111b3a.24.1733528331999;
        Fri, 06 Dec 2024 15:38:51 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725a2cc52f9sm3469025b3a.172.2024.12.06.15.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:51 -0800 (PST)
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
Subject: [PATCH v4 6/7] platform/chrome: cros_ec_typec: Thunderbolt support
Date: Fri,  6 Dec 2024 15:38:17 -0800
Message-ID: <20241206153813.v4.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
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

Add support for entering and exiting Thunderbolt alt-mode using AP
driven alt-mode.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

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
index 984f843ea7a2..3eef4b5c2f60 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -238,6 +238,7 @@ config CROS_EC_TYPEC
 	depends on USB_ROLE_SWITCH
 	default MFD_CROS_EC_DEV
 	select CROS_EC_TYPEC_ALTMODES if TYPEC_DP_ALTMODE
+	select CROS_EC_TYPEC_ALTMODES if TYPEC_TBT_ALTMODE
 	help
 	  If you say Y here, you get support for accessing Type C connector
 	  information from the Chrome OS EC.
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0f3bc335f583..0b87be52e1db 100644
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
index bb7c7ad2ff6e..4db655465a86 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -8,6 +8,7 @@
 #include "cros_ec_typec.h"
 
 #include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_tbt.h>
 #include <linux/usb/pd_vdo.h>
 
 #include "cros_typec_altmode.h"
@@ -70,6 +71,8 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
 
 	if (data->sid == USB_TYPEC_DP_SID)
 		req.mode_to_enter = CROS_EC_ALTMODE_DP;
+	else if (data->sid == USB_TYPEC_TBT_SID)
+		req.mode_to_enter = CROS_EC_ALTMODE_TBT;
 	else
 		return -EOPNOTSUPP;
 
@@ -194,6 +197,56 @@ static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
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
@@ -205,6 +258,9 @@ static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
 	if (adata->sid == USB_TYPEC_DP_SID)
 		return cros_typec_displayport_vdm(alt, header, data, count);
 
+	if (adata->sid == USB_TYPEC_TBT_SID)
+		return cros_typec_thunderbolt_vdm(alt, header, data, count);
+
 	return -EINVAL;
 }
 
@@ -279,3 +335,35 @@ cros_typec_register_displayport(struct cros_typec_port *port,
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
index c6f8fb02c99c..810b553ddcd8 100644
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
2.47.0.338.g60cca15819-goog


