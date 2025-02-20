Return-Path: <linux-kernel+bounces-523435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47EA3D6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC263A36D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B61F150D;
	Thu, 20 Feb 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GPUAQ44n"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BA1F12E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047361; cv=none; b=J8Zz52YTCNlgYDdAHaW6huopZgFlo56hbm0KiTOEEwpUoV0bNVlOdrTvOzu/NaXhB5p8vc1AoXUgDmivUJUnvvXfaeh/jsnQK9i8PI5kiTcM7UXSSDbL12k///KYVXNxMVlLh/rssJA9OyH/BU2hhe4ZhJqhsG+k5akysWwdQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047361; c=relaxed/simple;
	bh=ko9DcqyDLQkJPJKX4kJWpGbkYqXEe87j0rt841QCylk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n5xTyIGE9n9LGmzAo0iVYNFWi/zBnkRUaI2EV+u7KuK+v83qfdOA+Or9n240JEi1C/dqph7O5E6Kv417SMrNEoKL7hhOD9Ai33Xad93WNEqGxRNRCQg9VwQMz6zQC8rnRlb/EQT1sM+IyEzaRwUuQnsgccglOX8xjsjyRASygUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GPUAQ44n; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7ufM1005899;
	Thu, 20 Feb 2025 04:29:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=irRZdacmPzsDHfrVqHEPOuyV7W0VcOSBMWVOS+0+11A=; b=
	GPUAQ44ncAZOtKfUArqFJT1UrFypLst4fhbQRtQ0vHrGL/fw2/EIX/Q0B5moRTks
	wp485Jk+t1UyP0th1PB6zAl2W74k9JddQuUMZcGdA6rO6KWNRh1TX9C8gKSp5mqy
	CwKogxJtLRRwiBqmn75nhy5ktznNeN7nB2iZ0SHpl1ogX/dd6Kt3E8Cf3sENomYO
	ixeYw0RrZu0YfSb8GpqiFyBOOVM/6N7H6T/kM2XkEHUKMHUa3qA49NSAAGFzoCfs
	1A/CU1f4EN5aDaCJD0mjbTT6ojXqRKmTAcmWpaYkPHAl6gve6KUOmVvnH5aBaky4
	uGOgnZduqlbdQ2B/OJIFGg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44vyywv7kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 04:29:13 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 10:29:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 10:29:11 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B4FCF82025A;
	Thu, 20 Feb 2025 10:29:11 +0000 (UTC)
Message-ID: <89db7bf4-9297-4cfc-8b3d-f61315f6524e@opensource.cirrus.com>
Date: Thu, 20 Feb 2025 10:29:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: Mark Brown <broonie@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
 <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
 <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>
 <20250213161059-a4c53711-fdf6-480c-af49-f9f36227ba42@linutronix.de>
 <8d15d138-658c-4083-885b-62495023bb9a@opensource.cirrus.com>
 <Z7b7Ylk55D1LZ2WX@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <Z7b7Ylk55D1LZ2WX@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OJbC5dq8J7tgCxx4__xTz4wLxHNbjEtJ
X-Proofpoint-ORIG-GUID: OJbC5dq8J7tgCxx4__xTz4wLxHNbjEtJ
X-Authority-Analysis: v=2.4 cv=WOSFXmsR c=1 sm=1 tr=0 ts=67b703f9 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=ag1SF4gXAAAA:8 a=97uyb57JnHhYy19IygcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eKcMXjr5xVyoCAHiqxsq:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Reason: safe

On 20/02/2025 9:52 am, Charles Keepax wrote:
> On Wed, Feb 19, 2025 at 04:26:55PM +0000, Richard Fitzgerald wrote:
>> On 13/02/2025 3:16 pm, Thomas Weißschuh wrote:
>>> On Thu, Feb 13, 2025 at 03:06:59PM +0000, Mark Brown wrote:
>>>> On Thu, Feb 13, 2025 at 02:28:06PM +0000, Richard Fitzgerald wrote:
>>>>> On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:
>>>>
>>>>>>> Not tested on real hardware.
>>>>>>> This came up while porting kunit to mips64.
>>>>>>> Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by
>>>>
>>>>> I would say that is a bug in mips64 that should be fixed in mips64.
>>>>> It is not reasonable to expect generic drivers to have special cases for
>>>>> platforms that don't handle GFP_DMA.
>>>
>>> Indeed, I did that, too.
>>>
>>>> What specifically is the issue?  If it's a build time issue I'd
>>>> definitely agree that we should just be able to assume that platforms at
>>>> least build.  IIRC there is a Kconfig you can depend on for DMA but it
>>>> seems more trouble than it's worth to fix all users.
>>>
>>> More details in [0], It's only a runtime issue.
>>>
>>> I'm still wondering how all the on-stack buffers used with regmap_raw_read()
>>> and regmap_raw_write() by cs_dsp are satisfying the DMA requirements.
>>>
>> There are 3 suspicious regmap_raw_read(). The others are all integers,
>> which are guaranteed not to cross a page boundary.
>>
>> However, it looks like it might be safe to remove the GFP_DMA flags
>> now. regmap_raw_read() calls spi_write_then_read() which specifically
>> says that the buffers do not need to be DMA-safe and internally uses a
>> DMA-safe buffer. regmap_raw_write() uses either a temporary physically
>> contiguous buffer or GFP_DMA buffer (the implementation is terrifyingly
>> complex so it's difficult to determine exactly what it does).
>>
>> (Some older systems could only use certain special memory areas for DMA
>> but we haven't seen any of those used with cs_dsp.)
>>
> 
> We also need to consider what the I2C subsystem does, I have a
> vague memory of thinking the SPI system will attempt to remap
> buffers but I2C will just use them as is. cs_dsp will be used
> with both, although SPI is slightly more common for obvious
> reasons.
> 
> Thanks,
> Charles

For information here is the presentation given by Wolfram Sang
describing the DMA problem. This is the reason we used GFP_DMA buffers
in the cs_dsp code.

https://events19.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf


