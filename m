Return-Path: <linux-kernel+bounces-407675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B49C70E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EE71F2355D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24492040BE;
	Wed, 13 Nov 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gXFZ/dcw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB020401E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504967; cv=none; b=GduI5TDGj0qTuTgAzKXm6IkSQOd13LBc+a2uX8Vf+YMW5sIlRvCl59Cn4ZCZ3R4v05yGadkhOKxNfBFys9cWs9aDfvZTkFfECUDSWBUiWeKTtUMqo+xE/VoN6R7upMnAyRHMMZrustTTGGpRnNc+EoNsJs+S9gZIfImBuvbmQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504967; c=relaxed/simple;
	bh=VAScEqC+gOYlOCD5fSBTF28pUjgsQMZqDGi/b9qUFQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulYUd64l6bi/HBXGgFuOhLxA11olCMd2yEf0itXR/1YShKKttk4Xt6CPYXegGOsChUVHt2oR7BFcccZgCzrZIo9BxnI5w+DJaTgUVYAtrDtmpFuxPB30QHwbKGQPI4ObH28hUF9b1+U9kmm/77yyp+6GvNCHa+r5+VewG/IBdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gXFZ/dcw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so61502765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504964; x=1732109764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLrnY5p4F2ysEeuxEX1oEYB70cmBA8D62/QBYZDMk5c=;
        b=gXFZ/dcwZlK3nqxfyBwoKQ8r+NXg2cUybkd7Ptb65xgpF/+kJNiXPo0DvN8JZgOwSf
         pFuVUQptv6e2jBltSei/CGo9hEl1qRB0nJi+6180v2ATtAR1HOM32jm0RlM/CAfy8sCz
         /zOutt5fHtpZGdEE/fDvQ69UvCofZFggpxPZh3xX8L2Ee3tSaGoFB93T0dxS+Yc3mmah
         vrEg3leih7h4jRJmC50ho7UXnfdtovyAHHxwe/ZfmlGj73bmeTOwX8bEKPjZ4Ki4X4nn
         C1T4XvESgfLxfu9knSEuT/zI0rpVOpfYkGXpIVV4Ii8Jlfml0oj889ySWrF/ZpFsBzxa
         eBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504964; x=1732109764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLrnY5p4F2ysEeuxEX1oEYB70cmBA8D62/QBYZDMk5c=;
        b=KqEmmgM8PWOWv4uunXD5pB2RvfyMQjjJrzyvx/smdH7ZeH32eB0uwWC8qqPccT5OrB
         +CUIpzCj0pV0xub/QzY7R/g4EK2MqsO1w6f//rhSFvU8JmSDhbZm/1vH0yaAr9auJb88
         cv2jXjxEOWMB8OeNEwzccO3eQOArytjICF/zL6VoU6jwWE1L8oos7b9rWRGZrXwbUsPm
         RtrDYKEyg+iJRE02SUBRlnWGIiKHEEhGQCFZjRnzb7uKbGJI4O+3rzzEwu612HmdjFqc
         jOqBytG79TwpHTnO4cXN4hdjJZEVvBqPiYtHUmLXEZhCF+7p93dJ4r+h0PdIxQ+BU33c
         AxiA==
X-Forwarded-Encrypted: i=1; AJvYcCV9zAZE1j0LY0xt8p9qA6tSS7m8z1UZBIQhLu6JRiccn+KxnbfJwqaGLbTwW1y3MojAkIAukuSW+wmCu4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5y1trXcZXn/paJ2c79NlsA3U15GdA4snbOnyUpEvAylvhL8Mz
	kNNk2HVP/SWAoIChnmtA8hxo52Y/+fGSzqU7sWEUBb78X8Kz3Hmi9XpePkTfgNM=
X-Google-Smtp-Source: AGHT+IFhAKQyD7wWJYrPMxlQRcN6qIExSg3WsiPuAigIJwy4l5iZHLGTurt4LfoRew5/k7IONHIaLA==
X-Received: by 2002:a05:600c:1c15:b0:431:4b88:d408 with SMTP id 5b1f17b1804b1-432b74fda4bmr168007215e9.5.1731504963709;
        Wed, 13 Nov 2024 05:36:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:36:03 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 09/25] ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
Date: Wed, 13 Nov 2024 15:35:24 +0200
Message-Id: <20241113133540.2005850-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove the pdev member of struct rz_ssi_priv as it is not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index a4d65be17eb1..a359235b55af 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -99,7 +99,6 @@ struct rz_ssi_stream {
 
 struct rz_ssi_priv {
 	void __iomem *base;
-	struct platform_device *pdev;
 	struct reset_control *rstc;
 	struct device *dev;
 	struct clk *sfr_clk;
@@ -1043,7 +1042,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
-- 
2.39.2


