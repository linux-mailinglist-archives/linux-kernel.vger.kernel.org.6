Return-Path: <linux-kernel+bounces-407673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08869C70E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9926E1F21DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961D1F7065;
	Wed, 13 Nov 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fK3gTN7j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560D20265E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504964; cv=none; b=mYDwh77Wx4+71RPoGm8D/39f63WqS3tToYkHZn3+7eqGslzienN6i8B+02ad+zUFUlDY8h1Rlfr0VtfIskj2Ewurv4m9GZ9TIUee6hYttcV0LOl8XNPuARIPYL3gUFd4i08U41PliydMi2ythsYaaLqVb9xDgOghIvdR85Pby4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504964; c=relaxed/simple;
	bh=Sz1PAChDcM9B6CCJvpuwCd6OJsVNXMcyHPYNhDbm9c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBtsHz8I1FpnGUAjqdDoqpM+SAxvfiToLof2NB6rrd4D5o1pRHe3w/ZwQoThTE6jkVzQwh3boGdj539Sdwa6sqhpZ2YOIFgbkN9TSPKt43JRe29IatdO5rPH77AAERrW8sEiXwMpPioxm0RMB7mlm6EeES/biMVxCtU3UlHByqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fK3gTN7j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so59256915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504960; x=1732109760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaN72J9oCjuJRB7FXPQLRWlL5CXlKXSOkEeKQxWmO0E=;
        b=fK3gTN7jiIIAtO3rkYMWViQ7kwSobDSblhvVDlndpe8/9iBB8nAKVldreAUVzg+SvA
         jKcupWdRqJOsqZo0jrgpnYR3AxsWnylOhulll5e/7AgSkuEaoE2S23U1Qa5LdZcNufjB
         H06/HXplKzimOfo3qluFqCrbOFUzTwYl3MIpVBKCkghTZS35KjrTRK9vjBSy6RxKMrWZ
         zjxmHCHQMy/8SBP/jjgGJpz6NRvWFbisVKSILQxHj3V6Bvd6vgXsJSlQuIsgxyXcCrNf
         aCYLHETVCdvlZa42tE32LP2ieOw97zYs4XNnQWm48SvoeVSjQBCQYEoE2lQd2YTbH59l
         zQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504960; x=1732109760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaN72J9oCjuJRB7FXPQLRWlL5CXlKXSOkEeKQxWmO0E=;
        b=AwJyYOt5Cz7JrI8nDNi/B8h75SEh0F8ecCOTD3XPEIfesnKBxtcqawwAOVuSZ41Eki
         5OhanvXx2E85pVU527dnam5KP1Oo4t3B8bQbK9mAHG3SVoYEJpjg4nhA1J+Zw2/RK1th
         lvFhRPGHd1wHW8HMEgZpW2wj4Xp1HOUi4oVNwGi+eNvN4W2yN8VVgR9QbCw7op+gUtEP
         erLaYawKHuSLxze7J6oEBGCOZPuV479TkhjG74XVSMSeuRHOCm+2bjK45OwxqID6BDQO
         uguaXccATXrbAQdayzkTZQ7ELkMSZLN/nmZ6LYl+ggwB1LBfCfiN1zmBZW5PbkpzyJWq
         SCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWKcboFA66JAFqHEc/r2QC6wx0O7tNOCo2UKtB1f0T8hQh5rf5VWtq1GqcFW+Fyw9GRvJhfbk+nlamCBRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4skh9emf6nfbVU9eVVtmDKRGJ6nRnZ70HWJNErNZn1O/0K7D
	7lauylBY1xd7o4yhpYz6Rt1QbbpY+kR61dvaUoyKobbnD+FnQS5A02WZl3K8Eto=
X-Google-Smtp-Source: AGHT+IEMrNnWePZLL6c2pl45w1yaF9tt+h731CuGi4h+iBycfvBUpWEwqJT5WVYgqo485BsTWQsP3g==
X-Received: by 2002:a05:600c:4f43:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-432d82d6b43mr9287205e9.30.1731504959807;
        Wed, 13 Nov 2024 05:35:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:35:59 -0800 (PST)
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
Subject: [PATCH v3 07/25] ASoC: renesas: rz-ssi: Use only the proper amount of dividers
Date: Wed, 13 Nov 2024 15:35:22 +0200
Message-Id: <20241113133540.2005850-8-claudiu.beznea.uj@bp.renesas.com>
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

There is no need to populate the ckdv[] with invalid dividers as that
part will not be indexed anyway. The ssi->audio_mck/bclk_rate should
always be >= 0.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 2d8721156099..b4439505929f 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -258,8 +258,7 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 			    unsigned int channels)
 {
-	static s8 ckdv[16] = { 1,  2,  4,  8, 16, 32, 64, 128,
-			       6, 12, 24, 48, 96, -1, -1, -1 };
+	static s8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
 	unsigned int div;
-- 
2.39.2


