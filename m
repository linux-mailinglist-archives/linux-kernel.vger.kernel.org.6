Return-Path: <linux-kernel+bounces-534981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43710A46D91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC563A7787
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998425B663;
	Wed, 26 Feb 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KXVsMGRz"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5720DD7A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605781; cv=none; b=PNFdGRx1s6lJ6WMe5UwqSxKVwxmaV/Ng4JILTokI63Nm5mm4GnRbzinQD6VtnMyxFDQ1mWNqcZ1MpD5n7Jai+CME0KrIQKrdOwiKHu13C7KjGSLrIJXqZhfVSMOddaq48beWL9xA5UIMtobp0RzcQgDEuhFUafVto/GLsG3hA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605781; c=relaxed/simple;
	bh=vZGnJx5kd0tFgk25pQJmZLmcAZ8Ky1L2n9kLxIp8Ntk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hur1knt5CWIzaX+hjlY3zeCxNoTgbIfGAw/Vho/dA3eR/Og7DPC59LdQyyRTVMq2hptikK17E7hZmqKgnk2VRpV4owtqaefvKMlR0ME5k6xM8I20Ly1dWIlG8J0hVdqqRTnqbEL/HIbMpX91FlQGotIUDQuf1Nbyfe3gVqI7rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KXVsMGRz; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id E0A795819D8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:24:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3245644359;
	Wed, 26 Feb 2025 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740605091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgXFCdjVREXcRGUE0JevXJ8e89l3cM/elkjd9RzCGfY=;
	b=KXVsMGRz0Wxm2TObr9aSrau2qKoYmUNE+2C8hol5lxYBa6QSWTA/wphd/Sl33TGMisCfoA
	beltHL40H3Vs0GViZ+kGQQaDo309XhwS2P14m8G0Iym0nFIclkv5H9XnK3h2GUGh6cfF6S
	0iG9wh+/BnutFc1vlKQ4Yrm23RFs/3h7B2uWRaHabfffwXc2Z0Qzci+3E+yLd5EGVFO5L1
	wvadvFnb5CRxQIucNQcm9nrzQ0HNy5M39I1xG6Nl1dkb+Pb9i/uVBiys3F3AaUkfdgPiHm
	NiJeHUti0TsB4PP3/ukKorxpyq1gfRcaxro6ItmP+PEI/u0EudDO6aEcVQ7TAQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v8 0/2] drm: show "all" bridges in debugfs
Date: Wed, 26 Feb 2025 22:23:51 +0100
Message-Id: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeGv2cC/43NQQ6CMBCF4auYWTumFqGNK+9hWLR0gEmAmg6ih
 nB3Kydw+b3F/1YQSkwC18MKiRYWjlOGPR6g6d3UEXLIBq10qbQuMaQRA/ln1wpKH1/ohgF94tC
 RYHXRZI3y5kwGcuKRqOX3nr/X2T3LHNNnf1vMb/0zvBhUaK2uVGFccIW5+RjngadTE0eot237A
 hzNoLfKAAAA
X-Change-ID: 20250225-drm-debugfs-show-all-bridges-642e870b71e7
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeiteekkefgtdduveeuffeuffevkeehieduhfefvdfhueekuefhhfdttddvkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigr
 dhinhhtvghlrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This series adds a /sys/kernel/debug/dri/bridges file showing all bridges
between drm_bridge_add() and drm_bridge_remove(), which might not be bound
to any encoder and thus not visible anywhere in debugfs.

It also cleans up the DRM bridge debugfs code by moving code to
drm_bridge.c.

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v8:
- moved more code to drm_bridge.c, which makes adding '#if CONFIG_DEBUG_FS' unnecessary
- a small fix to a harmless bug
- Link to v7: https://lore.kernel.org/r/20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com

This series was initially part of v6 of this other series:
- Link to v6: https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

---
Luca Ceresoli (2):
      drm/bridge: move bridges_show logic from drm_debugfs.c
      drm/debugfs: add top-level 'bridges' file showing all added bridges

 drivers/gpu/drm/drm_bridge.c  | 70 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c | 38 +----------------------
 drivers/gpu/drm/drm_drv.c     |  2 ++
 include/drm/drm_bridge.h      |  3 ++
 4 files changed, 76 insertions(+), 37 deletions(-)
---
base-commit: b439ab75b6382f5c34aec6e87435cf7e58e72a35
change-id: 20250225-drm-debugfs-show-all-bridges-642e870b71e7

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


