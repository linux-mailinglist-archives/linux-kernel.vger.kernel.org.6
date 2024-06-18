Return-Path: <linux-kernel+bounces-218712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD490C440
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD66281FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73C13B58F;
	Tue, 18 Jun 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ9HE3v1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80C13AD2B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693778; cv=none; b=OuMdp/J8p6fCSgFBEc9PGgs7GMrOyfC/9mXk2VRbMrvEcn4tLccGNNdJCtC0Z4hg8CpNit0gI+xm7MIZ+Sr25q3YK5yteQ+d6CKUsDuzBe1MvVUOrwRRgQtJaPF8mlVO4bdvUzbKMBpJjvGaeT+zJjnJuKTudGpEB8i8aaFP12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693778; c=relaxed/simple;
	bh=6+24cIDcAKw2fApyhL9V0ZTUfUa7T5xYrUP8O7pxpiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxZzYf9PwoM4rLDoROENAjbAd1IOpkf6j1m0T9JZKAqVZ5gfKfeh/PHIwA/mV6BU6sYh96gBkhpoaUg0uFYNYUVguiM9i1hLHMKAmxV3B/0NoDL0cpq8lfIyoQmX924d64E0ltbIJjb/LL9x5jbiMwKkkDL3oWcmILrqL3Yhe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ9HE3v1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718693776; x=1750229776;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=6+24cIDcAKw2fApyhL9V0ZTUfUa7T5xYrUP8O7pxpiQ=;
  b=iJ9HE3v1S+39b998qF52LqPzIIKUemDLaGCfuvqyrd+qpQdKhSGT8dyA
   nyq4ceMFMfa5jOgWmGmnYicwGwoK9Cow+TM0DO1TnfDRJzSkLXYXHwSDN
   uNv6kXfR8rjVl4euhSpx2t31zg8GzRj2IPAmD6UdTQFbPRxE0Uvyahdmj
   gwq8BKjTVwgrNcmx6FDLuItUSJnZKauVQZrZwq0rqK3U5ZJZBRpK8y859
   vnQPRMdqksG6MuQc3vnGSLn0g/v5U00lV5gK4S+6EBdK2QI66IxOxpIB6
   DRkLoNOKBUmfVu/TurdccnDAzQHga48j0L1FMytFHN27bKDvI6w/vHAaN
   g==;
X-CSE-ConnectionGUID: +7KriF6eT5ebIyeEW1jrZw==
X-CSE-MsgGUID: vZn8NxhVQ6y53bq8DhR47Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19409937"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19409937"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 23:56:15 -0700
X-CSE-ConnectionGUID: hGDCuofCS4uSLLycWRJOJA==
X-CSE-MsgGUID: enW7CI8URjyHRA5amHz/MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72655182"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 23:56:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuMi198++-OHqE5pG1y3BnvRBPepG59zpq-wqjbgrrLdHw@mail.gmail.com>
	(Chris Li's message of "Mon, 17 Jun 2024 21:35:32 -0700")
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
Date: Tue, 18 Jun 2024 14:54:22 +0800
Message-ID: <8734pa68rl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jun 13, 2024 at 1:40=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Mon, Jun 10, 2024 at 7:38=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> >> >>
>> >> >> Chris Li <chrisl@kernel.org> writes:
>> >> >>
>> >> >
>> >> >> > In the page allocation side, we have the hugetlbfs which reserve=
 some
>> >> >> > memory for high order pages.
>> >> >> > We should have similar things to allow reserve some high order s=
wap
>> >> >> > entries without getting polluted by low order one.
>> >> >>
>> >> >> TBH, I don't like the idea of high order swap entries reservation.
>> >> > May I know more if you don't like the idea? I understand this can be
>> >> > controversial, because previously we like to take the THP as the be=
st
>> >> > effort approach. If there is some reason we can't make THP, we use =
the
>> >> > order 0 as fall back.
>> >> >
>> >> > For discussion purpose, I want break it down to smaller steps:
>> >> >
>> >> > First, can we agree that the following usage case is reasonable:
>> >> > The usage case is that, as Barry has shown, zsmalloc compresses big=
ger
>> >> > size than 4K and can have both better compress ratio and CPU
>> >> > performance gain.
>> >> > https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gma=
il.com/
>> >> >
>> >> > So the goal is to make THP/mTHP have some reasonable success rate
>> >> > running in the mix size swap allocation, after either low order or
>> >> > high order swap requests can overflow the swap file size. The alloc=
ate
>> >> > can still recover from that, after some swap entries got free.
>> >> >
>> >> > Please let me know if you think the above usage case and goal are n=
ot
>> >> > reasonable for the kernel.
>> >>
>> >> I think that it's reasonable to improve the success rate of high-order
>> >
>> > Glad to hear that.
>> >
>> >> swap entries allocation.  I just think that it's hard to use the
>> >> reservation based method.  For example, how much should be reserved?
>> >
>> > Understand, it is harder to use than a fully transparent method, but
>> > still better than no solution at all. The alternative right now is we
>> > can't do it.
>> >
>> > Regarding how much we should reserve. Similarly, how much should you
>> > choose your swap file size? If you choose N, why not N*120% or N*80%?
>> > That did not stop us from having a swapfile, right?
>> >
>> >> Why system OOM when there's still swap space available?  And so forth.
>> >
>> > Keep in mind that the reservation is an option. If you prefer the old
>> > behavior, you don't have to use the reservation. That shouldn't be a
>> > reason to stop others who want to use it. We don't have an alternative
>> > solution for the long run mix size allocation yet. If there is, I like
>> > to hear it.
>>
>> It's not enough to make it optional.  When you run into issue, you need
>> to debug it.  And you may debug an issue on a system that is configured
>> by someone else.
>
> That is in general true with all kernel development regardless of
> using options or not. If there is a bug in my patch, I will need to
> debug and fix it or the patch might be reverted.
>
> I don't see that as a reason to take the option path or not. The
> option just means the user taking this option will need to understand
> the trade off and accept the defined behavior of that option.

User configuration knobs are not forbidden for Linux kernel.  But we are
more careful about them because they will introduce ABI which we need to
maintain forever.  And they are hard to be used for users.  Optimizing
automatically is generally the better solution.  So, I suggest you to
think more about the automatically solution before diving into a new
option.

>>
>> >> So, I prefer the transparent methods.  Just like THP vs. hugetlbfs.
>> >
>> > Me too. I prefer transparent over reservation if it can achieve the
>> > same goal. Do we have a fully transparent method spec out? How to
>> > achieve fully transparent and also avoid fragmentation caused by mix
>> > order allocation/free?
>> >
>> > Keep in mind that we are still in the early stage of the mTHP swap
>> > development, I can have the reservation patch relatively easily. If
>> > you come up with a better transparent method patch which can achieve
>> > the same goal later, we can use it instead.
>>
>> Because we are still in the early stage, I think that we should try to
>> improve transparent solution firstly.  Personally, what I don't like is
>> that we don't work on the transparent solution because we have the
>> reservation solution.
>
> Do you have a road map or the design for the transparent solution you can=
 share?
> I am interested to know what is the short term step(e.g. a month)  in
> this transparent solution you have in mind, so we can compare the
> different approaches. I can't reason much just by the name
> "transparent solution" itself. Need more technical details.
>
> Right now we have a clear usage case we want to support, the swap
> in/out mTHP with bigger zsmalloc buffers. We can start with the
> limited usage case first then move to more general ones.

TBH, This is what I don't like.  It appears that you refuse to think
about the transparent (or automatic) solution.

I haven't thought about them thoroughly, but at least we may think about

- promoting low order non-full cluster when we find a free high order
  swap entries.

- stealing a low order non-full cluster with low usage count for
  high-order allocation.

- freeing more swap entries when swap devices become fragmented.

>> >> >> that's really important for you, I think that it's better to design
>> >> >> something like hugetlbfs vs core mm, that is, be separated from the
>> >> >> normal swap subsystem as much as possible.
>> >> >
>> >> > I am giving hugetlbfs just to make the point using reservation, or
>> >> > isolation of the resource to prevent mixing fragmentation existing =
in
>> >> > core mm.
>> >> > I am not suggesting copying the hugetlbfs implementation to the swap
>> >> > system. Unlike hugetlbfs, the swap allocation is typically done from
>> >> > the kernel, it is transparent from the application. I don't think
>> >> > separate from the swap subsystem is a good way to go.
>> >> >
>> >> > This comes down to why you don't like the reservation. e.g. if we u=
se
>> >> > two swapfile, one swapfile is purely allocate for high order, would
>> >> > that be better?
>> >>
>> >> Sorry, my words weren't accurate.  Personally, I just think that it's
>> >> better to make reservation related code not too intrusive.
>> >
>> > Yes. I will try to make it not too intrusive.
>> >
>> >> And, before reservation, we need to consider something else firstly.
>> >> Whether is it generally good to swap-in with swap-out order?  Should =
we
>> >
>> > When we have the reservation patch (or other means to sustain mix size
>> > swap allocation/free), we can test it out to get more data to reason
>> > about it.
>> > I consider the swap in size policy an orthogonal issue.
>>
>> No.  I don't think so.  If you swap-out in higher order, but swap-in in
>> lower order, you make the swap clusters fragmented.
>
> Sounds like that is the reason to apply swap-in the same order of the swa=
p out.
> In any case, my original point still stands. We need to have the
> ability to allocate high order swap entries with reasonable success
> rate *before* we have the option to choose which size to swap in. If
> allocating a high order swap always fails, we will be forced to use
> the low order one, there is no option to choose from. We can't evalute
> "is it generally good to swap-in with swap-out order?" by actual runs.

I think we don't need to fight for that.  Just prove the value of your
patchset with reasonable use cases and normal workloads.  Data will
persuade people.

--
Best Regards,
Huang, Ying

