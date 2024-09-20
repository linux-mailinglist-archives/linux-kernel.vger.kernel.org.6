Return-Path: <linux-kernel+bounces-334174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7C97D37C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940A71C21425
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF27E575;
	Fri, 20 Sep 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc866qlP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093752F9E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823747; cv=none; b=m4iHC1Hcht8J0TfuFaahvFtLebla4ZVUJC8VmjMIVVPau4khxSbV0w9TeCoQJJV5K396fxZ+P/x1a3kuiUnqxJzewd3bx74+I9FRkWOw0HLKxP5WcrCurQew2A3filUaMi0UUtS4TIlF0haZZNNudBmDTqBtAOemiBMdFsS6Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823747; c=relaxed/simple;
	bh=VnDz8E/CxphXslX9pLC9mxPJtilxX5wHcUxEthFCtFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vreh8Fr6PGfgr7hpgiFAMMr+0wMmAdXX3JXu5VW2YfiIkOSrhVOHeIUpurKZWCTl2tBUiZMrzhUv4av1r/YC5q4CTXoKaee5vRpH+YMAnTuDFRqvrSaH77dXe5DBNvMm7iqz7Wo+u6V5Jz4CByL5WBsl6ThArHUK82KoI32LxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc866qlP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726823745; x=1758359745;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=VnDz8E/CxphXslX9pLC9mxPJtilxX5wHcUxEthFCtFE=;
  b=bc866qlPzCGQ8iiVMFQKhlCsnyCc0ArBMnGZfCRfJX0/WQ7SG3L4CH61
   pjA8G0OkR/ONn3fgOdxjt9xbbxhsQ75J2pz7oZw3IX68CUFtClMvnVpky
   QYdSBg1BKvy5BSMJvHiopT5z4n0YntP+wJ3uuSY5T1ZHkWmoWgvhhBlHa
   MzYSXTfXyTPQQvPl66WPJqdQE/LI5cw8JlQ3YWMzT3vjAFQFIhNnAsaTI
   zoMcAAoWNXO2VwjcYGsEWmrCWHk2gfdzg/FAHfYe7znEQtjFBcWF98XoX
   RqRJRJJL4vBDMiM0I7J5/ArWpeLTNPoc9HwIZ38hZFxBsYYAOEYPRBXH4
   g==;
X-CSE-ConnectionGUID: Mu1+PtXBRJi+b1/F5OvxXg==
X-CSE-MsgGUID: l2X8BW9qR4KTIYj6CaqU8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36955660"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="36955660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:15:44 -0700
X-CSE-ConnectionGUID: 1LMmnwRLQSCRgdccj/Xf9A==
X-CSE-MsgGUID: ZmPhVy4CQ52btpXfqfXl5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="75013491"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:15:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>,  Yosry Ahmed <yosryahmed@google.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>,  "chengming.zhou@linux.dev"
 <chengming.zhou@linux.dev>,  "usamaarif642@gmail.com"
 <usamaarif642@gmail.com>,  "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
  "21cnbao@gmail.com" <21cnbao@gmail.com>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "Zou, Nanhai" <nanhai.zou@intel.com>,
  "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,  "Gopal, Vinodh"
 <vinodh.gopal@intel.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <SJ0PR11MB567839F1CB09EBD24921AA20C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
	(Kanchana P. Sridhar's message of "Fri, 20 Sep 2024 10:16:53 +0800")
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
	<CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
	<CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
	<SJ0PR11MB567839F1CB09EBD24921AA20C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Date: Fri, 20 Sep 2024 17:12:07 +0800
Message-ID: <87msk2vgd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:

> Hi Nhat,
>
>> -----Original Message-----
>> From: Nhat Pham <nphamcs@gmail.com>
>> Sent: Thursday, August 29, 2024 4:46 PM
>> To: Yosry Ahmed <yosryahmed@google.com>
>> Cc: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; linux-
>> kernel@vger.kernel.org; linux-mm@kvack.org; hannes@cmpxchg.org;
>> chengming.zhou@linux.dev; usamaarif642@gmail.com;
>> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
>> 21cnbao@gmail.com; akpm@linux-foundation.org; Zou, Nanhai
>> <nanhai.zou@intel.com>; Feghali, Wajdi K <wajdi.k.feghali@intel.com>;
>> Gopal, Vinodh <vinodh.gopal@intel.com>
>> Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
>>=20
>> On Thu, Aug 29, 2024 at 3:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om>
>> wrote:
>> >
>> > On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
>> >
>> > We are basically comparing zram with zswap in this case, and it's not
>> > fair because, as you mentioned, the zswap compressed data is being
>> > accounted for while the zram compressed data isn't. I am not really
>> > sure how valuable these test results are. Even if we remove the cgroup
>> > accounting from zswap, we won't see an improvement, we should expect a
>> > similar performance to zram.
>> >
>> > I think the test results that are really valuable are case 1, where
>> > zswap users are currently disabling CONFIG_THP_SWAP, and get to enable
>> > it after this series.
>>=20
>> Ah, this is a good point.
>>=20
>> I think the point of comparing mTHP zswap v.s mTHP (SSD)swap is more
>> of a sanity check. IOW, if mTHP swap outperforms mTHP zswap, then
>> something is wrong (otherwise why would enable zswap - might as well
>> just use swap, since SSD swap with mTHP >>> zswap with mTHP >>> zswap
>> without mTHP).
>>=20
>> That said, I don't think this benchmark can show it anyway. The access
>> pattern here is such that all the allocated memories are really cold,
>> so swap to disk (or to zram, which does not account memory usage
>> towards cgroup) is better by definition... And Kanchana does not seem
>> to have access to setup with larger SSD swapfiles? :)
>
> As follow up, I created a swapfile on disk to increase the SSD swap to 17=
9G.

Are you sure you used swapfile instead of a swap partition?  From the
following code in scan_swap_map_slots(),

	if (order > 0) {
		/*
		 * Should not even be attempting large allocations when huge
		 * page swap is disabled.  Warn and fail the allocation.
		 */
		if (!IS_ENABLED(CONFIG_THP_SWAP) ||
		    nr_pages > SWAPFILE_CLUSTER) {
			VM_WARN_ON_ONCE(1);
			return 0;
		}

		/*
		 * Swapfile is not block device or not using clusters so unable
		 * to allocate large entries.
		 */
		if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
			return 0;
	}

large folio will be split for swapfile.

--
Best Regards,
Huang, Ying

>  64KB mTHP (cgroup memory.high set to 40G, no swap limit):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  CONFIG_THP_SWAP=3DY
>  Sapphire Rapids server with 503 GiB RAM and 179G SSD swap backing device
>  for zswap.
>
>  usemem --init-time -w -O --sleep 0 -n 70 1g:
>
>  ------------------------------------------------------------------------=
-------
>                     mm-unstable 9-17-2024           zswap-mTHP v6     Cha=
nge wrt
>                                  Baseline                               B=
aseline
>                                  "before"                 "after"      (s=
leep 0)
>  ------------------------------------------------------------------------=
-------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd d=
eflate-
>                                       iaa                     iaa        =
    iaa
>  ------------------------------------------------------------------------=
-------
>  Throughput (KB/s)    93,273       88,496     143,117     134,131    53% =
    52%
>  sys time (sec)       316.68       349.00      917.88      877.74  -190% =
  -152%
>  memcg_high           73,836       83,522     126,120     133,013
>  memcg_swap_fail     261,136      324,533     494,191     578,824
>  pswpin                   16           11           0           0
>  pswpout           1,242,187    1,263,493           0           0
>  zswpin                  694          668         712         702
>  zswpout           3,991,403    4,933,901   9,289,092  10,461,948
>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  pgmajfault            3,488        3,353       3,377       3,499
>  ZSWPOUT-64kB            n/a          n/a     110,067     103,957
>  SWPOUT-64kB          77,637       78,968           0           0
>  ------------------------------------------------------------------------=
-------
>
> We do see 50% throughput improvement with mTHP-zswap wrt mTHP-SSD.
> The sys time increase can be attributed to higher swapout activity
> occurring with zswap-mTHP.
>
> I hope this quantifies the benefit of mTHP-zswap wrt mTHP-SSD in a
> non-swap-constrained setup. The 4G SSD swap setup data I shared
> in my response to Yosry also indicates better throughput with mTHP-zswap
> as compared to mTHP-SSD.
>
> Please do let me know if you have any other questions/suggestions.
>
> Thanks,
> Kanchana
>
>>=20
>> >
>> > If we really want to compare CONFIG_THP_SWAP on before and after, it
>> > should be with SSD because that's a more conventional setup. In this
>> > case the users that have CONFIG_THP_SWAP=3Dy only experience the
>> > benefits of zswap with this series. You mentioned experimenting with
>> > usemem to keep the memory allocated longer so that you're able to have
>> > a fair test with the small SSD swap setup. Did that work?
>> >
>> > I am hoping Nhat or Johannes would shed some light on whether they
>> > usually have CONFIG_THP_SWAP enabled or not with zswap. I am trying to
>> > figure out if any reasonable setups enable CONFIG_THP_SWAP with zswap.
>> > Otherwise the testing results from case 1 should be sufficient.
>> >
>> > >
>> > > In my opinion, even though the test set up does not provide an accur=
ate
>> > > way for a direct before/after comparison (because of zswap usage bei=
ng
>> > > counted in cgroup, hence towards the memory.high), it still seems
>> > > reasonable for zswap_store to support (m)THP, so that further
>> performance
>> > > improvements can be implemented.
>> >
>> > This is only referring to the results of case 2, right?
>> >
>> > Honestly, I wouldn't want to merge mTHP swapout support on its own
>> > just because it enables further performance improvements without
>> > having actual patches for them. But I don't think this captures the
>> > results accurately as it dismisses case 1 results (which I think are
>> > more reasonable).
>> >
>> > Thnaks

