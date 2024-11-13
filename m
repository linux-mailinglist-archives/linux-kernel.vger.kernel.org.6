Return-Path: <linux-kernel+bounces-407636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854879C7097
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4E6B28A97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3801DE3CA;
	Wed, 13 Nov 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QME9CyPb"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC6433CE;
	Wed, 13 Nov 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503452; cv=none; b=i+EQ+NYKDi31bYj6qqB5fIJ891ow4xSrArFGUo274X+zIw/ETG/ErQCoZ0m7r2e6kCj6V5sWFJoKNnXmEE23snI0yKSYOfqiM+j3vDmubxCaVy5aCIpfPO4J25YC2Neu4KBmXjZVMKjTZi1IPMlpFRaKi+di0eRL49UNs0Kv0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503452; c=relaxed/simple;
	bh=KdSwIyjCScMblkEb9rlJr5s3VHaxyxnbICAYrnRZuJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnLJOkeQdQw8CquGy8IgmxLEEr5d7hx0qv8my00QOC+tKm1WGws9WopiVuIi99p7ZjKRhywSA2DJSrD6TxPUat874+V9iY5olWUCAST8A6SYCGEKP0eYbFdyJEvv6v6n0/YqWWs+BeoC+kbUb7NQo0uL5UwLSWKYhHfQcNDdqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QME9CyPb; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD5stqU009840;
	Wed, 13 Nov 2024 07:10:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=c+MeybxwNsdzykpyV+
	1hIr/zg/Ov5gQlqxNpVVQZBCk=; b=QME9CyPb5KeBsAdpVVDGbmFPg5nC7lvCoh
	K4yZ2vx9WFN7wNpA+8fwRJgSiC+wZ5P3TGaZWnNat7+hwxDE1NsPU2hEFk6Ar0/D
	PRqasTSqxTXZ0RrBMCCv3ft3VASot7R9nWBxe/ihUYLbDhSr5DD64V/zuUU/PWIt
	k51b1/PDGOwJf25w3k+6LMCLl8877ou/MY+2Y9xokdBofciMYbAqrdvHRhIpu9RT
	1l7SOmvCziV6mH5CesVn+dRVawvMqXpbc29TcEMgY/TmUU1NKlS3ETlyEe6ku6XB
	xVySkgI9x4PlzeIi6q+BKTCkhbDPlnSjq/PVuKY7lkWUeiIU2Yhw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 42t613chfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 07:10:35 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 13:10:32 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 13 Nov 2024 13:10:32 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 7664D820257;
	Wed, 13 Nov 2024 13:10:32 +0000 (UTC)
Date: Wed, 13 Nov 2024 13:10:31 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: liujing <liujing@cmss.chinamobile.com>
CC: <david.rhodes@cirrus.com>, <rf@opensource.cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45:Increase the error checking returned by
 the function.
Message-ID: <ZzSlR1rXuNzb9axM@opensource.cirrus.com>
References: <20241113085756.2636-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241113085756.2636-1-liujing@cmss.chinamobile.com>
X-Proofpoint-ORIG-GUID: v8rXeXBW5VHI24MNFRkVl6qPBBAN6G3T
X-Proofpoint-GUID: v8rXeXBW5VHI24MNFRkVl6qPBBAN6G3T
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 13, 2024 at 04:57:56PM +0800, liujing wrote:
> In cs35l45_dsp_init(), it is necessary to check
> the return value of the wm_halo_init function.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
> index fa1d9d9151f9..c045c7c05947 100644
> --- a/sound/soc/codecs/cs35l45.c
> +++ b/sound/soc/codecs/cs35l45.c
> @@ -1365,7 +1365,10 @@ static int cs35l45_dsp_init(struct cs35l45_private *cs35l45)
>  	dsp->cs_dsp.lock_regions = 0xFFFFFFFF;
>  
>  	ret = wm_halo_init(dsp);
> -
> +	if (ret) {
> +		dev_err(cs35l45->dev, "wm_halo_init failed: %d\n", ret);
> +		return ret;
> +	}

Blank line should go here.

>  	regmap_multi_reg_write(cs35l45->regmap, cs35l45_fs_errata_patch,
>  						   ARRAY_SIZE(cs35l45_fs_errata_patch));
>  

The function is kinda weird, but the error check isn't per say
missing, in that there is a "return ret;" below the
regmap_multi_reg_write. If we are updating this it would make
sense to change that return into a "return 0;". But I would be
slightly nervous that the intention was to apply this errata
patch even on the error path, no clues in the commit messages.
David/Vlad you guys know what the intention was here?

Thanks,
Charles

