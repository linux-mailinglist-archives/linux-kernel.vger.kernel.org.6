Return-Path: <linux-kernel+bounces-544415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC0A4E12E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D703A3CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667F24113E;
	Tue,  4 Mar 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR9vO6Z1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BB23F415;
	Tue,  4 Mar 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098385; cv=none; b=Snj+XRxhW3gO5csylhLNdIQn76/1f3MBFPIAhSVFmqOPMT917ixmOWn8ZR55ndIugQApsOlk0Fi0BTAkmyGji6o1nBfD6+4kzkQ7VUWohkbWFz8ZGfuTB/CbKkEyAMRIcapeqGJepq7pbFSRPpdFcv7447YxEtJmckU6cOq8Z/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098385; c=relaxed/simple;
	bh=enEki/g6nl9PIJYhlE2BFdEBA9YEqGtw5SW96Ta6j1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1g0VKjH5UeHGtuup/5Lku/BUxMf4LtQ9Z0l/KDhvG1T1tg+I70Vaf8aWAflhss3j+5kAiXH7+6rvi5zMT/SfPR2EnTWH4oEqd+kCgUblTcjI6xHJzGp2i/KFG0XN5/WLUjeiQCgM4MGuOvAi4LX9Rvedk9uECjsnAM2PbmekO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR9vO6Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593FBC4CEE5;
	Tue,  4 Mar 2025 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098385;
	bh=enEki/g6nl9PIJYhlE2BFdEBA9YEqGtw5SW96Ta6j1g=;
	h=From:To:Cc:Subject:Date:From;
	b=oR9vO6Z1bsWemGUZZIk4ol62qrF1+H251dpkpmyvJjePYQV+IFvGwtCHS2kbDQIPT
	 b3qAEeWHtRQq1fBflTojTrwZ6LoDIA0w9v6XOawiwV3mmlQGpcciKskd98TGsnYJw4
	 RdwH7hovdUmYs5ixY5wAq7REWCr9h3Kt56UISHQq36v7lFzFgfc4ZazaVHFYwXJ4ti
	 +JJQKf0gZyNyY6FpaHD2TpJibwJXsF16yWBiPE3GOKuswFzY0AIFLRxx7n2UYRH83n
	 CQ8on728rBv0r+tIrcjrc9e3YQX9CUK+W26TmP8MDsz/HTwPw9VI+h9l2oirfFEIvE
	 tT2MMG71ACVjA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] snd: hda: realtek: fix incorrect IS_REACHABLE() usage
Date: Tue,  4 Mar 2025 15:25:55 +0100
Message-Id: <20250304142620.582191-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The alternative path leads to a build error after a recent change:

sound/pci/hda/patch_realtek.c: In function 'alc233_fixup_lenovo_low_en_micmute_led':
include/linux/stddef.h:9:14: error: called object is not a function or function pointer
    9 | #define NULL ((void *)0)
      |              ^
sound/pci/hda/patch_realtek.c:5041:49: note: in expansion of macro 'NULL'
 5041 | #define alc233_fixup_lenovo_line2_mic_hotkey    NULL
      |                                                 ^~~~
sound/pci/hda/patch_realtek.c:5063:9: note: in expansion of macro 'alc233_fixup_lenovo_line2_mic_hotkey'
 5063 |         alc233_fixup_lenovo_line2_mic_hotkey(codec, fix, action);

Using IS_REACHABLE() is somewhat questionable here anyway since it
leads to the input code not working when the HDA driver is builtin
but input is in a loadable module. Replace this with a hard compile-time
dependency on CONFIG_INPUT. In practice this won't chance much
other than solve the compiler error because it is rare to require
sound output but no input support.

Fixes: f603b159231b ("ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/Kconfig         | 1 +
 sound/pci/hda/patch_realtek.c | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 9f68cb73b54f..fb955a205d50 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -222,6 +222,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
+	depends on INPUT
 	select SND_HDA_GENERIC
 	select SND_HDA_GENERIC_LEDS
 	select SND_HDA_SCODEC_COMPONENT
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ebf54ef5877a..697a38e41e16 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4927,7 +4927,6 @@ static void alc298_fixup_samsung_amp_v2_4_amps(struct hda_codec *codec,
 		alc298_samsung_v2_init_amps(codec, 4);
 }
 
-#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -5036,10 +5035,6 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		spec->kb_dev = NULL;
 	}
 }
-#else /* INPUT */
-#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
-#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
-#endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
-- 
2.39.5


