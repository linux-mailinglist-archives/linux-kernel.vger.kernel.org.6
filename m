Return-Path: <linux-kernel+bounces-246172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D777A92BE80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92643282189
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1119B5BB;
	Tue,  9 Jul 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IV16cnaW"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9B7F487;
	Tue,  9 Jul 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539276; cv=none; b=RHTuGKWm9uey7fyuIducRZI6akPohnxpaYE/iGaKvbZh4roeyhDUCCd4HvqYbEHZSpeUN/vQnWsSikWB/my+0v77agAA6Q5R+uiBm/pQfUvrhSkfZle4XSY2mTwLi8Rv4kTv1jv2A6HuhWgQzHkCku+qMkZm7HVpvABFNT2bvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539276; c=relaxed/simple;
	bh=FvWdonThAmJ/q75JTUddBwM9tvlSfcVWOIEazl2kr/I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4qsHE+6uC8QLXUq+8CDHkhwU8sbrOLNQdvQG1GyDN5BnNOJ6RdG4wrTWrMwO4UCUg0Z4z2GTP+3BTtdc1CsnnC85J60ewsPYkOfpzHW5raCIqIjTllCqo6nplH30hKVcp0V+2dkQdfMeRydwrj1HOdu8CVyRKQs4SAnpBbgeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IV16cnaW; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699T296013261;
	Tue, 9 Jul 2024 10:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=6Xe73+JU2eVQQ8xYXG
	t1Vn3w9CgNx65jHpc54wpvgKw=; b=IV16cnaWsSggxGT2sPvUjQSCnusIo7kGAe
	KmPur7U0780Xmq1vgMGMC8W2fQCWRqSkkoEd54VxA9lkyMUtw8FeyRSv5S9IEcEV
	P7OXD2QnC6dl3a05WFjyQXBvtdvWddhNxwlpl2L9cnQKN2Lo0yPUV2ByaCmMdLbn
	x8rkDgGD2SAGRdzo1UUUODr47n4+2PZSkFJ/GV49ILMvOXtQcFX3YdkDNXKQ630e
	TGW2/QLE8Psbfm9qnOJEcomZX3ceWuFNJh0IgNKaDlPnBScQGn0Rh2VEyJ7jYeT6
	rsAVzzH7K99CkuLyF59fCrj7YbIM9K/IUJ/48xjB873dc1C+8/XA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4072bjaumh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 10:34:16 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 16:33:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 16:33:57 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 644CE820244;
	Tue,  9 Jul 2024 15:33:57 +0000 (UTC)
Date: Tue, 9 Jul 2024 16:33:56 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
CC: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 3/4] firmware: cs_dsp: Merge wmfw format log message into
 INFO message
Message-ID: <Zo1YZHiE6WK3d8rm@opensource.cirrus.com>
References: <20240709145156.268074-1-rf@opensource.cirrus.com>
 <20240709145156.268074-4-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709145156.268074-4-rf@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: hRAaVAlz16HcPybssSt-C_PeHfg3_Xgs
X-Proofpoint-GUID: hRAaVAlz16HcPybssSt-C_PeHfg3_Xgs
X-Proofpoint-Spam-Reason: safe

On Tue, Jul 09, 2024 at 03:51:55PM +0100, Richard Fitzgerald wrote:
> Log the WMFW file format version with the INFO_TEST message.
> 
> The behaviour of firmware controls depends on the WMFW format version,
> so this is useful information to log for debugging. But there's no
> need to use a separate log line just for this value.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/firmware/cirrus/cs_dsp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
> index 1bc2e0b6d40b..141a6c9d6737 100644
> --- a/drivers/firmware/cirrus/cs_dsp.c
> +++ b/drivers/firmware/cirrus/cs_dsp.c
> @@ -1502,7 +1502,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
>  		goto out_fw;
>  	}
>  
> -	cs_dsp_info(dsp, "Firmware version: %d\n", header->ver);
>  	dsp->fw_ver = header->ver;
>  
>  	if (header->core != dsp->type) {
> @@ -1552,7 +1551,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
>  		case WMFW_INFO_TEXT:
>  		case WMFW_NAME_TEXT:
>  			region_name = "Info/Name";
> -			cs_dsp_info(dsp, "%s: %.*s\n", file,
> +			cs_dsp_info(dsp, "%s (rev %d): %.*s\n", file, dsp->fw_ver,
>  				    min(le32_to_cpu(region->len), 100), region->data);

Are we sure on this one? I don't think a WMFW is required to
include an INFO/NAME block so it is now possible for this to not
get printed. Granted I have not seen one that doesn't include
at least one of these blocks but it isn't required. I think I
would lean towards keening the separate print personally.

Thanks,
Charles

