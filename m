Return-Path: <linux-kernel+bounces-267539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19CA941293
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268971C22DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553B1A2C14;
	Tue, 30 Jul 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="odMsHYz3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45B1A2554
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343846; cv=none; b=uufV18q5gZnmdzuW0QbepVX4El2tA+vXF3G4BrP4lu3o68gHBadHfdxfx5ptUILUphDecHPIx2XEmFQVM5bH3/3isSWHadfNc5GSgGRKd7obhTI2iUdLYI17xVTBm22FEecKus5wwIzh1FNyiQ89St/VCQJdej/2JFsKKWuLXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343846; c=relaxed/simple;
	bh=LXElMfscitp+h1jIWtFDnj+lqZ3mU9+8HT0EJKgSxns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpVx6lZqml8NsJTvs708BezVxmU35exQ6ZSHXoEb2yZUeQAW5Uir01zSvKF3/5QFJPcE3uGfIOQOKc32F0C8Btnpzb82jXtup+L7ITcETGdo/QLbeD3fWjnUMaTGm80qx3o7G+IGCeKtEBgGYbUfVsDdyNHAsFjAB+9zJ2BOC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=odMsHYz3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281f00e70cso15242645e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343842; x=1722948642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0bww741v4ESlaOBOd/IxNqqLNy/KYkDWPizVqdvx9s=;
        b=odMsHYz3l5V/d8wrOdcj7GVNnDsWp+QQGQcQ5MNXVkfMb7w3iO9GnPrGmyE5uXn7eD
         szTrhLKQ6W2YkfGK9y9v3C5PGtmkatWshIkMPZerozxzPJBulvR+LYXw9rNPhYVTZn2F
         93mwbEJeE1Tk6KpTy37RGnRUWb4REFOEwAOwTJjbH+43eya6DFdkizvkuYPiuyyzGilY
         lBjJo6Yy/PB2Xxal7FqrBQJ9LbaFwSqH4DRNeylM3HiOmtG/4wYB2LW+lj99lyuad1WY
         OXzA/kh4k8OoTFcD6/437ByzfFRk6WvUlFex+QqovWPIDi6DPHK/NGtJF3sianYmvG9n
         KKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343842; x=1722948642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0bww741v4ESlaOBOd/IxNqqLNy/KYkDWPizVqdvx9s=;
        b=KGBxODhEgeVtdghavgZEdxiPyiKY+TNs1iwUwHqf6uE3OJqL0gW5XU4omvYfc6ScHT
         5MnSqH6srFOoykx1Q4oDTuQkyqwOGk1edF95IBLquuuQIHjgTX/M2PAh2dcUGWAG/cl0
         EimmRthZEySR2ZdGemrxpw3pnTC+6gjJmzLGGzCW6jfsQux1y5CuzgFBL9RtiOmgfRcG
         sTolrinFnXaeMTYeDWKtHbhjmDoWJ7EF+GdPxLFTdKYkVpdX/dtmMQPDBw+t6wNk4awi
         Kk2abaCmKY8jz1bd/31JGHFQi9NedVEnZXrzei40h9vE1VE1A4eSHKcTdta4VNhXNObh
         zM8A==
X-Forwarded-Encrypted: i=1; AJvYcCXdBKxxeWQOEmIIv08N1NzioJRB48rER1UYH1g1yZBPZZu+RtiG9oxVowBhon35tbJvNaJrxHDuJszw2TJ8cclr7SJzmbZlJrismpPm
X-Gm-Message-State: AOJu0YwUgw8oeeAVps73icQQPrhXPxfTLg86kYXFvCFf6uYjCogJpL+A
	HzAk1m9ijkFwGLea6SuWQRgIISr+PyG/MW5aQoglwH5n2TuFdMqkJTtGPjZYIZU=
X-Google-Smtp-Source: AGHT+IFLDFq9LHqnUG6FBRbdJiqK71bxJQkIPCuJCS1JXepzU3MHqB97SQW7gMPpjbviNnFl2fKRWg==
X-Received: by 2002:a05:600c:1c93:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42811d71586mr72986835e9.8.1722343842261;
        Tue, 30 Jul 2024 05:50:42 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH LATER 9/9] drm/meson: dw-hdmi: drop hdmi system clock setup
Date: Tue, 30 Jul 2024 14:50:19 +0200
Message-ID: <20240730125023.710237-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Poking the HHI syscon is a way to setup clocks behind CCF's back.
Drop these poke and let CCF handle this using DT assigned-clocks.

HHI is a collection of Amlogic devices, such as clocks, reset,
power domains and phys.

This is another step to get rid of HHI access in Amlogic display drivers
and possibly stop using the component API.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 This change depends on:
 * 0602ba0dcd0e ("arm64: dts: amlogic: gx: correct hdmi clocks")
 * 1443b6ea806d ("arm64: dts: amlogic: setup hdmi system clock")

Time is needed for these changes to sink in u-boot and distros,
making this change safe to apply.

 drivers/gpu/drm/meson/meson_dw_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 6c18d97b8b16..b54c1e3093e9 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -111,7 +111,6 @@
 #define HDMITX_TOP_G12A_OFFSET	0x8000
 
 /* HHI Registers */
-#define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
 #define  PHY_CNTL1_INIT		0x03900000
@@ -419,9 +418,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 {
 	struct meson_drm *priv = meson_dw_hdmi->priv;
 
-	/* Enable clocks */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
-
 	/* Bring out of reset */
 	regmap_write(meson_dw_hdmi->top, HDMITX_TOP_SW_RESET, 0);
 	msleep(20);
-- 
2.43.0


