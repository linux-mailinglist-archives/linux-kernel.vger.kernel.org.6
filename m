Return-Path: <linux-kernel+bounces-559412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4EA5F391
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0B3A840E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14D266F02;
	Thu, 13 Mar 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob/nNi+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAD26136B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867218; cv=none; b=pmUs0YdDut6xsTUZefSFRmFSHqFk0kcHEqU3zTcyvz/ywwIRLo0QGVjtoWFHPOLH262rCApNPB9HgrXrhEq+2MNuiHmwo6G3JI05hJcIPWTJdv2BL6ofefg7h7a/T7aGMH08mQiZp0pGYPm8gyM3Goafk0oDty17+ecD+bjrlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867218; c=relaxed/simple;
	bh=gwr3V49Utd/SKmLHHtevd1iF7qftbaASGq6Mah8+cNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpnUEXpNYSikrJkScAu+5ycmQKTVtGsYjtusSGp5SxFlFk9toScUqGnXhVmWcy6+kRS1oa3BJBXTusgi9MPQVCmhN8Ow6czVlDIEvdjiB3aX3w2ey5Gof/Vukedje17SyjZ2rBY1SAHk1zar1sjZWC+aeHLKcCGLmi/CK7afkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob/nNi+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6EDC4CEEB;
	Thu, 13 Mar 2025 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867218;
	bh=gwr3V49Utd/SKmLHHtevd1iF7qftbaASGq6Mah8+cNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ob/nNi+zhKrLnG39o9effLm7IfK+Aoot/yxke/ynTbBGsZxn5zt6H0gD0JZS5Kv3T
	 yfqzNsGU3KQDINGgZWTbOLfwjXDvNOctQDOp0w7wmM3JQ7AlIR2Uc8GzZGw9Jjes4W
	 GRg70tVrgkbGjnzqmB6OS+R6Se0frXcZoZvqYmtpIhMPfZ9Axl209f4foNfHKFV9Wz
	 4RUiP1s9DpRaEjYd++2eEKBg97GExRBHNCHFkN/ZYhZ1CQHPfaFqZgiINuUksDDIdM
	 BsE1ALXJENdq/y8OMk7hqs7b0BAjfTPLCywEjmFznligPj18ZHKqUXJlFds73ylfuR
	 xLibtri2i10FQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 12:59:56 +0100
Subject: [PATCH v6 02/16] drm/bridge: Provide a helper to retrieve current
 bridge state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-2-511c54a604fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gwr3V49Utd/SKmLHHtevd1iF7qftbaASGq6Mah8+cNI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXTuxjtdt9zSEprtvQ3JzvzwUr4YwtbXJOzqtVehfoW
 rd13+LrKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwERklzIyLA2adUjp2bKvS4JE
 Jk2eu59/t3iv/+d9DB9eLjRVOaCrJMbI8MV4YiXb9ft3zb4+2sTvy7TgsW5Ok0xOfqpU79LbM+Y
 wMQEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The current bridge state is accessible from the drm_bridge structure,
but since it's fairly indirect it's not easy to figure out.

Provide a helper to retrieve it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_bridge.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 884ff1faa4c896c28a38399ceaa5016ab704c886..cdad3b78a195aa39776c93e2371217d3d3fb6064 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -955,10 +955,42 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 {
 	return NULL;
 }
 #endif
 
+/**
+ * drm_bridge_get_current_state() - Get the current bridge state
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
+	if (!bridge)
+		return NULL;
+
+	/*
+	 * Only atomic bridges will have bridge->base initialized by
+	 * drm_atomic_private_obj_init(), so we need to make sure we're
+	 * working with one before we try to use the lock.
+	 */
+	if (!bridge->funcs || !bridge->funcs->atomic_reset)
+		return NULL;
+
+	drm_modeset_lock_assert_held(&bridge->base.lock);
+
+	if (!bridge->base.state)
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
2.48.1


