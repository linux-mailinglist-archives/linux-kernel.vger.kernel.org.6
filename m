Return-Path: <linux-kernel+bounces-196191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B98D58A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10BD281BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D178283;
	Fri, 31 May 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOAldiKG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B081F16B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123032; cv=none; b=Im4e85ZcANs/fxICg6fpp1Mzqy1riVc0+HzLHLffEgu1xj38V0r69zXhLxJxFuPFAf5HO1iIS6RkkDTwTnd3oMNqRp9h6o22Ev7JzCb33QnGE+ZsZRiuHrZAc8ezd2F3gFpfRXA3sRqphsCu1HI4uLxa7YmcEe9UyWStokDZR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123032; c=relaxed/simple;
	bh=HXJhVHgaP2yBbTxxl2IaRVJ2gMdlgLwgYbfZ3DUTCsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBfPZ6fJF8++0T+q0pBOM+3EGWj/KnwYu6HUjEYJYgJZEupoPLigmUPxuI+GhgZq1GMhzeSgGk6+NyDrZpIHYfSHNhY9HBGVuECkOc6EtJMxM3++RG5kUrd+cHQRyGxOMT2ShnWD08GFWcbu6kv8UcZ5Vt89v0N6drQKsGQThaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOAldiKG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717123031; x=1748659031;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=HXJhVHgaP2yBbTxxl2IaRVJ2gMdlgLwgYbfZ3DUTCsc=;
  b=SOAldiKGhDQ4F+kMBTg90090/HXY8h3Wixuxq3Lv2GZSg/SjmDCdUA7r
   y01fC3RFCsB21eyKbEe38o+pDEamcJoIjEA6WbHejIWnbW1cqYm/JK2+G
   8O171rlsEdSFaMfOBKoDSjLTNDK96FNRJZ5FUr+HZ/aPW6QAe/JnD/kBF
   W18q3O4vg/u99oReXzpGJogkY8bg6lspplcE6M+NwJh2wiUNEzr6DUtdV
   9ZeZJu7Jgf6RvwRMSHtC+xjYM0TSIbA6VNQHX7F8uqD+wZ4ljRcxi00qj
   4S77k6JsCEGxZmkdGSZoxAGVHb4BrvrwwbmB/EDjTRNVe1k1UOpxv7cWY
   A==;
X-CSE-ConnectionGUID: O94XFWDbSwqMZJfnm8ho6A==
X-CSE-MsgGUID: 4EwV/pOKSFGYU+pntf0YZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17496649"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="17496649"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:37:10 -0700
X-CSE-ConnectionGUID: J0HrU7DtTbKaIrGi3wTesg==
X-CSE-MsgGUID: PAFVPX4WQiCHJLQzAUWYsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36641804"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:37:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
	(Chris Li's message of "Thu, 30 May 2024 14:44:33 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	<87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
	<875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
Date: Fri, 31 May 2024 10:35:15 +0800
Message-ID: <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > Hi Ying,
>> >
>> > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > I am spinning a new version for this series to address two issues
>> >> > found in this series:
>> >> >
>> >> > 1) Oppo discovered a bug in the following line:
>> >> > +               ci =3D si->cluster_info + tmp;
>> >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
>> >> > That is a serious bug but trivial to fix.
>> >> >
>> >> > 2) order 0 allocation currently blindly scans swap_map disregarding
>> >> > the cluster->order.
>> >>
>> >> IIUC, now, we only scan swap_map[] only if
>> >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[=
order]).
>> >> That is, if you doesn't run low swap free space, you will not do that.
>> >
>> > You can still swap space in order 0 clusters while order 4 runs out of
>> > free_cluster
>> > or nonfull_clusters[order]. For Android that is a common case.
>>
>> When we fail to allocate order 4, we will fallback to order 0.  Still
>> don't need to scan swap_map[].  But after looking at your below reply, I
>> realized that the swap space is almost full at most times in your cases.
>> Then, it's possible that we run into scanning swap_map[].
>> list_empty(&si->free_clusters) &&
>> list_empty(&si->nonfull_clusters[order]) will become true, if we put too
>> many clusters in si->percpu_cluster.  So, if we want to avoid to scan
>> swap_map[], we can stop add clusters in si->percpu_cluster when swap
>> space runs low.  And maybe take clusters out of si->percpu_cluster
>> sometimes.
>
> One idea after reading your reply. If we run out of the
> nonfull_cluster[order], we should be able to use other cpu's
> si->percpu_cluster[] as well. That is a very small win for Android,

This will be useful in general.  The number CPU may be large, and
multiple orders may be used.

> because android does not have too many cpu. We are talking about a
> handful of clusters, which might not justify the code complexity. It
> does not change the behavior that order 0 can pollut higher order.

I have a feeling that you don't really know why swap_map[] is scanned.
I suggest you to do more test and tracing to find out the reason.  I
suspect that there are some non-full cluster collection issues.

>> Another issue is nonfull_cluster[order1] cannot be used for
>> nonfull_cluster[order2].  In definition, we should not fail order 0
>> allocation, we need to steal nonfull_cluster[order>0] for order 0
>> allocation.  This can avoid to scan swap_map[] too.  This may be not
>> perfect, but it is the simplest first step implementation.  You can
>> optimize based on it further.
>
> Yes, that is listed as the limitation of this cluster order approach.
> Initially we need to support one order well first. We might choose
> what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
> are too big. The sweet spot might be some there in between.  If we can
> support one order well, we can demonstrate the value of the mTHP. We
> can worry about other mix orders later.
>
> Do you have any suggestions for how to prevent the order 0 polluting
> the higher order cluster? If we allow that to happen, then it defeats
> the goal of being able to allocate higher order swap entries. The
> tricky question is we don't know how much swap space we should reserve
> for each order. We can always break higher order clusters to lower
> order, but can't do the reserves. The current patch series lets the
> actual usage determine the percentage of the cluster for each order.
> However that seems not enough for the test case Barry has. When the
> app gets OOM kill that is where a large swing of order 0 swap will
> show up and not enough higher order usage for the brief moment. The
> order 0 swap entry will pollute the high order cluster. We are
> currently debating a "knob" to be able to reserve a certain % of swap
> space for a certain order. Those reservations will be guaranteed and
> order 0 swap entry can't pollute them even when it runs out of swap
> space. That can make the mTHP at least usable for the Android case.

IMO, the bottom line is that order-0 allocation is the first class
citizen, we must keep it optimized.  And, OOM with free swap space isn't
acceptable.  Please consider the policy we used for page allocation.

> Do you see another way to protect the high order cluster polluted by
> lower order one?

If we use high-order page allocation as reference, we need something
like compaction to guarantee high-order allocation finally.  But we are
too far from that.

For specific configuration, I believe that we can get reasonable
high-order swap entry allocation success rate for specific use cases.
For example, if we only do limited maximum number order-0 swap entries
allocation, can we keep high-order clusters?

>>
>> And, I checked your code again.  It appears that si->percpu_cluster may
>> be put in si->nonfull_cluster[], then be used by another CPU.  Please
>> check it.
>
> Ah, good point. I think it does. Let me take a closer look.

--
Best Regards,
Huang, Ying

