Return-Path: <linux-kernel+bounces-220776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63C90E6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EF1C20AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01657FBD1;
	Wed, 19 Jun 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOnuzxd9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3317D07F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789031; cv=none; b=aX8Zk8UhVyoEy8mVSmesC4sLNvXyMEn3/DGGV+EfhxhREr0ybZthmm6LXkjZJZUY7T4x4lJ9uEP6FYIah9Bjm2c9YYHyK/hxKNy/WHaguR3mmXawe6g7cPs6VNOgauNZT/tIzT+qU39AX8ox8m5rvRS31y2pGs6vNkUjX10XfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789031; c=relaxed/simple;
	bh=3pWtozG4IMuq9Ub5jQk7zLUZAkkC0MkHpKVPAA24bs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuiJRI7ct5aRShUpjEKsCcy4dd1/sgjFPJxsWUGHuKVtBPRyA5Ekx1mvhONuP5rDYlw1EpqPYbk/33M9uTHEUZI0RzAATIzcOwRRck2Kz8DmxcMW4rGQg7p1mj9XBhOYdf4rV69SSL+o5kikY+g7xGql53yR3CLDHYiyL+npBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOnuzxd9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718789030; x=1750325030;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3pWtozG4IMuq9Ub5jQk7zLUZAkkC0MkHpKVPAA24bs8=;
  b=TOnuzxd90Uh5EE1FM/BrAagvB9QwkiEx9VG+7TfZeuc4TTYSkDWYfv5O
   qm0p/q65Wl50na4lOKJt6rHl8kCffGWFI0TDzMvK+JG0rpXYw6Hrv35Vo
   ljkn5Yh6FdrXUlYya3qq3tgvXLqtLpfej9RuZv+gktVvtAai7EjOHXxjp
   Wm5wBBzVSHIA0ML7hvgdGrpOz3yahKx7dKyMFYI3P9e4AjuKBEY3Pzr+q
   N+SF9DqbjJzqPaLJ0gMWrksfPkY6g+Ts3Sb2s5WyqwVOL3/t/dPzuSD9Q
   dPhqenc+8GYmmCNKjzCwuSBS+CtmQbZeTRzsEYNAZjko/GblqCBX+K6t/
   w==;
X-CSE-ConnectionGUID: B9jrGKP3QvCBYrUgsFcaTA==
X-CSE-MsgGUID: wRlRXW0/TgGlZEtrgtfYPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15949831"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15949831"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:23:49 -0700
X-CSE-ConnectionGUID: jHs1NCVvQHSd++SvkXRrQw==
X-CSE-MsgGUID: m8edpKv5RzOpdSmXbbo0YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41944409"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:23:48 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuOfYMiD-aEhLa9i+oxAtasDcPhFb6__i6QRB2dGO1Lhcg@mail.gmail.com>
	(Chris Li's message of "Tue, 18 Jun 2024 02:31:58 -0700")
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
	<87a5jp6xuo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMi198++-OHqE5pG1y3BnvRBPepG59zpq-wqjbgrrLdHw@mail.gmail.com>
	<8734pa68rl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuOfYMiD-aEhLa9i+oxAtasDcPhFb6__i6QRB2dGO1Lhcg@mail.gmail.com>
Date: Wed, 19 Jun 2024 17:21:56 +0800
Message-ID: <87h6dp479n.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Jun 17, 2024 at 11:56=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > That is in general true with all kernel development regardless of
>> > using options or not. If there is a bug in my patch, I will need to
>> > debug and fix it or the patch might be reverted.
>> >
>> > I don't see that as a reason to take the option path or not. The
>> > option just means the user taking this option will need to understand
>> > the trade off and accept the defined behavior of that option.
>>
>> User configuration knobs are not forbidden for Linux kernel.  But we are
>> more careful about them because they will introduce ABI which we need to
>> maintain forever.  And they are hard to be used for users.  Optimizing
>> automatically is generally the better solution.  So, I suggest you to
>> think more about the automatically solution before diving into a new
>> option.
>
> I did, see my reply. Right now there are just no other options.
>
>>
>> >>
>> >> >> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.
>> >> >
>> >> > Me too. I prefer transparent over reservation if it can achieve the
>> >> > same goal. Do we have a fully transparent method spec out? How to
>> >> > achieve fully transparent and also avoid fragmentation caused by mix
>> >> > order allocation/free?
>> >> >
>> >> > Keep in mind that we are still in the early stage of the mTHP swap
>> >> > development, I can have the reservation patch relatively easily. If
>> >> > you come up with a better transparent method patch which can achieve
>> >> > the same goal later, we can use it instead.
>> >>
>> >> Because we are still in the early stage, I think that we should try to
>> >> improve transparent solution firstly.  Personally, what I don't like =
is
>> >> that we don't work on the transparent solution because we have the
>> >> reservation solution.
>> >
>> > Do you have a road map or the design for the transparent solution you =
can share?
>> > I am interested to know what is the short term step(e.g. a month)  in
>> > this transparent solution you have in mind, so we can compare the
>> > different approaches. I can't reason much just by the name
>> > "transparent solution" itself. Need more technical details.
>> >
>> > Right now we have a clear usage case we want to support, the swap
>> > in/out mTHP with bigger zsmalloc buffers. We can start with the
>> > limited usage case first then move to more general ones.
>>
>> TBH, This is what I don't like.  It appears that you refuse to think
>> about the transparent (or automatic) solution.
>
> Actually, that is not true, you make the wrong assumption about what I
> have considered. I want to find out what you have in mind to compare
> the near term solutions.

Sorry about my wrong assumption.

> In my recent LSF slide I already list 3 options to address this
> fragmentation problem.
> From easy to hard:
> 1) Assign cluster an order on allocation and remember the cluster
> order. (short term).
> That is this patch series
> 2) Buddy allocation on the swap entry (longer term)
> 3) Folio write out compound discontinuous swap entry. (ultimate)
>
> I also considered 4), which I did not put into the slide, because it
> is less effective than 3)
> 4) migrating the swap entries, which require scan page table entry.
> I briefly mentioned it during the session.

Or you need something like a rmap, that isn't easy.

> 3) should might qualify as your transparent solution. It is just much
> harder to implement.
> Even when we have 3), having some form of 1) can be beneficial as
> well. (less IO count, no indirect layer of swap offset).
>
>>
>> I haven't thought about them thoroughly, but at least we may think about
>>
>> - promoting low order non-full cluster when we find a free high order
>>   swap entries.
>>
>> - stealing a low order non-full cluster with low usage count for
>>   high-order allocation.
>
> Now we are talking.
> These two above fall well within 2) the buddy allocators
> But the buddy allocator will not be able to address all fragmentation
> issues, due to the allocator not being controlled the life cycle of
> the swap entry.
> It will not help Barry's zsmalloc usage case much because android
> likes to keep the swapfile full. I can already see that.

I think that buddy-like allocator (not exactly buddy algorithm) will
help fragmentation.  And it will help more users because it works
automatically.

I don't think they are too hard to be implemented.  We can try to find
some simple solution firstly.  So, I think that we don't need to push
them to long term.  At least, they can be done before introducing
high-order cluster reservation ABI.  Then, we can evaluate the benefit
and overhead of reservation ABI.

>> - freeing more swap entries when swap devices become fragmented.
>
> That requires a scan page table to free the swap entry, basically 4).

No.  You can just scan the page table of current process in
do_swap_page() and try to swap-in and free more swap entries.  That
doesn't work well for the shared pages.  However, I think that it can
help quite some workloads.

> It is all about investment and return. 1) is relatively easy to
> implement and with good improvement and return.

[snip]

--
Best Regards,
Huang, Ying

