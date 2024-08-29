Return-Path: <linux-kernel+bounces-307278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4379964B39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D91F27419
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87761B530C;
	Thu, 29 Aug 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c3Ru4dqn"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABB1B5ED2;
	Thu, 29 Aug 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948016; cv=none; b=AH9w7gQ7PgdePqlsRLYwufVhueCLprKbg1qHEQpePrfbOdRxtgA5ezWuqSFFBhyP/OA6m645D0P9tBtu+wpmbfL8GJF4IxmDOF9BkAhZuldoVrGbY3zdZXMK2D+GygdP/H4+1f0PVBfeGgdp6pOWJ7CRBqDScl+wm8ZvB5DiBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948016; c=relaxed/simple;
	bh=ti72UXLhLcsU8mFde4EgNqklecKAUM/cq1J9W53OKAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ewkdz+EWu4XYVLwGiMfZ7AFn3hLp+at1gD78N8iCH/q9ToUPammfKdlxDaqEYPjejyWckE/MDHTaZmJhgCyRy6+DnsCGMum0h2gnsaFXZZI8VZ3xsIwJ53lN/Og0IbeoHk65d92wqVOuhVrfC8sEA4jPbK0ZCEIZFJEYpM53Yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c3Ru4dqn; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDaY3U006559;
	Thu, 29 Aug 2024 11:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=EihV48pGoI5Wng+s
	Nfb2qLWOKb1N7jbBHIvMxwkTmVU=; b=c3Ru4dqnaK7G3bL1oO89KaOgDg/tYCDU
	VA2YDLQFOmaFffEpudDHsXyGmKgckQpM9jqUK9Zpn8t1vf8R73AzIhBg49tOU7X9
	oYxTTWBlWL1astWSNPIrSuI33DolZ8KyoVdux6+ZST8H7R0uTM8SRB3Vs95JdSc5
	sX6eTgCINDYpbdMdAN0bzgS8SVSengoAc9ZY7hSp72eWUW6BrSXW/7AWgBMP2CGL
	UZfskHNuZNIi0v8a4DQLDcUj9K/YBRcqJAaJtjIjuhIp35SHP5qyy1RpZ6QeBroD
	hsKUdjpg+gCXy4Jg4jj+YIK5aiVsQXvKA/paBfqZH4lQHiZUIHLk0g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 419puw2p1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 11:11:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 Aug
 2024 17:11:24 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 29 Aug 2024 17:11:24 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A9456820244;
	Thu, 29 Aug 2024 16:11:24 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Autodetect Cirrus Logic companion amplifier bindings
Date: Thu, 29 Aug 2024 16:11:14 +0000
Message-ID: <20240829161114.140938-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KDrPi1UEubz5MTHbYCjsCXkQIeElUPKd
X-Proofpoint-ORIG-GUID: KDrPi1UEubz5MTHbYCjsCXkQIeElUPKd
X-Proofpoint-Spam-Reason: safe

We do not need model specific HDA quirks to construct the component
binding details of Cirrus Logic companion amplifiers as this information
is already present in the ACPI.

Quirks are then only required for special workarounds not described in
the ACPI such as internal configuration of the Realtek codecs.

The codec pointer is now initialized in hda_component_manager_init() so
that we can detect when companion amplifiers are found in the ACPI but
the SSID invokes a quirk that also attempts to create the component
binding.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
v1 - This patch applies to for-next with this additional patch:
     b1faff28a2bd ("ALSA: hda: hda_component: Fix mutex crash if nothing ever binds")
     which is currently only in the for-linus.

     We're looking to do the same for the CS35L41 devices, but that will
     come later because there are many more quirks to work through.

 sound/pci/hda/hda_component.c |  19 +++-
 sound/pci/hda/hda_component.h |   2 +-
 sound/pci/hda/patch_realtek.c | 158 ++++++++++++++--------------------
 3 files changed, 82 insertions(+), 97 deletions(-)

diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index b7dfdb10d156..2d6b7b0b355d 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -142,7 +142,6 @@ int hda_component_manager_bind(struct hda_codec *cdc,
 
 	/* Init shared and component specific data */
 	memset(parent->comps, 0, sizeof(parent->comps));
-	parent->codec = cdc;
 
 	mutex_lock(&parent->mutex);
 	ret = component_bind_all(hda_codec_dev(cdc), parent);
@@ -163,6 +162,13 @@ int hda_component_manager_init(struct hda_codec *cdc,
 	struct hda_scodec_match *sm;
 	int ret, i;
 
+	if (parent->codec) {
+		codec_err(cdc, "Component binding already created (SSID: %x)\n",
+			  cdc->core.subsystem_id);
+		return -EINVAL;
+	}
+	parent->codec = cdc;
+
 	mutex_init(&parent->mutex);
 
 	for (i = 0; i < count; i++) {
@@ -185,12 +191,19 @@ int hda_component_manager_init(struct hda_codec *cdc,
 }
 EXPORT_SYMBOL_NS_GPL(hda_component_manager_init, SND_HDA_SCODEC_COMPONENT);
 
-void hda_component_manager_free(struct hda_codec *cdc,
+void hda_component_manager_free(struct hda_component_parent *parent,
 				const struct component_master_ops *ops)
 {
-	struct device *dev = hda_codec_dev(cdc);
+	struct device *dev;
+
+	if (!parent->codec)
+		return;
+
+	dev = hda_codec_dev(parent->codec);
 
 	component_master_del(dev, ops);
+
+	parent->codec = NULL;
 }
 EXPORT_SYMBOL_NS_GPL(hda_component_manager_free, SND_HDA_SCODEC_COMPONENT);
 
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 9f786608144c..7ee37154749f 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -75,7 +75,7 @@ int hda_component_manager_init(struct hda_codec *cdc,
 			       const char *match_str,
 			       const struct component_master_ops *ops);
 
-void hda_component_manager_free(struct hda_codec *cdc,
+void hda_component_manager_free(struct hda_component_parent *parent,
 				const struct component_master_ops *ops);
 
 int hda_component_manager_bind(struct hda_codec *cdc, struct hda_component_parent *parent);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c573183c69a9..fc46552a25c6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -949,7 +949,18 @@ static int alc_init(struct hda_codec *codec)
 	return 0;
 }
 
-#define alc_free	snd_hda_gen_free
+/* forward declaration */
+static const struct component_master_ops comp_master_ops;
+
+static void alc_free(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (spec)
+		hda_component_manager_free(&spec->comps, &comp_master_ops);
+
+	snd_hda_gen_free(codec);
+}
 
 static inline void alc_shutup(struct hda_codec *codec)
 {
@@ -6853,14 +6864,12 @@ static void comp_generic_fixup(struct hda_codec *cdc, int action, const char *bu
 		spec->gen.pcm_playback_hook = comp_generic_playback_hook;
 		break;
 	case HDA_FIXUP_ACT_FREE:
-		hda_component_manager_free(cdc, &comp_master_ops);
+		hda_component_manager_free(&spec->comps, &comp_master_ops);
 		break;
 	}
 }
 
-static void cs35lxx_autodet_fixup(struct hda_codec *cdc,
-				  const struct hda_fixup *fix,
-				  int action)
+static void find_cirrus_companion_amps(struct hda_codec *cdc)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct acpi_device *adev;
@@ -6875,67 +6884,53 @@ static void cs35lxx_autodet_fixup(struct hda_codec *cdc,
 	char *match;
 	int i, count = 0, count_devindex = 0;
 
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		for (i = 0; i < ARRAY_SIZE(acpi_ids); ++i) {
-			adev = acpi_dev_get_first_match_dev(acpi_ids[i].hid, NULL, -1);
-			if (adev)
-				break;
-		}
-		if (!adev) {
-			dev_err(dev, "Failed to find ACPI entry for a Cirrus Amp\n");
-			return;
-		}
-
-		count = i2c_acpi_client_count(adev);
-		if (count > 0) {
-			bus = "i2c";
-		} else {
-			count = acpi_spi_count_resources(adev);
-			if (count > 0)
-				bus = "spi";
-		}
+	for (i = 0; i < ARRAY_SIZE(acpi_ids); ++i) {
+		adev = acpi_dev_get_first_match_dev(acpi_ids[i].hid, NULL, -1);
+		if (adev)
+			break;
+	}
+	if (!adev) {
+		codec_dbg(cdc, "Did not find ACPI entry for a Cirrus Amp\n");
+		return;
+	}
 
-		fwnode = fwnode_handle_get(acpi_fwnode_handle(adev));
-		acpi_dev_put(adev);
+	count = i2c_acpi_client_count(adev);
+	if (count > 0) {
+		bus = "i2c";
+	} else {
+		count = acpi_spi_count_resources(adev);
+		if (count > 0)
+			bus = "spi";
+	}
 
-		if (!bus) {
-			dev_err(dev, "Did not find any buses for %s\n", acpi_ids[i].hid);
-			return;
-		}
+	fwnode = fwnode_handle_get(acpi_fwnode_handle(adev));
+	acpi_dev_put(adev);
 
-		if (!fwnode) {
-			dev_err(dev, "Could not get fwnode for %s\n", acpi_ids[i].hid);
-			return;
-		}
+	if (!bus) {
+		codec_err(cdc, "Did not find any buses for %s\n", acpi_ids[i].hid);
+		return;
+	}
 
-		/*
-		 * When available the cirrus,dev-index property is an accurate
-		 * count of the amps in a system and is used in preference to
-		 * the count of bus devices that can contain additional address
-		 * alias entries.
-		 */
-		count_devindex = fwnode_property_count_u32(fwnode, "cirrus,dev-index");
-		if (count_devindex > 0)
-			count = count_devindex;
+	if (!fwnode) {
+		codec_err(cdc, "Could not get fwnode for %s\n", acpi_ids[i].hid);
+		return;
+	}
 
-		match = devm_kasprintf(dev, GFP_KERNEL, "-%%s:00-%s.%%d", acpi_ids[i].name);
-		if (!match)
-			return;
-		dev_info(dev, "Found %d %s on %s (%s)\n", count, acpi_ids[i].hid, bus, match);
-		comp_generic_fixup(cdc, action, bus, acpi_ids[i].hid, match, count);
+	/*
+	 * When available the cirrus,dev-index property is an accurate
+	 * count of the amps in a system and is used in preference to
+	 * the count of bus devices that can contain additional address
+	 * alias entries.
+	 */
+	count_devindex = fwnode_property_count_u32(fwnode, "cirrus,dev-index");
+	if (count_devindex > 0)
+		count = count_devindex;
 
-		break;
-	case HDA_FIXUP_ACT_FREE:
-		/*
-		 * Pass the action on to comp_generic_fixup() so that
-		 * hda_component_manager functions can be called in just once
-		 * place. In this context the bus, hid, match_str or count
-		 * values do not need to be calculated.
-		 */
-		comp_generic_fixup(cdc, action, NULL, NULL, NULL, 0);
-		break;
-	}
+	match = devm_kasprintf(dev, GFP_KERNEL, "-%%s:00-%s.%%d", acpi_ids[i].name);
+	if (!match)
+		return;
+	codec_info(cdc, "Found %d %s on %s (%s)\n", count, acpi_ids[i].hid, bus, match);
+	comp_generic_fixup(cdc, HDA_FIXUP_ACT_PRE_PROBE, bus, acpi_ids[i].hid, match, count);
 }
 
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
@@ -6976,9 +6971,7 @@ static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fix
 	 * The same SSID has been re-used in different hardware, they have
 	 * different codecs and the newer GA403U has a ALC285.
 	 */
-	if (cdc->core.vendor_id == 0x10ec0285)
-		cs35lxx_autodet_fixup(cdc, fix, action);
-	else
+	if (cdc->core.vendor_id != 0x10ec0285)
 		alc_fixup_inv_dmic(cdc, fix, action);
 }
 
@@ -7575,7 +7568,6 @@ enum {
 	ALC2XX_FIXUP_HEADSET_MIC,
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 	ALC294_FIXUP_CS35L41_I2C_2,
-	ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED,
 	ALC256_FIXUP_ACER_SFG16_MICMUTE_LED,
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
@@ -7588,7 +7580,6 @@ enum {
 	ALC256_FIXUP_CHROME_BOOK,
 	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
-	ALCXXX_FIXUP_CS35LXX,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9842,12 +9833,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
 	},
-	[ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35lxx_autodet_fixup,
-		.chained = true,
-		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
-	},
 	[ALC256_FIXUP_ACER_SFG16_MICMUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc256_fixup_acer_sfg16_micmute_led,
@@ -9887,8 +9872,6 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x1b, 0x03a11c30 },
 			{ }
 		},
-		.chained = true,
-		.chain_id = ALCXXX_FIXUP_CS35LXX
 	},
 	[ALC285_FIXUP_ASUS_GA403U_I2C_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9912,10 +9895,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_lenovo_ssid_17aa3820,
 	},
-	[ALCXXX_FIXUP_CS35LXX] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cs35lxx_autodet_fixup,
-	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10297,8 +10276,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c4f, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c50, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c51, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8c52, "HP EliteBook 1040 G11", ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8c53, "HP Elite x360 1040 2-in-1 G11", ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c52, "HP EliteBook 1040 G11", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c53, "HP Elite x360 1040 2-in-1 G11", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c66, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c67, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c68, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10331,17 +10310,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d08, "HP EliteBook 1045 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 1040 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite x360 1040 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 830 13 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite x360 830 13 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 840 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 840 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 860 16 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
@@ -10421,14 +10389,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
-	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALCXXX_FIXUP_CS35LXX),
-	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
@@ -11620,6 +11585,13 @@ static int patch_alc269(struct hda_codec *codec)
 	snd_hda_pick_pin_fixup(codec, alc269_fallback_pin_fixup_tbl, alc269_fixups, false);
 	snd_hda_pick_fixup(codec, NULL,	alc269_fixup_vendor_tbl,
 			   alc269_fixups);
+
+	/*
+	 * Check whether ACPI describes companion amplifiers that require
+	 * component binding
+	 */
+	find_cirrus_companion_amps(codec);
+
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
-- 
2.43.0


