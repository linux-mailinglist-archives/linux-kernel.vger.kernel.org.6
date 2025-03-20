Return-Path: <linux-kernel+bounces-569861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B95A6A89E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B153F1883B90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36B2222D9;
	Thu, 20 Mar 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jDqR6+Nq"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09111EEBA;
	Thu, 20 Mar 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480693; cv=none; b=dsMP59V4HeRvlcnTn0TSTkl2pDwzwACEA9vP6bBPebv8nkIOexvlQgWRnX/dzAE4Y1FdsJzfBKvENtjR0x+4ZbqUrtcmObKPVvzDbs54GjptH7OvJn1K75R7MMpUzyzMjX9FQS/DEt35Ej9KjC4DGttmIy/j9kmOyYfMb77pe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480693; c=relaxed/simple;
	bh=XdW4PedjzFZG8ofPm1F1dYE00paWT5ST7BWQokDuoWM=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIwewVplQXfnJIYJ1pikBmhfiyuUWC2J+QSdYoJdILr3HW5ah4jsBeRsJM4+rDvGAahfGFJnG1tL3ZeHT3pXri7t7QGt0zMOM2NfmhJ7qbQ6umHYojElxIfRTIb41YN95AK9ZZAfBtGiznPcSB+xF+bEtm5ItwMuPwj40NUB7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jDqR6+Nq; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K4nWh2025692;
	Thu, 20 Mar 2025 09:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=258TAr1S7xL/7MlwKpAhSsCl4BlD4EFbhXEvTXUg94Q=; b=
	jDqR6+NqoIkgmS4ccMk1v+O8JmONHYMfbEHhY55R3oTNemAXA/L1WdtVT/ZFbeCR
	zHFIYecQV/JioVjonzVvBM8SS8fg3EdKR+U3Kb3WA54OLhOvoRX/g1xTsfRKDem9
	o73rP4FpvBlQRAUvVYLVntOE2gKHhV8xUKP2AeuxYO+leH6jO2e/+L9JI/VWKgTW
	vAoxZQx98V4QpzPaZQn2Udos1r4e9xZHrZVXfu0B94ycHIF+d+Nfu0UE2S0BJ1vJ
	Jrez0V43tiAob1UAVcOHCM6A24LQ877HzzjVK6Cc1gNWnO4Vtb3DPLWc1PcF/qZs
	aCmUJF/DKJGIpGsHWG6vLw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45fhbt4dep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 09:24:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 14:24:35 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 14:24:35 +0000
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 46CDE82255A;
	Thu, 20 Mar 2025 14:24:35 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Chris Chiu' <chris.chiu@canonical.com>, <tiwai@suse.com>,
        <perex@perex.cz>
CC: <sbinding@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250320124908.529842-1-chris.chiu@canonical.com> <20250320124908.529842-2-chris.chiu@canonical.com>
In-Reply-To: <20250320124908.529842-2-chris.chiu@canonical.com>
Subject: RE: [PATCH 2/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
Date: Thu, 20 Mar 2025 14:24:35 +0000
Message-ID: <000501db99a3$ce20d9e0$6a628da0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQM45rK1/2SRt4Vpn3BohtDFLRVB1AFf8ORVsLZ5I+A=
X-Authority-Analysis: v=2.4 cv=a4Aw9VSF c=1 sm=1 tr=0 ts=67dc2525 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=DfNHnWVPAAAA:8 a=NHU5abs-bgiuSG24rwwA:9 a=QEXdDO2ut3YA:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: gJGMfyxMEHfKd_eo5Ke3339QucSsW1x1
X-Proofpoint-GUID: gJGMfyxMEHfKd_eo5Ke3339QucSsW1x1
X-Proofpoint-Spam-Reason: safe

On Thu, Mar 20, 2025 at 12:49=E2=80=AFPM Chris Chiu wrote
> More HP EliteBook with Realtek HDA codec ALC3247 with combined CS35L56
> Amplifiers need quirk ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.
>=20
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c
> index 30d4cd93dae1..eda406a4b52a 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10734,6 +10734,11 @@ static const struct hda_quirk =
alc269_fixup_tbl[]
> =3D {
>  	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
>  	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
> +	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12",

Just the last two are out of sorted order

> ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> --
> 2.34.1
>=20

-Simon


