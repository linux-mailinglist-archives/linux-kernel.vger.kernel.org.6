Return-Path: <linux-kernel+bounces-262859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D892793CDEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BD41C20C70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3B172BBC;
	Fri, 26 Jul 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwUtWA7X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743C25624
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973956; cv=none; b=uEto+EZrSml1/XQ6HfOy3uVCgAaFQjoFxHfSZouH+rkk5pkJGGc7c8tcdaisHMV/GHY1T6TSJvaykIIzqErg27bvLAkyqOjSulKIQZCi3wVFjZphOxJIs+Z1I65/Ah0zxB0/+8fqCvkFKweUIF7katkCTyruc2fx3HEp5RCst7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973956; c=relaxed/simple;
	bh=GkclUsGZjjv+mhGeIqiCcLmIwUpgcXUJl9zbyqycT8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpM6FoCUgRkVkd1lySt+/0BMrXpZnrpaeqMSA3ErdqI5h4baXa4CkGX+2X20MjJZZjEiJNYx7NajA7YlJxrw6jNsenrzgcn5u4j2fs86JQp7u8cPpIgyJWX4BsA/yvg6asOAUIKFodzU2IBYHw1E78tlP3HuxUy+LI7iWBStDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwUtWA7X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721973955; x=1753509955;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=GkclUsGZjjv+mhGeIqiCcLmIwUpgcXUJl9zbyqycT8M=;
  b=jwUtWA7XOdJOEl2m7aZz0ZuGOtbbw6XZwYenc6Yrtqafvi4vOnDv9cu/
   1Ua1Bt+r1JZXQ7lQ18oKy79pvKwgoq9jVYkXxhs21qU6cKX//eEOalPfa
   hCsz+SV9VvihtBxThmLzk8lh6OSPhaeSZlsb0/3K3Bkq15JRle9IJRYMf
   SnG0q+YEpBdoSWfxCnsXyErwEwNfBa9qcD7IYLu1GS6iPP5OVNpuj3Mje
   CoRcZ4gaWHwQheha7ir7U8Q6qiL1RSY6ODy+axr82ayMCJVpXJD4Im2Zt
   K50f/91fGuFr6pDYQ5KJUNyWl6tuRbn4POgKRnaDqhn0KSR3td/u5El3N
   w==;
X-CSE-ConnectionGUID: cIp3OXu+Q6y9zYN/afkBQQ==
X-CSE-MsgGUID: FTwzOrrSRHue9nptX/5QVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="22665570"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="22665570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 23:05:54 -0700
X-CSE-ConnectionGUID: 9re6eL1ZS4mdHEVy/CbCIg==
X-CSE-MsgGUID: 3Fmd0MnHQ5i9TUJgXEcC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="57991925"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 23:05:52 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbWW6YLZe=47+kfuz76J+WWGmfKHvqatGGm=RyRX=D-WeQ@mail.gmail.com>
	(Chris Li's message of "Thu, 25 Jul 2024 22:09:25 -0700")
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
	<87v80s3nvs.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbWW6YLZe=47+kfuz76J+WWGmfKHvqatGGm=RyRX=D-WeQ@mail.gmail.com>
Date: Fri, 26 Jul 2024 14:02:19 +0800
Message-ID: <87jzh83d3o.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jul 25, 2024 at 7:13=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>> >
>> > The current proposed order also improves things step by step. The only
>> > disagreement here is which patch order we introduce yet another list
>> > in addition to the nonfull one. I just feel that it does not make
>> > sense to invest into new code if that new code is going to be
>> > completely rewrite anyway in the next two patches.
>> >
>> > Unless you mean is we should not do the patch 3 big rewrite and should
>> > continue the scan_swap_map_try_ssd_cluster() way of only doing half of
>> > the allocation job and let scan_swap_map_slots() do the complex retry
>> > on top of try_ssd(). I feel the overall code is more complex and less
>> > maintainable.
>>
>> I haven't look at [3/3], will wait for your next version for that.  So,
>> I cannot say which order is better.  Please consider reviewers' effort
>> too.  Small step patch is easier to be understood and reviewed.
>
> That is exactly the reason I don't want to introduce too much new code
> depending on the scan_swap_map_slots() behavior, which will be
> abandoned in the big rewrite. Their constraints are very different. I
> want to make the big rewrite patch 3 as small as possible. Using
> incremental follow up patches to improve it.
>
>>
>> >> > That is why I want to make this change patch after patch 3. There is
>> >> > also the long test cycle after the modification to make sure the sw=
ap
>> >> > code path is stable. I am not resisting a change of patch orders, it
>> >> > is that patch can't directly be removed before patch 3 before the b=
ig
>> >> > rewrite.
>> >> >
>> >> >
>> >> >>
>> >> >> > Your original
>> >> >> > suggestion appears like that you want to keep all cluster with o=
rder-N
>> >> >> > on the nonfull list for order-N always unless the number of free=
 swap
>> >> >> > entry is less than 1<<N.
>> >> >>
>> >> >> Well I think that's certainly one of the conditions for removing i=
t. But agree
>> >> >> that if a full scan of the cluster has been performed and no swap =
entries have
>> >> >> been freed since the scan started then it should also be removed f=
rom the list.
>> >> >
>> >> > Yes, in the later patch of patch, beyond patch 3, we have the almost
>> >> > full cluster that for the cluster has been scan and not able to
>> >> > allocate order N entry.
>> >> >
>> >> >>
>> >> >> >
>> >> >> >>> And, I understand that in some situations it may
>> >> >> >>> be better to share clusters among CPUs.  So my suggestion is,
>> >> >> >>>
>> >> >> >>> - Make swap_cluster_info->order more accurate, don't pretend t=
hat we
>> >> >> >>>   have free swap entries with that order even after we are sur=
e that we
>> >> >> >>>   haven't.
>> >> >> >>
>> >> >> >> Is this patch pretending that today? I don't think so?
>> >> >> >
>> >> >> > IIUC, in this patch swap_cluster_info->order is still "N" even i=
f we are
>> >> >> > sure that there are no order-N free swap entry in the cluster.
>> >> >>
>> >> >> Oh I see what you mean. I think you and Chris already discussed th=
is? IIRC
>> >> >> Chris's point was that if you move that cluster to N-1, eventually=
 all clusters
>> >> >> are for order-0 and you have no means of allocating high orders un=
til a whole
>> >> >> cluster becomes free. That logic certainly makes sense to me, so t=
hink its
>> >> >> better for swap_cluster_info->order to remain static while the clu=
ster is
>> >> >> allocated. (I only skimmed that conversation so appologies if I go=
t the
>> >> >> conclusion wrong!).
>> >> >
>> >> > Yes, that is the original intent, keep the cluster order as much as=
 possible.
>> >> >
>> >> >>
>> >> >> >
>> >> >> >> But I agree that a
>> >> >> >> cluster should only be on the per-order nonfull list if we know=
 there are at
>> >> >> >> least enough free swap entries in that cluster to cover the ord=
er. Of course
>> >> >> >> that doesn't tell us for sure because they may not be contiguou=
s.
>> >> >> >
>> >> >> > We can check that when free swap entry via checking adjacent swap
>> >> >> > entries.  IMHO, the performance should be acceptable.
>> >> >>
>> >> >> Would you then use the result of that scanning to "promote" a clus=
ter's order?
>> >> >> e.g. swap_cluster_info->order =3D N+1? That would be neat. But thi=
s all feels like
>> >> >> a separate change on top of what Chris is doing here. For high ord=
ers there
>> >> >> could be quite a bit of scanning required in the worst case for ev=
ery page that
>> >> >> gets freed.
>> >> >
>> >> > Right, I feel that is a different set of patches. Even this series =
is
>> >> > hard enough for review. Those order promotion and demotion is headi=
ng
>> >> > towards a buddy system design. I want to point out that even the bu=
ddy
>> >> > system is not able to handle the case that swapfile is almost full =
and
>> >> > the recently freed swap entries are not contiguous.
>> >> >
>> >> > We can invest in the buddy system, which doesn't handle all the
>> >> > fragmentation issues. Or I prefer to go directly to the discontiguo=
us
>> >> > swap entry. We pay a price for the indirect mapping of swap entries.
>> >> > But it will solve the fragmentation issue 100%.
>> >>
>> >> It's good if we can solve the fragmentation issue 100%.  Just need to
>> >> pay attention to the cost.
>> >
>> > The cost you mean the development cost or the run time cost (memory an=
d cpu)?
>>
>> I mean runtime cost.
>
> Thanks for the clarification. Agree that we need to pay attention to
> the run time cost. That is given.
>
>> >> >> >>> My question is whether it's so important to share the per-cpu =
cluster
>> >> >> >>> among CPUs?
>> >> >> >>
>> >> >> >> My rationale for sharing is that the preference previously has =
been to favour
>> >> >> >> efficient use of swap space; we don't want to fail a request fo=
r allocation of a
>> >> >> >> given order if there are actually slots available just because =
they have been
>> >> >> >> reserved by another CPU. And I'm still asserting that it should=
 be ~zero cost to
>> >> >> >> do this. If I'm wrong about the zero cost, or in practice the s=
haring doesn't
>> >> >> >> actually help improve allocation success, then I'm happy to tak=
e the exclusive
>> >> >> >> approach.
>> >> >> >>
>> >> >> >>> I suggest to start with simple design, that is, per-CPU
>> >> >> >>> cluster will not be shared among CPUs in most cases.
>> >> >> >>
>> >> >> >> I'm all for starting simple; I think that's what I already prop=
osed (exclusive
>> >> >> >> in this patch, then shared in the "big rewrite"). I'm just obje=
cting to the
>> >> >> >> current half-and-half policy in this patch.
>> >> >> >
>> >> >> > Sounds good to me.  We can start with exclusive solution and eva=
luate
>> >> >> > whether shared solution is good.
>> >> >>
>> >> >> Yep. And also evaluate the dynamic order inc/dec idea too...
>> >> >
>> >> > It is not able to avoid fragementation 100% of the time. I prefer t=
he
>> >> > discontinued swap entry as the next step, which guarantees forward
>> >> > progress, we will not be stuck in a situation where we are not able=
 to
>> >> > allocate swap entries due to fragmentation.
>> >>
>> >> If my understanding were correct, the implementation complexity of the
>> >> order promotion/demotion isn't at the same level of that of discontin=
ued
>> >> swap entry.
>> >
>> > Discontinued swap entry has higher complexity but higher payout as
>> > well. It can get us to the place where cluster promotion/demotion
>> > can't.
>> >
>> > I also feel that if we implement something towards a buddy system
>> > allocator for swap, we should do a proper buddy allocator
>> > implementation of data structures.
>>
>> I don't think that it's easy to implement a real buddy allocator for
>> swap entries.  So, I avoid to use buddy in my words.
>
> Then such a mix of cluster order promote/demote lose some benefit of
> the buddy system. Because it lacks the proper data structure to
> support buddy allocation. The buddy allocator provides more general
> migration between orders. For the limited usage case of cluster
> promotion/demotion is supported (by luck). We need to evaluate whether
> it is worth the additional complexity.

TBH, I believe that the complexity of order promote/demote is quite low,
both for development and runtime.  A real buddy allocator may need to
increase per-swap-entry memory footprint much.

--
Best Regards,
Huang, Ying

