Return-Path: <linux-kernel+bounces-570004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05453A6AA98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDDB46017A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDAA22AE45;
	Thu, 20 Mar 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="br5rpF0I"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6622A7FE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486466; cv=none; b=icQz6BqMh5J62tHjXO9dtuVcBPvHz3mhBt0uRBKXnUfSMhLyX9dre729Pg3faeaMPeDNLJ852EmDf+TkimfMfEBJ51mFVnVJHJ70yQx1MqXHPGP3PCX6t/D1QURHEY7fKPAoPQzp4mIJi5Y7wCdCk1NJZE4FOnGjJj4GrploKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486466; c=relaxed/simple;
	bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJSQDLFbD63poZCt8UiOWZACyfBFzeJGaad/xoS7Nh0CdxSWyMXt2KJ3BDywonlRNPps/oMK2hlEmN/YOoX+XK/QI1cJnBCyWrYljGMDTugqJa+JaVnseSLKQCTp36elHuHC05h6plxikX6tqIWj+BThVl+Egr0TSxd2t7NRzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=br5rpF0I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D5E319EA;
	Thu, 20 Mar 2025 16:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486345;
	bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=br5rpF0I4QfIqE1Q1ze9G9TqZzChKg0Ef7BWYPWBSwBNue5i1Ig2dw6gdqmMVQ+Ol
	 AsSLlv9Neoui85vV11qtCpB6+nM1fhswE+eXZvZ3UByp5xE5og//Afth7CKNZM94AO
	 850ljiUL1Nr8eAMq3l7QiRO11uyeEKjueUJ3uhpo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:11 +0200
Subject: [PATCH 16/18] drm/bridge: cdns-dsi: Update htotal in
 cdns_dsi_mode2cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-16-725277c5f43b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3Duc29yGssBNwc7Nzzd6cuHFVTJyPm/qWnwlK
 YcoBeVrlHmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7nAAKCRD6PaqMvJYe
 9RwdEACMNuzhwhzLBQGjW9qUMDxk2p8+9CyvB9HAavK1KC31lXMNfelL6GkkyT1qLOn2ZCD8jHo
 Ja4FoEQRXBoLeyS6KMSQkw2Su86zTpOKY4vi8N22lKTHeirIA00Xm+JTwj5Y7ayZbt+AUh3jZko
 Vs095FpyRdH6jukjY8m1WpQECqdtHjsS+UdnlwjHZoRMc3hkErzi/RN1KF6PKt+uIrV/Euec6D6
 dFgPforoIuqCc2b+a0tFf47OrP9jJSvwz46aKg9rmAS276I2rgP5kQ67G68MkEo5JE5wkKh6z9A
 l0Wd09IgwJSwMQlgBqLL2S7X45gfs1r+dd9IeLEV5rZZN9595cyeYe1zeSPyzV+oUbwrGcbU97d
 yd2G74O1NUWdx/UdsM+/MDM+t4N8EFYc4+07CtH2E+8jLKBHGDi8NEzuJVtrqMCTcsQiFqJyv77
 zVVSFBI0jPtNBkr4ZlAuqp5T7CTCVqm1xKaVqDHmZqRruADEyLBtcKiCsaXEH+MW8GCZQoQH6hb
 +nqEiTY0VFnkPC0JmNt4UDnKazBRana9vO7GUntIvPTg5vU2Y4qM2WLIH+sAOpR219Md7xWC+6z
 B7+wG+R1/+JOuNsEeQ5NgFLB2zpCiBaiZECOr6pLTvcKzgdtpWbEanzdh/nwfODegV8+ozD6w22
 F1Xp9WtAazigPyg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

cdns_dsi_mode2cfg() calculates the dsi timings, but for some reason
doesn't set the htotal based on those timings. It is set only later, in
cdns_dsi_adjust_phy_config().

As cdns_dsi_mode2cfg() is the logical place to calculate it, let's move
it there. Especially as the following patch will remove
cdns_dsi_adjust_phy_config().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 9f4f7b6c8330..2a272fd8ea3e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -505,6 +505,15 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 
 	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
 
+	dsi_cfg->htotal = dsi_cfg->hact + dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+
+	if (sync_pulse) {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_PULSE_OVERHEAD;
+		dsi_cfg->htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
+	} else {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_EVENT_OVERHEAD;
+	}
+
 	return 0;
 }
 
@@ -522,15 +531,7 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 	unsigned int dsi_hfp_ext;
 	unsigned int lanes = output->dev->lanes;
 
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
-		dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_PULSE_OVERHEAD;
-		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
-	} else {
-		dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_EVENT_OVERHEAD;
-	}
-
-	dsi_htotal += dsi_cfg->hact;
-	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+	dsi_htotal = dsi_cfg->htotal;
 
 	/*
 	 * Make sure DSI htotal is aligned on a lane boundary when calculating

-- 
2.43.0


