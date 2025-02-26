Return-Path: <linux-kernel+bounces-534982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB2A46D92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B52188A72C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC125D522;
	Wed, 26 Feb 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bxHhQ0ho"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA3238141
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605782; cv=none; b=qlcyoR5tydGxYr5hObTIIcafHa5c7jim3lNRB70KrLPYiMUeryudi11QgX3qGue96x97OcUPu9ykbS360hfq3UjDl/TcwxduzbVIe6G8BXNuMuK8AVPcQBxq3JLdgb2XpylFj6Ub6h3zQaOhoCLjNaJ6JNTAYaCzcLWY0rPX8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605782; c=relaxed/simple;
	bh=qVcmuTLjuGwhURV9H0HV1xExYFcR55pmtn1RROktqQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0wvn2DFntGPAvWCVO6sgq0D3hYjGX1vjpfbPVdcerG4814fwSwPsLrsxWdw9HY3pOK4uKyxQGTJ/od35ZiuHhfpoq0A625NMm83zI9yRSQ/LK84HMSndAk8yBaxc65DnO3Ha/CCarHkkmuGsescz7h5+eVbGGdDeqKWW8m2AgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bxHhQ0ho; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 76AE5581DE2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:25:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 903B344357;
	Wed, 26 Feb 2025 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740605092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xF27PRucwgAu9bdjrMgFWQV2T+OOnNTiIdeMX9W7Ig=;
	b=bxHhQ0hoQqWGwiAwtRSHdZmboq9N1U6dyUkOqL7l0iaTCanFtQ3RNwTBObJaxRk8mmj263
	i0podeQv1Kp5dSIT6vOc2z0cfSWBt+uq0JsQH6iWhUc7IVVpiO5Zex+xCX4i/JkgoQPzjm
	PkxZ6u3Nf4Vz7Tu7WhgsjHjNjKLySA+BX1I70AV54gbgg4AtUF+nRxIZ8pwoCLbgznh/MP
	UqFZrMSvzpUXSysJtr+XPfDK+oNbY/E+Y8e3ZC7UM0b2OAtYYXwmUQAd3g/KFZSA55sJRB
	r86v1jap0tuDZtILBgh9SLd6IfwGsGpgkGLhm5ohQmDh+52QVO/P9ixn/4rAhg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 26 Feb 2025 22:23:52 +0100
Subject: [PATCH v8 1/2] drm/bridge: move bridges_show logic from
 drm_debugfs.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-drm-debugfs-show-all-bridges-v8-1-bb511cc49d83@bootlin.com>
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

In preparation to expose more info about bridges in debugfs, which will
require more insight into drm_bridge data structures, move the bridges_show
code to drm_bridge.c.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v8:
 - add the file in drm_bridge.c, which avois the added #if CONFIG_DEBUG_FS

This patch was added in v7.
---
 drivers/gpu/drm/drm_bridge.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c | 38 +-------------------------------------
 include/drm/drm_bridge.h      |  2 ++
 3 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 241a384ebce39b4a3db58c208af27960904fc662..a6bf1a565e3c3a8d24de60448972849f6d86ba72 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
@@ -1335,6 +1336,47 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+static int encoder_bridges_show(struct seq_file *m, void *data)
+{
+	struct drm_encoder *encoder = m->private;
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct drm_bridge *bridge;
+	unsigned int idx = 0;
+
+	drm_for_each_bridge_in_chain(encoder, bridge) {
+		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
+		drm_printf(&p, "\ttype: [%d] %s\n",
+			   bridge->type,
+			   drm_get_connector_type_name(bridge->type));
+
+		if (bridge->of_node)
+			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
+
+		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
+			drm_puts(&p, " detect");
+		if (bridge->ops & DRM_BRIDGE_OP_EDID)
+			drm_puts(&p, " edid");
+		if (bridge->ops & DRM_BRIDGE_OP_HPD)
+			drm_puts(&p, " hpd");
+		if (bridge->ops & DRM_BRIDGE_OP_MODES)
+			drm_puts(&p, " modes");
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+			drm_puts(&p, " hdmi");
+		drm_puts(&p, "\n");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(encoder_bridges);
+
+void drm_bridge_debugfs_encoder_params(struct dentry *root,
+				       struct drm_encoder *encoder)
+{
+	/* bridges list */
+	debugfs_create_file("bridges", 0444, root, encoder, &encoder_bridges_fops);
+}
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 6b2178864c7ee12db9aa1f562e106b2f604439f8..3dfd8b34dceb7a5b8f11e3072a1eaef430869722 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -740,40 +740,6 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
 	crtc->debugfs_entry = NULL;
 }
 
-static int bridges_show(struct seq_file *m, void *data)
-{
-	struct drm_encoder *encoder = m->private;
-	struct drm_printer p = drm_seq_file_printer(m);
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
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(bridges);
-
 void drm_debugfs_encoder_add(struct drm_encoder *encoder)
 {
 	struct drm_minor *minor = encoder->dev->primary;
@@ -789,9 +755,7 @@ void drm_debugfs_encoder_add(struct drm_encoder *encoder)
 
 	encoder->debugfs_entry = root;
 
-	/* bridges list */
-	debugfs_create_file("bridges", 0444, root, encoder,
-			    &bridges_fops);
+	drm_bridge_debugfs_encoder_params(root, encoder);
 
 	if (encoder->funcs && encoder->funcs->debugfs_init)
 		encoder->funcs->debugfs_init(encoder, root);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..0890acfe04b99b1ccbbff10b507cb8c2b2705e06 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1108,4 +1108,6 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 #endif
 
+void drm_bridge_debugfs_encoder_params(struct dentry *root, struct drm_encoder *encoder);
+
 #endif

-- 
2.48.1


