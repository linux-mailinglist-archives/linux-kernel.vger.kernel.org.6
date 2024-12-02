Return-Path: <linux-kernel+bounces-427853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C19E06B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB36282E7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550820B7F7;
	Mon,  2 Dec 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PLqODWOF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23179481C4;
	Mon,  2 Dec 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152334; cv=none; b=fVVQEWrvvfH+Oco1gGmoWYOXTKcd/4oqf9q/2u3UFatsDw68ijuCRchkrlgUWGqcJEwoELUTzEp2KzZ+Ovi/CyxROfu78tIFaTXH65dczQrxz2XDVZBDtbLaZo6XDbjC7VcAR7GN2fUIsPQDSCK7REj9roxdU9qp4zJ0/BP+LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152334; c=relaxed/simple;
	bh=jw2fskYGUron3qj25KaqYQcHClRWEji01kCqyPVAHnQ=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/cYxNbooJf6Tt+DzED4akZPpvs4qG1/vGRGaGwiiz4yHbkldqY8bRzdEgEODn/SCXK24afKE01QZ6kcq78RzqJXTRkdVS1JNu54Eb91gSAbOv+UtDJfD1nGWBZvPO0iClAIjA/887MtxU6Jn345Ob5ij9dXgkjX20aPi10A49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PLqODWOF; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2FAhIE016220;
	Mon, 2 Dec 2024 09:11:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Nks5Vx2Hrhdfj3UbxVEHBLq+NEob4f8KJ225M6QG1aw=; b=
	PLqODWOFMc4B5b/bchPn07Xa7vlYIomaW+dGcX6NVE9xq9x+g2VkyErpJWJOM/Lc
	BqqlwiKBsCAQw6W+7tTZO3rwplAZ/AzHz0HLm21CwM+jErxFjL6RJcHT9PXjfqqy
	uFvTxmWnpGP+har/umFIJoBrAHgwGp116R49yxWON6UiKQvKL/eF0m0glTbfw5Le
	hur5dNRSQc48yNyZn2am6wOH44kJidotBTtO0w3WcqO2IfhBurCVh9nB/cRrvn6u
	PNTVNSKtQy2ize/ur3NZx2tKy5k24pDP5S6NC6rZevOz9CtCgFZWXkQ9Nzlh7IME
	kIEuPN1ygwHJhy2+2pK+ZA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43800nwwrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:11:57 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 2 Dec
 2024 15:11:56 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 2 Dec 2024 15:11:56 +0000
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E980B822542;
	Mon,  2 Dec 2024 15:11:55 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Chris Chiu' <chris.chiu@canonical.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <kailang@realtek.com>,
        <sbinding@opensource.cirrus.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241202144659.1553504-1-chris.chiu@canonical.com>
In-Reply-To: <20241202144659.1553504-1-chris.chiu@canonical.com>
Subject: RE: [PATCH] ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops
Date: Mon, 2 Dec 2024 15:11:55 +0000
Message-ID: <003a01db44cc$86afb1c0$940f1540$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQKILYej/XnujusHUFG8gFpSUi0H6LF5PROQ
X-Proofpoint-GUID: cpGoji_CFhX-cHeosU837bRT2zlr2O9Z
X-Proofpoint-ORIG-GUID: cpGoji_CFhX-cHeosU837bRT2zlr2O9Z
X-Proofpoint-Spam-Reason: safe

On Mon, 2 Dec 2024 14:47:00 +0000, Chris Chiu wrote:
> These HP laptops use Realtek HDA codec ALC3315 combined CS35L56
> Amplifiers. They need the quirk ALC285_FIXUP_HP_GPIO_LED to get
> the micmute LED working.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>

Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>

> ---
>  sound/pci/hda/patch_realtek.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2bf5c512ebaf..237e0c17083b 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10521,7 +10521,13 @@ static const struct hda_quirk
> alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite",
> ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite",
> ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16",
> ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firelfy 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA",
> ALC256_FIXUP_ASUS_MIC),
>  	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300",
> ALC282_FIXUP_ASUS_TX300),
>  	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE",
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> --
> 2.34.1
> 



