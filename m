Return-Path: <linux-kernel+bounces-178809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749698C57F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0515A1F24A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF9158D80;
	Tue, 14 May 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hWM//Mpa"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDC158A01
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697090; cv=none; b=XCORud9hznbtRRJhsWyCKUChUIEDn7bAegKBJDvF27S5t5HTSHFzX1noe2wFD3qHskytI0+TUG6pU4gpK7R+iVUOgC+Qz9HyYpR8+voP05u0lLm3rCxymeTwIY/30ql0jaROPYRsyu+AWKbcA6Y6bOoZZmr+SuPbUWVaMZg/2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697090; c=relaxed/simple;
	bh=DxlEqtVTRXFReuQuvLxn/d2cy0K8/Bkbm/OiSCg4Hc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1p5U0WtOk3n6knhmrfzzn1zovoaiu5Pz4eY4wrACQa7gcCZr6C2aOj7Ktwfmrd7EMQuSSp2Ricdu3i4syeey0LL99Soo4yIbYFjOEee4Ot3e4/nbQKiYD+T7mba+8kDo0xYztCPqQhYErVUC1YKogUgWraOi8rSbQleN/GXEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hWM//Mpa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so3978983f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715697086; x=1716301886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln4czWjw11QmRtGLij7AUk0r+XUH7GvNjZu/Euwwgag=;
        b=hWM//Mpau4m8Yz1o7+7aF1/2p5TPzek5rHFRxFmsv5WaO3XVYbeqP9rUlxCQ70kwam
         yUKLRofi9KBARSkLnwEwzmySNSivqBDoocfe6zYDPGRVGE8XC8fMiydNOyCBOqSdkmg5
         CERuKR37UR0RPAHmqWuNyryGSOJA1VgbqI/uWxGKmz+SzE0pxCgTgC4SI1nGSMquwVBx
         bDCxrfUrlXagTlmBdYHn8fo1+ISfGMbfDY2xYbYijF1cgBpEBvaTCwsOb4bfPxQLznxX
         kSJqe45FX9RHhcH0t5rqIKi0+y6rild8LWDJg0l2zQttzshBwieApguq714m9zCVq4Bi
         G80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697086; x=1716301886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln4czWjw11QmRtGLij7AUk0r+XUH7GvNjZu/Euwwgag=;
        b=AGZBtTpK2VulO5TJuZ09RE3+VcHsmIr93PDA7fHnXEN9pYyCYiJIN0egdrBbq65q5q
         4qIobArm8q5qL9yMcUKrn/QKfzZL+OoPlUABPv5LefFkpFKt9+Zb3nGSiztJGudsp/0i
         J51wL83kfftA9sV8Iz11vp2cdbF9cFIU4m67xU5pHNZEh7WGvY9E5phOQ2yiiSk+Kfp5
         GF2ngFxJNhGgF4qcWHtJ7uXlbNGT9lyECyoVHatsFiu+3lkcXrGAr/L8mt9PfndMJ76k
         ONn1fvU0MrmmoTNQI4xjlQoBEJh2F0sMpmPZMop6XUXXTW2OrrskIq0b4myPG7LYGvWI
         7Urg==
X-Forwarded-Encrypted: i=1; AJvYcCUerkOw+jIH7vH4wS3afz0Sieu73tAE8aFOlsdLrGD/qSyFKrNOQKpfIx86LW0yDRfZ5MBUI8fd4azu+OWtbOa7Zc1HG97mROJ3IBn1
X-Gm-Message-State: AOJu0Yy5STIR67jN71ickP5L4MGVttJAC4uebHFSkNtxBz9Yi8UftIW3
	OqD9OdUfC3DmGFCRfZDMm5KZSfrStE3kNKpsBAFVfQ+8jac1A1WY3j0bqmxmuss=
X-Google-Smtp-Source: AGHT+IEMwg+hLrvXY8E1TdPRRYJF6yX+6J61OrtJvgZefi9YUEoDxzUYDJl8/OrpwBDQbxRW36oP3g==
X-Received: by 2002:adf:fa0f:0:b0:34d:1b8c:1afb with SMTP id ffacd0b85a97d-3504a736b48mr7803454f8f.24.1715697086450;
        Tue, 14 May 2024 07:31:26 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:3f47:f219:de13:38a7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-351cb0fb6b4sm627163f8f.24.2024.05.14.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:31:26 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH RFC] ASoC: amlogic: do not use dpcm_playback/capture flags
Date: Tue, 14 May 2024 16:30:46 +0200
Message-ID: <20240514143116.3824376-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87o79azh65.wl-kuninori.morimoto.gx@renesas.com>
References: <87o79azh65.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

dpcm_playback/capture flags are being deprecated in ASoC.
Use playback/capture_only flags instead

Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Following Kuninori's series, dpcm_playback/capture will be ignored.
However, properly disabling stream direction is important for Amlogic
audio drivers.

I'm not too sure how this should be applied to avoid breaking bisect,
before or after Kuninori's series. Maybe it should be merged into it ?

Any suggestion Kuninori ?

 sound/soc/meson/axg-card.c         | 10 +++++-----
 sound/soc/meson/meson-card-utils.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 09aa36e94c85..646ab87afac2 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -132,7 +132,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	lb->stream_name = lb->name;
 	lb->cpus->of_node = pad->cpus->of_node;
 	lb->cpus->dai_name = "TDM Loopback";
-	lb->dpcm_capture = 1;
+	lb->capture_only = 1;
 	lb->no_pcm = 1;
 	lb->ops = &axg_card_tdm_be_ops;
 	lb->init = axg_card_tdm_dai_lb_init;
@@ -176,7 +176,7 @@ static int axg_card_parse_cpu_tdm_slots(struct snd_soc_card *card,
 
 	/* Disable playback is the interface has no tx slots */
 	if (!tx)
-		link->dpcm_playback = 0;
+		link->capture_only = 1;
 
 	for (i = 0, rx = 0; i < AXG_TDM_NUM_LANES; i++) {
 		snprintf(propname, 32, "dai-tdm-slot-rx-mask-%d", i);
@@ -186,9 +186,9 @@ static int axg_card_parse_cpu_tdm_slots(struct snd_soc_card *card,
 
 	/* Disable capture is the interface has no rx slots */
 	if (!rx)
-		link->dpcm_capture = 0;
+		link->playback_only = 1;
 
-	/* ... but the interface should at least have one of them */
+	/* ... but the interface should at least have one direction */
 	if (!tx && !rx) {
 		dev_err(card->dev, "tdm link has no cpu slots\n");
 		return -EINVAL;
@@ -275,7 +275,7 @@ static int axg_card_parse_tdm(struct snd_soc_card *card,
 		return ret;
 
 	/* Add loopback if the pad dai has playback */
-	if (link->dpcm_playback) {
+	if (!link->capture_only) {
 		ret = axg_card_add_tdm_loopback(card, index);
 		if (ret)
 			return ret;
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index ed6c7e2f609c..1a4ef124e4e2 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -186,9 +186,9 @@ int meson_card_set_fe_link(struct snd_soc_card *card,
 	link->dpcm_merged_rate = 1;
 
 	if (is_playback)
-		link->dpcm_playback = 1;
+		link->playback_only = 1;
 	else
-		link->dpcm_capture = 1;
+		link->capture_only = 1;
 
 	return meson_card_set_link_name(card, link, node, "fe");
 }
-- 
2.43.0


