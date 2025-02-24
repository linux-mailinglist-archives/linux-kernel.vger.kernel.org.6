Return-Path: <linux-kernel+bounces-529593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1EA42862
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18AC16607B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0B263C9F;
	Mon, 24 Feb 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BUNnVFHI"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD31917F1;
	Mon, 24 Feb 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416079; cv=none; b=Xe/d/waoJ6igtbxew5GIT4zkMVdQkCT8k6vpcL9rCtYjKDsur+5xSdPN9kiHluOIYnm9L/up53TERsxVsCJBhrJObSI/18F2W/Iv7jXPXlBEuz6FRL77kLF4FcJxDbZSr4cuwUKD48AjhPW04vQkp+XHeDSwHrqnYK2I2/6Pfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416079; c=relaxed/simple;
	bh=Y+DIUur2W80o9iTlTLPQPr/9J9Lr8rvP5f0TDTbi4qw=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hzQRivUf8lVte4Jv8NxnQA+ebbBnxVGmhO8IocBdeY/J4tB32Q+bRkK74kD5pDkPeHX33IHL4mFFuvRgybMiN+O4KcuqlJ65R+jN5RIpc53EM51j4HRh2N6lMfa5FbLcHgHxcTnXqgfYXvroWZxl10qTMldiW1fsr75fHrrESmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BUNnVFHI; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7jUb6002951;
	Mon, 24 Feb 2025 10:54:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=5OuOpiSbISPiLOHJ5OGL2EeTP76xBxd4YC+Zp3RJI5I=; b=
	BUNnVFHI/R8zGG2K3uDUEg6SGN4A9uFOfBYIqRKmbxEo7LfN66y+oJEjVYpCB3cB
	ecsigrpI0Gc2I+/h9wnRG1+1pCiE61tBzQaGtgC7g2R8SDZMkxXsfDrEKp3YgGs+
	InrP+8UI/yGKPR9d15qYMBxR56xo4PT7oHYK0gQSUaGYdzyH+GbA5el4kq94VnpT
	NVWaxGNQvCG4hbE1L0OY+ahFhogwYfQU1K/Shm3Dw9YS2k5jANbY7yCnutZC3X3T
	AEjnwCm3rlbIioU9QByVSK8oiSMbFg09tmgD7dnpE7bcjj6MrRz63wv7EnWjG1vc
	hSGPCV3Ax0iRWkim2kNycQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ycv5mnkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 10:54:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 16:53:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 16:53:59 +0000
Received: from LONNCK4V044 (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3F27A822560;
	Mon, 24 Feb 2025 16:53:59 +0000 (UTC)
From: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
To: 'Antheas Kapenekakis' <lkml@antheas.dev>, <linux-sound@vger.kernel.org>,
        <kailang@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <baojun.xu@ti.com>, <simont@opensource.cirrus.com>,
        'Kyle Gospodnetich'
	<me@kylegospodneti.ch>
References: <20250224161016.439696-1-lkml@antheas.dev> <20250224161016.439696-3-lkml@antheas.dev>
In-Reply-To: <20250224161016.439696-3-lkml@antheas.dev>
Subject: RE: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
Date: Mon, 24 Feb 2025 16:53:59 +0000
Message-ID: <004001db86dc$b32dec60$1989c520$@opensource.cirrus.com>
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
Thread-Index: AQK4C/lidhPLDnaStG469zOZiMBV9AIYzneVsYzWteA=
X-Authority-Analysis: v=2.4 cv=HoqMG1TS c=1 sm=1 tr=0 ts=67bca429 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=n9Sqmae0AAAA:8 a=iox4zFpeAAAA:8 a=sozttTNsAAAA:8 a=w1d2syhTAAAA:8
 a=rFI6naETVmhn8JkIUsQA:9 a=CjuIK1q_8ugA:10 a=UmAUUZEt6-oIqEbegvw9:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: Qk-SlthDU3OWytr9Rae7AIYM5voKxuZu
X-Proofpoint-ORIG-GUID: Qk-SlthDU3OWytr9Rae7AIYM5voKxuZu
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: Antheas Kapenekakis <lkml@antheas.dev>
> Sent: Monday, February 24, 2025 4:10 PM
> To: linux-sound@vger.kernel.org; kailang@realtek.com
> Cc: linux-kernel@vger.kernel.org; perex@perex.cz; tiwai@suse.com;
> baojun.xu@ti.com; simont@opensource.cirrus.com; Antheas Kapenekakis
> <lkml@antheas.dev>; Kyle Gospodnetich <me@kylegospodneti.ch>
> Subject: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
> 
> dsdt entry is the same as the original Ally, so borrow its quirks.
> Sound works in both speakers, headphones, and microphone. Whereas none
> worked before.

This laptop is in the list of laptops that I was planning to upstream, but I
am currently waiting on testing for this generation of laptops.
The Ally fixups do some extra stuff in the Realtek driver, which may or may
not apply to this laptop.  I believe the minimum fixup required for this
laptop is ALC287_FIXUP_CS35L41_I2C_2, but I don't have the laptop to test
that.
If possible, could you provide an acpidump of this system, so I can compare
against what I have?

It would be better to wait until we have tested this generation of laptops,
after which I can upstream the kernel patches to support them, as well as
the firmware.

Thanks,
Stefan

> 
> Tested-by: Kyle Gospodnetich <me@kylegospodneti.ch>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 1771e3b5618d..62c77db73df9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10699,6 +10699,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
{
>  	SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JI/JV/J3D",
> ALC245_FIXUP_CS35L41_SPI_2),
>  	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM",
> ALC245_FIXUP_CS35L41_SPI_2),
>  	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16",
> ALC289_FIXUP_ASUS_GA401),
> +	SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA",
> +ALC294_FIXUP_ASUS_ALLY),
>  	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE",
> ALC256_FIXUP_ASUS_AIO_GPIO2),
>  	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD",
> ALC274_FIXUP_ASUS_ZEN_AIO_27),
>  	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR",
> ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
> --
> 2.48.1
> 



