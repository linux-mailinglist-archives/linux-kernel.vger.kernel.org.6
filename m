Return-Path: <linux-kernel+bounces-262924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A693CEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBFD1C21568
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643615666F;
	Fri, 26 Jul 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZNFA1+2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D80A2A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978498; cv=none; b=cgkeUjV+IEw/nMZdaskIws2caRBbOPvy/3P5j5lEezBJIePSSlSaJnETQq51+4LCJ86tvAgMfnxfbYVYbfpjnKgipzVsUkjYJts2CSQMpXVpa4x+QI2l0GRVN1XHrIwqiX4btVEyEmlQJrXpL7AdJj1IcwZkRY2f9dpAX0gIOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978498; c=relaxed/simple;
	bh=gKrNSgDY0ErL0fBmb3lOUOMz9WR2nuOrqOt+rD3xeWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCBKUVupN6p2UkQp6Bn+mBJd00J3uDYrmthrMmdqenoACCf4CMDiPCSE3W8tyxeqJdn6krMKaFZC9cTS5JWYWfC+Tttmb1CUlju1gdoMWgU52kLIb+/w0vFJUFdUUlI+d97XUWt99eozm5ae9sfRssoBZEuAKj/U85jGQSfGqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZNFA1+2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721978496; x=1753514496;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=gKrNSgDY0ErL0fBmb3lOUOMz9WR2nuOrqOt+rD3xeWQ=;
  b=mZNFA1+2s860sKCNd2jI3TbZLQGzNmqQx0KlynKqublSbHzjphbhE2EQ
   QWCk0d877Gag1I3kCzGMZe/7prtfyyijb0bAlMiG4cBuITwu2muB3nyi/
   7fmriI2GgXqv3gZ+RFHbpH/V4Ss3l9PipOgIglLLl/CQ86SIKgZe/Xjr5
   7xRTWvU8i0UBeOPWl+W35nh8vkIm0jF75IEvUSajUL4eYPsYQ0dPqZj63
   Gf22R4I2+/s52MJjHk5rroxt/Y02rupcNzyaBVjGwsWMVSSHLBWPkCgd9
   O0S/5Swp7wuVjnoChCiKuXVMwgmcjlghNaKTQiAdh3J/0X3LmRNOxB3hU
   Q==;
X-CSE-ConnectionGUID: 8rPUSUjrQ/CLLbM2AOrlDQ==
X-CSE-MsgGUID: kMqs37vgQ7qt6wbssjW6Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19894325"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19894325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:21:35 -0700
X-CSE-ConnectionGUID: 2LySTCSbRiOnG8aIyhcD2g==
X-CSE-MsgGUID: 8ui9B32sT+eaeu9Shma26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="57464689"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:21:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbWe9wraG2FjBcX9OmHN5ynB4et9WEHqh6NPSVK5mzJi2A@mail.gmail.com>
	(Chris Li's message of "Fri, 26 Jul 2024 00:10:31 -0700")
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
	<87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
	<87o76k3dkt.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbWe9wraG2FjBcX9OmHN5ynB4et9WEHqh6NPSVK5mzJi2A@mail.gmail.com>
Date: Fri, 26 Jul 2024 15:18:00 +0800
Message-ID: <87bk2k39lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jul 25, 2024 at 10:55=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >> > If the freeing of swap entry is random distribution. You need 16
>> >> > continuous swap entries free at the same time at aligned 16 base
>> >> > locations. The total number of order 4 free swap space add up toget=
her
>> >> > is much lower than the order 0 allocatable swap space.
>> >> > If having one entry free is 50% probability(swapfile half full), th=
en
>> >> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 =
E-5.
>> >> > If the swapfile is 80% full, that number drops to 6.5 E -12.
>> >>
>> >> This depends on workloads.  Quite some workloads will show some degree
>> >> of spatial locality.  For a workload with no spatial locality at all =
as
>> >> above, mTHP may be not a good choice at the first place.
>> >
>> > The fragmentation comes from the order 0 entry not from the mTHP. mTHP
>> > have their own valid usage case, and should be separate from how you
>> > use the order 0 entry. That is why I consider this kind of strategy
>> > only works on the lucky case. I would much prefer the strategy that
>> > can guarantee work not depend on luck.
>>
>> It seems that you have some perfect solution.  Will learn it when you
>> post it.
>
> No, I don't have perfect solutions. I see puting limit on order 0 swap
> usage and writing out discontinuous swap entries from a folio are more
> deterministic and not depend on luck. Both have their price to pay as
> well.
>
>>
>> >> >> - Order-4 pages need to be swapped out, but no enough order-4 non-=
full
>> >> >>   clusters available.
>> >> >
>> >> > Exactly.
>> >> >
>> >> >>
>> >> >> So, we need a way to migrate non-full clusters among orders to adj=
ust to
>> >> >> the various situations automatically.
>> >> >
>> >> > There is no easy way to migrate swap entries to different locations.
>> >> > That is why I like to have discontiguous swap entries allocation for
>> >> > mTHP.
>> >>
>> >> We suggest to migrate non-full swap clsuters among different lists, n=
ot
>> >> swap entries.
>> >
>> > Then you have the down side of reducing the number of total high order
>> > clusters. By chance it is much easier to fragment the cluster than
>> > anti-fragment a cluster.  The orders of clusters have a natural
>> > tendency to move down rather than move up, given long enough time of
>> > random access. It will likely run out of high order clusters in the
>> > long run if we don't have any separation of orders.
>>
>> As my example above, you may have almost 0 high-order clusters forever.
>> So, your solution only works for very specific use cases.  It's not a
>> general solution.
>
> One simple solution is having an optional limitation of 0 order swap.
> I understand you don't like that option, but there is no other easy
> solution to achieve the same effectiveness, so far. If there is, I
> like to hear it.

Just as you said, it's optional, so it's not general solution.  This may
trigger OOM in general solution.

>>
>> >> >> But yes, data is needed for any performance related change.
>> >>
>> >> BTW: I think non-full cluster isn't a good name.  Partial cluster is
>> >> much better and follows the same convention as partial slab.
>> >
>> > I am not opposed to it. The only reason I hold off on the rename is
>> > because there are patches from Kairui I am testing depending on it.
>> > Let's finish up the V5 patch with the swap cache reclaim code path
>> > then do the renaming as one batch job. We actually have more than one
>> > list that has the clusters partially full. It helps reduce the repeat
>> > scan of the cluster that is not full but also not able to allocate
>> > swap entries for this order.  Just the name of one of them as
>> > "partial" is not precise either. Because the other lists are also
>> > partially full. We'd better give them precise meaning systematically.
>>
>> I don't think that it's hard to do a search/replace before the next
>> version.
>
> The overhead is on the other internal experimental patches. Again,
> I am not opposed to renaming it. Just want to do it at one batch not
> many times, including other list names.

--
Best Regards,
Huang, Ying

