Return-Path: <linux-kernel+bounces-372717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B69D9A4C34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AAC1F22F60
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09391DF999;
	Sat, 19 Oct 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B9Zsvemh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A981DE8AA
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327678; cv=none; b=dP0oA5JKeBQp8j7TAmun6PL+lwxnraXWI32GvLb4FA5FO2CXQ7XSyvpQOVj1UHsWBDPTrssD0lYn6qLY2l+OLD160mymnVSMVkGoWuNj+DEZ9P3oU3Mu/K0Y08XfE5Lct/TqDsKoUqkulFNmSa0UA/AUvN7DDNdCFIN+jVxNuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327678; c=relaxed/simple;
	bh=bBMfGXWqc59VvywxMcrKKTmoSCTWD+93WcF84hRM7k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsyPHS8HJNH+Vp/1hqjpC8LcwM8Gs9KPTtA/T+0xxfUzZrIsy3o4bEtEyfusOR7C9qM4HVKqtOW98oT7s+NgdvHvfHCnw23GtcLKf8xfYa0jXxPbI62NCWTVX+3xwQgqDAoJMkDeeX2zqfLYTMqucLluGUsnnqzEBezbWv+DSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B9Zsvemh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso16525935e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1729327673; x=1729932473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su/gA2vZm43OZPNrjqU3H6dnR7lMMIQDMznyw802HoA=;
        b=B9ZsvemhVN2m5H87AdwSJGATcbgDuJzln1j6tjVeHE97f7YZZuIIi3yDODM/oqSgPW
         FFoDBK0NCSYvQnYb5hWR71czA/CGrXJJtcK8XD8POdaNJ0j7H3JUVjZZc9xS0vqU8qsB
         Y1znKXz52RCccAULtk4gntj5J62KqU7eQpedKI9BPMSPWVlp32+yxmw+fLnLZfOTfRAS
         Fgg05Tl3fdd3ZKS/wCUIF3/O91cUbU44yA0LXhBok8fuRzDiCPe7ptEy4drbzjCHTkr+
         dUdsxvSbgWcmIkJ+FTQJeJYpvQF9kbXgeK5O3DTjmgrIITRFSa8MAEjkTYMSkFtjZaYe
         ZKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729327673; x=1729932473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su/gA2vZm43OZPNrjqU3H6dnR7lMMIQDMznyw802HoA=;
        b=wUvo6Gu5WrSxXAliJyNzV+viDNIKSkPoSYgcv2Ll2WLuijIlJt4yd6yAkcITaOzbRf
         U6T6pqw69ARRmzXRu1fhzH47dH9FZWrCD02OYrfFwZRyNWXS9D0cgsJCn5KMtzv44GrP
         r3bS9gNBXeTx2XqoJzZIm+m8usKu0A7u42oFB9OzjCstJ9Gb5usxKI99GKSryMw5da/L
         TTxEOUrwuURYTsOI4fNS+1kx8NJPPUBTZSdnPplZuugnQx5pSKY9zy6HXVdQmgh4XPIQ
         QGLkUq4dGrs/NSZ5bVGVl8uJ7S0xLf/i4r4INaykyh2OM8vx1xV4BjTlXCLi1HhMQcXy
         R7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVJUTjRs9hUiTZQBDLwq/Er1r5WmySGuMavjM//H1irdns9Dd3a/vzXfnaIk+xNyJE+MFglZ8Gg3JDaIQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw576guAOR5MF86SkUmJ5evZtcxPOzwVIhnynR/Ki7GVplnsDGp
	poS1r57uVBAyszTVslRPGgH6WoO218ojgKjuuvUsEUPKNhKLRJRCp7mx/aqEI4s=
X-Google-Smtp-Source: AGHT+IG77C1AJn6G4KHr/98gwp5TO2FyaZmbbg9kHUJJo7AxaVAri13cwdvUg7gZGWh/UvC983QSQg==
X-Received: by 2002:a05:600c:12c9:b0:431:555d:e184 with SMTP id 5b1f17b1804b1-43161686b11mr51728705e9.25.1729327672912;
        Sat, 19 Oct 2024 01:47:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0eccbasm3898731f8f.81.2024.10.19.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 01:47:52 -0700 (PDT)
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
Subject: [PATCH v4 02/12] clk: renesas: r9a08g045: Add power domain for RTC
Date: Sat, 19 Oct 2024 11:47:28 +0300
Message-Id: <20241019084738.3370489-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241019084738.3370489-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241019084738.3370489-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RTC and VBATTB don't share the MSTOP control bit (but only the bus
clock and the reset signal). As the MSTOP control is modeled though power
domains add power domain support for the RTC device available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none; this patch is new

 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 213499fc8fb5..97ade53f79c3 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -304,6 +304,9 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("rtc",		R9A08G045_PD_RTC,
+				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(7)),
+				RZG2L_PD_F_NONE),
 };
 
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
-- 
2.39.2


