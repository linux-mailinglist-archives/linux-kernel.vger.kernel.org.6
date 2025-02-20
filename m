Return-Path: <linux-kernel+bounces-524001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BBA3DDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1F517787C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6381D5CFB;
	Thu, 20 Feb 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4aqcM/5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FE1D54CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064053; cv=none; b=KhNW/qtLAul44HJYjPlmGsvm1p8oe3HCbEcrzkZutgZkqy1h2wIcx9gakvS843F8cMuWE0wW4aTAby3+fI3DmgfsKWdKuUlee82Op2BBWSIlnWmdAJfkQhy/YUhghjMY9xLqpz6vcsGEM9yswhYp7s0X03lkxLtlOahAFGzJQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064053; c=relaxed/simple;
	bh=kNWHbdQTfRuwv2Va9uXhxADhuf1Qe21ZY5fqlYZexyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AW0CyNrP6tkEBQ1/nJNB6J0ypbp8ez79G+/u05qjWi9dHi11ClY//r7T8B5YvrgmGpSizckZ4z2gkHF++P2p8LFHYQpKOD4G5B+cBtgxjOKJo4QxmwdUhnrI03Q1bogW62WWKfW90W2s+Yw2iJr8gMNYnVhjR5injh3dZAEcQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4aqcM/5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54524740032so1155814e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740064050; x=1740668850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvG19MxhO3fYpjz2GmSHw6ccIGj+912fnpqB5X8XAQE=;
        b=v4aqcM/5aoRMd9QrntvVMEvc/HQcmTnd+vnjUxf9n8CA9SOk7XkUBaLIwCx799XfYc
         G6kKr5AchUWCm7ktvoeLVrQYv0UXCtZybMfhcORJ87ny5swIibW2W5VHNrhA8Fgy0V45
         8fkFIgzL0sSz0bMbWrpSQC4xpSCzJPXozwB13wVISzTwRIwIYHzq0LjelHsFGWf68fCB
         ojdAeLv3e35OjEkU5kDozIIYGJ4DDZRK1/B7KEKzqtGTy7dbsOqvDYJ4I6oDyhWZdVuG
         yz+erMVSXcIlGkJRID4Qr05KViTz7yFcKhdsvZ9G+dwnpiVTmhsWwYq6VVCTVj9pwwHz
         J45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064050; x=1740668850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvG19MxhO3fYpjz2GmSHw6ccIGj+912fnpqB5X8XAQE=;
        b=UBkPeRDFT3A12Gl5iaiYjim7vTdhXElYAMJ0fuuMabNo752Fg0DOhxposqcq8wxibT
         uDNCm9bJuLRYvn0BYWsN9/PsmDQY1WMm1AdKIvX9Mrqwm/XFglqrD/gaLbZ5fOLBVTkc
         xckoZcsHFtX6jYLhrzEPGsbSupqBoLjmvURKmf64gnqjD/7R4oS5+RYKmSwgPPYpzHHB
         o8CH0nmLIFd9tLhHpLx9rqo0QKP3a5tdZmedBT7p2I0VhBwLuTSwimT7ovM7XiYJzvo1
         TLQshT8ZXianUzmIWJypj3hbz0aem2gHj7ugJFkCPfPhYebC2GtaOpePvGsDhlFPTfrk
         itmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0BaKXrMJq/eoj0xjhJAY2RGeGluqVAa8Y98S8Qu1M5YGI0p9RlssD1axJpD5NxUN7hmyTUocrScEoWVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qHvYSr1e4Ua+tPdSfD3WU1emCHw7GGvn38SnzP1bLmu6rdeh
	ufWlNKi7f53V4jFb7Ibp+10N32gxoyCsdVZnkJJBnsOxF2EDGyDdIZZujvRf0jmlNtaCu6EbIsW
	9
X-Gm-Gg: ASbGncsxYMTRveFCRkgH1NSKBBJUrXGNZiE8svFLQQisflry9ZRIx2P9PFqOeMKr1xR
	MUzYPXfWaIIUkbXU4W4jiJbYWDIaawmCO8uKgCdD2f1mhH+XQXh9qRjzaHl6NHlWoL1sLYWYiL2
	0J9RnVL466qg8nbsn5GZrtDbrP84+1CCVvPse+pv4Uc8DEjMnugueKaMzZOzoSRuUJpY+LbRAD6
	4GYSlHNQkQrrHkbQZQGhgaWR8ij4P7EgtpYmwPBpeX/Nvc7I9ZpVQi80wb39F2rr0NslA9jb3jm
	SH7BMJJ0+LVGXxOPuUuSWXo=
X-Google-Smtp-Source: AGHT+IETrZT5oIuDLjlPhyAtOgizah+3OWG8Z0rwGfMHYB+otPCEElkRy42DyiPBfMuzjPj44nhQvg==
X-Received: by 2002:a2e:8a84:0:b0:306:501:4772 with SMTP id 38308e7fff4ca-30a2a7d42fbmr51425261fa.37.1740064049632;
        Thu, 20 Feb 2025 07:07:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309311777a8sm18419121fa.25.2025.02.20.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:07:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 17:07:26 +0200
Subject: [PATCH] drm/bridge: panel: move prepare_prev_first handling to
 drm_panel_bridge_add_typed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-panel_prev_first-v1-1-b9e787825a1a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC1Ft2cC/x2MUQqAIBAFrxL7nWALRXWVCBFbayFMNCIQ797S5
 /DmTYFMiSnD3BRI9HDmKwh0bQPusGEnxZswoMZeI2oVbaDTRHGN55Rv5d2k3eBGS96C3GTy/P7
 JZa31AyZLoq9iAAAA
X-Change-ID: 20250220-panel_prev_first-fc90c6c8aefa
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Svyatoslav Ryhel <clamor95@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kNWHbdQTfRuwv2Va9uXhxADhuf1Qe21ZY5fqlYZexyI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnt0Uv+NryiBFZE11p7O20qwstMksW1SPCO+2d5
 kshDb+eqtiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7dFLwAKCRCLPIo+Aiko
 1easB/9psQew0KpvbiVyfpBWBJJoXZ+oLaY5qqIF/v1CEUx19i8UKAZTpUv7/0eHvv4sCVW8oGs
 MG5FOmXafYYxbSyCNr1Es1NV8b/aZZSwiNn5yWos9VAOdJD5g9npG0q4JjqD3YpLst4cBdYsx0x
 sn3b5caZXqWVugrwYSh7bHwt09WR8fDI9qsRmC73mAmOpMiz9AELWOUM+Vk4TvaiPnf2sixFvDp
 yXLabRmGt2RzOnadKucI0q0VOZz/Le2BQ1nR/KFS2nWgBsNTr1X81D6S+Lzd2ldKQnfoyWQ/mIK
 pQrQU/Zh8Uc8dYZbW1XGzdMENFiSAAZlsq5GE+m4B8Jk+CyM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The commit 5ea6b1702781 ("drm/panel: Add prepare_prev_first flag to
drm_panel") and commit 0974687a19c3 ("drm/bridge: panel: Set
pre_enable_prev_first from drmm_panel_bridge_add") added handling of
panel's prepare_prev_first to devm_panel_bridge_add() and
drmm_panel_bridge_add(). However if the driver calls
drm_panel_bridge_add_typed() directly, then the flag won't be handled
and thus the drm_bridge.pre_enable_prev_first will not be set.

Move prepare_prev_first handling to the drm_panel_bridge_add_typed() so
that there is no way to miss the flag.

Fixes: 5ea6b1702781 ("drm/panel: Add prepare_prev_first flag to drm_panel")
Fixes: 0974687a19c3 ("drm/bridge: panel: Set pre_enable_prev_first from drmm_panel_bridge_add")
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Closes: https://lore.kernel.org/dri-devel/CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/panel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index c57036b06493a6922e2cae38bcd1733930ff0073..ed23de0478312a26a5d3434e63bd2fe4a6099bfc 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -302,6 +302,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 	panel_bridge->bridge.of_node = panel->dev->of_node;
 	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
 	panel_bridge->bridge.type = connector_type;
+	panel_bridge->bridge.pre_enable_prev_first = panel->prepare_prev_first;
 
 	drm_bridge_add(&panel_bridge->bridge);
 
@@ -416,8 +417,6 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 		return bridge;
 	}
 
-	bridge->pre_enable_prev_first = panel->prepare_prev_first;
-
 	*ptr = bridge;
 	devres_add(dev, ptr);
 
@@ -459,8 +458,6 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
 	if (ret)
 		return ERR_PTR(ret);
 
-	bridge->pre_enable_prev_first = panel->prepare_prev_first;
-
 	return bridge;
 }
 EXPORT_SYMBOL(drmm_panel_bridge_add);

---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250220-panel_prev_first-fc90c6c8aefa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


