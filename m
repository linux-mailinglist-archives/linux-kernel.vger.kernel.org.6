Return-Path: <linux-kernel+bounces-534967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CDA46D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB78F16BF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163922332E;
	Wed, 26 Feb 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ikf0by6P"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A8218591
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605098; cv=none; b=kYdyH3H22QGkWsu/I5j4MYXg/HXS/9cwKlOt3p4pB5BnkQtYWQQG7xDE/BvTYIuIjHSxS/8+0Y4g36SHLbSh9oBQESRrNEtzOJrPOOVnQFko+uT5maiVZ2EP7jLHZgqQmMugfo2GZS6cYObn5Tu0qT0SGx3W6jjxWy0PyCL4G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605098; c=relaxed/simple;
	bh=GPvtEcspJU6GxP83VqwaJwmNYNNs6KoVA1yAU/7fUWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqkfwiDu7au8d3Qv+YDXAsUhl9Ebqq9FdjulNBmEYYtSfQUDBebRbu34RDFBY7AFu9Rk8Zl6XPWiDWgeLOFU0wuuWjFPvpGlAc/RpE6PAw6tHBGmsChx7Ff72Z15KePRcFTvEU01cEDv48EOq+g7CwYCR3FzpHRkdOB/X7LiP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ikf0by6P; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAF6C4435B;
	Wed, 26 Feb 2025 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740605094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjXIFbrycUalHpcnR/F5qePySLzaC2KIyI6Go0Y3H6o=;
	b=ikf0by6PP6wDzBzH4f1AW/7i/C50BiqT4SRCVXjtBq8jUBcsVS9BqRMC/ofjH0KTQiqIzR
	H0RueAaGHUHfIErOLGlCgP6uXHEhjX+2YhxbOTWqyaF2sIqaa7MXullaZFsiwz6pt8iFII
	ICoEC6T3Cw5nxBTW9AQl6sJT4Bw9PrH+CpK3saQqljwg+K7PELliMqLIEYl/1GHOi9vCvE
	sn0GJxmAiFfzOUwy5VCZITyTyiFCZkmPT6s6PYmyZ19qirlXaHncsHl3naVH/UfV4Jcy55
	gNqwDwifbgXjFk9kHk2GTgHVfgoyqfgOsZYdJabdGx+Gmq7EnTirFIEY8gMAGw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 26 Feb 2025 22:23:53 +0100
Subject: [PATCH v8 2/2] drm/debugfs: add top-level 'bridges' file showing
 all added bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-drm-debugfs-show-all-bridges-v8-2-bb511cc49d83@bootlin.com>
References: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
In-Reply-To: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhop
 ehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

The global bridges_list holding all the bridges between drm_bridge_add()
and drm_bridge_remove() cannot be inspected via debugfs. Add a file showing
it.

To avoid code duplication, move the code printing a bridge info to a common
function.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v8:
- add the file in drm_bridge.c, which avois the added #if CONFIG_DEBUG_FS
- fix incorrect (but harmless) idx increment in
  drm_bridge_debugfs_show_bridge()

Changed in v7:
- move implementation to drm_bridge.c to avoid exporting bridge_list and
  bridge_mutex

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c | 72 ++++++++++++++++++++++++++++++--------------
 drivers/gpu/drm/drm_drv.c    |  2 ++
 include/drm/drm_bridge.h     |  1 +
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index a6bf1a565e3c3a8d24de60448972849f6d86ba72..9c6e35d41ed54a14d5745e684a341c907ed84d6b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1336,6 +1336,49 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
+					   struct drm_bridge *bridge,
+					   unsigned int idx)
+{
+	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
+	drm_printf(p, "\ttype: [%d] %s\n",
+		   bridge->type,
+		   drm_get_connector_type_name(bridge->type));
+
+	if (bridge->of_node)
+		drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
+
+	drm_printf(p, "\tops: [0x%x]", bridge->ops);
+	if (bridge->ops & DRM_BRIDGE_OP_DETECT)
+		drm_puts(p, " detect");
+	if (bridge->ops & DRM_BRIDGE_OP_EDID)
+		drm_puts(p, " edid");
+	if (bridge->ops & DRM_BRIDGE_OP_HPD)
+		drm_puts(p, " hpd");
+	if (bridge->ops & DRM_BRIDGE_OP_MODES)
+		drm_puts(p, " modes");
+	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+		drm_puts(p, " hdmi");
+	drm_puts(p, "\n");
+}
+
+static int allbridges_show(struct seq_file *m, void *data)
+{
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct drm_bridge *bridge;
+	unsigned int idx = 0;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list)
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
+
+	mutex_unlock(&bridge_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(allbridges);
+
 static int encoder_bridges_show(struct seq_file *m, void *data)
 {
 	struct drm_encoder *encoder = m->private;
@@ -1343,33 +1386,18 @@ static int encoder_bridges_show(struct seq_file *m, void *data)
 	struct drm_bridge *bridge;
 	unsigned int idx = 0;
 
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
+	drm_for_each_bridge_in_chain(encoder, bridge)
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++);
 
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(encoder_bridges);
 
+void drm_bridge_debugfs_params(struct dentry *root)
+{
+	debugfs_create_file("bridges", 0444, root, NULL, &allbridges_fops);
+}
+
 void drm_bridge_debugfs_encoder_params(struct dentry *root,
 				       struct drm_encoder *encoder)
 {
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3cf440eee8a2ab3de134d925db8f1d2ce68062b7..22e8cd0a6a37a0ac25535e9d570da25571b0b2bc 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -38,6 +38,7 @@
 #include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_cache.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_color_mgmt.h>
@@ -1120,6 +1121,7 @@ static int __init drm_core_init(void)
 	}
 
 	drm_debugfs_root = debugfs_create_dir("dri", NULL);
+	drm_bridge_debugfs_params(drm_debugfs_root);
 
 	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
 	if (ret < 0)
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 0890acfe04b99b1ccbbff10b507cb8c2b2705e06..2a99d70865571f24db0ca75c758cfd09d3a5d459 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1108,6 +1108,7 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 #endif
 
+void drm_bridge_debugfs_params(struct dentry *root);
 void drm_bridge_debugfs_encoder_params(struct dentry *root, struct drm_encoder *encoder);
 
 #endif

-- 
2.48.1


