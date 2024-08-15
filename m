Return-Path: <linux-kernel+bounces-287366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4D95270A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B3AB23003
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86E383A2;
	Thu, 15 Aug 2024 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXQSQpIv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CA17C9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682075; cv=none; b=i5jjNwSEPiAiI/WB4SqeT6PjVPlXyP3Vz4j9PIdbIiQ5raJ5fLSfPTT5B5r2rzN4hzxYKeKMuiVgiriekD9I4A/VECChHtEYlgt/O5mSiqiQdJoBa7TZ2cynCRn2qZaofgLQLc9H0Tb5Oj0Cn669yeU2cI4L7WvfXCuPYu9vKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682075; c=relaxed/simple;
	bh=/jcJ+rI0gKZr/IVP6XjS/Ak4IPjJQVitYadHxzTrZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHL1bhVD2f725nWKTllYwvbMx3TB8nh/7Rjm1de+0ju9NomYqaZHlEobTmHxt3I/dT07QRxleciVUTjuzOVymod+pnx/DTyBoQwmYTT8Em8Cn7GH8dtbQrg8lDdWZ+YQ0eiNQGa/kU5Q8kSIEceaYLwyILuwHkK2uz7YGEIVlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lXQSQpIv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd70ba6a15so4079415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682073; x=1724286873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yiv0xFPMhU7ZUs+XvuB/ZZA+l47REHWpzG575OPKPI=;
        b=lXQSQpIv6FXxMe09ClVhx4zRYbjS9mjO+31RPg8GOxJoOGknc0F45Kcc2zxhSdGWXW
         fl/MnqT53XQm2iLM/goAFP0Ohs0HlhcMjzSeu5SvQxbuiZSRZ5ft4pwr5X0nbJIroBk6
         33Ll8z/c8tVxt0UzqTCPaSf/i1ErysvLjd3mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682073; x=1724286873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yiv0xFPMhU7ZUs+XvuB/ZZA+l47REHWpzG575OPKPI=;
        b=grr84fP33byxVNQOw/8oc/Cdg3pnsmM7k1VM6xPXVgsSL9n3mhk5Xd5uXDT2QzXp8v
         JFNSgtMlog0ioVvDUTiIBXJ/6NyTiy73JJNaQvF4G14sv6EjIAxZL+ZMn/CuWAIHrt31
         IQkatJySKq7FVm1myn8mHrMCgo6A8Y4QbeviKW5UBr7v2HSWlVV79YpHmx4SUVpuYnx1
         /Y1lR0WidMI8qqTy+ohmJPWHokahCb719WYq5fq+jG9Qbl7Ry8y30EhYEdG2nuLMYV+U
         z8iSNJLFgUVn1HWOcmDIurUzTUl5B0J8pQydqoMrn5TaE6Z3z7VPzScdIiPA1wxBKW2I
         dSLw==
X-Gm-Message-State: AOJu0YztUhudloj33WpSIRu8suy78xjBYdRWp2uyx468vxR4OgAGsCte
	tQoz9GjoJTpLwOmCHv7VsZrUcyrXLubtMvpZcfP7unYbBQMFJBbxTJb6LZ/GMQ==
X-Google-Smtp-Source: AGHT+IHJN+4iBjtg5BFHkoM0j1LHWILoEX4QehkqxO/ua5YPwB+wrtI73F9/wcxBEBcJXyMVg84zJg==
X-Received: by 2002:a17:902:7c92:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-201d64b09ddmr38089775ad.41.1723682072985;
        Wed, 14 Aug 2024 17:34:32 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f03a16b2sm1970445ad.268.2024.08.14.17.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 17:34:32 -0700 (PDT)
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
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 06/11] drm/bridge: dp_typec: Allow users to hook hpd notify path
Date: Wed, 14 Aug 2024 17:34:11 -0700
Message-ID: <20240815003417.1175506-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240815003417.1175506-1-swboyd@chromium.org>
References: <20240815003417.1175506-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch added support for no-hpd to drm_dp_typec_bridge code.
Allow users of this bridge to hook the HPD notification path of the
bridge chain so that they can be made aware of the connector status
changing. This helps HPD-less users of the bridge inject the HPD state
into their code by using the connector status as a proxy for HPD being
asserted or deasserted.

In particular, this will help Trogdor/Strongbad boards that need to read
the EC's analog mux which steers the DP signal to one or the other USB
type-c ports to figure out which type-c port has HPD asserted.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 19 +++++++++++++++++++
 include/drm/bridge/aux-bridge.h         |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index a5a434b7d5ec..32c0171c512c 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -55,6 +55,9 @@ to_drm_dp_typec_bridge_data(struct drm_bridge *bridge)
 struct drm_dp_typec_bridge_dev {
 	struct auxiliary_device adev;
 	size_t max_lanes;
+	void (*hpd_notify)(struct drm_dp_typec_bridge_dev *dev,
+			   void *data, enum drm_connector_status status);
+	void *hpd_data;
 	bool no_hpd;
 };
 
@@ -235,6 +238,8 @@ devm_drm_dp_typec_bridge_alloc(struct device *parent, const struct drm_dp_typec_
 	adev->dev.platform_data = of_node_get(desc->of_node);
 	typec_bridge_dev->max_lanes = desc->num_dp_lanes;
 	typec_bridge_dev->no_hpd = desc->no_hpd;
+	typec_bridge_dev->hpd_notify = desc->hpd_notify;
+	typec_bridge_dev->hpd_data = desc->hpd_data;
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
@@ -305,6 +310,19 @@ void drm_dp_typec_bridge_notify(struct drm_dp_typec_bridge_dev *typec_bridge_dev
 }
 EXPORT_SYMBOL_GPL(drm_dp_typec_bridge_notify);
 
+static void drm_dp_typec_bridge_hpd_notify(struct drm_bridge *bridge,
+					    enum drm_connector_status status)
+{
+	struct drm_dp_typec_bridge_data *data;
+	struct drm_dp_typec_bridge_dev *typec_bridge_dev;
+
+	data = to_drm_dp_typec_bridge_data(bridge);
+	typec_bridge_dev = to_drm_dp_typec_bridge_dev(data->hpd_bridge.dev);
+
+	if (typec_bridge_dev->hpd_notify)
+		typec_bridge_dev->hpd_notify(typec_bridge_dev, typec_bridge_dev->hpd_data, status);
+}
+
 static int drm_aux_hpd_bridge_attach(struct drm_bridge *bridge,
 				     enum drm_bridge_attach_flags flags)
 {
@@ -460,6 +478,7 @@ static const struct drm_bridge_funcs drm_dp_typec_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.hpd_notify = drm_dp_typec_bridge_hpd_notify,
 };
 
 enum drm_aux_bridge_type {
diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index 13f5e98b4d31..3229f200f0df 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -28,11 +28,16 @@ struct drm_dp_typec_bridge_dev;
  * struct drm_dp_typec_bridge_desc - drm_dp_typec_bridge descriptor
  * @of_node: device node pointer corresponding to this bridge instance
  * @num_dp_lanes: number of input DP lanes possible (1, 2 or 4)
+ * @hpd_notify: callback for bridge hot plug detect events
+ * @hpd_data: data passed to @hpd_notify callback
  * @no_hpd: true if this bridge can't signal HPD state with drm_dp_typec_bridge_notify()
  */
 struct drm_dp_typec_bridge_desc {
 	struct device_node *of_node;
 	size_t num_dp_lanes;
+	void (*hpd_notify)(struct drm_dp_typec_bridge_dev *typec_bridge_dev,
+			   void *data, enum drm_connector_status status);
+	void *hpd_data;
 	bool no_hpd;
 };
 
-- 
https://chromeos.dev


