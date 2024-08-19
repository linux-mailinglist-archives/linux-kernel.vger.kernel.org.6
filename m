Return-Path: <linux-kernel+bounces-292203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F8956C60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8BAB25BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AB916C6B7;
	Mon, 19 Aug 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UZVCZcE1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EC16C6A2;
	Mon, 19 Aug 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074966; cv=none; b=FUmUGC0K98cqexaGJGh3Gj9c6nLRH4i7FPc8iiRFLoBYiRWxP2ocgHEw1Dkz+n/hW+2HgkkBuAIjUoKuEhyWdyuG0Asx1T8nQajcirh0lXOw47XFazQX7hhoLzTn9DWzZ61l2H1ChUoqWHPxxkmBRBflI8GuVQKHWVo9po9Xeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074966; c=relaxed/simple;
	bh=zZhQNCHQqUbuFv46DFdkcuhDec7qz5oYZt7ws26HwLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5m5v7X3UYibPKKU55Dx9Wus4l5e8sN1oclUAj8viRZW6IHgoG2gWRnrcA/k56CkZqMRcglKI7laFCfHzqcWj0mRwgpt1R4FAPGYMNMXry//iten09/oHaTJitWpLKj4HIL8JEoM+pZK2RHJGZpfl+BHlYtmdcc7CQQdEWAqSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UZVCZcE1; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J4T6OS006086;
	Mon, 19 Aug 2024 07:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=GZY3gy6uYHYixNHg
	UGIf4GyFXnY5o/dwMVq6kOQCKx8=; b=UZVCZcE1gBKsYn2+s00d9GXVDqiApmiK
	DSg2n5r12EiTnWsttagsdUh4cxjiD4mnPACc8E370gn6Y4bLJsjKxnhqqoaZVaOg
	0JoHwDkIytM9mM/KL3/Oi+Q3mtFZhIbbTuc9bvNldFWmFTCQuBQO4AnHlL4dtyp2
	i4ZXas/CoEdM9em2VnrahDRXUhxrgOB/NxOTU2tpNO/gNAMWUW6NONvrBn8wC0/r
	h5FmTFb1skIkL9rArduJwiTEs1GXKSoIuHw/iPsc6qKZcaosZOAEkAib0i8RjdsQ
	evcw/odX3ca+qboXiz+Xp9WZaSi8HZpxM1W5Cp3ui7QznBQyLdtR5g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hsney-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 07:37:50 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 13:37:49 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 19 Aug 2024 13:37:49 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C9B3D820249;
	Mon, 19 Aug 2024 12:37:48 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Convert existing CS35L56 products to use autodetect fixup function
Date: Mon, 19 Aug 2024 12:37:36 +0000
Message-ID: <20240819123736.111946-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yuWMSgkMFm8oFoXO2gdKrHz2IalK0TXn
X-Proofpoint-ORIG-GUID: yuWMSgkMFm8oFoXO2gdKrHz2IalK0TXn
X-Proofpoint-Spam-Reason: safe

The existing CS35L56 products can make use of the fixup function that
works out the component binding details so we can remove the fixed
configuration fixup functions.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 47 +++++------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d569626f78a..c573183c69a9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6970,26 +6970,6 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	comp_generic_fixup(cdc, action, "i2c", "CLSA0101", "-%s:00-cs35l41-hda.%d", 2);
 }
 
-static void cs35l56_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
-{
-	comp_generic_fixup(cdc, action, "i2c", "CSC3556", "-%s:00-cs35l56-hda.%d", 2);
-}
-
-static void cs35l56_fixup_i2c_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
-{
-	comp_generic_fixup(cdc, action, "i2c", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
-}
-
-static void cs35l56_fixup_spi_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
-{
-	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 2);
-}
-
-static void cs35l56_fixup_spi_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
-{
-	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
-}
-
 static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	/*
@@ -6997,7 +6977,7 @@ static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fix
 	 * different codecs and the newer GA403U has a ALC285.
 	 */
 	if (cdc->core.vendor_id == 0x10ec0285)
-		cs35l56_fixup_i2c_two(cdc, fix, action);
+		cs35lxx_autodet_fixup(cdc, fix, action);
 	else
 		alc_fixup_inv_dmic(cdc, fix, action);
 }
@@ -7599,9 +7579,6 @@ enum {
 	ALC256_FIXUP_ACER_SFG16_MICMUTE_LED,
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
-	ALC285_FIXUP_CS35L56_SPI_2,
-	ALC285_FIXUP_CS35L56_I2C_2,
-	ALC285_FIXUP_CS35L56_I2C_4,
 	ALC285_FIXUP_ASUS_GA403U,
 	ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC,
 	ALC285_FIXUP_ASUS_GA403U_I2C_SPEAKER2_TO_DAC1,
@@ -9867,7 +9844,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l56_fixup_spi_four,
+		.v.func = cs35lxx_autodet_fixup,
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
 	},
@@ -9883,18 +9860,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_spectre_x360_eu0xxx,
 	},
-	[ALC285_FIXUP_CS35L56_SPI_2] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l56_fixup_spi_two,
-	},
-	[ALC285_FIXUP_CS35L56_I2C_2] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l56_fixup_i2c_two,
-	},
-	[ALC285_FIXUP_CS35L56_I2C_4] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35l56_fixup_i2c_four,
-	},
 	[ALC285_FIXUP_ASUS_GA403U] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_asus_ga403u,
@@ -9923,7 +9888,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 		.chained = true,
-		.chain_id = ALC285_FIXUP_CS35L56_SPI_2
+		.chain_id = ALCXXX_FIXUP_CS35LXX
 	},
 	[ALC285_FIXUP_ASUS_GA403U_I2C_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
@@ -10456,14 +10421,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606", ALC285_FIXUP_CS35L56_I2C_4),
+	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
-	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_CS35L56_I2C_2),
-	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_CS35L56_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0


