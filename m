Return-Path: <linux-kernel+bounces-397784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5C9BE064
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F31F23D06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355631DC046;
	Wed,  6 Nov 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y7QszrUW"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AE1DB361
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881176; cv=none; b=Kv+E/ZV+gz2yFwkedYLCxVhMyA7Q2g2qaOzzf+kC1Wq1obJYcyN5zqe0/Jrfzn199W138UkWN2w166jGw/p5iw5dYRRHftBLSceJ8c2WTmT7SzBat1wi4Ef8z1uvoQSqxt61Lq5u2tNBDyRtZwkrfkJ7dRRACuFJ2WPG8EEakpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881176; c=relaxed/simple;
	bh=a+IUchkvg57gxZbkyNp9bTZ3an2EXOBGERsCCV+NV2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8iZ+G1aOL7TsdC+81wy2ZExCY6xSnUXKORjcBxzDsp9Tw2BJAppP0XUDC4c0/AfDcTJoSrWH0ePAK+wQ0Pu5ffntP8w3Ayv9qcFJHywuj+bk57c687LxIeRCiP6cssWNWRTqUl4rbBeGCHhnx26GdggUBTcAN3FuwPXO5DAsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y7QszrUW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so1080305766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881172; x=1731485972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54nqiDHAf9M3O/5JYgCXuFRVc4rEVNuOCEXOJ805IPg=;
        b=Y7QszrUWozmghiossX93kjZkOO2rnwBuTn3wLXQ1HqdJYysAGEIxo9owGy2j3nO+c1
         WkpCC0H8OLsLBHBYS/Vo/lbmn0ggLaGdAwxM8HYvBtPP3FYaFYYgLIXpeNEeNq6fntUS
         smNKazFySj8V54iPpK+zxbm29e4F+GI48kS4kJc+3HwNeXsVl71aTVKpvK2orW1T3GRY
         Cj3AOzR+larPoeJuC+NgnfPjaXAaOJJ1qg++dj0TIGKcnCqHC5W35SJwFASDyvrHHIWR
         CX4eGegfWi7u492uwqR1/S2fp9d3DNESXdRLG1e7qLDr1233NwbZhECHKTs+w5jPJ+jC
         M2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881172; x=1731485972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54nqiDHAf9M3O/5JYgCXuFRVc4rEVNuOCEXOJ805IPg=;
        b=cwqMcBnKkn4i3N4YSywbE4X0xdofhosoRtm0Z+NEBI2Bmt0ASuMN59nDIJCP2VH8Yq
         LDq1jRX8k92RL/iVT0nrnw1avcCG9KbuXvkkVAhHj1ueQ33WrGgTIWe1Z0fzoGe50lA5
         SCm3a0BFOqbToQiMh6cxiVD5UMknHXqyCJSB9rpQ/YUZtKQkwqcWur6TnxYiKEHO9Eiv
         McUnB3byG5Qr6WmCVVcuIynuC/WdLPfks3T+n7t0Pzy/4Bb6znKObM4CejPfZhx6EXf9
         fIz8k72x9+TdX81VTZnhLOQd630vUMUlxPXtNQ/cqIUOQ49e3G+p3GkRPyqmlNZpbu9H
         bAeg==
X-Forwarded-Encrypted: i=1; AJvYcCWwXYvm2Xf5UvQvWHwR2Qn5G3ob9r7h6dORMhX68ZZTAJ3ihXOkwz/o1y4Hy0eyF8o275Kg9PZPvoZNRtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0RTw5HYpJujfbx6zvoIORgL3ReDD3G9d77aEb1oC/IVtxSN/
	RFz125ohtPX5LZu20Z0mR9zhwNlLmUta8FQNUiwEGoRSkVHBFls7bzztG9WAlqOPScqEKdZtiw2
	o
X-Google-Smtp-Source: AGHT+IF/XT22UAeG19xPFVLsEumo/uwLEK05hyFiHlUZcUMHq9+9v5dsaFc4UYukkjyQ8GsIJhfNjA==
X-Received: by 2002:a17:906:bc02:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-a9eb150ac01mr535571666b.5.1730881172333;
        Wed, 06 Nov 2024 00:19:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:19:31 -0800 (PST)
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
Subject: [PATCH 08/31] ASoC: sh: rz-ssi: Fix typo on SSI_RATES macro comment
Date: Wed,  6 Nov 2024 10:18:03 +0200
Message-Id: <20241106081826.1211088-9-claudiu.beznea.uj@bp.renesas.com>
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

The SSI_RATES macro covers 8KHz-48KHz audio frequencies. Update macro
comment to reflect it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index b4439505929f..a4d65be17eb1 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -71,7 +71,7 @@
 #define PREALLOC_BUFFER		(SZ_32K)
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
-#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-44.1kHz */
+#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
 #define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
-- 
2.39.2


