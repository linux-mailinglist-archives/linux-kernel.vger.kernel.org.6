Return-Path: <linux-kernel+bounces-339367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD6E9863FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503151C2590D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B126AE6;
	Wed, 25 Sep 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtrm1gYG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B93B298
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278995; cv=none; b=NefS5qBJye8VouHIGJM9PKySZKdFudd+o05aeVtzFFwcGR31hsxQCjNE9ZvreQsQG37fTuLyvFiUO4+sJ1CjPHeKGeiiiTXh5EDf97z3CH36zdkzpF3kX8EcpJMCarwux3JSDo4n8jxE4KeYXDlGN1YMU/zEgUL133pQV8BfM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278995; c=relaxed/simple;
	bh=w4RqhIFVBN4KBuZwGM8vHSEfTfAmOJ8kTf3Rh0OtbcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRsGfzuqGYa+Zgyl2Z2TJ3S3FlMsR//Tz6Haso+1oUFPH8Xmor90jUiGmtd3Wk8WhFUqJ22AVvbq+15dUqW9RzFGtZZpqM3j8uIl157RUlwS+w0vGlhsif3rcPmTCOSO42g+VdIDCJ4sXgNzxDl3V+WWAHHz1sBvBk2LCcJ5WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtrm1gYG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso904301766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278992; x=1727883792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq2TptZvyceBLBBx7LtBZE3h+E/rY5vjthtbIWopdq8=;
        b=Wtrm1gYGTqvS2GMyC0+dz8fYsnjsdsrmpY9GqSZJtB5yDplAl5Rc7djo8h8zF4+lo+
         Syo2JZxo8gBhynqQFIy6cfl60bWfERfHeF3gRdrVU1i6v8Rfu8ioeCzgVKdIXQadXv/s
         etTeF96J2WM3PG2tGnbJYY5l+6veEAplrqTFZnX7knPh5rl0O4XIyOplTr/VaVHUMbuo
         znxP97pa5O2PYaeYr0xuJaPh0Nua7UmOaZW6yW8gs0mB6BswcKsjG7wTMzwISxZiDDZZ
         5/fOdXAF4tI+TZiar/6Vw89ZY+mZRcluGAXM8ukiF4sEcyXg6UGU3WFI7dkyUY3AWwXs
         +/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278992; x=1727883792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq2TptZvyceBLBBx7LtBZE3h+E/rY5vjthtbIWopdq8=;
        b=jZKm+Bd/+b7pbb2Ngh3lY38/MNOtG3vRjhsBoOZq9GoNGBeVopYWbYvdVC2BvGRLj0
         KUjIr4JtCLDJZxUxVA/Qi5hZ+HqvhRc1Cp+NeiFbXRy/8oHN4EoY9ZJH2GZ8wIXzI5Yf
         l7oS6aDSyDHORj7bKuB1o+oNP2F6dkzj7EOyM1xzTl+Fiiz80UvevyC5IdnbuFPtI+Zo
         8Oe5i81uhijTVmixk2pEJaBpe8gm33m6I8KotmwXhzgLogA8ey76dgNW8EO822rEUt7B
         RjfFgxe9r9p3ETJIZsxtdVhLRyDqsbXj+92QUB/PfSs5m2gDa8bZim8NYAgoFNY77CA5
         WsGw==
X-Forwarded-Encrypted: i=1; AJvYcCV52qGlx5CYs+BEHhdqMwqEf2uF/oGXtA02J6m8+Wu78Fe+UiEC3wFfnqmlwhVK98wqnT1iYESkXjBOlog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOpphPhQw36/g+FrY4tM2Fdqjufu9AQNiTLDJldYm2ERlaJIY
	JoBlH00/shM5HidSuv3gnnczyNT8qxb+1fHqcNda8qgfhBRnHHp0
X-Google-Smtp-Source: AGHT+IHHc8HHdLYal7Pmze3ybNwhfKc28k6q1+c6BRN4mTyPbMmAiS5NmCbp8C1cZy+2fjcsw/yvLA==
X-Received: by 2002:a17:907:70b:b0:a8d:75ab:17aa with SMTP id a640c23a62f3a-a93a03c61cbmr314978966b.37.1727278992373;
        Wed, 25 Sep 2024 08:43:12 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:43:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:44 +0200
Subject: [PATCH 5/6] drm/panel: ili9322: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-5-e609d502401b@gmail.com>
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
In-Reply-To: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=929;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=w4RqhIFVBN4KBuZwGM8vHSEfTfAmOJ8kTf3Rh0OtbcY=;
 b=pFLApbC3MB4uKW0ZEVlNXM9AhpNeBXEs3My6pYnOwU646q8xtnwHyVxasmviBPw02fUL94CWi
 xgK5yWm/k67BakTjtq6lgKkPmmAhABqOvLOLqnuQGNEghVM3/8W6sHR
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`ili9322_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 4a6dcfd781e8..94b7dfef3b5e 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -318,7 +318,7 @@ static int ili9322_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, buf, 1, val, 1);
 }
 
-static struct regmap_bus ili9322_regmap_bus = {
+static const struct regmap_bus ili9322_regmap_bus = {
 	.write = ili9322_regmap_spi_write,
 	.read = ili9322_regmap_spi_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_BIG,

-- 
2.43.0


