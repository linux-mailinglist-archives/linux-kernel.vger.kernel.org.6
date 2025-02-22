Return-Path: <linux-kernel+bounces-527458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4AA40B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15EF176B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993A202C2A;
	Sat, 22 Feb 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ESwFJlcP"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A1145B16;
	Sat, 22 Feb 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740253234; cv=pass; b=H0EbW+viqApwEk/Mdqx3Uh0W4Vsukr8LK8JgcFMhCXM35OPPP5boOkBGSDpJ1SXuHtVfztjp4av+b6gQ67q4YHpznwXZ0n2ap0OpONtyA/UkQJwy/9hxcR8k0P7REohKFDo6/uFFRtfo+eKSLKgLwphq8E8RZjHedx+2PfIAHc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740253234; c=relaxed/simple;
	bh=W6mUPuXHEaLn50tK+gfcBT0rcpWaJhQUu4tC4s0k9AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HseojT24RgLIyx6UKKZ/tkU1oQpYA5u3ALqTHnW44gUz24HuLkMY5eT1/UCv4n3sKN7mAeV7wuT81tUgf2UL9MEz6mQTOHDuy12AYkEFO2OdZJaaXTtsuBMN6PfxebTMNP5a/7uENVCjNkUnuX6sghSioDFrfQd55bKL7UI+khA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ESwFJlcP; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740253208; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cFnaziYWq8fuZZEXH1iBEDweFg5S6T67NZoO81cinSccE64MTJBbctAyb8bnPLklT/eRdZlAOSRyj7aCM6TU2O0bluoE5etkMyZdybhL8vC4Vx5rb/ShV9OPg7X6ibnj+f+Hqkp1ICGvH2/jOWTacu6WJq3/dg4ClUSElBr9+Ws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740253208; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Q5/IToFSpLyjKOQVtxgtX4PEL1BIaHLOTx1ZNWW4Gk=; 
	b=G18wN3hUGXgh9LTKrulbMNWB7jXwheceVc+DSfyqpKoweDiBnLJr3LsdejfUYwLHRHtyZkfwktm15BKB5ecO8N2kgrExIr6sK5d5e5pJDLEHoqecw7pY/lsD3RQS4yBMK8m8MSV7DSjkFP9PTEIQtmzDGkK6S0sk09LW9MocK5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740253208;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=9Q5/IToFSpLyjKOQVtxgtX4PEL1BIaHLOTx1ZNWW4Gk=;
	b=ESwFJlcPlHbE5YWxrX9bfBGcQnc++mRPdz2TCEoLy79MKxLrJH8D+9cBJYoHPacO
	Ew1odUZ2cBVKLDBX77pa4qhtMCKsyTmrEvEnTrS5nXvzyAWbCExOBfvUAcYTOSMJuUJ
	kl8Ypfr5AQh1FCTI0TQap8+91G/oBwO98B6xjKIM=
Received: by mx.zohomail.com with SMTPS id 1740253204933761.5026406092906;
	Sat, 22 Feb 2025 11:40:04 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 22 Feb 2025 20:39:57 +0100
Subject: [PATCH] ASoC: es8328: fix route from DAC to output
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-es8328-route-bludgeoning-v1-1-99bfb7fb22d9@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAwoumcC/x2MQQqAIBAAvxJ7bsG2Ausr0SFzs4XQ0Iog+nvSc
 WBmHkgchRP0xQORL0kSfIaqLGBeJ+8YxWYGUtQqIkJOuiaNMZwHo9lO6zh48Q6VafRsyHZZg5z
 vkRe5//Uwvu8HX8cqHWoAAAA=
X-Change-ID: 20250222-es8328-route-bludgeoning-0b48cb2d9022
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sean Cross <xobs@kosagi.com>
Cc: kernel@collabora.com, Mark Brown <broonie@linaro.org>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The ES8328 codec driver, which is also used for the ES8388 chip that
appears to have an identical register map, claims that the output can
either take the route from DAC->Mixer->Output or through DAC->Output
directly. To the best of what I could find, this is not true, and
creates problems.

Without DACCONTROL17 bit index 7 set for the left channel, as well as
DACCONTROL20 bit index 7 set for the right channel, I cannot get any
analog audio out on Left Out 2 and Right Out 2 respectively, despite the
DAPM routes claiming that this should be possible. Furthermore, the same
is the case for Left Out 1 and Right Out 1, showing that those two don't
have a direct route from DAC to output bypassing the mixer either.

Those control bits toggle whether the DACs are fed (stale bread?) into
their respective mixers. If one "unmutes" the mixer controls in
alsamixer, then sure, the audio output works, but if it doesn't work
without the mixer being fed the DAC input then evidently it's not a
direct output from the DAC.

ES8328/ES8388 are seemingly not alone in this. ES8323, which uses a
separate driver for what appears to be a very similar register map,
simply flips those two bits on in its probe function, and then pretends
there is no power management whatsoever for the individual controls.
Fair enough.

My theory as to why nobody has noticed this up to this point is that
everyone just assumes it's their fault when they had to unmute an
additional control in ALSA.

Fix this in the es8328 driver by removing the erroneous direct route,
then get rid of the playback switch controls and have those bits tied to
the mixer's widget instead, which until now had no register to play
with.

Fixes: 567e4f98922c ("ASoC: add es8328 codec driver")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
I've tested this patch on an ArmSoM Sige5 board, with an ongoing port of
its CPU-side SAI driver. While there are some other factors that lead to
me being puzzled, a good day or so was lost to the DAPM graph not making
any sense. The board uses an ES8388, which appears to be the only
ES8328-like on the market at the moment, so I couldn't test it with the
actual ES8328. However, their register listings from their datasheets
look the same, so I'd be surprised if they differed in this regard.
---
 sound/soc/codecs/es8328.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index f3c97da798dc8e4af72a90588a7f7995fd2e11e4..76159c45e6b52e71925bac4913b1d4da8d9127a3 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -233,7 +233,6 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
 	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
@@ -243,7 +242,6 @@ static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
@@ -336,10 +334,10 @@ static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8328_DACPOWER,
 			ES8328_DACPOWER_LDAC_OFF, 1),
 
-	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Left Mixer", ES8328_DACCONTROL17, 7, 0,
 		&es8328_left_mixer_controls[0],
 		ARRAY_SIZE(es8328_left_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Right Mixer", ES8328_DACCONTROL20, 7, 0,
 		&es8328_right_mixer_controls[0],
 		ARRAY_SIZE(es8328_right_mixer_controls)),
 
@@ -418,19 +416,14 @@ static const struct snd_soc_dapm_route es8328_dapm_routes[] = {
 	{ "Right Line Mux", "PGA", "Right PGA Mux" },
 	{ "Right Line Mux", "Differential", "Differential Mux" },
 
-	{ "Left Out 1", NULL, "Left DAC" },
-	{ "Right Out 1", NULL, "Right DAC" },
-	{ "Left Out 2", NULL, "Left DAC" },
-	{ "Right Out 2", NULL, "Right DAC" },
-
-	{ "Left Mixer", "Playback Switch", "Left DAC" },
+	{ "Left Mixer", NULL, "Left DAC" },
 	{ "Left Mixer", "Left Bypass Switch", "Left Line Mux" },
 	{ "Left Mixer", "Right Playback Switch", "Right DAC" },
 	{ "Left Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "Right Mixer", "Left Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Left Bypass Switch", "Left Line Mux" },
-	{ "Right Mixer", "Playback Switch", "Right DAC" },
+	{ "Right Mixer", NULL, "Right DAC" },
 	{ "Right Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "DAC DIG", NULL, "DAC STM" },

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250222-es8328-route-bludgeoning-0b48cb2d9022

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


