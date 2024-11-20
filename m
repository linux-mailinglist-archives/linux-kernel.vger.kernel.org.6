Return-Path: <linux-kernel+bounces-415165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA239D3232
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2724B2446F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198893F9C5;
	Wed, 20 Nov 2024 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnG5Y3Ma"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76628691
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069932; cv=none; b=dKibN66Yqao8TCU50H3WxtFNOvmDpRIQdGuaPaCrTGKPNpm/+llr3cmpuIm5GkzeQvTqfnLaUl1BtWQceJw+qn1ILxdt2TzpOLgeBIy7PFRCRivGaraRabTMMhjx/Gazb57sYmDsU1BQju2UfgyAhYnD3llXQ1BfJ1RWYN2PZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069932; c=relaxed/simple;
	bh=upRDFDNn3e9sVjsx+si8HEybjpJVG1i9vaC3T3+gAAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMpSPc4POL3aw9HoxX47ApnsKv2AD7sGOQsXaL19qVKFWMLgDIE4Q6666UNKoUqU8M+02mgRaH/n1kaHdWzdlPn9QBeQwX4NBkTeux7f9/sHMoDZp7yCfT6QSfg6HcrmZb4xsOy9Yje3MQ5LhyW/trhaZ/ker70Wi6fFz5H5/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnG5Y3Ma; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78374b54-1a68-4dc1-a220-dcef30a338c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732069926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YpUv7rVcJFYRzzR3PZNYnI2fm9zbQhap8P3eqbO/jA=;
	b=UnG5Y3Ma0zxvODOk1WVsIt4vW/4aUWryiIWUbzxytKAqczBJ4qnd1iplphXbukQUOTD2K6
	TTXMzHT1kwgWNXkvZydlCA5X2SduFfYEwHTdJi0vUIBcb7ZsbRNixmmtdnjKcE2Xf3N52w
	Fm8c4UpKMC3sAfGcWn4z35tC3A+QVcw=
Date: Wed, 20 Nov 2024 10:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
To: Yosry Ahmed <yosryahmed@google.com>,
 "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
 "Gopal, Vinodh" <vinodh.gopal@intel.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
 <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
 <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
 <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com>
 <SJ0PR11MB56780456B6808A54954D9EC9C9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZiE3PeRF=9_-ySMr7rDogGQtG9aHuwfZvpMF3uPN6aJQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkZiE3PeRF=9_-ySMr7rDogGQtG9aHuwfZvpMF3uPN6aJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/11/20 07:44, Yosry Ahmed wrote:
> On Tue, Nov 19, 2024 at 2:35 PM Sridhar, Kanchana P
> <kanchana.p.sridhar@intel.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Yosry Ahmed <yosryahmed@google.com>
>>> Sent: Tuesday, November 19, 2024 11:51 AM
>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>>> Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
>>> <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
>>> kernel@vger.kernel.org; linux-mm@kvack.org; usamaarif642@gmail.com;
>>> ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
>>> Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
>>> <vinodh.gopal@intel.com>
>>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
>>> zswap_decompress().
>>>
>>> On Tue, Nov 19, 2024 at 11:42 AM Sridhar, Kanchana P
>>> <kanchana.p.sridhar@intel.com> wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Yosry Ahmed <yosryahmed@google.com>
>>>>> Sent: Tuesday, November 19, 2024 11:27 AM
>>>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>>>>> Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
>>>>> <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
>>>>> kernel@vger.kernel.org; linux-mm@kvack.org; usamaarif642@gmail.com;
>>>>> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
>>>>> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
>>>>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>>>>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
>>>>> zswap_decompress().
>>>>>
>>>>> On Tue, Nov 19, 2024 at 11:22 AM Sridhar, Kanchana P
>>>>> <kanchana.p.sridhar@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Yosry Ahmed <yosryahmed@google.com>
>>>>>>> Sent: Friday, November 15, 2024 1:49 PM
>>>>>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>>>>>>> Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
>>>>>>> <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
>>>>>>> kernel@vger.kernel.org; linux-mm@kvack.org;
>>> usamaarif642@gmail.com;
>>>>>>> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
>>>>>>> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
>>>>>>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh
>>> <vinodh.gopal@intel.com>
>>>>>>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
>>>>>>> zswap_decompress().
>>>>>>>
>>>>>>> On Fri, Nov 15, 2024 at 1:14 PM Sridhar, Kanchana P
>>>>>>> <kanchana.p.sridhar@intel.com> wrote:
>>>>>>>>
>>>>>>>> Hi Chengming,
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Chengming Zhou <chengming.zhou@linux.dev>
>>>>>>>>> Sent: Wednesday, November 13, 2024 11:24 PM
>>>>>>>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>;
>>> Johannes
>>>>>>> Weiner
>>>>>>>>> <hannes@cmpxchg.org>
>>>>>>>>> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
>>>>>>>>> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
>>>>>>>>> mm@kvack.org; usamaarif642@gmail.com;
>>> ryan.roberts@arm.com;
>>>>>>> Huang,
>>>>>>>>> Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
>>>>>>>>> foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>;
>>> Gopal,
>>>>>>> Vinodh
>>>>>>>>> <vinodh.gopal@intel.com>
>>>>>>>>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
>>>>>>>>> zswap_decompress().
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
>>>>>>>>>>
>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>> From: Johannes Weiner <hannes@cmpxchg.org>
>>>>>>>>>>> Sent: Wednesday, November 13, 2024 9:12 PM
>>>>>>>>>>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>>>>>>>>>>> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
>>>>>>>>>>> <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
>>> linux-
>>>>>>>>>>> mm@kvack.org; chengming.zhou@linux.dev;
>>>>>>> usamaarif642@gmail.com;
>>>>>>>>>>> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
>>>>>>>>>>> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali,
>>> Wajdi K
>>>>>>>>>>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh
>>>>> <vinodh.gopal@intel.com>
>>>>>>>>>>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory
>>> leak in
>>>>>>>>>>> zswap_decompress().
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana
>>> P
>>>>>>> wrote:
>>>>>>>>>>>> So my question was, can we prevent the migration to a
>>> different
>>>>> cpu
>>>>>>>>>>>> by relinquishing the mutex lock after this conditional
>>>>>>>>>>>
>>>>>>>>>>> Holding the mutex doesn't prevent preemption/migration.
>>>>>>>>>>
>>>>>>>>>> Sure, however, is this also applicable to holding the mutex of a
>>> per-
>>>>> cpu
>>>>>>>>>> structure obtained via raw_cpu_ptr()?
>>>>>>>>>
>>>>>>>>> Yes, unless you use migration_disable() or cpus_read_lock() to
>>> protect
>>>>>>>>> this section.
>>>>>>>>
>>>>>>>> Ok.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Would holding the mutex prevent the acomp_ctx of the cpu prior
>>> to
>>>>>>>>>> the migration (in the UAF scenario you described) from being
>>>>> deleted?
>>>>>>>>>
>>>>>>>>> No, cpu offline can kick in anytime to free the acomp_ctx->buffer.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> If holding the per-cpu acomp_ctx's mutex isn't sufficient to
>>> prevent
>>>>> the
>>>>>>>>>> UAF, I agree, we might need a way to prevent the acomp_ctx
>>> from
>>>>> being
>>>>>>>>>> deleted, e.g. with refcounts as you've suggested, or to not use
>>> the
>>>>>>>>>
>>>>>>>>> Right, refcount solution from Johannes is very good IMHO.
>>>>>>>>>
>>>>>>>>>> acomp_ctx at all for the check, instead use a boolean.
>>>>>>>>>
>>>>>>>>> But this is not enough to just avoid using acomp_ctx for the check,
>>>>>>>>> the usage of acomp_ctx inside the mutex is also UAF, since cpu
>>> offline
>>>>>>>>> can kick in anytime to free the acomp_ctx->buffer.
>>>>>>>>
>>>>>>>> I see. How would the refcounts work? Would this add latency to
>>> zswap
>>>>>>>> ops? In low memory situations, could the cpu offlining code over-ride
>>>>>>>> the refcounts?
>>>>>>>
>>>>>>> I think what Johannes meant is that the zswap compress/decompress
>>>>>>> paths grab a ref on the acomp_ctx before using it, and the CPU
>>>>>>> offlining code only drops the initial ref, and does not free the
>>>>>>> buffer directly. The buffer is only freed when the ref drops to zero.
>>>>>>>
>>>>>>> I am not familiar with CPU hotplug, would it be simpler if we have a
>>>>>>> wrapper like get_acomp_ctx() that disables migration or calls
>>>>>>> cpus_read_lock() before grabbing the per-CPU acomp_ctx? A similar
>>>>>>> wrapper, put_acompt_ctx() will be used after we are done using the
>>>>>>> acomp_ctx.
>>>>>>
>>>>>> Would it be sufficient to add a check for mutex_is_locked() in
>>>>>> zswap_cpu_comp_dead() and if this returns true, to exit without
>>> deleting
>>>>>> the acomp?
>>>>>
>>>>> I don't think this works. First of all, it's racy. It's possible the
>>>>> mutex gets locked after we check mutex_is_locked() but before we
>>>>> delete the acomp_ctx. Also, if we find that the mutex is locked, then
>>>>> we do nothing and essentially leak the memory.
>>>>
>>>> Yes, this would assume the cpu offlining code retries at some interval,
>>>> which could prevent the memory leak.
>>>
>>> I am not sure about that, but even so, it wouldn't handle the first
>>> scenario where the mutex gets locked after we check mutex_is_locked().
>>>
>>>>
>>>>>
>>>>> Second, and probably more important, this only checks if anyone is
>>>>> currently holding the mutex. What about tasks that may be sleeping
>>>>> waiting for the mutex to be unlocked? The mutex will be deleted from
>>>>> under them as well.
>>>>
>>>> Wouldn't this and the race described above, also be issues for the
>>>> refcount based approach?
>>>
>>> I don't think so, at least if implemented correctly. There are a lot
>>> of examples around the kernel that use RCU + refcounts for such use
>>> cases. I think there are also some examples in kernel docs.
>>>
>>> That being said, I am wondering if we can get away with something
>>> simpler like holding the cpus read lock or disabling migration as I
>>> suggested earlier, but I am not quite sure.
>>
>> Another idea to consider is how zsmalloc avoids this issue through
>> its use of the local_lock() on the per-cpu mapping area. This disables
>> preemption from zs_map_object() through zs_unmap_object().
>> Would changing the acomp_ctx's mutex to a local_lock solve the
>> problem?
> 
> This is similar to disabling migration as I suggested, but disabling
> preemption means that we cannot sleep, we spin on a lock instead.
> 
> In zswap_compress(), we send the compression request and may sleep
> waiting for it. We also make a non-atomic allocation later that may
> also sleep but that's less of a problem.
> 
> In zswap_decompress() we may also sleep, which is why we sometimes
> copy the data into acomp_ctx->buffer and unmap the handle to begin
> with.
> 
> So I don't think we can just replace the mutex with a lock.
> 
>>
>>>
>>>>
>>>> Also, I am wondering if the mutex design already handles cases where
>>>> tasks are sleeping, waiting for a mutex that disappears?
>>>
>>> I don't believe so. It doesn't make sense for someone to free a mutex
>>> while someone is waiting for it. How would the waiter know if the
>>> memory backing the mutex was freed?
>>
>> Thanks Yosry, all good points. There would need to be some sort of
>> arbiter (for e.g., the cpu offlining code) that would reschedule tasks
>> running on a cpu before shutting it down, which could address
>> this specific issue. I was thinking these are not problems unique to
>> zswap's per-cpu acomp_ctx->mutex wrt the offlining?
> 
> There are a few reasons why zswap has this problem and other code may
> not have it. For example the data structure is dynamically allocated
> and is freed during offlining, it wouldn't be a problem if it was
> static. Also the fact that we don't disable preemption when accessing
> the per-CPU data, as I mentioned earlier, which would prevent the CPU
> we are running on from going offline while we access the per-CPU data.
> 
> I think we should either:
> (a) Use refcounts.
> (b) Disable migration.
> (c) Hold the CPUs read lock.
> 
> I was hoping someone with more knowledge about CPU offlining would
> confirm (b) and (c) would work, but I am pretty confident they would.

+1, I also think (b) or (c) should work with my limited knowledge about
CPU offlining :-) And they seem simpler than refcounts implementation.

Thanks.

