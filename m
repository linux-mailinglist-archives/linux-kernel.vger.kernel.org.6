Return-Path: <linux-kernel+bounces-390172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C09B7678
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB6A1F233BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145C81552EE;
	Thu, 31 Oct 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wqn+JHSa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9C148832
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363350; cv=none; b=tWBN0d0lIa1u0s4o6djtvUeSvlyl04W50XU6GivOZS3WtGhadY44zmKiH7Qin/nWJM/LskcZE76RaEiEZRD4fvFx52DsKzks5rURLOiH0WnMPoMx8jzpRo84Hd2YFBhUwdeiNaMrMv4HYM1OZMWjcresQVWdJQc5msSxSKuda78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363350; c=relaxed/simple;
	bh=PMU0uMcMcWAKRKv+7T1kQKvTf9dp6QsnhlSRXNzeDls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aepjIrFi9GBlDIvk0BP26l+lMsvzCLZsTEvRj/cIf9wPA4/NPpDebVqSSBTw3u0REvFBPTSZ314MdLLPw8jjnYbSk2hKCqnOT9UHBIUv4MWzIwfD7s6dEJsMn/Ke5Dpy0UilEYX1xEHjCX69WyR0fDQoS+tKKgLIdUs89uomEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wqn+JHSa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730363348; x=1761899348;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=PMU0uMcMcWAKRKv+7T1kQKvTf9dp6QsnhlSRXNzeDls=;
  b=Wqn+JHSa4NY2eL9m/TcXDK3wcl+XxDpgdrANGYCGBt/+oRhvhF1U6EDi
   Vh7jgl+UfdI4GDnkwRZ4bzphMvbuTljqulvyJ9Hu/atbwwog98C83/ENw
   tBQ19KL6e+bYUhVtxGz8aP8ViqnRSQDy1IxMN464BhIBt46QaGTdZt/py
   ndrBt7Nu7I3Uw7FVvTRSMOQ1zjd5etoiiLh3L7lnVL24qXx/VUnJgu5Np
   X5jN1o6+80j+9OViutTvnV7lPYj1smLV0uvqMEDH+LqhDHInVxQFra5Ch
   Xo59yiIX5mpVadgwOVYB6JHBN3nElTohBHT5BlSbcHn4IAfOWnLaO6Dyx
   w==;
X-CSE-ConnectionGUID: 2jfaCbhBR56EPyfzgcv7aQ==
X-CSE-MsgGUID: hUhES1fJSa2VuFvLjdcfGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="33878357"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="33878357"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:29:07 -0700
X-CSE-ConnectionGUID: N/dIxb3sTHmvY/EFOAgiIg==
X-CSE-MsgGUID: koFOiFCLQAO4jPWqYR72Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82721743"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:29:04 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  Chris Li <chrisl@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v3] mm: add per-order mTHP swpin counters
In-Reply-To: <CAGsJ_4yoH2qVpiVmYhYH6WTN4yueQ4yYw+P-CG4Q-dKjc9VVRQ@mail.gmail.com>
	(Barry Song's message of "Thu, 31 Oct 2024 21:21:24 +1300")
References: <20241031075325.1037-1-21cnbao@gmail.com>
	<874j4sae8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yoH2qVpiVmYhYH6WTN4yueQ4yYw+P-CG4Q-dKjc9VVRQ@mail.gmail.com>
Date: Thu, 31 Oct 2024 16:25:31 +0800
Message-ID: <87zfmk8yro.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Oct 31, 2024 at 9:09=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > This helps profile the sizes of folios being swapped in. Currently,
>> > only mTHP swap-out is being counted.
>> > The new interface can be found at:
>> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
>> > For example,
>> > $ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
>> > 12809
>> > $ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
>> > 4763
>> >
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Cc: Chris Li <chrisl@kernel.org>
>> > Cc: Yosry Ahmed <yosryahmed@google.com>
>> > Cc: "Huang, Ying" <ying.huang@intel.com>
>> > Cc: Kairui Song <kasong@tencent.com>
>> > Cc: Ryan Roberts <ryan.roberts@arm.com>
>> > Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>> > Cc: Usama Arif <usamaarif642@gmail.com>
>> > ---
>> >  -v3: minor refine changelog per Huang, Ying. thanks!
>> >
>> >  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
>> >  include/linux/huge_mm.h                    | 1 +
>> >  mm/huge_memory.c                           | 3 +++
>> >  mm/page_io.c                               | 3 +++
>> >  4 files changed, 11 insertions(+)
>> >
>> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
>> > index 2a171ed5206e..5caa3fb2feb1 100644
>> > --- a/Documentation/admin-guide/mm/transhuge.rst
>> > +++ b/Documentation/admin-guide/mm/transhuge.rst
>> > @@ -534,6 +534,10 @@ zswpout
>> >       is incremented every time a huge page is swapped out to zswap in=
 one
>> >       piece without splitting.
>> >
>> > +swpin
>> > +     is incremented every time a huge page is swapped in from a non-z=
swap
>> > +     swap device in one piece.
>> > +
>> >  swpout
>> >       is incremented every time a huge page is swapped out to a non-zs=
wap
>> >       swap device in one piece without splitting.
>>
>> In Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage, I
>> found
>>
>> "
>> What:           /sys/kernel/mm/transparent_hugepage/
>> Date:           April 2024
>> Contact:        Linux memory management mailing list <linux-mm@kvack.org>
>> Description:
>>                 /sys/kernel/mm/transparent_hugepage/ contains a number o=
f files and
>>                 subdirectories,
>>
>>                         - defrag
>>                         - enabled
>>                         - hpage_pmd_size
>>                         - khugepaged
>>                         - shmem_enabled
>>                         - use_zero_page
>>                         - subdirectories of the form hugepages-<size>kB,=
 where <size>
>>                           is the page size of the hugepages supported by=
 the kernel/CPU
>>                           combination.
>>
>>                 See Documentation/admin-guide/mm/transhuge.rst for detai=
ls.
>> "
>>
>> So, Documentation/admin-guide/mm/transhuge.rst will be used as ABI
>> document?
>
> Yes. this follows:
>
> sysfs-kernel-mm-hugepages:              See
> Documentation/admin-guide/mm/hugetlbpage.rst for details.
> sysfs-kernel-mm-ksm:            See Documentation/mm/ksm.rst for more
> information.
> sysfs-kernel-mm-transparent-hugepage:           See
> Documentation/admin-guide/mm/transhuge.rst for details.
>

Got it!  Thanks!  Feel free to add

Acked-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

--
Best Regards,
Huang, Ying

