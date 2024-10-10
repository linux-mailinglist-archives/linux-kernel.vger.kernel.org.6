Return-Path: <linux-kernel+bounces-358727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D429982DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227C62823BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C81BDA84;
	Thu, 10 Oct 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y1Ii4+od"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805E1BC9EC;
	Thu, 10 Oct 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554053; cv=none; b=OzmjxsboKeBF2PqRPtbm1ios6HY9g5T3cM0a08/F6HHkszGPLQcRoJt9Svago6O++RovVWCRt+OYFwsXUjTVVOsbppZQfz5ob2sy2wrvP3UiGKRup0jZ2VczjUvO7jZWNGCwUZjVkPLEN1CUHE0Ib7Ufmbl4lHPRD9Vgi39TT5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554053; c=relaxed/simple;
	bh=NoHifkCcU/cNxUBhbvJudqLfDrHd9ys3JoFIBJofY8A=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxapajgJhKrnkl4AYZ/5+0ZU3Kg3Ft5+stupbOIWsXATvXsn6+CSJKvbvv4JTnLPViEx0+qFIFp+3LCzrIonLLH7sA+u3RzcCzmJagzc4uBCBuL78Lqx/lgYRBK3TZR889Ff4PRgKtm4LjQA9/HkId/XRk2e+wWI0sMj1At0WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y1Ii4+od; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A4VGqf000957;
	Thu, 10 Oct 2024 04:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/HIZ2Le5v6v0pGIyJ5OLSKxrh1VBKsYH584PmUXSvAc=; b=
	Y1Ii4+odW+ZeyZ+xUtlk9CqCi3kgqyROVEZ2tHrDNjrYmXAXZBk+fZ/ruYHXc3I3
	o8h1KkLlOcS4YDTubVD8weQsdxwvKP3lmD7VwXGeocNJGO+uG3PrChe3gzgobYB0
	emPyIjtN5bXeTRYHjlV5rU6aNALn5R+MvmfH/S0a2eHgM+og5WquMUHEb+nMS0Sz
	UzJ5v0eW7GKgMaij4cGWvNJvuAqMkwx9W7IXzgfkoxPALDlj+fsFP0lfZPGt4RjG
	V5P9y2V/+DLz+MJ1v6CkUb79rkkWMVzRNvVX2M3g+hV6b9GKFwGuIE7ioKB6EfyE
	lt8bouYDJa4xdhH0x/DKnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4232uy75av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 04:53:52 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 10:53:49 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 10 Oct 2024 10:53:49 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 96CAA820248;
	Thu, 10 Oct 2024 09:53:49 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: "'Luke D. Jones'" <luke@ljones.dev>, <tiwai@suse.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <rf@opensource.cirrus.com>, <foss@athaariq.my.id>,
        <sbinding@opensource.cirrus.com>, <kailang@realtek.com>,
        <perex@perex.cz>
References: <20241009205800.40570-1-luke@ljones.dev>
In-Reply-To: <20241009205800.40570-1-luke@ljones.dev>
Subject: RE: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
Date: Thu, 10 Oct 2024 10:53:49 +0100
Message-ID: <000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
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
Thread-Index: AQLaM5BF+fBgGyVU6uCoux+KLk9Da7CBiZjA
X-Proofpoint-GUID: NjKcoiJovRqF1hl6EMUPY4qW04beMScw
X-Proofpoint-ORIG-GUID: NjKcoiJovRqF1hl6EMUPY4qW04beMScw
X-Proofpoint-Spam-Reason: safe

On Wed, Oct 09, 2024, Luke D. Jones wrote:
> The GA605W laptop has almost the exact same codec setup as the GA403
> and so the same quirks apply to it.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  sound/pci/hda/patch_realtek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 41e1119877b3..19b0bae074b6 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = {
...
>  	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
ALC285_FIXUP_CS35L56_I2C_2),
> -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
ALC285_FIXUP_CS35L56_I2C_2),
> +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
...

Hi Luke,
Thanks!

The support code for the CS35L56 has changed a little in Takashi's branches
from what that patch was generated against and there is no longer an
existing quirk in the fixup table to trigger the component binding (but the
general idea seems reasonable to hook the fixup of the headset mic).
Cheers,
-Simon


