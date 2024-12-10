Return-Path: <linux-kernel+bounces-440020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D449EB80B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D30282467
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B0F234982;
	Tue, 10 Dec 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hDi+eEZM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C82397AE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850623; cv=none; b=kuBRF4f87DYZqx5B1k7qJbfyoKpwHdNg5xtcIub6jXH82QIoVrsMJVBGgD1YeZjWuhEO+122bEEVA97mdAMn/sAYNiJ4jgrXqgsJe1NjFw9bGd9/C8hzNwHxaG9LPGyIe9+krT1HPG3P2GgTB3FsRsOJYuV4vhjaiHFD67PJVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850623; c=relaxed/simple;
	bh=hgummav4gWlxydCCaiYlSrENU1T64Eunf3Cfp6+7rSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ErBL2uoRz/CGU7Mf+Xg6ZMUvCoIOk3dhDMJZIbe3egD84QqVprVY6+6CR37wAP9WOp0UmMQZzkqVdmK3rMQcmO8yOm6RbfQjCbyy4XryFcqGmc0oU54yF7BBg3lvRHXGtQmfX4jD+mUWJKui0udJFVLVbqr8H4lxt+7wDJu9SXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hDi+eEZM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso3810750a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850619; x=1734455419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFuKmapnbE9+QOXBiNESOVZ7AOkqywZ/u7IM8EV36Uw=;
        b=hDi+eEZMHKYaStvYGNqdq89LdNEds2TOOG3WmHMR2G5bGIw+1r7JQMrwNVZfDNGpQq
         67ciFOKnp7z+LRoH5r1a22banVTgRw05K7pEhUj7MyX/rloEGEncZE7eGcVfzXAEdjU1
         J+ZeOGFMmxO0i3FyoB/bHDuRHEfDrxwiSKLKu0JQXTDNFLSyeeI6ZceIYCG7hxfxoKQf
         ntMm/dLiPvrjDIk8TD+QvRLDjd53E6RhInc2wHnOa3GfkiWj5wCWA7ZL5aBMm9SZXWk8
         8TXzRDFkHHXW4WvzkIFKH0Ra45UICMoqR1uvMS9K3cBpe0uCRXP7uhuZepJJWNnMIWzL
         nt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850619; x=1734455419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFuKmapnbE9+QOXBiNESOVZ7AOkqywZ/u7IM8EV36Uw=;
        b=LY3/3tce+L2BRs700VKn+J1sGDuIYWSRic0mauXmYxF9kjAkjgkgWHpb5YwRa4JuZx
         f00PsdI0VbnIhjv99UYIuhFZzNIwKCiLaVOwBrPKL5+JStU6RxhBBW5iNehsEA2apxu2
         AovwZPGgdiCZ3bsbjOBDxqrvmXIkDufhj+FKmCUCeetNSivgFlxMLXOqQhdPMctg4QcO
         Mp8jXIENk603qG2SRhtzhbDdDiF3pB34LYSzkVfEwiip9Fq3tLOdpzwSfXKPrUp9MQG7
         qLyBtl9R15+wIDEB6qRu1Ye+CIO4GzCZJdtg/H4nDpNMneNfviDAEQmYV7EC6yw7VoDK
         +iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iQdTu56F5r7WdWwz31vdvw6jOLTuJOTfj1a8OxvFNMJK3T0R3Rn3kxM5K3UjmA47cxsMTMWfvzm7eH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFHgn+MB4FpLFO+7nsQ2lah8cr5F2SpvYZ9WEv88FAcH+pQ1J
	AAUqlzxF9p3eXKDuUvQt5UH/ZvxLMTTAjVHZglVpTOfevATSDO1B3Ej8JUS1oO8=
X-Gm-Gg: ASbGncuhXSvF6cKv+77doEU+3OA4N+BcvLvVBpNU1JZ1aIx2yDKx9b0ShaUkxSkCNh7
	OEs3HnPqWl/mDqo2RQhbgIplc+I5wA3dfO2YRb55S8ozGZg1T2f5nxraBU5+BNi6EzFqhg39Dhw
	KkwQmIzmAbQNajan8aug0u3IpcsUg1Mjo1XOJPKLxOV6n1/LfWzzOqodF57/cLBkSHXUea8S6xK
	Nd21M8mIMBrTjOhFtC5ETghXK2qfExqbua/1K3z7Zh+yhzxpLe29Z5b9IomlBRqC0jEv5YVoUV8
	HdpccqZ0
X-Google-Smtp-Source: AGHT+IGIek6OPyyjZZjrXkuvdN81VR6DHl8mzdwNbzCCYx8cbaECzDZswIN2k+lpO7iWi6HMxuv6jA==
X-Received: by 2002:a05:6402:360f:b0:5d3:bab1:513f with SMTP id 4fb4d7f45d1cf-5d3be6c4046mr19223495a12.18.1733850618930;
        Tue, 10 Dec 2024 09:10:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:18 -0800 (PST)
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
Subject: [PATCH v4 06/24] ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
Date: Tue, 10 Dec 2024 19:09:35 +0200
Message-Id: <20241210170953.2936724-7-claudiu.beznea.uj@bp.renesas.com>
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

The SSI_RATES macro covers 8KHz-48KHz audio frequencies. Update macro
comment to reflect it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 178c915331e9..35929160a8a5 100644
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


