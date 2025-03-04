Return-Path: <linux-kernel+bounces-543972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC8A4DC06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19503188DCBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66961FF7AC;
	Tue,  4 Mar 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyEHfAg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B41FF1D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086669; cv=none; b=GsDBB3THp4aNol3ZqX5B8gJrR1uftIyMegLW1KUng5nxEgv77E4iYexTCrmaIsugo9r8zl5qO0nv0GPxHgzjGeCs0A6SZDQDVAyT0XNAEgIgttDqH00qpgs870d3uuoe97TFfvBqR2ZxZ49QWCcB5gi/Jnnz23yZ8n6/qLbvWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086669; c=relaxed/simple;
	bh=JgF9vOJBbu71izE1DQMLADlikJ3dVzuG54ze6IQ0bXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcq/fUOAG4FgaG5YjTBAGCctmLfXznKfrh3iaRjWLQ8JyrXfieuADOQ9XNYZjJwr/JcMbLCeQynG7yHj1P1jXKWCosCW3S1ASvRt/p28G30UykCshDtwSG185QsbYHhQrus+Y9zRWpGHidua722lJpgFnovb1esU3o93Op54tJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyEHfAg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555BDC4CEE5;
	Tue,  4 Mar 2025 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086668;
	bh=JgF9vOJBbu71izE1DQMLADlikJ3dVzuG54ze6IQ0bXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GyEHfAg79XpJJhmAImbNHNp9u0Qdgk4wDVq+tQW/TC8AwsusnH298URaFF1sVQolj
	 vmRl/RPgwh20em1oMneORsqAubANTa6vZjlWgv1sFRxR7C/0L4BFbWaMB40W7y1bXv
	 p6xUc+Wo+Jh38enU8zyh0kUiLa95jH1noOkSPPBAeiCAy9TbgGsTG8bIYz9a0IaZAY
	 hSHPFPAjXz2IvT7jJKHmNMJ5JexSr7dGk5tPvy/9R5hbbmBDpz2NJ0pbgmNN8gIqjw
	 WLBz5oQAVjJ6Fa6rLMxyzFfd86O5n5Yea1xN6VG+bEkORXOhku6rBT+QdL8WUylmuG
	 0YuSbmtv17aMw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:45 +0100
Subject: [PATCH v5 02/16] drm/bridge: Provide a helper to retrieve current
 bridge state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-2-aacf461d2157@kernel.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
In-Reply-To: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
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
 h=from:subject:message-id; bh=JgF9vOJBbu71izE1DQMLADlikJ3dVzuG54ze6IQ0bXQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7u81LNNgFXd/0LKj6MejNRvV7yV/+ff59jS/XdyN+
 zJjEs686ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWZ/NWJ9ncsom8/HkG+wb
 thxaEjYreukM0Vbt/Adb1N79l830t6t8wmo1LXJCbKvJliUbpb6p3mKsU+AxsXArjInbKp6w9rG
 VaO+ciqzpnC5JgvphO8K6nty0SOt4uZun78GLI3NVVm1zNv8NAA==
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
index 2b65466540306feb0694abdc7cd801369cb9c9f0..6fb1da7c195e99143a67a999d16fe361c1e3f4ab 100644
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


