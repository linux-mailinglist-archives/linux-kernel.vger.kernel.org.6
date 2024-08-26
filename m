Return-Path: <linux-kernel+bounces-301744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65C95F4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E429B21CED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C81946A2;
	Mon, 26 Aug 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PlFzkV35"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B419409A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685946; cv=none; b=ekifa1nqg/1ycgPiA8R3OszdLTnixEBM6B8CBF2OaWWMfi7+ZstwNC05hUkQ8QYm3gyeDbt9OoWfhncBsahg9/hvEj3H4oHcmh5YLG4a7ee40D76bN7rWt7rFe/80swG94cGkJ4y9En1CoiSSvwmeGx+iJb1Fwhxb94z2ucC6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685946; c=relaxed/simple;
	bh=rsZuUfNZcs9lg0rPx9CSZBgjL9st+fLll+W4cyWgdkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORLGJI7LNGCoDB4GEGQElG3hSmKGmhR/uibbt87hhrsi4oZRfNTIS9dcHGT8gxOevrDLBV7mqUEyVvdfb4LgvPnh6dNuOv8WrIdqez/jM8VFxJO6cvPwj0Ny9Yflq8lpkUgKC1KiqKyF1y3NtFry6tBW2vtHHiYObFjM4YONw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PlFzkV35; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86b46c4831so250224666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724685943; x=1725290743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKZW1L3bK8VtJFD4UHbqlhoKQbHeYiPWb3w9DhKsGU8=;
        b=PlFzkV35kguZ4oZgO4JXg7bbAGyYF94UoEdRWOILc0frP96aSzjnuER6cIljU9JzZH
         JCFn5wMJps3c4Rnkho6R7goLyC6ozBKHPvEghuXR0rd3X1SO8XKBYl78aQWCzIkY+l1+
         eqd5B1bkwS8GCyg5X8MwXYp+MZzPd7wFC4UbIBYrGheIkdN9Ig9/JECYsS3LtAXAUmF8
         bxGUt61r/2nRTzRTpjAzXaRlu2Fwzyo59IKXByOfVeLINe5TaUSLNCbTYeNn0UyGSS/8
         Wjzv62muWDCI7NHApqCtOs2RqGxteT1K/bXHrtfa/uvrpCL0DrlevcwZhjZI4jOcdxC5
         /vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724685943; x=1725290743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKZW1L3bK8VtJFD4UHbqlhoKQbHeYiPWb3w9DhKsGU8=;
        b=e3GpVvTvADh1zkHaPBD/HHSD6Xrw3ZwdjbFNi5y4kvIltR50E27g9kLhmWj9ZwiD3N
         H+OFJSR971mHuOZocsrG+FO7e3e0exNZx8OvsNu7jnsIdMT4f7MjL+BqTm/b+mJyVzbd
         W0Ywx5v9ysOv6AtWptQuk8aOkyiD7t5vLdUPwiXTRKVxKSbool9OF8w/s2fMSQr7vuuf
         J/lms4am7RF4qY4qpHNrZcvq3uh1/JLAqX5KYfNdN8p19SECU0Mmxkyb5aAgcbpyRkkY
         98mlLi+rn0wHCv754cn+MRVgMY39g5ieJMsyL85kBA7/GOy3+WOkVE67ypMJucltkmRx
         MPOA==
X-Forwarded-Encrypted: i=1; AJvYcCUdJVVlYi7PmpjJ25+0XtfC6xhWxO6Od+U2Ed1fHLVG+Ie0CqorPodt64ZVHS+dKoHrX8MjDtHlDlw6sOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHXYDfS7B94FVFNdHT4ljis1eqT3aJnCctyJLKFIQWJBziHUd
	Jq/f8hw7P90UwO5HPfmXfzSM+pBIhRi2XC+jrg6KDwdRgrnPI0YfS+TGReyIL9A=
X-Google-Smtp-Source: AGHT+IHwcvV+iRgWb/1qPSucDkWuaWbymy91bdnFpsjuT+IA2I+XKOr0Sq6pyEAf+2DomRgdSdho8Q==
X-Received: by 2002:a17:907:c27:b0:a86:8166:1b0a with SMTP id a640c23a62f3a-a86a54efbeamr802439266b.56.1724685942736;
        Mon, 26 Aug 2024 08:25:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437d5fsm683005866b.99.2024.08.26.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:25:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/3] clk: renesas: rzg2l-cpg: Mark watchdog and always-on PM domains as IRQ safe
Date: Mon, 26 Aug 2024 18:25:28 +0300
Message-Id: <20240826152529.2080248-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

If the watchdog is part of a dedicated power domain (as it may be on
RZ/G3S) the watchdog PM domain need to be powered on in the watchdog
restart handler. Currently, only the clocks are enabled in the watchdog
restart handler. To be able to also power on the PM domain we need to
call pm_runtime_resume_and_get() on the watchdog restart handler, mark
the watchdog device as IRQ safe and register the watchdog PM domain
with GENPD_FLAG_IRQ_SAFE.

Register watchdog PM domain as IRQ safe. Along with it the always-on
PM domain (parent of the watchdog domain) was marked as IRQ safe.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index ec0672651fe0..8e4f17c21dd7 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -259,7 +259,7 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	/* Keep always-on domain on the first position for proper domains registration. */
 	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
 				DEF_REG_CONF(0, 0),
-				GENPD_FLAG_ALWAYS_ON),
+				GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
 	DEF_PD("gic",		R9A08G045_PD_GIC,
 				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
 				GENPD_FLAG_ALWAYS_ON),
@@ -270,7 +270,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
 				GENPD_FLAG_ALWAYS_ON),
 	DEF_PD("wdt0",		R9A08G045_PD_WDT0,
-				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)), 0),
+				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
+				GENPD_FLAG_IRQ_SAFE),
 	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)), 0),
 	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
-- 
2.39.2


