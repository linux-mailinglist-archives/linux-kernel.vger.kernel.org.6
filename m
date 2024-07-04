Return-Path: <linux-kernel+bounces-241586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA9927CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446C31F243DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D11369B8;
	Thu,  4 Jul 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVJf81ez"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CB76050
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116796; cv=none; b=QL50PwnKbBp4uc9ch5zmMPhDEv2QLAVkLRSa6txJ/lA4Y8gW+8QcrIEm4kct1gobob6acukrzKl8sWGELlAfNGyrXDsvrbHWkq3qzX7BKm7dSuAEWMefzr+xxMMK0pGaoJe6/dG0M82YlWY5TdXQ/rR2kEYKnxPZ0S0EsVYMpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116796; c=relaxed/simple;
	bh=OUiWTZTqWlc4SvJdwojYPEb1CINd2C0Flb2icDCmd8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgSoUjoNm2QNhzPDNA3ddTaJnbU7jgnfdxk4LiLbWST6efG+r0AyCxN/tQ66fituSVZg7aTRb1wyVGgM6R3wDMVbL8ZhdsoPLfEjX/GaZio7z+7VcoUEihL+Umy975j1kxg1XcEfjclwIHVaM+Wia0WNl0OKq+WqbqQtOn5Slqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVJf81ez; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so9607701fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720116793; x=1720721593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5wmc3JLBv697TtUhyKSB/n8Ks6mEjR8phindw2vHwk=;
        b=MVJf81ezAlkMt9LW9hLkHiO3N1uWx7OTf28roo3SsCyYx9OeHRNmRl9DybYeW5oTjf
         TzRz0Z9RDUFYeK7PhC0EqpUZpn48zi7fFC4LdamXy/aSwAE/4TzN67mCAXL6868KEuA/
         Y3GTWnPC4QiJXRgNhc24eB3udPvnsDve0wdZs8SZhnMQ412SLaf6R+1hboidLQC9W22d
         5nSythvK5G95nKXncauRX3wC6bBYdYLKWPsigvHZxkdmPie+uUi+3vX5wC0UpGoNmek7
         B2bz1/RkWPrFfxg84GdWt9mP1Y5AD2ZTu7tfxLiMU9pAkleXTj8GmZAUASHgsxvBhb50
         oyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720116793; x=1720721593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5wmc3JLBv697TtUhyKSB/n8Ks6mEjR8phindw2vHwk=;
        b=QW4dm4/fmvFra3LkTugoTcjArAFf+qA0pCCnnhMeB5AKieFfU12DAhFgJk4+J6C4Y7
         y4iEKJGcjm+yEip4BRJh0LX2dGsPU/RxIF4+Ak1Gt9MrqtO/Upr0AVOIuqlkHFUC2OSw
         NP1xlV+89B6wc1iNFoBWHkqEdFBrQxa7iBVfSzJXg/hITtCYxdEOQPNIscX/rRrylYeP
         ZISqsgbs2z5vE5uP727gPF5kIpQTEkASfrBk1VFrZ1kgf8m0J1QG7bdut7BvKpFshZxW
         11ELLCzoFaw7BV9yDW5FF+Z7dQfccbrlbXZCRrGd7FFSQBO47YohZSNS4eSqYjvCDBp1
         FMnA==
X-Gm-Message-State: AOJu0YxfBQXJwSC9ihZeyAhHCnbtFE3VbmdysqrkwWkN3WVf3fNNYw1H
	YvSgqruFmJk58EsDrFad10H1UFqVZCCJ9BFexp9oDWeYgzSI0/x9
X-Google-Smtp-Source: AGHT+IGbXR/+ZfGhIcPgZDZTcOHuwAG7346JR274Tx/ADP/F3rMhj9KO/uUeIY6eA6HGN84H7lmFcg==
X-Received: by 2002:a2e:6e11:0:b0:2ee:8d05:db2 with SMTP id 38308e7fff4ca-2ee8eda81b9mr18148491fa.29.1720116793075;
        Thu, 04 Jul 2024 11:13:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-0b06-a203-2f25-a0f6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b06:a203:2f25:a0f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25198dsm32993855e9.32.2024.07.04.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:13:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 04 Jul 2024 20:13:08 +0200
Subject: [PATCH 2/2] regulator: max77857: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-regulator-const-regmap-v1-2-bce0ddef63ea@gmail.com>
References: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
In-Reply-To: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720116789; l=817;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OUiWTZTqWlc4SvJdwojYPEb1CINd2C0Flb2icDCmd8Q=;
 b=hPieVHSguLU0SUKYUs6fc1/2nA59LGIf1SNaFxyxkKXOgHDW5nIM9HNwtFinOinEnHU+M2EgC
 ZAS3xRetrkqAXzzA5kaEZh/vg6n7pWDqU7kaFCNoOo6jStc4vqVY4hX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`max77857_remgap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/regulator/max77857-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index 145ad0281857..bc28dc8503a8 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -67,7 +67,7 @@ static bool max77857_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config max77857_regmap_config = {
+static const struct regmap_config max77857_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_MAPLE,

-- 
2.40.1


