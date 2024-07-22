Return-Path: <linux-kernel+bounces-258401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ABE938782
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A9CB20D52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CAFF9D4;
	Mon, 22 Jul 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0cl4VZn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9E1849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721614661; cv=none; b=qoUelgnCzZ5ZM9qm3sZjat4a/UO9HyPk0gZ+6swxLCRMY2e1WnWty7aTT8MBgAHzGtr9GgT9TxWEjhlxpFYizd0kc8UmuCp/QN7jXmLEtOjmpStJBGRCf19NlcZoxs8AUsvdXOwIQz30kh8QgyYjbjuXVu3E8yXiUfhsHUv2NYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721614661; c=relaxed/simple;
	bh=9WpNI1lqce4FVULvexJBf8KieXCM0lVlLQAIpUtTnGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMlNbt+gxUz5ue3ec2raPC2ubbKeruoNvjdF+oQJYcoFkP++L0cO28Zy6+PashRfTOkc/vuNhbWFRrV0/58KKrmt+6WTQCqjLw8fn0K0xQKnH5MxFDz3kpMZdPgAOPaaTIsVbC5Up7uSP7/KKP2Nrx19V2U0KsKomnlYYSDBMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0cl4VZn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721614660; x=1753150660;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9WpNI1lqce4FVULvexJBf8KieXCM0lVlLQAIpUtTnGM=;
  b=W0cl4VZnekleLJOOSaSKCkkym20A+yMHl7gcau/acYwlWQBlbKYf1oLK
   Tg31NBEsOLJanu1ejVf2h1Dv/H6ghOhRF9qBPOALm00ytRla9r4BZKqXL
   TC2KQCjtoDgZcDAa/Ax8etcuXaIwHhqVQATEygAv3Y6zVk078ZO2guY1C
   LyOPHa9cSt0lmUloGDlp7X17c7OVOBFLc+8u7lPAk0X2Qq1ffsD5bO/vs
   OIOh+kFJq3EJklH0M2GphoBQgQnwkXHxH3h0uen4I2o793q8mTvmPqbkM
   Q8qwDntZj3LEO7OT+5AhgbFDqo7XEkoctJL0AKTll6/lNg9lRuNWpBROP
   A==;
X-CSE-ConnectionGUID: WYx29nkOS3e8ruhVmQ+vyA==
X-CSE-MsgGUID: 2bsSJpRiRc6CwNzOdUULjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="44588126"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="44588126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 19:17:39 -0700
X-CSE-ConnectionGUID: dC9FdTT+SNuRMARWnklLsw==
X-CSE-MsgGUID: sN+6lOviTeKtYcDGrQ1b2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56831651"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 19:17:37 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com> (Ryan Roberts's
	message of "Fri, 19 Jul 2024 11:30:25 +0100")
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
	<20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
	<ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
	<CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
	<b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
	<CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
	<874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
Date: Mon, 22 Jul 2024 10:14:03 +0800
Message-ID: <87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 18/07/2024 08:53, Huang, Ying wrote:
>> Chris Li <chrisl@kernel.org> writes:
>>=20
>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
>>>>
>>>> On 16/07/2024 23:46, Chris Li wrote:
>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
>>>>>>
>>>>>> On 11/07/2024 08:29, Chris Li wrote:

[snip]

>>>>>>> +
>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->ord=
er]);
>>>>>>
>>>>>> I find the transitions when you add and remove a cluster from the
>>>>>> nonfull_clusters list a bit strange (if I've understood correctly): =
It is added
>>>>>> to the list whenever there is at least one free swap entry if not al=
ready on the
>>>>>> list. But you take it off the list when assigning it as the current =
cluster for
>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>>>>>>
>>>>>> So you could have this situation:
>>>>>>
>>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu)
>>>>>>   - cpuA allocs 1 swap entry from current cluster
>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>>>>>>
>>>>>> At this point both cpuA and cpuB share the same cluster as their cur=
rent
>>>>>> cluster. So why not just put the cluster on the nonfull_clusters lis=
t at
>>>>>> allocation time (when removed from free_list) and only remove it fro=
m the
>>>>>
>>>>> The big rewrite on patch 3 does that, taking it off the free list and
>>>>> moving it into nonfull.
>>>>
>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
>>>> scan_swap_map_slots()" I assumed that was just a refactoring of the co=
de to
>>>> separate the SSD and HDD code paths. Personally I'd prefer to see the
>>>> refactoring separated from behavioural changes.
>>>
>>> It is not a refactoring. It is a big rewrite of the swap allocator
>>> using the cluster. Behavior change is expected. The goal is completely
>>> removing the brute force scanning of swap_map[] array for cluster swap
>>> allocation.
>>>
>>>>
>>>> Since the patch was titled RFC and I thought it was just refactoring, =
I was
>>>> deferring review. But sounds like it is actually required to realize t=
he test
>>>> results quoted on the cover letter?
>>>
>>> Yes, required because it handles the previous fall out case try_ssd()
>>> failed. This big rewrite has gone through a lot of testing and bug
>>> fix. It is pretty stable now. The only reason I keep it as RFC is
>>> because it is not feature complete. Currently it does not do swap
>>> cache reclaim. The next version will have swap cache reclaim and
>>> remove the RFC.
>>>
>>>>
>>>>> I am only making the minimal change in this step so the big rewrite c=
an land.
>>>>>
>>>>>> nonfull_clusters list when it is completely full (or at least defini=
tely doesn't
>>>>>> have room for an `order` allocation)? Then you allow "stealing" alwa=
ys instead
>>>>>> of just sometimes. You would likely want to move the cluster to the =
end of the
>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_cluster() to=
 reduce the
>>>>>> chances of multiple CPUs using the same cluster.
>>>>>
>>>>> For nonfull clusters it is less important to avoid multiple CPU
>>>>> sharing the cluster. Because the cluster already has previous swap
>>>>> entries allocated from the previous CPU.
>>>>
>>>> But if 2 CPUs have the same cluster, isn't there a pathalogical case w=
here cpuA
>>>> could be slightly ahead of cpuB so that cpuA allocates all the free pa=
ges and
>>>
>>> That happens to exist per cpu next pointer already. When the other CPU
>>> advances to the next cluster pointer, it can cross with the other
>>> CPU's next cluster pointer.
>>=20
>> No.  si->percpu_cluster[cpu].next will keep in the current per cpu
>> cluster only.  If it doesn't do that, we should fix it.
>>=20
>> I agree with Ryan that we should make per cpu cluster correct.  A
>> cluster in per cpu cluster shouldn't be put in nonfull list.  When we
>> scan to the end of a per cpu cluster, we can put the cluster in nonfull
>> list if necessary.  And, we should make it correct in this patch instead
>> of later in series.  I understand that you want to make the patch itself
>> simple, but it's important to make code simple to be understood too.
>> Consistent design choice will do that.
>
> I think I'm actually arguing for the opposite of what you suggest here.

Sorry, I misunderstood your words.

> As I see it, there are 2 possible approaches; either a cluster is always
> considered exclusive to a single cpu when its set as a per-cpu cluster, s=
o it
> does not appear on the nonfull list. Or a cluster is considered sharable =
in this
> case, in which case it should be added to the nonfull list.
>
> The code at the moment sort of does both; when a cpu decides to use a clu=
ster in
> the nonfull list, it removes it from that list to make it exclusive. But =
as soon
> as a single swap entry is freed from that cluster it is put back on the l=
ist.
> This neither-one-policy-nor-the-other seems odd to me.
>
> I think Huang, Ying is arguing to keep it always exclusive while installe=
d as a
> per-cpu cluster.

Yes.

> I was arguing to make it always shared. Perhaps the best
> approach is to implement the exclusive policy in this patch (you'd need a=
 flag
> to note if any pages were freed while in exclusive use, then when exclusi=
ve use
> completes, put it back on the nonfull list if the flag was set). Then mig=
rate to
> the shared approach as part of the "big rewrite"?
>>=20
>>>> cpuB just ends up scanning and finding nothing to allocate. I think do=
 want to
>>>> share the cluster when you really need to, but try to avoid it if ther=
e are
>>>> other options, and I think moving the cluster to the end of the list m=
ight be a
>>>> way to help that?
>>>
>>> Simply moving to the end of the list can create a possible deadloop
>>> when all clusters have been scanned and not available swap range
>>> found.

I also think that the shared approach has dead loop issue.

>> This is another reason that we should put the cluster in
>> nonfull_clusters[order--] if there are no free swap entry with "order"
>> in the cluster.  It makes design complex to keep it in
>> nonfull_clusters[order].
>>=20
>>> We have tried many different approaches including moving to the end of
>>> the list. It can cause more fragmentation because each CPU allocates
>>> their swap slot cache (64 entries) from a different cluster.
>>>
>>>>> Those behaviors will be fine
>>>>> tuned after the patch 3 big rewrite. Try to make this patch simple.
>>>
>>> Again, I want to keep it simple here so patch 3 can land.
>>>
>>>>>> Another potential optimization (which was in my hacked version IIRC)=
 is to only
>>>>>> add/remove from nonfull list when `total - count` crosses the (1 << =
order)
>>>>>> boundary rather than when becoming completely full. You definitely w=
on't be able
>>>>>> to allocate order-2 if there are only 3 pages available, for example.
>>>>>
>>>>> That is in patch 3 as well. This patch is just doing the bare minimum
>>>>> to introduce the nonfull list.
>>>>>

[snip]

--
Best Regards,
Huang, Ying

