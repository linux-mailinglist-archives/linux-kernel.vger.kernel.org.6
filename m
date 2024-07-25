Return-Path: <linux-kernel+bounces-261832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233893BCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167CC2856D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B616D9B7;
	Thu, 25 Jul 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDBsPjha"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811F15FA96
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890008; cv=none; b=JCtfTPBbFjojw9IfpLG2fOPCq/cCQ1VD2KVNpKpqhuKKXtaeb3miGJeegMtfkA4TPywCtpZtGj3SlswmxicocMSAjvRvxY+eqb70/BU55pxJMPO7fKU5b/RDb4YhzoCtBrFjfnsGMStg7AyYWX2CButjx2GX8fDrfm+wN6XIVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890008; c=relaxed/simple;
	bh=NUMLKRX6NViwl6axdyNznKeK1TtgPZrNlCDLGVcMlA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDQewE/IGt9z5KOctnxSiVGih/6kr5U9lWnDoEjam84fCgX1VeO6Mlq/Iwsz1rVSNmuGPMt69G765bU3x684GZnuEKUabO2kDKLIq6yNu5GD3DdxiDysn3nsipFtJigDyz8iKgjBsSDH6NG8GDMyd3YHH/7W8c+wC+FcZhFqk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDBsPjha; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721890007; x=1753426007;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=NUMLKRX6NViwl6axdyNznKeK1TtgPZrNlCDLGVcMlA8=;
  b=hDBsPjhaLs6V8eG0muF6WG0eUQVyVedUwRHQPoLsENNNtRX7xyfyXQxp
   S3exbqbbPe3TdpqgcJBQLIY47/U9B+gpJmOa9yKAg886Obh6aTgnypF8F
   /BGMKTFnxLVx47IsuOsQBDXGp4D+23ExGjpzvI1MPe4xBDPDYdRy2sj+L
   HpS9oJV3NWD7EskEQt+vht0DcpsNSAYMnfEEj4IHFVGWWswGj6QSkrw5h
   iwUejxJoTsv806z0sxD7KrSLmXBupbFXmA6NCnLcsoAgv3ptSU1t9eQg9
   s+9KcqkLbBHCGone7fPFTZ0MjA/8+41bJqi4zkJjISuq2cEofEVf7+GvV
   w==;
X-CSE-ConnectionGUID: LYgKn7JcTa205altbI7Shg==
X-CSE-MsgGUID: 607B9IUKQaaOKsgywUZP6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="22516458"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="22516458"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:46:45 -0700
X-CSE-ConnectionGUID: PUXGKoNnSL2BBn3WdO8ZHw==
X-CSE-MsgGUID: kNlhaVFAR1iwdoE4AgWh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="56971583"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:46:42 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbV9cx6Le1cYgYo2D922E4Com45+XXquMZugog2+w5K_yg@mail.gmail.com>
	(Chris Li's message of "Wed, 24 Jul 2024 15:41:00 -0700")
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
	<87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
	<CACePvbV9cx6Le1cYgYo2D922E4Com45+XXquMZugog2+w5K_yg@mail.gmail.com>
Date: Thu, 25 Jul 2024 14:43:09 +0800
Message-ID: <87plr26kg2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> Hi Ryan and Ying,
>
> Sorry I was busy. I am catching up on the email now.
>
> On Wed, Jul 24, 2024 at 1:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
>>
>> On 23/07/2024 07:27, Huang, Ying wrote:
>> > Ryan Roberts <ryan.roberts@arm.com> writes:
>> >
>> >> On 22/07/2024 09:49, Huang, Ying wrote:
>> >>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>>
>> >>>> On 22/07/2024 03:14, Huang, Ying wrote:
>> >>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>>>>
>> >>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
>> >>>>>>> Chris Li <chrisl@kernel.org> writes:
>> >>>>>>>
>> >>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.robe=
rts@arm.com> wrote:
>> >>>>>>>>>
>> >>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>> >>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.ro=
berts@arm.com> wrote:
>> >>>>>>>>>>>
>> >>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>> >>>>>
>> >>>>> [snip]
>> >>>>>
>> >>>>>>>>>>>> +
>> >>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>> >>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters=
[ci->order]);
>> >>>>>>>>>>>
>> >>>>>>>>>>> I find the transitions when you add and remove a cluster fro=
m the
>> >>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood corr=
ectly): It is added
>> >>>>>>>>>>> to the list whenever there is at least one free swap entry i=
f not already on the
>> >>>>>>>>>>> list. But you take it off the list when assigning it as the =
current cluster for
>> >>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>> >>>>>>>>>>>
>> >>>>>>>>>>> So you could have this situation:
>> >>>>>>>>>>>
>> >>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cp=
u)
>> >>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>> >>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>> >>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>> >>>>>>>>>>>
>> >>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as t=
heir current
>> >>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_clus=
ters list at
>> >>>>>>>>>>> allocation time (when removed from free_list) and only remov=
e it from the
>> >>>>>>>>>>
>> >>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free =
list and
>> >>>>>>>>>> moving it into nonfull.
>> >>>>>>>>>
>> >>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation fr=
om
>> >>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring o=
f the code to
>> >>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to =
see the
>> >>>>>>>>> refactoring separated from behavioural changes.
>> >>>>>>>>
>> >>>>>>>> It is not a refactoring. It is a big rewrite of the swap alloca=
tor
>> >>>>>>>> using the cluster. Behavior change is expected. The goal is com=
pletely
>> >>>>>>>> removing the brute force scanning of swap_map[] array for clust=
er swap
>> >>>>>>>> allocation.
>> >>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>> Since the patch was titled RFC and I thought it was just refac=
toring, I was
>> >>>>>>>>> deferring review. But sounds like it is actually required to r=
ealize the test
>> >>>>>>>>> results quoted on the cover letter?
>> >>>>>>>>
>> >>>>>>>> Yes, required because it handles the previous fall out case try=
_ssd()
>> >>>>>>>> failed. This big rewrite has gone through a lot of testing and =
bug
>> >>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC =
is
>> >>>>>>>> because it is not feature complete. Currently it does not do sw=
ap
>> >>>>>>>> cache reclaim. The next version will have swap cache reclaim and
>> >>>>>>>> remove the RFC.
>> >>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>>> I am only making the minimal change in this step so the big r=
ewrite can land.
>> >>>>>>>>>>
>> >>>>>>>>>>> nonfull_clusters list when it is completely full (or at leas=
t definitely doesn't
>> >>>>>>>>>>> have room for an `order` allocation)? Then you allow "steali=
ng" always instead
>> >>>>>>>>>>> of just sometimes. You would likely want to move the cluster=
 to the end of the
>> >>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_clus=
ter() to reduce the
>> >>>>>>>>>>> chances of multiple CPUs using the same cluster.
>> >>>>>>>>>>
>> >>>>>>>>>> For nonfull clusters it is less important to avoid multiple C=
PU
>> >>>>>>>>>> sharing the cluster. Because the cluster already has previous=
 swap
>> >>>>>>>>>> entries allocated from the previous CPU.
>> >>>>>>>>>
>> >>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogica=
l case where cpuA
>> >>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the=
 free pages and
>> >>>>>>>>
>> >>>>>>>> That happens to exist per cpu next pointer already. When the ot=
her CPU
>> >>>>>>>> advances to the next cluster pointer, it can cross with the oth=
er
>> >>>>>>>> CPU's next cluster pointer.
>> >>>>>>>
>> >>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per c=
pu
>> >>>>>>> cluster only.  If it doesn't do that, we should fix it.
>> >>>>>>>
>> >>>>>>> I agree with Ryan that we should make per cpu cluster correct.  A
>> >>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  Wh=
en we
>> >>>>>>> scan to the end of a per cpu cluster, we can put the cluster in =
nonfull
>> >>>>>>> list if necessary.  And, we should make it correct in this patch=
 instead
>> >>>>>>> of later in series.  I understand that you want to make the patc=
h itself
>> >>>>>>> simple, but it's important to make code simple to be understood =
too.
>> >>>>>>> Consistent design choice will do that.
>> >>>>>>
>> >>>>>> I think I'm actually arguing for the opposite of what you suggest=
 here.
>> >>>>>
>> >>>>> Sorry, I misunderstood your words.
>> >>>>>
>> >>>>>> As I see it, there are 2 possible approaches; either a cluster is=
 always
>> >>>>>> considered exclusive to a single cpu when its set as a per-cpu cl=
uster, so it
>> >>>>>> does not appear on the nonfull list. Or a cluster is considered s=
harable in this
>> >>>>>> case, in which case it should be added to the nonfull list.
>> >>>>>>
>> >>>>>> The code at the moment sort of does both; when a cpu decides to u=
se a cluster in
>> >>>>>> the nonfull list, it removes it from that list to make it exclusi=
ve. But as soon
>> >>>>>> as a single swap entry is freed from that cluster it is put back =
on the list.
>> >>>>>> This neither-one-policy-nor-the-other seems odd to me.
>> >>>>>>
>> >>>>>> I think Huang, Ying is arguing to keep it always exclusive while =
installed as a
>> >>>>>> per-cpu cluster.
>> >>>>>
>> >>>>> Yes.
>> >>>>>
>> >>>>>> I was arguing to make it always shared. Perhaps the best
>> >>>>>> approach is to implement the exclusive policy in this patch (you'=
d need a flag
>> >>>>>> to note if any pages were freed while in exclusive use, then when=
 exclusive use
>> >>>>>> completes, put it back on the nonfull list if the flag was set). =
Then migrate to
>> >>>>>> the shared approach as part of the "big rewrite"?
>> >>>>>>>
>> >>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I =
think do want to
>> >>>>>>>>> share the cluster when you really need to, but try to avoid it=
 if there are
>> >>>>>>>>> other options, and I think moving the cluster to the end of th=
e list might be a
>> >>>>>>>>> way to help that?
>> >>>>>>>>
>> >>>>>>>> Simply moving to the end of the list can create a possible dead=
loop
>> >>>>>>>> when all clusters have been scanned and not available swap range
>> >>>>>>>> found.
>> >>>>>
>> >>>>> I also think that the shared approach has dead loop issue.
>> >>>>
>> >>>> What exactly do you mean by dead loop issue? Perhaps you are sugges=
ting the code
>> >>>> won't know when to stop dequeing/requeuing clusters on the nonfull =
list and will
>> >>>> go forever? That's surely just an implementation issue to solve? It=
's not a
>> >>>> reason to avoid the design principle; if we agree that maintaining =
sharability
>> >>>> of the cluster is preferred then the code must be written to guard =
against the
>> >>>> dead loop problem. It could be done by remembering the first cluste=
r you
>> >>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when =
you get back
>> >>>> to it. (I think holding the si lock will protect against concurrent=
ly freeing
>> >>>> the cluster so it should definitely remain in the list?).
>> >>>
>> >>> I believe that you can find some way to avoid the dead loop issue,
>> >>> although your suggestion may kill the performance via looping a long=
 list
>> >>> of nonfull clusters.
>> >>
>> >> I don't agree; If the clusters are considered exclusive (i.e. removed=
 from the
>> >> list when made current for a cpu), that only reduces the size of the =
list by a
>> >> maximum of the number of CPUs in the system, which I suspect is prett=
y small
>> >> compared to the number of nonfull clusters.
>> >
>> > Anyway, this depends on details.  If we cannot allocate a order-N swap
>> > entry from the cluster, we should remove it from the nonfull list for
>> > order-N (This is the behavior of this patch too).
>
> Yes, Kairui implements something like that in the reclaim part of the
> patch series. It is after patch 3. We are heavily testing the
> performance and the stability of the reclaim patches. May I post the
> reclaim together with patch 3 for discussion. If you want we can
> discuss the re-order the patch in a later iteration.
>
>>
>> Yes that's a good point, and I conceed it is more difficult to detect th=
at
>> condition if the cluster is shared. I suspect that with a bit of thinkin=
g, we
>> could find a way though.
>
> Kaiui has  the patch series show a good performance number that beats
> the current swap cache reclaim.
>
> I want to make a point regarding the patch ordering before vs after
> patch 3 (aka the big rewrite).
> Previously, the "san_swap_map_try_ssd_cluster" only did partial
> allocation. It does not sucessfully allocate a swap entry 100% the
> time.  The patch 3 makes the cluster allocation function return the
> swap entry 100% of the time. There are no more fallback retry loops
> outside of the cluster allocation function. Also the try_ssd function
> does not do swap cache reclaims while the cluster allocation function
> will need to. These two have very different constraints.
>
> There for, adding different cluster header into
> san_swap_map_try_ssd_cluste will be a lot of waste investment of
> development time in the sense that, that function will need to be
> rewrite any way, the end result is very different.

I am not a big fan of implementing the final solution directly.
Personally, I prefer to improve step by step.

> That is why I want to make this change patch after patch 3. There is
> also the long test cycle after the modification to make sure the swap
> code path is stable. I am not resisting a change of patch orders, it
> is that patch can't directly be removed before patch 3 before the big
> rewrite.
>
>
>>
>> > Your original
>> > suggestion appears like that you want to keep all cluster with order-N
>> > on the nonfull list for order-N always unless the number of free swap
>> > entry is less than 1<<N.
>>
>> Well I think that's certainly one of the conditions for removing it. But=
 agree
>> that if a full scan of the cluster has been performed and no swap entrie=
s have
>> been freed since the scan started then it should also be removed from th=
e list.
>
> Yes, in the later patch of patch, beyond patch 3, we have the almost
> full cluster that for the cluster has been scan and not able to
> allocate order N entry.
>
>>
>> >
>> >>> And, I understand that in some situations it may
>> >>> be better to share clusters among CPUs.  So my suggestion is,
>> >>>
>> >>> - Make swap_cluster_info->order more accurate, don't pretend that we
>> >>>   have free swap entries with that order even after we are sure that=
 we
>> >>>   haven't.
>> >>
>> >> Is this patch pretending that today? I don't think so?
>> >
>> > IIUC, in this patch swap_cluster_info->order is still "N" even if we a=
re
>> > sure that there are no order-N free swap entry in the cluster.
>>
>> Oh I see what you mean. I think you and Chris already discussed this? II=
RC
>> Chris's point was that if you move that cluster to N-1, eventually all c=
lusters
>> are for order-0 and you have no means of allocating high orders until a =
whole
>> cluster becomes free. That logic certainly makes sense to me, so think i=
ts
>> better for swap_cluster_info->order to remain static while the cluster is
>> allocated. (I only skimmed that conversation so appologies if I got the
>> conclusion wrong!).
>
> Yes, that is the original intent, keep the cluster order as much as possi=
ble.
>
>>
>> >
>> >> But I agree that a
>> >> cluster should only be on the per-order nonfull list if we know there=
 are at
>> >> least enough free swap entries in that cluster to cover the order. Of=
 course
>> >> that doesn't tell us for sure because they may not be contiguous.
>> >
>> > We can check that when free swap entry via checking adjacent swap
>> > entries.  IMHO, the performance should be acceptable.
>>
>> Would you then use the result of that scanning to "promote" a cluster's =
order?
>> e.g. swap_cluster_info->order =3D N+1? That would be neat. But this all =
feels like
>> a separate change on top of what Chris is doing here. For high orders th=
ere
>> could be quite a bit of scanning required in the worst case for every pa=
ge that
>> gets freed.
>
> Right, I feel that is a different set of patches. Even this series is
> hard enough for review. Those order promotion and demotion is heading
> towards a buddy system design. I want to point out that even the buddy
> system is not able to handle the case that swapfile is almost full and
> the recently freed swap entries are not contiguous.
>
> We can invest in the buddy system, which doesn't handle all the
> fragmentation issues. Or I prefer to go directly to the discontiguous
> swap entry. We pay a price for the indirect mapping of swap entries.
> But it will solve the fragmentation issue 100%.

It's good if we can solve the fragmentation issue 100%.  Just need to
pay attention to the cost.

>>
>> >
>> >>>
>> >>> My question is whether it's so important to share the per-cpu cluster
>> >>> among CPUs?
>> >>
>> >> My rationale for sharing is that the preference previously has been t=
o favour
>> >> efficient use of swap space; we don't want to fail a request for allo=
cation of a
>> >> given order if there are actually slots available just because they h=
ave been
>> >> reserved by another CPU. And I'm still asserting that it should be ~z=
ero cost to
>> >> do this. If I'm wrong about the zero cost, or in practice the sharing=
 doesn't
>> >> actually help improve allocation success, then I'm happy to take the =
exclusive
>> >> approach.
>> >>
>> >>> I suggest to start with simple design, that is, per-CPU
>> >>> cluster will not be shared among CPUs in most cases.
>> >>
>> >> I'm all for starting simple; I think that's what I already proposed (=
exclusive
>> >> in this patch, then shared in the "big rewrite"). I'm just objecting =
to the
>> >> current half-and-half policy in this patch.
>> >
>> > Sounds good to me.  We can start with exclusive solution and evaluate
>> > whether shared solution is good.
>>
>> Yep. And also evaluate the dynamic order inc/dec idea too...
>
> It is not able to avoid fragementation 100% of the time. I prefer the
> discontinued swap entry as the next step, which guarantees forward
> progress, we will not be stuck in a situation where we are not able to
> allocate swap entries due to fragmentation.

If my understanding were correct, the implementation complexity of the
order promotion/demotion isn't at the same level of that of discontinued
swap entry.

--
Best Regards,
Huang, Ying

>
>>
>> >
>> >>>
>> >>> Another choice for sharing is when we run short of free swap space, =
we
>> >>> disable per-CPU cluster and allocate from the shared non-full cluster
>> >>> list directly.
>> >>>
>> >>>> Which actually makes me wonder; what is the mechanism that prevents=
 the current
>> >>>> per-cpu cluster from being freed? Is that just handled by the confl=
ict detection
>> >>>> thingy? Perhaps that would be better handled with a flag to mark it=
 in use, or
>> >>>> raise count when its current. (If Chris has implemented that in the=
 "big
>> >>>> rewrite" patch, sorry, I still haven't gotten around to looking at =
it :-| )
>> >>>
>> >>> Yes.  We may need a flag for that.
>> >>>
>> >>>>>
>> >>>>>>> This is another reason that we should put the cluster in
>> >>>>>>> nonfull_clusters[order--] if there are no free swap entry with "=
order"
>> >>>>>>> in the cluster.  It makes design complex to keep it in
>> >>>>>>> nonfull_clusters[order].
>> >>>>>>>
>> >>>>>>>> We have tried many different approaches including moving to the=
 end of
>> >>>>>>>> the list. It can cause more fragmentation because each CPU allo=
cates
>> >>>>>>>> their swap slot cache (64 entries) from a different cluster.
>> >>>>>>>>
>> >>>>>>>>>> Those behaviors will be fine
>> >>>>>>>>>> tuned after the patch 3 big rewrite. Try to make this patch s=
imple.
>> >>>>>>>>
>> >>>>>>>> Again, I want to keep it simple here so patch 3 can land.
>> >>>>>>>>
>> >>>>>>>>>>> Another potential optimization (which was in my hacked versi=
on IIRC) is to only
>> >>>>>>>>>>> add/remove from nonfull list when `total - count` crosses th=
e (1 << order)
>> >>>>>>>>>>> boundary rather than when becoming completely full. You defi=
nitely won't be able
>> >>>>>>>>>>> to allocate order-2 if there are only 3 pages available, for=
 example.
>> >>>>>>>>>>
>> >>>>>>>>>> That is in patch 3 as well. This patch is just doing the bare=
 minimum
>> >>>>>>>>>> to introduce the nonfull list.
>> >>>>>>>>>>
>> >>>>>
>> >>>>> [snip]
>> >
>> > --
>> > Best Regards,
>> > Huang, Ying
>>

