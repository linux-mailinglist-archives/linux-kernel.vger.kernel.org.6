Return-Path: <linux-kernel+bounces-425215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244649DBEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C941B21BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3431537DA;
	Fri, 29 Nov 2024 04:07:26 +0000 (UTC)
Received: from mail-m104.netease.com (mail-m104.netease.com [154.81.10.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731E1B960;
	Fri, 29 Nov 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732853246; cv=none; b=sCsSOdsvBPchyBKGseIUxEMF++xZr06SHTzlQvRp9TOvZpgWqeDlxlWCB6VaICCTO5dRw+g31nyzQ0w7ICvncsCDgCf5cnSGpkymaAivmbeWc8oPkcjPFsbawWlN4ddvs7zHivqUi4d5SR5IfrmAhXHVzewLgspoLY0WdPr0m3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732853246; c=relaxed/simple;
	bh=kjp7gSMMg6OxEX6Lz04y8I/e7NxImJNRioU1K8UzebI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FF30iZvge4RVfvBgZGJU9X8pI6Br2qjzPxtQpoC3U3lSbqREUWwhQx2jahu4KVD6ctCpugzqa1Pzu1UAnSTuFKkqSUU4OnCsclxKm+5XquSgcq+8ght8yL+9u1v1f3AxgVsStMu8IZc/fPalB69Rm2CteJMLyvjau6Lb8k4jQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; arc=none smtp.client-ip=154.81.10.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4291aca3;
	Fri, 29 Nov 2024 09:44:46 +0800 (GMT+08:00)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	feng.liu@senarytech.com,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH V2] ALSA: hda/conexant: fix Z60MR100 startup pop issue
Date: Fri, 29 Nov 2024 09:44:41 +0800
Message-Id: <20241129014441.437205-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxkYVkMfSUxJQhlCHkwYQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKQ0hVSk9IVUxDWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a9375978ce709d9kunm4291aca3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46NTo6TDIvIyENIjE#TxpL
	NStPCwNVSlVKTEhJQ09PTUNMTEpJVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSEhLSTcG

When Z60MR100 startup, speaker will output a pop. To fix this issue,
we mute codec by init verbs in bios when system startup, and set GPIO
to low to unmute codec in codec driver when it loaded .

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e851785ff058..29c5c9fa55d3 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -308,6 +308,7 @@ enum {
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
+	CXT_FIXUP_HP_A_U,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -762,6 +763,20 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void cxt_setup_gpio_unmute(struct hda_codec *codec,
+				unsigned int gpio_mute_mask)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (gpio_mute_mask) {
+		// set gpio data to 0.
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
+	}
+}
+
 static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -776,6 +791,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
 		cxt_setup_mute_led(codec, 0x10, 0x20);
 }
 
+static void cxt_fixup_hp_a_u(struct hda_codec *codec,
+			const struct hda_fixup *fix, int action)
+{
+	//Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
+	//so need to unmute once by clearing the gpio data when runs into the system.
+	if (action == HDA_FIXUP_ACT_INIT)
+		cxt_setup_gpio_unmute(codec, 0x2);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -982,6 +1006,10 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ }
 		},
 	},
+	[CXT_FIXUP_HP_A_U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_a_u,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1055,6 +1083,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0252, "MBX-Z60MR100", CXT_FIXUP_HP_A_U),
 	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
@@ -1100,6 +1129,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
+	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
 	{}
 };
 
-- 
2.34.1


