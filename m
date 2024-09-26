Return-Path: <linux-kernel+bounces-339771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D2986A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A9A1F22CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA316FF25;
	Thu, 26 Sep 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFavqCw5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E61D5ADC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727311697; cv=none; b=TpD/YXWfLH+50Pz873CMERnmBhU6KpEYZ9/HnZR5IebxdCjX7WVh62vTPFhZVFzV8oTW6VHEN/NedNqrCJDZSMmDMIgv6LdV+QcLaYGlKllEOrzcSZMlGgnokK3F0E7owDU6XgbgT653uuH9yKF9mcgL/uNfyT7JPiYnSvxIYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727311697; c=relaxed/simple;
	bh=cOgDWVnlUJg/7PGR9wEDlkr6Ro3VyvIPFpymOkUAPgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2joKemvjsrdiFzYXXKrCJUAnQc9/Oz9rR2DKMzcROesU8+2iFKP3n7TN6+CP0NNV6A5o6KE9Gq3kljWZEBJOzSebLBoq4fP+8wo1cIOmgOPmt5TB0LXiRSIy+ANsPTfayzrqDSCD3o6QnhWkDwxoWSRsrlNFDkGgDGUWI35Wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFavqCw5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727311696; x=1758847696;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cOgDWVnlUJg/7PGR9wEDlkr6Ro3VyvIPFpymOkUAPgI=;
  b=AFavqCw5xy/AVC65QulwaK97ct2FkvjACEG3bPe/be3RVJqnjScYIjiJ
   DmZuu4Mk2vLSWPD5624xWZeXfGfimHUf3uA642aUHN9eQ3Zq/ilPkgAfx
   MtTwPaAlKmCmfVNq2DVeSTDmBkpiX+5jru0GodxNyKtIWKEo9wmQ9w+rx
   6IGWknj0ZYYyVeVs7hXopgUVUJARZinrA/7f/v6x6fB65kRWzbLgRHKYq
   mKUZvXClSTX2xc5eli9WR5rjYfmCkJByIR0KPkLSNHOlC2SoQselJ/96i
   UxPAf+ESxsPBPN+va+JnvRqc28rei0PcpKdObUrnZaECbsYm8ZyYnM4L8
   A==;
X-CSE-ConnectionGUID: ry35W9zqTVObbV32G8QW7A==
X-CSE-MsgGUID: 0SgZRI0RSy6AwmT+yhR0vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26567175"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26567175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 17:48:13 -0700
X-CSE-ConnectionGUID: LX4AOFhzTMOiw48P8geTBA==
X-CSE-MsgGUID: GkjIn0nhTKaOGM1czQFY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71623483"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 17:48:09 -0700
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
In-Reply-To: <SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
	(Kanchana P. Sridhar's message of "Thu, 26 Sep 2024 02:39:25 +0800")
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
	<87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
Date: Thu, 26 Sep 2024 08:44:36 +0800
Message-ID: <877cazs0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:

>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Tuesday, September 24, 2024 11:35 PM
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
>> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>> 
>> [snip]
>> 
>> >
>> > Case 1: Comparing zswap 4K vs. zswap mTHP
>> > =========================================
>> >
>> > In this scenario, the "before" is CONFIG_THP_SWAP set to off, that results in
>> > 64K/2M (m)THP to be split into 4K folios that get processed by zswap.
>> >
>> > The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that
>> results
>> > in 64K/2M (m)THP to not be split, and processed by zswap.
>> >
>> >  64KB mTHP (cgroup memory.high set to 40G):
>> >  ==========================================
>> >
>> >  -------------------------------------------------------------------------------
>> >                     mm-unstable 9-23-2024              zswap-mTHP     Change wrt
>> >                         CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y       Baseline
>> >                                  Baseline
>> >  -------------------------------------------------------------------------------
>> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>> >                                       iaa                     iaa            iaa
>> >  -------------------------------------------------------------------------------
>> >  Throughput (KB/s)   143,323      125,485     153,550     129,609    7%       3%
>> >  elapsed time (sec)    24.97        25.42       23.90       25.19    4%       1%
>> >  sys time (sec)       822.72       750.96      757.70      731.13    8%       3%
>> >  memcg_high          132,743      169,825     148,075     192,744
>> >  memcg_swap_fail     639,067      841,553       2,204       2,215
>> >  pswpin                    0            0           0           0
>> >  pswpout                   0            0           0           0
>> >  zswpin                  795          873         760         902
>> >  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
>> >  thp_swpout                0            0           0           0
>> >  thp_swpout_               0            0           0           0
>> >   fallback
>> >  64kB-mthp_          639,065      841,553       2,204       2,215
>> >   swpout_fallback
>> >  pgmajfault            2,861        2,924       3,054       3,259
>> >  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
>> >  SWPOUT-64kB               0            0           0           0
>> >  -------------------------------------------------------------------------------
>> >
>> 
>> IIUC, the throughput is the sum of throughput of all usemem processes?
>> 
>> One possible issue of usemem test case is the "imbalance" issue.  That
>> is, some usemem processes may swap-out/swap-in less, so the score is
>> very high; while some other processes may swap-out/swap-in more, so the
>> score is very low.  Sometimes, the total score decreases, but the scores
>> of usemem processes are more balanced, so that the performance should be
>> considered better.  And, in general, we should make usemem score
>> balanced among processes via say longer test time.  Can you check this
>> in your test results?
>
> Actually, the throughput data listed in the cover-letter is the average of
> all the usemem processes. Your observation about the "imbalance" issue is
> right. Some processes see a higher throughput than others. I have noticed
> that the throughputs progressively reduce as the individual processes exit
> and print their stats.
>
> Listed below are the stats from two runs of usemem70: sleep 10 and sleep 30.
> Both are run with a cgroup mem-limit of 40G. Data is with v7, 64K folios are
> enabled, zswap uses zstd. 
>
>
> -----------------------------------------------
>                sleep 10           sleep 30
>       Throughput (KB/s)  Throughput (KB/s)
>  -----------------------------------------------
>                 181,540            191,686
>                 179,651            191,459
>                 179,068            188,834
>                 177,244            187,568
>                 177,215            186,703
>                 176,565            185,584
>                 176,546            185,370
>                 176,470            185,021
>                 176,214            184,303
>                 176,128            184,040
>                 175,279            183,932
>                 174,745            180,831
>                 173,935            179,418
>                 161,546            168,014
>                 160,332            167,540
>                 160,122            167,364
>                 159,613            167,020
>                 159,546            166,590
>                 159,021            166,483
>                 158,845            166,418
>                 158,426            166,264
>                 158,396            166,066
>                 158,371            165,944
>                 158,298            165,866
>                 158,250            165,884
>                 158,057            165,533
>                 158,011            165,532
>                 157,899            165,457
>                 157,894            165,424
>                 157,839            165,410
>                 157,731            165,407
>                 157,629            165,273
>                 157,626            164,867
>                 157,581            164,636
>                 157,471            164,266
>                 157,430            164,225
>                 157,287            163,290
>                 156,289            153,597
>                 153,970            147,494
>                 148,244            147,102
>                 142,907            146,111
>                 142,811            145,789
>                 139,171            141,168
>                 136,314            140,714
>                 133,616            140,111
>                 132,881            139,636
>                 132,729            136,943
>                 132,680            136,844
>                 132,248            135,726
>                 132,027            135,384
>                 131,929            135,270
>                 131,766            134,748
>                 131,667            134,733
>                 131,576            134,582
>                 131,396            134,302
>                 131,351            134,160
>                 131,135            134,102
>                 130,885            134,097
>                 130,854            134,058
>                 130,767            134,006
>                 130,666            133,960
>                 130,647            133,894
>                 130,152            133,837
>                 130,006            133,747
>                 129,921            133,679
>                 129,856            133,666
>                 129,377            133,564
>                 128,366            133,331
>                 127,988            132,938
>                 126,903            132,746
>  -----------------------------------------------
>       sum    10,526,916         10,919,561
>   average       150,385            155,994
>    stddev        17,551             19,633
>  -----------------------------------------------
>     elapsed       24.40              43.66
>  time (sec)
>    sys time      806.25             766.05
>       (sec)
>     zswpout  10,008,713         10,008,407
>   64K folio     623,463            623,629
>      swpout
>  -----------------------------------------------

Although there are some imbalance, I don't find it's too much.  So, I
think the test result is reasonable.  Please pay attention to the
imbalance issue in the future tests.

> As we increase the time for which allocations are maintained,
> there seems to be a slight improvement in throughput, but the
> variance increases as well. The processes with lower throughput
> could be the ones that handle the memcg being over limit by
> doing reclaim, possibly before they can allocate.
>
> Interestingly, the longer test time does seem to reduce the amount
> of reclaim (hence lower sys time), but more 64K large folios seem to
> be reclaimed. Could this mean that with longer test time (sleep 30),
> more cold memory residing in large folios is getting reclaimed, as
> against memory just relinquished by the exiting processes?

I don't think longer sleep time in test helps much to balance.  Can you
try with less process, and larger memory size per process?  I guess that
this will improve balance.

--
Best Regards,
Huang, Ying

