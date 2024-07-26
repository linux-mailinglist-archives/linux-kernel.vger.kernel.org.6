Return-Path: <linux-kernel+bounces-262781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4DB93CCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDB42828E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB3200AF;
	Fri, 26 Jul 2024 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CirzcVgH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044F1CAA6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959985; cv=none; b=awK32ODoxmnaPzFViHfY1RqAeey8xnWpHjKsOBJvNQ7pPwIJwl2RWtl0XCLvEp6ggY62Ko0btv2xQYjBM/9dbEyBe08TZ1tba5A14kS3VTWOb99Au2Obc9hg7u8cMOoTSVqzOJG43fxF5g/ivxxewFgEIV8jUd0D8vv3A3J0KhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959985; c=relaxed/simple;
	bh=tN1cXDoPA3NUrowVquUiGpxSX3MKZA6RxwkcdHiATtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+T2paDWpmAJVi1BEQkBd2jVdXk4wtuQG27SjB4GyQPihkmTojdvXUC2kfu7QeuJeO9qCmCFDHexA28N0ZIFYg89HB+SIgSD6AhH34fLSg/oXxc2fv9+FJwy4u7ixnw7VmsYs69p705W/VPMgQn0+LNJJL570GcIQhVUmA5pAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CirzcVgH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721959983; x=1753495983;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=tN1cXDoPA3NUrowVquUiGpxSX3MKZA6RxwkcdHiATtU=;
  b=CirzcVgH31YK151tom/cflDcooXxpK/irzmGgZj5sspArJ2gF5HdhpC2
   UO9Ioyvz6GCwc3GiK9QTdXCF9OY+cvBsAMfqa+gdQ5T5YeWmBRgTVtTQR
   q2X9nMbmbtr6TBpnignTub09k69KFCidglfKotY5xQEevr2TLxyfpsCJf
   C+s3jVlU51lWN1yYTKBRW1mDdzA5TyCQHNdbDcOEOuPDgtuF7QYqvoRn8
   Y8avx5LaQDKsvULHJb1VubVUJ5Ox+G53fVvdhyLjXcJu1W8Wme/8EYL1t
   p0AuWhGfwyl2sUnZwxnuJ/GQJOW41IRzrv1iRaBmaxW/Tp6TpFD3Q+/92
   w==;
X-CSE-ConnectionGUID: ebw6PXibSs6iVpJL6+qHtw==
X-CSE-MsgGUID: TzkOEltqTV28jLbO3yzgMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19923821"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19923821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:13:02 -0700
X-CSE-ConnectionGUID: iw7tDrNzToW5+YhCxO8P+A==
X-CSE-MsgGUID: i0ICqGSZQsOVSIEpaaoimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="53896340"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:13:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbXC6SwD1mx_s_9yCZpqTXZhRKMetbCcBNPOgT-ZtLmGCA@mail.gmail.com>
	(Chris Li's message of "Thu, 25 Jul 2024 01:09:03 -0700")
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
	<87plr26kg2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXC6SwD1mx_s_9yCZpqTXZhRKMetbCcBNPOgT-ZtLmGCA@mail.gmail.com>
Date: Fri, 26 Jul 2024 10:09:27 +0800
Message-ID: <87v80s3nvs.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Jul 24, 2024 at 11:46=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > Hi Ryan and Ying,
>> >
>> > Sorry I was busy. I am catching up on the email now.
>> >
>> > On Wed, Jul 24, 2024 at 1:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
>> >>
>> >> On 23/07/2024 07:27, Huang, Ying wrote:
>> >> > Ryan Roberts <ryan.roberts@arm.com> writes:
>> >> >
>> >> >> On 22/07/2024 09:49, Huang, Ying wrote:
>> >> >>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >> >>>
>> >> >>>> On 22/07/2024 03:14, Huang, Ying wrote:
>> >> >>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >> >>>>>
>> >> >>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
>> >> >>>>>>> Chris Li <chrisl@kernel.org> writes:
>> >> >>>>>>>
>> >> >>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.r=
oberts@arm.com> wrote:
>> >> >>>>>>>>>
>> >> >>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>> >> >>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan=
.roberts@arm.com> wrote:
>> >> >>>>>>>>>>>
>> >> >>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>> >> >>>>>
>> >> >>>>> [snip]
>> >> >>>>>
>> >> >>>>>>>>>>>> +
>> >> >>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>> >> >>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clust=
ers[ci->order]);
>> >> >>>>>>>>>>>
>> >> >>>>>>>>>>> I find the transitions when you add and remove a cluster =
from the
>> >> >>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood c=
orrectly): It is added
>> >> >>>>>>>>>>> to the list whenever there is at least one free swap entr=
y if not already on the
>> >> >>>>>>>>>>> list. But you take it off the list when assigning it as t=
he current cluster for
>> >> >>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>> >> >>>>>>>>>>>
>> >> >>>>>>>>>>> So you could have this situation:
>> >> >>>>>>>>>>>
>> >> >>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that=
 cpu)
>> >> >>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>> >> >>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>> >> >>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>> >> >>>>>>>>>>>
>> >> >>>>>>>>>>> At this point both cpuA and cpuB share the same cluster a=
s their current
>> >> >>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_c=
lusters list at
>> >> >>>>>>>>>>> allocation time (when removed from free_list) and only re=
move it from the
>> >> >>>>>>>>>>
>> >> >>>>>>>>>> The big rewrite on patch 3 does that, taking it off the fr=
ee list and
>> >> >>>>>>>>>> moving it into nonfull.
>> >> >>>>>>>>>
>> >> >>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation=
 from
>> >> >>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactorin=
g of the code to
>> >> >>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer =
to see the
>> >> >>>>>>>>> refactoring separated from behavioural changes.
>> >> >>>>>>>>
>> >> >>>>>>>> It is not a refactoring. It is a big rewrite of the swap all=
ocator
>> >> >>>>>>>> using the cluster. Behavior change is expected. The goal is =
completely
>> >> >>>>>>>> removing the brute force scanning of swap_map[] array for cl=
uster swap
>> >> >>>>>>>> allocation.
>> >> >>>>>>>>
>> >> >>>>>>>>>
>> >> >>>>>>>>> Since the patch was titled RFC and I thought it was just re=
factoring, I was
>> >> >>>>>>>>> deferring review. But sounds like it is actually required t=
o realize the test
>> >> >>>>>>>>> results quoted on the cover letter?
>> >> >>>>>>>>
>> >> >>>>>>>> Yes, required because it handles the previous fall out case =
try_ssd()
>> >> >>>>>>>> failed. This big rewrite has gone through a lot of testing a=
nd bug
>> >> >>>>>>>> fix. It is pretty stable now. The only reason I keep it as R=
FC is
>> >> >>>>>>>> because it is not feature complete. Currently it does not do=
 swap
>> >> >>>>>>>> cache reclaim. The next version will have swap cache reclaim=
 and
>> >> >>>>>>>> remove the RFC.
>> >> >>>>>>>>
>> >> >>>>>>>>>
>> >> >>>>>>>>>> I am only making the minimal change in this step so the bi=
g rewrite can land.
>> >> >>>>>>>>>>
>> >> >>>>>>>>>>> nonfull_clusters list when it is completely full (or at l=
east definitely doesn't
>> >> >>>>>>>>>>> have room for an `order` allocation)? Then you allow "ste=
aling" always instead
>> >> >>>>>>>>>>> of just sometimes. You would likely want to move the clus=
ter to the end of the
>> >> >>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_c=
luster() to reduce the
>> >> >>>>>>>>>>> chances of multiple CPUs using the same cluster.
>> >> >>>>>>>>>>
>> >> >>>>>>>>>> For nonfull clusters it is less important to avoid multipl=
e CPU
>> >> >>>>>>>>>> sharing the cluster. Because the cluster already has previ=
ous swap
>> >> >>>>>>>>>> entries allocated from the previous CPU.
>> >> >>>>>>>>>
>> >> >>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalog=
ical case where cpuA
>> >> >>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all =
the free pages and
>> >> >>>>>>>>
>> >> >>>>>>>> That happens to exist per cpu next pointer already. When the=
 other CPU
>> >> >>>>>>>> advances to the next cluster pointer, it can cross with the =
other
>> >> >>>>>>>> CPU's next cluster pointer.
>> >> >>>>>>>
>> >> >>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current pe=
r cpu
>> >> >>>>>>> cluster only.  If it doesn't do that, we should fix it.
>> >> >>>>>>>
>> >> >>>>>>> I agree with Ryan that we should make per cpu cluster correct=
.  A
>> >> >>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list. =
 When we
>> >> >>>>>>> scan to the end of a per cpu cluster, we can put the cluster =
in nonfull
>> >> >>>>>>> list if necessary.  And, we should make it correct in this pa=
tch instead
>> >> >>>>>>> of later in series.  I understand that you want to make the p=
atch itself
>> >> >>>>>>> simple, but it's important to make code simple to be understo=
od too.
>> >> >>>>>>> Consistent design choice will do that.
>> >> >>>>>>
>> >> >>>>>> I think I'm actually arguing for the opposite of what you sugg=
est here.
>> >> >>>>>
>> >> >>>>> Sorry, I misunderstood your words.
>> >> >>>>>
>> >> >>>>>> As I see it, there are 2 possible approaches; either a cluster=
 is always
>> >> >>>>>> considered exclusive to a single cpu when its set as a per-cpu=
 cluster, so it
>> >> >>>>>> does not appear on the nonfull list. Or a cluster is considere=
d sharable in this
>> >> >>>>>> case, in which case it should be added to the nonfull list.
>> >> >>>>>>
>> >> >>>>>> The code at the moment sort of does both; when a cpu decides t=
o use a cluster in
>> >> >>>>>> the nonfull list, it removes it from that list to make it excl=
usive. But as soon
>> >> >>>>>> as a single swap entry is freed from that cluster it is put ba=
ck on the list.
>> >> >>>>>> This neither-one-policy-nor-the-other seems odd to me.
>> >> >>>>>>
>> >> >>>>>> I think Huang, Ying is arguing to keep it always exclusive whi=
le installed as a
>> >> >>>>>> per-cpu cluster.
>> >> >>>>>
>> >> >>>>> Yes.
>> >> >>>>>
>> >> >>>>>> I was arguing to make it always shared. Perhaps the best
>> >> >>>>>> approach is to implement the exclusive policy in this patch (y=
ou'd need a flag
>> >> >>>>>> to note if any pages were freed while in exclusive use, then w=
hen exclusive use
>> >> >>>>>> completes, put it back on the nonfull list if the flag was set=
). Then migrate to
>> >> >>>>>> the shared approach as part of the "big rewrite"?
>> >> >>>>>>>
>> >> >>>>>>>>> cpuB just ends up scanning and finding nothing to allocate.=
 I think do want to
>> >> >>>>>>>>> share the cluster when you really need to, but try to avoid=
 it if there are
>> >> >>>>>>>>> other options, and I think moving the cluster to the end of=
 the list might be a
>> >> >>>>>>>>> way to help that?
>> >> >>>>>>>>
>> >> >>>>>>>> Simply moving to the end of the list can create a possible d=
eadloop
>> >> >>>>>>>> when all clusters have been scanned and not available swap r=
ange
>> >> >>>>>>>> found.
>> >> >>>>>
>> >> >>>>> I also think that the shared approach has dead loop issue.
>> >> >>>>
>> >> >>>> What exactly do you mean by dead loop issue? Perhaps you are sug=
gesting the code
>> >> >>>> won't know when to stop dequeing/requeuing clusters on the nonfu=
ll list and will
>> >> >>>> go forever? That's surely just an implementation issue to solve?=
 It's not a
>> >> >>>> reason to avoid the design principle; if we agree that maintaini=
ng sharability
>> >> >>>> of the cluster is preferred then the code must be written to gua=
rd against the
>> >> >>>> dead loop problem. It could be done by remembering the first clu=
ster you
>> >> >>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop wh=
en you get back
>> >> >>>> to it. (I think holding the si lock will protect against concurr=
ently freeing
>> >> >>>> the cluster so it should definitely remain in the list?).
>> >> >>>
>> >> >>> I believe that you can find some way to avoid the dead loop issue,
>> >> >>> although your suggestion may kill the performance via looping a l=
ong list
>> >> >>> of nonfull clusters.
>> >> >>
>> >> >> I don't agree; If the clusters are considered exclusive (i.e. remo=
ved from the
>> >> >> list when made current for a cpu), that only reduces the size of t=
he list by a
>> >> >> maximum of the number of CPUs in the system, which I suspect is pr=
etty small
>> >> >> compared to the number of nonfull clusters.
>> >> >
>> >> > Anyway, this depends on details.  If we cannot allocate a order-N s=
wap
>> >> > entry from the cluster, we should remove it from the nonfull list f=
or
>> >> > order-N (This is the behavior of this patch too).
>> >
>> > Yes, Kairui implements something like that in the reclaim part of the
>> > patch series. It is after patch 3. We are heavily testing the
>> > performance and the stability of the reclaim patches. May I post the
>> > reclaim together with patch 3 for discussion. If you want we can
>> > discuss the re-order the patch in a later iteration.
>> >
>> >>
>> >> Yes that's a good point, and I conceed it is more difficult to detect=
 that
>> >> condition if the cluster is shared. I suspect that with a bit of thin=
king, we
>> >> could find a way though.
>> >
>> > Kaiui has  the patch series show a good performance number that beats
>> > the current swap cache reclaim.
>> >
>> > I want to make a point regarding the patch ordering before vs after
>> > patch 3 (aka the big rewrite).
>> > Previously, the "san_swap_map_try_ssd_cluster" only did partial
>> > allocation. It does not sucessfully allocate a swap entry 100% the
>> > time.  The patch 3 makes the cluster allocation function return the
>> > swap entry 100% of the time. There are no more fallback retry loops
>> > outside of the cluster allocation function. Also the try_ssd function
>> > does not do swap cache reclaims while the cluster allocation function
>> > will need to. These two have very different constraints.
>> >
>> > There for, adding different cluster header into
>> > san_swap_map_try_ssd_cluste will be a lot of waste investment of
>> > development time in the sense that, that function will need to be
>> > rewrite any way, the end result is very different.
>>
>> I am not a big fan of implementing the final solution directly.
>> Personally, I prefer to improve step by step.
>
> The current proposed order also improves things step by step. The only
> disagreement here is which patch order we introduce yet another list
> in addition to the nonfull one. I just feel that it does not make
> sense to invest into new code if that new code is going to be
> completely rewrite anyway in the next two patches.
>
> Unless you mean is we should not do the patch 3 big rewrite and should
> continue the scan_swap_map_try_ssd_cluster() way of only doing half of
> the allocation job and let scan_swap_map_slots() do the complex retry
> on top of try_ssd(). I feel the overall code is more complex and less
> maintainable.

I haven't look at [3/3], will wait for your next version for that.  So,
I cannot say which order is better.  Please consider reviewers' effort
too.  Small step patch is easier to be understood and reviewed.

>> > That is why I want to make this change patch after patch 3. There is
>> > also the long test cycle after the modification to make sure the swap
>> > code path is stable. I am not resisting a change of patch orders, it
>> > is that patch can't directly be removed before patch 3 before the big
>> > rewrite.
>> >
>> >
>> >>
>> >> > Your original
>> >> > suggestion appears like that you want to keep all cluster with orde=
r-N
>> >> > on the nonfull list for order-N always unless the number of free sw=
ap
>> >> > entry is less than 1<<N.
>> >>
>> >> Well I think that's certainly one of the conditions for removing it. =
But agree
>> >> that if a full scan of the cluster has been performed and no swap ent=
ries have
>> >> been freed since the scan started then it should also be removed from=
 the list.
>> >
>> > Yes, in the later patch of patch, beyond patch 3, we have the almost
>> > full cluster that for the cluster has been scan and not able to
>> > allocate order N entry.
>> >
>> >>
>> >> >
>> >> >>> And, I understand that in some situations it may
>> >> >>> be better to share clusters among CPUs.  So my suggestion is,
>> >> >>>
>> >> >>> - Make swap_cluster_info->order more accurate, don't pretend that=
 we
>> >> >>>   have free swap entries with that order even after we are sure t=
hat we
>> >> >>>   haven't.
>> >> >>
>> >> >> Is this patch pretending that today? I don't think so?
>> >> >
>> >> > IIUC, in this patch swap_cluster_info->order is still "N" even if w=
e are
>> >> > sure that there are no order-N free swap entry in the cluster.
>> >>
>> >> Oh I see what you mean. I think you and Chris already discussed this?=
 IIRC
>> >> Chris's point was that if you move that cluster to N-1, eventually al=
l clusters
>> >> are for order-0 and you have no means of allocating high orders until=
 a whole
>> >> cluster becomes free. That logic certainly makes sense to me, so thin=
k its
>> >> better for swap_cluster_info->order to remain static while the cluste=
r is
>> >> allocated. (I only skimmed that conversation so appologies if I got t=
he
>> >> conclusion wrong!).
>> >
>> > Yes, that is the original intent, keep the cluster order as much as po=
ssible.
>> >
>> >>
>> >> >
>> >> >> But I agree that a
>> >> >> cluster should only be on the per-order nonfull list if we know th=
ere are at
>> >> >> least enough free swap entries in that cluster to cover the order.=
 Of course
>> >> >> that doesn't tell us for sure because they may not be contiguous.
>> >> >
>> >> > We can check that when free swap entry via checking adjacent swap
>> >> > entries.  IMHO, the performance should be acceptable.
>> >>
>> >> Would you then use the result of that scanning to "promote" a cluster=
's order?
>> >> e.g. swap_cluster_info->order =3D N+1? That would be neat. But this a=
ll feels like
>> >> a separate change on top of what Chris is doing here. For high orders=
 there
>> >> could be quite a bit of scanning required in the worst case for every=
 page that
>> >> gets freed.
>> >
>> > Right, I feel that is a different set of patches. Even this series is
>> > hard enough for review. Those order promotion and demotion is heading
>> > towards a buddy system design. I want to point out that even the buddy
>> > system is not able to handle the case that swapfile is almost full and
>> > the recently freed swap entries are not contiguous.
>> >
>> > We can invest in the buddy system, which doesn't handle all the
>> > fragmentation issues. Or I prefer to go directly to the discontiguous
>> > swap entry. We pay a price for the indirect mapping of swap entries.
>> > But it will solve the fragmentation issue 100%.
>>
>> It's good if we can solve the fragmentation issue 100%.  Just need to
>> pay attention to the cost.
>
> The cost you mean the development cost or the run time cost (memory and c=
pu)?

I mean runtime cost.

>>
>> >>
>> >> >
>> >> >>>
>> >> >>> My question is whether it's so important to share the per-cpu clu=
ster
>> >> >>> among CPUs?
>> >> >>
>> >> >> My rationale for sharing is that the preference previously has bee=
n to favour
>> >> >> efficient use of swap space; we don't want to fail a request for a=
llocation of a
>> >> >> given order if there are actually slots available just because the=
y have been
>> >> >> reserved by another CPU. And I'm still asserting that it should be=
 ~zero cost to
>> >> >> do this. If I'm wrong about the zero cost, or in practice the shar=
ing doesn't
>> >> >> actually help improve allocation success, then I'm happy to take t=
he exclusive
>> >> >> approach.
>> >> >>
>> >> >>> I suggest to start with simple design, that is, per-CPU
>> >> >>> cluster will not be shared among CPUs in most cases.
>> >> >>
>> >> >> I'm all for starting simple; I think that's what I already propose=
d (exclusive
>> >> >> in this patch, then shared in the "big rewrite"). I'm just objecti=
ng to the
>> >> >> current half-and-half policy in this patch.
>> >> >
>> >> > Sounds good to me.  We can start with exclusive solution and evalua=
te
>> >> > whether shared solution is good.
>> >>
>> >> Yep. And also evaluate the dynamic order inc/dec idea too...
>> >
>> > It is not able to avoid fragementation 100% of the time. I prefer the
>> > discontinued swap entry as the next step, which guarantees forward
>> > progress, we will not be stuck in a situation where we are not able to
>> > allocate swap entries due to fragmentation.
>>
>> If my understanding were correct, the implementation complexity of the
>> order promotion/demotion isn't at the same level of that of discontinued
>> swap entry.
>
> Discontinued swap entry has higher complexity but higher payout as
> well. It can get us to the place where cluster promotion/demotion
> can't.
>
> I also feel that if we implement something towards a buddy system
> allocator for swap, we should do a proper buddy allocator
> implementation of data structures.

I don't think that it's easy to implement a real buddy allocator for
swap entries.  So, I avoid to use buddy in my words.

--
Best Regards,
Huang, Ying

