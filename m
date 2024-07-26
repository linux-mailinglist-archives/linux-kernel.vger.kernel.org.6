Return-Path: <linux-kernel+bounces-262943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300093CEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F51D282AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A417625D;
	Fri, 26 Jul 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4vzGNTh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FD3C30
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979650; cv=none; b=aRniGUJ3Muz+HNRFfYTT8N/vcK/YS9g/cw+MoAom7Fn2EU3D+d20hhJ5lJzFdKeYiIGI6ieG3KgScSgzA8Tpps6+VsOmm+47OiGA5Hy89es5gim6vvZZocFH9QR4nGhGFu+kiMevXGslUS09yH2vAPc8hF9G+C89JCiMoqSt37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979650; c=relaxed/simple;
	bh=Ws0mUKAeZJGpfSgqwrkFJcFudcNL57jAO7azj2yMpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjoeeDf2/CbKAOQzWQ5YRGvu2N39XnMfmywmK5omBVEuXuDtnoTRCm7VJimupwipmAJ0/jpL0eyg1nCUKkx0yNzW4Lke19D0aFd+CL8cKK2WWMAwOaHKys+/TGVvWPp0hyla/HjXvN5LHu7UEWwI9TriOvXwdOPJP3m4dIVvisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4vzGNTh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721979648; x=1753515648;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Ws0mUKAeZJGpfSgqwrkFJcFudcNL57jAO7azj2yMpL0=;
  b=g4vzGNThl94LaxOFo0yajZGTMWTwwBVDdM4ntzMnACF5RuaFWdaCHbly
   XBdXuD9QhKvCzQEIvfi2+auEm2is7BhfZqDhv7v5qi4QZNdTrJ+EyNfJg
   HnGapL6dosSVeQXfddMPl/MqwqDz07HQIusvmJj3GHrvyUfoXNPOGdl6+
   8Vh9rUFjZm9VOL+VP67cZjlEZ3/WgyAUCxX/jFBzcklY5x8coKlhLNqx0
   tQU0W8NKKfO7miZHTyRdjL2aHAGxcsz6wr/sE6OvPfJMI8kalbOn5uM/e
   oROxZeT6A1FSMhW5anSehGxT6FRowLqPozEqLkiWvv3GO89gsvGKvckK6
   w==;
X-CSE-ConnectionGUID: DOo/bKaURaqzyVvRj64EGA==
X-CSE-MsgGUID: gdEYgNgoQW6n72iRdlhyyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19896854"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19896854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:40:47 -0700
X-CSE-ConnectionGUID: 65P79MMoQ+y78OsvbPzdXA==
X-CSE-MsgGUID: /nIU7j4ERBWH8lQvAG6qkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="57470945"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:40:45 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbVFJ_TO6cX7GJqzZ7u4K2dv0HX2-mc7mVBuXDF3JyqEFg@mail.gmail.com>
	(Chris Li's message of "Fri, 26 Jul 2024 00:26:47 -0700")
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
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
	<87bk2k39lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbVFJ_TO6cX7GJqzZ7u4K2dv0HX2-mc7mVBuXDF3JyqEFg@mail.gmail.com>
Date: Fri, 26 Jul 2024 15:37:12 +0800
Message-ID: <8734nw38pj.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Fri, Jul 26, 2024 at 12:21=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Thu, Jul 25, 2024 at 10:55=E2=80=AFPM Huang, Ying <ying.huang@intel=
.com> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >> > If the freeing of swap entry is random distribution. You need 16
>> >> >> > continuous swap entries free at the same time at aligned 16 base
>> >> >> > locations. The total number of order 4 free swap space add up to=
gether
>> >> >> > is much lower than the order 0 allocatable swap space.
>> >> >> > If having one entry free is 50% probability(swapfile half full),=
 then
>> >> >> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1=
.5 E-5.
>> >> >> > If the swapfile is 80% full, that number drops to 6.5 E -12.
>> >> >>
>> >> >> This depends on workloads.  Quite some workloads will show some de=
gree
>> >> >> of spatial locality.  For a workload with no spatial locality at a=
ll as
>> >> >> above, mTHP may be not a good choice at the first place.
>> >> >
>> >> > The fragmentation comes from the order 0 entry not from the mTHP. m=
THP
>> >> > have their own valid usage case, and should be separate from how you
>> >> > use the order 0 entry. That is why I consider this kind of strategy
>> >> > only works on the lucky case. I would much prefer the strategy that
>> >> > can guarantee work not depend on luck.
>> >>
>> >> It seems that you have some perfect solution.  Will learn it when you
>> >> post it.
>> >
>> > No, I don't have perfect solutions. I see puting limit on order 0 swap
>> > usage and writing out discontinuous swap entries from a folio are more
>> > deterministic and not depend on luck. Both have their price to pay as
>> > well.
>> >
>> >>
>> >> >> >> - Order-4 pages need to be swapped out, but no enough order-4 n=
on-full
>> >> >> >>   clusters available.
>> >> >> >
>> >> >> > Exactly.
>> >> >> >
>> >> >> >>
>> >> >> >> So, we need a way to migrate non-full clusters among orders to =
adjust to
>> >> >> >> the various situations automatically.
>> >> >> >
>> >> >> > There is no easy way to migrate swap entries to different locati=
ons.
>> >> >> > That is why I like to have discontiguous swap entries allocation=
 for
>> >> >> > mTHP.
>> >> >>
>> >> >> We suggest to migrate non-full swap clsuters among different lists=
, not
>> >> >> swap entries.
>> >> >
>> >> > Then you have the down side of reducing the number of total high or=
der
>> >> > clusters. By chance it is much easier to fragment the cluster than
>> >> > anti-fragment a cluster.  The orders of clusters have a natural
>> >> > tendency to move down rather than move up, given long enough time of
>> >> > random access. It will likely run out of high order clusters in the
>> >> > long run if we don't have any separation of orders.
>> >>
>> >> As my example above, you may have almost 0 high-order clusters foreve=
r.
>> >> So, your solution only works for very specific use cases.  It's not a
>> >> general solution.
>> >
>> > One simple solution is having an optional limitation of 0 order swap.
>> > I understand you don't like that option, but there is no other easy
>> > solution to achieve the same effectiveness, so far. If there is, I
>> > like to hear it.
>>
>> Just as you said, it's optional, so it's not general solution.  This may
>> trigger OOM in general solution.
>
> Agree it is not a general solution. This option is simple and useful.
> The more general solution is just write out discontiguous swap entries.

I just don't know how to do that.  For example, how to put the folio in
swap cache.  Will wait you to show the implementation.

--
Best Regards,
Huang, Ying

