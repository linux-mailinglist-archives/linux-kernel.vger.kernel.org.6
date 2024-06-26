Return-Path: <linux-kernel+bounces-230990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D69184A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B3F1F27AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82718C33D;
	Wed, 26 Jun 2024 14:40:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99618757F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412846; cv=none; b=Hhx7LZsEYl9hzQ0uavgt/UpViQEOpjDpmAjMSjXMOTmLxAgEfREVwM+n4b2ZjDj0Z8mdCXkKcBAm1QWnc3O7PmnisiNmo760TCupMWAT8ayJTtxPns/zDnK0XSFIqgKnequRHdsZMG9AG8JJvCxhniL9K/6DrD71QLRKhhpgm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412846; c=relaxed/simple;
	bh=A38PiAz80YmBu0Bjdij5p2tqfJIFTaZDez9EJ2DNtwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmTB9hUhJljD3JJ5iVPeQUu9T3hB0ITo3TmAIsutMIdRlDTx3JgYllVY/hhyru+OEK3kwVloZes7gQIdfHeQgcUv5bPRO6ws+CNEiu2Wl4HMm904tH8Ped0DGoIH4qrTFQZXzp6wav38q210PDz2VUyMqtGSfpyKn0aQ7Fzpu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMTp9-0007iB-KM; Wed, 26 Jun 2024 16:40:39 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 26 Jun 2024 16:40:39 +0200
Subject: [PATCH 2/2] drm/panel: ilitek-ili9881c: Report subpixel order
 according to rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240626-drm-panel-ili9881c-rotation-v1-2-e0ff54173e32@pengutronix.de>
References: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
In-Reply-To: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Assume a default RGB subpixel order and flip it around if 180° rotation
is configured via address mode. Report subpixel order to userspace.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index b4565ff1a0de..28cd7560e5db 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1471,6 +1471,10 @@ static int ili9881c_get_modes(struct drm_panel *panel,
 
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
+	if (ctx->address_mode == 0x3)
+		connector->display_info.subpixel_order = SubPixelHorizontalBGR;
+	else
+		connector->display_info.subpixel_order = SubPixelHorizontalRGB;
 
 	/*
 	 * TODO: Remove once all drm drivers call

-- 
2.39.2


