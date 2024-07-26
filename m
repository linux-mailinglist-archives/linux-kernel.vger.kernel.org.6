Return-Path: <linux-kernel+bounces-262949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31593CEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327ED1C21620
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539517623E;
	Fri, 26 Jul 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7V7YA9G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B237E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979997; cv=none; b=G9OUb8jhYh3ubK0ZVs7RUF/g/J53Oa7Gc+gkFuXJeF955J2JwMIKPXwTNTDMJfmYI5Fzcn+pLVGcM1RWAltQ+XMNDS6Qeo5sPUJmOAr/x7EVqUNt55PPMTB5EieqI93loVKwCEidVjPNxX6j0+aQD/hZFrBluq29j5fHdlpSYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979997; c=relaxed/simple;
	bh=4dkOgTz+W+CPhX5MUDdwMnAzYZgSGUV44WKSHTwfMDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAtHfKLhQs4LyQyutIeJs/pITA7wESIpqHhfrBr3DfWcYtJGudM5W/+ViHiajq+FQOGAs51iT77QpEJGWRhLRRtuBtL+WGAkr6UeKhBHHW/NT6K3lMxFxNnMVzXt7NaFfRlo8kRhCL5WXDAZWdW98dOpur1hWa5DgflhEVtjbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7V7YA9G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721979996; x=1753515996;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4dkOgTz+W+CPhX5MUDdwMnAzYZgSGUV44WKSHTwfMDs=;
  b=R7V7YA9GHmrbX/tOoxXxQeECMlL8ax5bM81aEiHWQ4MZ9XzXY6dKaSYT
   6qZsVEk7xZmL0Nu69ePt2yIl6wmGMTFFve4rn/+TYh4eQzNFhNrMBkHaE
   F/DssYVklt3wwi2oQKT7hQU5PKPZP39uKIwLIBv2rdDxdmlx5vlUDNNGs
   bMV7RUkLgZcR9kg2etrgrYf8UapxacmJaLvK+8+ppjLkNkMibR0Www7HP
   nxQIp777/AwuIFxAdx6aHIjF6vycg1h1QGCaY5sG5Ni1AA/sY1cNCaqhO
   5H/Fd6VRIZqFdwld++e27PIN7JgHG2JjIj30QhKYPxrqH/NWgvfLnWenL
   A==;
X-CSE-ConnectionGUID: knqsCHsGRnGjNF4xJl0Tbg==
X-CSE-MsgGUID: bcT0HOdtRaG9ftzI801/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23519354"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="23519354"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:46:35 -0700
X-CSE-ConnectionGUID: YnW2zew7Tq2LPknE49BQRQ==
X-CSE-MsgGUID: wBgAp7oqQX6RGR1fuBlPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53099844"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:46:32 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbWJ8c8pF0nQ=_bidJU2qoaJn6ygOAGVz4H07Kf0Rzxaag@mail.gmail.com>
	(Chris Li's message of "Fri, 26 Jul 2024 00:15:58 -0700")
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
	<87jzh83d3o.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbWJ8c8pF0nQ=_bidJU2qoaJn6ygOAGVz4H07Kf0Rzxaag@mail.gmail.com>
Date: Fri, 26 Jul 2024 15:42:59 +0800
Message-ID: <87y15o1tvg.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jul 25, 2024 at 11:05=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Thu, Jul 25, 2024 at 7:13=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >> >
>> >> > The current proposed order also improves things step by step. The o=
nly
>> >> > disagreement here is which patch order we introduce yet another list
>> >> > in addition to the nonfull one. I just feel that it does not make
>> >> > sense to invest into new code if that new code is going to be
>> >> > completely rewrite anyway in the next two patches.
>> >> >
>> >> > Unless you mean is we should not do the patch 3 big rewrite and sho=
uld
>> >> > continue the scan_swap_map_try_ssd_cluster() way of only doing half=
 of
>> >> > the allocation job and let scan_swap_map_slots() do the complex ret=
ry
>> >> > on top of try_ssd(). I feel the overall code is more complex and le=
ss
>> >> > maintainable.
>> >>
>> >> I haven't look at [3/3], will wait for your next version for that.  S=
o,
>> >> I cannot say which order is better.  Please consider reviewers' effort
>> >> too.  Small step patch is easier to be understood and reviewed.
>> >
>> > That is exactly the reason I don't want to introduce too much new code
>> > depending on the scan_swap_map_slots() behavior, which will be
>> > abandoned in the big rewrite. Their constraints are very different. I
>> > want to make the big rewrite patch 3 as small as possible. Using
>> > incremental follow up patches to improve it.
>> >
>> >>
>> >> >> > That is why I want to make this change patch after patch 3. Ther=
e is
>> >> >> > also the long test cycle after the modification to make sure the=
 swap
>> >> >> > code path is stable. I am not resisting a change of patch orders=
, it
>> >> >> > is that patch can't directly be removed before patch 3 before th=
e big
>> >> >> > rewrite.
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> > Your original
>> >> >> >> > suggestion appears like that you want to keep all cluster wit=
h order-N
>> >> >> >> > on the nonfull list for order-N always unless the number of f=
ree swap
>> >> >> >> > entry is less than 1<<N.
>> >> >> >>
>> >> >> >> Well I think that's certainly one of the conditions for removin=
g it. But agree
>> >> >> >> that if a full scan of the cluster has been performed and no sw=
ap entries have
>> >> >> >> been freed since the scan started then it should also be remove=
d from the list.
>> >> >> >
>> >> >> > Yes, in the later patch of patch, beyond patch 3, we have the al=
most
>> >> >> > full cluster that for the cluster has been scan and not able to
>> >> >> > allocate order N entry.
>> >> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> >>> And, I understand that in some situations it may
>> >> >> >> >>> be better to share clusters among CPUs.  So my suggestion i=
s,
>> >> >> >> >>>
>> >> >> >> >>> - Make swap_cluster_info->order more accurate, don't preten=
d that we
>> >> >> >> >>>   have free swap entries with that order even after we are =
sure that we
>> >> >> >> >>>   haven't.
>> >> >> >> >>
>> >> >> >> >> Is this patch pretending that today? I don't think so?
>> >> >> >> >
>> >> >> >> > IIUC, in this patch swap_cluster_info->order is still "N" eve=
n if we are
>> >> >> >> > sure that there are no order-N free swap entry in the cluster.
>> >> >> >>
>> >> >> >> Oh I see what you mean. I think you and Chris already discussed=
 this? IIRC
>> >> >> >> Chris's point was that if you move that cluster to N-1, eventua=
lly all clusters
>> >> >> >> are for order-0 and you have no means of allocating high orders=
 until a whole
>> >> >> >> cluster becomes free. That logic certainly makes sense to me, s=
o think its
>> >> >> >> better for swap_cluster_info->order to remain static while the =
cluster is
>> >> >> >> allocated. (I only skimmed that conversation so appologies if I=
 got the
>> >> >> >> conclusion wrong!).
>> >> >> >
>> >> >> > Yes, that is the original intent, keep the cluster order as much=
 as possible.
>> >> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> >> But I agree that a
>> >> >> >> >> cluster should only be on the per-order nonfull list if we k=
now there are at
>> >> >> >> >> least enough free swap entries in that cluster to cover the =
order. Of course
>> >> >> >> >> that doesn't tell us for sure because they may not be contig=
uous.
>> >> >> >> >
>> >> >> >> > We can check that when free swap entry via checking adjacent =
swap
>> >> >> >> > entries.  IMHO, the performance should be acceptable.
>> >> >> >>
>> >> >> >> Would you then use the result of that scanning to "promote" a c=
luster's order?
>> >> >> >> e.g. swap_cluster_info->order =3D N+1? That would be neat. But =
this all feels like
>> >> >> >> a separate change on top of what Chris is doing here. For high =
orders there
>> >> >> >> could be quite a bit of scanning required in the worst case for=
 every page that
>> >> >> >> gets freed.
>> >> >> >
>> >> >> > Right, I feel that is a different set of patches. Even this seri=
es is
>> >> >> > hard enough for review. Those order promotion and demotion is he=
ading
>> >> >> > towards a buddy system design. I want to point out that even the=
 buddy
>> >> >> > system is not able to handle the case that swapfile is almost fu=
ll and
>> >> >> > the recently freed swap entries are not contiguous.
>> >> >> >
>> >> >> > We can invest in the buddy system, which doesn't handle all the
>> >> >> > fragmentation issues. Or I prefer to go directly to the disconti=
guous
>> >> >> > swap entry. We pay a price for the indirect mapping of swap entr=
ies.
>> >> >> > But it will solve the fragmentation issue 100%.
>> >> >>
>> >> >> It's good if we can solve the fragmentation issue 100%.  Just need=
 to
>> >> >> pay attention to the cost.
>> >> >
>> >> > The cost you mean the development cost or the run time cost (memory=
 and cpu)?
>> >>
>> >> I mean runtime cost.
>> >
>> > Thanks for the clarification. Agree that we need to pay attention to
>> > the run time cost. That is given.
>> >
>> >> >> >> >>> My question is whether it's so important to share the per-c=
pu cluster
>> >> >> >> >>> among CPUs?
>> >> >> >> >>
>> >> >> >> >> My rationale for sharing is that the preference previously h=
as been to favour
>> >> >> >> >> efficient use of swap space; we don't want to fail a request=
 for allocation of a
>> >> >> >> >> given order if there are actually slots available just becau=
se they have been
>> >> >> >> >> reserved by another CPU. And I'm still asserting that it sho=
uld be ~zero cost to
>> >> >> >> >> do this. If I'm wrong about the zero cost, or in practice th=
e sharing doesn't
>> >> >> >> >> actually help improve allocation success, then I'm happy to =
take the exclusive
>> >> >> >> >> approach.
>> >> >> >> >>
>> >> >> >> >>> I suggest to start with simple design, that is, per-CPU
>> >> >> >> >>> cluster will not be shared among CPUs in most cases.
>> >> >> >> >>
>> >> >> >> >> I'm all for starting simple; I think that's what I already p=
roposed (exclusive
>> >> >> >> >> in this patch, then shared in the "big rewrite"). I'm just o=
bjecting to the
>> >> >> >> >> current half-and-half policy in this patch.
>> >> >> >> >
>> >> >> >> > Sounds good to me.  We can start with exclusive solution and =
evaluate
>> >> >> >> > whether shared solution is good.
>> >> >> >>
>> >> >> >> Yep. And also evaluate the dynamic order inc/dec idea too...
>> >> >> >
>> >> >> > It is not able to avoid fragementation 100% of the time. I prefe=
r the
>> >> >> > discontinued swap entry as the next step, which guarantees forwa=
rd
>> >> >> > progress, we will not be stuck in a situation where we are not a=
ble to
>> >> >> > allocate swap entries due to fragmentation.
>> >> >>
>> >> >> If my understanding were correct, the implementation complexity of=
 the
>> >> >> order promotion/demotion isn't at the same level of that of discon=
tinued
>> >> >> swap entry.
>> >> >
>> >> > Discontinued swap entry has higher complexity but higher payout as
>> >> > well. It can get us to the place where cluster promotion/demotion
>> >> > can't.
>> >> >
>> >> > I also feel that if we implement something towards a buddy system
>> >> > allocator for swap, we should do a proper buddy allocator
>> >> > implementation of data structures.
>> >>
>> >> I don't think that it's easy to implement a real buddy allocator for
>> >> swap entries.  So, I avoid to use buddy in my words.
>> >
>> > Then such a mix of cluster order promote/demote lose some benefit of
>> > the buddy system. Because it lacks the proper data structure to
>> > support buddy allocation. The buddy allocator provides more general
>> > migration between orders. For the limited usage case of cluster
>> > promotion/demotion is supported (by luck). We need to evaluate whether
>> > it is worth the additional complexity.
>>
>> TBH, I believe that the complexity of order promote/demote is quite low,
>> both for development and runtime.  A real buddy allocator may need to
>> increase per-swap-entry memory footprint much.
>
> I mostly concern its effectiveness. Anyway, the series is already
> complex enough with the big rewrite and reclaim on swap cache.
>
> Let me know if you think it needs to be done before the big rewrite.

I hope so.  But, I will not force you to do that if you don't buy in it.

--
Best Regards,
Huang, Ying

