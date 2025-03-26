Return-Path: <linux-kernel+bounces-577484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E2A71DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BFB84360E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2F241665;
	Wed, 26 Mar 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPP567yf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AD2405E0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011284; cv=none; b=D0flRjjUG/AfGzk7O1wViBIlSyV6bSvAoEKhw6JtyVzA/rDo344bR8RVmC04S8TRlYMCH1cx6fTKSboIf6SDsYAphecYmAHt9UBFYfEMdmCEPOgGycjHsDCMZ/wbIed+R6zJd2EfuJKLHRRtLl/UEPw+foP/rgvzlbVfgYoHUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011284; c=relaxed/simple;
	bh=GJ2h0VLSrTHjXFeoTtYZt72ktEidkiPLMWalclmodbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oM/sKU/UDvTninqfxBCcC0zxxufIzdpgwN08qiH1JZYVdGEaxQ5I5TNzUb5Dy1YhLfTJjtHmwAnIhRX4Tmah6qRtQFFAXGyDPThKEPVeoKoBalRVgq+0incA/5s98LtjrsipzrDwH0aOXYmxtf2Gti8bXGC/kEwuC2iNsVuGMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GPP567yf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DE634443C;
	Wed, 26 Mar 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743011280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhjBmXsf/LmBdhRk5NLGeDB408E/96bpBJOsIdR68d4=;
	b=GPP567yfHMyK57Rh6puGQTwdX5hnay2mru9whH1UGqvFQSR3QbIoxeoQ9FSoqN1cTKchlE
	kczeAYMHtW/ZkCsYO+7afCk9BYhYYnm/4PZcFx7EoxPjCUJORAvAtwSh5XiKFGkz/LuINO
	6YXAFHApPIj3r6vnrknaZkFeVUSmqsS6sVwEwfF0O+YMiRjwh3HZgYfi93FJvw7t9rjkzw
	HYi/xKcph7PP+YhHCYUZTCnOoaq702UMB3HlQ7TqMx7MZSiVfBpSUGu8QSFw0NgeutlKSL
	AYRp1kejqalRl+e+H2FBvpJqZo3CT03g76/Q2uEsy4xs2/qQg2a692g8dvU1qQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 26 Mar 2025 18:47:36 +0100
Subject: [PATCH v9 2/5] drm/bridge: add support for refcounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-drm-bridge-refcount-v9-2-5e0661fe1f84@bootlin.com>
References: <20250326-drm-bridge-refcount-v9-0-5e0661fe1f84@bootlin.com>
In-Reply-To: <20250326-drm-bridge-refcount-v9-0-5e0661fe1f84@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehjefgudegvddukeegvedtgfduudehtdfgteefvefgheekjeehvdeihfdtfffhkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehimhigsehli
 hhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

DRM bridges are currently considered as a fixed element of a DRM card, and
thus their lifetime is assumed to extend for as long as the card
exists. New use cases, such as hot-pluggable hardware with video bridges,
require DRM bridges to be added to and removed from a DRM card without
tearing the card down. This is possible for connectors already (used by DP
MST), it is now needed for DRM bridges as well.

As a first preliminary step, make bridges reference-counted to allow a
struct drm_bridge (along with the private driver structure embedding it) to
stay allocated even after the driver has been removed, until the last
reference is put.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v9:
 - make drm_bridge_put() void as discussed in
   https://lore.kernel.org/lkml/20250326102304.49510630@booty/
 - slightly simplify code flow in drm_bridge_get/put()
 - removed Maxime's Reviewed-by due to the above changes

Changes in v8:
 - move back drm_bridge_get/put() to the .c file, make __drm_bridge_free
   private
 - move back drm_bridge_put_void() to .c, not used in this series outside
   of drm_bridge.c
 - remove drm_bridge_put_and_clear(), not used in this series
 - minor docs and coding style tweaks

Changes in v7:
 - export drm_bridge_put_void
 - struct drm_bridge: use container pointer instead of container_offset
 - remove drm_bridge_is_refcounted()
 - remove all DRM_DEBUG()s
 - drm_bridge_get/put: accept NULL pointer and return the bridge pointer to
   allow pass-through calls
 - extract to separate patches:
    - the addition of drm_bridge_alloc
    - the addition of drm_bridge_get/put() to drm_bridge_add/remove()
    - the addition of drm_bridge_get/put() to drm_bridge_attach/detach()
 - fix a typo, slightly improve kerneldoc

Changes in v6:
 - use drm_warn, not WARN_ON (Jani Nikula)
 - Add devm_drm_bridge_alloc() to replace drm_bridge_init() (similar to
   drmm_encoder_alloc)
 - Remove .destroy func: deallocation is done via the struct offset
   computed by the devm_drm_bridge_alloc() macro
 - use fixed free callback, as the same callback is used in all cases
   anyway (remove free_cb, add bool is_refcounted)
 - add drm_bridge_get/put() to drm_bridge_attach/detach() (add the bridge
   to a list)
 - make some DRM_DEBUG() strings more informative

This patch was added in v5.
---
 drivers/gpu/drm/drm_bridge.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_bridge.h     | 19 +++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 84fa1a1330cbabd309526829fff70971cfed1dcd..22b459af112fd3cd2db00aa16668d270e028b307 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -199,23 +199,84 @@
 static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
 
+static void __drm_bridge_free(struct kref *kref)
+{
+	struct drm_bridge *bridge = container_of(kref, struct drm_bridge, refcount);
+
+	kfree(bridge->container);
+}
+
+/**
+ * drm_bridge_get - Acquire a bridge reference
+ * @bridge: DRM bridge
+ *
+ * This function increments the bridge's refcount.
+ *
+ * Returns:
+ * Pointer to @bridge.
+ */
+struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge)
+{
+	if (bridge)
+		kref_get(&bridge->refcount);
+
+	return bridge;
+}
+EXPORT_SYMBOL(drm_bridge_get);
+
+/**
+ * drm_bridge_put - Release a bridge reference
+ * @bridge: DRM bridge
+ *
+ * This function decrements the bridge's reference count and frees the
+ * object if the reference count drops to zero.
+ */
+void drm_bridge_put(struct drm_bridge *bridge)
+{
+	if (bridge)
+		kref_put(&bridge->refcount, __drm_bridge_free);
+}
+EXPORT_SYMBOL(drm_bridge_put);
+
+/**
+ * drm_bridge_put_void - wrapper to drm_bridge_put() taking a void pointer
+ *
+ * @data: pointer to @struct drm_bridge, cast to a void pointer
+ *
+ * Wrapper of drm_bridge_put() to be used when a function taking a void
+ * pointer is needed, for example as a devm action.
+ */
+static void drm_bridge_put_void(void *data)
+{
+	struct drm_bridge *bridge = (struct drm_bridge *)data;
+
+	drm_bridge_put(bridge);
+}
+
 void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 			      const struct drm_bridge_funcs *funcs)
 {
 	void *container;
 	struct drm_bridge *bridge;
+	int err;
 
 	if (!funcs) {
 		dev_warn(dev, "Missing funcs pointer\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	container = devm_kzalloc(dev, size, GFP_KERNEL);
+	container = kzalloc(size, GFP_KERNEL);
 	if (!container)
 		return ERR_PTR(-ENOMEM);
 
 	bridge = container + offset;
+	bridge->container = container;
 	bridge->funcs = funcs;
+	kref_init(&bridge->refcount);
+
+	err = devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);
+	if (err)
+		return ERR_PTR(err);
 
 	return container;
 }
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index a59277674d5a2937e324d3ce48f934418788053f..df9bbf6fd1fb522add28b76406b74cdb7391fc57 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -840,6 +840,18 @@ struct drm_bridge {
 	const struct drm_bridge_timings *timings;
 	/** @funcs: control functions */
 	const struct drm_bridge_funcs *funcs;
+
+	/**
+	 * @container: Pointer to the private driver struct embedding this
+	 * @struct drm_bridge.
+	 */
+	void *container;
+
+	/**
+	 * @refcount: reference count of users referencing this bridge.
+	 */
+	struct kref refcount;
+
 	/** @driver_private: pointer to the bridge driver's internal context */
 	void *driver_private;
 	/** @ops: bitmask of operations supported by the bridge */
@@ -941,6 +953,9 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 	return container_of(priv, struct drm_bridge, base);
 }
 
+struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);
+void drm_bridge_put(struct drm_bridge *bridge);
+
 void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 			      const struct drm_bridge_funcs *funcs);
 
@@ -951,6 +966,10 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
  * @member: the name of the &drm_bridge within @type
  * @funcs: callbacks for this bridge
  *
+ * The reference count of the returned bridge is initialized to 1. This
+ * reference will be automatically dropped via devm (by calling
+ * drm_bridge_put()) when @dev is removed.
+ *
  * Returns:
  * Pointer to new bridge, or ERR_PTR on failure.
  */

-- 
2.49.0


