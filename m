Return-Path: <linux-kernel+bounces-569149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2AA69F24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1406F887B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC021E0E08;
	Thu, 20 Mar 2025 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GQ0BaJS2"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0182F5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742446725; cv=none; b=BSIgWjXrIXKMcsYrNBQbsVEDn1v2tHI1l4w/1xdaeouWGs9RRTyjpde0EeC4Hww8ANYAxcGE5TlwsY+N0xeNMWo/9NLAzpT9oLSvMlS1MCQJT2soamT0JN7DO2vKNBkfh3TMTVxwO7UWSCGhmhY46OdwZ9+Lz/1u3tBPIoEyif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742446725; c=relaxed/simple;
	bh=/h8djwy6EnI+Il466BA2OX1O62oAIYaC/Xcp12suwQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MwySgNr90KDbcGfgdI6DvBV8e8Lpu4W727RUnKWbTK+xdevHumSbfPllTQOKhKZFDawGpL+EkTDG5GBAP1KNlqD2yEGMG/2NAP0LiLs3t2HdgplWdQ64CenRu4Vya3AXserZows4/PLipxsst0WSrhgjKGGYslfUJQkW6On+qgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GQ0BaJS2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K4wa5C3135152
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 19 Mar 2025 23:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742446716;
	bh=qnXnan2xmfHTVg81CV9ypXPZYrqoyXi0sRePOxOJPKA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GQ0BaJS2K0iCCaUY51VSYYh5rzLK10PF70JufEmJuuNGgrUnXxztrfQBmkI/HPQQ0
	 BDZEYwY2ZMlZhm7iJ0BVhGtPu3+yCKFh51E9HmYMBFbJh+Xzg4/CD3amNCAKWC/0v2
	 ++Romjos/ang1ZTl++Ch2wdOk+mJF7v8QambZNyI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K4wa7L084784;
	Wed, 19 Mar 2025 23:58:36 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 23:58:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 23:58:36 -0500
Received: from [172.24.227.40] (pratham-workstation-pc.dhcp.ti.com [172.24.227.40])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K4wXnC110445;
	Wed, 19 Mar 2025 23:58:34 -0500
Message-ID: <7647126a-5986-4a2c-9bb0-9efb0ff9c131@ti.com>
Date: Thu, 20 Mar 2025 10:28:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: scatterlist: Fix sg_split_phys to preserve original
 scatterlist offsets
To: Andrew Morton <akpm@linux-foundation.org>
CC: Jens Axboe <axboe@kernel.dk>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, <linux-kernel@vger.kernel.org>
References: <20250319111437.1969903-1-t-pratham@ti.com>
 <20250319184605.809fc9ce3b169478102b9313@linux-foundation.org>
Content-Language: en-US
From: T Pratham <t-pratham@ti.com>
In-Reply-To: <20250319184605.809fc9ce3b169478102b9313@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 20/03/25 07:16, Andrew Morton wrote:
> On Wed, 19 Mar 2025 16:44:38 +0530 T Pratham <t-pratham@ti.com> wrote:
>
>> The split_sg_phys function was incorrectly setting the offsets of all
>> scatterlist entries (except the first) to 0. Only the first scatterlist
>> entry's offset and length needs to be modified to account for the skip.
>> Setting the rest entries' offsets to 0 could lead to incorrect data
>> access.
>>
>> This patch removes the offending code, ensuring that the page offsets
>> in the input scatterlist are preserved in the output scatterlist.
> Is this merely from code inspection, or is this issues known to have
> observable runtime effects?
>
> If the latter, please provide a complete description.

Hi,

I am using this function in a crypto driver that I'm currently
developing (not yet sent to mailing list). During testing, it was
observed that the output scatterlists (except the first one) contained
incorrect garbage data.

I narrowed this issue down to the call of sg_split(). Upon debugging
inside this function, I found that this resetting of offset is the cause
of the problem, causing the subsequent scatterlists to point to
incorrect memory locations in a page. By removing this code, I am
obtaining expected data in all the split output scatterlists. Thus, this
was indeed causing observable runtime effects!

Regards
T Pratham <t-pratham@ti.com>

>> ...
>>
>> --- a/lib/sg_split.c
>> +++ b/lib/sg_split.c
>> @@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
>>  			if (!j) {
>>  				out_sg->offset += split->skip_sg0;
>>  				out_sg->length -= split->skip_sg0;
>> -			} else {
>> -				out_sg->offset = 0;
>>  			}
>>  			sg_dma_address(out_sg) = 0;
>>  			sg_dma_len(out_sg) = 0;
>> -- 
>> 2.34.1

