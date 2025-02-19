Return-Path: <linux-kernel+bounces-522024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A58A3C500
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123863A7F10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4D1FDA9D;
	Wed, 19 Feb 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dpJr42FC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A831FA267
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982432; cv=none; b=JhvF9hc1+ZxhgBNtREJKJzHiHEipLMeamac8jDYYH19/muupGe1JjqzJpUB4lBwINE5UUPDHig2eA2R4bRwRThZw6Vu1FS071jXOOV2+m23QLNaFB6UqMAK+fThl/MaIjxZ1cSNVJ+GLndXLw6Vg04SgtzL/8Rp5OCHkNOGzZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982432; c=relaxed/simple;
	bh=fY7kQvrXBSicPzpDTSxsGdCK4jMtvwuoyE7YHeUdqBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CsDLEbHs7f6vyUd+zbiqe+NSY5qIXBW98q/iqv/61gnjG8f/uTRECa/HVveQcTbkvej+xMYVIpFBZiBxW0eX+zV0q9AtIAmqlTyIL6W3rh6VjCImfkI8z70Hn1K7qJRVdIh/bkt/Lt7Bar1rx7cbLnGPed8AoeQnwWaYhK4LzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dpJr42FC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFu336022079;
	Wed, 19 Feb 2025 10:26:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Liiu3C5LRMrFCCEl8pUDANPi+XZvIfaCdvYtbsdrqKk=; b=
	dpJr42FCZd7BDgIuR+wHQmWTLY1Sxz6A5PDCVDHri8zmvMFP6SxcxKnIdNQmJ5yX
	z6aUsElyGLbS5jYioRlmHuEXB/MHnZSIAbosHyrpAa9CzzJMLw810Jk1LrjWimIa
	O9oH8nTmOjmiZALKD0p81Y3nWCfRdO+pd84BaiVTaXal1Vg6/ChSOLQ4Hgo/YU4r
	4LrAlIrULVfbOq14KCriI3+mFk9pshv31MANHfHjgj0LHu3foPNIp/IWGWsHBYfm
	+jLEB51lH3TMqGtw83Vs929/BS7LuQ5gnKg554fJUQq+Un6w0FpvhNhYyh6SWpH1
	cQwTWh0uYMzkhwHaahakQg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44wjcag36b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:26:56 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 16:26:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 16:26:55 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 24D3D82025A;
	Wed, 19 Feb 2025 16:26:55 +0000 (UTC)
Message-ID: <8d15d138-658c-4083-885b-62495023bb9a@opensource.cirrus.com>
Date: Wed, 19 Feb 2025 16:26:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "Mark
 Brown" <broonie@kernel.org>
CC: Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
 <e93d1b72-43da-4e96-9523-e1bbf3853031@opensource.cirrus.com>
 <1e251815-5d58-436b-9120-e88f75a7ecaa@sirena.org.uk>
 <20250213161059-a4c53711-fdf6-480c-af49-f9f36227ba42@linutronix.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250213161059-a4c53711-fdf6-480c-af49-f9f36227ba42@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aplICTZV c=1 sm=1 tr=0 ts=67b60650 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=jBZ0p1ap1sntT-lPAfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DBGSOnuPSOOY7aoIsPZDKJuIlufE9EzX
X-Proofpoint-GUID: DBGSOnuPSOOY7aoIsPZDKJuIlufE9EzX
X-Proofpoint-Spam-Reason: safe

On 13/02/2025 3:16 pm, Thomas Weißschuh wrote:
> On Thu, Feb 13, 2025 at 03:06:59PM +0000, Mark Brown wrote:
>> On Thu, Feb 13, 2025 at 02:28:06PM +0000, Richard Fitzgerald wrote:
>>> On 11/02/2025 5:21 pm, Richard Fitzgerald wrote:
>>
>>>>> Not tested on real hardware.
>>>>> This came up while porting kunit to mips64.
>>>>> Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by
>>
>>> I would say that is a bug in mips64 that should be fixed in mips64.
>>> It is not reasonable to expect generic drivers to have special cases for
>>> platforms that don't handle GFP_DMA.
> 
> Indeed, I did that, too.
> 
>> What specifically is the issue?  If it's a build time issue I'd
>> definitely agree that we should just be able to assume that platforms at
>> least build.  IIRC there is a Kconfig you can depend on for DMA but it
>> seems more trouble than it's worth to fix all users.
> 
> More details in [0], It's only a runtime issue.
> 
> I'm still wondering how all the on-stack buffers used with regmap_raw_read()
> and regmap_raw_write() by cs_dsp are satisfying the DMA requirements.
> 
There are 3 suspicious regmap_raw_read(). The others are all integers,
which are guaranteed not to cross a page boundary.

However, it looks like it might be safe to remove the GFP_DMA flags
now. regmap_raw_read() calls spi_write_then_read() which specifically
says that the buffers do not need to be DMA-safe and internally uses a
DMA-safe buffer. regmap_raw_write() uses either a temporary physically
contiguous buffer or GFP_DMA buffer (the implementation is terrifyingly
complex so it's difficult to determine exactly what it does).

(Some older systems could only use certain special memory areas for DMA
but we haven't seen any of those used with cs_dsp.)


> [0] https://lore.kernel.org/lkml/20250212-kunit-mips-v1-1-eb49c9d76615@linutronix.de/


