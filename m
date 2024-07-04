Return-Path: <linux-kernel+bounces-240390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B6926D26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328D1C21815
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355DC8FE;
	Thu,  4 Jul 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3Xx4W7v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F119457
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057322; cv=none; b=QI/tu0xgOpolZhnIvwnOQnDUVO8pvWbFcrZU5aU5Rbm9Adylr0ZeN/UcVaKVgBAcK+/vtmEfuXk339hXYCMoTqRF321/5Y1txVVdWY8EKvg8zTN1e948e7IvYjCkp1HDJypWl9ZItK2IuasPV87lJ38sMti02NStYBdvV6IsRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057322; c=relaxed/simple;
	bh=s/Aa0BJyrKpjKQ94bhIQQb2pZjpiX1HeSQehN0NvdII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Za8W2FRXzVp8naYhbHQj1s8agVe0cnsLVPm6hQ9oCdeIGkEdxS/fgEyzvkXcgGD8nBSAwK2OhLP26ylcAjI2sU0dHEyKnSIUiDcIu9AedHLuXPtoo+7jexIJgngygf1mp106b1JuSl95SGDgyulXYj11rBDjyzkqA3o/e6UeJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3Xx4W7v; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720057321; x=1751593321;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=s/Aa0BJyrKpjKQ94bhIQQb2pZjpiX1HeSQehN0NvdII=;
  b=Q3Xx4W7v5j01BC1pXVG2Hl9qr3ZXcvMqZgNLAc09KAfLudx95eNKsHUY
   1a1VBcfE0qQUqACsHd3VxKKh8hxUiG7+9/FapoaqjgrfvwboyjS4o1mUC
   opMzoRz9m/cuwTuBB6G2fgjlkycgi0zHZJNcS9KWltDHt1FlNhgxby+d4
   Tr6ukWHNaqG6BWDs7nWvEAztgN/GddbSqx2wGOhqGilfDJOKLghxG+ctt
   js0rZSHhEXk1DD8muz7EaSJVYSget6l4VL3fJLGFf8lupPizuv3CW/lXu
   2ExhQmjeI4LliLm9CkBjYCeYIsW3VOxWkxbA1GuQG/uj402Hv7Mrsm/hm
   Q==;
X-CSE-ConnectionGUID: wIQyt6c6QM2M8u0ExTnC9w==
X-CSE-MsgGUID: 2KTFFIDMRoGcFuZs1e/gMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21078275"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21078275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:41:59 -0700
X-CSE-ConnectionGUID: bsWP/oM4TcOPJf1ZqepPAg==
X-CSE-MsgGUID: dCvdjqnFRJGZ/rQEOPH3Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51388565"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:41:54 -0700
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
In-Reply-To: <CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com>
	(Barry Song's message of "Wed, 3 Jul 2024 19:58:51 +1200")
References: <20240629111010.230484-1-21cnbao@gmail.com>
	<87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com>
Date: Thu, 04 Jul 2024 09:40:03 +0800
Message-ID: <8734oqhr4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Wed, Jul 3, 2024 at 6:33=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>
> Ying, thanks!
>
>> Barry Song <21cnbao@gmail.com> writes:

[snip]

>> > This patch introduces mTHP swap-in support. For now, we limit mTHP
>> > swap-ins to contiguous swaps that were likely swapped out from mTHP as
>> > a whole.
>> >
>> > Additionally, the current implementation only covers the SWAP_SYNCHRON=
OUS
>> > case. This is the simplest and most common use case, benefiting millio=
ns
>>
>> I admit that Android is an important target platform of Linux kernel.
>> But I will not advocate that it's MOST common ...
>
> Okay, I understand that there are still many embedded systems similar
> to Android, even if
> they are not Android :-)
>
>>
>> > of Android phones and similar devices with minimal implementation
>> > cost. In this straightforward scenario, large folios are always exclus=
ive,
>> > eliminating the need to handle complex rmap and swapcache issues.
>> >
>> > It offers several benefits:
>> > 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP aft=
er
>> >    swap-out and swap-in.
>> > 2. Eliminates fragmentation in swap slots and supports successful THP_=
SWPOUT
>> >    without fragmentation. Based on the observed data [1] on Chris's an=
d Ryan's
>> >    THP swap allocation optimization, aligned swap-in plays a crucial r=
ole
>> >    in the success of THP_SWPOUT.
>> > 3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU=
 usage
>> >    and enhancing compression ratios significantly. We have another pat=
chset
>> >    to enable mTHP compression and decompression in zsmalloc/zRAM[2].
>> >
>> > Using the readahead mechanism to decide whether to swap in mTHP doesn'=
t seem
>> > to be an optimal approach. There's a critical distinction between page=
cache
>> > and anonymous pages: pagecache can be evicted and later retrieved from=
 disk,
>> > potentially becoming a mTHP upon retrieval, whereas anonymous pages mu=
st
>> > always reside in memory or swapfile. If we swap in small folios and id=
entify
>> > adjacent memory suitable for swapping in as mTHP, those pages that hav=
e been
>> > converted to small folios may never transition to mTHP. The process of
>> > converting mTHP into small folios remains irreversible. This introduces
>> > the risk of losing all mTHP through several swap-out and swap-in cycle=
s,
>> > let alone losing the benefits of defragmentation, improved compression
>> > ratios, and reduced CPU usage based on mTHP compression/decompression.
>>
>> I understand that the most optimal policy in your use cases may be
>> always swapping-in mTHP in highest order.  But, it may be not in some
>> other use cases.  For example, relative slow swap devices, non-fault
>> sub-pages swapped out again before usage, etc.
>>
>> So, IMO, the default policy should be the one that can adapt to the
>> requirements automatically.  For example, if most non-fault sub-pages
>> will be read/written before being swapped out again, we should swap-in
>> in larger order, otherwise in smaller order.  Swap readahead is one
>> possible way to do that.  But, I admit that this may not work perfectly
>> in your use cases.
>>
>> Previously I hope that we can start with this automatic policy that
>> helps everyone, then check whether it can satisfy your requirements
>> before implementing the optimal policy for you.  But it appears that you
>> don't agree with this.
>>
>> Based on the above, IMO, we should not use your policy as default at
>> least for now.  A user space interface can be implemented to select
>> different swap-in order policy similar as that of mTHP allocation order
>> policy.  We need a different policy because the performance characters
>> of the memory allocation is quite different from that of swap-in.  For
>> example, the SSD reading could be much slower than the memory
>> allocation.  With the policy selection, I think that we can implement
>> mTHP swap-in for non-SWAP_SYNCHRONOUS too.  Users need to know what they
>> are doing.
>
> Agreed. Ryan also suggested something similar before.
> Could we add this user policy by:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled
> which could be 0 or 1, I assume we don't need so many "always inherit
> madvise never"?
>
> Do you have any suggestions regarding the user interface?

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled

looks good to me.  To be consistent with "enabled" in the same
directory, and more importantly, to be extensible, I think that it's
better to start with at least "always never".  I believe that we will
add "auto" in the future to tune automatically.  Which can be used as
default finally.

--
Best Regards,
Huang, Ying

