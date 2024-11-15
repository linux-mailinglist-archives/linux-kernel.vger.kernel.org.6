Return-Path: <linux-kernel+bounces-410979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB39CF117
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DD91F2945E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D221D61A4;
	Fri, 15 Nov 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="t6yRHl8l"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CE1D45FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686877; cv=none; b=fZvvs7/OnFE2RM5MarxnDlEd3+MTGkXylyv/37o1BnE5R/GCfZ7PWooVhi+yMNd4NjOncUlehsDoHmTOF6v3toIKyHKlXQgKVSjG9btCLzD33S5U9tj5zM4uwefIQAugrWlqjHtSS+JL71hiikgVmfCky2JgwJjAJ3dgzOvL4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686877; c=relaxed/simple;
	bh=oyIFfv6hbzfl2CcNXovdbt4pHCPK8ip4Z0gc+H04Rq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbR4t4t2Mq6A66ui70m3TZ+ES4w4a2mAA+ZWOQlq5lC3yHDFys8wR4asP+dna9xzqG1/ussg9+n1h1yh5p/pZYe/3lxRqoGQET3+jT1sN+oiZCuxk2pdlIsXZWj+kVdF5jghV1Cvnry0/O0ePC9NErlzYsUf6hGtq+5ehipqp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=t6yRHl8l; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1423169a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1731686874; x=1732291674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CycAJx3idmdsvb2oboF200n+heMzv/tQjcKECgs/uw=;
        b=t6yRHl8lSAdJxmMEgmOrM1gc6R9+eFQdMQUUiTeRdVTulAITklS3tHCH5LMo/aI3on
         OJQys4sde8Y7u3XpvAgpW7sDYJ3FTw7YntRSh5L4ox3SvFda3Wdsn9Dfxi25N9kPBeh3
         tOORnTfjf8C7nzGi6djQZMbE1G/2WA3D/rTjZtdckPq5ZnewnymZQfYeXtia2B34ZGWx
         klLniue0SygLXNl62rKrg3aBc5o2QnXXrtfrFRkLATh0uF8QKqEsC9q5uXao2CGgph6V
         9YEFjqjWpsC7VHB9PahmGVIhkQKJnIXNiE4WAJu+PSFRqhRUR8Hsxe2rCr7VL1SqKXLX
         jwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686874; x=1732291674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CycAJx3idmdsvb2oboF200n+heMzv/tQjcKECgs/uw=;
        b=MkmD06k0i8A/BaZd9ISxmzmP4TpmCYcfl76YG234g+qMZzT/7zxEGmjDNrFCTwUBTu
         1l0zbGywEUepnflCF5Kv9KNIO6XjNXzCc77g7W/OY3u6biO8n9zYgwyuPYpFqgvzDpZ/
         n2sptNBKO64inJYVktxD7on8wtfQn4lnj7qHPVPdGfT7uhNw+9qxoSErBvw+1CFdsory
         vxS7RWHE0Zl9MD+eoUONsbeof6qDutYj2496xt8Ie89ySsBoQd3XBpz/gYsBxv0wWqXv
         cyITsW/F9vqb2bdruJgToB7Nn22/KiNEA6FZ/yV7WA5UxUI12x/bvIK81pTHptoZtjCe
         4qZw==
X-Forwarded-Encrypted: i=1; AJvYcCUWfhmNEUobf/Grkleopw5JVnupAMfhLrGmBTpYkTiCHzuNjrFnqmZQIFmSjvkXw1/n/PFco+sXQ1UoZvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdoS7Ek+e9nXv0xpw/5DWsNb2//6TQjJC6IYSVaIndZuKX92xa
	/Mt692zsFXRXJ1AMmmkTvkjQe+ApuO/EGcULCD7L8B2VtMHGWAfvItfjl5vgIQ4=
X-Google-Smtp-Source: AGHT+IH2U0OnUfhXO3qxZuHhXGmKJ4U2QgdglEBHh3If9IMSL3DAHUNYch3+DhBSltB9S39eUaStfg==
X-Received: by 2002:a05:6402:50d3:b0:5cf:707f:a123 with SMTP id 4fb4d7f45d1cf-5cf8fc1406bmr2607951a12.5.1731686873609;
        Fri, 15 Nov 2024 08:07:53 -0800 (PST)
Received: from fedora.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e00172dsm194948266b.120.2024.11.15.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:07:53 -0800 (PST)
From: Daniel Semkowicz <dse@thaumatec.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tony Lindgren <tony@atomide.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/bridge: tc358775: Remove burst mode support
Date: Fri, 15 Nov 2024 17:06:32 +0100
Message-ID: <20241115160641.74074-2-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115160641.74074-1-dse@thaumatec.com>
References: <20241115160641.74074-1-dse@thaumatec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current tc358775 bridge driver implementation assumes that DSI clock
is used as a source for LVDS pixel clock. Moreover, clock divider
PCLKDIV has a hard-coded value. This means that driver expects DSI
clock to always match a panel pixel clock. With such assumption, LVDS
pixel clock is configured to be (DSI pixel clock / 3) for single link.
This is true for DSI non-burst video modes. In burst mode, DSI host
is allowed to set transmission rate higher than pixel clock to allow
shorter data bursts. When the transmission rate is higher than expected
by the bridge, LVDS output timings are still configured for the lower
frequency, but the output is clocked with the higher one. In most cases,
bad LVDS timings cause incorrect panel operation.

Remove support for burst mode, so the non-burst mode is used by DSI
host by default. Burst mode is supported by the bridge itself,
but requires proper implementation in the driver to operate correctly
in all scenarios.

Fixes: a4ed72e85c46 ("drm/bridge: tc358775: Add burst and low-power modes")
Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
---

 drivers/gpu/drm/bridge/tc358775.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 0b4efaca6d682..7496681c7b883 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -632,8 +632,7 @@ static int tc_attach_host(struct tc_data *tc)
 
 	dsi->lanes = tc->num_dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
 
 	/*
 	 * The hs_rate and lp_rate are data rate values. The HS mode is
-- 
2.47.0


