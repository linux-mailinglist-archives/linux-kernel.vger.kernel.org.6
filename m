Return-Path: <linux-kernel+bounces-367857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE29A07A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81461C27116
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D42076A6;
	Wed, 16 Oct 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtEQm8JZ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9D2071EF;
	Wed, 16 Oct 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075345; cv=none; b=ftHJVp/wrGB5eit0FIYosJQAahhvvb5jcO2wAetf/lthBkm7zWQwgospj7/0JQk/9J5pfSYuaIq3pI9BCIlgi8m/YQy7ZLkQ8g3lmY2ZMLBAnTg/vlz6bWp6+SGP+mNStSiT1Qm6yO4wjampV/sMM/eXw/vCc6H42UVhReQgWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075345; c=relaxed/simple;
	bh=DxM55qAuJVLJ56rkaMYQvYFQ1y/6QKJEizLQtDgKJD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmXo7QLNYxbbP4r/MWzi6F5OW53vgbrlJm7JbGeL4u2ia1J+yjsL9U3TIV0lJ2TiDkDpeSq+ZdCt3vA61ttxoe4jV2KOxzV6M7ucYtwh9SapvYSPedSBFZLn0hM7MpaBruYpxwFzf4fUAjoa3LNsmqeUFY5wFeP5Liu06zs91JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtEQm8JZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso46705995ad.2;
        Wed, 16 Oct 2024 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729075343; x=1729680143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWFXTKeTH7RgE3F6l0NRgDfeJ3cSqKL3g04gUQ1u1OQ=;
        b=ZtEQm8JZ1yhr7QyfOsnDEaI8Acbbhe09DiSJIgrMbUJQkQQ3hccwwTvh85WboVXgkl
         kieQH2vR41Oy3Gwi1PcZjTL3reyieK7Mdn22vhQP3VFa1/DzXDVyiNPwQoy+Znj+nxQR
         +jicgDjjP63MJBw02yniw86tGHyD2s0W1YxfIQKJHjGKC5ckkjbJLMEFYlwq9tDKk1iG
         nmerMSeqQUBrSUZGs91ogIszm376bBjXDneMSFcKV9nNn6ulsH3bOPokogu2XCNZ3nU5
         UGLk2v+o1w/wPexTQ3c/hWGhiH9qtuAbQf13pm9LI1zY0qqQBDJfHnJaAkSUMcAReFKr
         whOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075343; x=1729680143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWFXTKeTH7RgE3F6l0NRgDfeJ3cSqKL3g04gUQ1u1OQ=;
        b=uMY8lnMasVDu4e68uBaGoKzFrlX2F9XuYZHpWV9WDcB/kd7cd7AbkQR6ExweoDtch4
         DJC8gGhPZy6NeYvrcC53nauWi1Q9Ck3sm6MYpPvN4fN4V3l5GAcFngf8w+9ON/mWqdOC
         IbQ862tYuEu7UcdsO+Z0oBTb7oUK7LtcndHP2cyjHRJ1Q7mTAuvwK1PlQXrxkh955J05
         iU87DLKDwboHTcf+RKu1/6fL8TY39Du/tJHb9kQb2rLiMqBL7MOBj8LHX/knmr3l4k7D
         gPCzgTk2JM/kORX826JjIHkCR5K7YZjqVjZAJnNcNA9RDPOIfFUzN2ve/bLKGIbes9X0
         l1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZtQc9INAZY7BUBcg9mJ582eU7kY91/mHYRP/cXEUqAqpodAfE+wyj4RWAJsXigF9t+jbylUhZm3Cxcffq@vger.kernel.org, AJvYcCUbrIpJzXhhfGk7ElLbP7pboX9v9BMrMI1lQWvMpEpccvkhef1Y9Ok2+C7Ibw71Qv/i46GD0me5FcQQ@vger.kernel.org, AJvYcCVu9ORWqs75Q//51GWqIwfqz/zvfC5XBgNP6qYTVv8+dbsg0MZoSu86YcXLgzx0IBazJqDlfZ+oIiTjymg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QNTGgsoV2ZeuikfILKXdg2dUH4ktDVPy6YAh2wPNDLCgFAgh
	LMRrFeJtF1fNpQ1pHNhhvugebOF52iAHpi1zFTPWj6WqSnsrsOpC
X-Google-Smtp-Source: AGHT+IErQ5tKfU2htn0tUHC4Jifcww5wToA5v9tphD4rJTGKDd2vhRKlq2gdzwjSgsuFu3IAYiWVwQ==
X-Received: by 2002:a17:902:ecc6:b0:20c:83e7:ca51 with SMTP id d9443c01a7336-20d27ebb734mr49525465ad.26.1729075343000;
        Wed, 16 Oct 2024 03:42:23 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm26319645ad.182.2024.10.16.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:42:22 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 16 Oct 2024 20:41:02 +1000
Subject: [PATCH 3/3] ASoC: cs42l84: leverage ring sense IRQs to correctly
 detect headsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-cs42l84-v1-3-8d7e9d437d2d@gmail.com>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
In-Reply-To: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6541;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=DxM55qAuJVLJ56rkaMYQvYFQ1y/6QKJEizLQtDgKJD4=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOn8M8p5mVrvF13uP7/18rSq945H9WuPBJe78ntu1hU6n
 nKk5JJRRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABM59IGR4elBdyW/l3EymZee
 u5wWiG2tPjmB+aqW587Ojl5miZvc4owMu/qkNJ/lt3V/v3zo++8HmyyWt3Q7TGl4J/F8r4XLfFd
 /JgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Some jacks integrated on devices with this codec, such as certain
Apple Silicon Macs, have quite trigger-happy tip sense switches that
cause a tip sense IRQ before the plug is fully seated. If users are
unfortunate with their timing, this can lead to headsets being detected
as mic-less headphones among other issues with the codec's device
detection routines.

Introduce some rudimentary ring sense interrupt handling so that we
can re-trigger the codec's detection routines when we are certain
that the plug is fully seated.

This seems to differ from what other Cirrus drivers do, but is
necessary for devices to be reliably detected properly here.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/cs42l84.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
index dbbc76f41ccb958b068848426d1891b16aa84866..8711968a38e24de221e32066739cc4d60964fdef 100644
--- a/sound/soc/codecs/cs42l84.c
+++ b/sound/soc/codecs/cs42l84.c
@@ -44,7 +44,8 @@ struct cs42l84_private {
 	struct gpio_desc *reset_gpio;
 	struct snd_soc_jack *jack;
 	struct mutex irq_lock;
-	u8 plug_state;
+	u8 tip_state;
+	u8 ring_state;
 	int pll_config;
 	int bclk;
 	u8 pll_mclk_f;
@@ -797,13 +798,23 @@ static void cs42l84_revert_hs(struct cs42l84_private *cs42l84)
 		FIELD_PREP(CS42L84_HS_DET_CTL2_SET, 2));
 }
 
+static void cs42l84_set_interrupt_masks(struct cs42l84_private *cs42l84,
+					unsigned int val)
+{
+	regmap_update_bits(cs42l84->regmap, CS42L84_TSRS_PLUG_INT_MASK,
+			CS42L84_RS_PLUG | CS42L84_RS_UNPLUG |
+			CS42L84_TS_PLUG | CS42L84_TS_UNPLUG,
+			val);
+}
+
 static irqreturn_t cs42l84_irq_thread(int irq, void *data)
 {
 	struct cs42l84_private *cs42l84 = (struct cs42l84_private *)data;
 	unsigned int stickies[1];
 	unsigned int masks[1];
 	unsigned int reg;
-	u8 current_plug_status;
+	u8 current_tip_state;
+	u8 current_ring_state;
 	int i;
 
 	mutex_lock(&cs42l84->irq_lock);
@@ -817,16 +828,24 @@ static irqreturn_t cs42l84_irq_thread(int irq, void *data)
 				irq_params_table[i].mask;
 	}
 
+	/* When handling plug sene IRQs, we only care about EITHER tip OR ring.
+	 * Ring is useless on remove, and is only useful on insert for
+	 * detecting if the plug state has changed AFTER we have handled the
+	 * tip sense IRQ, e.g. if the plug was not fully seated within the tip
+	 * sense debounce time.
+	 */
+
 	if ((~masks[0]) & irq_params_table[0].mask) {
 		regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
-		current_plug_status = (((char) reg) &
+
+		current_tip_state = (((char) reg) &
 		      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
 		      CS42L84_TS_PLUG_SHIFT;
 
-		switch (current_plug_status) {
-		case CS42L84_PLUG:
-			if (cs42l84->plug_state != CS42L84_PLUG) {
-				cs42l84->plug_state = CS42L84_PLUG;
+		if (current_tip_state != cs42l84->tip_state) {
+			cs42l84->tip_state = current_tip_state;
+			switch (current_tip_state) {
+			case CS42L84_PLUG:
 				dev_dbg(cs42l84->dev, "Plug event\n");
 
 				cs42l84_detect_hs(cs42l84);
@@ -839,47 +858,57 @@ static irqreturn_t cs42l84_irq_thread(int irq, void *data)
 				 * was disconnected at any point during the detection procedure.
 				 */
 				regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
-				current_plug_status = (((char) reg) &
+				current_tip_state = (((char) reg) &
 				      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
 				      CS42L84_TS_PLUG_SHIFT;
-				if (current_plug_status != CS42L84_PLUG) {
+				if (current_tip_state != CS42L84_PLUG) {
 					dev_dbg(cs42l84->dev, "Wobbly connection, detection invalidated\n");
-					cs42l84->plug_state = CS42L84_UNPLUG;
+					cs42l84->tip_state = CS42L84_UNPLUG;
 					cs42l84_revert_hs(cs42l84);
 				}
-			}
-			break;
 
-		case CS42L84_UNPLUG:
-			if (cs42l84->plug_state != CS42L84_UNPLUG) {
-				cs42l84->plug_state = CS42L84_UNPLUG;
+				/* Unmask ring sense interrupts */
+				cs42l84_set_interrupt_masks(cs42l84, 0);
+				break;
+			case CS42L84_UNPLUG:
+				cs42l84->ring_state = CS42L84_UNPLUG;
 				dev_dbg(cs42l84->dev, "Unplug event\n");
 
 				cs42l84_revert_hs(cs42l84);
 				cs42l84->hs_type = 0;
 				snd_soc_jack_report(cs42l84->jack, 0,
 						    SND_JACK_HEADSET);
+
+				/* Mask ring sense interrupts */
+				cs42l84_set_interrupt_masks(cs42l84,
+							    CS42L84_RS_PLUG | CS42L84_RS_UNPLUG);
+				break;
+			default:
+				cs42l84->ring_state = CS42L84_TRANS;
 			}
-			break;
 
-		default:
-			if (cs42l84->plug_state != CS42L84_TRANS)
-				cs42l84->plug_state = CS42L84_TRANS;
+			mutex_unlock(&cs42l84->irq_lock);
+
+			return IRQ_HANDLED;
+		}
+
+		/* Tip state didn't change, we must've got a ring sense IRQ */
+		current_ring_state = (((char) reg) &
+		      (CS42L84_RS_PLUG | CS42L84_RS_UNPLUG)) >>
+		      CS42L84_RS_PLUG_SHIFT;
+
+		if (current_ring_state != cs42l84->ring_state) {
+			cs42l84->ring_state = current_ring_state;
+			if (current_ring_state == CS42L84_PLUG)
+				cs42l84_detect_hs(cs42l84);
 		}
 	}
+
 	mutex_unlock(&cs42l84->irq_lock);
 
 	return IRQ_HANDLED;
 }
 
-static void cs42l84_set_interrupt_masks(struct cs42l84_private *cs42l84)
-{
-	regmap_update_bits(cs42l84->regmap, CS42L84_TSRS_PLUG_INT_MASK,
-			CS42L84_RS_PLUG | CS42L84_RS_UNPLUG |
-			CS42L84_TS_PLUG | CS42L84_TS_UNPLUG,
-			CS42L84_RS_PLUG | CS42L84_RS_UNPLUG);
-}
-
 static void cs42l84_setup_plug_detect(struct cs42l84_private *cs42l84)
 {
 	unsigned int reg;
@@ -909,7 +938,7 @@ static void cs42l84_setup_plug_detect(struct cs42l84_private *cs42l84)
 
 	/* Save the initial status of the tip sense */
 	regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
-	cs42l84->plug_state = (((char) reg) &
+	cs42l84->tip_state = (((char) reg) &
 		      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
 		      CS42L84_TS_PLUG_SHIFT;
 
@@ -1016,8 +1045,8 @@ static int cs42l84_i2c_probe(struct i2c_client *i2c_client)
 	/* Setup plug detection */
 	cs42l84_setup_plug_detect(cs42l84);
 
-	/* Mask/Unmask Interrupts */
-	cs42l84_set_interrupt_masks(cs42l84);
+	/* Mask ring sense interrupts */
+	cs42l84_set_interrupt_masks(cs42l84, CS42L84_RS_PLUG | CS42L84_RS_UNPLUG);
 
 	/* Register codec for machine driver */
 	ret = devm_snd_soc_register_component(&i2c_client->dev,

-- 
2.47.0


