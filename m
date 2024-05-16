Return-Path: <linux-kernel+bounces-180672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E18C719E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60C31F217CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF42C697;
	Thu, 16 May 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="E1z0LPal";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LMfjlKy4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E37225D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840718; cv=none; b=lewiZ5cpeFyoWF/GBgP8svu4Cc8FhuLuPKyIoHRJl7ko4UjYe/rpJdeCB/Po5iI+YO9QmVPN/VVxdn+HwCT/cuqDW08xu0r2hai9E1AImYOcSDT1r0OuH+2fFB3/fm1qhB0Lq0fCBKXMbXM9w6hsI3W0yWFJarT9BEC5hVSUpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840718; c=relaxed/simple;
	bh=gjTBTFOmFlUHEWlJWq5ipC//VVCiq4P3QuH99HQTlNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKr+Y1Mta4MG8mFrqp04AdP4nkemJYfVBNHw8cR79vGbIm3VzQXLiHi2d5m8Ikb9fgk0j6a2nIkrB/7LaAGvJ25Kbv74OdJwMI0zljz8tImwTORwX544p3EUUWMOTSN1/ljKW949M0FvXUeUVJBl3rNld7SgxoXs2cN76Ck/Q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=E1z0LPal; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LMfjlKy4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715840715; x=1747376715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivJGdfB0We0kranfdHPe4hL+Enb5dv3W/8BGkP2mIFc=;
  b=E1z0LPal4b3Zkq9GmwR4I2v8+S5zHBJoMB3rWyUClVKeLHkPu+DNd0Kr
   qv3CkfiLNSUffV2dJmMcHL0YQuSW0uZ5bTqAStBBJEpZsGL89h8FcK8v4
   V4Ap5b2gYhNYh4qo++cew2vha+ukU4gLKvi28goi4mMocl9CTRrr4VHl4
   BNpppV82qUFLuZ5B3Q9Pby0V1HKi0K3lrLPHTWCkXhd1xQXXCDOakSKYG
   MC6O18PUqaOjR7nm57X4kZTeEOSv2zPePZG2vnR2ok5iaQXswdCn/d8t5
   EmziJapca/y+4IZZ7QrJXGKS8qNnwPVTLZ5aZve4QFNPNj1kJKZv932Gc
   w==;
X-CSE-ConnectionGUID: UYcMj9TdRsyGzPZ36lEgJw==
X-CSE-MsgGUID: EpIeAuzbQmSeikKVQIY9Mg==
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; 
   d="scan'208";a="36926962"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 08:25:10 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63ED5172EAE;
	Thu, 16 May 2024 08:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715840706; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ivJGdfB0We0kranfdHPe4hL+Enb5dv3W/8BGkP2mIFc=;
	b=LMfjlKy4qv5svpwRzxRrtrslK3KvpTcDdd+RkdxGMQYqFUgIS6rjkzTgWkMDsb0D3jA0W+
	MiRXFTh5uTxsemyAVlgRdEl7E+LHC5NkvTGlkEFrJP0Th0YD8xFY/PJoHoG/03U/S7O6aJ
	pE3sSRsKH+4X/J+MJdsGWwjY2I95OC1sr18eJuMaGk1Nqg8lhSjnMMGxgWjN6uxscXQYBo
	tdRcff9++0bdYKlyjypnR1NFUIJ1QZZqE6hVZJ7YCSLPsI3/vLDUJAuQ5xPhfrLT7IzT4Y
	alrmiVsDKFvO/p7V1FBtC81Zw6SvmZv0gYSlQ6IUpsiZylXOe4QgGUt+JZ8GjA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/bridge: tc358767: Only print GPIO debug output if they actually occur
Date: Thu, 16 May 2024 08:24:54 +0200
Message-Id: <20240516062455.106266-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
References: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Currently the output the following output is printed upon each interrupt:
 tc358767 1-000f: GPIO0:
This spams the kernel log while debugging an IRQ storm from the bridge.
Only print the debug output if the GPIO hotplug event actually happened.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index de62a7e2eafec..8874713bdd4a4 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2146,11 +2146,11 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		bool h = val & INT_GPIO_H(tc->hpd_pin);
 		bool lc = val & INT_GPIO_LC(tc->hpd_pin);
 
-		dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
-			h ? "H" : "", lc ? "LC" : "");
-
-		if (h || lc)
+		if (h || lc) {
+			dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
+				h ? "H" : "", lc ? "LC" : "");
 			drm_kms_helper_hotplug_event(tc->bridge.dev);
+		}
 	}
 
 	regmap_write(tc->regmap, INTSTS_G, val);
-- 
2.34.1


