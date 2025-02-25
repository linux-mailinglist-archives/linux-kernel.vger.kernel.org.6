Return-Path: <linux-kernel+bounces-531846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D875A445C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B91188A8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1D18DB18;
	Tue, 25 Feb 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d2sb87hn"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEA189BB0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500191; cv=none; b=NGEz8kbzazlijPtxUdefgpxh3iWLPJSMnHWQXqsAIhA3gR6IEZPzcDSQcAaepLRhJbFHwXerfcjyYMJfbMh+nDGB6aEhZ9tP1Fja9ZdGvBqnKzTKXJ27mNcgB9y2Dbj9aqSHAU0aP8+Y1G4JYZacfPV0FABVwFkx+Q4YlSpUnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500191; c=relaxed/simple;
	bh=jWKTO6dQPX6sZAQq7wtWpaD1FsweUC/qr2oqg+2udeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQxJBiU7EV+twi94bMQGeh40wC93Lyiw++DjEe0kQ1Cn2C8QukiKqfW37NtqBEGJkvEDE/Xqv/Phh6e6UxOtxlOVoPVPOu7dvlagiwox4E7GKgxvwdw3RbP5Q/iSSl91OnrvGOp9ma52broP7z33g6vn0nAPoDFXKGtvUSLD1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d2sb87hn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD0CB4435C;
	Tue, 25 Feb 2025 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740500187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhrN2RdRmhY01s4zRlL2EVZGrZ0qirN8//YZAm2QyLk=;
	b=d2sb87hn5Y2JoAoHpp/tFzBNo6si80EFt9YAS6hTDJ3R6SUiEbcN+shxHKNjtAxUGSCvbN
	6ulyHiy/1+ASGWHO/plKsA33bx67RXNm+BAtBSyaGWRzQlo0yHCPcaV3nIU55xysyclZFJ
	YR+O+nj/qDNXsBFFXe0ZXunYYkO4tcmSqldjanbECxlh1RaEkfOoNUIqyk03Fn++Htn/G2
	giZTNOxd2m0GbZip3w3omdK2EbUCtWTaILjcyRm4+6OkajVBLtazfOFyHUdfg9g+y0u+k3
	TqhC/5O9TGoWyqP7ZkgB625TDWfocrHt9FPPCC3tABLvBsXWB2En5FPKckalkg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 25 Feb 2025 17:16:20 +0100
Subject: [PATCH v7 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-drm-debugfs-show-all-bridges-v7-1-8826037ada37@bootlin.com>
References: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
In-Reply-To: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdpr
 hgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

In preparation to expose more info about bridges in debugfs, which will
require more insight into drm_bridge data structures, move the bridges_show
code to drm_bridge.c.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v7.
---
 drivers/gpu/drm/drm_bridge.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c | 27 ++-------------------------
 include/drm/drm_bridge.h      |  8 ++++++++
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 241a384ebce39b4a3db58c208af27960904fc662..6e1e02c1cf443fbaa764765ad369b7a34cc03f2d 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1335,6 +1335,39 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
+					     struct drm_encoder *encoder)
+{
+	struct drm_bridge *bridge;
+	unsigned int idx = 0;
+
+	drm_for_each_bridge_in_chain(encoder, bridge) {
+		drm_printf(p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
+		drm_printf(p, "\ttype: [%d] %s\n",
+			   bridge->type,
+			   drm_get_connector_type_name(bridge->type));
+
+		if (bridge->of_node)
+			drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
+
+		drm_printf(p, "\tops: [0x%x]", bridge->ops);
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
+			drm_puts(p, " detect");
+		if (bridge->ops & DRM_BRIDGE_OP_EDID)
+			drm_puts(p, " edid");
+		if (bridge->ops & DRM_BRIDGE_OP_HPD)
+			drm_puts(p, " hpd");
+		if (bridge->ops & DRM_BRIDGE_OP_MODES)
+			drm_puts(p, " modes");
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+			drm_puts(p, " hdmi");
+		drm_puts(p, "\n");
+	}
+}
+EXPORT_SYMBOL(drm_bridge_debugfs_show_encoder_bridges);
+#endif
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 6b2178864c7ee12db9aa1f562e106b2f604439f8..a625c0c9a9aa076af19c8ba47564dbb24ba71c9a 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -744,31 +744,8 @@ static int bridges_show(struct seq_file *m, void *data)
 {
 	struct drm_encoder *encoder = m->private;
 	struct drm_printer p = drm_seq_file_printer(m);
-	struct drm_bridge *bridge;
-	unsigned int idx = 0;
-
-	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
-		drm_printf(&p, "\ttype: [%d] %s\n",
-			   bridge->type,
-			   drm_get_connector_type_name(bridge->type));
-
-		if (bridge->of_node)
-			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
-
-		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
-		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
-			drm_puts(&p, " detect");
-		if (bridge->ops & DRM_BRIDGE_OP_EDID)
-			drm_puts(&p, " edid");
-		if (bridge->ops & DRM_BRIDGE_OP_HPD)
-			drm_puts(&p, " hpd");
-		if (bridge->ops & DRM_BRIDGE_OP_MODES)
-			drm_puts(&p, " modes");
-		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
-			drm_puts(&p, " hdmi");
-		drm_puts(&p, "\n");
-	}
+
+	drm_bridge_debugfs_show_encoder_bridges(&p, encoder);
 
 	return 0;
 }
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..23c062853e7bb42d8d73af35ef7f16fb37345a37 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1108,4 +1108,12 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
+					     struct drm_encoder *encoder);
+#else
+static inline void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
+							   struct drm_encoder *encoder) {}
+#endif
+
 #endif

-- 
2.48.1


