Return-Path: <linux-kernel+bounces-238944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAE9253BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFDA1C24B00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308212EBDB;
	Wed,  3 Jul 2024 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeI6wlws"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22733D5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988395; cv=none; b=Y4xKoApsPr/Q89UWLLy+X2ZWsOA52pAO91OZgLm5LqArk9yAq0PG/UFI/KyQxbYlwl+Waxd/wTQfKbvSxif6Lf8fY+YKpzlaCNSUL1WuCii1XIio+U7Q3dG2/xthgDN9qpzKm2LKUQ2WhVI+NOWa2oXrtxV/ULanBLiWhMxRzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988395; c=relaxed/simple;
	bh=H5eZhdMck6PKyVrAjb2JK2IorIN9/Ev82wjv1COU90s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nJffuokOtkFILVWLDdrJYPTpk2ZEuHlk4jwvW/c7E7S1dsYwqU+etcV6TwI3NZpC+utanaIzQl2MuBq23Lc7x0GzpWAYkMGzxqM3OG55hO5n2HEU970ceQ5CYChYPupbXo3VAMKRNKTDgA1HZ9P5GmeshipwB6Y/ISa1ZsfqxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeI6wlws; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719988393; x=1751524393;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=H5eZhdMck6PKyVrAjb2JK2IorIN9/Ev82wjv1COU90s=;
  b=XeI6wlwsgIZmljrA7uHBnBOxvZ2xMEwDgXX+NFreht7ajXdz3iTWqzWa
   6/HV93sRyG/iyBDAk1LejAcp3Uh9nGHBW3eADTNG8xhjHMwJ++l4wU7iP
   Ln5O1A6AXXGexg5JYFuorfOi7OPizWevUPVKoAeLkPfL2fmAL7JdkWuH0
   OJlUSxBfR+VQFqfdjK9cSCq1BML3OzSXeLAVMhO96wQ+Lv+omiLWyCOLl
   +FzOjxv5ZFuKtelnEGJPgqKvb3u3hwEGyG7WrA5B5+VHUu2PYQwHaZ2qj
   5ULGRTrKgatkztY/4WnJyA5xkOepBbisOBxQiIJWyn8n88QH53RC/Fnh7
   g==;
X-CSE-ConnectionGUID: yaxcd7J3QVqguQr0eGXjpg==
X-CSE-MsgGUID: D8sdVbBiSyOqV606ORNVCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16856511"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="16856511"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:33:12 -0700
X-CSE-ConnectionGUID: UEkP0j2dQxCdKOAaqTTBvQ==
X-CSE-MsgGUID: BDVkjxB/Si6N+TTmzpIFhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="69322686"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:33:07 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,  chrisl@kernel.org,
  david@redhat.com,  hannes@cmpxchg.org,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  mhocko@suse.com,  nphamcs@gmail.com,
  ryan.roberts@arm.com,  shy828301@gmail.com,  surenb@google.com,
  kaleshsingh@google.com,  hughd@google.com,  v-songbaohua@oppo.com,
  willy@infradead.org,  xiang@kernel.org,  yosryahmed@google.com,
  baolin.wang@linux.alibaba.com,  shakeel.butt@linux.dev,
  senozhatsky@chromium.org,  minchan@kernel.org
Subject: Re: [PATCH RFC v4 0/2] mm: support mTHP swap-in for zRAM-like swapfile
In-Reply-To: <20240629111010.230484-1-21cnbao@gmail.com> (Barry Song's message
	of "Sat, 29 Jun 2024 23:10:08 +1200")
References: <20240629111010.230484-1-21cnbao@gmail.com>
Date: Wed, 03 Jul 2024 14:31:16 +0800
Message-ID: <87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> In an embedded system like Android, more than half of anonymous memory is
> actually stored in swap devices such as zRAM. For instance, when an app 
> is switched to the background, most of its memory might be swapped out.
>
> Currently, we have mTHP features, but unfortunately, without support
> for large folio swap-ins, once those large folios are swapped out,
> we lose them immediately because mTHP is a one-way ticket.

No exactly one-way ticket, we have (or will have) khugepaged.  But I
admit that it may be not good enough for you.

> This is unacceptable and reduces mTHP to merely a toy on systems
> with significant swap utilization.

May be true in your systems.  May be not in some other systems.

> This patch introduces mTHP swap-in support. For now, we limit mTHP
> swap-ins to contiguous swaps that were likely swapped out from mTHP as
> a whole.
>
> Additionally, the current implementation only covers the SWAP_SYNCHRONOUS
> case. This is the simplest and most common use case, benefiting millions

I admit that Android is an important target platform of Linux kernel.
But I will not advocate that it's MOST common ...

> of Android phones and similar devices with minimal implementation
> cost. In this straightforward scenario, large folios are always exclusive,
> eliminating the need to handle complex rmap and swapcache issues.
>
> It offers several benefits:
> 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
>    swap-out and swap-in.
> 2. Eliminates fragmentation in swap slots and supports successful THP_SWPOUT
>    without fragmentation. Based on the observed data [1] on Chris's and Ryan's
>    THP swap allocation optimization, aligned swap-in plays a crucial role
>    in the success of THP_SWPOUT.
> 3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU usage
>    and enhancing compression ratios significantly. We have another patchset
>    to enable mTHP compression and decompression in zsmalloc/zRAM[2].
>
> Using the readahead mechanism to decide whether to swap in mTHP doesn't seem
> to be an optimal approach. There's a critical distinction between pagecache
> and anonymous pages: pagecache can be evicted and later retrieved from disk,
> potentially becoming a mTHP upon retrieval, whereas anonymous pages must
> always reside in memory or swapfile. If we swap in small folios and identify
> adjacent memory suitable for swapping in as mTHP, those pages that have been
> converted to small folios may never transition to mTHP. The process of
> converting mTHP into small folios remains irreversible. This introduces
> the risk of losing all mTHP through several swap-out and swap-in cycles,
> let alone losing the benefits of defragmentation, improved compression
> ratios, and reduced CPU usage based on mTHP compression/decompression.

I understand that the most optimal policy in your use cases may be
always swapping-in mTHP in highest order.  But, it may be not in some
other use cases.  For example, relative slow swap devices, non-fault
sub-pages swapped out again before usage, etc.

So, IMO, the default policy should be the one that can adapt to the
requirements automatically.  For example, if most non-fault sub-pages
will be read/written before being swapped out again, we should swap-in
in larger order, otherwise in smaller order.  Swap readahead is one
possible way to do that.  But, I admit that this may not work perfectly
in your use cases.

Previously I hope that we can start with this automatic policy that
helps everyone, then check whether it can satisfy your requirements
before implementing the optimal policy for you.  But it appears that you
don't agree with this.

Based on the above, IMO, we should not use your policy as default at
least for now.  A user space interface can be implemented to select
different swap-in order policy similar as that of mTHP allocation order
policy.  We need a different policy because the performance characters
of the memory allocation is quite different from that of swap-in.  For
example, the SSD reading could be much slower than the memory
allocation.  With the policy selection, I think that we can implement
mTHP swap-in for non-SWAP_SYNCHRONOUS too.  Users need to know what they
are doing.

> Conversely, in deploying mTHP on millions of real-world products with this
> feature in OPPO's out-of-tree code[3], we haven't observed any significant
> increase in memory footprint for 64KiB mTHP based on CONT-PTE on ARM64.
>
> [1] https://lore.kernel.org/linux-mm/20240622071231.576056-1-21cnbao@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/
> [3] OnePlusOSS / android_kernel_oneplus_sm8550 
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11
>

[snip]

--
Best Regards,
Huang, Ying

