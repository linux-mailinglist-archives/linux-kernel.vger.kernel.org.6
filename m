Return-Path: <linux-kernel+bounces-378545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D89AD216
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318CA1F28EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65831CDFD2;
	Wed, 23 Oct 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p5zTzkoN"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8A1CF5F3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702917; cv=none; b=EtaybJHr3sag/UXhEOAPoiqD7A2W1fQMYeN2S8jf7ZZqgnqWrJWdZDcRODfc7WVzwbjyg6qAS6W0bsn9zzGwrovtCkpk4kSa57dcpBKcj0hiVaiB1S02VAN1lBUbMWN5EzLcwoc2CXAfY9yLskpt87z6nRrSK/6+YYaMmkIBTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702917; c=relaxed/simple;
	bh=LQ9C43uacwyjeQXzWWnBX4lz6q4UeuejSFIAUR1BRPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MeBktkvlkt2lW73qsHaaT4MjB5TFitfltJ8gokAqbWxWbOemXXs+xPOVzlfO6v3ftxG1GDpPJBPvlKLFQwJkgSB7/f6ZF/VWqjd0MyqavamoWR0DM+Uz7957rcacQbdNQJpJiDtxx6gD1UFLQZEqrG2nK4Ggnsm1YJ+5xCx6/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p5zTzkoN; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NH1U9A091926;
	Wed, 23 Oct 2024 12:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729702890;
	bh=hXVh2GtKZd3nt1H1BlLl46ovaaf3eFuwFeLL9I9z0SE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=p5zTzkoNTy/x699l/cBFe/OcGFKXJO1aDCeIEQJ8LtFOpk0lKYBPkAP4Uu22EIPZ1
	 DKGQ4tlhwpxb4hr+hI/hKmZn9e6sO9l+tNEm32CJOYitUC1vzWIBxxhqMRZS+/sils
	 fOkUjkQlPVw9ufHaHAhOv8V3AbHNp7g3rHOA3tTQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NH1UtV013942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 12:01:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 12:01:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 12:01:30 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NH1UXE072625;
	Wed, 23 Oct 2024 12:01:30 -0500
Message-ID: <abc0dce9-b64f-451e-8315-ef9e39d0503b@ti.com>
Date: Wed, 23 Oct 2024 12:01:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kfifo: don't include dma-mapping.h in kfifo.h
To: Jiri Slaby <jirislaby@kernel.org>, Christoph Hellwig <hch@lst.de>,
        <jassisinghbrar@gmail.com>
CC: <stefani@seibold.net>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20241023055317.313234-1-hch@lst.de>
 <33b28b0a-b19d-459a-8db4-678df60cd799@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <33b28b0a-b19d-459a-8db4-678df60cd799@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/23/24 1:30 AM, Jiri Slaby wrote:
> On 23. 10. 24, 7:53, Christoph Hellwig wrote:
>> Nothing in kfifo.h directly needs dma-mapping.h, only two macros
>> use DMA_MAPPING_ERROR when actually instantiated.  Drop the
>> dma-mapping.h include to reduce include bloat.
>>
>> Add an explicity <linux/io.h> include to drivers/mailbox/omap-mailbox.c
>> as that file uses __raw_readl and __raw_writel through a complicated
>> include chain involving <linux/dma-mapping.h>
>>
>> Fixes: d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>
>> Changes since v1:
>>   - improve the commit log
>>
>>   drivers/mailbox/omap-mailbox.c | 1 +
>>   include/linux/kfifo.h          | 1 -
>>   samples/kfifo/dma-example.c    | 1 +
>>   3 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
>> index 6797770474a5..680243751d62 100644
>> --- a/drivers/mailbox/omap-mailbox.c
>> +++ b/drivers/mailbox/omap-mailbox.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/kfifo.h>
> 
> Funnily enough, this driver does not use kfifo since:
> commit 3f58c1f4206f37d0af4595a9046c76016334b301
> Author: Andrew Davis <afd@ti.com>
> Date:   Wed Apr 10 08:59:42 2024 -0500
> 
>      mailbox: omap: Remove kernel FIFO message queuing
> 
>>   #include <linux/err.h>
>> +#include <linux/io.h>
> 
> So this should have been revealed at that point (while removing kfifo.h in that commit too).
> 
> Perhaps Andrew can remove the include now?
> 

Yes, I'll send a patch dropping kfifo.h (unless you want to just do it
as part of this patch).

The addition of io.h is still correct here as we seem to have been
including it indirectly before, which is always a bit hacky.
So for this patch,

Acked-by: Andrew Davis <afd@ti.com>

> thanks,

