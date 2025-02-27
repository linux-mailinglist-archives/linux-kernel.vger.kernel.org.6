Return-Path: <linux-kernel+bounces-535452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0637A47302
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9BF3AEBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0041AF0CE;
	Thu, 27 Feb 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NWnE91Al"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5C15B102
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623427; cv=none; b=OA05uqQDICgtOCoExMObO8GaperVs5kYflvrRtasDxR284GvCUlTYYZQr9CDKwas4jZVbKYsQ2phN6LIic0QlYGyzFrbEs505Zf15HF6vkj0pRC9Vy4YjZTzoWXhvWjKeK8uDvPs3ZquZddp1fGFVFe4BuOpI//95Zd66jMzUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623427; c=relaxed/simple;
	bh=eFPNjbqeh7Zfliv2plXYbO6k4fkvgOaHAVfhYBRDa6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuArGaEVViq0PNpC4KSkfX0lRLeEsqI6zzYeE0bWwgf1JBs6/X8Otjh5S2vDTUq+Ig2QOOf3mAHHs2+dXqITsYoycrbkxaKhMBN274pP1V1fW3wPJja+84ULZ1xZhcuFEkAmFAJIjwxlWXaXsOyP7p6+mocUVZMa8epElCOE3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NWnE91Al; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7486a582-5143-4b4f-ae97-3a06089b630c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740623422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbOYPimeqO3tk023X9SrOfwdCZQmqLyKIJkaK9p9QJE=;
	b=NWnE91AlMZmfwO4cduShqKb8KSd5wIDIOmzp5Yqy9P8th8GFxZiVDZHkTJzPXwBVIuBsEb
	wYP06zvgyKCw3v1MDEGBDamqyMG7CqCVdmGguIvWvQv3Ap20oSgns5xuHmfl/fHi0yTBqy
	2hRf/OtuhD7fOAqrXQwl7NikHodjg2U=
Date: Thu, 27 Feb 2025 10:30:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: zswap: fix crypto_free_acomp() deadlock in
 zswap_cpu_comp_dead()
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "David S. Miller"
 <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-mm@kvack.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250226185625.2672936-1-yosry.ahmed@linux.dev>
 <20250226200016.GB3949421@google.com> <Z796VjPjno2PLTut@google.com>
 <20250226211628.GD3949421@google.com> <Z7-GaVJHC_1ynigx@google.com>
 <CAKEwX=O8zQj3Vj=2G6aCjK7e2DDs+VBUhRd25AefTdcvFOT-=A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=O8zQj3Vj=2G6aCjK7e2DDs+VBUhRd25AefTdcvFOT-=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/2/27 07:47, Nhat Pham wrote:
> On Wed, Feb 26, 2025 at 1:23 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
>>
>> On Wed, Feb 26, 2025 at 09:16:28PM +0000, Eric Biggers wrote:
>>> On Wed, Feb 26, 2025 at 08:32:22PM +0000, Yosry Ahmed wrote:
>>>> On Wed, Feb 26, 2025 at 08:00:16PM +0000, Eric Biggers wrote:
>>>>> On Wed, Feb 26, 2025 at 06:56:25PM +0000, Yosry Ahmed wrote:
>>>>>> Currently, zswap_cpu_comp_dead() calls crypto_free_acomp() while holding
>>>>>> the per-CPU acomp_ctx mutex. crypto_free_acomp() then holds scomp_lock
>>>>>> (through crypto_exit_scomp_ops_async()).
>>>>>>
>>>>>> On the other hand, crypto_alloc_acomp_node() holds the scomp_lock
>>>>>> (through crypto_scomp_init_tfm()), and then allocates memory.
>>>>>> If the allocation results in reclaim, we may attempt to hold the per-CPU
>>>>>> acomp_ctx mutex.
>>>>>
>>>>> The bug is in acomp.  crypto_free_acomp() should never have to wait for a memory
>>>>> allocation.  That is what needs to be fixed.
>>>>
>>>> crypto_free_acomp() does not explicitly wait for an allocation, but it
>>>> waits for scomp_lock (in crypto_exit_scomp_ops_async()), which may be
>>>> held while allocating memory from crypto_scomp_init_tfm().
>>>>
>>>> Are you suggesting that crypto_exit_scomp_ops_async() should not be
>>>> holding scomp_lock?
>>>
>>> I think the solution while keeping the bounce buffer in place would be to do
>>> what the patch
>>> https://lore.kernel.org/linux-crypto/Z6w7Pz8jBeqhijut@gondor.apana.org.au/ does,
>>> i.e. make the actual allocation and free happen outside the lock.
>>
>> I am fine with a solution like that if Herbert is fine with it. Although
>> as I mentioned, I think this patch is nice to have anyway.
>>
>>>
>>>>> But really the bounce buffering in acomp (which is what is causing this problem)
>>>>> should not exist at all.  There is really no practical use case for it; it's
>>>>> just there because of the Crypto API's insistence on shoehorning everything into
>>>>> scatterlists for no reason...
>>>>
>>>> I am assuming this about scomp_scratch logic, which is what we need to
>>>> hold the scomp_lock for, resulting in this problem.
>>>
>>> Yes.
>>>
>>>> If this is something that can be done right away I am fine with dropping
>>>> this patch for an alternative fix, although it may be nice to reduce the
>>>> lock critical section in zswap_cpu_comp_dead() to the bare minimum
>>>> anyway.
>>>
>>> Well, unfortunately the whole Crypto API philosophy of having a single interface
>>> for software and for hardware offload doesn't really work.  This is just yet
>>> another example of that; it's a problem caused by shoehorning software
>>> compression into an interface designed for hardware offload.  zcomp really
>>> should just use the compression libs directly (like most users of compression in
>>> the kernel already do), and have an alternate code path specifically for
>>> hardware offload (using acomp) for the few people who really want that.
>>
>> zcomp is for zram, zswap does not use it. If zswap is not going to use
>> the crypto API we'll want something like zcomp or maybe reuse zcomp
>> itself. That's a problem for another day :)
> 
> I'm actually thinking whether we should expose the zcomp API and use
> it for zswap. There are a couple of parameters for zstd I wanna play
> with, which zcomp/zram seems to already support, but not the crypto
> API (zstd level, dictionary, etc.).

Ah, agree! Actually I also think we should use the zcomp API in zswap,
if its API meets our requirements.

> 
> But yes, a different problem for another day :)

