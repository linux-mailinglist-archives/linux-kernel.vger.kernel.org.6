Return-Path: <linux-kernel+bounces-440035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4C9EB7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8517C164BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7FE21420D;
	Tue, 10 Dec 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MAZVe3e8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF92237A27
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850640; cv=none; b=KdpHUDRWrP1DXk71DJ7nzy60xmsZWWkWov8qF+xCoUKRge13Q0/NGiDLqIPrRNPaz2oPts5s5e2N896IJnyXHygjl65EWqHrZMq+TEjQdapTyiLjK81wShSu6Dclhb31FpyBDdp4ejAyltoW8fJFicTuOMBGRUI6jyHihOLTzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850640; c=relaxed/simple;
	bh=Yz055MkA+pxfsMjRAkbTxtMOq7knGNv3D+SNR/Ylrow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBKGcjFvogXg0XTokXMzk4kK6Ri917RNzVHgzM1IlRV+vcfoqHX4OUvXRbT2e6gjO4R9BYlNntn7Z+eAbLeTrRC18s2EP+bjo4Jh9RbZhRl8eyy3wGRZwjjbqLDjK1LQGRz1Kt//vWcM3fMBVRm+j0PJUJFO5Rmb+4dY3jukSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MAZVe3e8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so9452020a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850636; x=1734455436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGFKtP/kqhSYwKWsXVqygeaqizf9KcZRKhKS1yEgkJI=;
        b=MAZVe3e8PZ9TTx9ehV1VXTuqvgGeoAxTuyx9+A38aNUVRkXEKeLwn9Ymx8AlYr7KEA
         XzfhBuBq0J82ZudgH2v0irugxF7G8Sp5KHxi3oJ+SVDxdIJkODXb+sosZfCyJVETG8cr
         m6RgsIiCkPfi3WDf6R89tMfTjzfoXW/bi/x2/UdJ+094drqSMGNYS/MHdxslkiu99U9y
         y78IP21BpxYyHQe3A480mWyYY7FAPrAsc4U1CgpBtvxo1h82JPvVOmfVbUcMrqjzv/zB
         xbCsj8tbDx/7y/RYIFSsIlDTFapOTNpr94fzJXcss63Sn7FoYv65qKP5d6PuKM89CRJv
         KuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850636; x=1734455436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGFKtP/kqhSYwKWsXVqygeaqizf9KcZRKhKS1yEgkJI=;
        b=fhy1pKT/dH2y+fu6XhmOz9v0tkuuELy+lJo2vgh9U390dvXEcDmpZGnjM4ww3NbIzH
         Wqyk38npDvwnEkkwTW23PXddulWmMMjJceBCx++O13Q0dWdPdYJhSDzWoZE2H0TwnA/6
         kVuNytbHZvQ2HLqk2zuug5ADqmggYYfPBaWy9HeOxe6T0gkOSYbvQSfrPOSg72vw81py
         FXBHxBkYi9g3lmx4nXhBjzmufjzU/J5O+6J7+IBsU/bKs1T+3fgR7ys+ZNFtetlOhKvE
         dHJp8h0T1zb6SmsCxwBniE2tB0ADrD8yyL7AI6OBrmvqt1fUdOgCj+Lga+yhwIGWsnoV
         cCnA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZsoGM0T3YZC30vh7QaYMrbPcrUsuuGWOly7b9cPY2yYBuvUUJ5P38a2Kd1Azz/zo3+RyaBG2ENrispE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kKjVILexi3Y/ZWXLaX+97XtdF49E0WirhQF8RZ62BsTuHVXy
	GT0U7g0/2dyJxsijpIz6kBtsJzhceeMQxrdz+6Cr5y0sNsrT9wW70SKeSKmquRA=
X-Gm-Gg: ASbGncsHV5wzoCC09rHzaBfwnHfZ/q7cVeAwfkfwH5rAh8KqvOiURdLzmmh5hNN5p3Z
	g2efUC0pUoihc8GBrG057qMcTFnbH02WCqyCOG+MEypygCKaYLw3b43QNN0c+U7i31VVJrF6Odv
	0kC1xBu9xy8h0tI1OkXzc4OIHu8AiS26qY6qD+Rjweei39/Zahzo6RP9UlaWB0JuC5GSLRjPN8V
	V4aZNLhrafnOEbeXqsaMY9oMnRLUclsOsmRbGXfTl8H5FTj1hoZngUOF3dzz6HtsWPByn6oXcLZ
	zgvnyUvY
X-Google-Smtp-Source: AGHT+IEC55JYbSGMCcanrVtAVCn++NmOM5lxtdpdi4NfwxaJizcleFUS/sRGsmrPp5CnJom5vv0rQw==
X-Received: by 2002:a05:6402:43c5:b0:5d0:b51c:8479 with SMTP id 4fb4d7f45d1cf-5d3be680125mr18546630a12.10.1733850636238;
        Tue, 10 Dec 2024 09:10:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 13/24] ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/suspend the SSI
Date: Tue, 10 Dec 2024 19:09:42 +0200
Message-Id: <20241210170953.2936724-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 209b5b8827e5..878158344f88 100644
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


