Return-Path: <linux-kernel+bounces-410207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0239CD647
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605A92807B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B9178CC5;
	Fri, 15 Nov 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHwR51t+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B6156C6C;
	Fri, 15 Nov 2024 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645832; cv=none; b=JnC4+yYRoUOAkf6sb0CBtkWcuTuGeYCYc4rC/1KehwKy0YsbcgGKNMjVf7szKUci+puZaeUm65THZ1wvkjh87kFn4g9FZ5MXXbgVOMvaUuTbOJClMJ2jksOjomvzP/PblpZMZiNQuzWGelC496OfiV+et/q+YDdF+Yty7TvKQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645832; c=relaxed/simple;
	bh=mM4PGSRNftyvjqwJTZvJS0Ulm9jEuf37Prrpsk1AJ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMSEIClqq/fclEBmESeICAKMYdvICvChy1DTq/FqF0+TZ6/7HtfF4XiuGfX0Sbxff8f+/PEJ/XexAAsTINQN0hKXaqHOdeKy5UX8kX8tEtBDePGUWjvW9IoiYtEJUQw1k79Ltf32C0zihI0OYyKGjwr/Mrwm9kTTafH5BWs/pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHwR51t+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43193678216so12130745e9.0;
        Thu, 14 Nov 2024 20:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731645829; x=1732250629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tie4lBSMdBeYwnVm6qx/FcQnD9h2dJp8stTbFXgQSoc=;
        b=MHwR51t+3RN8yNMc58k+FijEc4xC8cHFvnlKE/Jgn+qARgVR8K4bR5SY71+MHxuxK2
         9OfVDtzM6t0dXZuMG3GWo/v/9o2psi/oSSYWi1+WscOuxiXlteMckJ/Swj1PUeua1RxW
         4jufIIs+GUeh8pjEgvqecvZzpSYtD2gvC4H9+cwsxrwI1w19SMHC8gHFdhbUhQ7G4cVF
         PlkX/oUw4SEdP5uK9gT3cIRuywtR+ZUPjiYgiYC2RPwSOgclS3liiZDuPMnpEe4IL62v
         aIW6zQQkM5LJNICgXmzkMocFjPqEMF2l275YKnCSA31ISUWsjPQPYwnnjo5rBVeRpyGN
         AIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731645829; x=1732250629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tie4lBSMdBeYwnVm6qx/FcQnD9h2dJp8stTbFXgQSoc=;
        b=cMRDjPdn0J+9yi9pqcV6KmkWUdWfcwMrzSVOd6vdnCJc6tPYvElYbibef6IQzJbq/Z
         O//xV2de6y21fvR5EBWFPOQG0CRdKEvK1JnUXM2QSIcak52oynBaEbbyB+AhczwDyMpt
         gizQcwnUzhZp/npcHy9dvLMtcaH6u1D2VUs11DTrBEsL5Vl4QLXhIVJ2WMOUSgeUtffq
         U/7A59+KGV0pkQJv4BJar6IeK+ENMV6kK8qyuyJCHqAQ/m3H2m+9rAUjGbOUPiekVm6/
         eHCDjgqKsD6amvVVx1U6RHPWgNa1HF5tQxNr1wYxcj7HdH6zecMNcUaATHVihgLRL+X1
         vShQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYoW/zXc+7/rWND3lDJ1aMiImWaFFtrSa/L4I7J3g2+mwu2WQMu+tWoQRNGEO/JFSc6xMw3CJBp0Iw70Q=@vger.kernel.org, AJvYcCX7MwzxpL2DzBwpUBqEYasqoiPxaOU2XseKsLK856T8HLoWVsD45gNtHW+qw47qcEQhVO2DnmyG4yYPRbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RfMkzptWTnWv/XnAF4eK3qXwGFi/pIsGHqUOEP5YOQNvXz0j
	A2aMabcRZtrv0+vlW6dmBRtL4TxLm6YK9weYZCJ4HDymPxilu/5J
X-Google-Smtp-Source: AGHT+IGbvMY7eKYpg/YN2+uU7kn2jJvMehtMnsJQewT2m0tWrHntvUjkGXDFzNljnU7IYS+vI6ad7w==
X-Received: by 2002:a05:600c:4689:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-432df746a1bmr9541995e9.15.1731645828702;
        Thu, 14 Nov 2024 20:43:48 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265f28sm44609745e9.17.2024.11.14.20.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 20:43:48 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Reichl <hias@horus.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3] ASoC: hdmi-codec: reorder channel allocation list
Date: Fri, 15 Nov 2024 04:43:44 +0000
Message-Id: <20241115044344.3510979-1-christianshewitt@gmail.com>
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
specific speaker masks at the top.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v2:
- No changes, resending to ensure patch formatting is good
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
index 74caae52e127..d9df29a26f4f 100644
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


