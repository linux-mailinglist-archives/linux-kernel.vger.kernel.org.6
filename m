Return-Path: <linux-kernel+bounces-397800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FB9BE0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F5AB246F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F64D1DF96F;
	Wed,  6 Nov 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TIh+w6Ts"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C41DF273
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881211; cv=none; b=FjWu1jqJ7YB5Dvk0S0upKSPsCEzJly5r80Ul72eHaeXnpmLi244CgR/pyZYi6McOXn6Lot8M/o4oJwsPLKHkG4bTwWeLew1m/tHgY22o0v2UQbxPbnOHzWF15ZwNln2oC1lp5w6p4EDdxg6KvXtPfXMZPotsEznem3+bKgcwqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881211; c=relaxed/simple;
	bh=QhxaHQhEQbSU4HAJMWAlhJ2b4bTmMo3I+DW+bAanSzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKMu6Gwup6SCR4Z91yBlTn+hKyjzm7p5RVMjOlz/QLXcLlELD907arqf8KaigwTzGQYD6f8nmRcOYzrksZvNkW7lhReoel0u+OAAMV2DjWyMyPr2gUaj5UcC6i/Qf9wkYx+9L0eQnIUfH80Ka3jbIDLIxlPJFKnb9Dr3H1VQwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TIh+w6Ts; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ec86a67feso70995666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881208; x=1731486008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keyxaK/rf+1WXM1+Qgkj4yMP90XxmUdDhzWy2M4/zFY=;
        b=TIh+w6Ts9/QGIjkZVRMuvcYh6honGGH7AQCc2wHlBks7lL6Q7RUe+GFhDqhJ2Jpout
         CCmB2FJZnP4QPCDDLOowbK3AEWW6Xf5fA60/OYw8ABgcRLRUiRYBjc75T3Trk10EV6pQ
         7hQqtVyXYMyAK0CFfEeiWCTf5O09Ic/eoZ5SbDT75ufJ9Hu0abJuto1p0idx0NFlnehR
         JbrXb3rn53+o4JO2hmCacyad1jPQSs9TBryNbL+mpZroMOx7vmq6Wm02f5Jq4q03deLG
         x6vWjSoyrK6kriK6RgD7/rlhoPjQVJQTZEgu/4GXNlXtzSYZxSKKF35KZtgCMBgxs+lF
         HjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881208; x=1731486008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keyxaK/rf+1WXM1+Qgkj4yMP90XxmUdDhzWy2M4/zFY=;
        b=ZcbGBQCDFfOjs6SlHsXFB2rtWzsTltHT/EzqHcGE+9N0slNdTG0oYGRnSzVryjw90j
         eaUfhO4D15PN7AyXxDwsU0fj9fPZZXVjBdB0ttpU8yo/2TXd291MEHMZViCsFAjZ/ANH
         zyJyClIMZ1pdWp1mo5NMFXGE/RP310EiaPe9szOOr0R0JKjvsWr34Kx/WcMr3+cHAg3q
         lFy8JSLXZQ+bicKNYUleHzC7eZFmOUYUcWvOnLKnF7Bv8OOXBJPZOJK4nTPUSMfJxhbl
         Ra4rIWbnU6eti4QdefwKkadAOFwEngKbHfy80r7j+U85Y3ISEVKU8nYcNjWkeIAL6khC
         XPqA==
X-Forwarded-Encrypted: i=1; AJvYcCVhj/7h3EgQX6w7pBPyGlQXqNslClBbMb02JNBPQUtc4bmNw08kVXjtMg4nFMjo1f8I76z9hmQ4yFiSlHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJOTTGSJWoGuibEXiO8mBWr9pwrcTIO+BnTtOPjMnwf1ZpaB2
	hJW0+cm5vyCyNFQ8EBv1Vkr/+nF352jQCed8YGwat8b+uvwC02BH8IsP5THkE/c=
X-Google-Smtp-Source: AGHT+IEGdOR7nmhmm5rVDWL/VF0T9Y8wlc2teyYuu+R9m98yrznQ5wa6C0FQenz3Cgm3gZGz4QX/YQ==
X-Received: by 2002:a17:906:f597:b0:a99:ebcc:bfbe with SMTP id a640c23a62f3a-a9de5d992f1mr3807862066b.27.1730881208017;
        Wed, 06 Nov 2024 00:20:08 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:20:07 -0800 (PST)
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
Subject: [PATCH 24/31] ASoC: da7213: Add suspend to RAM support
Date: Wed,  6 Nov 2024 10:18:19 +0200
Message-Id: <20241106081826.1211088-25-claudiu.beznea.uj@bp.renesas.com>
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

Add suspend to RAM support. This uses the already available runtime PM
support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 4298ca77fa30..01c78f8032c4 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2235,6 +2235,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops da7213_pm = {
 	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct i2c_device_id da7213_i2c_id[] = {
-- 
2.39.2


