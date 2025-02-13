Return-Path: <linux-kernel+bounces-513199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D2A343A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0A11890C94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20A155A4E;
	Thu, 13 Feb 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0bbn1aL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E7149C55
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457912; cv=none; b=p/QFDD3E4+me0gw0N2Rru0N3rL1+87X7aWW8wogAwoXTpaE3T/VGVvVzneTVBHBx1f9nQrNpacvdFORP4dNxl1r1BqkZ3AAF/xPWAT9/UKxPe9K01stNgl0rlpphnQ4qTISXzbWCYsjby0LiseIswxHUCSETg6MPt6anMUEzXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457912; c=relaxed/simple;
	bh=72Lepx1DN8gQFji9Cjn3zP8xGqZXbIiwFKfACerW6i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKmZg7xMMzc3Z8QPurzuRclz5o9KcmsiP9+0yA3oCtjdqA5iNYUQ3Rxgwi4wTGM/DvPMQQkc0TBavi+RoFeCGu9GQM4juvZrTw9ejNluKm7liSDWt8wlMKF21vyvx1lq+nEgRfWhzKjA+/mlUDMYbNLRCSuw9IBQzb8K7V50Upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0bbn1aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8524C4CED1;
	Thu, 13 Feb 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457912;
	bh=72Lepx1DN8gQFji9Cjn3zP8xGqZXbIiwFKfACerW6i4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0bbn1aLsA2ZyNa0O0cxSmj/CWZknrcr+lIZUL+dG4w9+mONgdbhjaLb6WUTOGUko
	 Uuv8BjysxNoR01g2q7nk15elHd8XtXUiPQpQlZf+aAcFxEKta5THptt4oYo5uG+4Vd
	 GDoao6RtiXCn48TQP5Tqx0HTDvAkjspGIrho+bTe8004IQ1v4wa2GALdH0Lpspg06t
	 plO2XIaAuVnaZ5B91Wz41ZhCRwa8b0W7gvEohjyoUipNF/WAWSpc2ccd/9tdpFhSjH
	 tEC4o7QKarMpxNxKgHc7XHkAPUzogNXr35kC6YaVzwpYvqsPLIEP4B5w4of4sstNhg
	 ZmXqJdvuXoVMQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:47 +0100
Subject: [PATCH v3 28/37] drm/bridge: Provide a helper to retrieve current
 bridge state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-28-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=mripard@kernel.org;
 h=from:subject:message-id; bh=72Lepx1DN8gQFji9Cjn3zP8xGqZXbIiwFKfACerW6i4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWJWWdfacEcg56NQ9o+t24c8dIcYtLy976wdN3RVVe
 s9u7znTjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRxgTGOlU9/gfpCfaPHDOP
 1hUbJpauWH657aX739Mucz5prlwsl2zty1kyUTXVWJ7VLZz5U/l3xvqobBUjvUUfllvp7Hny9qK
 4zY87HwwlDjz12C4XNikyeKNK8hHJzS/PzH/Uby9/7lY5gyYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The current bridge state is accessible from the drm_bridge structure,
but since it's fairly indirect it's not easy to figure out.

Provide a helper to retrieve it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_bridge.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 2b65466540306feb0694abdc7cd801369cb9c9f0..4cc12b8bbdfe2b496546607d1ae0b66a903c8f89 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -955,10 +955,31 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 {
 	return NULL;
 }
 #endif
 
+/**
+ * @drm_bridge_get_current_state() - Get the current bridge state
+ * @bridge: bridge object
+ *
+ * This function must be called with the modeset lock held.
+ *
+ * RETURNS:
+ *
+ * The current bridge state, or NULL if there is none.
+ */
+static inline struct drm_bridge_state *
+drm_bridge_get_current_state(struct drm_bridge *bridge)
+{
+	drm_modeset_lock_assert_held(&bridge->base.lock);
+
+	if (!bridge)
+		return NULL;
+
+	return drm_priv_to_bridge_state(bridge->base.state);
+}
+
 /**
  * drm_bridge_get_next_bridge() - Get the next bridge in the chain
  * @bridge: bridge object
  *
  * RETURNS:

-- 
2.48.0


