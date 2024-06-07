Return-Path: <linux-kernel+bounces-205426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A58FFB6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9348AB228E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31214EC7C;
	Fri,  7 Jun 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V+RV9tSV"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38F1CA8D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739425; cv=none; b=sS0yH0pHm+oyDCUvqrt3hQk/ETvyZxH3IhBbh5I2iRBc9yXMDAR9tpAWgUMeCBOwtT5266DtIx5XfyrpHMEwbWmYXXT8Sz0cNelsxKpStF6Swvt4kVcBXbgyqGO0kcHFZQc/sWLCfRvRdGYtV1jQP/1VoEnEgMH8+i6+msw/AgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739425; c=relaxed/simple;
	bh=TrOUUn/q8Q3b1nR0hdUKvloqx3BXOawnjX42zuQz2Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOb+4JtGUZZgmyg2gMu7ADGwAzH7A0m0k54BbuYtiv5chkh7N93fCF1Xmv38RlE4p0JjNXHLlja6Un2F7DWJsuEzFC4peGZ2P8o9mPXvbfEHLsyztsot9Q+ATcGVfqeJIdPku7RdWieoOfT7gP39z89Qz+BXCV1lVE+obLfsoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+RV9tSV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717739419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yyJ/LKuKfn3MmPsJ34/SLspsUgQV15PcfdP8ap5KjA=;
	b=V+RV9tSVZpFiZoFYBh7eTuWzhsUlmLUbyyiF4B+E8s8VHkoVTkTs6e0IhbtU4U31z9Kv4Z
	hvLkysSqH5MLEC0Awv+AgB7wpwNeVEx46zv0CCAnshGj6Ptz6/0VDbrMR7j1A4kmuuiGwO
	JyD1/55d+99OuHwT1Rdb9TWCiiXJ3DU=
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <b489301c-6322-4639-a6ee-a7887c3b927f@linux.dev>
Date: Fri, 7 Jun 2024 13:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240606165303.431215-1-flintglass@gmail.com>
 <CAJD7tkZ=o3AN+4Cj5UBJv6zcrjPFW5T1_53iHB2qtShRRhKhbQ@mail.gmail.com>
 <CAPpoddc5ge0myLfN8burL9fEUjc0oaB0C8Yc3_J923hd_O9u4A@mail.gmail.com>
 <CAJD7tkZPB8SSGgaobvFtQ5aOHjBzLt9DLxYT4j8k0sSyyLdURA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkZPB8SSGgaobvFtQ5aOHjBzLt9DLxYT4j8k0sSyyLdURA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/7 12:58, Yosry Ahmed wrote:
> On Thu, Jun 6, 2024 at 6:01 PM Takero Funaki <flintglass@gmail.com> wrote:
>>
>> 2024年6月7日(金) 2:46 Yosry Ahmed <yosryahmed@google.com>:
>>
>>>
>>> There are a lot of magic numbers in this patch, and it seems like it's
>>> all based on theory. I don't object to making the number of zpools
>>> dynamic in some way, but unless we do it in a data-driven way where we
>>> understand the implications, I think the added complexity and
>>> inconsistency is not justified.
>>>
>>> For example, 2*CPU zpools is an overkill and will cause a lot of
>>> fragmentation. We use 32 zpools right now for machines with 100s of
>>> CPUs. I know that you are keeping 32 as the limit, but why 2*CPUs if
>>> nr_cpus <= 16?
>>>
>>> Also, the limitation based on memory size assumes that zsmalloc is the
>>> only allocator used by zswap, which is unfortunately not the case.
>>>
>>> The current implementation using 32 zpools all the time is not
>>> perfect, and I did write a patch to make it at least be min(nr_cpus,
>>> 32), but it is simple and it works. Complexity should be justified.
>>>
>>
>> Thanks for your comments.
>> I agree the 2*cpu is too much. it was conservatively chosen assuming
>> 1/2 contention while all cores are accessing zswap. Much smaller
>> factor or non-linear scale as your comments in the main thread would
>> be better.
> 
> Chengming is currently experimenting with fixing the lock contention
> problem in zsmalloc by making the lock more granular. Based on the
> data he finds, we may be able to just drop the multiple zpools patch
> from zswap.

Hope so, not sure now, will test and compare one pool with multiple pools.

> 
> I'd wait for his findings before investing more into improving this.

Ok, I will get back with code and some testing data a few days later.

Thanks.

> 
>>
>> I found your patch from the main thread.
>> One point I'm afraid, this hashing will fail if nr_zswap_zpools is 1
>> or is not rounded to order of 2. hash_ptr crashes when bit is 0.
> 
> Yeah that patch was just for experimenting, I did not test it well.
> Thanks for taking a look.

