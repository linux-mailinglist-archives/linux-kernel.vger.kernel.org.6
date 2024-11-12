Return-Path: <linux-kernel+bounces-405188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC49C4E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37C1B27621
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27E20896E;
	Tue, 12 Nov 2024 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJobWbYy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477F1990AB;
	Tue, 12 Nov 2024 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388039; cv=none; b=WuAWT0iAFVVXGVCaaN1C5UchnHMMGIaBevsA276OlSO6m5G5p+ZW5v+Iw/7kr4kMu+2t9Jx89yVJ9OFfsa/GKuL4Farr0JCLcSFdBxwDNIBNAZ/0KJNqE+YXGumadX4BEgEzD/5OfCHDx5ui10U6ABgLEvxlfpHUqAelGXn87Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388039; c=relaxed/simple;
	bh=RYvxk5szbK5nBC40HodFjGOpQ15icHkfsB6+XoS/f3A=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Y+Fx5FuRu2ahsZKqJo7L8Hy/f7uV5TpR6U4v6aaBskws6OGuvu63X7dDALKIYiFMBUryRrNqw5TlMMte1G8IbPtLRAyCOzSS6zHLCykTAgVdiqxR3YavZtfAf6gXFnDQ37hGxshx4xO9TIQrtTPtLCE4f7KAZ6EXNV9mdnThxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJobWbYy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431616c23b5so29691255e9.0;
        Mon, 11 Nov 2024 21:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731388035; x=1731992835; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILkI2uCTl8t1Nm9lqB/gevASgH86EFHiEk0kNXqkrL8=;
        b=XJobWbYyoHmrp/70yPQ/0Pw1kqFYpzEKgjWlndmqizLs3kJc6zoaMeRs00kHj0gR6l
         jmuxDTP1Pm2gsJbzTyuaFRZ2Lr4x7MLpqyuxQZ4tP7fPmU/pZyly6tluvcWQzGFIblVQ
         QoYnyDogoD0xWLB7lRYbYnI3UdtJK1n1IMU1iCr85y0a1aeFQbkWKWtdV4aih9mlaIKc
         oe1EKmOfGaunbFpKZCIT3WnvxeOimgm1iCjyO8uj+lxv+KzMiGBUmdMnoBTTl5MZIi5T
         4b+GfVXZ8HEz9dU4lsbnneCYXrEjykW8UtfIxYw7vh0UFluemv++T9l18pOUjzwwLSI7
         Pi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731388035; x=1731992835;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILkI2uCTl8t1Nm9lqB/gevASgH86EFHiEk0kNXqkrL8=;
        b=KGh2d8BWeFSnejCLIxiGgQLjqRRZ+Q/fdERrA3FX/wfsKxK8MmMEARLS7NUPPReEtM
         lMqceY4vqTWmq7XT9FlaaOM4BlTk61NSH53zwfigAdXOKBE2L/mszYdOZPrOQza7tX/r
         Ljf62RL03db752sFg8YKX2At01RcD3LB3I49AdgEuko2g+FsrtmxIR4vyK2n5SVVxVG8
         ATHtqpT061Kr/SyHo3kEpSIjWS8izdPgOvpNpcxT+HNNzjH4kJh4VUwfhYFYZTEqBhJn
         dypLDpVe/r3CxMcJRRhh3pdBj56+a0o5mdZ0NuxOrNrleAOVEGqxO1yjFgjeQ8K0jevI
         u2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWX2nVVojM0aRl+uYTOAV++/q6WoS6eTLUCwdbXb8smRlsJk1XyKvA3xIOVylfpXKWOTWGjj9SFENP4bjU=@vger.kernel.org, AJvYcCXgvSDDo+0BzmUW4Mx7zIj/8UUVuwiAICXVau1Io5WNuRGkhA20Wn1+xz4g7V9a8A1mdM2rH3gyj78G/I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQU+roLhd1atEaPWWVGjjpI2j7sXGvTUgveU7tAQrGhZynOkOI
	h1noUX4EeXV20RokhnWrRa2svJ9T05kKngT0tmMQA0opABLaDS3F
X-Google-Smtp-Source: AGHT+IF9+cgddGpyUpMMtFPxL4rt8NKWIyq5yTuVhSMCdwwREYIF9pAIEl1fAm9HuHFXn5Ih9saM7A==
X-Received: by 2002:a05:600c:4fc3:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-432b744db26mr117744055e9.4.1731388035094;
        Mon, 11 Nov 2024 21:07:15 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c0414sm228435215e9.23.2024.11.11.21.07.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2024 21:07:14 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: [RESEND v2] ASoC: hdmi-codec: reorder channel allocation list
Message-Id: <7697010E-E0F2-419F-8378-FC3E491EE1E4@gmail.com>
Date: Tue, 12 Nov 2024 09:07:00 +0400
Cc: Matthias Reichl <hias@horus.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.200.121)

From: Jonas Karlman <jonas@kwiboo.se>

The ordering in hdmi_codec_get_ch_alloc_table_idx() results in
wrong channel allocation for a number of cases, e.g. when ELD
reports FL|FR|LFE|FC|RL|RR or FL|FR|LFE|FC|RL|RR|RC|RLC|RRC:

ca_id 0x01 with speaker mask FL|FR|LFE is selected instead of
ca_id 0x03 with speaker mask FL|FR|LFE|FC for 4 channels

and

ca_id 0x04 with speaker mask FL|FR|RC gets selected instead of
ca_id 0x0b with speaker mask FL|FR|LFE|FC|RL|RR for 6 channels

Fix this by reordering the channel allocation list with most
specific speaker mask at the top.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
=E2=80=94
Changes since v1:
- Squash content from an additional related patch authored by
Jonas since the original 2019 v1 submission [0]
- Minor rewording in the description (nothing creditworthy)

[0] =
https://patchwork.kernel.org/project/alsa-devel/patch/HE1PR06MB4011885AED9=
F32B09183B617ACD40@HE1PR06MB4011.eurprd06.prod.outlook.com/

NB: This patch has been included with most Allwinner, Amlogic
and Rockchip LibreELEC distro images since 2019 but has been
somewhat forgotten about (despite the occasional nag from me
to Jonas who is super-busy). However in the last month or so
adding it to LibreELEC x86-64 and Rasbperry Pi images has also
solved several 3.1/4.0 speaker placement problems reported in
forums so it's time to send v2 on Jonas' behalf.

sound/soc/codecs/hdmi-codec.c | 140 +++++++++++++++++++---------------
1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c =
b/sound/soc/codecs/hdmi-codec.c
index d3abb7ce2153..63e063fb02de 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -185,84 +185,97 @@ static const struct snd_pcm_chmap_elem =
hdmi_codec_8ch_chmaps[] =3D {
/*
 * hdmi_codec_channel_alloc: speaker configuration available for CEA
 *
- * This is an ordered list that must match with hdmi_codec_8ch_chmaps =
struct
+ * This is an ordered list where ca_id must exist in =
hdmi_codec_8ch_chmaps
 * The preceding ones have better chances to be selected by
 * hdmi_codec_get_ch_alloc_table_idx().
 */
static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] =
=3D {
	{ .ca_id =3D 0x00, .n_ch =3D 2,
-	  .mask =3D FL | FR},
-	/* 2.1 */
-	{ .ca_id =3D 0x01, .n_ch =3D 4,
-	  .mask =3D FL | FR | LFE},
-	/* Dolby Surround */
+	  .mask =3D FL | FR },
+	{ .ca_id =3D 0x03, .n_ch =3D 4,
+	  .mask =3D FL | FR | LFE | FC },
	{ .ca_id =3D 0x02, .n_ch =3D 4,
	  .mask =3D FL | FR | FC },
-	/* surround51 */
+	{ .ca_id =3D 0x01, .n_ch =3D 4,
+	  .mask =3D FL | FR | LFE },
	{ .ca_id =3D 0x0b, .n_ch =3D 6,
-	  .mask =3D FL | FR | LFE | FC | RL | RR},
-	/* surround40 */
-	{ .ca_id =3D 0x08, .n_ch =3D 6,
-	  .mask =3D FL | FR | RL | RR },
-	/* surround41 */
-	{ .ca_id =3D 0x09, .n_ch =3D 6,
-	  .mask =3D FL | FR | LFE | RL | RR },
-	/* surround50 */
+	  .mask =3D FL | FR | LFE | FC | RL | RR },
	{ .ca_id =3D 0x0a, .n_ch =3D 6,
	  .mask =3D FL | FR | FC | RL | RR },
-	/* 6.1 */
-	{ .ca_id =3D 0x0f, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FC | RL | RR | RC },
-	/* surround71 */
+	{ .ca_id =3D 0x09, .n_ch =3D 6,
+	  .mask =3D FL | FR | LFE | RL | RR },
+	{ .ca_id =3D 0x08, .n_ch =3D 6,
+	  .mask =3D FL | FR | RL | RR },
+	{ .ca_id =3D 0x07, .n_ch =3D 6,
+	  .mask =3D FL | FR | LFE | FC | RC },
+	{ .ca_id =3D 0x06, .n_ch =3D 6,
+	  .mask =3D FL | FR | FC | RC },
+	{ .ca_id =3D 0x05, .n_ch =3D 6,
+	  .mask =3D FL | FR | LFE | RC },
+	{ .ca_id =3D 0x04, .n_ch =3D 6,
+	  .mask =3D FL | FR | RC },
	{ .ca_id =3D 0x13, .n_ch =3D 8,
	  .mask =3D FL | FR | LFE | FC | RL | RR | RLC | RRC },
-	/* others */
-	{ .ca_id =3D 0x03, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FC },
-	{ .ca_id =3D 0x04, .n_ch =3D 8,
-	  .mask =3D FL | FR | RC},
-	{ .ca_id =3D 0x05, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RC },
-	{ .ca_id =3D 0x06, .n_ch =3D 8,
-	  .mask =3D FL | FR | FC | RC },
-	{ .ca_id =3D 0x07, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FC | RC },
-	{ .ca_id =3D 0x0c, .n_ch =3D 8,
-	  .mask =3D FL | FR | RC | RL | RR },
-	{ .ca_id =3D 0x0d, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RL | RR | RC },
-	{ .ca_id =3D 0x0e, .n_ch =3D 8,
-	  .mask =3D FL | FR | FC | RL | RR | RC },
-	{ .ca_id =3D 0x10, .n_ch =3D 8,
-	  .mask =3D FL | FR | RL | RR | RLC | RRC },
-	{ .ca_id =3D 0x11, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id =3D 0x1f, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC | RL | RR | FLC | FRC },
	{ .ca_id =3D 0x12, .n_ch =3D 8,
	  .mask =3D FL | FR | FC | RL | RR | RLC | RRC },
-	{ .ca_id =3D 0x14, .n_ch =3D 8,
-	  .mask =3D FL | FR | FLC | FRC },
-	{ .ca_id =3D 0x15, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FLC | FRC },
-	{ .ca_id =3D 0x16, .n_ch =3D 8,
-	  .mask =3D FL | FR | FC | FLC | FRC },
-	{ .ca_id =3D 0x17, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FC | FLC | FRC },
-	{ .ca_id =3D 0x18, .n_ch =3D 8,
-	  .mask =3D FL | FR | RC | FLC | FRC },
-	{ .ca_id =3D 0x19, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RC | FLC | FRC },
-	{ .ca_id =3D 0x1a, .n_ch =3D 8,
-	  .mask =3D FL | FR | RC | FC | FLC | FRC },
-	{ .ca_id =3D 0x1b, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RC | FC | FLC | FRC },
-	{ .ca_id =3D 0x1c, .n_ch =3D 8,
-	  .mask =3D FL | FR | RL | RR | FLC | FRC },
-	{ .ca_id =3D 0x1d, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | RL | RR | FLC | FRC },
	{ .ca_id =3D 0x1e, .n_ch =3D 8,
	  .mask =3D FL | FR | FC | RL | RR | FLC | FRC },
-	{ .ca_id =3D 0x1f, .n_ch =3D 8,
-	  .mask =3D FL | FR | LFE | FC | RL | RR | FLC | FRC },
+	{ .ca_id =3D 0x11, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id =3D 0x1d, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RL | RR | FLC | FRC },
+	{ .ca_id =3D 0x10, .n_ch =3D 8,
+	  .mask =3D FL | FR | RL | RR | RLC | RRC },
+	{ .ca_id =3D 0x1c, .n_ch =3D 8,
+	  .mask =3D FL | FR | RL | RR | FLC | FRC },
+	{ .ca_id =3D 0x0f, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC | RL | RR | RC },
+	{ .ca_id =3D 0x1b, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RC | FC | FLC | FRC },
+	{ .ca_id =3D 0x0e, .n_ch =3D 8,
+	  .mask =3D FL | FR | FC | RL | RR | RC },
+	{ .ca_id =3D 0x1a, .n_ch =3D 8,
+	  .mask =3D FL | FR | RC | FC | FLC | FRC },
+	{ .ca_id =3D 0x0d, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RL | RR | RC },
+	{ .ca_id =3D 0x19, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RC | FLC | FRC },
+	{ .ca_id =3D 0x0c, .n_ch =3D 8,
+	  .mask =3D FL | FR | RC | RL | RR },
+	{ .ca_id =3D 0x18, .n_ch =3D 8,
+	  .mask =3D FL | FR | RC | FLC | FRC },
+	{ .ca_id =3D 0x17, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC | FLC | FRC },
+	{ .ca_id =3D 0x16, .n_ch =3D 8,
+	  .mask =3D FL | FR | FC | FLC | FRC },
+	{ .ca_id =3D 0x15, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FLC | FRC },
+	{ .ca_id =3D 0x14, .n_ch =3D 8,
+	  .mask =3D FL | FR | FLC | FRC },
+	{ .ca_id =3D 0x0b, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC | RL | RR },
+	{ .ca_id =3D 0x0a, .n_ch =3D 8,
+	  .mask =3D FL | FR | FC | RL | RR },
+	{ .ca_id =3D 0x09, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RL | RR },
+	{ .ca_id =3D 0x08, .n_ch =3D 8,
+	  .mask =3D FL | FR | RL | RR },
+	{ .ca_id =3D 0x07, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC | RC },
+	{ .ca_id =3D 0x06, .n_ch =3D 8,
+	  .mask =3D FL | FR | FC | RC },
+	{ .ca_id =3D 0x05, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | RC },
+	{ .ca_id =3D 0x04, .n_ch =3D 8,
+	  .mask =3D FL | FR | RC },
+	{ .ca_id =3D 0x03, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE | FC },
+	{ .ca_id =3D 0x02, .n_ch =3D 8,
+	  .mask =3D FL | FR | FC },
+	{ .ca_id =3D 0x01, .n_ch =3D 8,
+	  .mask =3D FL | FR | LFE },
};

struct hdmi_codec_priv {
@@ -371,7 +384,8 @@ static int hdmi_codec_chmap_ctl_get(struct =
snd_kcontrol *kcontrol,
	struct snd_pcm_chmap *info =3D snd_kcontrol_chip(kcontrol);
	struct hdmi_codec_priv *hcp =3D info->private_data;

-	map =3D info->chmap[hcp->chmap_idx].map;
+	if (hcp->chmap_idx !=3D HDMI_CODEC_CHMAP_IDX_UNKNOWN)
+		map =3D info->chmap[hcp->chmap_idx].map;

	for (i =3D 0; i < info->max_channels; i++) {
		if (hcp->chmap_idx =3D=3D HDMI_CODEC_CHMAP_IDX_UNKNOWN)
--=20
2.34.1


