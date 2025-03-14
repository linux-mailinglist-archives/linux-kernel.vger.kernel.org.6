Return-Path: <linux-kernel+bounces-561225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A32A60EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91CD16D8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DE1F9413;
	Fri, 14 Mar 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V5JWfu5S"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A91F460B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948319; cv=none; b=mifEQAdpq2yAVbq6p+0hhywjbY7QLR4sw8KTafXNZvk6Au4Y8z+2ufetzfUl4UQ33MfH6IJFo386L05gKItEm43zCxlLxAguAuLscWd2RqvQNDwOrGH9mCyQCDZhdyWcoQ0ce2wjGEpYnOk0dGL1ioSjaVRtOIQFu1PLzR7uupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948319; c=relaxed/simple;
	bh=0U02z4AP7TV0+hO06MAypxONFGpr+ZNKShqTW76S89E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTQDgeJNmiKu0geLsxZgxDdacJsM2ML5VzWxv3MPEjnDOKLhfjDmug+5xjqhMSi49PGst6qZpqTB0GP4gLjOegW26ZMHb3XGPyCXQ2GqUH0y/7dbvZXWFILToN9TRIvDH0m0eyGkxasoKPyXID6sMx88G9mDsFC89As+rwNjFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V5JWfu5S; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 267114333F;
	Fri, 14 Mar 2025 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741948314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMRuXNJQ91MiX1jBJa/pd03aZsq6PMaQrbW5zeLajvU=;
	b=V5JWfu5SO2uDAuf84Ru0idEusJzCBpo4EBZSNCBD0mIxNuJ5yJmMF9tWe2oyDV1wsoo9ZG
	ffUeQ4v7ZFyY7z2YOiBedjerS9Bvvhd/HLz1FiGL7yB6fXPbbcH5hDR563hM/MzXnC/qX0
	NRp5e9O5+c+qLsQPjTfAG+izmBK12WJESpVLZSUq4IlXeZJXkjmXQw1on7IBwI7f3zd+8S
	r0VG5j4Ua/EIpghGmy/AnOygXLOQb8scz/DtHO/nufA4dXXer91ZoanskMdmEVKqr+Kf2/
	ahqhuLTcz42TptBpPow9Q0IceHs9Pl+kmfB+jenO/yM2U3y23cIxn4J1aJcLeQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Mar 2025 11:31:21 +0100
Subject: [PATCH v7 08/11] drm/atomic-helper: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-bridge-refcount-v7-8-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
In-Reply-To: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Dmitry Baryshkov <lumag@kernel.org>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepihhnkhhirdgurggvsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehjvghrn
 hgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhksehshihsqdgsrghsvgdrihhopdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgv
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_chain_get_first_bridge() is
refcounted. Put it when done.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Note: I suspect most or all of the involved functions here could just
receive the encoder instead of the first bridge in the chain, and then walk
the encoder chain on their own. For the sake of simplicity and to show how
to put a bridge in general I've kept this patch in this form, for the time
being.

This patch was added in v7.
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5302ab3248985d3e0a47e40fd3deb7ad0d9f775b..fcd9139ef98e9f57659b7e447cf57702e99a5165 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -455,6 +455,7 @@ mode_fixup(struct drm_atomic_state *state)
 		ret = drm_atomic_bridge_chain_check(bridge,
 						    new_crtc_state,
 						    new_conn_state);
+		drm_bridge_put(bridge);
 		if (ret) {
 			drm_dbg_atomic(encoder->dev, "Bridge atomic check failed\n");
 			return ret;
@@ -526,6 +527,7 @@ static enum drm_mode_status mode_valid_path(struct drm_connector *connector,
 	bridge = drm_bridge_chain_get_first_bridge(encoder);
 	ret = drm_bridge_chain_mode_valid(bridge, &connector->display_info,
 					  mode);
+	drm_bridge_put(bridge);
 	if (ret != MODE_OK) {
 		drm_dbg_atomic(encoder->dev, "[BRIDGE] mode_valid() failed\n");
 		return ret;
@@ -1226,6 +1228,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *state)
 		}
 
 		drm_atomic_bridge_chain_post_disable(bridge, state);
+		drm_bridge_put(bridge);
 	}
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -1433,6 +1436,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *state)
 
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
 		drm_bridge_chain_mode_set(bridge, mode, adjusted_mode);
+		drm_bridge_put(bridge);
 	}
 }
 
@@ -1564,6 +1568,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		}
 
 		drm_atomic_bridge_chain_enable(bridge, state);
+		drm_bridge_put(bridge);
 	}
 
 	drm_atomic_helper_commit_writebacks(dev, state);

-- 
2.48.1


