Return-Path: <linux-kernel+bounces-259625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4BB9399B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18BC1C21A89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BE14A0A7;
	Tue, 23 Jul 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PITcwJ3v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C813C8F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716245; cv=none; b=oZp/D4RfXVwjZDzCOuh0AgiSEA8SMnSmirxS8wfjUc9C8us29GnHFcq0i8erze4mAspM/2baKeFo3lMtYOdRkGvdJ4OD5C5mQ56bCekvMp11Tb40qypSEoZJqgYmjhj+rHQipbDHtYDQUjBcmRviikKyWw32r13jwfBG0aU/CMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716245; c=relaxed/simple;
	bh=sAG0dFj1gQshlamUJIoFUzgwnmTSFyMBTs0DRiUb/wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T9QNTv7P43+OiGKwwIi7i0E/Nem1Wiyfc/Fb18YiF7FhivLba4xxwmdQ1w7TX0tcBi9esn9NULDSgKY/5GS1LPX6GoL2HGCJ3uY3RAnQ7xX2MvJ/CZPxrkH8+R+i2iZO3wMjEydw9K2YygHBCiauXyVx/FmlWy2go2Xi74tLrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PITcwJ3v; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721716243; x=1753252243;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=sAG0dFj1gQshlamUJIoFUzgwnmTSFyMBTs0DRiUb/wk=;
  b=PITcwJ3vyQhnVHRGkncmvMmGDIK/t1KO6G1oyGAWjFNPfP+4bPJS3aBV
   GbOQwHRI4mwByOoaavOmkj4/HrgKrUZyHrDIKGuObz1+iprVhkhyoGQw4
   7+jV2aJ7nTNdClCIVQQOGwcdVaHOk1pUUppRUHF6htoTVeCW6509OmFNH
   lHL5bQ3LEAqmaZzwyoBOXYQD+yxi/Qw8WImo1IEf8MjmCxYlJ0sT5OiHo
   5JUlaS9NHm7J6v4Umf36KOqXM9ztKI+odz4v6bU5ST6iePS7hB4ZK+16K
   +i3Mw59yMRnYcS3O2HOvUWiRQBPplUSyPX32e0iQ8gFT+KFK03tcuGMqN
   A==;
X-CSE-ConnectionGUID: rymTXpwSShqJisLxyVT7iA==
X-CSE-MsgGUID: Fm94PonXQ1uAnScm8bv7gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29982239"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29982239"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 23:30:43 -0700
X-CSE-ConnectionGUID: UWAmHK1JSWuLfP5VgIQokg==
X-CSE-MsgGUID: VNZ9pXNtSwiDPJb2HwOw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52062852"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 23:30:40 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  "Kalesh Singh" <kaleshsingh@google.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com> (Ryan Roberts's
	message of "Mon, 22 Jul 2024 10:54:35 +0100")
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
	<20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
	<ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
	<CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
	<b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
	<CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
	<874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
	<87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<43f73463-af42-4a00-8996-5f63bdf264a3@arm.com>
	<87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com>
Date: Tue, 23 Jul 2024 14:27:07 +0800
Message-ID: <87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 22/07/2024 09:49, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>=20
>>> On 22/07/2024 03:14, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
>>>>>> Chris Li <chrisl@kernel.org> writes:
>>>>>>
>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
>>>>>>>>
>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.robert=
s@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>>>>
>>>> [snip]
>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[ci-=
>order]);
>>>>>>>>>>
>>>>>>>>>> I find the transitions when you add and remove a cluster from the
>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood correctl=
y): It is added
>>>>>>>>>> to the list whenever there is at least one free swap entry if no=
t already on the
>>>>>>>>>> list. But you take it off the list when assigning it as the curr=
ent cluster for
>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>>>>>>>>>>
>>>>>>>>>> So you could have this situation:
>>>>>>>>>>
>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu)
>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>>>>>>>>>>
>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as their=
 current
>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_clusters=
 list at
>>>>>>>>>> allocation time (when removed from free_list) and only remove it=
 from the
>>>>>>>>>
>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free list=
 and
>>>>>>>>> moving it into nonfull.
>>>>>>>>
>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring of th=
e code to
>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to see =
the
>>>>>>>> refactoring separated from behavioural changes.
>>>>>>>
>>>>>>> It is not a refactoring. It is a big rewrite of the swap allocator
>>>>>>> using the cluster. Behavior change is expected. The goal is complet=
ely
>>>>>>> removing the brute force scanning of swap_map[] array for cluster s=
wap
>>>>>>> allocation.
>>>>>>>
>>>>>>>>
>>>>>>>> Since the patch was titled RFC and I thought it was just refactori=
ng, I was
>>>>>>>> deferring review. But sounds like it is actually required to reali=
ze the test
>>>>>>>> results quoted on the cover letter?
>>>>>>>
>>>>>>> Yes, required because it handles the previous fall out case try_ssd=
()
>>>>>>> failed. This big rewrite has gone through a lot of testing and bug
>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC is
>>>>>>> because it is not feature complete. Currently it does not do swap
>>>>>>> cache reclaim. The next version will have swap cache reclaim and
>>>>>>> remove the RFC.
>>>>>>>
>>>>>>>>
>>>>>>>>> I am only making the minimal change in this step so the big rewri=
te can land.
>>>>>>>>>
>>>>>>>>>> nonfull_clusters list when it is completely full (or at least de=
finitely doesn't
>>>>>>>>>> have room for an `order` allocation)? Then you allow "stealing" =
always instead
>>>>>>>>>> of just sometimes. You would likely want to move the cluster to =
the end of the
>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_cluster(=
) to reduce the
>>>>>>>>>> chances of multiple CPUs using the same cluster.
>>>>>>>>>
>>>>>>>>> For nonfull clusters it is less important to avoid multiple CPU
>>>>>>>>> sharing the cluster. Because the cluster already has previous swap
>>>>>>>>> entries allocated from the previous CPU.
>>>>>>>>
>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogical ca=
se where cpuA
>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the fre=
e pages and
>>>>>>>
>>>>>>> That happens to exist per cpu next pointer already. When the other =
CPU
>>>>>>> advances to the next cluster pointer, it can cross with the other
>>>>>>> CPU's next cluster pointer.
>>>>>>
>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per cpu
>>>>>> cluster only.  If it doesn't do that, we should fix it.
>>>>>>
>>>>>> I agree with Ryan that we should make per cpu cluster correct.  A
>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  When we
>>>>>> scan to the end of a per cpu cluster, we can put the cluster in nonf=
ull
>>>>>> list if necessary.  And, we should make it correct in this patch ins=
tead
>>>>>> of later in series.  I understand that you want to make the patch it=
self
>>>>>> simple, but it's important to make code simple to be understood too.
>>>>>> Consistent design choice will do that.
>>>>>
>>>>> I think I'm actually arguing for the opposite of what you suggest her=
e.
>>>>
>>>> Sorry, I misunderstood your words.
>>>>
>>>>> As I see it, there are 2 possible approaches; either a cluster is alw=
ays
>>>>> considered exclusive to a single cpu when its set as a per-cpu cluste=
r, so it
>>>>> does not appear on the nonfull list. Or a cluster is considered shara=
ble in this
>>>>> case, in which case it should be added to the nonfull list.
>>>>>
>>>>> The code at the moment sort of does both; when a cpu decides to use a=
 cluster in
>>>>> the nonfull list, it removes it from that list to make it exclusive. =
But as soon
>>>>> as a single swap entry is freed from that cluster it is put back on t=
he list.
>>>>> This neither-one-policy-nor-the-other seems odd to me.
>>>>>
>>>>> I think Huang, Ying is arguing to keep it always exclusive while inst=
alled as a
>>>>> per-cpu cluster.
>>>>
>>>> Yes.
>>>>
>>>>> I was arguing to make it always shared. Perhaps the best
>>>>> approach is to implement the exclusive policy in this patch (you'd ne=
ed a flag
>>>>> to note if any pages were freed while in exclusive use, then when exc=
lusive use
>>>>> completes, put it back on the nonfull list if the flag was set). Then=
 migrate to
>>>>> the shared approach as part of the "big rewrite"?
>>>>>>
>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I thin=
k do want to
>>>>>>>> share the cluster when you really need to, but try to avoid it if =
there are
>>>>>>>> other options, and I think moving the cluster to the end of the li=
st might be a
>>>>>>>> way to help that?
>>>>>>>
>>>>>>> Simply moving to the end of the list can create a possible deadloop
>>>>>>> when all clusters have been scanned and not available swap range
>>>>>>> found.
>>>>
>>>> I also think that the shared approach has dead loop issue.
>>>
>>> What exactly do you mean by dead loop issue? Perhaps you are suggesting=
 the code
>>> won't know when to stop dequeing/requeuing clusters on the nonfull list=
 and will
>>> go forever? That's surely just an implementation issue to solve? It's n=
ot a
>>> reason to avoid the design principle; if we agree that maintaining shar=
ability
>>> of the cluster is preferred then the code must be written to guard agai=
nst the
>>> dead loop problem. It could be done by remembering the first cluster you
>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when you =
get back
>>> to it. (I think holding the si lock will protect against concurrently f=
reeing
>>> the cluster so it should definitely remain in the list?).
>>=20
>> I believe that you can find some way to avoid the dead loop issue,
>> although your suggestion may kill the performance via looping a long list
>> of nonfull clusters.=20=20
>
> I don't agree; If the clusters are considered exclusive (i.e. removed fro=
m the
> list when made current for a cpu), that only reduces the size of the list=
 by a
> maximum of the number of CPUs in the system, which I suspect is pretty sm=
all
> compared to the number of nonfull clusters.

Anyway, this depends on details.  If we cannot allocate a order-N swap
entry from the cluster, we should remove it from the nonfull list for
order-N (This is the behavior of this patch too).  Your original
suggestion appears like that you want to keep all cluster with order-N
on the nonfull list for order-N always unless the number of free swap
entry is less than 1<<N.

>> And, I understand that in some situations it may
>> be better to share clusters among CPUs.  So my suggestion is,
>>=20
>> - Make swap_cluster_info->order more accurate, don't pretend that we
>>   have free swap entries with that order even after we are sure that we
>>   haven't.
>
> Is this patch pretending that today? I don't think so?

IIUC, in this patch swap_cluster_info->order is still "N" even if we are
sure that there are no order-N free swap entry in the cluster.

> But I agree that a
> cluster should only be on the per-order nonfull list if we know there are=
 at
> least enough free swap entries in that cluster to cover the order. Of cou=
rse
> that doesn't tell us for sure because they may not be contiguous.

We can check that when free swap entry via checking adjacent swap
entries.  IMHO, the performance should be acceptable.

>>=20
>> My question is whether it's so important to share the per-cpu cluster
>> among CPUs?=20
>
> My rationale for sharing is that the preference previously has been to fa=
vour
> efficient use of swap space; we don't want to fail a request for allocati=
on of a
> given order if there are actually slots available just because they have =
been
> reserved by another CPU. And I'm still asserting that it should be ~zero =
cost to
> do this. If I'm wrong about the zero cost, or in practice the sharing doe=
sn't
> actually help improve allocation success, then I'm happy to take the excl=
usive
> approach.
>
>> I suggest to start with simple design, that is, per-CPU
>> cluster will not be shared among CPUs in most cases.
>
> I'm all for starting simple; I think that's what I already proposed (excl=
usive
> in this patch, then shared in the "big rewrite"). I'm just objecting to t=
he
> current half-and-half policy in this patch.

Sounds good to me.  We can start with exclusive solution and evaluate
whether shared solution is good.

>>=20
>> Another choice for sharing is when we run short of free swap space, we
>> disable per-CPU cluster and allocate from the shared non-full cluster
>> list directly.
>>=20
>>> Which actually makes me wonder; what is the mechanism that prevents the=
 current
>>> per-cpu cluster from being freed? Is that just handled by the conflict =
detection
>>> thingy? Perhaps that would be better handled with a flag to mark it in =
use, or
>>> raise count when its current. (If Chris has implemented that in the "big
>>> rewrite" patch, sorry, I still haven't gotten around to looking at it :=
-| )
>>=20
>> Yes.  We may need a flag for that.
>>=20
>>>>
>>>>>> This is another reason that we should put the cluster in
>>>>>> nonfull_clusters[order--] if there are no free swap entry with "orde=
r"
>>>>>> in the cluster.  It makes design complex to keep it in
>>>>>> nonfull_clusters[order].
>>>>>>
>>>>>>> We have tried many different approaches including moving to the end=
 of
>>>>>>> the list. It can cause more fragmentation because each CPU allocates
>>>>>>> their swap slot cache (64 entries) from a different cluster.
>>>>>>>
>>>>>>>>> Those behaviors will be fine
>>>>>>>>> tuned after the patch 3 big rewrite. Try to make this patch simpl=
e.
>>>>>>>
>>>>>>> Again, I want to keep it simple here so patch 3 can land.
>>>>>>>
>>>>>>>>>> Another potential optimization (which was in my hacked version I=
IRC) is to only
>>>>>>>>>> add/remove from nonfull list when `total - count` crosses the (1=
 << order)
>>>>>>>>>> boundary rather than when becoming completely full. You definite=
ly won't be able
>>>>>>>>>> to allocate order-2 if there are only 3 pages available, for exa=
mple.
>>>>>>>>>
>>>>>>>>> That is in patch 3 as well. This patch is just doing the bare min=
imum
>>>>>>>>> to introduce the nonfull list.
>>>>>>>>>
>>>>
>>>> [snip]

--
Best Regards,
Huang, Ying

