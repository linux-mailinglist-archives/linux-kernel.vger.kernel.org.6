Return-Path: <linux-kernel+bounces-514977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E295A35E45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476341896624
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C46265CA2;
	Fri, 14 Feb 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MGob5DAY"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92830265619
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537884; cv=none; b=fCa9BVfSo4odSXxl9YIIjiZDNKd0C08iF4MWxu69UT6YVxWzq0umS+mfXuboeYHJ6B/wwVvGCjUsSzYt5pDUojGg9YirVdBZ1xliutP5oDzVxkiTLLl0HD8C2EmtkhIwwNQZ/IuNnxugDuqcNtszDnKe7Y90BnzLo8xtB9p8LEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537884; c=relaxed/simple;
	bh=0FzmlmjHgsSOEqIGlKVGxNm+yZCYAekcmp2IYH33eq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TOziL7toIKSTJeUgalV2FArHwwazZnYC1md+sU6fA/cT97GdMM+zbITKzsxITVD1FeGBmik6I20X4nCk3Sk5vV5jCt9QZGfsI3N9Bid8BH16tyvqFncQyfK2ffchBATOSjdAZZCS+tVQOHO3MUff13ewzcCvFnM4Lt476YvIn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MGob5DAY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E066944202;
	Fri, 14 Feb 2025 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739537875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ze9+bc3E0f1wMT/AFQmpj05iI6Vym9TYkA30cm3okpc=;
	b=MGob5DAYjn9kmQfSTza6aFopPVe1JLQduVKyj95rg5VxF2ULFGvfOmAuoBDNPgg/Q96KBX
	bosCbojwpnCDMQ8xbHmsza5ybVSPCxtJdsVcHt+ZzlGgLGKucT1TX/SrzYEg6sEDx9fJO6
	TRCG3e2CFWz25Az9C8nPPoZZcxMrPtec75YI22Ozd7Clhlrk/BPF/EFEsIryf7zoEKOu6p
	gGv0yokHGDDZIrqsZf5e1HXQxmrqBmlHUN3feaHrwPmyOLfsh3qyg4IlEJsPl1eBJBDn9E
	AESmuf7KgHBIzOELnwiYgqHOyvjkgCOUbuI/lcrQkLi+Mp2BqQq0kI9fyDCyzQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 0/5] drm: small cleanups and improvements
Date: Fri, 14 Feb 2025 13:57:39 +0100
Message-Id: <20250214-drm-assorted-cleanups-v7-0-88ca5827d7af@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMM9r2cC/x3MQQqDQAxA0atI1gZ0sFa8irhIJ6kN6CiJSkG8e
 4cu3+L/C1xMxaEvLjA51XVNGc+ygPihNAkqZ0OowqMKdYNsC5L7arswxlkoHZsjc8ud1K+GOoL
 cbiZv/f6/w3jfPxP60gZnAAAA
X-Change-ID: 20250214-drm-assorted-cleanups-dd6d8e1b4a8a
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeiteekkefgtdduveeuffeuffevkeehieduhfefvdfhueekuefhhfdttddvkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughri
 hdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

This series collects some minor improvements and fixes previously part of
[0], hence the "v7" version number.

All of these patches already have some Review/Ack tags.

[0] https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (5):
      drm/debugfs: fix printk format for bridge index
      drm: of: drm_of_find_panel_or_bridge: move misplaced comment
      drm/bridge: panel: use drm_bridge_is_panel() instead of open code
      drm/bridge: panel: drm_panel_bridge_remove: warn when called on non-panel bridge
      drm/bridge: panel: forbid initializing a panel with unknown connector type

 drivers/gpu/drm/bridge/panel.c | 4 +++-
 drivers/gpu/drm/drm_debugfs.c  | 2 +-
 drivers/gpu/drm/drm_of.c       | 2 +-
 drivers/gpu/drm/drm_panel.c    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250214-drm-assorted-cleanups-dd6d8e1b4a8a

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


