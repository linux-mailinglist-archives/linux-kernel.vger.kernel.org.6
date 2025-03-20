Return-Path: <linux-kernel+bounces-570006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB5A6AA91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CF87B3857
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614EB22B5B6;
	Thu, 20 Mar 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YRc/72gg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80022AE7E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486469; cv=none; b=Uz/17Wkka4D8lQlC8ZINRPciFCIMSgtrv8sz4AvyoGWNN7RU+YMvfemKznrek74w9amcNjUXmM9mfSEUVLNL6GdsBEBYY8SpANyrrYzJa6+iEhTfyplsgDL99B/9L3gdWGc88DBkQcJv6zmozfnf3jw8jhgONcs7V/ofY3q2d6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486469; c=relaxed/simple;
	bh=QpPNCE/E/KWQolKtCOFkofej8djB0ueW3MJ0KSDshcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHaoHGovOqMtxvrH78BYipjyKvEodTcqyBAl0mvpduxRuody6Eccfg6KjF3BlvLT/A4moh+FJv9d2RTUpQ2M1HUmM+8+ZAxAURxSwMdHcl9jWqnDgoO0DHHAAOflG/HvVUtAklaMKsf0WAGGRkt4KlbZamwl6Az3i7B7W1p1gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YRc/72gg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE811250A;
	Thu, 20 Mar 2025 16:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486347;
	bh=QpPNCE/E/KWQolKtCOFkofej8djB0ueW3MJ0KSDshcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YRc/72ggG0toHOpFZ/BCgslWMD3HdlJpcT6czhZK7/OSHGeAkp3gUIr2FzCpHHZhn
	 1umV9fgcd18nGHvHL1gB8OVkSy9NJ6o3fBjknF9s1Fed8uw4WTSQQPC8rcCBROf8lu
	 /hkjdKkQoVzEjIdq+OsAX7LBmHK7IGlybG0xt46c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:13 +0200
Subject: [PATCH 18/18] drm/bridge: cdns-dsi: Don't fail on
 MIPI_DSI_MODE_VIDEO_BURST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-18-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=QpPNCE/E/KWQolKtCOFkofej8djB0ueW3MJ0KSDshcA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DucYZK5+NXYKzJdd92G5rg9oQKnoa7JAD37U
 yJIIGrHFUiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7nAAKCRD6PaqMvJYe
 9Y06D/4rAhssTack4HqjC5UtxrcEAjrkFWN5o67P5tlC9R8Vn4uRFWQcmlqGdpL6k/A71CGm0Oi
 +mnV5lqIDCqIP6lizBE0zTXJWB0E0BLjv+nJaxXqf8Pk0BT38AU6NZH2s5ZSOLiBjRTHn0s6Eo3
 hFAY2gCT4xZfqZKT4iFLMGAmFHfIrmgs1uB3DAxbHAxv++Ms8CTg9JrdHvF+fTpl9tYX2bNUFux
 XueuOxfPRd62CS1T+mJrcql5kSUNGrkq8BMvc1goHn9AecIw+d3n/MpvnvRMWBBzCIXSqTutEnv
 PV7dnA/e0fGKKA7pxcXEi1C9egEitsAsRV3W2h9A6Vplf0vCm69NmczyMMh5Z4eP1vABp/S8DrC
 0wnIgEJb3pIDca2PxG5gILF+ZCjdPMRGHKlfAfElU22XanbR8B+PLT+3sRhm2Z/JROu9NCuKpSB
 dZjRTrsqF4MDSKDpw6MENP2uy0wU9btREJ7EG9FkAZxvd4whD1fJeiYzEkZyTtxcy87l4OElfSF
 ecZU2RhxfedKZt/gGamZFYa9qT+eoimTBB0Zry9MKYyVHKltUz5QRV0+Fn9d2wFWI4bkABK08nf
 2HUyQbCRWwJGfNSJDMv8pg0rQiaCPvbjVSZ6di21hyj471vp9w21oxRzhcHIVChijk88xJleK1d
 m9JZZ2aJEbI+ibg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

While the cdns-dsi does not support DSI burst mode, the burst mode is
essentially DSI event mode with more versatile clocking and timings.
Thus cdns-dsi doesn't need to fail if the DSI peripheral driver requests
MIPI_DSI_MODE_VIDEO_BURST.

In my particular use case, this allows the use of ti-sn65dsi83 driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0bb55584cb44..4b77a203b608 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1057,10 +1057,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 	if (output->dev)
 		return -EBUSY;
 
-	/* We do not support burst mode yet. */
-	if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
-		return -ENOTSUPP;
-
 	/*
 	 * The host <-> device link might be described using an OF-graph
 	 * representation, in this case we extract the device of_node from

-- 
2.43.0


