Return-Path: <linux-kernel+bounces-271490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000D944EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8301C1F2337E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC111A2C0C;
	Thu,  1 Aug 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HdUNd1PS"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF111EB4AC;
	Thu,  1 Aug 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525496; cv=none; b=Jl7urUOXXkOjd1UCmFBMdUnJnvLMovKmIb+4TA9PThfPtGY+7+B1GLIjpgDhWfZ3ARpj25l30/gaT1zUF0FCquX/4xWgGrNW2m70lMQgKzBMx1+FCqaTBWMwtSJeroItfZexZfJtH3jmHbe855ikjL/fNrZSXFQwM+kGCS8U07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525496; c=relaxed/simple;
	bh=FWVp8HMBYaZKLCorqfkr9VeFARih3v6eHDwyYW1O8ZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5/4fbATmZs3u06l1spOpeluOVhplCuMQNwzC7TqLJdCa4gLqr3xds7GX8Qsl6w9qfGJjQoylttMLVE06HMiOpd4IpcN7gdjOPT6HysHDIZNfaDLa/k633JAW8cavlJj0IQfb1Ud6E7SlOgCBZU9cGsA38F6Il9pQM5aEhAPjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HdUNd1PS; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4714r7S6022188;
	Thu, 1 Aug 2024 10:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=EmYIzwLForKzJx7Y
	XNCfis/wH2kFPFRDxiAOWpEYPQ0=; b=HdUNd1PSw48DxEQk5NVpmtW1us3T45G1
	lPtA6rUPqmwmE+x7qIju2HXVe0al9DQRwuQ+d6qXX+Bu4egTTyTeGepp8iLs9co2
	zBYBwIj3X4FJupqzoio6JmY7OD73krMk9PKMvK+nnSK4xd8FDjyJV0c8Ulqk5auV
	Ff1YiMzNlFNMV2dZJgJpmDhvhJPcaLol6NB/s3Vi0Lqu7BcyECjNDVTNf8wRY6Qb
	PSDs81cxpPDX2L4I+BLZ5tldjJ1nitCC2w0rzjTB43E1vK4sY73UhXqxJKw8AdWq
	gH4JS5DyHCauccQhaGGhYVNfIKK+MuHOt97m/iuyM6n5g0P7f5Q5eQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40qjw9afhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 10:16:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 16:16:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 1 Aug 2024 16:16:10 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DB44B820244;
	Thu,  1 Aug 2024 15:16:09 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add support for new HP G12 laptops
Date: Thu, 1 Aug 2024 15:16:05 +0000
Message-ID: <20240801151605.76347-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B48m9LocTL3nObv4mEEt_6GQQdJF_qQ5
X-Proofpoint-ORIG-GUID: B48m9LocTL3nObv4mEEt_6GQQdJF_qQ5
X-Proofpoint-Spam-Reason: safe

Some of these laptop models have quirk IDs that are identical but have
different amplifier parts fitted, this difference is described in the
ACPI information.

The solution introduced for this product family can derive the required
component binding information from ACPI instead of hardcoding it,
supports the new variants of the CS35L56 being used and has generalized
naming that makes it applicable to other ALC+amp combinations.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1645d21d422f..1a05c647f08c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11,15 +11,18 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/ctype.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/hda_codec.h>
@@ -6856,6 +6859,86 @@ static void comp_generic_fixup(struct hda_codec *cdc, int action, const char *bu
 	}
 }
 
+static void cs35lxx_autodet_fixup(struct hda_codec *cdc,
+				  const struct hda_fixup *fix,
+				  int action)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct acpi_device *adev;
+	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
+	const char *bus = NULL;
+	static const struct {
+		const char *hid;
+		const char *name;
+	} acpi_ids[] = {{ "CSC3554", "cs35l54-hda" },
+			{ "CSC3556", "cs35l56-hda" },
+			{ "CSC3557", "cs35l57-hda" }};
+	char *match;
+	int i, count = 0, count_devindex = 0;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		for (i = 0; i < ARRAY_SIZE(acpi_ids); ++i) {
+			adev = acpi_dev_get_first_match_dev(acpi_ids[i].hid, NULL, -1);
+			if (adev)
+				break;
+		}
+		if (!adev) {
+			dev_err(dev, "Failed to find ACPI entry for a Cirrus Amp\n");
+			return;
+		}
+
+		count = i2c_acpi_client_count(adev);
+		if (count > 0) {
+			bus = "i2c";
+		} else {
+			count = acpi_spi_count_resources(adev);
+			if (count > 0)
+				bus = "spi";
+		}
+
+		fwnode = fwnode_handle_get(acpi_fwnode_handle(adev));
+		acpi_dev_put(adev);
+
+		if (!bus) {
+			dev_err(dev, "Did not find any buses for %s\n", acpi_ids[i].hid);
+			return;
+		}
+
+		if (!fwnode) {
+			dev_err(dev, "Could not get fwnode for %s\n", acpi_ids[i].hid);
+			return;
+		}
+
+		/*
+		 * When available the cirrus,dev-index property is an accurate
+		 * count of the amps in a system and is used in preference to
+		 * the count of bus devices that can contain additional address
+		 * alias entries.
+		 */
+		count_devindex = fwnode_property_count_u32(fwnode, "cirrus,dev-index");
+		if (count_devindex > 0)
+			count = count_devindex;
+
+		match = devm_kasprintf(dev, GFP_KERNEL, "-%%s:00-%s.%%d", acpi_ids[i].name);
+		if (!match)
+			return;
+		dev_info(dev, "Found %d %s on %s (%s)\n", count, acpi_ids[i].hid, bus, match);
+		comp_generic_fixup(cdc, action, bus, acpi_ids[i].hid, match, count);
+
+		break;
+	case HDA_FIXUP_ACT_FREE:
+		/*
+		 * Pass the action on to comp_generic_fixup() so that
+		 * hda_component_manager functions can be called in just once
+		 * place. In this context the bus, hid, match_str or count
+		 * values do not need to be calculated.
+		 */
+		comp_generic_fixup(cdc, action, NULL, NULL, NULL, 0);
+		break;
+	}
+}
+
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
@@ -7528,6 +7611,7 @@ enum {
 	ALC256_FIXUP_CHROME_BOOK,
 	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
+	ALCXXX_FIXUP_CS35LXX,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9857,6 +9941,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_lenovo_ssid_17aa3820,
 	},
+	[ALCXXX_FIXUP_CS35LXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35lxx_autodet_fixup,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10271,6 +10359,17 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d08, "HP EliteBook 1045 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 1040 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite x360 1040 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 830 13 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite x360 830 13 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 840 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 840 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 860 16 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALCXXX_FIXUP_CS35LXX),
+	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALCXXX_FIXUP_CS35LXX),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.43.0


