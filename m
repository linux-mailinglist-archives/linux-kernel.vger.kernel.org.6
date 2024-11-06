Return-Path: <linux-kernel+bounces-397791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E359BE087
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34DB1C23333
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213C1DE3AE;
	Wed,  6 Nov 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IPxMBA+A"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B771DE2B3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881190; cv=none; b=qwQ0WLccv1BWKMeoZJ3l8UJavxYTXFDkMxC8hVT0zUBaW3Hj1fnVkT6vYI4KZpqVBCbYlMYoc9SVtZyndAucjAJR9v1WntkABgU+LkO44+2v5QcrhpL1EJYTvESARIBWEMxnSjOoUoR8iHIY44nOBA2xo/haxwciLMr+QlgKKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881190; c=relaxed/simple;
	bh=YID8IYH610Iing2cJZPx6UW3BF5bizj27YuaKHhCdes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dc2xUbvu/lAkmx8TuL8CcI3YtFGB2/1euuF3lxJB4DcAAUcJgF41ZBGFR9lEveCbkvvapOz0ysYvj8Y46kgqX5+joIAahSYFihvJi2ZIfEble+P9FXqMe3NzjRvtvU5FEs5oacnByNMlFuYgm4ns7CRKqXoMm9icetGYiCaeDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IPxMBA+A; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so748935366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881187; x=1731485987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/hWNG3HAgCOlQHhONRJpVCG0tqayFG3P4E3MIcwkoI=;
        b=IPxMBA+AqeE6Pmedv1wrTxNQAWZTCS3raqm0AVS/vhYB+DKEglnZDQ5oOv68CWB62H
         EMGOrWKRexw2dbP9RYgt9Ioa+ecTsrbrIDdcYV3xMm3QRtylu71aSiRrW6iZyyFDFXjg
         u9cvmds9c0tzwMCWmKQr8KVqhKGpGfpO9R2XG4Ba0cvgnPWE79IRXiS1itkQTrQAHHhM
         e+Hg/EKxxFlFgCh3Jo54Yw6bH2hcdjugoUOT+VtHtAhmIp6vGtUVsQ2Mi7JlnuQCxGVu
         a+MGIWhl6MOewmoo9TCtgz2TlfMliC4rSjmWbTQdxzWwDYy1r/ahT1p7IwFW/U+jjSnU
         QMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881187; x=1731485987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/hWNG3HAgCOlQHhONRJpVCG0tqayFG3P4E3MIcwkoI=;
        b=JgYVOnXaf7/eOHcBwKMRBAwpyOUB6u7Gcwf903oDDImlEEi2uf+GUP3GW45uXN/AeG
         tI78x7pv6cNKMVd12GJDmHZyV/WDZv/xVAZsbb3T6EBrkSgWfQptPBEA+ZJtxE+HPpbU
         gAUDn5wLGYJrQaBU2eGhsRCmcD5r/l4/S+zHylepc+sesFnAJB0WbgIi5i6yubFPcU3T
         xQ1XATCPpa7QgPYpcsH6dSXRQypw1x1hg8sS819K1ZIVdzxfatjg8zZqSqBgQ1RlB9lV
         Q97nV4I+nBn6p4IeKxBGbVnTteiNxon83fdVIov3vyAbxyhZESLmv+wz/Ehov0QhBTEQ
         Ir7w==
X-Forwarded-Encrypted: i=1; AJvYcCUDSERZWt/bSnh4UK2+aW5WCB2CE7aucUZHz3Y42KNz7rVZf4wrnZoWTxLEeZ3QKbSai+WhKgqmKE3wmLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg92lstcqF2W971ribGD0J8u1POXQiepuP+l7eXpAFA/vN2o0
	eMb0T3IfxgHl1HTGqG6riDPIpc8S1Lme2yqjfW8MEQdN7PWfetUXzs5iitbVrOg=
X-Google-Smtp-Source: AGHT+IGuHBRrgKxJoGl8Urt0/2Ht7js+NxyCMe7K+fJ5ezE6i8Xc31oLkZHGUMAc7oNBPDO8yDM+lQ==
X-Received: by 2002:a17:907:7e88:b0:a9a:4fd3:c35f with SMTP id a640c23a62f3a-a9e6553afbcmr1883561266b.9.1730881187433;
        Wed, 06 Nov 2024 00:19:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:19:46 -0800 (PST)
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
	support.opensource@diasemi.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	Adam.Thomson.Opensource@diasemi.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 15/31] ASoC: sh: rz-ssi: Use goto label names that specify their actions
Date: Wed,  6 Nov 2024 10:18:10 +0200
Message-Id: <20241106081826.1211088-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use goto label names that specify their action. In this way we can have
a better understanding of what is the action associated with the label
by just reading the label name.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 0b5bc973a23c..468fefdaa9c6 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1084,15 +1084,15 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
 	if (ssi->irq_int < 0) {
-		rz_ssi_release_dma_channels(ssi);
-		return ssi->irq_int;
+		ret = ssi->irq_int;
+		goto err_release_dma_chs;
 	}
 
 	ret = devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
 	if (ret < 0) {
-		rz_ssi_release_dma_channels(ssi);
-		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
+		dev_err_probe(dev, ret, "irq request error (int_req)\n");
+		goto err_release_dma_chs;
 	}
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
@@ -1136,7 +1136,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(ssi->rstc)) {
 		ret = PTR_ERR(ssi->rstc);
-		goto err_reset;
+		goto err_release_dma_chs;
 	}
 
 	reset_control_deassert(ssi->rstc);
@@ -1152,17 +1152,17 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
 		dev_err(dev, "failed to register snd component\n");
-		goto err_snd_soc;
+		goto err_pm_put;
 	}
 
 	return 0;
 
-err_snd_soc:
+err_pm_put:
 	pm_runtime_put(dev);
 err_pm:
 	pm_runtime_disable(dev);
 	reset_control_assert(ssi->rstc);
-err_reset:
+err_release_dma_chs:
 	rz_ssi_release_dma_channels(ssi);
 
 	return ret;
-- 
2.39.2


