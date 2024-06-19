Return-Path: <linux-kernel+bounces-220640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881AE90E4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202CC282875
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7D770F0;
	Wed, 19 Jun 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0z4bPaV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2A1BF50;
	Wed, 19 Jun 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783246; cv=none; b=tlrMR1oYS0Qu4fVVncKm4uiZxmJirAOijtLXO1xIUi5/orJE8iQs7MPl5S7cQHW/PAbIFdmBr/uxzcjwbARIKd1HyW+G6ci4TIrx2nVrILhLPSM3XrQCAhpzHgPNMHMEZFpFuPUTDOOXjPWxyPmOzGhk+y/pHVhwOU5fpX8cid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783246; c=relaxed/simple;
	bh=uVbdn5OiYgXHp1/bkkFcotgPWMA8kwbEVPxCJwPA0R4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdyALPW44Yl07TEQ32VE3dth8X5oQrP6xxALtauskRa8IcOrYDqO7vFDR98tjYfwYrdjbQj7+elFUreZrcG5msN6COEoc+kngZ6t5byCb9mxs7x0XeSiCwpo7rXs0ZCpaCiSK/G65JamQGpaWtwYwIn4D5QSzlXJPO4tJJBI7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0z4bPaV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42165f6645fso50977615e9.2;
        Wed, 19 Jun 2024 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718783242; x=1719388042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBNFCZSAnRRNd7GE8/l7cArIOPNTfPbrmTZUqPBXsJo=;
        b=U0z4bPaVUXuI489ip8iLR/gmRFhyazi+YwutPcpkzQiVG5nc2h5Z77yXwMD8NLOoWG
         jhHa3TBxuxbwOF93PfprqAxH4bTSxkK/1ED/hP/gczIDA4dsnWRmIgpwloYh1TqF8zL7
         rrs/tYDZ7eSa9Xtg16xQyIqwzdO/oqJeJaCs0YcyMEy9D1pwaVPNcLxbsycGFdPuiINW
         JoSBhY1e8B8RuqEBHi39/usAUx6uFKhpRa8EwygSGLYcoL6hdBJ5bpgFC4ArAu6prlv5
         VSAfV64Zb2OINzef3G87XFq1LrFIgPLC3cgWyGWfrKfRrtP2pq6DuPqllfMhbfQFbSe2
         cObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783242; x=1719388042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBNFCZSAnRRNd7GE8/l7cArIOPNTfPbrmTZUqPBXsJo=;
        b=w8Eu2KxvLD94FzgaDuQtHrqEW8aSxZr3Q2Jwz1ftNedK1sFqqty/QDhZIn1A2Nd4B+
         ixvYboMLYMvP7R0Y9Ytg1QExbKN7yJbEOw1wZXcFWNjKTggJh76A2heMiz67WkzLbbLa
         u+a8yr9yrLuJxM+Wt1CXLVV2thIUZJogLWmeurmmBLNqE1aXavCV45uNlhArVS0+fq6a
         i1H7UM2rrU2dsTvzbSoq9i3hVuDbjoLVaXFvrTNywtUTsjajRXhj20CKoBtIDpG9RCf2
         dEoT+ivMaJCelYBZs/n9ZObgbpYQaRB+w9iE5kQRkR4LhQ0d0zt1+HfPIT0vSuxtaGLm
         PCxA==
X-Forwarded-Encrypted: i=1; AJvYcCWesxQbGmz0JM9bRa9ft4clElE/MrzZhNvzNrqndnQE1yv/P91gRkOblsdFvEau5hGa6XaspuAMaIUy0SHeR4RgDhgitz2vJQJ1Ow1niSFMJNc0xDLd2RkXqi+b9Qu0Nae0blQGWEtFUWo=
X-Gm-Message-State: AOJu0Yzi7x73tHcmoRjyLkIU0y+dVl3iMkCzT9wkfIltb01Wi1U7zSB8
	usvHSnNhxfqPhBHarswH9I5kZw2EY4H4uJGvfyKLwvVoDmoe8BQJ
X-Google-Smtp-Source: AGHT+IGmyZ4I8ZGD2LtUym46dqtEAY1PY2S/+nf9VSd7LPKGvdnVImEt+sL/elWMwN+rb+usBWVbYQ==
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75cb with SMTP id 5b1f17b1804b1-424760d7767mr10275965e9.6.1718783242056;
        Wed, 19 Jun 2024 00:47:22 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641f522sm215124345e9.48.2024.06.19.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:47:21 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Reichl <hias@horus.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] ASoC: hdmi-codec: reorder channel allocation list
Date: Wed, 19 Jun 2024 07:47:17 +0000
Message-Id: <20240619074717.2138638-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes since v1:
- Squash content from an additional related patch authored by
Jonas since the original 2019 v1 submission [0]
- Minor rewording in the description (nothing creditworthy)

[0] https://patchwork.kernel.org/project/alsa-devel/patch/HE1PR06MB4011885AED9F32B09183B617ACD40@HE1PR06MB4011.eurprd06.prod.outlook.com/

NB: This patch has been included with most Allwinner, Amlogic
and Rockchip LibreELEC distro images since 2019 but has been
somewhat forgotten about (despite the occasional nag from me
to Jonas who is super-busy). However in the last month or so
adding it to LibreELEC x86-64 and Rasbperry Pi images has also
solved several 3.1/4.0 speaker placement problems reported in
forums so it's time to send v2 on Jonas' behalf.

 sound/soc/codecs/hdmi-codec.c | 140 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d3abb7ce2153..63e063fb02de 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -185,84 +185,97 @@ static const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
 /*
  * hdmi_codec_channel_alloc: speaker configuration available for CEA
  *
- * This is an ordered list that must match with hdmi_codec_8ch_chmaps struct
+ * This is an ordered list where ca_id must exist in hdmi_codec_8ch_chmaps
  * The preceding ones have better chances to be selected by
  * hdmi_codec_get_ch_alloc_table_idx().
  */
 static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 	{ .ca_id = 0x00, .n_ch = 2,
-	  .mask = FL | FR},
-	/* 2.1 */
-	{ .ca_id = 0x01, .n_ch = 4,
-	  .mask = FL | FR | LFE},
-	/* Dolby Surround */
+	  .mask = FL | FR },
+	{ .ca_id = 0x03, .n_ch = 4,
+	  .mask = FL | FR | LFE | FC },
 	{ .ca_id = 0x02, .n_ch = 4,
 	  .mask = FL | FR | FC },
-	/* surround51 */
+	{ .ca_id = 0x01, .n_ch = 4,
+	  .mask = FL | FR | LFE },
 	{ .ca_id = 0x0b, .n_ch = 6,
-	  .mask = FL | FR | LFE | FC | RL | RR},
-	/* surround40 */
-	{ .ca_id = 0x08, .n_ch = 6,
-	  .mask = FL | FR | RL | RR },
-	/* surround41 */
-	{ .ca_id = 0x09, .n_ch = 6,
-	  .mask = FL | FR | LFE | RL | RR },
-	/* surround50 */
+	  .mask = FL | FR | LFE | FC | RL | RR },
 	{ .ca_id = 0x0a, .n_ch = 6,
 	  .mask = FL | FR | FC | RL | RR },
-	/* 6.1 */
-	{ .ca_id = 0x0f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | RC },
-	/* surround71 */
+	{ .ca_id = 0x09, .n_ch = 6,
+	  .mask = FL | FR | LFE | RL | RR },
+	{ .ca_id = 0x08, .n_ch = 6,
+	  .mask = FL | FR | RL | RR },
+	{ .ca_id = 0x07, .n_ch = 6,
+	  .mask = FL | FR | LFE | FC | RC },
+	{ .ca_id = 0x06, .n_ch = 6,
+	  .mask = FL | FR | FC | RC },
+	{ .ca_id = 0x05, .n_ch = 6,
+	  .mask = FL | FR | LFE | RC },
+	{ .ca_id = 0x04, .n_ch = 6,
+	  .mask = FL | FR | RC },
 	{ .ca_id = 0x13, .n_ch = 8,
 	  .mask = FL | FR | LFE | FC | RL | RR | RLC | RRC },
-	/* others */
-	{ .ca_id = 0x03, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC },
-	{ .ca_id = 0x04, .n_ch = 8,
-	  .mask = FL | FR | RC},
-	{ .ca_id = 0x05, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC },
-	{ .ca_id = 0x06, .n_ch = 8,
-	  .mask = FL | FR | FC | RC },
-	{ .ca_id = 0x07, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RC },
-	{ .ca_id = 0x0c, .n_ch = 8,
-	  .mask = FL | FR | RC | RL | RR },
-	{ .ca_id = 0x0d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RC },
-	{ .ca_id = 0x0e, .n_ch = 8,
-	  .mask = FL | FR | FC | RL | RR | RC },
-	{ .ca_id = 0x10, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | RLC | RRC },
-	{ .ca_id = 0x11, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
 	{ .ca_id = 0x12, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | RLC | RRC },
-	{ .ca_id = 0x14, .n_ch = 8,
-	  .mask = FL | FR | FLC | FRC },
-	{ .ca_id = 0x15, .n_ch = 8,
-	  .mask = FL | FR | LFE | FLC | FRC },
-	{ .ca_id = 0x16, .n_ch = 8,
-	  .mask = FL | FR | FC | FLC | FRC },
-	{ .ca_id = 0x17, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | FLC | FRC },
-	{ .ca_id = 0x18, .n_ch = 8,
-	  .mask = FL | FR | RC | FLC | FRC },
-	{ .ca_id = 0x19, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FLC | FRC },
-	{ .ca_id = 0x1a, .n_ch = 8,
-	  .mask = FL | FR | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1b, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1c, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
 	{ .ca_id = 0x1e, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
+	{ .ca_id = 0x11, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
+	{ .ca_id = 0x10, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1c, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | FLC | FRC },
+	{ .ca_id = 0x0f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | RC },
+	{ .ca_id = 0x1b, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0e, .n_ch = 8,
+	  .mask = FL | FR | FC | RL | RR | RC },
+	{ .ca_id = 0x1a, .n_ch = 8,
+	  .mask = FL | FR | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RC },
+	{ .ca_id = 0x19, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FLC | FRC },
+	{ .ca_id = 0x0c, .n_ch = 8,
+	  .mask = FL | FR | RC | RL | RR },
+	{ .ca_id = 0x18, .n_ch = 8,
+	  .mask = FL | FR | RC | FLC | FRC },
+	{ .ca_id = 0x17, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | FLC | FRC },
+	{ .ca_id = 0x16, .n_ch = 8,
+	  .mask = FL | FR | FC | FLC | FRC },
+	{ .ca_id = 0x15, .n_ch = 8,
+	  .mask = FL | FR | LFE | FLC | FRC },
+	{ .ca_id = 0x14, .n_ch = 8,
+	  .mask = FL | FR | FLC | FRC },
+	{ .ca_id = 0x0b, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR },
+	{ .ca_id = 0x0a, .n_ch = 8,
+	  .mask = FL | FR | FC | RL | RR },
+	{ .ca_id = 0x09, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR },
+	{ .ca_id = 0x08, .n_ch = 8,
+	  .mask = FL | FR | RL | RR },
+	{ .ca_id = 0x07, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RC },
+	{ .ca_id = 0x06, .n_ch = 8,
+	  .mask = FL | FR | FC | RC },
+	{ .ca_id = 0x05, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC },
+	{ .ca_id = 0x04, .n_ch = 8,
+	  .mask = FL | FR | RC },
+	{ .ca_id = 0x03, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC },
+	{ .ca_id = 0x02, .n_ch = 8,
+	  .mask = FL | FR | FC },
+	{ .ca_id = 0x01, .n_ch = 8,
+	  .mask = FL | FR | LFE },
 };
 
 struct hdmi_codec_priv {
@@ -371,7 +384,8 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct hdmi_codec_priv *hcp = info->private_data;
 
-	map = info->chmap[hcp->chmap_idx].map;
+	if (hcp->chmap_idx != HDMI_CODEC_CHMAP_IDX_UNKNOWN)
+		map = info->chmap[hcp->chmap_idx].map;
 
 	for (i = 0; i < info->max_channels; i++) {
 		if (hcp->chmap_idx == HDMI_CODEC_CHMAP_IDX_UNKNOWN)
-- 
2.34.1


