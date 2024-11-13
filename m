Return-Path: <linux-kernel+bounces-407681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A259C70FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E7C2864F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE790207205;
	Wed, 13 Nov 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lycCngBI"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2B206966
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504980; cv=none; b=EFnEOUlJyhfIskbAFc5pONM0Bxz9scMEXip1KDIiYJ1deQScZ8bOr61wtME3ZTYds8pcHvR9G+p03xMR81mZZS9Kht8A8wdINiMpcU3qrBahSX8KbvmsJcayKHiE1vhKPnaPIiK23/XddJQ4iYjHuDiGmt8vmYDsdfBjaFZLMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504980; c=relaxed/simple;
	bh=Hb+vwu3in96zGGIqIx/aQip48C7Np65T0IXGvehWm4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZlyIARUzBBL2DVyQ9zHyp5SIt3reS8D7OBcHfCtjVpBZ7hL4KMwq/P+qoAXk8whBNqFBAJVpdbIVoTBRb6DVAOdAAojs2z3Eq/wn8g6BL7CrvRZGk6Y3pRBetfwOfAfeY4DiNfenhUfmatq1gNOYJuGmm2cTw/lNh1FbkAzaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lycCngBI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53da3b911b9so166935e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504976; x=1732109776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rm8JuVgQ7iKPfViIiadsm8ecEHZvGTd39nDcvF7dJ0=;
        b=lycCngBI/2MkAypiG6kFwQxZ3SkwNWftjwCTjM9lHrHDrMNKNEU8R3zCkbRcKNhGhp
         vmXLyhdgCIoCOQXneSIwS11AGZ7vcy5vRptQbDq/YR7X9D8Dtgln11mZ4XQv1wmO82oD
         msRZzuo1yq6UvJ+55WDluGSucU14wvdre4feDrwUni5VL3Zor4ZoA965iItkaB5ozGrT
         vJs34z75pwdXDTDZW5pnhKv9S5dWX7Qwbrc2ZP88HgFVZXgIN9jEnobW8o1Lcj3tV3V5
         6sE9Hyv8paE2LEyjR4l6MNYSQ/gkpM4osR+mMjRO0oCtOGeNhU7YwidLUK42uXxI3N4k
         rDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504976; x=1732109776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rm8JuVgQ7iKPfViIiadsm8ecEHZvGTd39nDcvF7dJ0=;
        b=o5cYTGg1F2GvRV2sWTCrAp5vd089UNJAmCzUgqoQksBcV9p+jjVHn0l/rNcPRim97H
         oPpZzxjDYoRLpmwGvmEfXVvyskl2dLKOInKm2ug6HR+MImzK0Fpv2qOgM800eL0n8ArB
         AH8PilXLV2i0wc2IdWGgH6scGg+eTcgZx4Gu4fqsQeYRyii8SqMahJmOZuRkCdto7CbJ
         NaF78yhO5bp5jXq/4LkM6ApiOzYeOe8WcDv0Ac4DZbPdQ5Jp+xYz6UlirUox1veG76X+
         LILGfPZPSNVYoRCVk9knImfEylUAFsz4RqkxOZytQ9h1571e/LZbwj7FTJQUAvCpvKcv
         dyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiz2igSgKu8GGTdTMRHWlQKh4TlxZ7q/JD7hgHC619lqeRieHXXt0NxJkrlXUgESLgaTdL2m0B+siMqJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqP8R0Wa4jfQmGQYHeDNI1Dkb8hPBFMjUWCQrKMyqDh48tewj
	jZgcG/I93w3GPgEoyRvY0ysDLa/ylL8h4uSsDEXoEmbGd50kO5aPeCPaEUYm/4s=
X-Google-Smtp-Source: AGHT+IEnvTVlqiO6GIBm7lampTt9bPx2RUwGdovCKknaCN6PZBCzx+SyTqmg5qzcSMj7gEWzB99BNQ==
X-Received: by 2002:a05:6512:39d4:b0:53a:bb9:b54a with SMTP id 2adb3069b0e04-53d9fee1ff7mr1607071e87.48.1731504975767;
        Wed, 13 Nov 2024 05:36:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:36:15 -0800 (PST)
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
Subject: [PATCH v3 15/25] ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/suspend the SSI
Date: Wed, 13 Nov 2024 15:35:30 +0200
Message-Id: <20241113133540.2005850-16-claudiu.beznea.uj@bp.renesas.com>
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

The ASoC subsystem takes care of runtime resume/suspend the audio
devices when needed. Just enable the runtime PM on the SSI driver and
let the subsystem runtime resume/suspend it. While at it use directly
the devm_pm_runtime_enable().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 4af381f6d470..35172630be8b 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1140,11 +1140,10 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	reset_control_deassert(ssi->rstc);
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed\n");
-		goto err_pm;
+		dev_err(dev, "Failed to enable runtime PM!\n");
+		goto err_reset;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
@@ -1152,15 +1151,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_pm_put;
+		goto err_reset;
 	}
 
 	return 0;
 
-err_pm_put:
-	pm_runtime_put(dev);
-err_pm:
-	pm_runtime_disable(dev);
+err_reset:
 	reset_control_assert(ssi->rstc);
 err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
@@ -1174,8 +1170,6 @@ static void rz_ssi_remove(struct platform_device *pdev)
 
 	rz_ssi_release_dma_channels(ssi);
 
-	pm_runtime_put(ssi->dev);
-	pm_runtime_disable(ssi->dev);
 	reset_control_assert(ssi->rstc);
 }
 
-- 
2.39.2


