Return-Path: <linux-kernel+bounces-169898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B830D8BCF25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D4B282077
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1A8061B;
	Mon,  6 May 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFKvbref"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724098005C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002518; cv=none; b=JK/sfe4WukzAD9k2sUhQQJj8QFeBw/Ieg99em7Bc/DHklxBZlVMxZMcmHb7KxJREw+fK76C1kqNER0MqmJmZh6BgGMjpopU8RM5/lBczekWAcjMRzwU+csoARCJmfuhPv4IlbjDc9QoS3XMgAawoG8X2SXVTWAT07dYdW/sSQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002518; c=relaxed/simple;
	bh=TuYMERR0RaUaMlVi9q6zNXvlpim/SMByOC7RHr5bFKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4Y3SKeTi59bUWHziU9Zf4Ttr2qrWLXhc3AOPX48rUPGl6tYVFCHx6wyNffO/1H9zCtT3pULyVmLaILlkf+RWsC1U3Smtzq/DjJG55iqOFWgC1iue3e/lrURRmwo4wCzAaiXHuU+79ALXdkK4fOISi8dFxZLhtpiO8QdSLykLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFKvbref; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E0BC3277B;
	Mon,  6 May 2024 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002518;
	bh=TuYMERR0RaUaMlVi9q6zNXvlpim/SMByOC7RHr5bFKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PFKvbrefjvVIf53ItfzYZvHVza+Ja0BR+Vd7BHiSXEA1gtTj09HbUVXMNyYUMffFR
	 /Wp4yNUxMD8kCBWwzKQpWQL4T3Y1mWiGvXFjBH9WDLET+qYEAWK7PtxrFjhQbixWQ6
	 oOE3PIhRQFuXvdLywvfIOk4Mp9D/DKUsRd0qFNyYPec+lVs1DljLS74AIuLqldYBA9
	 deu6o8W1gp9xjfDwqskRyyX50TBHOEwcMQLVNJUfPrMxdl5KJffx3jeaz+/H/egyHv
	 VoDfgA+MewIY+jixWlLFUWUMd74PAm5lZFYCZ8MAjAzwC4SeFjosrNDTgoZopKvqhZ
	 ySULCnuFnPlmw==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:32 +0200
Subject: [PATCH 03/20] drm/mediatek: dsi: add support for
 .dsi_lp11_notity()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-3-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

drm_bridge_dsi_lp11_notify() shall be called while both the clock and
data lanes are still in LP-11 mode. Add the callback.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ed45c9cc3137..d4a5a2bd591a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -709,6 +709,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 
 	mtk_dsi_lane_ready(dsi);
 	mtk_dsi_set_mode(dsi);
+	drm_bridge_dsi_lp11_notify(dsi->next_bridge);
 	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	dsi->enabled = true;

-- 
2.39.2


