Return-Path: <linux-kernel+bounces-357145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DB996C70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398871C21239
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B91991A4;
	Wed,  9 Oct 2024 13:42:57 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB3CA5B;
	Wed,  9 Oct 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481377; cv=none; b=niTrS3S/aDmJ02RV19872FXCX4RT+88l1IlOl8Eo68C7ZEzpcnaai/Uxq0r5mJpNfYO5Qb09Syn6sr4EtuG8GafxJvrI5QYL0U4ElyN0IzR7r9PcOBgnAjY0dTu/6lioIOjsL8AI0M0vewfWc0X0/l5yGOVspkl30w4R7GJmdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481377; c=relaxed/simple;
	bh=OXVOr/LAUsUjd+dup1SvboCZCzCpINd2Hkc7UPq8A/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGeATb02o8W9nJWpNHdwtqpfmZoXpGmP8NvRMwAqpehhimWYgrQPt4vag8KlUF97VJ1ymYz9xkUEg2P2h6qYJ6udf/DsSfO64BEL/rWn+/pvfa0HvRvIy03rxmCgjZTKTiTaVopZi+4KSPOXrrxqoVl0OYyuvkynwhTY5h7S7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 590242F2023D; Wed,  9 Oct 2024 13:42:52 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 8CB462F2023B;
	Wed,  9 Oct 2024 13:42:51 +0000 (UTC)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Cc: Vasiliy Kovalev <kovalev@altlinux.org>
Subject: [PATCH v2] ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
Date: Wed,  9 Oct 2024 16:42:48 +0300
Message-Id: <20241009134248.662175-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a problem with simultaneous audio output to headphones and
speakers, and when headphones are turned off, the speakers also turn
off and do not turn them on.

However, it was found that if you boot linux immediately after windows,
there are no such problems. When comparing alsa-info, the only difference
is the different configuration of Node 0x1d:

working conf. (windows): Pin-ctls: 0x80: HP
not working     (linux): Pin-ctls: 0xc0: OUT HP

This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
described problem.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/pci/hda/patch_conexant.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index b61ce5e6f5ec5..956cb71c3bee1 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -303,6 +303,7 @@ enum {
 	CXT_FIXUP_HP_SPECTRE,
 	CXT_FIXUP_HP_GATE_MIC,
 	CXT_FIXUP_MUTE_LED_GPIO,
+	CXT_FIXUP_HP_ELITEONE_OUT_DIS,
 	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
@@ -320,6 +321,19 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 	spec->gen.inv_dmic_split = 1;
 }
 
+/* fix widget control pin settings */
+static void cxt_fixup_update_pinctl(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		/* Unset OUT_EN for this Node pin, leaving only HP_EN.
+		 * This is the value stored in the codec register after
+		 * the correct initialization of the previous windows boot.
+		 */
+		snd_hda_set_pin_ctl(codec, 0x1d, AC_PINCTL_HP_EN);
+	}
+}
+
 static void cxt5066_increase_mic_boost(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
@@ -971,6 +985,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_mute_led_gpio,
 	},
+	[CXT_FIXUP_HP_ELITEONE_OUT_DIS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_update_pinctl,
+	},
 	[CXT_FIXUP_HP_ZBOOK_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_hp_zbook_mute_led,
@@ -1061,6 +1079,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83e5, "HP EliteOne 1000 G2", CXT_FIXUP_HP_ELITEONE_OUT_DIS),
 	SND_PCI_QUIRK(0x103c, 0x8402, "HP ProBook 645 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8427, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x844f, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
-- 
2.33.8


