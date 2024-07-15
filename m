Return-Path: <linux-kernel+bounces-252084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CE930E27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C281C210D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF01836D6;
	Mon, 15 Jul 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOVXCOnv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B2184120
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025204; cv=none; b=Pp+udosxUJUz9yVQ32jrhbeJqAD6+0GiM6DeErfspOD801Cy8pgFnCImaxakD+A3reYJmfVfHSNrlqhrYDnFVncKTmNq4QfJ6R+qGUGZvPflBpTiRnzUMDdTSDae0RldD1N0+Z9CcaRCdX1nz3eHDxt27CsgkyaSfja3aKHGEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025204; c=relaxed/simple;
	bh=RSj/GL8gZoJdjbJyGkKZjzhqoxsZ6wLfYZiTk6CBwIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQuBtEQL0Ed/YFAQ1/yGuhc2qFovw/4hVEciPiMZzcaEzS4Ms7R7ksmWRisWEBSuDlkHjP9VXcoeG1Rj16+0Rtymroec+U0OArec2eGY+fKuP/7EI1b1/ZGjOYvlbIiUztTv7nnJIL8niMVpkIJiURJEofwt5b5YAGFs78J1iqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oOVXCOnv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9944764fso4581464e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721025199; x=1721629999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cowQ2MZs44p/k7+ocTvDEJFCYMvt/Fw411UD/yRIuZk=;
        b=oOVXCOnvly3CsPC/YUEjTxCI7dPrrRw9R4nfNIqpobXxlYG+nALW+LBuHP8dc6ZiGt
         +xY1YVapTMZoQcFUQIn9f9JVEg4FKz23PU+/bAvj8n2U9d4rqHYHltYq7Bf/kxzDKxZh
         GaZq3vxq8c5rv+npDtqcDfpW0dm2KYO27eaPYh7p7PSl/Wbs5EhGQlajuTWyudXmv9VZ
         0wbaGgO7f0bbVmPo25FSCvTj7EOFr+7whQPT+omPKWtrxGKTkc9+JXVJqjjDCsizToV0
         assGIbZF+Ju2NAQQGnM4JjFWfGK7trp2B09miGDjB5Twc1Dp9mVlCQGTWpuUFb3kVHLZ
         pu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721025199; x=1721629999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cowQ2MZs44p/k7+ocTvDEJFCYMvt/Fw411UD/yRIuZk=;
        b=XsdQKwlYK9Eefo0BVFvdBXSXS1S1aoQirwbYifVFeL43sHaES+j4iJKcmh7jlUEqLn
         eU8nklyJIUdu1qpIVPMDchpSya0LN7qnPY8/nMIr6WkU6qCWqMCuZfqYywZoUIz1NCcU
         xToCUEs5kscGKKQ6iiSjIDREgy/xN1rlLD+GKaBFL+YBywJTIcmted8iAyA16zwtgFnY
         GNk+8aCUDI3yqbDZbBO2tY7VWPlMhPEM0nZEm8ph6a66zS6RAamPBAXWLbSohOqhlJ22
         /hsD1eO9cs3869tMLkSuaZuBuRn6lkCrHUE9k3rvdhwWE08DW2waWpU204i0tufv7xlu
         rOzA==
X-Forwarded-Encrypted: i=1; AJvYcCViLr8mOma9Njta8nWe432BsxRDtuAms9xsF6EdWi3qcVt/Aevu6rQQhOKzVczzN+0EpJR104yk8OHJk+Pzh3Vv9V8NLidU3AtAgecM
X-Gm-Message-State: AOJu0YysJwTChFiJogdI/cJq+19g97AF7nPOV0ZkiEfk7X+FmYtWP0YQ
	ype7KpTAP9RMpN7TEYP1Gb3EVAFx7yzVXIqAQYcvjsDoP8CVql1WfDCsjwqC3Ys=
X-Google-Smtp-Source: AGHT+IHap4bfADCMMdp+9/m6hrqUOR1BGeplBSV1y4IBIjYw8gKprZmmugJo1TIVKbdLpOyzSTxWyQ==
X-Received: by 2002:a05:6512:789:b0:52e:954d:3594 with SMTP id 2adb3069b0e04-52eb99cafa9mr9724397e87.52.1721025199105;
        Sun, 14 Jul 2024 23:33:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e188esm743543e87.47.2024.07.14.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 23:33:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Jul 2024 09:33:05 +0300
Subject: [PATCH v4 5/5] drm/bridge-connector: reset the HDMI connector
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-drm-bridge-connector-fix-hdmi-reset-v4-5-61e6417cfd99@linaro.org>
References: <20240715-drm-bridge-connector-fix-hdmi-reset-v4-0-61e6417cfd99@linaro.org>
In-Reply-To: <20240715-drm-bridge-connector-fix-hdmi-reset-v4-0-61e6417cfd99@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Edmund Dea <edmund.j.dea@intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RSj/GL8gZoJdjbJyGkKZjzhqoxsZ6wLfYZiTk6CBwIc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmlMKpemzG8GiCsYpbPT9S1Ojj9SgO+0jwg1X5y
 9EPZPxXbKOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpTCqQAKCRCLPIo+Aiko
 1RfqCACEDU19Qkxz5DVPRYkK7fDdQdzCC7Ex3ixU9rJztEg0cYygQQ7/N1TTSfpbHd/6dnXTQqr
 1EgcPH6TE+tH9eXXMheeF1OS/bhTuKARxi2wWkdHQUGUtyMj8mcHkHdrusMxtne+ZhGO/FIJ2xq
 Rbf1R+hLTh4esRtay58HxYpazr137omA9Gw8f5vvDWH+/fN0hvMicz3Eg/9i+0frpzphu+S7qVc
 FVZeAPpLqP6gaJGOvTRZRx1keGxL2vn+faVwbgsOyaVmNQjvZ71zl4YXnlV8oqwC/teMLyW6umJ
 AqBRzDQGS3iL3PzsMCTRPynE0PUtU41rhweY1t1X4Nq8Idxh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
IGT chokes on the max_bpc property in several kms_properties tests due
to the drm_bridge_connector failing to reset HDMI-related
properties.

Call __drm_atomic_helper_connector_hdmi_reset() if the
drm_bridge_connector has bridge_hdmi.

It is impossible to call this function from HDMI bridges, none of the
bridge callbacks correspond to the drm_connector_funcs::reset().

Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI connector")
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/Kconfig                |  1 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 8c174ceb0c4d..3763649ba251 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -15,6 +15,7 @@ if DRM_DISPLAY_HELPER
 
 config DRM_BRIDGE_CONNECTOR
 	bool
+	select DRM_DISPLAY_HDMI_STATE_HELPER
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 0869b663f17e..7ebb35438459 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -216,8 +216,19 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 	}
 }
 
+static void drm_bridge_connector_reset(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	drm_atomic_helper_connector_reset(connector);
+	if (bridge_connector->bridge_hdmi)
+		__drm_atomic_helper_connector_hdmi_reset(connector,
+							 connector->state);
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,

-- 
2.39.2


