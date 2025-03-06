Return-Path: <linux-kernel+bounces-549480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2ABA5530D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FCD3A9515
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1325CC69;
	Thu,  6 Mar 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JcLC4Hym"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826281DDA35
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282138; cv=none; b=ev1HaVTtTe1P/bJ1EJisthAzfK7v0Ln5P9vWi7GJkDCsCq8NdYanrpbXvJm5nBCTo6jTE4cwVY6oqdAdqqSpscpv0qC0I6knMcyL2PGDPiXRvNa9jOr7xBroaT6ibqtD11O7chlqMmxaelZiDBK2UQ5muxOFaFilLtlWQANRImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282138; c=relaxed/simple;
	bh=qnfF/zPCA5ZbDxoG2tl2pujCc76QB/jkgKmeL1Lb6Mg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3i2S7Q0nVpnCGd/6Y6LyiX+H+58iCzFjZj/vMKzReP5dD/GFL8bxTzjvIFLaeSrBrPC22CNYKsuGKKIcPcfDHYNHtvDk+78I4ZcXub8+6iHmcH91l/OHM3TeTeeyTed6HPhCQXguokAw/s2tDq9DQLm4FdOuPcSmNch15RS8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JcLC4Hym; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0340441CA;
	Thu,  6 Mar 2025 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741282127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IldYrjBrNiicEKDypgdTmvOYJP/ivQY5AR+49uR4q4s=;
	b=JcLC4Hym6wDZYoTWvWQwnoD16J/nAvplEwRb46CpXZhipbjm93flldHOu3X+STp8fRlch/
	FPXG7UCpdAbC6aIk8JGplgeHhvNtLwHR/wqsEjdu9BIk96+G3NjiaApdSNNoarwdqxEC4E
	CVe2TIwoQ5lPhp8XZOTGJlEknbdowNXyg5osqINEWUpJxaY5yho0w+MTzcdtF5Mps/VAzr
	H3AOLSy/Y0AAvhwc4wFy+YEiqXZK6UG87ejBsxmHRtMo3vA7ltP9YcYsDTzUioneoSj/zt
	3KbHGlEBuPSqW4w4ZY7m81UkbbYcKTB5MEYTQRlA0qYeJshK3TCcnRj8dAmYOA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] drm/bridge: two minor code improvements
Date: Thu, 06 Mar 2025 18:28:39 +0100
Message-Id: <20250306-drm-two-ldb-improvements-v1-0-f139d768b92c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfbyWcC/x3MwQqEIBCA4VeJOTdgLRn0KtHB1bEGUmMMW4jef
 aXjd/j/GzIJU4apuUGocOYUK7q2AbuZuBKyq4Ze9YP6KI1OAp5Xwt19kcMhqVCgeGbstDd6tFa
 R8VDzQ8jz713Py/P8AYlH8OhqAAAA
X-Change-ID: 20250306-drm-two-ldb-improvements-16fa67cc0eaf
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektedvtdfhhedvveeiveffheefffejvefgleekhfelueefveeiveefhfejtefgveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnv
 ghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series brings small improvements to two bridge drivers.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/bridge: imx8qxp-ldb: cleanup return value
      drm/bridge: fsl-ldb: make warning message more informative

 drivers/gpu/drm/bridge/fsl-ldb.c         | 6 +++---
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250306-drm-two-ldb-improvements-16fa67cc0eaf

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


