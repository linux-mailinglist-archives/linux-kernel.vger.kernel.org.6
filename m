Return-Path: <linux-kernel+bounces-388536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909B9B60F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DE8B22047
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E371E9087;
	Wed, 30 Oct 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="P9uLa7ec"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713951E907D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286117; cv=none; b=UGTD4sZVbCMDut/F502ZC0ssMticMXrXoNnTbEfUsG9GXLLU1QJvev490LjIn+wqlPstPTFz2K1p1ovv/u51SfmDL3+v3uFQcNEptzVWSofLZVdWOdDyyiyyQ5cyNAV73CvW4DueV+uKZv0MgqnStAf746SN4c4nRMIylk7yNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286117; c=relaxed/simple;
	bh=ITkAAPBuQN7qt/2aNfaGc9Z5M3Kkbo9w1OZJ+C50G0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGYo+uDHrYn78TzKOZ1lQMo7p5YSTSSqnYpI1z0OYGL+viCklP2c4pvWjKHbAtFS7MTbBCLNIxoQXMYx38rgtlQOKtuaxwwg0SI5janOieOS5juGlpdRuVmsA3IuWQ89l0kQHCw76GpK1N6T3k05gJNkmWROMa6lnLiKgyWP3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=P9uLa7ec; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43155afca99so4571275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730286114; x=1730890914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rgH4N0XoiBaBn2DnREg2ur7KL1nWjEyXhZb98mz/Ng=;
        b=P9uLa7ecQkPsoGz3RFrnra7DW5aBagtOIpPsbpt53gnQ9vVcGKyYW7z7M1bF8R93UH
         e4+2dsOfUzaSBt6iZp9QqEtBzS5uX5o+CQ59fvcW3py37oE40wb19nbCcLhB5hCnPhCG
         G+knFDa5uWzy5P0Pj7h/SVEXAg0N9/4BBk4WkYTImh+CsYwC/y2eZDqejaVziy5+AB1F
         NtCn0vkwnKT7D6LUCa7g68/t+UIPjGsub0X+Tq4JG/kpfiZnzatJH7QVWtKh9MbhdEnQ
         kjrzuk4eCAewgTEICLU0gLjv/3kBckHfxAnhDbeXEf4U/80vHbHf+liLAyLXQ3w0HyDQ
         TcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286114; x=1730890914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rgH4N0XoiBaBn2DnREg2ur7KL1nWjEyXhZb98mz/Ng=;
        b=uqAQqwDIuh5ZH+2C/IRwxN4fS08Xg9PT385vg2zL+p+Q7zOcVEyVH66OnBq2qkqeVR
         N89IoM2MhmiSj/2G+DKNYeadMfS15bMW8L7xxqsoobELNIulNRESvXEqkhkhFT88Z48J
         WXEaWGxJtmhMhSr93pbgYv12UyrVSyMA99Ewh6ock/R1wzsmVseXOfjhrRoGKe5dYId8
         6/3R1ZJE+elYzv1CKuKazmwGAY8X+9OGulHz6yLXG0lvoRi2HWiovBhhGmpToBQSHqyt
         JvEgBnV7xGNZRbQ7XnxxP4lmBT0zNh8SqobAoubF9+dpyWfve61fOLKeNcCuBfZGNCed
         0naw==
X-Forwarded-Encrypted: i=1; AJvYcCUiHbdoi2OIX6cNSNhLOTs38Ur8OeLh9PxqMiqw7xs1NSfbN9IhurD7e4LM6ZyOO4Ryf4DPreW9BuXDIRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxblOdHjpAkLX2wtx/a6EU0IzNfWhJCuQ5p/EO7zz8RtPjAN13
	GY3zs5Fc5aJfL6q/tz3U6XX22dDjjpKscd5uLCOtcz3W+qdiOL24aqdLn5PY7KI=
X-Google-Smtp-Source: AGHT+IGfKyeSaef4KGaUGWI/IsN7D3+8OWnPlyJSqw8C74dZyJJbZrKCWAh3Eh0KnB9ZpF56LKeAYw==
X-Received: by 2002:a05:600c:1c96:b0:431:55af:a220 with SMTP id 5b1f17b1804b1-431b5729f16mr45142475e9.12.1730286113827;
        Wed, 30 Oct 2024 04:01:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd99edebsm17956935e9.45.2024.10.30.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:01:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 10/10] arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3 flags
Date: Wed, 30 Oct 2024 13:01:20 +0200
Message-Id: <20241030110120.332802-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241030110120.332802-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241030110120.332802-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the Renesas VBATTB clock and RTCA-3 RTC drivers. These are
available on the Renesas RZ/G3S SoC. VBATTB is the clock provider for
the RTC counter.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- squashed w/ patch "arm64: defconfig: Enable Renesas RTCA-3 flag" from v3
- updated patch description
- collected tags

Changes in v3:
- update patch title and description
- dropped CONFIG_MFD_RENESAS_VBATTB

Changes in v2:
- added CONFIG_MFD_RENESAS_VBATTB
- added vendor name in the VBATTB clock flag

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0fad83642034..4f4fe8d9125c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1222,6 +1222,7 @@ CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_RTC_DRV_TI_K3=m
+CONFIG_RTC_DRV_RENESAS_RTCA3=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
@@ -1371,6 +1372,7 @@ CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
+CONFIG_CLK_RENESAS_VBATTB=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
-- 
2.39.2


