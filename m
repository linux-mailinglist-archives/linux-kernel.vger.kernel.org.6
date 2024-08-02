Return-Path: <linux-kernel+bounces-272474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EE945C9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72FE1C216ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3041DF699;
	Fri,  2 Aug 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jQSM/TUm"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB114AD38;
	Fri,  2 Aug 2024 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596184; cv=none; b=dV+cNo4RXLeMVmoFslFVhGqoNtdqbmWS+jqz3GiVC3T6de61ERwWLDoZQv3YseHaTNQxPHzNMifdTXLt3aYsooLtimsw68Vg3/hKxnv01wCpi2ka1HQUo+dmfzTc9SBlpWGNjnZo20ysetCGSeXc46ASqlvrQ4Klql7QjsYf2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596184; c=relaxed/simple;
	bh=XlqNgRT1sSw687vQQMAVbvrjuTBSqP0nwEva+txTRHE=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjsJefizVBDoXMWhMDxqfIHUrFxBrEwOr5OE9gmMNiOMgE9UubIy6CLj1QTf5I0+W+LfYFJZm7NNgkAAF6GEBkeuKnKevJmx/yP6YOT5GAVSl/EO4AImOjH7Nc17iNNA3PXzDk2Wpy2+yFlkmaRuA3lMkLjLam4HetdjKN943RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jQSM/TUm; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729mQjc018638;
	Fri, 2 Aug 2024 05:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=u9NQlEhURMaalyDIQrXPGM9GN2OyMf+qVlpdNFMIHCA=; b=
	jQSM/TUm6hrYMKOFiBLtQ0/pn6bM/v20wJCts+WYvBftH+4Tbhn+ZHFbq2IcWLRE
	FNlxGS/Fc+DlZweSLo/ftLjZsjjLvndqPZINGklMZMUMAedIL5qkwjWWBBrvQccq
	vazCgjW2ojIl83GiA5I1O2tLH3SvvfptzaLmNl9odfL9AhnOCwsnmYfrlCy9JTXu
	Fmnx+S7ASAci4JQx+vPbuHnxXXkJISApDgDZklBtSSWS67KYYEzwUsO+cDjStqjk
	Sx/buSIew7MXyIXDIJb+7gyPeiK9ZfTN/D/AaZSl66e4dhw2pWGBgU0KipsDyQnj
	SWIucsBub6qK4QTFvFmEsw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40rjdnrket-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 05:54:20 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 Aug 2024
 11:54:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 2 Aug 2024 11:54:18 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6D668820244;
	Fri,  2 Aug 2024 10:54:18 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240801151605.76347-1-simont@opensource.cirrus.com>
In-Reply-To: <20240801151605.76347-1-simont@opensource.cirrus.com>
Subject: RE: [PATCH] ALSA: hda/realtek: Add support for new HP G12 laptops
Date: Fri, 2 Aug 2024 11:54:18 +0100
Message-ID: <000a01dae4ca$52dfdb20$f89f9160$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQEN+yDiJqd8+9ETVIYDiI4g0Uo+crOtnSCA
X-Proofpoint-ORIG-GUID: Map1LWB69wA3Z2waveaq76N5NsC_4bgh
X-Proofpoint-GUID: Map1LWB69wA3Z2waveaq76N5NsC_4bgh
X-Proofpoint-Spam-Reason: safe

Hi Takashi,
We were thinking about the random kernel config builds overnight and
checking the bus header files the count functions don't properly define the
empty versions of the functions to avoid the need to #ifdef the code around
config options.

We'll fix that up and spin a v2
-Simon

> -----Original Message-----
> From: Simon Trimmer <simont@opensource.cirrus.com>
> Sent: Thursday, August 1, 2024 4:16 PM
> To: tiwai@suse.com
> Cc: linux-sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; patches@opensource.cirrus.com; Simon Trimmer
> <simont@opensource.cirrus.com>
> Subject: [PATCH] ALSA: hda/realtek: Add support for new HP G12 laptops
> 
> Some of these laptop models have quirk IDs that are identical but have
> different amplifier parts fitted, this difference is described in the
> ACPI information.
> 
> The solution introduced for this product family can derive the required
> component binding information from ACPI instead of hardcoding it,
> supports the new variants of the CS35L56 being used and has generalized
> naming that makes it applicable to other ALC+amp combinations.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---
>  sound/pci/hda/patch_realtek.c | 99
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 1645d21d422f..1a05c647f08c 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -11,15 +11,18 @@
>   */
> 
>  #include <linux/acpi.h>
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  #include <linux/dmi.h>
>  #include <linux/module.h>
> +#include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/leds.h>
>  #include <linux/ctype.h>
> +#include <linux/spi/spi.h>
>  #include <sound/core.h>
>  #include <sound/jack.h>
>  #include <sound/hda_codec.h>
> @@ -6856,6 +6859,86 @@ static void comp_generic_fixup(struct hda_codec
> *cdc, int action, const char *bu
>  	}
>  }
> 
> +static void cs35lxx_autodet_fixup(struct hda_codec *cdc,
> +				  const struct hda_fixup *fix,
> +				  int action)
> +{
> +	struct device *dev = hda_codec_dev(cdc);
> +	struct acpi_device *adev;
> +	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
> +	const char *bus = NULL;
> +	static const struct {
> +		const char *hid;
> +		const char *name;
> +	} acpi_ids[] = {{ "CSC3554", "cs35l54-hda" },
> +			{ "CSC3556", "cs35l56-hda" },
> +			{ "CSC3557", "cs35l57-hda" }};
> +	char *match;
> +	int i, count = 0, count_devindex = 0;
> +
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
> +		for (i = 0; i < ARRAY_SIZE(acpi_ids); ++i) {
> +			adev = acpi_dev_get_first_match_dev(acpi_ids[i].hid,
> NULL, -1);
> +			if (adev)
> +				break;
> +		}
> +		if (!adev) {
> +			dev_err(dev, "Failed to find ACPI entry for a Cirrus
> Amp\n");
> +			return;
> +		}
> +
> +		count = i2c_acpi_client_count(adev);
> +		if (count > 0) {
> +			bus = "i2c";
> +		} else {
> +			count = acpi_spi_count_resources(adev);
> +			if (count > 0)
> +				bus = "spi";
> +		}
> +
> +		fwnode = fwnode_handle_get(acpi_fwnode_handle(adev));
> +		acpi_dev_put(adev);
> +
> +		if (!bus) {
> +			dev_err(dev, "Did not find any buses for %s\n",
> acpi_ids[i].hid);
> +			return;
> +		}
> +
> +		if (!fwnode) {
> +			dev_err(dev, "Could not get fwnode for %s\n",
> acpi_ids[i].hid);
> +			return;
> +		}
> +
> +		/*
> +		 * When available the cirrus,dev-index property is an
accurate
> +		 * count of the amps in a system and is used in preference
to
> +		 * the count of bus devices that can contain additional
address
> +		 * alias entries.
> +		 */
> +		count_devindex = fwnode_property_count_u32(fwnode,
> "cirrus,dev-index");
> +		if (count_devindex > 0)
> +			count = count_devindex;
> +
> +		match = devm_kasprintf(dev, GFP_KERNEL, "-%%s:00-
> %s.%%d", acpi_ids[i].name);
> +		if (!match)
> +			return;
> +		dev_info(dev, "Found %d %s on %s (%s)\n", count,
> acpi_ids[i].hid, bus, match);
> +		comp_generic_fixup(cdc, action, bus, acpi_ids[i].hid, match,
> count);
> +
> +		break;
> +	case HDA_FIXUP_ACT_FREE:
> +		/*
> +		 * Pass the action on to comp_generic_fixup() so that
> +		 * hda_component_manager functions can be called in just
> once
> +		 * place. In this context the bus, hid, match_str or count
> +		 * values do not need to be calculated.
> +		 */
> +		comp_generic_fixup(cdc, action, NULL, NULL, NULL, 0);
> +		break;
> +	}
> +}
> +
>  static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct
> hda_fixup *fix, int action)
>  {
>  	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-
> hda.%d", 2);
> @@ -7528,6 +7611,7 @@ enum {
>  	ALC256_FIXUP_CHROME_BOOK,
>  	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
>  	ALC287_FIXUP_LENOVO_SSID_17AA3820,
> +	ALCXXX_FIXUP_CS35LXX,
>  };
> 
>  /* A special fixup for Lenovo C940 and Yoga Duet 7;
> @@ -9857,6 +9941,10 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc287_fixup_lenovo_ssid_17aa3820,
>  	},
> +	[ALCXXX_FIXUP_CS35LXX] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cs35lxx_autodet_fixup,
> +	},
>  };
> 
>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> @@ -10271,6 +10359,17 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite",
> ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite",
> ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16",
> ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d08, "HP EliteBook 1045 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 1040 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite x360 1040 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 830 13 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite x360 830 13 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 840 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 840 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 860 16 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12",
> ALCXXX_FIXUP_CS35LXX),
> +	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12",
> ALCXXX_FIXUP_CS35LXX),
>  	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA",
> ALC256_FIXUP_ASUS_MIC),
>  	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300",
> ALC282_FIXUP_ASUS_TX300),
>  	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE",
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> --
> 2.43.0
> 



