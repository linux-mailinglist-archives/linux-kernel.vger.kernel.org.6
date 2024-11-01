Return-Path: <linux-kernel+bounces-392045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110019B8F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345D91C243F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC40194ACD;
	Fri,  1 Nov 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7ZiPqWc"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096219E806
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456368; cv=none; b=aUqOsbd80kaY2T9dppmOn3DOKRKM3canT7r4Q63LG9Ylbbc0RWpr3nKRa26X8GicQymljtxfaNbIUKgiP1yPyM3WaACLTwMzYFHKsdtV8ibCHmJ6nXgC9UclpLNdT0S/cBxah3cV7qqMx2FraOcwsdKZtMeBFUi5EYEuzr7R4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456368; c=relaxed/simple;
	bh=o8zF22Q3lPENAEm/ZYvkUJMiXNxulV8OozkqO4RXQvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnNQmIf28w1sUmrTK9YrWM4GhIlwyPckcScG25F35zmfgFix48rNGYFZdwVdCH62+QErXfiOFtBd/0L+RtCkzV1H3XcqUGumCJxqqpsfPFYcQILWWKJI0B/jVGV/qnY0g1Qh2+F+fED4HTr84VWaerlJtZ1Pq2MaQxvezGnjO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7ZiPqWc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso15706831fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730456365; x=1731061165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGgjAKyLcDyP//XG7JzBSUmff5/dvBkAhC31JU8OV0g=;
        b=a7ZiPqWc+zdFthvpEz6+wy64DTkHrjj8fGZM90LIxtZh6gCZmdUYB9YA4sERZ4FDXC
         7H34PAmcZVvXY07ERRTTSdaDccfbSfVzDRgcgN5DFvGBJ0Yt0I2ha2p3Q/5mFuAj6zwW
         4K5Iw1xIIkHtlubAeH8iQ0A4GYC6gq0rEfNnH6cl0nvd/6D/+J0X35sv+9RhdCmXdh5g
         2hlYH3af/kD0v8ae29HP6BPdG+YjTCGsAUxdQQOi/6eJR6Kqw2vjXMuf1J74bpf+hMGG
         KnKoVXm8X7nXMau9p8reo++kQTctJhFnZ35FIPWzFlUXSnLkPIUJxJxEU4j4yUkpWKeq
         Gixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730456365; x=1731061165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGgjAKyLcDyP//XG7JzBSUmff5/dvBkAhC31JU8OV0g=;
        b=ve/e220s8QvqmHQ0v88mMlWcFXpOJZasgJFM2dDgFxgLoVqanOXTjfJV/DEhwQ51PT
         UI8iesJMcVQu7E/QClbGXDvqEAS86UP8sPwRTAtNKyNr4UbcjNaCrr1n0WCZxjw/9Ekn
         sxbSKjqw0fy1UrHnjOJROkgW5tx3+QGF5iMeREETldqb18Mnih+nDIQLEnsn5UCkIeLK
         UPDz1V0sapmA5hAK2ysAnTLXOf2TCSnYi8/sQC9TSgJLw9U8a/O9Bo8Q1WuIDFy8v0F0
         9+2V6v7tZZoPZb58+VhMxAtwz1/7zztPXB2JtpYSHbMBmtWMaobERPh8yc4HpvqkwdrA
         EBbw==
X-Forwarded-Encrypted: i=1; AJvYcCVk9XvLgyZeVzHOYLQ/qLHM1Kpa8DOR7WdvizU6ft5I2rct1zAAOKkptQ9O71Y66T1JVbMFoh4NeeENsPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpqu5s7bkpbmuMcbHbtY1XvmnmA7lu97vaBfkJtEC9mMP+Fz2
	CLXOeuzxtTSf8jLi0sHdwaHl+4it0hCV1/pmr5xKUEL0AEZUUVp4THoAy7FH3xY=
X-Google-Smtp-Source: AGHT+IGrg+MWNfrCkOop6SzsPvLBRfWp/DqEaW2dXOspXiW0SLaKOKmN4JT+lZ8wzfmuDxerrXaXhA==
X-Received: by 2002:a2e:bc0b:0:b0:2fb:403c:268b with SMTP id 38308e7fff4ca-2fd059d28c8mr58307211fa.34.1730456364657;
        Fri, 01 Nov 2024 03:19:24 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef5d6ef4sm5197031fa.48.2024.11.01.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:19:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 12:19:07 +0200
Subject: [PATCH RFC v2 6/7] drm/display/hdmi: implement connector update
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-drm-bridge-hdmi-connector-v2-6-739ef9addf9e@linaro.org>
References: <20241101-drm-bridge-hdmi-connector-v2-0-739ef9addf9e@linaro.org>
In-Reply-To: <20241101-drm-bridge-hdmi-connector-v2-0-739ef9addf9e@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o8zF22Q3lPENAEm/ZYvkUJMiXNxulV8OozkqO4RXQvk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJKsZVEQyQuPw+HstvVa+ywD0DzMiBOlZfnHVE
 KF1rHV9ULuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZySrGQAKCRCLPIo+Aiko
 1fMQCACgMN9amTdAcyKL+du1jF5SGu+FJ0bpmOX/kii6kS9fkFmW3LameFMLXWArrtscsYb0BjH
 aDoCZmihQEAP8h2xj6l8plf0wv8gfO6BMDn/iXRyNNPoDy+V6aFvFwpm5tVCGyHHghH0z4obR+V
 pE4Y5Osy7/1lliErcrZZgpCgoOTgIRlGiL1BafbuEgz+0qG5wFZfQO0mcz6c876TN9ml+Uo/ezl
 tVuxyHU4FxXr/WsNhnV2H5HimCa55xnzoLoHnAU8c1tX5S6FcvR9PR1OBbVO9RcyouOgv8Ky/Id
 fu2VYo2hsea/slZ4EpRbcAWw1S16Zcmcf4ZKPK+rJq80q2cX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The HDMI Connectors need to perform a variety of tasks when the HDMI
connector state changes. Such tasks include setting or invalidating CEC
address, notifying HDMI codec driver, updating scrambler data, etc.

Implementing such tasks in a driver-specific callbacks is error prone.
Start implementing the generic helper function (currently handling only
the HDMI Codec framework) to be used by driver utilizing HDMI Connector
framework.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 56 +++++++++++++++++++++++++
 include/drm/display/drm_hdmi_state_helper.h     |  4 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index feb7a3a759811aed70c679be8704072093e2a79b..dc9d0cc162b2197dcbadda26686a9c5652e74107 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -748,3 +748,59 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
+
+/**
+ * __drm_atomic_helper_connector_hdmi_update_edid - Update the HDMI Connector basing on passed EDID
+ * @connector: A pointer to the HDMI connector
+ * @drm_edid: EDID to process
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * and .force() callbacks, updating the HDMI-specific connector's data. The
+ * function consumes passed EDID, there is no need to free it afterwards. Most
+ * of the drivers should be able to use
+ * @drm_atomic_helper_connector_hdmi_update() instead.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int
+__drm_atomic_helper_connector_hdmi_update_edid(struct drm_connector *connector,
+					       const struct drm_edid *drm_edid)
+{
+	drm_edid_connector_update(connector, drm_edid);
+	drm_edid_free(drm_edid);
+
+	if (!drm_edid) {
+		drm_connector_hdmi_codec_plugged_notify(connector, false);
+
+		// TODO: also handle CEC and scramber, HDMI sink disconnected.
+
+		return 0;
+	}
+
+	drm_connector_hdmi_codec_plugged_notify(connector, true);
+
+	// TODO: also handle CEC and scramber, HDMI sink is now connected.
+
+	return 0;
+}
+EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_update_edid);
+
+/**
+ * drm_atomic_helper_connector_hdmi_update - Update the HDMI Connector after reading the EDID
+ * @connector: A pointer to the HDMI connector
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * and .force() callbacks, updating the HDMI-specific connector's data.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int
+drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector)
+{
+	const struct drm_edid *drm_edid = drm_edid_read(connector);
+
+	return __drm_atomic_helper_connector_hdmi_update_edid(connector, drm_edid);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 2d45fcfa461985065a5e5ad67eddc0b1c556d526..ea0980aa25cbbfdd36f44201888c139b0ee943da 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -20,4 +20,8 @@ int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_state *state);
 
+int __drm_atomic_helper_connector_hdmi_update_edid(struct drm_connector *connector,
+						   const struct drm_edid *drm_edid);
+int drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector);
+
 #endif // DRM_HDMI_STATE_HELPER_H_

-- 
2.39.5


