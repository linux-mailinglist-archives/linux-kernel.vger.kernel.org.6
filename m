Return-Path: <linux-kernel+bounces-440026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26E9EB7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38653163DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248313DAC11;
	Tue, 10 Dec 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="R0QKl8lt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7D23A59C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850629; cv=none; b=VxPU01oSYWEvxfqNZPfnMTA4m4c1QXAZ+O8hh7NiXQbU18u+7u4NdtHBNKHgB3io9eX9SSiN9LV6x33fzZ3tLtaF12LzTJxFdDQ8RtdUkWBfAb8a+4ZAZ8zvjPKlrnh71xI5Qp4sgy60wun33rN1lKtYP/rG+GllQhgyyAgcCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850629; c=relaxed/simple;
	bh=ujffKmfqqDwP9nSS/Rh8QsJL6MbeKN+Qqc+lwPTDO6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Su1Unjp1oFxSR8zG85S/KbSV+zkGbeChRM8zaDMGzIjxRQbJTZVHN+1e2vnUrcnKRGNS2L1hSY1+/irn/rydCL8uykG4ypV9ED+hn405LPwo5FUrlcEIjoKHSFhxMOVs3D24MFpQHZGrRL10Clis8/uPkUAgaoD5dHkMXY9YfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=R0QKl8lt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so5213987a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850626; x=1734455426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt6/CuLO4TNfbHvjGkE7QWPE5biRbMT4tQY2cpGkikU=;
        b=R0QKl8ltpkWoHydIefVc0xQrvPiLvplUyTjqzT6eHRvjJgdOVWa7o1ljB35cZVL3cd
         /NQI5szGDpJFyZlfoB1gawjPP0g8QUKO4DhZGoEM8GSqS88YT2ZgZ17TzWofc0EzxTOC
         TRSmQJfu0+JVzRqM+B6TUF5trZYIjjvnOl70wC4vDMO0gMcDFgB4j+hxE246F5nKqLmu
         kfoZBoL8BgkErwniYfqW8dajUAYq8FDikk5QWw9Tmb9JYf1Jp3ukkxZA7dVvq5vVnOOy
         Is8T+LIE5dV8rUZ/KlSZ7p7EZR/bZ3+Efq1njQqwVnAQ2Py8btOxhsngdgvTBhE+cXws
         Yr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850626; x=1734455426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt6/CuLO4TNfbHvjGkE7QWPE5biRbMT4tQY2cpGkikU=;
        b=pY2M38Q2NE2k0v3eGbwbUGWe7PdCjI1Blt4R8pNHuqn07ZcicJoll9RlohnSdYY68R
         gMFWQEs9pJig3u+uRuhLlzX4ZrLSKSLtevxVmzOTGRKMjIFRGFGM55s6gZDwidPm9kLO
         WCawoUtGxkV/XgVP90PBnjeT8jgtJZQMYs4+bXocdTIqTejIY/qj5CgNA3txCCoFNCgE
         FVciK68FP2s69O9+aGgvtJs58N6vDNlTuMKQmZdyOw0MCD2KmOv8fF+tTNlEqbk7X+Em
         yN6PInPZ1Rmu1p5PPgHMXCH/tNEbii2Tt/v6kNsiQs6NzK3K0lzs/oArN5DebM+VXPj9
         lzKg==
X-Forwarded-Encrypted: i=1; AJvYcCXCAxqul2HG+h2TV8vL+6r4FLrLt6hS3rahbjx3UZBO6bdx0WZ2UbQqdeMh1T1cegPdMHjQrREm55br6KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDflfd9d8txdRMsq3+EYMyiASUOEqRwyQM3OEZ8K/9eJ0MdA5w
	YqiypfJ1tNFf4Irj4CMEwfuG3KpJASCySZzUlfsRwZjGKWwEhRmEtjc2Mgl8P5o=
X-Gm-Gg: ASbGnct2FC4iazTXD4VTQUZIVl6oR9V2fbjadezI6HvciUtfC8pdMKMsrtKGJuRiR6Z
	D73JnHMCGDhlOMuvPUPJN5vPGVstHpepW94wT6Il1hdMHY4owf1TP6b4b825QFpsZ0YOZ6D1UOr
	gIdxw/2wjCpZVAwX6V0NtJ9xny0K9AXZ7zTPmeBvdozfvVA+P1Rtea+6FkFjky09UJl04+WRlUS
	AaD6aqsdR4o/lZBD7qylrh/B5gFipZxrxW4XhU8yd8DyUmC8NAKQhoN41Xp9xBbrv7eVNE1jIWY
	ygHo9ce+
X-Google-Smtp-Source: AGHT+IFnf0CQr0jkK6OJUnuRd7yMlMyY8yimkX0n0o6RyaHOTAp9AyL9lRgA8mS0FG7jjIMo1TvGpQ==
X-Received: by 2002:a05:6402:2813:b0:5d3:d4cf:feb5 with SMTP id 4fb4d7f45d1cf-5d3d4d00325mr14392707a12.29.1733850625802;
        Tue, 10 Dec 2024 09:10:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:25 -0800 (PST)
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
Subject: [PATCH v4 09/24] ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_play()
Date: Tue, 10 Dec 2024 19:09:38 +0200
Message-Id: <20241210170953.2936724-10-claudiu.beznea.uj@bp.renesas.com>
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

The first argument of the rz_ssi_stream_is_play() is not used. Remove it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- fixed typos in patch title and description
- collected tags

 sound/soc/renesas/rz-ssi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index e2e172d8e9db..1a98f6b3e6a7 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -162,8 +162,7 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 	writel(val, (priv->base + reg));
 }
 
-static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
-					 struct snd_pcm_substream *substream)
+static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substream)
 {
 	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 }
@@ -337,7 +336,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	bool is_play = rz_ssi_stream_is_play(ssi, strm->substream);
+	bool is_play = rz_ssi_stream_is_play(strm->substream);
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
@@ -674,7 +673,7 @@ static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
 		 */
 		return 0;
 
-	dir = rz_ssi_stream_is_play(ssi, substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dir = rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	/* Always transfer 1 period */
 	amount = runtime->period_size;
@@ -800,7 +799,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ssi->dma_rt) {
 			bool is_playback;
 
-			is_playback = rz_ssi_stream_is_play(ssi, substream);
+			is_playback = rz_ssi_stream_is_play(substream);
 			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
 						      is_playback);
 			/* Fallback to pio */
-- 
2.39.2


