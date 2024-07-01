Return-Path: <linux-kernel+bounces-236809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C320F91E756
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DA6282365
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3716EC19;
	Mon,  1 Jul 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbYAxomN"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB916EBF6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857999; cv=none; b=gcJ1hyw+PzwcV/xS956fSQ2ycY7nNmB8rj1/XAodIEqDQclxXBwHZ0tFUFNvlQu/uy7NSS3CpJCK/enGKeSVIZz77ShAhfQKCGBFm8GowXQIjGDSo20y0mBza3wtEDy7J1r4mhhjGZdzb7ZNSta9iUOLY7qO0Ey1hwHekoqYqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857999; c=relaxed/simple;
	bh=SKAFSPCa5VrynHGCh1AnVztZXyJngqx/+e1B3wfGBFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARa5vSVUa4QX7iTvewhWnpzYmwpdy8fKp24PmtPGAV00ktzrzIuAKhSIr4BW5OMQZFkTOPiLoknDUGEIicgc54YN3ltXiAgje33kvi0ioyQQyhtA33CfmAVhfgjcWggdcDzDuT/rwojA40p0/zwAo03G1hdUIutPOYVJ91+lw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbYAxomN; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso37554521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719857996; x=1720462796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9f4mKCaRWs6EL5Tgl8NVvQuffheXHlnyeBx3NKI8np8=;
        b=AbYAxomNazrvCUsbw79+eu32F2AiG7UJZkY/KUlDTbXF/j8aMF+ZPMiAbEt6DdQS86
         P3l+fKu0HA4rI0azNYx7pSczX0WvaHP6ruz7Om4ZUgv/8m/fPOtOpRLNEn+xEUk2mPdT
         l8mwOnj7z2UGxCqEpqRI8t4qK8QRf1STFUhwmpwbUSfpQl+HjwcUqcXrYpSD6jsWQ2xZ
         uRv3Rpmm5a+bIJAxf6uSa9D4oSh7iHS2KjWwDjA3OFiYg4Vzx1yM2Cv+qM0nBtgREYW5
         yH/+jMdJ1u6B+ARtAI06zZr++463f4Dl2ht6CVgmOVWpyhucBKOvvrmhPlwXVrX4DnG7
         2b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857996; x=1720462796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f4mKCaRWs6EL5Tgl8NVvQuffheXHlnyeBx3NKI8np8=;
        b=MtciV4yrlnvB+Duxma0Lj44mO/8YGKcjVSc7kv5fsee8T9xXMPFofjyy+a4M4IeLl6
         joWlcwHXL95OXgYClL0A5BjDafKhZ1+fjAXzpuqUxwE6a9qM1DtYVla/dv7VE08Liywi
         t8SqaJrWs6C1q4QTYFTBKzQ+BgG3pJkjH+8lWuFJHRr0SyFc7F6tEiWgOLiKuVU4GHmi
         QZqMmy+hJa6MlyZQvttW+nnSH5KZgs2xalN1/9+/zhGJUrOr8tdGcRcgHBc688AxNWBj
         y3hjijQyYvNQlQ2HhuDH+pT361+Cno1m2OqfVznLp75dQy+J35guYoHEnVExd3h88Ulm
         KGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCViB6UUyK7k+CcG/Cw2UsW7UyzK/PY3SKaxw8hrPMf057WFCbSQZyJcbsg+gZM76eZSX/fAzBGLcPxW/iDtcM4d6DsxpE5M/eiSZpmu
X-Gm-Message-State: AOJu0YykIScgSlJpGFIKQUkfaJIuqYl6lxIsmJ+viFLqxZtd3QvakJY9
	sizFsRmI1Tmu+uYXBB1RTYts/LXys6k8/VzwOTa6YZMNO0y1c7Jt6zzi8WW4FBY=
X-Google-Smtp-Source: AGHT+IHHEZTy14kxUGvJ5gNImCp6TDI/dbrQQgc1/QstVX1/NQsX4jr1qkKXl2r4xuXwszTqwSPmOA==
X-Received: by 2002:a05:6512:10d6:b0:52c:df4c:92d8 with SMTP id 2adb3069b0e04-52e7b8decfdmr3570098e87.1.1719857995662;
        Mon, 01 Jul 2024 11:19:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2f8aasm1516931e87.236.2024.07.01.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:19:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Jul 2024 21:19:52 +0300
Subject: [PATCH 1/2] drm/bridge: lt9611uxc: properly attach to a next
 bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-lt9611uxc-next-bridge-v1-1-665bce5fdaaa@linaro.org>
References: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
In-Reply-To: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SKAFSPCa5VrynHGCh1AnVztZXyJngqx/+e1B3wfGBFA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1rTZ0/m8tkTF6eUXTLhCVpzbPpakTsdmmk+dSWFU9WO/
 DtayRDZyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJVN/kYJjf0zprvrSq0IRT
 J2I2hd1O9Vc6KFAj6yx3KGjKgZRp6u92sp+3sSnI5KoJ1dJiWHNhy9fqdreG7I51UucWnH3zre6
 84v3iI/4/hBVSzl93nSRg2tTfHn5jvULRrFOxcZqr3thJmjzZd2eOzInFsZnhS9JT09d+MJmnYN
 l0R2HGRu3MndN86pwtDyspTjOpeuk/29H+p+xrPb9zEcU8TxrmLbxb6+KdocQ069wV2+t5kW5e7
 Lbn9S5Km69uuSvVdZS/UmGx4n2nBx/cZjh91lXWkktmDXi5TEXu4HFHwZtZUlvTSrzdRfxFCk5u
 EHvo3eH0d++xk5LOW5w3/2PfeZBvJyv7lVJvB3+Ve//8AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If there is a next bridge in the OF graph don't let it be ignored.
Attach the next bridge to the chain.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 4e802b54a1cb..4d379d0d24d9 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -23,6 +23,7 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -34,6 +35,7 @@
 struct lt9611uxc {
 	struct device *dev;
 	struct drm_bridge bridge;
+	struct drm_bridge *next_bridge;
 	struct drm_connector connector;
 
 	struct regmap *regmap;
@@ -358,6 +360,11 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 	struct lt9611uxc *lt9611uxc = bridge_to_lt9611uxc(bridge);
 	int ret;
 
+	ret = drm_bridge_attach(bridge->encoder, lt9611uxc->next_bridge,
+				 bridge, flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		return ret;
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = lt9611uxc_connector_init(bridge, lt9611uxc);
 		if (ret < 0)
@@ -525,7 +532,7 @@ static int lt9611uxc_parse_dt(struct device *dev,
 
 	lt9611uxc->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
 
-	return 0;
+	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611uxc->next_bridge);
 }
 
 static int lt9611uxc_gpio_init(struct lt9611uxc *lt9611uxc)

-- 
2.39.2


