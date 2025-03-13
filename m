Return-Path: <linux-kernel+bounces-559425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADCA5F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E513B9E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB32267F5D;
	Thu, 13 Mar 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dySuTXn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EF267F54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867252; cv=none; b=DOVA6uZ8IiMI/fGKjCAZ8kEtqxzSnCFaYVu2fXKhlVz74waoEseUE8n9O0+oJsgEpc1sRaE33koCaPFvKCYZHBqME7eCbt1CqHxJ/q8rMN7AEBLzhUpcVoWjVUPhjqX8lW3+OIEWU04QSPUA+8g11XK9KLZNvKf0Caj5d6ISaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867252; c=relaxed/simple;
	bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJi19uibhzjyqyrZ71O4iE6zd+/aOyf9OaSJWyKo7pQACgCuUjOxqsPO0CwX+xnoZSIeWEmFRfJWlJZxAE/pHheQaISQ+jYMU5Vt5aPI+RoTYzyOaSaf1IDTuozV3IkAPLR3L1ITduEdDgfTjSmM0RZFmWFUrtimxtVDH6lJF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dySuTXn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95943C4CEDD;
	Thu, 13 Mar 2025 12:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867251;
	bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dySuTXn+o7bxUpXsfZBd31gkruJgZ50VLCoiiw+YS74b2sv44+UD8XF3OI9/zeF3N
	 uZzo8XCvLTLeOOgJG2fbwsnHm5VjYfWzHj0z0mA3jdmIH6B8LFf7YGPPq25eyiJnXx
	 C49qQ2Fh6krbnApov6adPmtni9pd1Lipj7xnoBqsxPM+hsasp48pUaF/OTghiE3C/d
	 jIwdEcgvdZ1jSTaZlozeLUhi9tRrtF3rLboOuxNvMmQbJb1OgjE3nHJuyVBnS6CYzk
	 9ywIQcRGY+xBKE3L//AGf4MpglLbWZGKJe0ZLrmCQyv3QAc76xBXJJxAnfZi0xhRad
	 gojcHUQ4ZXLYA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:08 +0100
Subject: [PATCH v6 14/16] drm/bridge: tc358768: Stop disabling when failing
 to enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-14-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThxTVrn78U3o9PbJx/RltC44HroYWFg7OXN5wHv99
 X2zftsadJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiu1cxMvS+qj9/a/EkxXyn
 h4x2Z1VPZbzNfrmZK/1i82depW1zXc8wMhz9ta5tLp+c7MWI4nuL9b4fmqdQ8DFcVd1s5tf409w
 83pwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tc358768 bridge driver, if enabling it fails, tries to disable it.
This is pretty uncommon in bridge drivers, and also stands in the way
for further reworks.

Worse, since pre_enable and enable aren't expected to fail, disable and
post_disable might be called twice: once to handle the failure, and once
to actually disable the bridge.

Since post_disable uses regulators and clocks, this would lead to enable
count imbalances.

In order to prevent that imbalance, and to allow further reworks, let's
drop the calls to disable and post_disable, but keep the warning to let
users know about what's going on.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6b65ba8aed86012bc0f464bd5ee44325dae677c6 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1075,15 +1075,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
 	val |= TC358768_DSI_CONTROL_DIS_MODE; /* DSI mode */
 	tc358768_write(priv, TC358768_DSI_CONFW, val);
 
 	ret = tc358768_clear_error(priv);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
-		tc358768_bridge_disable(bridge);
-		tc358768_bridge_post_disable(bridge);
-	}
 }
 
 static void tc358768_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
@@ -1099,15 +1096,12 @@ static void tc358768_bridge_enable(struct drm_bridge *bridge)
 
 	/* set PP_en */
 	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(6), BIT(6));
 
 	ret = tc358768_clear_error(priv);
-	if (ret) {
+	if (ret)
 		dev_err(priv->dev, "Bridge enable failed: %d\n", ret);
-		tc358768_bridge_disable(bridge);
-		tc358768_bridge_post_disable(bridge);
-	}
 }
 
 #define MAX_INPUT_SEL_FORMATS	1
 
 static u32 *

-- 
2.48.1


