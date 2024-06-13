Return-Path: <linux-kernel+bounces-212852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747F90673A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F81C208F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDA13D60C;
	Thu, 13 Jun 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWCGdnqO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69313D539
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268051; cv=none; b=d5yzHm8BJCIzKPV/8i8FyT3oyaWUoDmjDfR7oe4tGd07wH1ZrqfAXqWl7mufRy4RWTAoUVexfDUL9e7xF3WhuS2i9mrLK39koFGXhEq6bWmEnbTKEkJN/Ifzf5MYqC0ql/swyMIHV+NZD4tg9p+m1mlix+TmpAaobMDm6S9kWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268051; c=relaxed/simple;
	bh=BufJUpD5h99/QMmWwXqc0nJMKvoaciS9R2964RYmPDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPFuGMVW9FYUAMcFcsu+yAAeU3ZyEPqn5eZv+N33ewl7LMBZvC+u9CcD/4LSBVeS5887P7OGWazCQL9pXx7Anq1+J2B66Qtw/PxlslNUonCDbHtXlQimrJrR36kPYM5LiM4hd60LF+h/3rR9YSbv6nUPYZkTFafE5rNjh6AeGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWCGdnqO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718268049; x=1749804049;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=BufJUpD5h99/QMmWwXqc0nJMKvoaciS9R2964RYmPDQ=;
  b=ZWCGdnqOFoKSYOUbEzkFaBT6m6mzUc0uQtWBjTOqvT5rhH9utEA+56sr
   PvKWu8zt5cTAKJF+KTMf41+d+Bto3QAoyNJD4Kv51q8CdtiuIupj9gAAW
   SQOAz09jN+p2UXwSQ9kfwaNFeQT+6g2mrE8B8Xcpm74tT+GpyHivvTFYp
   baKcD3aLAfw0kYZLWaI9fKqXspWuY1azw7kIBlKaahf7jCzPs8obzKR8l
   uYUH0KImU7UmW1EWZoxXeIGTupviSq/sDHaWWMSVNfhdXlJivltunfmEW
   ZScCx9HwaSDlo+wxZxS4NB3kuus1XqPm9zdIU6lz6AcLUufKKjd6DEP7C
   Q==;
X-CSE-ConnectionGUID: YMOmvmViQruFFlRFImGeCQ==
X-CSE-MsgGUID: WrtH4HwlQ/mL7G0WgAId0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15038179"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15038179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:40:49 -0700
X-CSE-ConnectionGUID: y6ZThw5fQ/qC4Z8Tk3LApA==
X-CSE-MsgGUID: oiRJwbZRTGmKIw26B63CQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45197867"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:40:47 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CANeU7Q=Epa438LXEX4WEccxLt6WOziLg2sp_=RA3C4PxtHD5uw@mail.gmail.com>
	(Chris Li's message of "Tue, 11 Jun 2024 00:11:42 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	<87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
	<875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
	<87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
	<875xum96nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Q=iYzyjDwgMRLtSZwKv414JqtZK8w=XWDd6bWZ7Ah-8jA@mail.gmail.com>
	<87wmmw6w9e.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Q=Epa438LXEX4WEccxLt6WOziLg2sp_=RA3C4PxtHD5uw@mail.gmail.com>
Date: Thu, 13 Jun 2024 16:38:55 +0800
Message-ID: <87a5jp6xuo.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Jun 10, 2024 at 7:38=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >
>> >> > In the page allocation side, we have the hugetlbfs which reserve so=
me
>> >> > memory for high order pages.
>> >> > We should have similar things to allow reserve some high order swap
>> >> > entries without getting polluted by low order one.
>> >>
>> >> TBH, I don't like the idea of high order swap entries reservation.
>> > May I know more if you don't like the idea? I understand this can be
>> > controversial, because previously we like to take the THP as the best
>> > effort approach. If there is some reason we can't make THP, we use the
>> > order 0 as fall back.
>> >
>> > For discussion purpose, I want break it down to smaller steps:
>> >
>> > First, can we agree that the following usage case is reasonable:
>> > The usage case is that, as Barry has shown, zsmalloc compresses bigger
>> > size than 4K and can have both better compress ratio and CPU
>> > performance gain.
>> > https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.=
com/
>> >
>> > So the goal is to make THP/mTHP have some reasonable success rate
>> > running in the mix size swap allocation, after either low order or
>> > high order swap requests can overflow the swap file size. The allocate
>> > can still recover from that, after some swap entries got free.
>> >
>> > Please let me know if you think the above usage case and goal are not
>> > reasonable for the kernel.
>>
>> I think that it's reasonable to improve the success rate of high-order
>
> Glad to hear that.
>
>> swap entries allocation.  I just think that it's hard to use the
>> reservation based method.  For example, how much should be reserved?
>
> Understand, it is harder to use than a fully transparent method, but
> still better than no solution at all. The alternative right now is we
> can't do it.
>
> Regarding how much we should reserve. Similarly, how much should you
> choose your swap file size? If you choose N, why not N*120% or N*80%?
> That did not stop us from having a swapfile, right?
>
>> Why system OOM when there's still swap space available?  And so forth.
>
> Keep in mind that the reservation is an option. If you prefer the old
> behavior, you don't have to use the reservation. That shouldn't be a
> reason to stop others who want to use it. We don't have an alternative
> solution for the long run mix size allocation yet. If there is, I like
> to hear it.

It's not enough to make it optional.  When you run into issue, you need
to debug it.  And you may debug an issue on a system that is configured
by someone else.

>> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.
>
> Me too. I prefer transparent over reservation if it can achieve the
> same goal. Do we have a fully transparent method spec out? How to
> achieve fully transparent and also avoid fragmentation caused by mix
> order allocation/free?
>
> Keep in mind that we are still in the early stage of the mTHP swap
> development, I can have the reservation patch relatively easily. If
> you come up with a better transparent method patch which can achieve
> the same goal later, we can use it instead.

Because we are still in the early stage, I think that we should try to
improve transparent solution firstly.  Personally, what I don't like is
that we don't work on the transparent solution because we have the
reservation solution.

>>
>> >> that's really important for you, I think that it's better to design
>> >> something like hugetlbfs vs core mm, that is, be separated from the
>> >> normal swap subsystem as much as possible.
>> >
>> > I am giving hugetlbfs just to make the point using reservation, or
>> > isolation of the resource to prevent mixing fragmentation existing in
>> > core mm.
>> > I am not suggesting copying the hugetlbfs implementation to the swap
>> > system. Unlike hugetlbfs, the swap allocation is typically done from
>> > the kernel, it is transparent from the application. I don't think
>> > separate from the swap subsystem is a good way to go.
>> >
>> > This comes down to why you don't like the reservation. e.g. if we use
>> > two swapfile, one swapfile is purely allocate for high order, would
>> > that be better?
>>
>> Sorry, my words weren't accurate.  Personally, I just think that it's
>> better to make reservation related code not too intrusive.
>
> Yes. I will try to make it not too intrusive.
>
>> And, before reservation, we need to consider something else firstly.
>> Whether is it generally good to swap-in with swap-out order?  Should we
>
> When we have the reservation patch (or other means to sustain mix size
> swap allocation/free), we can test it out to get more data to reason
> about it.
> I consider the swap in size policy an orthogonal issue.

No.  I don't think so.  If you swap-out in higher order, but swap-in in
lower order, you make the swap clusters fragmented.

>> consider memory wastage too?  One static policy doesn't fit all, we may
>> need either a dynamic policy, or make policy configurable.
>> In general, I think that we need to do this step by step.
>
> The core swap layer needs to be able to sustain mix size swap
> allocation free in the long run. Without that the swap in size policy
> is meaningless.
>
> Yes, that is the step by step approach. Allowing long run mix size
> swap allocation as the first step.
>
>> >> >> > Do you see another way to protect the high order cluster pollute=
d by
>> >> >> > lower order one?
>> >> >>
>> >> >> If we use high-order page allocation as reference, we need somethi=
ng
>> >> >> like compaction to guarantee high-order allocation finally.  But w=
e are
>> >> >> too far from that.
>> >> >
>> >> > We should consider reservation for high-order swap entry allocation
>> >> > similar to hugetlbfs for memory.
>> >> > Swap compaction will be very complicated because it needs to scan t=
he
>> >> > PTE to migrate the swap entry. It might be easier to support folio
>> >> > write out compound discontiguous swap entries. That is another way =
to
>> >> > address the fragmentation issue. We are also too far from that as
>> >> > right now.
>> >>
>> >> That's not easy to write out compound discontiguous swap entries too.
>> >> For example, how to put folios in swap cache?
>> >
>> > I propose the idea in the recent LSF/MM discussion, the last few
>> > slides are for the discontiguous swap and it has the discontiguous
>> > entries in swap cache.
>> > https://drive.google.com/file/d/10wN4WgEekaiTDiAx2AND97CYLgfDJXAD/view
>> >
>> > Agree it is not an easy change. The cache cache would have to change
>> > the assumption all offset are contiguous.
>> > For swap, we kind of have some in memory data associated with per
>> > offset already, so it might provide an opportunity to combine the
>> > offset related data structure for swap together. Another alternative
>> > might be using xarray without the multi entry property. , just treat
>> > each offset like a single entry. I haven't dug deep into this
>> > direction yet.
>>
>> Thanks!  I will study your idea.
>>
>
> I am happy to discuss if you have any questions.
>
>> > We can have more discussion, maybe arrange an upstream alignment
>> > meeting if there is interest.
>>
>> Sure.
>
> Ideally, if we can resolve our differences over the mail list then we
> don't need to have a separate meeting :-)
>

--
Best Regards,
Huang, Ying

