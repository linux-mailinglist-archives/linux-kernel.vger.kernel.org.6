Return-Path: <linux-kernel+bounces-426071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE889DEE79
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE10FB234C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641A1531CB;
	Sat, 30 Nov 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4XYcGQq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777B148855
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931576; cv=none; b=di2OiigLW3w0U8rtpBdBn1WVYtHujNlrNhdKXYDe9NJrOj76+WPXFuV3Mlu2W0ISwB3vORZeY7qAXRf3sLD6Dovgqn/DZuznJGG6/GNglSYqjP3y5QIJNC2IFhMH58vnh28mJfqQ/yzPrcZ3ct4BU18uPere2UjnCKsfxYNmE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931576; c=relaxed/simple;
	bh=V6uHu+T4+xW+xwMuVx/apScXj6PwN9KdCvTiBY/zzqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAO3n3pFdg5rxTxwzQRi7E2ZUEt+MuT73KDuxKtFBhrs2UMuLfmORRMsiJDhY2jiVVLSZqyTXF+9xTqecd2H8BtNNhTGYhWDyH/z3gIc87NMNIb0GO9uFkzAos9IV1eME9YYdpPup9T7gluj/yklMY+h8fJwlgBg3bv8vZoAPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4XYcGQq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df1d1b726so2909614e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931573; x=1733536373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi+JDxO7zFRVUVNShSHXAVY8nfszGwV4/oGBGiyAqww=;
        b=x4XYcGQq6Qa3gP8pkDUxhmdP9HCVNiMDc9zguuvlu5JWh0reL8KsGJ0tzPFYTKxflF
         uwkyEGpoc9hffFYC6u3oE/NeD7RqYZNRU8D3fFe9a9Mauc4zeRzt0dE+vy0BsIi9cKD2
         fIsCLpFRUhOO2qoeYdWobcRM4ZHQc9XkaTcYzze8Yrr+8kJ4IrEtvNdpHU+sfkI+YmM6
         D6UQixwCWsHYyEZVI4wRcs+TyTYIYYBw/sew5uSDxc3ZyRsWlpHzJnBMq9E0HH7Yr4u3
         3ZuchVCRHZvUGIafNUgDL/goInKqBN8e7+jBg0sb5gMoaWmkx9w56CnE21xl6FrlcDMd
         cHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931573; x=1733536373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi+JDxO7zFRVUVNShSHXAVY8nfszGwV4/oGBGiyAqww=;
        b=YXrdsXcQvJqp89erSfXTwb0uDmUOgdoAb/qW8pMQ+2gM92xGndzU+e0WgNeP5sEHu9
         /9TJblFQt84Gn83fTJhru2fEerw7iz5q8ZnG1VcZflMNSnyr0TqAkrwJL4Cu2WoSYg4A
         rUHqLx7aoZufKya5sj5XKfIolp+r7omKamhEamvebSrF/lQ2RdNb/aHR11W1k65cY5PM
         JxGn1xVmlVMM6jSkpvlqtQ02unsQCz+pdeePMXKtIDcLufMR9p/JQfdj+IyCy6yCWNyo
         NTWydw2SboXD/SmLdVR9gICOMRo9InVFTseg4sD94HWHSv3yQwn+bYZ76z8Vm3KUuqjh
         RZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0Zx4Q2tvFumps1RsnPePgX6GM7fKNtY5KdQ9hE+TjKwxD+63Ae07dh83yv0rr9QCmRxzwZ9KxorJGZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfy8ZnNi72YJ3fbA9ryRR8mcxZIZYnsrG40klVCS9zjAYiY/jH
	P6S/1zBI4kxXznSyWRswiSGBMONfzBDMGZLY2ZjJhYc9YI+18DpOnWAllpWa/zw=
X-Gm-Gg: ASbGncsyPuNyMjHwWXqLkrhJv1zgMQGemxCIOfyb+gt0WtO7Wvmpws+Ga6tzMqAzkK5
	P76SHYITbVz/egsEZwePr/saliwIfYZrh8jz6DV989gJEBv1Kst20K27dVv3EaLyou4hlbaa2nN
	fcsic17MX8AUYG3GMyYTqM8qaHe6FwiIhf5qKELj/t3KlvchAB/rhQ3MPe1ADCPhNbbkPLz4WFr
	JKwIhxvtzjuDAQRSp2WUp0bcRWzz83x43JMTIoLv7g1I34b4pZiRvaTnQ==
X-Google-Smtp-Source: AGHT+IHEYj74nFURYbWP3Egy7gi3UHFs7eYCLy23sHhESjuboylGOmyFITklL7Me2c+2Ybp446w/LA==
X-Received: by 2002:a05:6512:2309:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-53df01046eamr8488039e87.42.1732931573080;
        Fri, 29 Nov 2024 17:52:53 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:32 +0200
Subject: [PATCH v5 07/10] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-7-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=V6uHu+T4+xW+xwMuVx/apScXj6PwN9KdCvTiBY/zzqA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7pX/oMCB23f3Dl28T72F5rnzAu3MnESPs7t7BUhWRXw9
 1Lk0aJORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAExEYR77/zqjCu2Eb83GP2fZ
 /I0qDXeMSL5+ZYbQYbd19606OYpCjUwuXJVSWeoa81rz0QYu07WsVn16WVMTGYueu147XR13uNh
 T6nVdSniXWePDn3mXvlrKHK50mhW0c3t02pUchYWCVXP7qrKitdadmLXiWI+o8cfyYlXF02Eyly
 7cTX1bkJGqtlrte/5e5WlWG9zv7gkRnvf55p2Lfx++Pbnlt5WNd9oMfjsnb9ajO+81VjS/XP3dY
 SrHTqfmxbM9vTmF2xI8hFOWLHGOvlCeUKheLD/vQJrwwT1xHc6L65eUXfbzuar8Yva7pbNVep+6
 KVt/9+9yTnXT9hR+d2mlSIHMxvcmVV+3q8leDvuV/cYaAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
bridge in the bridge chain. This removes the need to perform TMDS char
rate check manually in the bridge driver.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 320c297008aaa8b6ef5b1f4c71928849b202e8ac..512ced87ea18c74e182a558a686ddd83de891814 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -18,6 +18,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
 /**
@@ -299,9 +300,22 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static enum drm_mode_status
+drm_bridge_connector_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	if (bridge_connector->bridge_hdmi)
+		return drm_hdmi_connector_mode_valid(connector, mode);
+
+	return MODE_OK;
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
-	/* No need for .mode_valid(), the bridges are checked by the core. */
+	.mode_valid = drm_bridge_connector_mode_valid,
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 };

-- 
2.39.5


