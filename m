Return-Path: <linux-kernel+bounces-339408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBC9864C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB83D1F252BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0884A2F;
	Wed, 25 Sep 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeItgtvB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703F4C618
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281520; cv=none; b=EWTpzquot9PosndbwJJhTZWPBSV69Dr0xvQ3DzwCyl6oYAsRkgIBK3akxs6ixLt6qfmyYoABFPU9xfB4LeUy6L/vqVgn99JFxZgUY1ooQeB8fjx+Xc4nQ09TYfrmhRZgTYFzN5lG8jzurKe3j4VZrFju2XMBC8itbuUQ7U1Vxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281520; c=relaxed/simple;
	bh=B/aYBTa60A9g90oBOpffUDM7pG4axnORwfirwaLuURI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEVwli6o40fACbZoACDJbWd6+6M1B309FrVvuI3FA6WH2gi27q29TIUajH5ME7bY9qCTi55e35jDHJqJKqjsPPMrWfNS2PZRIoN0+JmWm9+/PFGofFZoSAlT+hF1zfr8j+VAT8f1+3qawH7yoeNnEFTU96zgaKENohr/Gq7lBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CeItgtvB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b01da232aso676285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281518; x=1727886318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li8IhGzdBecmdmZEMsV/NksrzGw4yHw1ja6oPqU+zCY=;
        b=CeItgtvB2mVjg7AZzpg/MNIpruRwGVF5e0cMpKNL9fG05Tsl8K9HdONfCshVW6ZiHX
         K9jUywR71TygRNecDH9mhFmhI/guIShGQyYELN0gJUCuUcSssSHOHBhg1A1oVUK1ZuMV
         WF8UylFgWmKR3HhDjA5nnwd4uWaTScvqiHa0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281518; x=1727886318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li8IhGzdBecmdmZEMsV/NksrzGw4yHw1ja6oPqU+zCY=;
        b=DGj7pDdq8QeyRKRFVKViAmLPArdoCIbPg1wAg86cmcrefYZaGfSXUvC49puXkw4Wox
         +S9MrdUA0HCcUMMU2sqg6Ny6b/w15GEvqNrear1ce7rGUzJ+Oqgx4zO709Mhtwu2n8++
         ycAJtfiZ2nPnjjdiyJGAiz+0iCrFXhIgHYnswTwGOxAInSuGuKNAZEq7Lg6xY8OgWCz3
         H+Kf786xw15r9e1qxwdnn8JFoCoWiubyr1dAcjSC9jKm6OZuOKGCs/Squ3oktNPRH7E6
         kst06vOOyAEffYdDufHk/0uJilbXByQ80iGeasUuT1GqfSroMmBYiuRzc8nP4pgsGVDm
         FUtw==
X-Forwarded-Encrypted: i=1; AJvYcCW4llCOqjvxtcsedorMsMefOTQgXgCyf8AzKEKIPIkz4sHP1+G51Dh49plyGHuCvuKvnFOBfffO19M+TKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOcR9thVySAkQQWii3VPf7Fxda3lX0dbESq2B7TqS+fHFjUvS
	D0evAoHANhyB6L7n5ZDnJCoJL6H4g8z8cQi3i/QMvcuC1x5bTr+455zgUEip/w==
X-Google-Smtp-Source: AGHT+IFMT5cF7Fy101YbQOPVWEhNSeZB2W0BjXha7Z4XNH7qjSAj0pLjLalziUhJFRR8caZAYC5Zfw==
X-Received: by 2002:a17:903:28c6:b0:205:841d:1221 with SMTP id d9443c01a7336-20b19c6f3f0mr1932145ad.24.1727281518406;
        Wed, 25 Sep 2024 09:25:18 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20b0e4ed6c2sm7061535ad.271.2024.09.25.09.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:18 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 3/8] usb: typec: intel_pmc_mux: Null check before use
Date: Wed, 25 Sep 2024 09:25:04 -0700
Message-ID: <20240925092505.3.Ib7a83adb069df1cb0a40dcddff29618bf3255700@changeid>
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

Make sure the data pointer in typec_mux_state is not null before
accessing it.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 56989a0d0f43..4283fead9a69 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -331,14 +331,19 @@ static int
 pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 {
 	struct typec_thunderbolt_data *data = state->data;
-	u8 cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
-	u8 cable_speed = TBT_CABLE_SPEED(data->cable_mode);
+	u8 cable_rounded, cable_speed;
 	struct altmode_req req = { };
 
+	if (!data)
+		return 0;
+
 	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
 	    IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB))
 		return 0;
 
+	cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
+	cable_speed = TBT_CABLE_SPEED(data->cable_mode);
+
 	req.usage = PMC_USB_ALT_MODE;
 	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
-- 
2.46.0.792.g87dc391469-goog


