Return-Path: <linux-kernel+bounces-531845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516BA445C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D855188A8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28218DB14;
	Tue, 25 Feb 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PdKBO7Z4"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4816631C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500191; cv=none; b=QbWWaCEjCDDskcKjsG7ANTo2BpjDrsUzFFLFkgXS/O7CI45jj6aPcJDxJj8aP6VNTBnHx46AqTgVZ5iW+Njg9x0KqhmGi14wrk5C2GTP5omIRVOTR6uMYKExVUI7lPM4anLAGZhjCE/vMaDvzn1CQAYO4aZI72UGMjHA8VGbTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500191; c=relaxed/simple;
	bh=I4Uy1S7IiMhOj795m3dU0p7E0Uti1BXB8xu5eONNUrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qDEqLlm8SaNZxsKFR6/Ck/M7FAJKhC+eNa0ZhGGM45Qm4u4ya2mSsCXI4fhBFHZTzavxplwVbemkO9pWnSks1pGK/UroJwZ1pagrXX7tAjFQangbjcFfKWckUYPjq9+d1W2bwlgLAaq+3nxluUqfk9yEw6ahPEdfBjPuSaVI60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PdKBO7Z4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFC1944438;
	Tue, 25 Feb 2025 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740500186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LEEmVMpK44qBCwoC1CS4003TvI/41r2AeqpMRBQ8hIo=;
	b=PdKBO7Z4QCUvs4jYNY5II5co/Kw9570Qj7Ms++qWFDnDUe94KhHcgHNCsVFqRpIXfkIfZP
	3Ojr4TzLDXZG6bYSTemOKyc3f0Ne/MDvXWBf7d26K5A5pLtfV1Qq3f7k5uqovyW0/n7Hdn
	ff1yhaEdnPb5UjIyKj6ivu+cR9xIrp1saXEbtWokP61pT/DDPx/d/roff/uTMkHSkiAOGD
	aCu1xHml78dmmCdVyQAuapsXlJ9XqgIw42kzIkd9u0R0vU3r2+MsEqDhv1GLcOpB8cyKc9
	zay5p0W6ch57izcf9yI3VZF0+IOPDvzbU0FmFKKPQQblbRisTTwFqJG5bGICzg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 0/2] drm: show "all" bridges in debugfs
Date: Tue, 25 Feb 2025 17:16:19 +0100
Message-Id: <20250225-drm-debugfs-show-all-bridges-v7-0-8826037ada37@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPsvWcC/x3MwQqCQBAG4FeROTewDdpGrxId3PZ3HTCNGSxBf
 PeWjt/l28lhCqdbs5Pho67LXBFPDT3Hfi5gzdUkQbog0nG2F2ektQzOPi5f7qeJk2kucL60gms
 MKZ4RqRZvw6Dbv78/juMHrMOTRG4AAAA=
X-Change-ID: 20250225-drm-debugfs-show-all-bridges-642e870b71e7
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfeiteekkefgtdduveeuffeuffevkeehieduhfefvdfhueekuefhhfdttddvkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiii
 ihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughmihhtrhihrdgsrghrhihshhhkohhvsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

This series collects some minor improvements and fixes previously part of
[0], hence the "v7" version number.

It adds a /sys/kernel/debug/dri/bridges file showing all bridges between
drm_bridge_add() and drm_bridge_remove(), which might not be bound to any
encoder and thus not visible anywhere in debugfs.

[0] https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/bridge: move bridges_show logic from drm_debugfs.c
      drm/debugfs: add top-level 'bridges' file showing all added bridges

 drivers/gpu/drm/drm_bridge.c   | 53 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c  | 42 ++++++++++++++-------------------
 drivers/gpu/drm/drm_drv.c      |  1 +
 drivers/gpu/drm/drm_internal.h |  5 ++++
 include/drm/drm_bridge.h       | 10 ++++++++
 5 files changed, 86 insertions(+), 25 deletions(-)
---
base-commit: 09c117e66c48bfdccc41b380d6300f0a1011ec7e
change-id: 20250225-drm-debugfs-show-all-bridges-642e870b71e7

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


