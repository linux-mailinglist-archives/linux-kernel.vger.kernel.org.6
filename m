Return-Path: <linux-kernel+bounces-198755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E78D7D03
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C311E1C20F54
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17053E31;
	Mon,  3 Jun 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FX5i62F8"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505E487BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401977; cv=none; b=Tr9c8yz0Dsg4Xodac2z+dvMYGb/Cifr3AbhRVtAkMR+Rrk85BWD3VK30qzPEIuHvSebprzpO8OPwyref+ydR/Z6H1q3076lQS/A7vpIAOk6leatauhRrepB14nCNUTw+KgM60DVkVkw67yWyPe5jun1ZV6UKkN/qigskYw5eqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401977; c=relaxed/simple;
	bh=MIF84jAmIzDg4Wz6TnMTbmZnsvgXm/Bb1xUd8UhNtFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jty/hQEF9YAPYRz6uqbcsLGediqVLs80UDaeZ/8njRYmPY8KUIt87bmF3fL0oXvGlICAy+3dHKgMsnECp0J8LwRy4ts6fzjIAai/1lIlaLMzNH0hnjxKQ7aN8M/Ih9hon/vmwaHwOKTJARyb2WEfipFeFBn5fzKw5VPeE+MbSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FX5i62F8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717401972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzieQJ4BnZ2O+k2Yxxz/okFmp27lskeHqZjRJMv514E=;
	b=FX5i62F8fKahV2di7nQq0WGf6YGLs0O3dOslRmI/ZZJUdPAXnv0U2qwRCaNzwIoGNu+ZAd
	UeXA0Zrs/2oNq8IYXl5OEO6CwiyTPMfzKHZNYM8Np5dg8QLl0TzjUhlVkW+aUfNkG682Kv
	eACi2gCe6KmweGHY9JCpbno0ZJzscWI=
X-Envelope-To: cl@gentwo.org
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
Message-ID: <0df9277d-6f10-4af6-abd7-50a275489a72@linux.dev>
Date: Mon, 3 Jun 2024 16:05:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] slab: check the return value of
 check_bytes_and_report()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
 <20240528-b4-slab-debug-v1-1-8694ef4802df@linux.dev>
 <4e4d45b5-c684-2d93-49d2-b179a088c2d5@gentwo.org>
 <dc7181fc-5b16-46f1-a267-0eb5781f692a@linux.dev>
 <2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/3 15:46, Vlastimil Babka wrote:
> On 5/31/24 10:31 AM, Chengming Zhou wrote:
>> On 2024/5/30 23:20, Christoph Lameter (Ampere) wrote:
>>> On Tue, 28 May 2024, Chengming Zhou wrote:
>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 0809760cf789..de57512734ac 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -1324,9 +1324,10 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>>>>         }
>>>>     } else {
>>>>         if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>>>> -            check_bytes_and_report(s, slab, p, "Alignment padding",
>>>> +            if (!check_bytes_and_report(s, slab, p, "Alignment padding",
>>>>                 endobject, POISON_INUSE,
>>>> -                s->inuse - s->object_size);
>>>> +                s->inuse - s->object_size))
>>>> +                return 0;
>>>>         }
>>>>     }
>>>
>>> This change means we will then skip the rest of the checks in check_object() such as the poison check.
>>
>> Yeah, only when this padding checking failed.
>>
>> Now, we always abort checking and return 0 when the first checking error happens,
>> such as redzones checking above.
> 
> Yes your patch will make it consistent. But IMHO it would be better to do
> all the checks without skipping, report their specific error findings in
> check_bytes_and_report() but not print_trailer(). Once all checks were done,
> if any found an error, print the trailer once from check_object(). Thoughts?

Ok, it's feasible, will change to this.

> 
>> Thanks.
> 

