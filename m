Return-Path: <linux-kernel+bounces-433985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47D9E5FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EAB284D13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8E1C303A;
	Thu,  5 Dec 2024 21:10:08 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BD5028C;
	Thu,  5 Dec 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433008; cv=none; b=UwuRvFP8aoJdATPpScrJPfY0xW6mV0SVsTm7J5jJ5kES1E22rbrUPuWO7fmMfWqd187/9Zc44l6LLAMcdTBeQx+sP8WH7aWtAMaGmN8ogJ+wZAPvP6azcx9TS+uzhwynzJrU+HYcONMg9sOIaIrv+pvmYPjLYHiP/XfR8LPUkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433008; c=relaxed/simple;
	bh=HDInLichUUvEbDxatLBLrTQAQONvhrjZX5HaWPpZhGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtPs+5TppeZ+/1mn2nCNbPA3oQAHH1WMFrFqFvZsp6JJyNo8IvFPo+Bys5oD+lN9QG0iyBwmZAQJMqvplhsTREThLAPCIx3p1Qv0Dt413pU4467G1dwpJ7b8TD/6uUp899c+mlG07gVRXzUT/MdXYSKE37z7O5T9XEoPaeGeSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 6786823374;
	Fri,  6 Dec 2024 00:03:14 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Pshou <pshou@realtek.com>,
	Derek Gordon <derek@derekgordon.com>
Subject: [PATCH] ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD audio
Date: Fri,  6 Dec 2024 00:03:06 +0300
Message-Id: <20241205210306.977634-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces necessary quirks to enable audio functionality on the
ASUS Zen AIO 27 Z272SD_A272SD:
- configures verbs to activate internal speakers and headphone jack.
- implements adjustments for headset microphone functionality.

The speaker and jack configurations were derived from a dump of
the working Windows driver, while the headset microphone
functionality was fine-tuned through experimental testing.

Link: https://lore.kernel.org/all/CAGGMHBOGDUnMewBTrZgoBKFk_A4sNF4fEXwfH9Ay8SNTzjy0-g@mail.gmail.com/T/
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4e58c6810f2217..694db73612a0b1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7714,6 +7714,7 @@ enum {
 	ALC274_FIXUP_HP_MIC,
 	ALC274_FIXUP_HP_HEADSET_MIC,
 	ALC274_FIXUP_HP_ENVY_GPIO,
+	ALC274_FIXUP_ASUS_ZEN_AIO_27,
 	ALC256_FIXUP_ASUS_HPE,
 	ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK,
 	ALC287_FIXUP_HP_GPIO_LED,
@@ -9516,6 +9517,26 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc274_fixup_hp_envy_gpio,
 	},
+	[ALC274_FIXUP_ASUS_ZEN_AIO_27] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xc420 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0249 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4a },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x202b },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x62 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xa007 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6b },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5060 },
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC2XX_FIXUP_HEADSET_MIC,
+	},
 	[ALC256_FIXUP_ASUS_HPE] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10630,6 +10651,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
+	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.33.8


