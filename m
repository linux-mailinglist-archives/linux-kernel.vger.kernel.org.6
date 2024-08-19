Return-Path: <linux-kernel+bounces-292997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0519577BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F61F2236B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C91E6723;
	Mon, 19 Aug 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wx1gX1Kn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AC1E3CBA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107130; cv=none; b=AGx+F4dM2vpQ82/zHxZ09Dd9hZyijZLZMxqwWoKhs6wsZwFGrA2SW4WfjtWHQCurzLkuijROMy15g1u6sY9tjZsZF6N7fy7Dqxr4UAvxMzOzoJMxv8e995QFn1P1OXjHLQrVjZnhqJevZAbjL+p/Qkhjqf7cs/SnlvL+EFW1Smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107130; c=relaxed/simple;
	bh=HsvBWQDhlsn8H6zRFLK5T7gdVtCqYrCaBpLaZ8SUzbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF4owlA9to2e7Jk7RU4+2LasvhF7ttgt+c71SPGncZQN5fGwysvGOKxfufj15sLG7QlCatnjRO/lLdUe67T5ew7Dt3Zu651MZ10ozVLZGJ2sqGh4M07wGcjhcOBhpywmHaYGYx/uIhhLglJSYzh29m11Npd/y+mWiyDIa0f7pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wx1gX1Kn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c08b95cso16377755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107128; x=1724711928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QfY7K5G02ZDzjvxUav8uCOJkIdUZDTh+/duvHHbQ8k=;
        b=Wx1gX1KnMcmz8o2FEGEuGCpZVk23STosTETGBaJaCwEIEp/mG2/hxuBuek66I+vxpW
         niLp3JRkvWpcFJ1h0IiXJoEDp/WCh9L9uFSVqN+uqoj5Tt44tTCjFEQvW2GtsyQTnnO3
         Ustxy06Rq4Zal2qWxCSu4Ix5Xwidi5B+Xt+rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107128; x=1724711928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QfY7K5G02ZDzjvxUav8uCOJkIdUZDTh+/duvHHbQ8k=;
        b=KMTLOPuKeP04N4hiJwFFdNupDJsJB+zZ6usEqySnNbhmcLD0tPPOjQ96sJJnISBsHl
         l2sYUmWxgFufQenmou31RxOwlAD4Jy80NUkBwTlVpuNT49cK/h91vDv5EYmyPpY5PA8m
         CvmZGf2HX206EUGbSokSM9YNibI9BJXbMckBgir5C61Ol5++a972p7dI8hf0bklj3L+D
         0u9WhKRy7oCMAQvUKosoGx+yxH85AH73JPm824X8uXPurl65dWQJ8OP7aHHV1PG5oSXV
         MQvCY1gPO9QHO+X1++Oy2YGww6jojBy9PaquI+EeR56e0GSauLLP60vBFKcqXiWj8MBR
         8mzQ==
X-Gm-Message-State: AOJu0YzdMyBxSf0D13atg9ein+9H+IBXnV+nFgGJUNEyMqiXA/T/Zi1F
	HxL+c0qbdL4WQzfTKcUkhIb2Uv2owW/E0QE71li0YD2vkh9PJl7NIxR2G2Yxag==
X-Google-Smtp-Source: AGHT+IEjvBWy5ocnu/ktRfbxtIPTfv9LDJE/ruEiBfpU+qt4ZXlJ9XqOGFL2pdFVOCA7+gyynTnvVA==
X-Received: by 2002:a17:902:da86:b0:200:79c1:a69f with SMTP id d9443c01a7336-2025f1c1077mr18748745ad.20.1724107127977;
        Mon, 19 Aug 2024 15:38:47 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f03758a6sm66871225ad.180.2024.08.19.15.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:38:47 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 05/17] usb: typec: Add device managed typec_switch_register()
Date: Mon, 19 Aug 2024 15:38:19 -0700
Message-ID: <20240819223834.2049862-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240819223834.2049862-1-swboyd@chromium.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify driver error paths by adding devm_typec_switch_register() which
will unregister the typec switch when the parent device is unbound.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/usb/typec/mux.c       | 27 +++++++++++++++++++++++++++
 include/linux/usb/typec_mux.h |  9 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 65c60eb56428..3531ab03bac4 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -235,6 +235,33 @@ void typec_switch_unregister(struct typec_switch_dev *sw_dev)
 }
 EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
+static void devm_typec_switch_unregister(struct device *dev, void *switch_dev)
+{
+	typec_switch_unregister(*(struct typec_switch_dev **)switch_dev);
+}
+
+struct typec_switch_dev *
+devm_typec_switch_register(struct device *parent,
+			   const struct typec_switch_desc *desc)
+{
+	struct typec_switch_dev **ptr, *switch_dev;
+
+	ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	switch_dev = typec_switch_register(parent ,desc);
+	if (!IS_ERR(switch_dev)) {
+		*ptr = switch_dev;
+		devres_add(parent, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return switch_dev;
+}
+EXPORT_SYMBOL_GPL(devm_typec_switch_register);
+
 void typec_switch_set_drvdata(struct typec_switch_dev *sw_dev, void *data)
 {
 	dev_set_drvdata(&sw_dev->dev, data);
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index c6f49756530d..fe7a05dd71c8 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -34,6 +34,9 @@ int typec_switch_set(struct typec_switch *sw,
 struct typec_switch_dev *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc);
+struct typec_switch_dev *
+devm_typec_switch_register(struct device *parent,
+			   const struct typec_switch_desc *desc);
 void typec_switch_unregister(struct typec_switch_dev *sw);
 
 void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
@@ -59,6 +62,12 @@ typec_switch_register(struct device *parent,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct typec_switch_dev *
+devm_typec_switch_register(struct device *parent,
+			   const struct typec_switch_desc *desc)
+{
+	return typec_switch_register(parent, desc);
+}
 static inline void typec_switch_unregister(struct typec_switch_dev *sw) {}
 
 static inline void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data) {}
-- 
https://chromeos.dev


