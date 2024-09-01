Return-Path: <linux-kernel+bounces-310089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DE9674C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6722A1C210FF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99393BB59;
	Sun,  1 Sep 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ral7CfPc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79213C827
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163641; cv=none; b=ikb0Wcdz+19203hT8ge6lRwzL7/pnU9j/h8Z7b05V4lpZfFUNg9dlJIxpheGkl70i0lcNQVkjo0L35XJDEDacH90ucnAO8LamJaN6tx6UoL7ahIWuBQCRh9g5BF/KvbWSOen53Rr6TGQhOxPLsiipklSjDYUi3RhvuOqlkbw6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163641; c=relaxed/simple;
	bh=K0vY/b3gdQJ7BbfGBTXVjSZjUjMpNMzLu+iBHhG2UV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvLMUEXHTuHI+MgxifvEppHUux+H2dFezqN//4JRGKXYHDIjZdQx62igtFjCMrDbXvcgcSyzze73hDBthQMevF5zOBWeAhGr8upPvjszrP+O/0dcohAu9q21joc1pWpTKS4n3SImJ5wLHHKVfIQLZI8lUq3EVas1XeGzOGylSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ral7CfPc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4c923a3d7so352523a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163639; x=1725768439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dihu8n2PjcWrFXOuwWbECc9MpTZcbkDtMAPCx56QCc0=;
        b=Ral7CfPcE6I6JLLwGDbrbf4VdCpLJLd5VBeL1JQx0Lv8LiHAedN3a7Bms6VpMfNzWc
         Kl1Wn9QeF8uuenIS2n7WiIOKf84cEXhFlfHq3jMkphgzxHRZKBv0exPUdxrgC/AFPz88
         NcPU+uj3U3hGPuZC5zyaNGTqRdJ9vevZACJM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163639; x=1725768439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dihu8n2PjcWrFXOuwWbECc9MpTZcbkDtMAPCx56QCc0=;
        b=tLnPT7hJrk3f0cPHn4ov1Ms1mwQT5T1/5J9wQL8xhfeSszQ137gBLIdiKLGJyA6S2I
         DbKI6JOGbbt3HbXahmnjwtUC1iVpg/xG1zyNXFbPzAU8aBdfziODEQlKnamNjQcXmE1d
         WZFbVRHltyuvAlTvrLo5Yswqk0RzrEzL2i1/tABWXzVcm+1jkdt0i7i3fFOc8GKT/OeW
         SCvGSWhy1uM41T2N79IfGicEUwqHtrxbNJ/6D2awA9F5MBhr9JUjhBkTvHIZk0FSxSJL
         fRC/3PCyi43GWmZ7NSXKNP/9fM93sD+X9msHmSA7DpD7ji8IOk6j8YCfSA6pI0vm8W43
         veCw==
X-Gm-Message-State: AOJu0YzEcrjjMZL8iZe03efYfS6gBplLBHXwzUPLDlt47XH/KicJy+EM
	N6+3t2PLmFnTsX8uttzdogEKZeVVlqvPFcA8fHoZNpTXFweLBmlNgBogH9Rxuw==
X-Google-Smtp-Source: AGHT+IGUB6+86RHnw08wq757NS4DSJb/B5ixBOuB5HoLx7W2xOHzGQ0pL/7XrZLrWwYk0S+0GfQauw==
X-Received: by 2002:a05:6a21:3213:b0:1c4:a8a6:a85f with SMTP id adf61e73a8af0-1ced62a2b24mr2056687637.30.1725163639331;
        Sat, 31 Aug 2024 21:07:19 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d8aba505bfsm1381042a91.8.2024.08.31.21.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:19 -0700 (PDT)
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
Subject: [PATCH v4 08/18] drm/bridge: dp_typec: Add "no-hpd" support
Date: Sat, 31 Aug 2024 21:06:46 -0700
Message-ID: <20240901040658.157425-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240901040658.157425-1-swboyd@chromium.org>
References: <20240901040658.157425-1-swboyd@chromium.org>
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
index d2832e6481d7..52db36aa190b 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -22,6 +22,7 @@ static DEFINE_IDA(drm_aux_hpd_bridge_ida);
 struct drm_aux_hpd_bridge_data {
 	struct drm_bridge bridge;
 	struct device *dev;
+	bool no_hpd;
 };
 
 enum dp_lane {
@@ -355,6 +356,8 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
 
 	if (!data)
 		return;
+	if (data->no_hpd)
+		return;
 
 	drm_bridge_hpd_notify(&data->bridge, status);
 }
@@ -672,6 +675,7 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 			return -ENOMEM;
 		bridge = &hpd_data->bridge;
 		bridge->funcs = &drm_aux_hpd_bridge_funcs;
+		bridge->ops = DRM_BRIDGE_OP_HPD;
 	} else if (id->driver_data == DRM_AUX_TYPEC_BRIDGE) {
 		typec_data = devm_kzalloc(dev, sizeof(*typec_data), GFP_KERNEL);
 		if (!typec_data)
@@ -680,6 +684,9 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 		bridge = &hpd_data->bridge;
 		bridge->funcs = &drm_dp_typec_bridge_funcs;
 		typec_bridge_dev = to_drm_dp_typec_bridge_dev(dev);
+		hpd_data->no_hpd = of_property_read_bool(np, "no-hpd");
+		if (!hpd_data->no_hpd)
+			bridge->ops = DRM_BRIDGE_OP_HPD;
 		memcpy(typec_data->dp_lanes, dp_lanes, sizeof(typec_data->dp_lanes));
 		ret = drm_dp_typec_bridge_probe_typec_ports(typec_data, typec_bridge_dev, np);
 		if (ret)
@@ -689,8 +696,7 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 	}
 
 	hpd_data->dev = dev;
-	bridge->of_node = dev_get_platdata(dev);
-	bridge->ops = DRM_BRIDGE_OP_HPD;
+	bridge->of_node = np;
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	auxiliary_set_drvdata(auxdev, hpd_data);
-- 
https://chromeos.dev


