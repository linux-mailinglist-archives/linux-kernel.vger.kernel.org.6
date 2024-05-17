Return-Path: <linux-kernel+bounces-182646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA848C8DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F501C21410
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E31422AE;
	Fri, 17 May 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxA4tp/K"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7C1420B9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981862; cv=none; b=sR9I9DVX4ogER7uNANx4doe1Ce9363Ijze6kE8dkxmuLHDXtS9w5DWBFRZWZVvC2fi7OXsWbnA8uTwqDuyn7jRH08qTCzK5Pmoj0dIaoQXH3UjNmf6WmeVg6lFHEnmZDnz+eKaAAlnEVK3e7d34B9jib9ysZnZy5Ll6TbN80+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981862; c=relaxed/simple;
	bh=FlKZAl7IvkiENnscHBKvzQjnIjGrDUrh/2f8yIWJZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxjGEBvv+9BZB98TFGFWJjV0i0z9onKSZ1Cx6bE75QjSrN/XuEsnCJdjwFQEVQ30rLFczrbeUEyBAM+L2WFGs6cNwpYlitCe5rv39l9tv+FHawj7NggtxU1H9r4NDUlaCXDHR/hmz/Ilzkf+4CrGInscS1p5dK/2ARWno++Y72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxA4tp/K; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so136185a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981860; x=1716586660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6V1DTOaoA4qH0IIompQM1ktLyB9pQcF5OQ8P3nV8rs=;
        b=VxA4tp/KUIPuT3ZX5a+kL0+OZXwEOVWKtMW2jh9274XhWV+z+WDOVwXSP13p0y8ZOt
         fbuMQdmZIyI9Ao6IVobmuGCLD4EXtWhrs8rDscSKETQEasUgZ0kG7robXtEi+OTlPCFm
         ZsfCxdaxRrzpLJFKEITmeVLKzhuF9EQEXv8/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981860; x=1716586660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6V1DTOaoA4qH0IIompQM1ktLyB9pQcF5OQ8P3nV8rs=;
        b=DVyi79xtksg7pLdoJylAmztqPGmAM5c6L1Fb3aEvx9FerrHZmi6oCjPZeY1Zzmx63L
         2XL517KQrRQU/l4O/yhJFopRo55y60Bk4nGVsFX0f6VlrMY0LYVs9fgRwwWa7E3u5nU2
         SDQegra+vm1mu6KNr3wtvCTIvtQojAtAWCZoi/EvrCTX/ZZHHviwghi8GgZJIjMHrscV
         lDr4/Lumii9Mk5ZFmQjNSdi7le2nfqvCY31UQ8hjIlW5YsiPUvcNiG3ssokV+rG5XrCw
         6THYtzjT6PXFrtXnM/VkctroZ3/0wrhZOgQ5N7c+1RdKOxlFao4k3iIOTx5TDgfoTJjW
         hAVw==
X-Forwarded-Encrypted: i=1; AJvYcCWO7sUIu/9l2EpKNpWeg0S+NgKmiXaQHXNIDvhbgYbfWokLp6Rymxx5kWNu+oFbk6Ld40R2toDcHmlhgMSpdOcrkU9KWcF+NaNWH0UD
X-Gm-Message-State: AOJu0YzKXVI3jD5e99igF8iy+rCdbYK0VTxzZ9bMJdpzVTsonvPlbcpO
	yP6v2jcnJjXARVJyU2h04bCzXU/IhLVrULO1MnrVZ3e+pV1o8/MrONfrL3xj1A==
X-Google-Smtp-Source: AGHT+IHm5RdVFjZ89P0T1AzZMKaNsfexwf2EZJjaYa/Kewivy7mYMercZQ/c+BtdjQ/LoSpevWMT2w==
X-Received: by 2002:a05:6a00:3996:b0:6ec:ceb4:49b8 with SMTP id d2e1a72fcca58-6f4e01ba036mr25987075b3a.0.1715981860345;
        Fri, 17 May 2024 14:37:40 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:39 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Shuijing Li <shuijing.li@mediatek.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Xinlei Lee <xinlei.lee@mediatek.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drm/panel: boe-tv101wum-nl6: Check for errors on the NOP in prepare()
Date: Fri, 17 May 2024 14:36:38 -0700
Message-ID: <20240517143643.3.Ibffbaa5b4999ac0e55f43bf353144433b099d727@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mipi_dsi_dcs_nop() function returns an error but we weren't
checking it in boe_panel_prepare(). Add a check. This is highly
unlikely to matter in practice. If the NOP failed then likely later
MIPI commands would fail too.

Found by code inspection.

Fixes: 812562b8d881 ("drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 028625d2d37d..f7beace455c3 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1456,7 +1456,11 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	usleep_range(10000, 11000);
 
 	if (boe->desc->lp11_before_reset) {
-		mipi_dsi_dcs_nop(boe->dsi);
+		ret = mipi_dsi_dcs_nop(boe->dsi);
+		if (ret < 0) {
+			dev_err(&boe->dsi->dev, "Failed to send NOP: %d\n", ret);
+			goto poweroff;
+		}
 		usleep_range(1000, 2000);
 	}
 	gpiod_set_value(boe->enable_gpio, 1);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


