Return-Path: <linux-kernel+bounces-196487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A58D5CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2002828954A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000A150981;
	Fri, 31 May 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBMuAXpC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099E14F9EE
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144681; cv=none; b=W/8b9zcYmKWcXkXgKK8MREEZIZbL5klh705i+DazPUTAo5Y4XX7qtF08i6/+WdAB/1VhDqMv5vcjaWcDP1vLsdZ4lPXkLYJR80yel51rSuaZsw4UFxfEe36IpBgrTXgNCmx1SMeE+H1GOdyTWd2ZHVvagMmlOey6LJVlc9HmKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144681; c=relaxed/simple;
	bh=0ybdQoPao3Fs+wvAdUgSdweM9qNoDU9X/xhgb/ynYt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dPT4hzSieisSDmJwuWx0gNbkFy5yOiJy9XhiX7V4NGsYkdRK+DYntypgZEK7k+8qA12cJLp2bBY6YYTTtsGGv3FPgd+7XgrjrWrdHWEoW171PCgkGX/QrW4nt3Ye3lFK+sSrFhvmu3X42CDWo1f4oXT/JGxMGaxEjTPSCo9TAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XBMuAXpC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6134df05fso16371345ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717144679; x=1717749479; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMwLestZgmk4mqZillFQkfuSiKmx8+iHR4IW4Az53nU=;
        b=XBMuAXpC07qZWmmpti+DDduNj8rJ0DpJGdTkvDW/2vmKrr/tDqfcWwTrjipZE8bqzS
         2OfGuyyQTN68DW0DGnwFDaO4sdAAThXPZ/XLn0ad8pnMLFRg4b2db5rF0mcIsRfeFkRZ
         Ro8E4yWgi64lCoL18KZXqnPNys0Rx9NcGo8cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144679; x=1717749479;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMwLestZgmk4mqZillFQkfuSiKmx8+iHR4IW4Az53nU=;
        b=rtNhO8Gcd7v71K3AhQlOr+gnVLeamWfl/3UN1wZr00jG0Hu5yLD01oVjyLyb3Rq8z1
         thAzQsj7JyMmFSFkr0v4ArL9l2As7g7v3PXak9z3LIdxoSySvXTdUnR9SyLnf4j4nAOo
         07kuexSUw+kSGSoluEiI7WtfTsnDNJv4QsPvDyJrH0RnBIj30Or/XZMvBAhAnvflvAEh
         mzdSwI4VtO5o9+D8fEHH8Eg9IAO4Bk3ia5sSDtH1kfwqfDTLAMLt7Ue8BA7pebJhoAUk
         eJD9c3xWFoo3rJsjguk2ye98ZmaIl6pb10RW23HjlP6DjUhS4SpUhkoRPkINOg1HQp4L
         kYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Eu03RqtOABszVfLP9ixawqLImIMbGeqftGzVBKBXlkkANDkZN+eOuo6qXR8RcrAr0VL69gdxGA541Iiv7BFH/skO/0y9Z0xlkO3N
X-Gm-Message-State: AOJu0YwojYfnxAFMMOK3eiDvi9o6KhW8ZPQUFinElzu0FadoCmxAH5v4
	tVrBReWETrOrCA+hw2UnNkXgele3WjaFi+4rwZL3yiWpX3yEwMORNjZQO/a68Q==
X-Google-Smtp-Source: AGHT+IHVF/CjYv1gYu9lVMBUNy41C2j/6h4MXrfx+yak3WHwDeUdVuFOe+Oz/lM84SJ3D8ebAql2BQ==
X-Received: by 2002:a17:902:c403:b0:1f4:ac56:3d15 with SMTP id d9443c01a7336-1f636fedfbcmr13329195ad.15.1717144679140;
        Fri, 31 May 2024 01:37:59 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (198.180.199.104.bc.googleusercontent.com. [104.199.180.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63240379fsm11057545ad.252.2024.05.31.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:37:58 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 31 May 2024 08:37:54 +0000
Subject: [PATCH RFT] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol
 name collision
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGGMWWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2ND3ZREcyNDS10jIwtDAwtTC2OLRFMloOKCotS0zAqwQdFKQW4hSrG
 1tQABn+CFXQAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

Since "Headphone Switch" kcontrol name has already been used by da7219,
rename the control name from "Headphone" to "Headphones" to prevent the
colision. Also, this change makes kcontrol name align with the one in
mt8186-mt6366-da7219-max98357.c.

Fixes: 9c7388baa2053 ("ASoC: mediatek: mt8183-da7219-max98357: Map missing jack kcontrols")
Change-Id: I9ae69a4673cd04786b247cc514fdd20f878ef009
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
This patch fix the kcontrol name collision in mt8183-da7219-max98357.c.
Originally, the "Headphone" kcontrol is added to meet PulseAudio's and
PipeWire's needs, but that patch was untested. Since I don't have
either setup, I wonder if someone can test this patch.
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index acaf81fd6c9b..f848e14b091a 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -31,7 +31,7 @@ struct mt8183_da7219_max98357_priv {
 
 static struct snd_soc_jack_pin mt8183_da7219_max98357_jack_pins[] = {
 	{
-		.pin	= "Headphone",
+		.pin	= "Headphones",
 		.mask	= SND_JACK_HEADPHONE,
 	},
 	{
@@ -626,7 +626,7 @@ static struct snd_soc_codec_conf mt6358_codec_conf[] = {
 };
 
 static const struct snd_kcontrol_new mt8183_da7219_max98357_snd_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Line Out"),
@@ -634,7 +634,7 @@ static const struct snd_kcontrol_new mt8183_da7219_max98357_snd_controls[] = {
 
 static const
 struct snd_soc_dapm_widget mt8183_da7219_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_SPK("Line Out", NULL),
@@ -680,7 +680,7 @@ static struct snd_soc_codec_conf mt8183_da7219_rt1015_codec_conf[] = {
 };
 
 static const struct snd_kcontrol_new mt8183_da7219_rt1015_snd_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Left Spk"),
 	SOC_DAPM_PIN_SWITCH("Right Spk"),
@@ -689,7 +689,7 @@ static const struct snd_kcontrol_new mt8183_da7219_rt1015_snd_controls[] = {
 
 static const
 struct snd_soc_dapm_widget mt8183_da7219_rt1015_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Left Spk", NULL),
 	SND_SOC_DAPM_SPK("Right Spk", NULL),

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240531-da7219-2281085838a5

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


