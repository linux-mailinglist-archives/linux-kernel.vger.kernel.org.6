Return-Path: <linux-kernel+bounces-261840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6F93BCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1416DB21134
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9407916DC1B;
	Thu, 25 Jul 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7+abrNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5C16B389
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890633; cv=none; b=fIqCsi6aFyC7jcUARrqTuNLnoBSECfBuTpVQx5BSc+2Nuzqz0neMmfpWaU9mUlI4WULrJWD5rZ4iKUVmLzavtI3OEQbKJ4HWXHVL+Ms/Ll4aNnBw1w5Nb/7s8owJzPTtwkaImL44PlQS3Yy09gJm4oKg/B0nDrkxwzldKL1aiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890633; c=relaxed/simple;
	bh=/T3+TjUVvYGkGByCF3BLwudneM0vlKjOqw2CmXbgoEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCw+ucC5ptF/xbp+69Wx/lUyX42OuD06dhC0bQwdY/McChZOyn8T0+w1s/WH6QJyN+wHKOPR/CiR1h15SzwGES3IRS/pI0gv/oxHs8QDvYeeawZDBrYFJknBAoKoZTJ8XHPEyb15iU74tnlDsticFF4pDXXCPHemyIlGjSHJzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7+abrNj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721890631; x=1753426631;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/T3+TjUVvYGkGByCF3BLwudneM0vlKjOqw2CmXbgoEc=;
  b=e7+abrNj/l2YiHHHGhO5sCaOVA9HN/mJXHZ1P/dbV2nlKH1BNi/IcusX
   IyT6dz1ecN1VNM2QfJV2n1l1wqo+8EAkyTieLJgkRl/3T9xjxy8/QgV3P
   xi5okJdYj1K9QSiX4TEySt0Dv2kPezU2O8GJEpY9yTxeLNjAXpo0v4GSV
   T/Zpiyp4EYCueEb/FjhlvVV9NLobu04Wl7RU2YogaK0aRGiWW/ZrmI2RY
   CLFoiH7s7s+mEcK1pDhqfaMlH2+BCpBeKIE9tptRQpRheq292MefKDA5V
   cPXYlVYaB5ruuT/QZNBvGz+ZBB6Ow4TCc+oSGgayotuwR297CL63fSp8k
   Q==;
X-CSE-ConnectionGUID: BtLkAvQKQHac201c2n1K8g==
X-CSE-MsgGUID: n3ONsJShQuOJ9R4GHyMCXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30997076"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="30997076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:57:10 -0700
X-CSE-ConnectionGUID: PmnzisSARJGId/0He5fJHw==
X-CSE-MsgGUID: qNt5F0poTZK1eRlwsSef0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52853617"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:57:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  "Kalesh Singh" <kaleshsingh@google.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com> (Ryan Roberts's
	message of "Wed, 24 Jul 2024 09:33:28 +0100")
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
Date: Thu, 25 Jul 2024 14:53:35 +0800
Message-ID: <87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 23/07/2024 07:27, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>=20
>>> On 22/07/2024 09:49, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> On 22/07/2024 03:14, Huang, Ying wrote:
>>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>>
>>>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
>>>>>>>> Chris Li <chrisl@kernel.org> writes:
>>>>>>>>
>>>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.robert=
s@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
>>>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.robe=
rts@arm.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[c=
i->order]);
>>>>>>>>>>>>
>>>>>>>>>>>> I find the transitions when you add and remove a cluster from =
the
>>>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood correc=
tly): It is added
>>>>>>>>>>>> to the list whenever there is at least one free swap entry if =
not already on the
>>>>>>>>>>>> list. But you take it off the list when assigning it as the cu=
rrent cluster for
>>>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>>>>>>>>>>>>
>>>>>>>>>>>> So you could have this situation:
>>>>>>>>>>>>
>>>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu)
>>>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
>>>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>>>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>>>>>>>>>>>>
>>>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as the=
ir current
>>>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_cluste=
rs list at
>>>>>>>>>>>> allocation time (when removed from free_list) and only remove =
it from the
>>>>>>>>>>>
>>>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free li=
st and
>>>>>>>>>>> moving it into nonfull.
>>>>>>>>>>
>>>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
>>>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring of =
the code to
>>>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to se=
e the
>>>>>>>>>> refactoring separated from behavioural changes.
>>>>>>>>>
>>>>>>>>> It is not a refactoring. It is a big rewrite of the swap allocator
>>>>>>>>> using the cluster. Behavior change is expected. The goal is compl=
etely
>>>>>>>>> removing the brute force scanning of swap_map[] array for cluster=
 swap
>>>>>>>>> allocation.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Since the patch was titled RFC and I thought it was just refacto=
ring, I was
>>>>>>>>>> deferring review. But sounds like it is actually required to rea=
lize the test
>>>>>>>>>> results quoted on the cover letter?
>>>>>>>>>
>>>>>>>>> Yes, required because it handles the previous fall out case try_s=
sd()
>>>>>>>>> failed. This big rewrite has gone through a lot of testing and bug
>>>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC is
>>>>>>>>> because it is not feature complete. Currently it does not do swap
>>>>>>>>> cache reclaim. The next version will have swap cache reclaim and
>>>>>>>>> remove the RFC.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> I am only making the minimal change in this step so the big rew=
rite can land.
>>>>>>>>>>>
>>>>>>>>>>>> nonfull_clusters list when it is completely full (or at least =
definitely doesn't
>>>>>>>>>>>> have room for an `order` allocation)? Then you allow "stealing=
" always instead
>>>>>>>>>>>> of just sometimes. You would likely want to move the cluster t=
o the end of the
>>>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_cluste=
r() to reduce the
>>>>>>>>>>>> chances of multiple CPUs using the same cluster.
>>>>>>>>>>>
>>>>>>>>>>> For nonfull clusters it is less important to avoid multiple CPU
>>>>>>>>>>> sharing the cluster. Because the cluster already has previous s=
wap
>>>>>>>>>>> entries allocated from the previous CPU.
>>>>>>>>>>
>>>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogical =
case where cpuA
>>>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the f=
ree pages and
>>>>>>>>>
>>>>>>>>> That happens to exist per cpu next pointer already. When the othe=
r CPU
>>>>>>>>> advances to the next cluster pointer, it can cross with the other
>>>>>>>>> CPU's next cluster pointer.
>>>>>>>>
>>>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per cpu
>>>>>>>> cluster only.  If it doesn't do that, we should fix it.
>>>>>>>>
>>>>>>>> I agree with Ryan that we should make per cpu cluster correct.  A
>>>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  When=
 we
>>>>>>>> scan to the end of a per cpu cluster, we can put the cluster in no=
nfull
>>>>>>>> list if necessary.  And, we should make it correct in this patch i=
nstead
>>>>>>>> of later in series.  I understand that you want to make the patch =
itself
>>>>>>>> simple, but it's important to make code simple to be understood to=
o.
>>>>>>>> Consistent design choice will do that.
>>>>>>>
>>>>>>> I think I'm actually arguing for the opposite of what you suggest h=
ere.
>>>>>>
>>>>>> Sorry, I misunderstood your words.
>>>>>>
>>>>>>> As I see it, there are 2 possible approaches; either a cluster is a=
lways
>>>>>>> considered exclusive to a single cpu when its set as a per-cpu clus=
ter, so it
>>>>>>> does not appear on the nonfull list. Or a cluster is considered sha=
rable in this
>>>>>>> case, in which case it should be added to the nonfull list.
>>>>>>>
>>>>>>> The code at the moment sort of does both; when a cpu decides to use=
 a cluster in
>>>>>>> the nonfull list, it removes it from that list to make it exclusive=
. But as soon
>>>>>>> as a single swap entry is freed from that cluster it is put back on=
 the list.
>>>>>>> This neither-one-policy-nor-the-other seems odd to me.
>>>>>>>
>>>>>>> I think Huang, Ying is arguing to keep it always exclusive while in=
stalled as a
>>>>>>> per-cpu cluster.
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>> I was arguing to make it always shared. Perhaps the best
>>>>>>> approach is to implement the exclusive policy in this patch (you'd =
need a flag
>>>>>>> to note if any pages were freed while in exclusive use, then when e=
xclusive use
>>>>>>> completes, put it back on the nonfull list if the flag was set). Th=
en migrate to
>>>>>>> the shared approach as part of the "big rewrite"?
>>>>>>>>
>>>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I th=
ink do want to
>>>>>>>>>> share the cluster when you really need to, but try to avoid it i=
f there are
>>>>>>>>>> other options, and I think moving the cluster to the end of the =
list might be a
>>>>>>>>>> way to help that?
>>>>>>>>>
>>>>>>>>> Simply moving to the end of the list can create a possible deadlo=
op
>>>>>>>>> when all clusters have been scanned and not available swap range
>>>>>>>>> found.
>>>>>>
>>>>>> I also think that the shared approach has dead loop issue.
>>>>>
>>>>> What exactly do you mean by dead loop issue? Perhaps you are suggesti=
ng the code
>>>>> won't know when to stop dequeing/requeuing clusters on the nonfull li=
st and will
>>>>> go forever? That's surely just an implementation issue to solve? It's=
 not a
>>>>> reason to avoid the design principle; if we agree that maintaining sh=
arability
>>>>> of the cluster is preferred then the code must be written to guard ag=
ainst the
>>>>> dead loop problem. It could be done by remembering the first cluster =
you
>>>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when yo=
u get back
>>>>> to it. (I think holding the si lock will protect against concurrently=
 freeing
>>>>> the cluster so it should definitely remain in the list?).
>>>>
>>>> I believe that you can find some way to avoid the dead loop issue,
>>>> although your suggestion may kill the performance via looping a long l=
ist
>>>> of nonfull clusters.=20=20
>>>
>>> I don't agree; If the clusters are considered exclusive (i.e. removed f=
rom the
>>> list when made current for a cpu), that only reduces the size of the li=
st by a
>>> maximum of the number of CPUs in the system, which I suspect is pretty =
small
>>> compared to the number of nonfull clusters.
>>=20
>> Anyway, this depends on details.  If we cannot allocate a order-N swap
>> entry from the cluster, we should remove it from the nonfull list for
>> order-N (This is the behavior of this patch too).=20
>
> Yes that's a good point, and I conceed it is more difficult to detect that
> condition if the cluster is shared. I suspect that with a bit of thinking=
, we
> could find a way though.
>
>> Your original
>> suggestion appears like that you want to keep all cluster with order-N
>> on the nonfull list for order-N always unless the number of free swap
>> entry is less than 1<<N.
>
> Well I think that's certainly one of the conditions for removing it. But =
agree
> that if a full scan of the cluster has been performed and no swap entries=
 have
> been freed since the scan started then it should also be removed from the=
 list.
>
>>=20
>>>> And, I understand that in some situations it may
>>>> be better to share clusters among CPUs.  So my suggestion is,
>>>>
>>>> - Make swap_cluster_info->order more accurate, don't pretend that we
>>>>   have free swap entries with that order even after we are sure that we
>>>>   haven't.
>>>
>>> Is this patch pretending that today? I don't think so?
>>=20
>> IIUC, in this patch swap_cluster_info->order is still "N" even if we are
>> sure that there are no order-N free swap entry in the cluster.
>
> Oh I see what you mean. I think you and Chris already discussed this? IIRC
> Chris's point was that if you move that cluster to N-1, eventually all cl=
usters
> are for order-0 and you have no means of allocating high orders until a w=
hole
> cluster becomes free. That logic certainly makes sense to me, so think its
> better for swap_cluster_info->order to remain static while the cluster is
> allocated. (I only skimmed that conversation so appologies if I got the
> conclusion wrong!).
>
>>=20
>>> But I agree that a
>>> cluster should only be on the per-order nonfull list if we know there a=
re at
>>> least enough free swap entries in that cluster to cover the order. Of c=
ourse
>>> that doesn't tell us for sure because they may not be contiguous.
>>=20
>> We can check that when free swap entry via checking adjacent swap
>> entries.  IMHO, the performance should be acceptable.
>
> Would you then use the result of that scanning to "promote" a cluster's o=
rder?
> e.g. swap_cluster_info->order =3D N+1? That would be neat. But this all f=
eels like
> a separate change on top of what Chris is doing here. For high orders the=
re
> could be quite a bit of scanning required in the worst case for every pag=
e that
> gets freed.

We can try to optimize it to control overhead if necessary.

>>=20
>>>>
>>>> My question is whether it's so important to share the per-cpu cluster
>>>> among CPUs?=20
>>>
>>> My rationale for sharing is that the preference previously has been to =
favour
>>> efficient use of swap space; we don't want to fail a request for alloca=
tion of a
>>> given order if there are actually slots available just because they hav=
e been
>>> reserved by another CPU. And I'm still asserting that it should be ~zer=
o cost to
>>> do this. If I'm wrong about the zero cost, or in practice the sharing d=
oesn't
>>> actually help improve allocation success, then I'm happy to take the ex=
clusive
>>> approach.
>>>
>>>> I suggest to start with simple design, that is, per-CPU
>>>> cluster will not be shared among CPUs in most cases.
>>>
>>> I'm all for starting simple; I think that's what I already proposed (ex=
clusive
>>> in this patch, then shared in the "big rewrite"). I'm just objecting to=
 the
>>> current half-and-half policy in this patch.
>>=20
>> Sounds good to me.  We can start with exclusive solution and evaluate
>> whether shared solution is good.
>
> Yep. And also evaluate the dynamic order inc/dec idea too...

Dynamic order inc/dec tries solving a more fundamental problem.  For
example,

- Initially, almost only order-0 pages are swapped out, most non-full
  clusters are order-0.

- Later, quite some order-0 swap entries are freed so that there are
  quite some order-4 swap entries available.

- Order-4 pages need to be swapped out, but no enough order-4 non-full
  clusters available.

So, we need a way to migrate non-full clusters among orders to adjust to
the various situations automatically.

But yes, data is needed for any performance related change.

--
Best Regards,
Huang, Ying

>>=20
>>>>
>>>> Another choice for sharing is when we run short of free swap space, we
>>>> disable per-CPU cluster and allocate from the shared non-full cluster
>>>> list directly.
>>>>
>>>>> Which actually makes me wonder; what is the mechanism that prevents t=
he current
>>>>> per-cpu cluster from being freed? Is that just handled by the conflic=
t detection
>>>>> thingy? Perhaps that would be better handled with a flag to mark it i=
n use, or
>>>>> raise count when its current. (If Chris has implemented that in the "=
big
>>>>> rewrite" patch, sorry, I still haven't gotten around to looking at it=
 :-| )
>>>>
>>>> Yes.  We may need a flag for that.
>>>>
>>>>>>
>>>>>>>> This is another reason that we should put the cluster in
>>>>>>>> nonfull_clusters[order--] if there are no free swap entry with "or=
der"
>>>>>>>> in the cluster.  It makes design complex to keep it in
>>>>>>>> nonfull_clusters[order].
>>>>>>>>
>>>>>>>>> We have tried many different approaches including moving to the e=
nd of
>>>>>>>>> the list. It can cause more fragmentation because each CPU alloca=
tes
>>>>>>>>> their swap slot cache (64 entries) from a different cluster.
>>>>>>>>>
>>>>>>>>>>> Those behaviors will be fine
>>>>>>>>>>> tuned after the patch 3 big rewrite. Try to make this patch sim=
ple.
>>>>>>>>>
>>>>>>>>> Again, I want to keep it simple here so patch 3 can land.
>>>>>>>>>
>>>>>>>>>>>> Another potential optimization (which was in my hacked version=
 IIRC) is to only
>>>>>>>>>>>> add/remove from nonfull list when `total - count` crosses the =
(1 << order)
>>>>>>>>>>>> boundary rather than when becoming completely full. You defini=
tely won't be able
>>>>>>>>>>>> to allocate order-2 if there are only 3 pages available, for e=
xample.
>>>>>>>>>>>
>>>>>>>>>>> That is in patch 3 as well. This patch is just doing the bare m=
inimum
>>>>>>>>>>> to introduce the nonfull list.
>>>>>>>>>>>
>>>>>>
>>>>>> [snip]
>>=20
>> --
>> Best Regards,
>> Huang, Ying

