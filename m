Return-Path: <linux-kernel+bounces-198925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A18D7F39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C806C2858A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC58565F;
	Mon,  3 Jun 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k1bopM9b"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BD85656
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407658; cv=none; b=dyXvC2mzpbhkv0iID3AJeMxPN8cKsteVf1TyP7xF5Yv+GPzJ5fEj1/UXGaVwvJMeIGk3sih4xURU10EvO9oIWKAwfbfQPleEEQnq/FCDAe3i6l9NNrRirx2pDIkYDdrzJ/IgKTDnZtNFGtU3MHNexMLO37CcRn4E9Vpn2OpecgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407658; c=relaxed/simple;
	bh=7/PBozWCZM+mgFS0nmYdbE6Ut8V9eeR4o/kX9YbofnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMUSATPMgKjc4YhVTf4SvRNnUIFkIkE17hGvUtZmJ1+ulw93FtUXd+u5weXEbn/qFvtf0H8VPaeXrZUZwNJUaG10Q3oclrxrdBTNbWW6GxpTs3ptRRpdWEfG8miptv41pae6AWo7qOsHY1n1bMV1Feda10YLCa/VrRp48wnDwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k1bopM9b; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717407654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cepglRJZ1mK8dA8kcnRQrvV4Tmkczc4BSDaYLYlAPNA=;
	b=k1bopM9b1+hOyhZunW8ZQd2QhXGgzm8Jf48bOWur2dYlvOBN/r2gFwzuesMSdeYB8+i/bv
	mAFoSSRBwj+H47F5ZpUpydINRt/BSs5y19NIjKOHO+oJPVqnjlp2ClcInGXcbI1Z/QBRzB
	tVM+iWLaFV6nPnCet+3Qi6z76mO5xfM=
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <4c8406b7-f5eb-4907-8ee1-f997bdeb157c@linux.dev>
Date: Mon, 3 Jun 2024 17:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] slab: don't put freepointer outside of object if only
 orig_size
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
 <20240528-b4-slab-debug-v1-2-8694ef4802df@linux.dev>
 <5a09e348-9eeb-4502-9aa9-ef5da2f94218@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <5a09e348-9eeb-4502-9aa9-ef5da2f94218@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/3 17:25, Vlastimil Babka wrote:
> On 5/28/24 9:16 AM, Chengming Zhou wrote:
>> The commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
>> allocated kmalloc space than requested") will extend right redzone
>> when allocating for orig_size < object_size. So we can't overlay the
>> freepointer in the object space in this case.
>>
>> But the code looks like it forgot to check SLAB_RED_ZONE, since there
>> won't be extended right redzone if only orig_size enabled.
>>
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> 
> Seems OK.
> 
>> ---
>>  mm/slub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index de57512734ac..b92d9a557852 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5150,7 +5150,7 @@ static int calculate_sizes(struct kmem_cache *s)
>>  	 */
>>  	s->inuse = size;
>>  
>> -	if (slub_debug_orig_size(s) ||
>> +	if (((flags & SLAB_RED_ZONE) && slub_debug_orig_size(s)) ||
>>  	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
>>  	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
> 
> Should we consolidate the two cases with flags & SLAB_RED_ZONE?

Yes, we can.

> 
> Also below this is a comment that could also mention the slub_debug_orig_size().

Ok, will add.

Thanks.

> 
>>  	    s->ctor) {
>>
> 

