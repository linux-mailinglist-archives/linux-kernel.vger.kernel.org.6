Return-Path: <linux-kernel+bounces-531940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE8A446BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A961883DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF520C000;
	Tue, 25 Feb 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGjkMEAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C720C488
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501882; cv=none; b=h5tAvgawPmwtj3Hv1tAX/u4etYwX3fxKrZSruMrlk/63PXlRTGE1033M0it/ESNSOMKtP97JLFwSb/0hhi+uFRhlklvitxOYCZgm3qUJt6K4ej39OY1HTP5CbL7CHY6Z3jcijnlv79faU6OZlqF9dVNkhPwLyYhSA4oj1Sww+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501882; c=relaxed/simple;
	bh=N9o+5lkH2lEqI5Z0LkHvN3UcudIkKdRGUvoC3mBiKdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8Dc9nuB3tNY3TjmEsh+miIcIFY/YFS/XN4JSw0xgZWivMApx0hNwaxcR+UUFlIl2fKGpRqfbFfjWm3o+5HXjYnuLS2jVFv3ljvBDadvlyw7QiXjvAXQ80NJQuZdEKGrmgXlww+kmDbcxrGuQ/1J6smICUyj1DBD0aAoaHWSOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGjkMEAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE32C4CEED;
	Tue, 25 Feb 2025 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501880;
	bh=N9o+5lkH2lEqI5Z0LkHvN3UcudIkKdRGUvoC3mBiKdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vGjkMEAVHcGMpKRMUlafJAGrQmk61NTDZa4iS592v/SBnMo0S0gBsg5Wwl1EPzrnD
	 UvHY1AqOn2IFB46+xAu6C0W4kU8Q0uNCpWRtTJpOBgKjC/s0SGFfOSj6watW/SgSmZ
	 MTI4qntlN0sLtb3WVGrFC3Rpeh8sAA+6894IOegpgYcIkhBRkElvNuYwJ16O9Mog3i
	 wOXfGTVg6GAjElUZ4GmobHBwrgjQVJbD2U7GVMvXfAdR633r1N3W7D5w17chz+71Yb
	 okrtOCKI9Nn7jtxUvW2hVcXS45B6kcSiCWUs/i8ETcA73Z/OJlbqa9AJoHynax5oGJ
	 4rrMwa1NyAtaA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:44:01 +0100
Subject: [PATCH v4 13/15] drm/bridge: tc358768: Stop disabling when failing
 to enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-13-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=mripard@kernel.org;
 h=from:subject:message-id; bh=N9o+5lkH2lEqI5Z0LkHvN3UcudIkKdRGUvoC3mBiKdc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P/t/vmHzfumZU7O1LHzvfzkxV6C5vn+jULbWD6+EX
 5O/XDwS2TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmMvk9Y8M3dcNpqhVfH1k/
 +qoq0yweWxwpENVyYubmHqMrjb5nVuXXRXEEMVtsevqRNYWbZ/1ObsYqZk3Fk/uF5n5/bzO772P
 AD/uECZoSrvHy5wNfMVkLu3FKRf0+EC5eMVu84oHoXyvXZ7MA
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


