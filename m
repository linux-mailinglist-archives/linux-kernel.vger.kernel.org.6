Return-Path: <linux-kernel+bounces-330698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81197A2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524AB1C21F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30671155741;
	Mon, 16 Sep 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="Xa1xdy5w"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101091862
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492938; cv=none; b=qs3WcUl7JKcUMrmwMNaoHsaDP1dQRKMs5e6/iWkStMjxCalV2Uu9RpRtE+5GOFpgHYCosqjL79EhSy+DYk5IT0fBcyn6i6C/rtUQ+0EPWoedvzfJqs24ytZD5Rge2vjAVm8ntrmnfdq3v+0GS1wpVgu2ntvlUqSLdEEJf2c0BuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492938; c=relaxed/simple;
	bh=ts4qHaRPC3o9DL2A8J29gR6K2XZT+maNirNuxok4Xh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1Pu9cUJ6OvOfEZuyApaBadoU/nVfUHf4Z51RM4SmrKsM+EXK6v6y5M4FrpJj0p2JVfYaVSXAj/AKAy+ZznJW2okh/gqEjFc9qwjGGVV9vZ6HUE1nXjfqtJQTHPBysCHrSsIOiXyQGgr50MD92AoWUAKT4jwfScRt/E1rtUoflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=Xa1xdy5w; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726492934;
	bh=ts4qHaRPC3o9DL2A8J29gR6K2XZT+maNirNuxok4Xh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa1xdy5wZK4tT6o7LBudYT5N2YQ+ih2UT6Z5rTb7gkhwBAn6SmnKeoKHeBTAPa+jq
	 /jwUqBaffXxJOHLhOnzBbcrXwYltjfL9uTDb4mj0ApeEt6gDJfjerHI7exHk1swC3t
	 IYhWYd/tS1nunp2HVLTrC35mCgipHO4kCQqurVwUYwdTHTmcvywS4jfYh1omWgPjpq
	 cwhzSptcYjfRDZhCY09ZR4CWpDlbNyp0MqkEFUIRTPHPGqpKH/ISwj58N/8u3h4Gbp
	 pf7Asq2kz0pLcUm5pY63fGgZghZAqax69gzRUhgieH8JmxYA9pkmG1JZ2BVwvr6bH3
	 LHHimzc04n15g==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id B986D2066F;
	Mon, 16 Sep 2024 15:22:14 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
Date: Mon, 16 Sep 2024 15:18:55 +0200
Message-ID: <40350b0d63fe2b54e7cba1e14be50917203f0079.1726492131.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Add quirk orientation for AYA NEO GEEK. The name appears without
spaces in DMI strings. The board name is completely different to
the previous models making it difficult to reuse their quirks
despite being the same resolution and using the same orientation.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d1302123071e..1e556f9dd574 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO GEEK */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "GEEK"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.44.2


