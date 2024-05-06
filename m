Return-Path: <linux-kernel+bounces-169904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D38BCF2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671111C22E39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7E082492;
	Mon,  6 May 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikbmr446"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6582486
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002542; cv=none; b=qoJ6OHQoTyNYdMCJC4PC0O2huMMSsYpKlMZWYjPCdz6rGTp339/xRWG/ykAuoqHS6wjqr1OeGXESapSYeZkiOy3Xrw6u7Jm+xMmdJvLbV6MBFHa5+KZHTbhAvFDKL1C09nRPn1QJagcxQKH1tb+I5YeKq2EBul657RqI2B2Oo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002542; c=relaxed/simple;
	bh=On4XVAth8phH/tpwuPnVAjW8rZ3xEljXuSTJvjxVCxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beUUaIhFHWyMJReVCMSqYcUKb0fOOyIdgU/qcKfOs2Vt7Pfal9TleSiwDZwaUEsyuWTVHcxrGIo99kBf+7LFQc3WcHxp5A4ATRTJQc4yO1SG6fPYfg1srnU3IzY1DMIRINo4WQxXnH2Dbkdgdr2YYWdaTvhSSQGyluX8IqacSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikbmr446; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC444C116B1;
	Mon,  6 May 2024 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002542;
	bh=On4XVAth8phH/tpwuPnVAjW8rZ3xEljXuSTJvjxVCxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ikbmr446+4FNMnf+X2Ixk0yrmfaW3BrQGq12yjTcqCoCnSMkfSMw79qQvU1rgZfqu
	 JcZnBDtaLaFpqmQqg4UdyeA5sK5j3exP0iGyduTW+eyccA9s4j2R2u7Lm954PYjFJ1
	 Q+l9MRMFtFOtcpDQ8ztJ8OYkO3Ce1eEN/UUkyu6VIt2vdXkRs8dxE10Y7teetNDRns
	 cdh+7BrTVQUTngjQ2ZR5sArhQPeeXTR/doaIIdckPjZqmAcuvwIr3bYhciLCreXU9j
	 6zdG+E+/fBgrr4+SEsziVEUOj+pHa3QSTlHgUxUB4CL6ONgrBQh8PAJVMZlOYWzcoi
	 BbhbiM5RK5trg==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:37 +0200
Subject: [PATCH 08/20] drm/bridge: tc358775: remove error message if
 regulator is missing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-8-545dcf00b8dd@kernel.org>
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

A missing regulator node will automatically be replaced by a dummy. Thus
regulators are optional anyway. Remove the error message.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index b7f15164e655..54aea58a3406 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -675,18 +675,12 @@ static int tc_probe(struct i2c_client *client)
 		return ret;
 
 	tc->vddio = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(tc->vddio)) {
-		ret = PTR_ERR(tc->vddio);
-		dev_err(dev, "vddio-supply not found\n");
-		return ret;
-	}
+	if (IS_ERR(tc->vddio))
+		return PTR_ERR(tc->vddio);
 
 	tc->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(tc->vdd)) {
-		ret = PTR_ERR(tc->vdd);
-		dev_err(dev, "vdd-supply not found\n");
-		return ret;
-	}
+	if (IS_ERR(tc->vdd))
+		return PTR_ERR(tc->vdd);
 
 	tc->stby_gpio = devm_gpiod_get_optional(dev, "stby", GPIOD_OUT_HIGH);
 	if (IS_ERR(tc->stby_gpio))

-- 
2.39.2


