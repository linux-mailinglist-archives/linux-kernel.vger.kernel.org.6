Return-Path: <linux-kernel+bounces-569955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A4A6AA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443BF3B8D06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014E1EB195;
	Thu, 20 Mar 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m18W9V4w"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D11E98EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485358; cv=none; b=UUR0BZFFtkm/hCtfyyS+9rzdbxp5WMHLwD1DII0SFSnQ9MVtY1nB4ihrKiLraEZI+y2Bg+AtDxZQ2sSXdjV7rpcqVvP9EyjkItlzWJjlBvnUvkx1ZhK3NK5ZgBclPt8Giq7S0M+D3kDjoFsBkesv1OlBSbsxKdWJCbwoZIvCBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485358; c=relaxed/simple;
	bh=d94NmL5l/c4RNcgkHzekopRG1modY77iggD4ffQWA1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r9VAm7XplGW+6fwOFoa9P8n75YdA/02H+Rn3e0rfqAosEJCuVawr5U/uKcwCL9F8l1BRfJb3+g1C5xdl2HGTQ48GhYVHpeyJNkbBKMx8F7Uequg8uADpdml9YWTB/J8hfJqC2+FULOMrO433oGGgIUBH/H4UItG56m6CgiBBY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m18W9V4w; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACB0D44408;
	Thu, 20 Mar 2025 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742485352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8mBeHfjSG+AR7A8Fp8QKLSrhvK7lhd1SXAkNAnYVLtw=;
	b=m18W9V4w7yusNw0mo6qqU9toSKUuwPKXTEBs5rlqYEFiw4yzWXhSy1EChVjxOqiubNVJjD
	pAL2KTjUrvqX1tzM1/cEkI6ZOaVEzFJ8nBLpbpADeIq/6/Ayqk9wKswVouV6NfHHNExWw5
	qayfzfiglank6Q4uNeCYNi5MXslQnDXWuQwiX8kro0kwzD5xfvJiD3cAGAxZYzlZm0yrdf
	bpSLDnc2PkZg3S7s0PDz49uSDOtQWVhv1CP5JVL4RRDpf1Y7DKDC7Uipt3XcQ5jCAXwtJw
	SKvFr4HyEtnAily0Fp+lKUbE8CL0CNj3JiMEAoILcnAW1QOGAn0KrBOE9AgrmQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v8 0/5] drm/bridge: add devm_drm_bridge_alloc() with bridge
 refcount
Date: Thu, 20 Mar 2025 16:42:09 +0100
Message-Id: <20250320-drm-bridge-refcount-v8-0-b3ddaa9f1368@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFE33GcC/32NTQ7CIBCFr9LMWgzUUqgr72G6sPzYSSwYqETTc
 HfHHsDkbb75Mu9tkF1Cl+HcbJBcwYwxEOhDA2a+hbtjaImh5a3kJ9ExmxY2JbRkkvMmvsLKpLY
 DWYrvgT6fZPC9t15H4hnzGtNnHynqd/3fVxTjTMhWKuG16YfuMsW4PjAcTVxgrLV+AR1PxK24A
 AAA
X-Change-ID: 20250314-drm-bridge-refcount-58d9503503f6
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgieetkeekgfdtudevueffueffveekheeiudfhfedvhfeukeeuhffhtddtvdekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsu
 hhsvgdruggvpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

This series improves the way DRM bridges are allocated and initialized and
makes them reference-counted. The goal of reference counting is to avoid
use-after-free by drivers which got a pointer to a bridge and keep it
stored and used even after the bridge has been deallocated.

The overall goal is supporting Linux devices with a DRM pipeline whose
final components can be hot-plugged and hot-unplugged, including one or
more bridges. For more details see the big picture [0].

DRM bridge drivers will have to be adapted to the new API -- the change is
trivial for most cases. This series converts two of them to serve as an
example. The remaining ones will be done as a follow-up after this first
part is merged.

After that, refcounting will have to be added on the two sides: all
functions returning a bridge pointer and all code obtaining such a
pointer. A few examples have been sent in v7 (link below), they are OK, but
I removed them from v8 because they must be merged only after converting
all bridges.

Here's the grand plan:

 A. add new alloc API and refcounting (this series, at least patches 1-3)
 B. after (A), convert all bridge drivers to new API
 C. after (A), add documentation and kunit tests
 D. after (B), add get/put to drm_bridge_add/remove() + attach/detech()
    (patches 3-4 in the v7 series)
 E. after (B), convert accessors (including patches 5-9 in the v7 series
    which convert drm_bridge_chain_get_first_bridge() and its users);
    this is a large work and can be done in chunks

Series layout:

 1. Add the new API and refcounting:

    drm/bridge: add devm_drm_bridge_alloc()
    drm/bridge: add support for refcounting
    drm/bridge: deprecate old-style bridge allocation

 2. convert a few bridge drivers (bridge providers) to the new API:

    drm/bridge: ti-sn65dsi83: use dynamic lifetime management
    drm/bridge: samsung-dsim: use dynamic lifetime management

[0] https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v8:
- Applied requested changes to patch 2
- Add R-by to other patches
- Removed v7 patches 3-9: they are OK but must wait until all bridge
  drivers are converted to the new API
- Added patch to deprecate old-style bridge allocation
- Link to v7: https://lore.kernel.org/r/20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com

---
Luca Ceresoli (5):
      drm/bridge: add devm_drm_bridge_alloc()
      drm/bridge: add support for refcounting
      drm/bridge: deprecate old-style bridge allocation
      drm/bridge: ti-sn65dsi83: use dynamic lifetime management
      drm/bridge: samsung-dsim: use dynamic lifetime management

 drivers/gpu/drm/bridge/samsung-dsim.c |  7 ++-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c |  7 ++-
 drivers/gpu/drm/drm_bridge.c          | 96 +++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h              | 36 +++++++++++++
 4 files changed, 138 insertions(+), 8 deletions(-)
---
base-commit: c940d00c7306a77ec293661abca634756207c885
change-id: 20250314-drm-bridge-refcount-58d9503503f6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


