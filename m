Return-Path: <linux-kernel+bounces-551309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A90DA56AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E73E174381
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492921C180;
	Fri,  7 Mar 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oYwtdnfV"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54266219E93;
	Fri,  7 Mar 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359296; cv=none; b=GdbmLoPLV0C+pIBrhqt//VCuZ8ZOdKFR3iNpTkXxOxpeqQ/C+Xgp+B9nDJQ6KIC2n6M7eLr805ygofEOeoS+Gcyh8lmAECo6TORE3AhTxtz+eNHSM6nVQNnexr5F8F/4VkHtoHoStceyo3+Ha0ZPcrHjj2DFcvc9FIKbIWoYOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359296; c=relaxed/simple;
	bh=5FmUiAMDyYRwTjhZe3krhibN9ZcwiQ03VmMnruG5Wdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ugQuhHHUgF1lAgoSKFmsV7udcB6VcJn0MT3pflbRvXjum4Y6cY2tm0Zk4L8S9n9SRSXPagxZmspl1ECpxasu48yT0vA6uTbfYfijLJqpA3HcAx7k1yBZMkzT4zgCu4wtqtCwgFJ7KT552MwVnKkn7rhhVjPWi6dt1Mq/QZyrsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oYwtdnfV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E2884431A;
	Fri,  7 Mar 2025 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741359292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BjkypQfzRJxgBfqmsHQ4+JuDYpzLw2y1hlLxWJbh47Q=;
	b=oYwtdnfVBnhp+4txWVrQBrkhbDeEGCXy5grBSQ7pcnut3O58djojwJ7DkeQkuXhUed+A0h
	FD3TNTYfMH3udNyDX2UaX1qRRY17slT+zeM4vZELiysmlXgptTY6IE3W/jluzfNJL0IJ6A
	1vfLaFaRhV2/tSViRiXMPDLfdopiPMwoEHayb1y8uskvRr45YLhPx8nRVtHQTjd0N29sWB
	r4dPh07mKVKqjZsmuDynKtRYFSrnuvcc/F15CRAHmGhnDJIR5aeizMk3LfG8QtAs1KdcWS
	m9azIrMi9Gbf7gzbTD14cjIdGWNtDaQqCOcu3t8VmnGhTrplwzSEiYM55BwjCQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm/panel: simple: add Tianma P0700WXF1MBAA and
 improve Tianma TM070JDHG34-00
Date: Fri, 07 Mar 2025 15:54:46 +0100
Message-Id: <20250307-tianma-p0700wxf1mbaa-v1-0-1c31039a3790@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYIy2cC/x3MTQ5AMBBA4avIrDUZpP6uIhZDp8xCSSs0EXfXW
 H6L9x4I7IUD9NkDni8JsruEIs9gXsktrMQkQ4mlxgobdQq5jdSBDeIdbbFNRAp1PXHbWsO2g5Q
 enq3EfzuM7/sBrruYrmYAAAA=
X-Change-ID: 20250307-tianma-p0700wxf1mbaa-056be88fdef9
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Pu, Hui" <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektedvtdfhhedvveeiveffheefffejvefgleekhfelueefveeiveefhfejtefgveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepjfhuihdrrfhusehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomhdprhgtphhtthhop
 egrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This short series adds power on/off timings to the Tianma TM070JDHG34-00
panel and adds support for the the Tianma P0700WXF1MBAA panel.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      dt-bindings: display: simple: Add Tianma P0700WXF1MBAA panel
      drm/panel: simple: Tianma TM070JDHG34-00: add delays
      drm/panel: simple: add Tianma P0700WXF1MBAA panel

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 39 +++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250307-tianma-p0700wxf1mbaa-056be88fdef9

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


