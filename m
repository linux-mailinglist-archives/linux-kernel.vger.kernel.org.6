Return-Path: <linux-kernel+bounces-400538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77159C0EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD071F23734
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DD21833C;
	Thu,  7 Nov 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7qvQ3Pt"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4D218302
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007908; cv=none; b=Bq8za4jWtrdeF3V/sGP67MMVdjSxXnW/wlaogxSxLfUkSHPUc5lB07mVDTAuQ7ZZ2ouCfMCgLIZ6YX6/IWssUQeyzMYY5gwlIGLgpuPPy7xoiGhv3tWiwK0nyVltiY8i+/7TiXJcUuEtSdx+iCWjeZs/SIZRAgBECsM3R+FDRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007908; c=relaxed/simple;
	bh=F1pTFIC/STStCNqTkG+Kgg/bMEZb3NhFwcrsacG2V4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx8c5vAyoP/23SsVeU+5gLFDGBHtJ/+WGSFL6ZR8mwDHzyFv1lht18qEkMwUMUthJYg6ZdB8o2U2cFvDUcRgP4E6n1psT4S4NW50Qytt5FsXv7OMH8AbFKb8b3xec8jsU4zpWXITPk5gKILJhD19zeF61iWHGCjm/NjWaJevx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B7qvQ3Pt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4e481692so1237626b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731007907; x=1731612707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHcj0dVpOorLNzt+K3XMiAGRMpCigjM3RXLcIpCRHg4=;
        b=B7qvQ3PtvX9X6yi8e3YvRXZb0AXPDwf3xDOamCQetG0+gOfljQdDbVV+WDzWW1LqtT
         aRAqi95v1LYRbEdM5M1uLw+CKH6pGiO14Pwa3tdar8Dp30Wp1q4DryGCMIgO8eRV2hmp
         vZISuXaUNC+q+oNeziXp8EBdEoQX47Fy2ET9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007907; x=1731612707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHcj0dVpOorLNzt+K3XMiAGRMpCigjM3RXLcIpCRHg4=;
        b=VMsgBY62t+1QWvIWEZQZye248kaSegPqdBdHfyRVU36dtIvnJvQwOLRxLt7xLiqTW5
         BZqpSjA3syFgwuFrY85DQYs/3adANfV/8RIBgAzV0ccQJcGbnWbunplU2JYdhYYDADFk
         8TXmr0M0ov8L6aJM07lRAzYUATDTfPBCVZ4AthZ8GbPV2YYht5zrzlgDALT7RQGAe1DY
         ay6bqbn2wG8n2CKCSH1WkuQdo4OBWM8cVUuRr09E+V/jHmZCrMKZi1vPtJ8tkMYR42Mp
         btEuyyNojJ6xRArmPQvGcej5v1fKFBhH79j64kEMk9AaCa3x7gV58u+Z/fcH8+acM2bF
         r9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF+73sEbra0ZKBbzpeFzSexkb+pDNAW2X9rFJsit3lVMy5A++9RFiQRbyAur5dKlUaGBy0qncOZXZ2Z2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHtgLH+uQ016hJ+bxdG5KhpVa4Q7F3rt0eNPs0lEamToPI/5Aw
	uVkDsRH7axXsVv3HMtcilz+4IEwsXFrO0yrtTkV8lLg0r3YEKC3z+qzmAM2CKg==
X-Google-Smtp-Source: AGHT+IHDevD6Gmfrr4MwmAepRm3599OBUDO0F/CJ4qgD4bU7JNZCnBYFjzrvU6Mh5L/usSA2LFDrWA==
X-Received: by 2002:a05:6a00:1252:b0:71e:c0c:5996 with SMTP id d2e1a72fcca58-724132a3730mr313854b3a.7.1731007906775;
        Thu, 07 Nov 2024 11:31:46 -0800 (PST)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72407a18e2csm2009358b3a.156.2024.11.07.11.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:31:46 -0800 (PST)
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
Subject: [PATCH v3 4/7] platform/chrome: cros_ec_typec: Update partner altmode active
Date: Thu,  7 Nov 2024 11:29:57 -0800
Message-ID: <20241107112955.v3.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
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

Mux configuration is often the final piece of mode entry and can be used
to determine whether a partner altmode is active. When mux configuration
is done, use the active port altmode's SVID to set the partner active
field for all partner alt modes.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c7781aea0b88..e3eabe5e42ac 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -618,6 +618,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
 
 	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
@@ -676,6 +677,16 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			port->mux_flags);
 	}
 
+	/* Iterate all partner alt-modes and set the active alternate mode. */
+	list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+		if (port->state.alt != NULL &&
+		    node->amode->svid == port->state.alt->svid) {
+			typec_altmode_update_active(node->amode, true);
+		} else {
+			typec_altmode_update_active(node->amode, false);
+		}
+	}
+
 mux_ack:
 	if (!typec->needs_mux_ack)
 		return ret;
-- 
2.47.0.277.g8800431eea-goog


