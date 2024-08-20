Return-Path: <linux-kernel+bounces-293000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009899577CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A931B242F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4841E7A53;
	Mon, 19 Aug 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkhCjsck"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E81E6757
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107137; cv=none; b=Zb9Z0gM/osMIP0gOzFM59JCHKM8XTEfotTCODjIL31VhJN2niFJgOWHG/oX9QV9PTc9h528dCTOHZiKYudtwCfcknXPQbr4xEXWqAaos9tvPksv0FBItxiWAQODDamwgN+t8U/rV8p09A31qeJRvPRT3blTIafcp7pJosUTy0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107137; c=relaxed/simple;
	bh=w0g28qwx8ttFAPV6ZVJOMX16jfJkNFs/UtJNKWMbmpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp0grhWScKN19kGLPzVNwHIXAhiHmINV/xHJt38cgL68MPG7OA+s7RyHFcatvCmgoIRdMKLqpw5GA5Sm37rIP5QTA7OOsDt0lxuJoOVgaJmELQPHQ2jNfjy+xgiESJrSL1h2UuZvrXg1rRkzjSuSaOheQwjWyXPiB4kRur+c2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kkhCjsck; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20208830de8so26787165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107134; x=1724711934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt5zDRruoKDjEjtxbZ90FeaEpY41huFpHL2b0DQLSiI=;
        b=kkhCjsck75mmX+R9nnoNWwAc9TILHtvcuT5fK6SJh+mViCJbFV4HQu8hJgCJIF/Jsn
         eS2+HGQWp433jdCaDKxj5IdB2/stW3YhIAMVHuTIjECSjZRzbE5pq44+Znjhcb1Tsix5
         r2Eo5gcJR3D3Go0qcpcaWntfIttiM299t04FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107134; x=1724711934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt5zDRruoKDjEjtxbZ90FeaEpY41huFpHL2b0DQLSiI=;
        b=lPhJuPvk5n82ZNXzV0xMIqI6kB/GYXwfW+pLQ+Q/zC13PEe2Drzw7w/qJMkGpICTMk
         qo+s6UOgoBXLus142WPcBB4rBu5R4t7Ju2L9d4lWyNK5zwtONp4cNv/Nkne6U4c/VXek
         6X+4CmAK5ff3x94uuYlCzQ1wiyCcuWoRlG2d1n74bt7zx+VznTRnciMkrBA333uQGWxT
         bWTENbUnjALZVaNtS/M3F6RYpf38xB2s/86kShgrRaYydJgjl/gdgH5R5qKnY7+qK4oI
         H14wnVtVudd9b8mzaanOBpJoFsKOa48Fg8da0U+yJozu1YEilA1e31V7PY4BQV49HU2b
         Qidw==
X-Gm-Message-State: AOJu0YypC73kOBEWP/WFmJermwjyx/EEIf+ggbKXsjgwSX5avwIWWUAt
	glI3LwXf//vx3RXjVFQ/7574BvbQKpmYaC2OqRGetdFuJijLTYxi2ZY1R2g/kg==
X-Google-Smtp-Source: AGHT+IGfZHELLF2y6L1aI/WGPxevrMzKOrLMaAgnD4U9RjeVY5g2VfRdfv/wemc3Z0vA24M/fT5EYw==
X-Received: by 2002:a17:902:ecc7:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-20308af2ef0mr6166935ad.8.1724107134306;
        Mon, 19 Aug 2024 15:38:54 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f038a84esm67020355ad.189.2024.08.19.15.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:38:53 -0700 (PDT)
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
Subject: [PATCH v3 08/17] drm/bridge: dp_typec: Add "no-hpd" support
Date: Mon, 19 Aug 2024 15:38:22 -0700
Message-ID: <20240819223834.2049862-9-swboyd@chromium.org>
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

Add support for HPD coming from somewhere else in the drm_bridge chain.
Skip signaling HPD sate when "no-hpd" is present in the DT node backing
the dp_typec bridge.

Add this support because some EC firmwares on Trogdor/Strongbad boards
don't properly indicate the state of the DP HPD level on a type-c port.
The EC only indicates that DP mode is entered or exited for a type-c
port. The HPD level is expressed to the DP controller via a pin on the
AP that the EC drives high or low when the type-c port partner (i.e.
monitor) asserts or deasserts HPD.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index 3d33f7936cbc..adafda4f128f 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -22,6 +22,7 @@ static DEFINE_IDA(drm_aux_hpd_bridge_ida);
 struct drm_aux_hpd_bridge_data {
 	struct drm_bridge bridge;
 	struct device *dev;
+	bool no_hpd;
 };
 
 enum dp_lane {
@@ -354,6 +355,8 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
 
 	if (!data)
 		return;
+	if (data->no_hpd)
+		return;
 
 	drm_bridge_hpd_notify(&data->bridge, status);
 }
@@ -662,6 +665,7 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 			return -ENOMEM;
 		bridge = &hpd_data->bridge;
 		bridge->funcs = &drm_aux_hpd_bridge_funcs;
+		bridge->ops = DRM_BRIDGE_OP_HPD;
 	} else if (id->driver_data == DRM_AUX_TYPEC_BRIDGE) {
 		typec_data = devm_kzalloc(dev, sizeof(*typec_data), GFP_KERNEL);
 		if (!typec_data)
@@ -670,6 +674,9 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 		bridge = &hpd_data->bridge;
 		bridge->funcs = &drm_dp_typec_bridge_funcs;
 		typec_bridge_dev = to_drm_dp_typec_bridge_dev(dev);
+		hpd_data->no_hpd = of_property_read_bool(np, "no-hpd");
+		if (!hpd_data->no_hpd)
+			bridge->ops = DRM_BRIDGE_OP_HPD;
 		memcpy(typec_data->dp_lanes, dp_lanes, sizeof(typec_data->dp_lanes));
 		ret = drm_dp_typec_bridge_probe_typec_ports(typec_data, typec_bridge_dev, np);
 		if (ret)
@@ -679,8 +686,7 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 	}
 
 	hpd_data->dev = dev;
-	bridge->of_node = dev_get_platdata(dev);
-	bridge->ops = DRM_BRIDGE_OP_HPD;
+	bridge->of_node = np;
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	auxiliary_set_drvdata(auxdev, hpd_data);
-- 
https://chromeos.dev


