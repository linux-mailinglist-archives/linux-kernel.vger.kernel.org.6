Return-Path: <linux-kernel+bounces-561218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC40A60EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F76F7A50BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46C1F4723;
	Fri, 14 Mar 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SXGCYBYm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BD1F3BBC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948300; cv=none; b=CIE1LOoha7Jdd+xKHZjP7R45qByOqeqLzVSsXNe4WIn+gJjNJXySIlkadXoyNTYOABMf+XmWkwNPgEdR6yykHK6stiNExwDmMZYKczMbYiju/KuaR5XH8Sjca43qs8rfC22AXFYR8+3A4Oo6ERHdXk97ptdDpgbP7Z6hmH63dzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948300; c=relaxed/simple;
	bh=5uyvwxemgTqpUqNktABr6WfhWnYbZ3mov1iQJAOYkKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ae9yNtZU8TXvpj7NAeEW+AGHDk7li4qNrJbCv+z1wZjT/lSRNWPLav/4fypT81emIXERDXipW4DHcTQLbRtSgcZ2nSCtCfK3EuocOrcB923y0TrwEdN2G/Luc89eOXAnOjBgfQRq6XhboXJIeZjhTAaH3bPyt8zLpZAg6RCLJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SXGCYBYm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F38043319;
	Fri, 14 Mar 2025 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741948296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CthbDigk3FITG5KuVTASsAyTeeERAzK2HC+VVcuhugU=;
	b=SXGCYBYmcePatDk7Qgbt7nM1QWqpMxTrv2xe3Ui+mDgANRvwpsNipMx8VL5f6sENIVkLXK
	XrdkTCarGU1cTqCzC62JJeIyadFSlQFfWpSyP3OkGkZBRhUW8I+eddbx3Ky6VtrHx7CduC
	NVaqNHN/9oZm5+M8Vczzj1PZ7UcD+EJoOJpBOceZOc77ZmFT+9UuBH9ES2PPrsyATIfBmz
	gv6hueiLxdzAlNUfz/FE8YlGVu57tc3VgtYzHRUcQBTOatEYgfeCcqEB/3oJPy3swcAm1K
	cPVUfrtpKn+HOamuLzoOcTw/MNXS2Q8MiX3PS7Ft1+ifM4/OEgegLRfYvr6D/Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Mar 2025 11:31:14 +0100
Subject: [PATCH v7 01/11] drm/bridge: add devm_drm_bridge_alloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-bridge-refcount-v7-1-152571f8c694@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepihhnkhhirdgurggvsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehjvghrn
 hgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhksehshihsqdgsrghsvgdrihhopdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgv
X-GND-Sasl: luca.ceresoli@bootlin.com

Add a macro to allocate and initialize a DRM bridge embedded within a
private driver struct.

Compared to current practice, which is based on [devm_]kzalloc() allocation
followed by open-coded initialization of fields, this allows to have a
common and explicit API to allocate and initialize DRM bridges.

Besides being useful to consolidate bridge driver code, this is a
fundamental step in preparation for adding dynamic lifetime to bridges
based on refcount.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v7:
- in v6 this was part of "drm/bridge: add support for refcounted DRM
  bridges", now split to a separate patch
---
 drivers/gpu/drm/drm_bridge.c | 22 ++++++++++++++++++++++
 include/drm/drm_bridge.h     | 17 +++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index ea9525ec16b5272d12a21a66913ada38e74e80bc..96df717b2caeb41d45346ded576eaeb2806fd051 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -199,6 +199,28 @@
 static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
 
+void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
+			      const struct drm_bridge_funcs *funcs)
+{
+	void *container;
+	struct drm_bridge *bridge;
+
+	if (!funcs) {
+		dev_warn(dev, "Missing funcs pointer\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	container = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-ENOMEM);
+
+	bridge = container + offset;
+	bridge->funcs = funcs;
+
+	return container;
+}
+EXPORT_SYMBOL(__devm_drm_bridge_alloc);
+
 /**
  * drm_bridge_add - add the given bridge to the global bridge list
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b0d86a685a41e3172e0aa15d1c9a5ae8e959255a..dae463b30542d586a595b67f7bdf5a5e898e9572 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -941,6 +941,23 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 	return container_of(priv, struct drm_bridge, base);
 }
 
+void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
+			      const struct drm_bridge_funcs *funcs);
+
+/**
+ * devm_drm_bridge_alloc - Allocate and initialize a bridge
+ * @dev: struct device of the bridge device
+ * @type: the type of the struct which contains struct &drm_bridge
+ * @member: the name of the &drm_bridge within @type
+ * @funcs: callbacks for this bridge
+ *
+ * Returns:
+ * Pointer to new bridge, or ERR_PTR on failure.
+ */
+#define devm_drm_bridge_alloc(dev, type, member, funcs) \
+	((type *)__devm_drm_bridge_alloc(dev, sizeof(type), \
+					 offsetof(type, member), funcs))
+
 void drm_bridge_add(struct drm_bridge *bridge);
 int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);

-- 
2.48.1


