Return-Path: <linux-kernel+bounces-288991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1079540EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD92865ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE307D08F;
	Fri, 16 Aug 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xw035Nh7"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C61763EE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785162; cv=none; b=SwlQsSpxbMBdAZ7NHlbdOefUVeOFf2HHbybKXQVGmflDTAodQygUTDKU1iQC76BcQRQ0hkscR/5RsHTbW0dqRdwsATvlD3weWfZEfPm1c+k23z9IZCwWwawkegEk+f5EIbC+oVNq4A+PCd3Nx1tqEimidx/l8owMvL9fYWuVm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785162; c=relaxed/simple;
	bh=wWHocHiVRaQDBAGZpYBq/QWdvrNFTKyzbY6+cB6VYx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwwZtu437WbVAqD90KS2pxWuJcGUfUZoH/TrLclKmiBLPFbEyGfXy0k/eh+FN7K/mG7JSPrxY+GC80D3fs7pEYjgYQ8ajpNoWBiy3KgHDLWkHmVpBcae4wt3Wwn3Zod316nmwOj9dCuLIcsN4z5ru2TuGK7p2aAn4P9bbFyprgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xw035Nh7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723785157; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SzPJYmstJwhog2+5yusTke5RmDuBUbggjzQg63D68/s=;
	b=Xw035Nh7mlfYbGp3PXB7DFzvlM6w0HJPUC+ZpCaxl6dxGS0TLoTDzEV5FBLGrnWGalF3h+HOWHOckx917NqFVyjGO4DVFO1W7oqt26WWRXiV3GuknpiKHVdqZ/JKF/ltkGP6AP5QQ0bZrfhfsg8EOmQzyxjkQzzcIpMffq77SE0=
Received: from 30.221.129.229(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCzH9pD_1723785156)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 13:12:37 +0800
Message-ID: <aa5ac560-1dcc-45b6-8e24-0e9cb59feb18@linux.alibaba.com>
Date: Fri, 16 Aug 2024 13:12:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
 <20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Andrew,

On 2024/8/16 13:02, Andrew Morton wrote:
> On Mon, 29 Jul 2024 09:58:02 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>>> For the fix, I think that we should still respect migrate_mode because
>>> users may prefer migration success over blocking.
>>>
>>> @@ -1492,11 +1492,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>>>    	return rc;
>>>    }
>>>    
>>> -static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
>>> +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
>>> +				  enum migrate_mode mode)
>>>    {
>>>    	int rc;
>>>    
>>> -	folio_lock(folio);
>>> +	if (mode == MIGRATE_ASYNC) {
>>> +		if (!folio_trylock(folio))
>>> +			return -EAGAIN;
>>> +	} else {
>>> +		folio_lock(folio);
>>> +	}
>>>    	rc = split_folio_to_list(folio, split_folios);
>>>    	folio_unlock(folio);
>>>    	if (!rc)
>>
>> Okay, yeah it looks better since it seems I missed the fallback
>> part in migrate_pages_sync().
>>
>> Let me send the next version to follow your advice, thanks.
> 
> The author seems to have disappeared.  Should we merge this as-is or
> does someone want to take a look at developing a v2?

I've replied your email last week, I'm not sure why it has not
been addressed?

https://lore.kernel.org/linux-mm/20240729021306.398286-1-hsiangkao@linux.alibaba.com/

The patch in your queue is already v2? No?

Thanks,
Gao Xiang

