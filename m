Return-Path: <linux-kernel+bounces-384654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC709B2CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018E81F22D34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DF1D460B;
	Mon, 28 Oct 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o0JI3CcO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2741D9323
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111186; cv=none; b=BfRzo6otqlMtmegmgaCQJRZEhBbMZMML6gPzkqxto1iZC36NSgF0yI3JvL2VH33NiChMBpEY4gb3PUwBpY3FiEoubLWgu5Tv71NNH8OZcxLguQNC0UdIaNt9JJqpcv9QvK3QqLZ4d3Ml+ACiLMaQWXsXxQTTyjFCTBbhNhIgZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111186; c=relaxed/simple;
	bh=XhJAVJsMqc3jWJeY5sUwKrKe2d7eZOn1JnEjj8THF0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVa9sGIeoK6DMOOU8nhSMSfd9oFT9Zm1YqT7vglAdBDp1Y1StbwviCfc32s12jfZnz7gaRdLABN2XfbQLc2y4do4exgRbhm+cTNWpTHZEk93ZYviPDBHGu37iO4/i5/tvz6wUK3CeTqcsLgUXOu8gPOErySVTFYQcK/aCr6V4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=o0JI3CcO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0cee600aso535993666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111183; x=1730715983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0ceU2N4ZWu/FtoiewhZfxk5s76R6vPhrLuwGN01j9U=;
        b=o0JI3CcOhQ9MIILk3D8Z56WygsfRiYPtczF/iaz1gGGXJmi5jEzplo+srZ7ionKbEq
         sOC5wDUBay28465I5j/0ICWoM8gUt2PDQ01ubGGZ+k2DNTfikawsQNHeCFIYSMcFx0CV
         rZSaGA/JCDFiIXzvBNrKGH0pS6TR2msteVH3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111183; x=1730715983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0ceU2N4ZWu/FtoiewhZfxk5s76R6vPhrLuwGN01j9U=;
        b=haa7j9ujCeyJcqSby/kTEnEqxh65vsbWSyjuLYa7VsMMK6MR7Gft4CbG5JyobuQWgW
         8PBBZomNn+oMiVBYcOFob2obrlaXenT+1ClyVn+1SFv38qbjVGbqYxslA5PgyIFDxAdI
         0nlWlTithYPD0tNbl4GPiU5MCgyfc8lDAI9gvyaj5YojclHEC/bRZvQX8+PGd96krF3X
         iFPLvzCn3NJnAB7k0Tmxfr+nqePHYLnYnRM6J8kTznFaBcHaaLezbToSv5Q4W8anRIiv
         1TYbQUZbrKU21pOcfgZ36aST2ZUlLs1BSXBHi8orM3hyrHQmUrMv4tNBdl/01BSBCrzQ
         j6WQ==
X-Gm-Message-State: AOJu0YzZBCeY6pGgQbHvVwa7uH8hMIXth2Nwwk2C7kMlOsVn15L3Bui6
	pPbh/Inahrd+Yy7MCDesE971NAddFS8HJLdywrOXS1dXv6LP1yX7T40+Gg2ND40K2qx8ah1p7f0
	yZKs=
X-Google-Smtp-Source: AGHT+IGk1NWuOLicniG16PKOif/FXsp+NvuIf9J+Hupxj0+7LKo6e8MDUzZowWTysAuCxxUypwbw8A==
X-Received: by 2002:a17:906:c105:b0:a9a:10c9:f4b8 with SMTP id a640c23a62f3a-a9de62eaf3dmr759573966b.61.1730111182612;
        Mon, 28 Oct 2024 03:26:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:22 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 08/10] drm: bridge: samsung-dsim: don't re-activate the bridge if already setup
Date: Mon, 28 Oct 2024 11:25:31 +0100
Message-ID: <20241028102559.1451383-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch does not re-execute the hardware initialization/activation
procedure for the bridge if it is already operational.
This feature is crucial when supporting the simple framebuffer, as the
controller has already been initialized by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/bridge/samsung-dsim.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 430f8adebf9c..7c03215bb004 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1933,6 +1933,7 @@ int samsung_dsim_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct samsung_dsim *dsi;
+	bool initialized;
 	int ret, i;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
@@ -2010,6 +2011,13 @@ int samsung_dsim_probe(struct platform_device *pdev)
 	dsi->bridge.funcs = &samsung_dsim_bridge_funcs;
 	dsi->bridge.of_node = dev->of_node;
 	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
+	initialized = of_property_read_bool(dev->of_node, "samsung,boot-on");
+	if (initialized) {
+		dsi->state = DSIM_STATE_INITIALIZED | DSIM_STATE_ENABLED;
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			goto err_disable_runtime;
+	}
 
 	/* DE_LOW: i.MX8M Mini/Nano LCDIF-DSIM glue logic inverts HS/VS/DE */
 	if (dsi->plat_data->hw_type == DSIM_TYPE_IMX8MM)
@@ -2020,11 +2028,14 @@ int samsung_dsim_probe(struct platform_device *pdev)
 	if (dsi->plat_data->host_ops && dsi->plat_data->host_ops->register_host) {
 		ret = dsi->plat_data->host_ops->register_host(dsi);
 		if (ret)
-			goto err_disable_runtime;
+			goto err_put_runtime;
 	}
 
 	return 0;
 
+err_put_runtime:
+	if (initialized)
+		pm_runtime_put_sync(dev);
 err_disable_runtime:
 	pm_runtime_disable(dev);
 
-- 
2.43.0


