Return-Path: <linux-kernel+bounces-339982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DEA986CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500B41F22206
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80436188721;
	Thu, 26 Sep 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUZAOVIG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F66224D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333472; cv=none; b=c+qZDjynfk4CpNHbr0DdXPNYOSI2mE+MNHbjU6ZiJU4Nyfq2jYc167twiXCBIdNOc5Tk0sT1i3Yo1mnkukPQ9aTFOtEFW/aukGZIngQUQHTOPzqkluNT/B7kd20pvH4PNSd+VePBQT37JUFGkHtxHOaVcxYaXRaRNH0asRnwzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333472; c=relaxed/simple;
	bh=4vOQ1UAED36KAtBYkjHVwAw+/u2JrzMSD+GfRoR+UD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuvA7o0Bs3ihfSoaHRbvdQzOPUAIB5I7wl0oVjhRQrrA9KEQ9rZV8f4P/HK4Y8BGY3K1mbadLGBlT7wIuwzZ4F8PzB2MEl1fYHfpEnrTx8tWJPw+s44QckFcsxJ+Kuw+q/xrlz1nhDPj3Ujug4wBBzH9Kd3tqmXQjvflWIGLW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUZAOVIG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727333471; x=1758869471;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4vOQ1UAED36KAtBYkjHVwAw+/u2JrzMSD+GfRoR+UD0=;
  b=EUZAOVIGOOq1w0Kf+UW4Ftg7RakH8fTruXEWttoqfWMRXqjBOQNrMOom
   eW+07+4UKYxtYc7LRAvGBK5q6s27+IOZ/kvRuam02kH9pWwfdZcfI6y1S
   aQf1FzGcL+if2kGrn/mWPstGV6/adlhAIMBjxpIwx1GDiTuwlbqYJfAYs
   xWTIJ75uWHtcz8+LC1/FJQHfx8Ucd/BEld4GnICf3GuO2GgPbu+SpNaJG
   KwHxpnJ7TvGKYQE5hrs8+q+U4OQnH6TSdw3bKJDEftylW5+5XZ0av/QqL
   O6ymPvO1V0+f7UPh/+eS9yUtoBRQMmdmPNdRRUOmxLEMf1+LUqs7cUk6b
   g==;
X-CSE-ConnectionGUID: OL2FudSqTfCWQsuEmYgw+g==
X-CSE-MsgGUID: pA2eHhuERCmWoBIGVReHRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37766517"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37766517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 23:51:09 -0700
X-CSE-ConnectionGUID: QGCYBa+8Q7Ot8BP7HCg5KA==
X-CSE-MsgGUID: HrfVTZa/Qv6r1G2WEJItQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="76845787"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 23:51:05 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>,  "yosryahmed@google.com" <yosryahmed@google.com>,
  "nphamcs@gmail.com" <nphamcs@gmail.com>,  "chengming.zhou@linux.dev"
 <chengming.zhou@linux.dev>,  "usamaarif642@gmail.com"
 <usamaarif642@gmail.com>,  "shakeel.butt@linux.dev"
 <shakeel.butt@linux.dev>,  "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
  "21cnbao@gmail.com" <21cnbao@gmail.com>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "Zou, Nanhai" <nanhai.zou@intel.com>,
  "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,  "Gopal, Vinodh"
 <vinodh.gopal@intel.com>
Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <SJ0PR11MB5678899F41B3F243E54C59D2C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
	(Kanchana P. Sridhar's message of "Thu, 26 Sep 2024 11:48:05 +0800")
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
	<87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
	<877cazs0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678899F41B3F243E54C59D2C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Date: Thu, 26 Sep 2024 14:47:31 +0800
Message-ID: <87msjurjwc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:

> Hi Ying,
>
>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Wednesday, September 25, 2024 5:45 PM
>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
>> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
>> chengming.zhou@linux.dev; usamaarif642@gmail.com;
>> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
>> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali,
>> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
>> <vinodh.gopal@intel.com>
>> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
>> 
>> "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:
>> 
>> >> -----Original Message-----
>> >> From: Huang, Ying <ying.huang@intel.com>
>> >> Sent: Tuesday, September 24, 2024 11:35 PM
>> >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>> >> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
>> >> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
>> >> chengming.zhou@linux.dev; usamaarif642@gmail.com;
>> >> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
>> >> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>;
>> Feghali,
>> >> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
>> >> <vinodh.gopal@intel.com>
>> >> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
>> >>
>> >> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>> >>
>> >> [snip]
>> >>
>> >> >
>> >> > Case 1: Comparing zswap 4K vs. zswap mTHP
>> >> > =========================================
>> >> >
>> >> > In this scenario, the "before" is CONFIG_THP_SWAP set to off, that
>> results in
>> >> > 64K/2M (m)THP to be split into 4K folios that get processed by zswap.
>> >> >
>> >> > The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that
>> >> results
>> >> > in 64K/2M (m)THP to not be split, and processed by zswap.
>> >> >
>> >> >  64KB mTHP (cgroup memory.high set to 40G):
>> >> >  ==========================================
>> >> >
>> >> >  -------------------------------------------------------------------------------
>> >> >                     mm-unstable 9-23-2024              zswap-mTHP     Change wrt
>> >> >                         CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y
>> Baseline
>> >> >                                  Baseline
>> >> >  -------------------------------------------------------------------------------
>> >> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>> >> >                                       iaa                     iaa            iaa
>> >> >  -------------------------------------------------------------------------------
>> >> >  Throughput (KB/s)   143,323      125,485     153,550     129,609    7%
>> 3%
>> >> >  elapsed time (sec)    24.97        25.42       23.90       25.19    4%       1%
>> >> >  sys time (sec)       822.72       750.96      757.70      731.13    8%       3%
>> >> >  memcg_high          132,743      169,825     148,075     192,744
>> >> >  memcg_swap_fail     639,067      841,553       2,204       2,215
>> >> >  pswpin                    0            0           0           0
>> >> >  pswpout                   0            0           0           0
>> >> >  zswpin                  795          873         760         902
>> >> >  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
>> >> >  thp_swpout                0            0           0           0
>> >> >  thp_swpout_               0            0           0           0
>> >> >   fallback
>> >> >  64kB-mthp_          639,065      841,553       2,204       2,215
>> >> >   swpout_fallback
>> >> >  pgmajfault            2,861        2,924       3,054       3,259
>> >> >  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
>> >> >  SWPOUT-64kB               0            0           0           0
>> >> >  -------------------------------------------------------------------------------
>> >> >
>> >>
>> >> IIUC, the throughput is the sum of throughput of all usemem processes?
>> >>
>> >> One possible issue of usemem test case is the "imbalance" issue.  That
>> >> is, some usemem processes may swap-out/swap-in less, so the score is
>> >> very high; while some other processes may swap-out/swap-in more, so the
>> >> score is very low.  Sometimes, the total score decreases, but the scores
>> >> of usemem processes are more balanced, so that the performance should
>> be
>> >> considered better.  And, in general, we should make usemem score
>> >> balanced among processes via say longer test time.  Can you check this
>> >> in your test results?
>> >
>> > Actually, the throughput data listed in the cover-letter is the average of
>> > all the usemem processes. Your observation about the "imbalance" issue is
>> > right. Some processes see a higher throughput than others. I have noticed
>> > that the throughputs progressively reduce as the individual processes exit
>> > and print their stats.
>> >
>> > Listed below are the stats from two runs of usemem70: sleep 10 and sleep
>> 30.
>> > Both are run with a cgroup mem-limit of 40G. Data is with v7, 64K folios are
>> > enabled, zswap uses zstd.
>> >
>> >
>> > -----------------------------------------------
>> >                sleep 10           sleep 30
>> >       Throughput (KB/s)  Throughput (KB/s)
>> >  -----------------------------------------------
>> >                 181,540            191,686
>> >                 179,651            191,459
>> >                 179,068            188,834
>> >                 177,244            187,568
>> >                 177,215            186,703
>> >                 176,565            185,584
>> >                 176,546            185,370
>> >                 176,470            185,021
>> >                 176,214            184,303
>> >                 176,128            184,040
>> >                 175,279            183,932
>> >                 174,745            180,831
>> >                 173,935            179,418
>> >                 161,546            168,014
>> >                 160,332            167,540
>> >                 160,122            167,364
>> >                 159,613            167,020
>> >                 159,546            166,590
>> >                 159,021            166,483
>> >                 158,845            166,418
>> >                 158,426            166,264
>> >                 158,396            166,066
>> >                 158,371            165,944
>> >                 158,298            165,866
>> >                 158,250            165,884
>> >                 158,057            165,533
>> >                 158,011            165,532
>> >                 157,899            165,457
>> >                 157,894            165,424
>> >                 157,839            165,410
>> >                 157,731            165,407
>> >                 157,629            165,273
>> >                 157,626            164,867
>> >                 157,581            164,636
>> >                 157,471            164,266
>> >                 157,430            164,225
>> >                 157,287            163,290
>> >                 156,289            153,597
>> >                 153,970            147,494
>> >                 148,244            147,102
>> >                 142,907            146,111
>> >                 142,811            145,789
>> >                 139,171            141,168
>> >                 136,314            140,714
>> >                 133,616            140,111
>> >                 132,881            139,636
>> >                 132,729            136,943
>> >                 132,680            136,844
>> >                 132,248            135,726
>> >                 132,027            135,384
>> >                 131,929            135,270
>> >                 131,766            134,748
>> >                 131,667            134,733
>> >                 131,576            134,582
>> >                 131,396            134,302
>> >                 131,351            134,160
>> >                 131,135            134,102
>> >                 130,885            134,097
>> >                 130,854            134,058
>> >                 130,767            134,006
>> >                 130,666            133,960
>> >                 130,647            133,894
>> >                 130,152            133,837
>> >                 130,006            133,747
>> >                 129,921            133,679
>> >                 129,856            133,666
>> >                 129,377            133,564
>> >                 128,366            133,331
>> >                 127,988            132,938
>> >                 126,903            132,746
>> >  -----------------------------------------------
>> >       sum    10,526,916         10,919,561
>> >   average       150,385            155,994
>> >    stddev        17,551             19,633
>> >  -----------------------------------------------
>> >     elapsed       24.40              43.66
>> >  time (sec)
>> >    sys time      806.25             766.05
>> >       (sec)
>> >     zswpout  10,008,713         10,008,407
>> >   64K folio     623,463            623,629
>> >      swpout
>> >  -----------------------------------------------
>> 
>> Although there are some imbalance, I don't find it's too much.  So, I
>> think the test result is reasonable.  Please pay attention to the
>> imbalance issue in the future tests.
>
> Sure, will do so.
>
>> 
>> > As we increase the time for which allocations are maintained,
>> > there seems to be a slight improvement in throughput, but the
>> > variance increases as well. The processes with lower throughput
>> > could be the ones that handle the memcg being over limit by
>> > doing reclaim, possibly before they can allocate.
>> >
>> > Interestingly, the longer test time does seem to reduce the amount
>> > of reclaim (hence lower sys time), but more 64K large folios seem to
>> > be reclaimed. Could this mean that with longer test time (sleep 30),
>> > more cold memory residing in large folios is getting reclaimed, as
>> > against memory just relinquished by the exiting processes?
>> 
>> I don't think longer sleep time in test helps much to balance.  Can you
>> try with less process, and larger memory size per process?  I guess that
>> this will improve balance.
>
> I tried this, and the data is listed below:
>
>   usemem options:
>   ---------------
>   30 processes allocate 10G each
>   cgroup memory limit = 150G
>   sleep 10
>   525Gi SSD disk swap partition
>   64K large folios enabled      
>
>   Throughput (KB/s) of each of the 30 processes:
>  ---------------------------------------------------------------
>                       mm-unstable    zswap_store of large folios
>                         9-25-2024                v7
>  zswap compressor:           zstd         zstd  deflate-iaa
>  ---------------------------------------------------------------
>                            38,393      234,485      374,427
>                            37,283      215,528      314,225
>                            37,156      214,942      304,413
>                            37,143      213,073      304,146
>                            36,814      212,904      290,186
>                            36,277      212,304      288,212
>                            36,104      212,207      285,682
>                            36,000      210,173      270,661
>                            35,994      208,487      256,960
>                            35,979      207,788      248,313
>                            35,967      207,714      235,338
>                            35,966      207,703      229,335
>                            35,835      207,690      221,697
>                            35,793      207,418      221,600
>                            35,692      206,160      219,346
>                            35,682      206,128      219,162
>                            35,681      205,817      219,155
>                            35,678      205,546      214,862
>                            35,678      205,523      214,710
>                            35,677      204,951      214,282
>                            35,677      204,283      213,441
>                            35,677      203,348      213,011
>                            35,675      203,028      212,923
>                            35,673      201,922      212,492
>                            35,672      201,660      212,225
>                            35,672      200,724      211,808
>                            35,672      200,324      211,420
>                            35,671      199,686      211,413
>                            35,667      198,858      211,346
>                            35,667      197,590      211,209
>  ---------------------------------------------------------------
>  sum                     1,081,515    6,217,964    7,268,000
>  average                    36,051      207,265      242,267
>  stddev                        655        7,010       42,234
>  elapsed time (sec)         343.70       107.40        84.34
>  sys time (sec)             269.30     2,520.13     1,696.20
>  memcg.high breaches       443,672      475,074      623,333
>  zswpout                    22,605   48,931,249   54,777,100
>  pswpout                40,004,528            0            0
>  hugepages-64K zswpout           0    3,057,090    3,421,855
>  hugepages-64K swpout    2,500,283            0            0
>  ---------------------------------------------------------------
>
> As you can see, this is quite a memory-constrained scenario, where we
> are giving a 50% of total memory required, as the memory limit for the
> cgroup in which the 30 processes are run. This causes significantly more
> reclaim activity than the setup I was using thus far (70 processes, 1G,
> 40G limit).
>
> The variance or "imbalance" reduces somewhat for zstd, but not for IAA.
>
> IAA shows really good throughput (17%) and elapsed time (21%) and
> sys time (33%) improvement wrt zstd with zswap_store of large folios.
> These are the memory-constrained scenarios in which IAA typically
> does really well. IAA verify_compress is enabled, so this is an added
> data integrity checks benefit we get with IAA.
>
> I would like to get your and the maintainers' feedback on whether
> I should switch to this "usemem30-10G" setup for v8?

The results looks good to me.  I suggest you to use it.

--
Best Regards,
Huang, Ying

