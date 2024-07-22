Return-Path: <linux-kernel+bounces-258681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AD938B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ED0280F23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2C1684AB;
	Mon, 22 Jul 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORHQ6m44"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEE16B74C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638398; cv=none; b=YsdledbPcvrda2RG6RDlWxvJKqdHjhr6RHUoju3ITvQKlmIaPMVDfoNswaIXhnTLrWx3IeGiFpvLWH3kFFMKRLm4f6jUr1uZRaz9E0rww/9vVT88pa2FkephJ/YKqWEB2iCezG3WvTi/xFoZV5IvONHULorf0GQNUXjTLLfGpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638398; c=relaxed/simple;
	bh=2aNWyhmRKO6CLT1k8LQ5OQ9/TeUK6tR4MTKi20F4MNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NF069GUiXXlcH1tIzvRWvrqE4Q6idnik5vW1cpsRIp8sRxqraQzupP2w4lid1Fs4z4xt3RvTHypmmFklAWqyk20nZxXYc4UAPKLKsS6KuclZmaUBIE1ENRM0rPACIg1Nn44F35Jt+z5gimdLbEGvcCihdQgWTGJJhx2vnKxzPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORHQ6m44; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721638396; x=1753174396;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2aNWyhmRKO6CLT1k8LQ5OQ9/TeUK6tR4MTKi20F4MNs=;
  b=ORHQ6m44q4xOEsfzwHY3dni6uQ88cH0tBZrbUBe7GIdP8AAnZsaBOja4
   k80+DNwsQx9PPTUxEmxwrRd8xb9hE2mljbXm5bojXb0k4gCpEacvB+yEZ
   LtW1ns+WnRG+ws2XWo/XOGAIPo2PJQ4llUGdTp2WwSh19C8Z6tz/THVFh
   O5TZZwtpLxF/aClKp3cPwqCcH+cR3xpDn9+icxqazRVzI4OHP5pUDCQdT
   ECCC0GTeZzkGejBItXnAA2O+P26WJm0t19rRQwiyY+JY39RQZP1y2T9Dh
   q/2rPCnavYCwUb5o0o9plt3MB/PpkQp138hmwilcxsEIRRBNhsBRNPeCx
   A==;
X-CSE-ConnectionGUID: OeS5gNALQvK29bmWmRXH0A==
X-CSE-MsgGUID: GyPBtdzVT3mAeW2dNeiS5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="36636688"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="36636688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 01:53:15 -0700
X-CSE-ConnectionGUID: MQ3aJ12+R42+mi/1/Tb3BQ==
X-CSE-MsgGUID: HLsuzrHvRYW8zi9cwj43pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="51473264"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 01:53:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  "Kalesh Singh" <kaleshsingh@google.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <43f73463-af42-4a00-8996-5f63bdf264a3@arm.com> (Ryan Roberts's
	message of "Mon, 22 Jul 2024 08:51:55 +0100")
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
Date: Mon, 22 Jul 2024 16:49:40 +0800
Message-ID: <87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 22/07/2024 03:14, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>=20
>>> On 18/07/2024 08:53, Huang, Ying wrote:
>>>> Chris Li <chrisl@kernel.org> writes:
>>>>
>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
>>>>>>
>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
>>>>>>>>
>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>>=20
>> [snip]
>>=20
>>>>>>>>> +
>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->o=
rder]);
>>>>>>>>
>>>>>>>> I find the transitions when you add and remove a cluster from the
>>>>>>>> nonfull_clusters list a bit strange (if I've understood correctly)=
: It is added
>>>>>>>> to the list whenever there is at least one free swap entry if not =
already on the
>>>>>>>> list. But you take it off the list when assigning it as the curren=
t cluster for
>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>>>>>>>>
>>>>>>>> So you could have this situation:
>>>>>>>>
>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu)
>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>>>>>>>>
>>>>>>>> At this point both cpuA and cpuB share the same cluster as their c=
urrent
>>>>>>>> cluster. So why not just put the cluster on the nonfull_clusters l=
ist at
>>>>>>>> allocation time (when removed from free_list) and only remove it f=
rom the
>>>>>>>
>>>>>>> The big rewrite on patch 3 does that, taking it off the free list a=
nd
>>>>>>> moving it into nonfull.
>>>>>>
>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring of the =
code to
>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to see the
>>>>>> refactoring separated from behavioural changes.
>>>>>
>>>>> It is not a refactoring. It is a big rewrite of the swap allocator
>>>>> using the cluster. Behavior change is expected. The goal is completely
>>>>> removing the brute force scanning of swap_map[] array for cluster swap
>>>>> allocation.
>>>>>
>>>>>>
>>>>>> Since the patch was titled RFC and I thought it was just refactoring=
, I was
>>>>>> deferring review. But sounds like it is actually required to realize=
 the test
>>>>>> results quoted on the cover letter?
>>>>>
>>>>> Yes, required because it handles the previous fall out case try_ssd()
>>>>> failed. This big rewrite has gone through a lot of testing and bug
>>>>> fix. It is pretty stable now. The only reason I keep it as RFC is
>>>>> because it is not feature complete. Currently it does not do swap
>>>>> cache reclaim. The next version will have swap cache reclaim and
>>>>> remove the RFC.
>>>>>
>>>>>>
>>>>>>> I am only making the minimal change in this step so the big rewrite=
 can land.
>>>>>>>
>>>>>>>> nonfull_clusters list when it is completely full (or at least defi=
nitely doesn't
>>>>>>>> have room for an `order` allocation)? Then you allow "stealing" al=
ways instead
>>>>>>>> of just sometimes. You would likely want to move the cluster to th=
e end of the
>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_cluster() =
to reduce the
>>>>>>>> chances of multiple CPUs using the same cluster.
>>>>>>>
>>>>>>> For nonfull clusters it is less important to avoid multiple CPU
>>>>>>> sharing the cluster. Because the cluster already has previous swap
>>>>>>> entries allocated from the previous CPU.
>>>>>>
>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogical case=
 where cpuA
>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the free =
pages and
>>>>>
>>>>> That happens to exist per cpu next pointer already. When the other CPU
>>>>> advances to the next cluster pointer, it can cross with the other
>>>>> CPU's next cluster pointer.
>>>>
>>>> No.  si->percpu_cluster[cpu].next will keep in the current per cpu
>>>> cluster only.  If it doesn't do that, we should fix it.
>>>>
>>>> I agree with Ryan that we should make per cpu cluster correct.  A
>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  When we
>>>> scan to the end of a per cpu cluster, we can put the cluster in nonfull
>>>> list if necessary.  And, we should make it correct in this patch inste=
ad
>>>> of later in series.  I understand that you want to make the patch itse=
lf
>>>> simple, but it's important to make code simple to be understood too.
>>>> Consistent design choice will do that.
>>>
>>> I think I'm actually arguing for the opposite of what you suggest here.
>>=20
>> Sorry, I misunderstood your words.
>>=20
>>> As I see it, there are 2 possible approaches; either a cluster is always
>>> considered exclusive to a single cpu when its set as a per-cpu cluster,=
 so it
>>> does not appear on the nonfull list. Or a cluster is considered sharabl=
e in this
>>> case, in which case it should be added to the nonfull list.
>>>
>>> The code at the moment sort of does both; when a cpu decides to use a c=
luster in
>>> the nonfull list, it removes it from that list to make it exclusive. Bu=
t as soon
>>> as a single swap entry is freed from that cluster it is put back on the=
 list.
>>> This neither-one-policy-nor-the-other seems odd to me.
>>>
>>> I think Huang, Ying is arguing to keep it always exclusive while instal=
led as a
>>> per-cpu cluster.
>>=20
>> Yes.
>>=20
>>> I was arguing to make it always shared. Perhaps the best
>>> approach is to implement the exclusive policy in this patch (you'd need=
 a flag
>>> to note if any pages were freed while in exclusive use, then when exclu=
sive use
>>> completes, put it back on the nonfull list if the flag was set). Then m=
igrate to
>>> the shared approach as part of the "big rewrite"?
>>>>
>>>>>> cpuB just ends up scanning and finding nothing to allocate. I think =
do want to
>>>>>> share the cluster when you really need to, but try to avoid it if th=
ere are
>>>>>> other options, and I think moving the cluster to the end of the list=
 might be a
>>>>>> way to help that?
>>>>>
>>>>> Simply moving to the end of the list can create a possible deadloop
>>>>> when all clusters have been scanned and not available swap range
>>>>> found.
>>=20
>> I also think that the shared approach has dead loop issue.
>
> What exactly do you mean by dead loop issue? Perhaps you are suggesting t=
he code
> won't know when to stop dequeing/requeuing clusters on the nonfull list a=
nd will
> go forever? That's surely just an implementation issue to solve? It's not=
 a
> reason to avoid the design principle; if we agree that maintaining sharab=
ility
> of the cluster is preferred then the code must be written to guard agains=
t the
> dead loop problem. It could be done by remembering the first cluster you
> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when you ge=
t back
> to it. (I think holding the si lock will protect against concurrently fre=
eing
> the cluster so it should definitely remain in the list?).

I believe that you can find some way to avoid the dead loop issue,
although your suggestion may kill the performance via looping a long list
of nonfull clusters.  And, I understand that in some situations it may
be better to share clusters among CPUs.  So my suggestion is,

- Make swap_cluster_info->order more accurate, don't pretend that we
  have free swap entries with that order even after we are sure that we
  haven't.

My question is whether it's so important to share the per-cpu cluster
among CPUs?  I suggest to start with simple design, that is, per-CPU
cluster will not be shared among CPUs in most cases.

Another choice for sharing is when we run short of free swap space, we
disable per-CPU cluster and allocate from the shared non-full cluster
list directly.

> Which actually makes me wonder; what is the mechanism that prevents the c=
urrent
> per-cpu cluster from being freed? Is that just handled by the conflict de=
tection
> thingy? Perhaps that would be better handled with a flag to mark it in us=
e, or
> raise count when its current. (If Chris has implemented that in the "big
> rewrite" patch, sorry, I still haven't gotten around to looking at it :-|=
 )

Yes.  We may need a flag for that.

>>=20
>>>> This is another reason that we should put the cluster in
>>>> nonfull_clusters[order--] if there are no free swap entry with "order"
>>>> in the cluster.  It makes design complex to keep it in
>>>> nonfull_clusters[order].
>>>>
>>>>> We have tried many different approaches including moving to the end of
>>>>> the list. It can cause more fragmentation because each CPU allocates
>>>>> their swap slot cache (64 entries) from a different cluster.
>>>>>
>>>>>>> Those behaviors will be fine
>>>>>>> tuned after the patch 3 big rewrite. Try to make this patch simple.
>>>>>
>>>>> Again, I want to keep it simple here so patch 3 can land.
>>>>>
>>>>>>>> Another potential optimization (which was in my hacked version IIR=
C) is to only
>>>>>>>> add/remove from nonfull list when `total - count` crosses the (1 <=
< order)
>>>>>>>> boundary rather than when becoming completely full. You definitely=
 won't be able
>>>>>>>> to allocate order-2 if there are only 3 pages available, for examp=
le.
>>>>>>>
>>>>>>> That is in patch 3 as well. This patch is just doing the bare minim=
um
>>>>>>> to introduce the nonfull list.
>>>>>>>
>>=20
>> [snip]

--
Best Regards,
Huang, Ying

