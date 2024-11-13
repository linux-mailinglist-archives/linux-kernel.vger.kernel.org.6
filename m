Return-Path: <linux-kernel+bounces-407671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1599C70D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8223E28A09F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F731F4FD4;
	Wed, 13 Nov 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YcYu1xGk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAB20127F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504960; cv=none; b=cV9EhJpsXPVTMKnZUE6F2CzyK55mNE6aMlISx9G9XETFqJnwYvsJcTMHOprR/JuAvJKZX10idAvhZLml9oSkQngMGT4gtqiEX7YBVeRwtw81AplOCFNnPyGH1Zc5fcOdWu9NLoEG9ZZ/ys6kuKVtoTSe8WdeBSG5ZTqCdbhn60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504960; c=relaxed/simple;
	bh=hsInE9S4S/vwenjeM66DD4/pCHktkvyL4wYR/f21JYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRqqnjdRYKBNKMfPrE6twA62S+sRujcVadEIN6cCv7jQsfLX+GvJ8JJQwJTUMqbzAWwi1RwYkNnLt+F9A5UWFE+MIsX8uNAre4VMs1gu1B64g/hnfNP0425HbIGM90/goAe1SC+hyFpYyi5r85eYLKa43/rcNBHQxZllgGkF68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YcYu1xGk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da209492cso635627e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504955; x=1732109755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMlZeixiliINj2sB8B/Hsjodp45t1qy+/EotEbzHeIE=;
        b=YcYu1xGkwpljYym8LpPMHKuiZvIvXup09ZYCunlEKTd8XO+zpH5qEgnw/ApWezX6Bo
         JgTEz2elBcZXHxf0hRuZmEamkdek1ymaRorKkyZvN/dDhRasl9C+c3lRDjLhFt/jMgvG
         4g72FdMdxMT3ba9Oa/i7XqUqd7M93JxQOJih9MaUGVqDPZm68G95cOcABY2J0wNt0BE5
         DgXrLqdamji13Dzrn8joilMR6Xs8gsyqcEwvsK+d5D1qU/8okfAuscHf1UAibMTloRX7
         OhB8XT397jgrLdQhOjwcm/PblL/GnbtoUU0+sBSVdz2QABuGFI+5YGS238xZgyAJY96t
         bBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504955; x=1732109755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMlZeixiliINj2sB8B/Hsjodp45t1qy+/EotEbzHeIE=;
        b=fz8h3z27GZrmRIR0F1Eiuq0xqWjUR/i9UuqebQv8m6NR1nppZ7zcJqmDO27c05/sS+
         pkC+RphawKGYnxeBeLqATdOR8pJjF27upzFufiTD0HWbeFvSDQoGMHVqXL93j/ZvLIGk
         0CkgQLGFwKK9aDya+voz0sXcaL3xeabz20P+v8bc/EFzA8wf0DxAYmsrt3cTITLbWLVo
         QPjZqRHpoOwsL2o5q7jymLP0PdZFBVBhBvSzLhJE1L8TPZ2Cv9hC4uum+2h/xchIhC52
         Zy2d9zcm+P3cmi+2FsIEg2ld9dlYFI4QT2DMEKMy9gCWIz0W5iFsL1TotIAwLlULviW8
         F3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC2ehZmTul3EbmwAWI4fxzmnc5T9S2CgQzPp/bvYRak5MSb80x5BfWJ8kLyOv13Lrcc92tgAQpZp22K+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpd5yREZQNngMhPx4ddYO684moOYFdfQe0gRi3vXz4/qgCU97j
	Oe3ku6LMj4mdC6JcDwIIhN1L4+L3eUUzJv8C2T6zVRdLbRIRy5RncctwRvrFeAg=
X-Google-Smtp-Source: AGHT+IFDoqWlc+LYE1IHHSkdT7sRQOeKuofe1Yq22n5/D6CUznab7ngU7zpCUFlNPYH6frvj2r8HUw==
X-Received: by 2002:a05:6512:3da0:b0:539:8fcd:524 with SMTP id 2adb3069b0e04-53d9fe8ad7cmr1333681e87.30.1731504955530;
        Wed, 13 Nov 2024 05:35:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:35:55 -0800 (PST)
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
Subject: [PATCH v3 05/25] pinctrl: renesas: rzg2l: Add audio clock pins
Date: Wed, 13 Nov 2024 15:35:20 +0200
Message-Id: <20241113133540.2005850-6-claudiu.beznea.uj@bp.renesas.com>
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

Add audio clock pins. These are used by audio IPs as input pins to feed
them with audio clocks.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- none

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8ffb9430a134..1190ca4b1808 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2086,6 +2086,8 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
 	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
+	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x2, 0, PIN_CFG_IEN) },
+	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x2, 1, PIN_CFG_IEN) },
 	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
 						     PIN_CFG_IO_VMC_SD0)) },
-- 
2.39.2


