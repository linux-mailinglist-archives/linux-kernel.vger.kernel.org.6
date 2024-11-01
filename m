Return-Path: <linux-kernel+bounces-391481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578579B87AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D50CB2202F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F086839F4;
	Fri,  1 Nov 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfnYhY9S"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7884535D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420732; cv=none; b=mI4sf9mT+EteDr9euveygBU+n1IW7kaGKpbcQIqVm4jMlbsb8fc2Gs32zUBKK5mQ9BDy3sH+bNksgQI6vwh172ZJaqoRpqJ3EV0Me4Vsq4kiNziPiDhv+SeVRKFQf2hty0H+YcKWJaY5M+HGVu8cAsnerKQIkWnj405LL/JyCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420732; c=relaxed/simple;
	bh=rnWWDnvK/2UdwmliNMd8qjy7ZbPEcXVWLie22T2NTNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkWQWt1DjENJMQUmhUCOWjxkJoXSERhqv+Z8DEJZ8++MNkHctg56DpBbFLQjnIOLoty/C+Kitx/HSlv4EcpXJVe7DPV+jJm4R8Hz8Mln6xcvQSUvmIFXcwsICvbx8AGfhO2VMNzz9+2iwsdCavKPETzfqwPA1RDdnLJbjoEr39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfnYhY9S; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53c73f01284so1826009e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730420724; x=1731025524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hv2lxmvcj3iHqVSo1vO+GpyATUEKN5RREgLh1lW/pKI=;
        b=gfnYhY9Sou7eoEPR+D65Ky/ixI68OSeYc5+QOKMHpCwze6Vd7P3w4Tn5e6SLgaZ6F9
         4/MoZSU5LrUuwezt0+8LhkKxCP+eKYkGq2Iw8e3bIgAgWJyEqHnzDRnhod2HTtPnSfKB
         FhSFoBgT6cwTZqT6RgVgJIrARDiai0wrBUYi+wwkj2CuKpsus3MPYLdOCyKZ/VUvNR4S
         PlJ3wfuY9ab9O6q6cX7TqJO97Y4i9UFHgjarVV/kHBJ8inLRa/Q4Lv13Mh9yxziTmaX7
         0YHryJ5thyTGAGSsr+PLnoxIdMVlMOKb7F+cSaWjk5cvNkkS15oIQZ4FaaELXz+5CfdK
         JPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420724; x=1731025524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv2lxmvcj3iHqVSo1vO+GpyATUEKN5RREgLh1lW/pKI=;
        b=NYJfi1whXAd56vbyTjD354o91QS8DQehiONjWb9II0Sp4XSsuFgO3n0DG10MsGx47i
         Nz30T1ZQDBYQifJI9lXAPaniU+dLYvadTO03yZoPB4tDNlkwhAe2I+XoCxEwjTcbUYDB
         jZWw6OKxWLlBkH7ai61Tkq/H3O/kZu8I1UbLz8oTuGHSLyP4gpyMorP8Y+mVuRoJDMd1
         mSIo+NGOioMUwoaOBOP8ojR+olw7OPprqPBkD8Cc/uw/dyOBojW2iICBq9fLe65XK3ku
         UdAO6FaOE0igKsvzjOwQYjilhrt+rP7KHFppwnh1qc71KMjwODCfZBejL6sBECw/hXqa
         WIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoazA3pppwalT9lYen5gGvt9pG7DEKGn/CGVbsMlm+FZP97MF7ZMvg3RYGlHqPuSpykqFpk0gzGjHn0IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lfm0usBhjAlxFRvQcNxsfFBO8XQqpOb4ftu1srUO2/QgElNG
	Ndd0R/tkaCLmE4oZpJesPKgzg/SGdIxRuIHJ4Eu/skveF4oikGgPHASll2o3/hA=
X-Google-Smtp-Source: AGHT+IEAG9yn1GIhE2YrHT9rrcbTzRT2YsspXsGtFKg4MG2x8/7FF58dsirEGqVuW26T1ugiJs7GKw==
X-Received: by 2002:a05:6512:1106:b0:539:8b49:8939 with SMTP id 2adb3069b0e04-53c79e913efmr2851992e87.41.1730420723969;
        Thu, 31 Oct 2024 17:25:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce489sm371153e87.127.2024.10.31.17.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:25:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 02:25:09 +0200
Subject: [PATCH v2 6/6] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hdmi-mode-valid-v2-6-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
In-Reply-To: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rnWWDnvK/2UdwmliNMd8qjy7ZbPEcXVWLie22T2NTNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJB/iyyoKxhJ9ymVIF5jZKxhY4Q/llakDKMFQT
 BEjedUrIaeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyQf4gAKCRCLPIo+Aiko
 1URAB/0Q+lN9KyT42dXskzxxSyFiafqSlV1SV+VcON3MjaaEaECIjnFoHbPKEDxvle6Xicl7vHs
 h46RF3lrs7ptPTroESb/pvPY/Jj5EK9/dqatVhqiLYq2adABTz85k64UaLF9WIvj1pF54o1lMJJ
 0R4OFGKZEAjC02s31dNE4fIMUbhsnc8JNoP15YRKxjq6AvslRKkkh+qCN5QhotWa9AUe6/FuS3d
 S7bNUR5mrFzDH3QH2n196BQPAJqsuELq2I2VbXoJuXeBSoQHuH5Dlli1/25UfCBLmbABtstMdis
 ux9EbzgijZfuFg2ndroerRXzSm8rHmu9np1KtZBbhZYdo8ju
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace .mode_valid() callback with .hdmi_tmds_char_rate_valid(). It is
more generic and is used in other mode validation paths. The rate
validation for .mode_valid() will be performed by the
drm_bridge_connector code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 181c5164b23192f0b557624d73c6223032b90ec6..c686671e4850a1af75b82995185ffc3cbb22a447 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -442,16 +442,14 @@ dw_hdmi_qp_bridge_edid_read(struct drm_bridge *bridge,
 }
 
 static enum drm_mode_status
-dw_hdmi_qp_bridge_mode_valid(struct drm_bridge *bridge,
-			     const struct drm_display_info *info,
-			     const struct drm_display_mode *mode)
+dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
+				       const struct drm_display_mode *mode,
+				       unsigned long long rate)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-	unsigned long long rate;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
 	if (rate > HDMI14_MAX_TMDSCLK) {
-		dev_dbg(hdmi->dev, "Unsupported mode clock: %d\n", mode->clock);
+		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
 		return MODE_CLOCK_HIGH;
 	}
 
@@ -510,7 +508,7 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
 	.detect = dw_hdmi_qp_bridge_detect,
 	.edid_read = dw_hdmi_qp_bridge_edid_read,
-	.mode_valid = dw_hdmi_qp_bridge_mode_valid,
+	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,
 	.hdmi_clear_infoframe = dw_hdmi_qp_bridge_clear_infoframe,
 	.hdmi_write_infoframe = dw_hdmi_qp_bridge_write_infoframe,
 };

-- 
2.39.5


