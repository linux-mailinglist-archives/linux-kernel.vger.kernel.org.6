Return-Path: <linux-kernel+bounces-569959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CEA6AA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7A08A6170
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13C223327;
	Thu, 20 Mar 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BOwk98/T"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295C21D3E2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485363; cv=none; b=K+ELCnZDCoO0Ok1yy9vyp7eji+vSJMRBnL7l2gj3RWB0G59KK4J2W3X4fp5qutZcdh6GEYKm1LPXj9HCmp0LosAhk2L0xDINdlwLXillEr00QQNfg1YtENczzfNMHQ/06i8EA00zQRLJLgr1c38OFc1+nsYcbsWziq02wD9N/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485363; c=relaxed/simple;
	bh=h/LzKZbNTgj+gZc92rlcauCerhCDhQNVV9eF+GpfrE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOIMfFYScWe0eMNSbOcBsOtoMAwxT0WjGyMQIgGOrLdhEbyCQRhlXtX9qA4IKJKZlyfPMbAc9sJGhwRh0uP3DYGebi+Zkr0enFXo9mlCA5s4CCKn4zmpVvebLJH+lIaipvGk+9rR+rXaIFGVtc24mJbRzW+aFzoKE/m2WJ3r4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BOwk98/T; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E2B444417;
	Thu, 20 Mar 2025 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742485359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyBNDLsArbdd7WHk93rkhCfp9ThfO49YHtAhELFf8JY=;
	b=BOwk98/TpGkOxzJx4oiUhpGhy8r0YMvaGQJYOINSzpbd20HMenb3xP12VjS//hVhI72Iam
	t9Dpvqpn8S9iRISG6Tg5phGO/QXvlbJB2vfZGxLCXG957uZvZcbWhedktWUQnkjPAoXxIs
	HkQAv1VRQ7IgMzM3YKaxo4NQO0jqfvwhuwPuz9VTzVxZXedGBuvGeTx06uh/oLs4vzRkd5
	JxTYtaW0T0J4NlVjtMed+UKicoT37q+vyPsn0wG71dm+a7wyCghXMAbpy1ZMeukJ1pdC8t
	Qkzr8akHHSnnpISG93yuGxJDUJ54W0Ipu4fHEWwA6kW7Ab289RadMxvwAhSdfQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 20 Mar 2025 16:42:12 +0100
Subject: [PATCH v8 3/5] drm/bridge: deprecate old-style bridge allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-drm-bridge-refcount-v8-3-b3ddaa9f1368@bootlin.com>
References: <20250320-drm-bridge-refcount-v8-0-b3ddaa9f1368@bootlin.com>
In-Reply-To: <20250320-drm-bridge-refcount-v8-0-b3ddaa9f1368@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehimhigs
 ehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

All DRM bridges are now supposed to be allocated using
devm_drm_bridge_alloc(), which is cleaner and necessary to support
refcounting.

Deprecate old school allocation using kzalloc and derivatives. In the
absence of a drm_bridge_init() or such initialization function, document
the deprecation on the first DRM bridge core function that is called after
allocation, i.e. drm_bridge_add().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v8.
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 2f2ecb73308e601b1a53ec8e7110933cef59b5da..17659b1cbdeae04e10b76f2aabc8ebba65c4f6e1 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -295,6 +295,10 @@ EXPORT_SYMBOL(__devm_drm_bridge_alloc);
  * drm_bridge_add - add the given bridge to the global bridge list
  *
  * @bridge: bridge control structure
+ *
+ * The bridge to be added must have been allocated by
+ * devm_drm_bridge_alloc(). Old-style allocation by kzalloc(),
+ * devm_kzalloc() and similar is deprecated.
  */
 void drm_bridge_add(struct drm_bridge *bridge)
 {

-- 
2.48.1


