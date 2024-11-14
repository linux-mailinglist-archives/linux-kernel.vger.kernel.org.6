Return-Path: <linux-kernel+bounces-409678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5B9C8FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777AF2813C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FC18BB82;
	Thu, 14 Nov 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeLfH4t7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBC189F33;
	Thu, 14 Nov 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602497; cv=none; b=EbhXLSxBwTAmDLKUQVCUyUDMGoj2amGHJw3o3fH2yo70CbUKTG8m0MPCoeR0ip8cluceG/qYkk4cc38xnWSG4y3U6W9GsaCwEZu43a/lGETIcqfIPXNlME4o7DvqIYjKLA5PQRPUe52i6EIZcCZQxsIkGwLBIR03ySVVxGZ6bH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602497; c=relaxed/simple;
	bh=mHvtfKy1lK4BhXuOOFOB5y1G3OSXiADG3fJ4EbMP8ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUXr5+85obs26O5f3nb3KdoQc+EAuI4gMZSyAggAkXj6F7qPbXQ2pJxKnpDn+dR4GjBCUmbexJHtdW4acYA89X6po2Yfp3cEuhpofD8tx1N6MLmmbqJIQAVXV6gGVqp0m8nNQiG44r/cTTm4Al0HWE+CqP/QMlqae6Gp7DfXSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeLfH4t7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2113da91b53so6766135ad.3;
        Thu, 14 Nov 2024 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731602495; x=1732207295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmIzy3tYV80/AAee8ixcAK6cOxGUld61Bp/4NhXM94Q=;
        b=AeLfH4t7mx6lwSu6piCzijN5qm32fvz5JLhRBcow6kZiR/WWHp/ICG0vZXgyLZPawA
         2d1ddIK+Bf9o545viFCqc4gqR3pM8kwm7IFBczCREx9fgiqLU+Ktv4QCn/9U+Xtp8lpF
         BweIewqAoooxzqAz9qX6p1E4YnluKtYinYr+dU/LwIVhQytsb+DlvwMgjpHR+2nHJpMI
         Hu3GGbvAJUF4CFxX134Yq79UlHaJ33rI4eqI9GCGv5R94V4txm6PnPWZG9xdioIh7fh+
         amv9YqY8pSsFBcjrtzFMtMFuiSCn9C4ncCaXnoigzZC2HDd9lj2FEdFFnYCY1GIXsRvK
         LISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602495; x=1732207295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmIzy3tYV80/AAee8ixcAK6cOxGUld61Bp/4NhXM94Q=;
        b=J6gknyhY0+fi4JUHJMRDvhrsprul+HAAwJagGuvu6OxD5+FfcTeif+ursnsVFisOcr
         0c30kX89YBMeQoDxmN3czpajKChTLiYnilkzYgKeMRJFZ4wjrHMk6iKSYGWi4WfnNkaj
         /yexYGlXx1yetNsh4LF97IK3OS3vO5pp0cONUPl657tbj2Py7yR7bxxnUpXBrXrVdERZ
         Ni5T/hQ2EfVOPWCd441q7f1lWA3liN+tVuzg+d/dZz1E94eHK6daLnCEQ574DsI/qbaa
         JLZtyeVPAI2UOR1hWtnjQeEgEOwPyCV2+72DNWtXcapKDMN+L4HloaKN41fX+W03luFN
         fraA==
X-Forwarded-Encrypted: i=1; AJvYcCVL3BnuWUedh9VNtQODGII3f4H8aUgwm+WZcZq+33I/4H+0toGFfIbmr4j+Hj3VhJaumFK9jhAo2q0=@vger.kernel.org, AJvYcCXbF+6lNULZ3z7uzL8HzVy/Yda5b3+/fWnTW31iIVAQBZa8g+vdgPzH2/x81lRdB99XOi92N/5m6/JwIaUz@vger.kernel.org
X-Gm-Message-State: AOJu0YyHN2JoJqnhpqyR5vYPuB7gwNjgSVwrIXbZ1XyF6xghXXaN4yrg
	4FCi+s9QxS2JTskc/4tF62mlx8UQ60WfnIggcdTTL2fujQpMEBi1
X-Google-Smtp-Source: AGHT+IGnooZ6MrXxfVzmJq1rxjV/3UioBbrSnmqau+biyq7rekOh0ecfxksZEJpkO1mhL3pSwY/ayg==
X-Received: by 2002:a17:903:11c9:b0:20d:2804:bcde with SMTP id d9443c01a7336-21183e0ce16mr324856285ad.35.1731602494879;
        Thu, 14 Nov 2024 08:41:34 -0800 (PST)
Received: from [10.113.16.67] ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm12844915ad.244.2024.11.14.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:41:34 -0800 (PST)
From: Hridesh MG <hridesh699@gmail.com>
Date: Thu, 14 Nov 2024 22:11:19 +0530
Subject: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
In-Reply-To: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Kailang Yang <kailang@realtek.com>, 
 Simon Trimmer <simont@opensource.cirrus.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Hridesh MG <hridesh699@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731602485; l=2867;
 i=hridesh699@gmail.com; s=20241114; h=from:subject:message-id;
 bh=mHvtfKy1lK4BhXuOOFOB5y1G3OSXiADG3fJ4EbMP8ec=;
 b=ZG2dfbnNXITv4SKWd1Ke9RtEB+Vb2l70GJfM7151MUO7IIhpq6a5MRAOHVOPWdP1UwiRyASUm
 SrhRETn6IUlCothJ10nlTmx+FeY05XBd4m/N7OvTzstHtvR5MWB1i8q
X-Developer-Key: i=hridesh699@gmail.com; a=ed25519;
 pk=otVQutD5ZTsEpajsGv/haM3pQj0yofkuYrdNcaX5AUE=

The headset jack on the realtek ALC287 codec for the Acer Nitro 5
AN515-58 laptop requires a fixup to detect microphone input.

The required pin config and verbs were obtained by reverse engineering
the windows driver using RtHD dump.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 571fa8a6c9e1204892a93ffb24acce65400ce4b2..0204ed80791db87153dad80d6a25466985ce5784 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7780,6 +7780,8 @@ enum {
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
 	ALC245_FIXUP_CLEVO_NOISY_MIC,
 	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
+	ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN,
+	ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -10154,6 +10156,23 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
+	[ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN] = {
+		.type = HDA_FIXUP_PINS,
+		.chained = true,
+		.chain_id = ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a19020 }, /* missing pin for headphone jack mic */
+			{ }
+		}
+	},
+	[ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xD689 },
+			{ }
+		}
+	}
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10201,6 +10220,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
+	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x053c, "Dell Latitude E5430", ALC292_FIXUP_DELL_E7X),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
@@ -11217,6 +11237,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN, .name = "alc287-fixup-acer-nitro-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \

-- 
2.47.0


