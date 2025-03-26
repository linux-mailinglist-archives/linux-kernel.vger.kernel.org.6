Return-Path: <linux-kernel+bounces-576677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90250A712F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D166189AA80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9301A3172;
	Wed, 26 Mar 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aUkLl7+h"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0E1862BB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978601; cv=none; b=cA6KlMS8hyChpjr4Mj3NfeWLyM+QkOMti3uCRNcaXnXh2NLmGp683KGhNMqeJjTTWkjqRWBK7fgmfIiVZ4A6azifBUTzYD/Pp2FUuwrBmVsTg5vrt6B3IcmZ7YfMOKhnKMcXQYIiILYytxh5b3W/e2xWvP6EKy7O+C5rX3ZqLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978601; c=relaxed/simple;
	bh=UmuNGhXyzS0bvxy9u1JJ5f2Rt/zKH8lNNhSRKgiDkK0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=gi7J6Le0xvIjBquDPY2OLDn5wPCEH1qGHlTVA45Sb5WGSO8Dk/aFR6Qbof2joJVPwLX+GfMa2m/UeIkZb4JCyAcTK3RE135DdZ5G4zblqtecOG01pAo2MnQ7nC312FKYltKSkN7NHv8jupFMsm4E76qzm/haowDP01BZN+vEyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aUkLl7+h; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52Q8h6hq1486280
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 03:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742978586;
	bh=Qr9W6z+JJYeihhasB/vZ/Hf84PDMhGoU60JFUmJ8jLk=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=aUkLl7+hgek4R5Lmjo/k63gKCPuuSJmWBvVTvJLsadv3j8WjXMYvy+KN+dDFPqIEx
	 EuU6bJvRJOi2mxTIawGPGLnKr/Xit9cSHeo4XPP2i7XmdRCSJSeEdhJC6im/BmkOjY
	 6pm0ce5DOIGUwb0Om0TDRwzXN8gEHwKcUDnRy8wY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52Q8h6iT010985
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 03:43:06 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 03:43:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 03:43:05 -0500
Received: from [172.24.227.40] (pratham-workstation-pc.dhcp.ti.com [172.24.227.40])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52Q8h3Pq022655;
	Wed, 26 Mar 2025 03:43:04 -0500
Message-ID: <41fd2bb3-7115-42c3-8ee5-e8e9e54fa86b@ti.com>
Date: Wed, 26 Mar 2025 14:13:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: scatterlist: Fix sg_split_phys to preserve original
 scatterlist offsets
From: T Pratham <t-pratham@ti.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Jens Axboe <axboe@kernel.dk>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, <linux-kernel@vger.kernel.org>
References: <20250319111437.1969903-1-t-pratham@ti.com>
 <20250319184605.809fc9ce3b169478102b9313@linux-foundation.org>
 <7647126a-5986-4a2c-9bb0-9efb0ff9c131@ti.com>
Content-Language: en-US
In-Reply-To: <7647126a-5986-4a2c-9bb0-9efb0ff9c131@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 20/03/25 10:28, T Pratham wrote:
> On 20/03/25 07:16, Andrew Morton wrote:
>> On Wed, 19 Mar 2025 16:44:38 +0530 T Pratham <t-pratham@ti.com> wrote:
>>
>>> The split_sg_phys function was incorrectly setting the offsets of all
>>> scatterlist entries (except the first) to 0. Only the first scatterlist
>>> entry's offset and length needs to be modified to account for the skip.
>>> Setting the rest entries' offsets to 0 could lead to incorrect data
>>> access.
>>>
>>> This patch removes the offending code, ensuring that the page offsets
>>> in the input scatterlist are preserved in the output scatterlist.
>> Is this merely from code inspection, or is this issues known to have
>> observable runtime effects?
>>
>> If the latter, please provide a complete description.
> Hi,
>
> I am using this function in a crypto driver that I'm currently
> developing (not yet sent to mailing list). During testing, it was
> observed that the output scatterlists (except the first one) contained
> incorrect garbage data.
>
> I narrowed this issue down to the call of sg_split(). Upon debugging
> inside this function, I found that this resetting of offset is the cause
> of the problem, causing the subsequent scatterlists to point to
> incorrect memory locations in a page. By removing this code, I am
> obtaining expected data in all the split output scatterlists. Thus, this
> was indeed causing observable runtime effects!
>
> Regards
> T Pratham <t-pratham@ti.com>

Hi Andrew,

Do you need the above details to be incorporated into the commit message
and be resent? Kindly let me know.

Regards
T Pratham <t-pratham@ti.com>

>>> ...
>>>
>>> --- a/lib/sg_split.c
>>> +++ b/lib/sg_split.c
>>> @@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
>>>  			if (!j) {
>>>  				out_sg->offset += split->skip_sg0;
>>>  				out_sg->length -= split->skip_sg0;
>>> -			} else {
>>> -				out_sg->offset = 0;
>>>  			}
>>>  			sg_dma_address(out_sg) = 0;
>>>  			sg_dma_len(out_sg) = 0;
>>> -- 
>>> 2.34.1

