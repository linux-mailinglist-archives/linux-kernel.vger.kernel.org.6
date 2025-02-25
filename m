Return-Path: <linux-kernel+bounces-531848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3FA445C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0E81898481
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86D1925BA;
	Tue, 25 Feb 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lV7ur9NU"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EE18DB16
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500194; cv=none; b=Qe9vMggwE79bxeDdhsYRhP5nhkHjyxpzAShKwY4PH4Yy8jlZFmBthnX8D65ed+QX6Sn7oYZzHmuItzjWeLp43bbAmUXRxQm1NQ9BiGG1kcn1OMY9yK2UpGMoMxBsRuGA0/NbrOeFjoX/oj6zgCpjiX3UKY8Pfe9tIRloT/fiCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500194; c=relaxed/simple;
	bh=Kx4OPgion81hg5VjdHjgBMUbmIuUnMOyOfk/1SHiXqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC+xPtt9hHw9yGNqHHRfocnzu1kXyLbbOqG/TbFqgxykB6mKvg9sErj/dCgid8owUdgYIskwHgi5Ea1u+ikCGg5+iUZAQQAHsVuzNCfsKNdFpB1Uoz6h/zFfNm6jqDU4RbHODQTRFok1G0sh8ECDaZZE+2kKnPpSTZ7TanDBqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lV7ur9NU; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C1F04444C;
	Tue, 25 Feb 2025 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740500189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P47nfS/ZAsV+GTxWNuPgcmN1fCcMjl+aug3aE0THhzE=;
	b=lV7ur9NUtth9szWs6vO36L/EiIJEWr0r8G1lriaqT9kmfZaaM8q9BCxKZXbKL+z2Qlh4V/
	alnX/7F2hXjp1p+pVnsOie7f+HBNrHZdTkpURZLfpo2FeuO1Y9QR8uKttLJc8VaZTYahVL
	Toj409E/SG3H33lNYbUSILQm/XNEKgXsURdn1niN5fa8ZZShtWYMPEHEbAy1Yk8MF4hydQ
	kYwAvUXueI35ZKX5611ijS6APX1muBLK5GtJxGlkiDR53485/0ZT4oPIUWujRz0H5WdkDe
	UKJfDdt6YZsM4IVNCJ9B8/js+SIV/Fl3nzzjlhVTiimEm++9LMHy/2SHi3oKlQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 25 Feb 2025 17:16:21 +0100
Subject: [PATCH v7 2/2] drm/debugfs: add top-level 'bridges' file showing
 all added bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-drm-debugfs-show-all-bridges-v7-2-8826037ada37@bootlin.com>
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

The global bridges_list holding all the bridges between drm_bridge_add()
and drm_bridge_remove() cannot be inspected via debugfs. Add a file showing
it.

To avoid code duplication, move the code printing a bridge info to a common
function.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v7:
- move implementation to drm_bridge.c to avoid exporting bridge_list and
  bridge_mutex

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c   | 64 +++++++++++++++++++++++++++---------------
 drivers/gpu/drm/drm_debugfs.c  | 15 ++++++++++
 drivers/gpu/drm/drm_drv.c      |  1 +
 drivers/gpu/drm/drm_internal.h |  5 ++++
 include/drm/drm_bridge.h       |  2 ++
 5 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6e1e02c1cf443fbaa764765ad369b7a34cc03f2d..c840b020cd1c9a39212ad90cca54aa93de2475cd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1336,36 +1336,56 @@ EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
 #ifdef CONFIG_DEBUG_FS
+static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
+					   struct drm_bridge *bridge,
+					   unsigned int idx)
+{
+	drm_printf(p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
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
 void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
 					     struct drm_encoder *encoder)
 {
 	struct drm_bridge *bridge;
 	unsigned int idx = 0;
 
-	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
-		drm_printf(p, "\ttype: [%d] %s\n",
-			   bridge->type,
-			   drm_get_connector_type_name(bridge->type));
-
-		if (bridge->of_node)
-			drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
-
-		drm_printf(p, "\tops: [0x%x]", bridge->ops);
-		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
-			drm_puts(p, " detect");
-		if (bridge->ops & DRM_BRIDGE_OP_EDID)
-			drm_puts(p, " edid");
-		if (bridge->ops & DRM_BRIDGE_OP_HPD)
-			drm_puts(p, " hpd");
-		if (bridge->ops & DRM_BRIDGE_OP_MODES)
-			drm_puts(p, " modes");
-		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
-			drm_puts(p, " hdmi");
-		drm_puts(p, "\n");
-	}
+	drm_for_each_bridge_in_chain(encoder, bridge)
+		drm_bridge_debugfs_show_bridge(p, bridge, idx++);
 }
 EXPORT_SYMBOL(drm_bridge_debugfs_show_encoder_bridges);
+
+void drm_bridge_debugfs_show_all_bridges(struct drm_printer *p)
+{
+	struct drm_bridge *bridge;
+	unsigned int idx = 0;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list)
+		drm_bridge_debugfs_show_bridge(p, bridge, idx++);
+
+	mutex_unlock(&bridge_lock);
+}
+EXPORT_SYMBOL(drm_bridge_debugfs_show_all_bridges);
 #endif
 
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a625c0c9a9aa076af19c8ba47564dbb24ba71c9a..74aa38ca96d23d1e7f9862ad092e72c106053fe7 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -779,3 +779,18 @@ void drm_debugfs_encoder_remove(struct drm_encoder *encoder)
 	debugfs_remove_recursive(encoder->debugfs_entry);
 	encoder->debugfs_entry = NULL;
 }
+
+static int allbridges_show(struct seq_file *m, void *data)
+{
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	drm_bridge_debugfs_show_all_bridges(&p);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(allbridges);
+
+void drm_debugfs_global_add(struct dentry *root)
+{
+	debugfs_create_file("bridges", 0444, root, NULL, &allbridges_fops);
+}
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3cf440eee8a2ab3de134d925db8f1d2ce68062b7..9b6d7bd16ba409b6a9155a9fecbec6bfdd5ea0c2 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1120,6 +1120,7 @@ static int __init drm_core_init(void)
 	}
 
 	drm_debugfs_root = debugfs_create_dir("dri", NULL);
+	drm_debugfs_global_add(drm_debugfs_root);
 
 	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index b2b6a8e49dda46f1cb3b048ef7b28356dd3aaa4e..4c9c56b68ec1149a2def8cdcbdeda4946dbffb10 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -196,6 +196,7 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc);
 void drm_debugfs_crtc_crc_add(struct drm_crtc *crtc);
 void drm_debugfs_encoder_add(struct drm_encoder *encoder);
 void drm_debugfs_encoder_remove(struct drm_encoder *encoder);
+void drm_debugfs_global_add(struct dentry *drm_debugfs_root);
 #else
 static inline void drm_debugfs_dev_fini(struct drm_device *dev)
 {
@@ -241,6 +242,10 @@ static inline void drm_debugfs_encoder_remove(struct drm_encoder *encoder)
 {
 }
 
+static inline void drm_debugfs_global_add(struct dentry *drm_debugfs_root)
+{
+}
+
 #endif
 
 drm_ioctl_t drm_version;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 23c062853e7bb42d8d73af35ef7f16fb37345a37..9dd2654d1cd7212fb798432110776e5818fcb5a0 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1111,9 +1111,11 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 #ifdef CONFIG_DEBUG_FS
 void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
 					     struct drm_encoder *encoder);
+void drm_bridge_debugfs_show_all_bridges(struct drm_printer *p);
 #else
 static inline void drm_bridge_debugfs_show_encoder_bridges(struct drm_printer *p,
 							   struct drm_encoder *encoder) {}
+static inline void drm_bridge_debugfs_show_all_bridges(struct drm_printer *p) {}
 #endif
 
 #endif

-- 
2.48.1


