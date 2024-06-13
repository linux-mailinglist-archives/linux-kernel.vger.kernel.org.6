Return-Path: <linux-kernel+bounces-212870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F5906766
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE462B21146
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D521411CD;
	Thu, 13 Jun 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5NKCP+l"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A013D8A6;
	Thu, 13 Jun 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268423; cv=none; b=W5K7eyepCLhw9X4NRBP7ZYR4nzSxUFXHvOHjRVYeV02vq5Aj7ILEeYQqvbt82wKSL5IoVzXJc5nm7M18T6WCsAkthRZzr5Y95k+7KZ1dEBVe6Qz6/zwKFMlQD+0BDlFWVgkF/w0EIl6bFONSFKb4atrEY2mfla5OO2ZEjeTD3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268423; c=relaxed/simple;
	bh=9PtQ8zM9C8kWoJ/j3aD7oi8Q4SAOvIat/GQcZAYBzWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEgDpWP8p9kSwk/o/LiejdLk8kKRBI5WF2SaLzQpSFVANFvg+q22zlEosxc9cCzuEGU/7zm97NUpcdfHO3/nTSRctHhz77qvb+0o/UfVzadmL0Jw8Up2upUmeAM8kTFOTITFucB0yCUdM7+EUvvNlS6E9NNP2rNRdGidPr09/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5NKCP+l; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so672007a12.2;
        Thu, 13 Jun 2024 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268420; x=1718873220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrljha2mkLWZllZM4qPDb9u5Vppz4LLT+JoE5p6lano=;
        b=I5NKCP+l5hW9yj7mOb0Ya0WSeQ0GPA8hHpEw2stanBt84ldmmOT38joeFn6WEA7JTW
         7xiODu7YccOZghKo7oeJtYwgYy6pu7GSMyKpArFybcMlqT6Rn+mAe61q3qJ3P3DAL6yJ
         68atTbnL3k7mCmyf+1wJyr6wdEe/oajsrbsSQ/ZYBpWgR0f51GsuiW1SinPV1xDuzaKf
         nKEPmZ8hYQpWCuFjzKLgayA+I+vBixQ+Vy5tCAB0EbhjZGq0KPf/ulfhLs/yTtQqCNci
         ssHYZKrMltBuC6/7GDU+KfY3Dzp0yOIYevex5uX+HV7x9QEWlkfrAl4jdUr8dP82weG7
         NnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268420; x=1718873220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrljha2mkLWZllZM4qPDb9u5Vppz4LLT+JoE5p6lano=;
        b=eJgIcz2L2sE3Lz//g4tObMXMGos3tcXQRDik/1Yv4qphrMeQc3XbV17xs+AyLVqJSd
         eB2+FX+FqeSBkonaLdmY+JK7drApVLe2drLSNV8BXPjbQhm7W6YScdr5qjZsQMQkRqIw
         g7ZO7mhYU0rSZXzUeY9Akr0Jw/73WRb46EVLJC8J+u6aosCGImcxjkXrn6xNAoJL+5q2
         Xlbb49UwLlafIaNnzLgk1BDkSQvYXxE+jTd+atWiARDP/dE8bIyYC7hyWheQiOwxIdvh
         h4azDHNYexAAeTyu7uQjMQpL9uikQW3S6/cdc5hjNZlaVepJMCHIFhFR4vq+ggtfiSrs
         +eOw==
X-Forwarded-Encrypted: i=1; AJvYcCUNlx08u/iYPdDGd5LdKCVZ7m966ZoWG3lXCEV+DgGzxRMi2YhNG95nnUJHflatAZcTlaryj+f1ORFCbinhLjm+Eb7RrAYcWIFAMg3/
X-Gm-Message-State: AOJu0YwZm2iNxxryslbDjH9f4wRESH2pMjXfavwgw3SMhcCjSb8CqM/6
	cukS+/KEkh/HpPc983c9ZA/Qjdyt6NXI2Bnjnx7U4GEBt0a3Jpz9
X-Google-Smtp-Source: AGHT+IFFzf8Xo+GvNocVfwURbaXw6j9mQa3VZgFp1TirAhgpggh4VF036LnafPgKJAK3xNbKpeF1Yg==
X-Received: by 2002:a17:906:d7a6:b0:a6f:5b5f:89a9 with SMTP id a640c23a62f3a-a6f5b5f8ba3mr36412766b.55.1718268420204;
        Thu, 13 Jun 2024 01:47:00 -0700 (PDT)
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2daasm48364266b.97.2024.06.13.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:46:58 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v2 1/3] ASoC: nau8822: move nau8822_set_dai_sysclk()
Date: Thu, 13 Jun 2024 10:46:50 +0200
Message-Id: <20240613084652.13113-2-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
References: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Next commit in series makes a change which calls nau8822_set_pll() from
nau8822_set_dai_sysclk(). Moving latter after the former would avoid a
forward declaration, and this is exactly what this change does.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 sound/soc/codecs/nau8822.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index e6909e64dfa3..a6741bda6a9e 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -612,20 +612,6 @@ static const struct snd_soc_dapm_route nau8822_dapm_routes[] = {
 	{"Right DAC", NULL, "Digital Loopback"},
 };
 
-static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
-				 unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = dai->component;
-	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
-
-	nau8822->div_id = clk_id;
-	nau8822->sysclk = freq;
-	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
-		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
-
-	return 0;
-}
-
 static int nau8822_calc_pll(unsigned int pll_in, unsigned int fs,
 				struct nau8822_pll *pll_param)
 {
@@ -782,6 +768,20 @@ static int nau8822_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	return 0;
 }
 
+static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+
+	nau8822->div_id = clk_id;
+	nau8822->sysclk = freq;
+	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
+		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
+
+	return 0;
+}
+
 static int nau8822_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
-- 
2.34.1


