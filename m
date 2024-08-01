Return-Path: <linux-kernel+bounces-271203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED1944AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBCC1F2425B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82F19538D;
	Thu,  1 Aug 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoced3zH"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E4189B90;
	Thu,  1 Aug 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514060; cv=none; b=WvS+oRVN+EAqUE90/RL1B53kLA5BRvuyhkNXVXS1OfiGtn3YcZEl7vyO9YWbHEZplh0q22H9bHpIEUsuYdcXt4434+ittRQc6XGTWBQosjXpjN+tf43geW6hyD6zbTJe1PjPJB6Cjc/vy3zfzAfKeAsiQE994DdBIT2ssfZuRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514060; c=relaxed/simple;
	bh=EinisjOjPV0e0yKSpJfC3ecduhzTRgqOVJizc0uDCLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jV2xEXh9zgkfns5wtYz040EPOW+PbElPR05uf5X5FRjZl2RBlrN3JjzN7ftG9/j2qu9mUQ3DywlSqKzX66ymYktY5w5las8BR1eb7caa46m9lQt8olqiwG4Qh74CGRlHa4+fYQsBjDjOf0RLqttwN6dp/nVZAVp3kwCOr8SQA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uoced3zH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso86657001fa.2;
        Thu, 01 Aug 2024 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722514056; x=1723118856; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWpJKDgAAIKrTcDAo93c65X2vfalBn4m5VoyMmFWUps=;
        b=Uoced3zHQpS2zoIsIcTTEhPMr0IebokTYlFBu7CjU4Dy04nAQJXMa4hy/FzEtpypfd
         3iJuhtPxgw6BObj0a2XexDv0ym9sOAL29BDDSyjNqlt76l8z6CIVes94ZrNEBz1+d1aO
         Ehqax6dT49gLBG/T3FSHwWyFizsxr+NG8Jle3o8lnvfxxr3kbLZKlkvyYDKoOXpPOVhD
         KTOAHEXkA2NTPbe49/MjNM1j9UZKY4hNRuOUJWC03JWIJqeU4EvwMqGIdnhU3nZgnX6e
         J6OtFJWak8UrrLYBL+RcndATEj+frrHGEbUWTS9nr4aC2Xs2CIJwN41YzcZzD3O8WgkE
         g4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514056; x=1723118856;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWpJKDgAAIKrTcDAo93c65X2vfalBn4m5VoyMmFWUps=;
        b=ktuvo4snbrle5BXpsR/L7TjGFacZPwcHIplt4Met370V375mJcFqAhVZgz9s4Eb1if
         70AuasUWN1/YuUjN9ATkv4P8R6kFkXzXSXiVu4gcfI2KCbR+pBQj0aUv78+O6skjJUPw
         4WOW3GF8G0mU8/Oi5S3Gs55q394agqMMHgJaJbnAr+Bwj59xFpEYp/SdqkzTTsjna+uw
         PdglPGB2F2j+bAYr8ePRER/tf2tsGtYDhxEbjUTTQUqwAdtjDOw770rr8c7IYLKhozZ2
         k9alVQlA8fR52XI/wc67P2rkWfAO5QyPAF1056D/pm3usIsWVSmnZ/ULICMmPVAaGOWV
         vSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpfzQqz1PUvSzeiNYMzkFWKE1jUd+EMTF426lmLaGndUlUR+9zGPJ/ahCLv3StxxG7yUNW4+6WnT0IvFNPGK+7fzGVf69Z2vJNwtCV
X-Gm-Message-State: AOJu0Yxc9dmBl59AHZSjqBObN8rRrMd71PJroluX0R6dneh6dAYvh95s
	50X4esYGVWokwFLdERLmRPgF1lY8y4RCen1idU/LHCKX62Ctmb+g
X-Google-Smtp-Source: AGHT+IFZNbzC+YgMBit6OkJtk5dwL+OfkqPRYepqPLnWQLve6sNGUlEaHfkxbiBTBghGKCIoMPkEbw==
X-Received: by 2002:a2e:7011:0:b0:2ef:18ae:5cc2 with SMTP id 38308e7fff4ca-2f15aac0e67mr168391fa.21.1722514055505;
        Thu, 01 Aug 2024 05:07:35 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d4fsm19471856f8f.86.2024.08.01.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:07:35 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 01 Aug 2024 14:07:19 +0200
Subject: [PATCH v2] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-asoc-fix-sun4i-i2s-v2-1-a8e4e9daa363@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHZ6q2YC/0XMQQ6DIBCF4auYWXcMIFrpqvdoukAcdRIRA7RpY
 rx7STddfsl7/wGJIlOCW3VApDcnDluBulTgFrvNhDwWgxJKi2sj0abgcOIPptemGVklNFaYcRi
 kbt0E5bhHKoNf9PEsnmLwmJdI9p9qlZFadG1fy16YrkOF3uZMwduYaV25uc/e8lq74OE8v0Law
 /CoAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Cl=C3=A9ment_P=C3=A9ron?= <peron.clem@gmail.com>, 
 Marcus Cooper <codekipper@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.0

This fixes the LRCLK polarity for sun8i-h3 and sun50i-h6 in i2s mode
which was wrongly inverted.

The LRCLK was being set in reversed logic compared to the DAI format:
inverted LRCLK for SND_SOC_DAIFMT_IB_NF and SND_SOC_DAIFMT_NB_NF; normal
LRCLK for SND_SOC_DAIFMT_IB_IF and SND_SOC_DAIFMT_NB_IF. Such reversed
logic applies properly for DSP_A, DSP_B, LEFT_J and RIGHT_J modes but
not for I2S mode, for which the LRCLK signal results reversed to what
expected on the bus. The issue is due to a misinterpretation of the
LRCLK polarity bit of the H3 and H6 i2s controllers. Such bit in this
case does not mean "0 => normal" or "1 => inverted" according to the
expected bus operation, but it means "0 => frame starts on low edge" and
"1 => frame starts on high edge" (from the User Manuals).

This commit fixes the LRCLK polarity by setting the LRCLK polarity bit
according to the selected bus mode and renames the LRCLK polarity bit
definition to avoid further confusion.

Fixes: dd657eae8164 ("ASoC: sun4i-i2s: Fix the LRCK polarity")
Fixes: 73adf87b7a58 ("ASoC: sun4i-i2s: Add support for H6 I2S")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Note that this fix applies for all the i2s controllers compatible with
sun8i-h3-i2s and sun50i-h6-i2s.

The issue had likely been introduced in commit dd657eae8164 ("ASoC:
sun4i-i2s: Fix the LRCK polarity") due to a misinterpreted bit from the
H3 Datasheet (see link below). Then also introduced for the H6 SoC in
commit 73adf87b7a58 ("ASoC: sun4i-i2s: Add support for H6 I2S").

Datasheets:
- H3: https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
  section 8.6.7.2
- H6: https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf
  section 7.2.5.2
- A64: https://linux-sunxi.org/images/b/b4/Allwinner_A64_User_Manual_V1.1.pdf
  section 7.6.7.2

Tests:
- Tested capture and playback in all supported formats (I2S, LEFT_J,
  RIGHT_J, DSP_A and DSP_B) in both normal and frame-inverted mode.
- Test setup: SoC DAI as master, ES8311 codec as slave. Bus monitored
  using a logic analyzer.
- Tested on A64 SoC (Pine64 board).
- Tested on H3 SoC (NanoPi Neo Air board).
- Not tested on H6 SoC.
---
Changes in v2:
- Fix LRCLK inversion mask: used BCLK mask by mistake in previous
  version
- Re-add clock word in DAI polarity comment
- Update patch description with a note about recent tests and datasheets
- Remove separate cover letter
- Rebase on top of asoc/for-next
- Link to v1: https://lore.kernel.org/all/20240529140658.180966-2-matteomartelli3@gmail.com
---
 sound/soc/sunxi/sun4i-i2s.c | 143 ++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 5f8d979585b6..3af0b2aab291 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -100,8 +100,8 @@
 #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
 
 #define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH	(1 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW		(0 << 19)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
@@ -729,65 +729,37 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -805,6 +777,35 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -836,65 +837,37 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				     unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -912,6 +885,36 @@ static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:

---
base-commit: ead2709553e9182c196c232100058ac008981cf1
change-id: 20240731-asoc-fix-sun4i-i2s-9a09dbb145cf

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


