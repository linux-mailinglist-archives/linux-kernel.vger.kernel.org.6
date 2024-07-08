Return-Path: <linux-kernel+bounces-244530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D892A592
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437211C21E61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B31448EE;
	Mon,  8 Jul 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HZWfvlOS"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36476035;
	Mon,  8 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452249; cv=none; b=gONzHTlwhhpPCzXGaQbmkFzDFWcHs/r1uIuKIoLHzK7M5fyutBFBS9WRa+b2VVoevOYiWvrilM78tMYuuEayIN5bY1uAAQxwnr2iHcX1ueSGkb7k29lto6dQFdZY72B+lnBbyKUZVFHPjEv3TpI0Bas03yDLYrwoWvbJQ9hANac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452249; c=relaxed/simple;
	bh=pS3mpbaNBw30xlRpnmp6WAVvSlm7ajqz1TOyUWOrhJE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Q6tCHw9GQV7eTvsCXOrLA+nbcXndSBQKTB3kaT3FvC2pjZPKApGMkhjmHJcTVlGVmOo3DQql1qMjgn0u2d2vUIAYQvRVrg1+mBOB9tvV8o6w8q3SyAL0elolUzeOTE2uiq4BnJAKb5MJuF2JUbPg6iGAtJsPbW43A0/5nRENUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HZWfvlOS; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46870Jlo022463;
	Mon, 8 Jul 2024 10:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=gXyh6SBCSHWmEVsSuVqEsfwuVcZ5xlXoDBlCEAuKm0k=; b=
	HZWfvlOS8fiZYO5iyTUkvO4pzCb24yxS4BWxtgeglchz7st58Vy4gzqY6IKOMRop
	9OH1FJKROfyfvs+/XnAnVvg5cobH8inekwoiF2C6jn98Dl60xOAhDbb0Hm28SFOh
	dJNyjseAv77Ek4wTZfJpYMn3y6R4V2gt30g/yFKwgU/pIp2TvuK2qLXbfy1hlpZw
	kFFQQ4O7qSnkTf92WE+KcA/a3mFKniAaUFsvDoRkHm3tN4PpOlalBFt/ARs9mH36
	f+nGHHD9M4dgLljAoG50+ZqGSlaViLTPxc/wUA9TWlGqJICO20wA84pt0rA7ripu
	XdGwXzEJ6IRiOX8h7z8MfQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axsnej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 10:24:01 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:23:59 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Jul 2024 16:23:59 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A16F1820244;
	Mon,  8 Jul 2024 15:23:59 +0000 (UTC)
Message-ID: <eeb6ab14-6f8d-4f89-909c-f4a843576078@opensource.cirrus.com>
Date: Mon, 8 Jul 2024 16:23:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: cs_dsp: Use strnlen() on name fields in V1
 wmfw files
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20240708152052.390594-1-rf@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <20240708152052.390594-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5crc1PMYt0RFI2-CVrlkanzM1T8hdD39
X-Proofpoint-GUID: 5crc1PMYt0RFI2-CVrlkanzM1T8hdD39
X-Proofpoint-Spam-Reason: safe

On 08/07/2024 16:20, Richard Fitzgerald wrote:
> Use strnlen() instead of strlen() on the algorithm and coefficient name
> string arrays in V1 wmfw files.
> 
> In V1 wmfw files the name is a NUL-terminated string in a fixed-size
> array. cs_dsp should protect against overrunning the array if the NUL
> terminator is missing.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
> ---
>   drivers/firmware/cirrus/cs_dsp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
> index 16484ab9b09d..8a347b938406 100644
> --- a/drivers/firmware/cirrus/cs_dsp.c
> +++ b/drivers/firmware/cirrus/cs_dsp.c
> @@ -1183,4 +1183,4 @@ static int cs_dsp_coeff_parse_alg(struct cs_dsp *dsp,
>   		blk->id = le32_to_cpu(raw->id);
>   		blk->name = raw->name;
> -		blk->name_len = strlen(raw->name);
> +		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
>   		blk->ncoeff = le32_to_cpu(raw->ncoeff);
> @@ -1260,4 +1260,4 @@ static int cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp,
>   		blk->name = raw->name;
> -		blk->name_len = strlen(raw->name);
> +		blk->name_len = strnlen(raw->name, ARRAY_SIZE(raw->name));
>   		blk->ctl_type = le16_to_cpu(raw->ctl_type);
>   		blk->flags = le16_to_cpu(raw->flags);

This is the same patch as V1 but with a couple of conflicting
lines dropped from the context. You can ignore this V2 if you've got
V1 to apply cleanly.

Sorry for the confusion.

