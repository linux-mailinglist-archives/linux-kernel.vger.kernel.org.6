Return-Path: <linux-kernel+bounces-262777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3EF93CCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA26AB217A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D81B28A;
	Fri, 26 Jul 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WV2ttzDy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F09848C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959666; cv=none; b=S7beVqxduSqkDqwKvC2RQ+dHu9TC1cvPo0Wr5YrRaVc2rFGTJOIbrbrX4p55bPAHrvSHkasE7pvLyHcqJg1lWHt7ydC9X0CRJljJ+Kq6NOHSftBFpAOPjn6JmtzK2gqXu/vQgAHCPmCKno6qwM334npmSpz8ak7KReY9RdJ/4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959666; c=relaxed/simple;
	bh=aVm7PuHpeIHXJvPSmFv1xW66DoJU7wHYbKkkNdhgS0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfLPiuN0GHYIJ2bEoJ50Egn4UDezvZ4OnAeTSFkQe+OEqWMJPFKFsuzxawFOJSep+2q7ieKLyTo/xh9P0Fk/bIJriNQKBlVdUdplGHqIvvNPblKVk6OWgQG+A+qfdrrzQNnfSMVo5nzgteBma+3JhyujblXApihbws9Cd9L+jVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WV2ttzDy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721959664; x=1753495664;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=aVm7PuHpeIHXJvPSmFv1xW66DoJU7wHYbKkkNdhgS0Q=;
  b=WV2ttzDy6exQBbL/uP0vrPmvTHj3+2lEZNJEr48zIlNxWUHfFK3WFJpz
   DEg9Qjk/WtJXJPT7lL3vX5Jm6yygQME5XzKoYEs6PVh6mWVQs5ItCdbNA
   a6HfUGtCGJAMuHK4s5b+feHbbSS6MTaKxDSo6p+6OcoWh5Hmat94UWneP
   jGpguFpAhJ6XNKVfp7Zno44UEzc9BO5kvktoNJGatjGOuQWxCEzk11GRg
   EmnodJ2uxwP9ORNITCHKKcszPN95e0nzlzWGxxxeTctclGz/r75SRShZU
   c+gg/1D6MBOtJsyqvVXUrxQE5AeVuphlZiU9a0VLEJcJAviWKO+OS7eKH
   w==;
X-CSE-ConnectionGUID: dcp0cyczQcat4Dgzl142gw==
X-CSE-MsgGUID: 1kpPV1rvQLm1cT+0A1jxiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19889092"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19889092"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:07:43 -0700
X-CSE-ConnectionGUID: CrOIbSyOTcGJ/Rs8aPTtVQ==
X-CSE-MsgGUID: i56PlJuXTxS2VuabQU8O4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="84089389"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:07:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
	(Chris Li's message of "Thu, 25 Jul 2024 01:26:36 -0700")
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
	<87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
Date: Fri, 26 Jul 2024 10:04:08 +0800
Message-ID: <87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Jul 24, 2024 at 11:57=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>> > On 23/07/2024 07:27, Huang, Ying wrote:
>> >> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>
>> >>> On 22/07/2024 09:49, Huang, Ying wrote:
>> >>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>>>
>> >>>>> On 22/07/2024 03:14, Huang, Ying wrote:
>> >>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>>>>>
>> >>>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
>> >>>>>>>> Chris Li <chrisl@kernel.org> writes:
>> >>>>>>>>
>> >>>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.rob=
erts@arm.com> wrote:
>> >>>>>>>>>>
>> >>>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>> >>>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.r=
oberts@arm.com> wrote:
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>> >>>>>>
>> >>>>>> [snip]
>> >>>>>>
>> >>>>>>>>>>>>> +
>> >>>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>> >>>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_cluster=
s[ci->order]);
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> I find the transitions when you add and remove a cluster fr=
om the
>> >>>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood cor=
rectly): It is added
>> >>>>>>>>>>>> to the list whenever there is at least one free swap entry =
if not already on the
>> >>>>>>>>>>>> list. But you take it off the list when assigning it as the=
 current cluster for
>> >>>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> So you could have this situation:
>> >>>>>>>>>>>>
>> >>>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that c=
pu)
>> >>>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>> >>>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>> >>>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>> >>>>>>>>>>>>
>> >>>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as =
their current
>> >>>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_clu=
sters list at
>> >>>>>>>>>>>> allocation time (when removed from free_list) and only remo=
ve it from the
>> >>>>>>>>>>>
>> >>>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free=
 list and
>> >>>>>>>>>>> moving it into nonfull.
>> >>>>>>>>>>
>> >>>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation f=
rom
>> >>>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring =
of the code to
>> >>>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to=
 see the
>> >>>>>>>>>> refactoring separated from behavioural changes.
>> >>>>>>>>>
>> >>>>>>>>> It is not a refactoring. It is a big rewrite of the swap alloc=
ator
>> >>>>>>>>> using the cluster. Behavior change is expected. The goal is co=
mpletely
>> >>>>>>>>> removing the brute force scanning of swap_map[] array for clus=
ter swap
>> >>>>>>>>> allocation.
>> >>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>> Since the patch was titled RFC and I thought it was just refa=
ctoring, I was
>> >>>>>>>>>> deferring review. But sounds like it is actually required to =
realize the test
>> >>>>>>>>>> results quoted on the cover letter?
>> >>>>>>>>>
>> >>>>>>>>> Yes, required because it handles the previous fall out case tr=
y_ssd()
>> >>>>>>>>> failed. This big rewrite has gone through a lot of testing and=
 bug
>> >>>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC=
 is
>> >>>>>>>>> because it is not feature complete. Currently it does not do s=
wap
>> >>>>>>>>> cache reclaim. The next version will have swap cache reclaim a=
nd
>> >>>>>>>>> remove the RFC.
>> >>>>>>>>>
>> >>>>>>>>>>
>> >>>>>>>>>>> I am only making the minimal change in this step so the big =
rewrite can land.
>> >>>>>>>>>>>
>> >>>>>>>>>>>> nonfull_clusters list when it is completely full (or at lea=
st definitely doesn't
>> >>>>>>>>>>>> have room for an `order` allocation)? Then you allow "steal=
ing" always instead
>> >>>>>>>>>>>> of just sometimes. You would likely want to move the cluste=
r to the end of the
>> >>>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_clu=
ster() to reduce the
>> >>>>>>>>>>>> chances of multiple CPUs using the same cluster.
>> >>>>>>>>>>>
>> >>>>>>>>>>> For nonfull clusters it is less important to avoid multiple =
CPU
>> >>>>>>>>>>> sharing the cluster. Because the cluster already has previou=
s swap
>> >>>>>>>>>>> entries allocated from the previous CPU.
>> >>>>>>>>>>
>> >>>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogic=
al case where cpuA
>> >>>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all th=
e free pages and
>> >>>>>>>>>
>> >>>>>>>>> That happens to exist per cpu next pointer already. When the o=
ther CPU
>> >>>>>>>>> advances to the next cluster pointer, it can cross with the ot=
her
>> >>>>>>>>> CPU's next cluster pointer.
>> >>>>>>>>
>> >>>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per =
cpu
>> >>>>>>>> cluster only.  If it doesn't do that, we should fix it.
>> >>>>>>>>
>> >>>>>>>> I agree with Ryan that we should make per cpu cluster correct. =
 A
>> >>>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  W=
hen we
>> >>>>>>>> scan to the end of a per cpu cluster, we can put the cluster in=
 nonfull
>> >>>>>>>> list if necessary.  And, we should make it correct in this patc=
h instead
>> >>>>>>>> of later in series.  I understand that you want to make the pat=
ch itself
>> >>>>>>>> simple, but it's important to make code simple to be understood=
 too.
>> >>>>>>>> Consistent design choice will do that.
>> >>>>>>>
>> >>>>>>> I think I'm actually arguing for the opposite of what you sugges=
t here.
>> >>>>>>
>> >>>>>> Sorry, I misunderstood your words.
>> >>>>>>
>> >>>>>>> As I see it, there are 2 possible approaches; either a cluster i=
s always
>> >>>>>>> considered exclusive to a single cpu when its set as a per-cpu c=
luster, so it
>> >>>>>>> does not appear on the nonfull list. Or a cluster is considered =
sharable in this
>> >>>>>>> case, in which case it should be added to the nonfull list.
>> >>>>>>>
>> >>>>>>> The code at the moment sort of does both; when a cpu decides to =
use a cluster in
>> >>>>>>> the nonfull list, it removes it from that list to make it exclus=
ive. But as soon
>> >>>>>>> as a single swap entry is freed from that cluster it is put back=
 on the list.
>> >>>>>>> This neither-one-policy-nor-the-other seems odd to me.
>> >>>>>>>
>> >>>>>>> I think Huang, Ying is arguing to keep it always exclusive while=
 installed as a
>> >>>>>>> per-cpu cluster.
>> >>>>>>
>> >>>>>> Yes.
>> >>>>>>
>> >>>>>>> I was arguing to make it always shared. Perhaps the best
>> >>>>>>> approach is to implement the exclusive policy in this patch (you=
'd need a flag
>> >>>>>>> to note if any pages were freed while in exclusive use, then whe=
n exclusive use
>> >>>>>>> completes, put it back on the nonfull list if the flag was set).=
 Then migrate to
>> >>>>>>> the shared approach as part of the "big rewrite"?
>> >>>>>>>>
>> >>>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I=
 think do want to
>> >>>>>>>>>> share the cluster when you really need to, but try to avoid i=
t if there are
>> >>>>>>>>>> other options, and I think moving the cluster to the end of t=
he list might be a
>> >>>>>>>>>> way to help that?
>> >>>>>>>>>
>> >>>>>>>>> Simply moving to the end of the list can create a possible dea=
dloop
>> >>>>>>>>> when all clusters have been scanned and not available swap ran=
ge
>> >>>>>>>>> found.
>> >>>>>>
>> >>>>>> I also think that the shared approach has dead loop issue.
>> >>>>>
>> >>>>> What exactly do you mean by dead loop issue? Perhaps you are sugge=
sting the code
>> >>>>> won't know when to stop dequeing/requeuing clusters on the nonfull=
 list and will
>> >>>>> go forever? That's surely just an implementation issue to solve? I=
t's not a
>> >>>>> reason to avoid the design principle; if we agree that maintaining=
 sharability
>> >>>>> of the cluster is preferred then the code must be written to guard=
 against the
>> >>>>> dead loop problem. It could be done by remembering the first clust=
er you
>> >>>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when=
 you get back
>> >>>>> to it. (I think holding the si lock will protect against concurren=
tly freeing
>> >>>>> the cluster so it should definitely remain in the list?).
>> >>>>
>> >>>> I believe that you can find some way to avoid the dead loop issue,
>> >>>> although your suggestion may kill the performance via looping a lon=
g list
>> >>>> of nonfull clusters.
>> >>>
>> >>> I don't agree; If the clusters are considered exclusive (i.e. remove=
d from the
>> >>> list when made current for a cpu), that only reduces the size of the=
 list by a
>> >>> maximum of the number of CPUs in the system, which I suspect is pret=
ty small
>> >>> compared to the number of nonfull clusters.
>> >>
>> >> Anyway, this depends on details.  If we cannot allocate a order-N swap
>> >> entry from the cluster, we should remove it from the nonfull list for
>> >> order-N (This is the behavior of this patch too).
>> >
>> > Yes that's a good point, and I conceed it is more difficult to detect =
that
>> > condition if the cluster is shared. I suspect that with a bit of think=
ing, we
>> > could find a way though.
>> >
>> >> Your original
>> >> suggestion appears like that you want to keep all cluster with order-N
>> >> on the nonfull list for order-N always unless the number of free swap
>> >> entry is less than 1<<N.
>> >
>> > Well I think that's certainly one of the conditions for removing it. B=
ut agree
>> > that if a full scan of the cluster has been performed and no swap entr=
ies have
>> > been freed since the scan started then it should also be removed from =
the list.
>> >
>> >>
>> >>>> And, I understand that in some situations it may
>> >>>> be better to share clusters among CPUs.  So my suggestion is,
>> >>>>
>> >>>> - Make swap_cluster_info->order more accurate, don't pretend that we
>> >>>>   have free swap entries with that order even after we are sure tha=
t we
>> >>>>   haven't.
>> >>>
>> >>> Is this patch pretending that today? I don't think so?
>> >>
>> >> IIUC, in this patch swap_cluster_info->order is still "N" even if we =
are
>> >> sure that there are no order-N free swap entry in the cluster.
>> >
>> > Oh I see what you mean. I think you and Chris already discussed this? =
IIRC
>> > Chris's point was that if you move that cluster to N-1, eventually all=
 clusters
>> > are for order-0 and you have no means of allocating high orders until =
a whole
>> > cluster becomes free. That logic certainly makes sense to me, so think=
 its
>> > better for swap_cluster_info->order to remain static while the cluster=
 is
>> > allocated. (I only skimmed that conversation so appologies if I got the
>> > conclusion wrong!).
>> >
>> >>
>> >>> But I agree that a
>> >>> cluster should only be on the per-order nonfull list if we know ther=
e are at
>> >>> least enough free swap entries in that cluster to cover the order. O=
f course
>> >>> that doesn't tell us for sure because they may not be contiguous.
>> >>
>> >> We can check that when free swap entry via checking adjacent swap
>> >> entries.  IMHO, the performance should be acceptable.
>> >
>> > Would you then use the result of that scanning to "promote" a cluster'=
s order?
>> > e.g. swap_cluster_info->order =3D N+1? That would be neat. But this al=
l feels like
>> > a separate change on top of what Chris is doing here. For high orders =
there
>> > could be quite a bit of scanning required in the worst case for every =
page that
>> > gets freed.
>>
>> We can try to optimize it to control overhead if necessary.
>>
>> >>
>> >>>>
>> >>>> My question is whether it's so important to share the per-cpu clust=
er
>> >>>> among CPUs?
>> >>>
>> >>> My rationale for sharing is that the preference previously has been =
to favour
>> >>> efficient use of swap space; we don't want to fail a request for all=
ocation of a
>> >>> given order if there are actually slots available just because they =
have been
>> >>> reserved by another CPU. And I'm still asserting that it should be ~=
zero cost to
>> >>> do this. If I'm wrong about the zero cost, or in practice the sharin=
g doesn't
>> >>> actually help improve allocation success, then I'm happy to take the=
 exclusive
>> >>> approach.
>> >>>
>> >>>> I suggest to start with simple design, that is, per-CPU
>> >>>> cluster will not be shared among CPUs in most cases.
>> >>>
>> >>> I'm all for starting simple; I think that's what I already proposed =
(exclusive
>> >>> in this patch, then shared in the "big rewrite"). I'm just objecting=
 to the
>> >>> current half-and-half policy in this patch.
>> >>
>> >> Sounds good to me.  We can start with exclusive solution and evaluate
>> >> whether shared solution is good.
>> >
>> > Yep. And also evaluate the dynamic order inc/dec idea too...
>>
>> Dynamic order inc/dec tries solving a more fundamental problem.  For
>> example,
>>
>> - Initially, almost only order-0 pages are swapped out, most non-full
>>   clusters are order-0.
>>
>> - Later, quite some order-0 swap entries are freed so that there are
>>   quite some order-4 swap entries available.
>
> If the freeing of swap entry is random distribution. You need 16
> continuous swap entries free at the same time at aligned 16 base
> locations. The total number of order 4 free swap space add up together
> is much lower than the order 0 allocatable swap space.
> If having one entry free is 50% probability(swapfile half full), then
> having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 E-5.
> If the swapfile is 80% full, that number drops to 6.5 E -12.

This depends on workloads.  Quite some workloads will show some degree
of spatial locality.  For a workload with no spatial locality at all as
above, mTHP may be not a good choice at the first place.

>> - Order-4 pages need to be swapped out, but no enough order-4 non-full
>>   clusters available.
>
> Exactly.
>
>>
>> So, we need a way to migrate non-full clusters among orders to adjust to
>> the various situations automatically.
>
> There is no easy way to migrate swap entries to different locations.
> That is why I like to have discontiguous swap entries allocation for
> mTHP.

We suggest to migrate non-full swap clsuters among different lists, not
swap entries.

>>
>> But yes, data is needed for any performance related change.

BTW: I think non-full cluster isn't a good name.  Partial cluster is
much better and follows the same convention as partial slab.

--
Best Regards,
Huang, Ying

