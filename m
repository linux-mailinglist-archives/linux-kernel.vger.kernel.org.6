Return-Path: <linux-kernel+bounces-424309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE89DB2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EF16537D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A3145FE8;
	Thu, 28 Nov 2024 06:44:14 +0000 (UTC)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com [45.254.49.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B941C94;
	Thu, 28 Nov 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776253; cv=none; b=sO8n27p6XapZGTe6ijB+WTbgZ/VXiokncp4prkAu1zu6N2wsLGwfz+p2AgDmuUFcQo5zzdlKJPgeq7vVyNz6SK+FP5lp6mhMlj72gDAj2Uva9iDknQ4+4JSSiHkuSAsWc/QpQp28YOKGuPL8g07igSws3ntMrEOrqamNsXTJifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776253; c=relaxed/simple;
	bh=1a0pCWz0vr9O9ZcRJsSe/fsu8yC8dixfeSg84zIwXbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1gXVYDXQrbnZXHH00llVmrdsErwwKYva3elnZmnvrpI3wSPMJWapyLunZmtl1UzqoxhVrlozuW8/o31pKTrS6Qsw3I9W9OD0AC8PKjlnj0jqnklalfcobbU7jOR+0R89nYSUaHotzW/ntgl0hdR4fnKE9i6QXHDde5oHIXE2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; arc=none smtp.client-ip=45.254.49.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by smtp.qiye.163.com (Hmail) with ESMTP id 413d48b4;
	Thu, 28 Nov 2024 14:08:34 +0800 (GMT+08:00)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	feng.liu@senarytech.com,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH V2] ALSA: hda/conexant: fix Z60MR100 startup pop issue
Date: Thu, 28 Nov 2024 14:08:12 +0800
Message-Id: <20241128060812.433362-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB0dVh1JHR8eGBgfGRkdTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKQ0hVSk9IVUxDWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhDVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a937162b63009d9kunm413d48b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6Myo6MTIuESxJThwTOhMT
	Ei4aFB1VSlVKTEhJTExPSkpOTUJLVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSE1JTzcG

When Z60MR100 startup, speaker will output a pop. To fix this issue,
we mute codec by init verbs in bios when system startup, and set GPIO
to low to unmute codec in codec driver when it loaded .

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e851785ff058..62c53e64bcad 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -42,6 +42,7 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
+	unsigned int gpio_unmute_bit_mask;
 	bool is_cx8070_sn6140;
 };
 
@@ -308,6 +309,7 @@ enum {
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
+	CXT_FIXUP_HP_A_U,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -762,6 +764,24 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void cxt_setup_mute_gpio_and_unmute(struct hda_codec *codec,
+				unsigned int gpio_mute_mask)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (gpio_mute_mask) {
+		spec->gpio_unmute_bit_mask = gpio_mute_mask;
+
+		//set gpio data to 0.
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+					spec->gpio_unmute_bit_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+					spec->gpio_unmute_bit_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
+	}
+}
+
 static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -776,6 +796,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
 		cxt_setup_mute_led(codec, 0x10, 0x20);
 }
 
+static void cxt_fixup_hp_a_u(struct hda_codec *codec,
+			const struct hda_fixup *fix, int action)
+{
+	//Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
+	//so need to unmute once by clearing the gpio data when runs into the system.
+	if (action == HDA_FIXUP_ACT_INIT)
+		cxt_setup_mute_gpio_and_unmute(codec, 0x2);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -982,6 +1011,10 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ }
 		},
 	},
+	[CXT_FIXUP_HP_A_U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_a_u,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1055,6 +1088,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0252, "MBX-Z60MR100", CXT_FIXUP_HP_A_U),
 	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
@@ -1100,6 +1134,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
+	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
 	{}
 };
 
-- 
2.34.1


