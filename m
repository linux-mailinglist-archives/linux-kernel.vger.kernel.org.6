Return-Path: <linux-kernel+bounces-209190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F73902E82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38CD282175
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FEB16F849;
	Tue, 11 Jun 2024 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="issTMjzF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6C16F855
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073505; cv=none; b=odUdkxvmYdblk2m2r0Zfsr9W0jTfyXRlD20eaEodqNwW7J1BzZX3nqo1qAqeE1LThWhwLZXIIKE5fa5s1lSYPX9GiUri+sbWnvhYgNjcYjqiDLitj8p4VQs8azuGfmwBr0KKY18Hj2hNdbRuDSWq7HXYRagH3x4VhJ8vLsi2Wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073505; c=relaxed/simple;
	bh=4d9H3f9WjPk4o7eUYMeqlaQdvIw+Jt6+ThVrJ/+j8Bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TXU+vhHRGw+NiqG355N1NsvMZSJ+Ey3eu7zvfqBtOvh1kGwVfep+0cd2VMcQPV66WBjNhlPg2xz3zz8GxD3S5P3Bh7DDI134NaXCbud7B0NXCShpvM5wwZuhBYjiMd4vpnQCt0K+A2HNw7JdPncaQL7IL495PSMMf73Bhm/vEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=issTMjzF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718073503; x=1749609503;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4d9H3f9WjPk4o7eUYMeqlaQdvIw+Jt6+ThVrJ/+j8Bc=;
  b=issTMjzFUc9ok/8Uhuv4ARxThpjLuQylSAKm4JbII6G7rOZRu8LzU5pq
   +Tv6BCxfoM7wkG9RZehGlDaiKkhjECRTniFY+j4YYz3/OyIjHUidWZZxj
   i/ASpkFmvETiui5iOZKC+FUrDOI1/KPDaU+OIH02/vNH8MDLKrzNuvDuz
   XwvDrcPTUzmAKcfaea2nCEerkN5ISCDpWGxYmDx7cYxdg+XEUK+NDgjJ8
   G7y1sTEiZU3Knwk9SnsOPiq+fQhWX6MBRfAB+xRl5C8yq+clrlhJwdyrr
   O5SFyc/h3iE+VK06XVrn/PglzIrp7C3P1ZMaS882F42TkK1bIakC0h6Qh
   Q==;
X-CSE-ConnectionGUID: uFGlTPA1QqyuTMjz32sMOQ==
X-CSE-MsgGUID: zAEYXjRdQTm1/2Cmvevuag==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32298553"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="32298553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 19:38:23 -0700
X-CSE-ConnectionGUID: QM5RQEVuQKa//xATzJ5gFQ==
X-CSE-MsgGUID: SVAGh7fbRVKy96NqltMSFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39173321"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 19:38:20 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CANeU7Q=iYzyjDwgMRLtSZwKv414JqtZK8w=XWDd6bWZ7Ah-8jA@mail.gmail.com>
	(Chris Li's message of "Fri, 7 Jun 2024 11:40:16 -0700")
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
Date: Tue, 11 Jun 2024 10:36:29 +0800
Message-ID: <87wmmw6w9e.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>
>> > In the page allocation side, we have the hugetlbfs which reserve some
>> > memory for high order pages.
>> > We should have similar things to allow reserve some high order swap
>> > entries without getting polluted by low order one.
>>
>> TBH, I don't like the idea of high order swap entries reservation.
> May I know more if you don't like the idea? I understand this can be
> controversial, because previously we like to take the THP as the best
> effort approach. If there is some reason we can't make THP, we use the
> order 0 as fall back.
>
> For discussion purpose, I want break it down to smaller steps:
>
> First, can we agree that the following usage case is reasonable:
> The usage case is that, as Barry has shown, zsmalloc compresses bigger
> size than 4K and can have both better compress ratio and CPU
> performance gain.
> https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/
>
> So the goal is to make THP/mTHP have some reasonable success rate
> running in the mix size swap allocation, after either low order or
> high order swap requests can overflow the swap file size. The allocate
> can still recover from that, after some swap entries got free.
>
> Please let me know if you think the above usage case and goal are not
> reasonable for the kernel.

I think that it's reasonable to improve the success rate of high-order
swap entries allocation.  I just think that it's hard to use the
reservation based method.  For example, how much should be reserved?
Why system OOM when there's still swap space available?  And so forth.
So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.

>> that's really important for you, I think that it's better to design
>> something like hugetlbfs vs core mm, that is, be separated from the
>> normal swap subsystem as much as possible.
>
> I am giving hugetlbfs just to make the point using reservation, or
> isolation of the resource to prevent mixing fragmentation existing in
> core mm.
> I am not suggesting copying the hugetlbfs implementation to the swap
> system. Unlike hugetlbfs, the swap allocation is typically done from
> the kernel, it is transparent from the application. I don't think
> separate from the swap subsystem is a good way to go.
>
> This comes down to why you don't like the reservation. e.g. if we use
> two swapfile, one swapfile is purely allocate for high order, would
> that be better?

Sorry, my words weren't accurate.  Personally, I just think that it's
better to make reservation related code not too intrusive.

And, before reservation, we need to consider something else firstly.
Whether is it generally good to swap-in with swap-out order?  Should we
consider memory wastage too?  One static policy doesn't fit all, we may
need either a dynamic policy, or make policy configurable.

In general, I think that we need to do this step by step.

>> >> > Do you see another way to protect the high order cluster polluted by
>> >> > lower order one?
>> >>
>> >> If we use high-order page allocation as reference, we need something
>> >> like compaction to guarantee high-order allocation finally.  But we a=
re
>> >> too far from that.
>> >
>> > We should consider reservation for high-order swap entry allocation
>> > similar to hugetlbfs for memory.
>> > Swap compaction will be very complicated because it needs to scan the
>> > PTE to migrate the swap entry. It might be easier to support folio
>> > write out compound discontiguous swap entries. That is another way to
>> > address the fragmentation issue. We are also too far from that as
>> > right now.
>>
>> That's not easy to write out compound discontiguous swap entries too.
>> For example, how to put folios in swap cache?
>
> I propose the idea in the recent LSF/MM discussion, the last few
> slides are for the discontiguous swap and it has the discontiguous
> entries in swap cache.
> https://drive.google.com/file/d/10wN4WgEekaiTDiAx2AND97CYLgfDJXAD/view
>
> Agree it is not an easy change. The cache cache would have to change
> the assumption all offset are contiguous.
> For swap, we kind of have some in memory data associated with per
> offset already, so it might provide an opportunity to combine the
> offset related data structure for swap together. Another alternative
> might be using xarray without the multi entry property. , just treat
> each offset like a single entry. I haven't dug deep into this
> direction yet.

Thanks!  I will study your idea.

> We can have more discussion, maybe arrange an upstream alignment
> meeting if there is interest.

Sure.

--
Best Regards,
Huang, Ying

