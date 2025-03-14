Return-Path: <linux-kernel+bounces-561217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736CA60EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E816FA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7F1F1934;
	Fri, 14 Mar 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FZ1oz6ZJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D01D5CDE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948298; cv=none; b=d3igqw17mn5CNFz6eByu9W6zVJDEJ2MtyQGJ1TLQ+Ixbsp3m2gc1ZlNnm/GFfpS5+PbltiU0f3P7BBlvrLaDlQIj9w1ZEQPUviGI/HtrzvRbiI5IWbidvO7JLjzrtdZ3jdh3reya7ZxqVOOHP05+pLUlLDc3Xn6WgeQcq53Ix30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948298; c=relaxed/simple;
	bh=Phm7Ff0xccwaAEmV6NyMl/QCQm0KGjedhoTKD/LQUhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GwL8boTmK76I5saXl9vsnVSkarIygkxNywaEtTqIS0a9didWLpGSP6LrI6MLZ37lV2e5Qp9l3kv0SaxB5SDMipolk9C+6qOktsZQDl7UCcy/gxbXAaVE+SS7mnQJ+3LXKPgYqNPbRGclbltc084XNidOe0aPj9o08oCWp3KacZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FZ1oz6ZJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C100143304;
	Fri, 14 Mar 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741948294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yEpZ4juRT6fBQZCKbXYpQBMIgNr/IaPoGPb+iKoyN+0=;
	b=FZ1oz6ZJsLewFtIdk4nCngYSG2+5EYWvhjJqyQfghuW7BeHzHc8uCudW8yTbDISu0ZadgA
	WGx8ZuM1LNfHJUODHwoqKB2jjwlpDiDzvm7aXT1vqK9Dfhq8461JWNG9+ppm8xA7yyerZ8
	+e7Uj1i3s+LStsWWjUQbGEZ5W1Q2aFXaQdK2d56rPTwEEydTtZ90PzZayYL/Nszxp847oG
	zqZsoL6sr/fgNa1jZIE4t1rfWg+8+DHy9QdaDp0kbulKPTnVWDqolVf/r1jSyjvgeWsV7B
	v+lsG7N3ktEu1PI0FL07j6D343uTXU3VEOnS1Dz/X/hA6i/FfVXeTubtmybGsA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 00/11] drm/bridge: add devm_drm_bridge_alloc() with
 bridge refcount
Date: Fri, 14 Mar 2025 11:31:13 +0100
Message-Id: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEF1GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3ZSiXN2koswUoExRalpyfmleia6pRYolUBaI0syUgDoLgDKZFWB
 To2NrawGhZXyjZQAAAA==
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgieetkeekgfdtudevueffueffveekheeiudfhfedvhfeukeeuhffhtddtvdekfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgdttddvmedusggrjeemgeekfhejmedulegthedphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehinhhkihdruggrvgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehmrghrvgigseguv
 ghngidruggvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlkhesshihshdqsggrshgvrdhiohdprhgtphhtthhopegrshhrihhvrghtshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvg
X-GND-Sasl: luca.ceresoli@bootlin.com

This series improves the way DRM bridges are allocated and initialized and
makes them reference-counted. The goal of reference counting is to avoid
use-after-free by drivers which got a pointer to a bridge and keep it
stored and used even after the bridge has been deallocated.

The overall goal is supporting Linux devices with a DRM pipeline whose
final components can be hot-plugged and hot-unplugged, including one or
more bridges. For more details see the big picture [0].

DRM bridge drivers will have to be adapted to the new API, which is pretty
simple for most cases. Refcounting will have to be adopted on the two
sides: all functions returning a bridge pointer and all code obtaining such
a pointer. This series has just an overview of some of those conversions,
because for now the main goal is to agree on the API.

Series layout:

 1. Add the new API and refcounting:

    drm/bridge: add devm_drm_bridge_alloc()
    drm/bridge: add support for refcounting

 2. get/put the reference in basic operations in the bridge core:

    drm/bridge: get/put the bridge reference in drm_bridge_add/remove()
    drm/bridge: get/put the bridge reference in drm_bridge_attach/detach()

 3. as an example of changes for bridge consumers, get a reference for the
    bridge returned by drm_bridge_chain_get_first_bridge(), have it put by
    all callers (all users will be covered later on separately):

    drm/bridge: add a cleanup action for scope-based drm_bridge_put() invocation
    drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bridge()
    drm/mxsfb: put the bridge returned by drm_bridge_chain_get_first_bridge()
    drm/atomic-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
    drm/probe-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()

 4. convert a few bridge drivers (bridge providers) to the new API:

    drm/bridge: ti-sn65dsi83: use dynamic lifetime management
    drm/bridge: samsung-dsim: use dynamic lifetime management

This work was formerly a part of my v6 DRM bridge hotplug series[0], now
split as a standalone series with many improvements, hence the "v7" version
number.

[0] https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (11):
      drm/bridge: add devm_drm_bridge_alloc()
      drm/bridge: add support for refcounting
      drm/bridge: get/put the bridge reference in drm_bridge_add/remove()
      drm/bridge: get/put the bridge reference in drm_bridge_attach/detach()
      drm/bridge: add a cleanup action for scope-based drm_bridge_put() invocation
      drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/mxsfb: put the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/atomic-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/probe-helper: put the bridge returned by drm_bridge_chain_get_first_bridge()
      drm/bridge: ti-sn65dsi83: use dynamic lifetime management
      drm/bridge: samsung-dsim: use dynamic lifetime management

 drivers/gpu/drm/bridge/samsung-dsim.c |   7 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c |   7 +-
 drivers/gpu/drm/drm_atomic_helper.c   |   5 ++
 drivers/gpu/drm/drm_bridge.c          |  74 +++++++++++++++++++--
 drivers/gpu/drm/drm_probe_helper.c    |   1 +
 drivers/gpu/drm/mxsfb/lcdif_kms.c     |   3 +-
 include/drm/drm_bridge.h              | 119 +++++++++++++++++++++++++++++++++-
 7 files changed, 201 insertions(+), 15 deletions(-)
---
base-commit: 9e6d91c60b0d64a4f945663993b3bbf4f3fb7392
change-id: 20250314-drm-bridge-refcount-58d9503503f6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


