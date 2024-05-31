Return-Path: <linux-kernel+bounces-196472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8398D5CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B51F21531
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC17E14F9EF;
	Fri, 31 May 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="soJ2cCCU"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB314F9DB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144326; cv=none; b=IQq4pI77DalOostTA+ZAMufK32+3IlZ0eU85NXBDTpjhV9M9o7/zypXc7rZoHQPHE4aYUUlkz1qaWnvOyLrlPgclyrByz09DdxAvNkufjl9n2zBxODxWW8OhH9qDZ3HsqeXurdjf/ohczHYLlTcgIls8UsK5rrHJcibTDxxbti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144326; c=relaxed/simple;
	bh=x58qvahiLWJ9l42qtXAob9nZ9sSWGTIY+wsTwkiQ6Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqtjSdzOUlzCcnQfHuFfal6lyQzkSd6Gxt01RitMAP9T0hBesQFAElVnWXlOM4AYfvVYslR8t+H9wA1cTbiyA2zvM9pbnuKf0gv9uaUUiGyKpMGoKD28ZrinE+7/ZnQuTYpZRE73MRZwLYeaA2ZY+9IWhCACE0wL1treGs3OvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=soJ2cCCU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: cl@gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717144322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHgLHUhxCEeWxCNJSXHptpDk0n+7D3OisdJ7k6oe/I0=;
	b=soJ2cCCUVPJxQoiCy/lPzeERw1gF34QVlNZzGq+cIC/9svcXTzgyuArdQ4wWeyQ8WPCD1B
	fH83u9/bQNfenATiqU1AT5HQ87YSBVl64atkNJ6aLKw84sNpYBERWwdvkfYNyKu7we4xfh
	17w/oYT+wOiNx4PQwdHcyxUmt1owLls=
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <dc7181fc-5b16-46f1-a267-0eb5781f692a@linux.dev>
Date: Fri, 31 May 2024 16:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] slab: check the return value of
 check_bytes_and_report()
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
 <20240528-b4-slab-debug-v1-1-8694ef4802df@linux.dev>
 <4e4d45b5-c684-2d93-49d2-b179a088c2d5@gentwo.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <4e4d45b5-c684-2d93-49d2-b179a088c2d5@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/30 23:20, Christoph Lameter (Ampere) wrote:
> On Tue, 28 May 2024, Chengming Zhou wrote:
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 0809760cf789..de57512734ac 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1324,9 +1324,10 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>>         }
>>     } else {
>>         if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>> -            check_bytes_and_report(s, slab, p, "Alignment padding",
>> +            if (!check_bytes_and_report(s, slab, p, "Alignment padding",
>>                 endobject, POISON_INUSE,
>> -                s->inuse - s->object_size);
>> +                s->inuse - s->object_size))
>> +                return 0;
>>         }
>>     }
> 
> This change means we will then skip the rest of the checks in check_object() such as the poison check.

Yeah, only when this padding checking failed.

Now, we always abort checking and return 0 when the first checking error happens,
such as redzones checking above.

Thanks.

