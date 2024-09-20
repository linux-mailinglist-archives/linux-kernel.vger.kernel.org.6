Return-Path: <linux-kernel+bounces-334186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33197D3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93EBB243DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67128136658;
	Fri, 20 Sep 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaXKIUc8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229633981
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824773; cv=none; b=IJDW23Z3Wdip520BYTuH2WPM25gHpvS1NRKHVdOgxf51AgM4EMs7N69w0dBWM6ocqCV0Mk/2JhFDfUgYqRK7TBKciNpoXNTK+AnT5oV26MuaL9kUcgu2dp/8D5TEhlecc3StgXf0gTgeTMHrySueGM8ez9lEkr5s3Dq66V4WlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824773; c=relaxed/simple;
	bh=IE9pentAbh+IEJlmH3vThkMt45Jgd4/BBZj41E+nRrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwKuz0iCjeLCMVflAR2T45h9q/sK9ymu+kKg5UDEt03cgHFCTKIjpsGsfW4qOqnN6UEtQAccA8/jBX59d3wQajcuwuP8eYTxdLC+3PBxCHZV+/IvPg8k1OxPng1/Ech9JX8TAcZSErfrkDgtoEBtjIQtduUYlB6ELt2pUqIOdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaXKIUc8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726824772; x=1758360772;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IE9pentAbh+IEJlmH3vThkMt45Jgd4/BBZj41E+nRrk=;
  b=gaXKIUc8dN2Nt+eEH8jrUEfSExQm1Tr62tl6tZt/RNEJpXV2wRQv0MmE
   D4D2XJOBPfkONxg60YNxw2mYir9Nq3tU1C51/nPw49buPUn2cYn+9GLAx
   Lz7Xojfk2nnJH7ykk5wDHviFCsqDf++BEjNJZGt2jiIOF6+V65Z8r+VpM
   STF84I+aeSpDlR+KiTBphdm3J4Dmw2MSZ9gnlcw4MDDF074CISDyHh/tw
   /yn+akpE/1gBqHB/tPkXgCmN71SiXeI6LhWm0YsbS64VW9rTRypDP6zf/
   5Oz7fUmkIY+03umhwnGufDL03qaZhx0t+HskDnFqMOaDS9BF2Z5Lxsxi0
   Q==;
X-CSE-ConnectionGUID: iSdbc54YQmW1asDpl1YzDw==
X-CSE-MsgGUID: gVif6SWFRYeCSGs9U88U8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25969775"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25969775"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:32:51 -0700
X-CSE-ConnectionGUID: Pf+3Vca1RvGkY5z60bkUNA==
X-CSE-MsgGUID: lMRDawGyTFSQWm+ORH2FTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="74618221"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 02:32:48 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "nphamcs@gmail.com" <nphamcs@gmail.com>,  "chengming.zhou@linux.dev"
 <chengming.zhou@linux.dev>,  "usamaarif642@gmail.com"
 <usamaarif642@gmail.com>,  "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
  "21cnbao@gmail.com" <21cnbao@gmail.com>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "Zou, Nanhai" <nanhai.zou@intel.com>,
  "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,  "Gopal, Vinodh"
 <vinodh.gopal@intel.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
In-Reply-To: <SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
	(Kanchana P. Sridhar's message of "Fri, 20 Sep 2024 09:41:02 +0800")
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
	<CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
	<SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Date: Fri, 20 Sep 2024 17:29:14 +0800
Message-ID: <87ikuqvfkl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:

[snip]

>
> Thanks, these are good points. I ran this experiment with mm-unstable 9-17-2024,
> commit 248ba8004e76eb335d7e6079724c3ee89a011389.
>
> Data is based on average of 3 runs of the vm-scalability "usemem" test.
>
>  4G SSD backing zswap, each process sleeps before exiting
>  ========================================================
>
>  64KB mTHP (cgroup memory.high set to 60G, no swap limit):
>  =========================================================
>  CONFIG_THP_SWAP=Y
>  Sapphire Rapids server with 503 GiB RAM and 4G SSD swap backing device
>  for zswap.
>
>  Experiment 1: Each process sleeps for 0 sec after allocating memory
>  (usemem --init-time -w -O --sleep 0 -n 70 1g):
>
>  -------------------------------------------------------------------------------
>                     mm-unstable 9-17-2024           zswap-mTHP v6     Change wrt
>                                  Baseline                               Baseline
>                                  "before"                 "after"      (sleep 0)
>  -------------------------------------------------------------------------------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>                                       iaa                     iaa            iaa
>  -------------------------------------------------------------------------------
>  Throughput (KB/s)   296,684      274,207     359,722     390,162    21%     42%
>  sys time (sec)        92.67        93.33      251.06      237.56  -171%   -155%
>  memcg_high            3,503        3,769      44,425      27,154
>  memcg_swap_fail           0            0     115,814     141,936
>  pswpin                   17            0           0           0
>  pswpout             370,853      393,232           0           0
>  zswpin                  693          123         666         667
>  zswpout               1,484          123   1,366,680   1,199,645
>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  pgmajfault            3,384        2,951       3,656       3,468
>  ZSWPOUT-64kB            n/a          n/a      82,940      73,121
>  SWPOUT-64kB          23,178       24,577           0           0
>  -------------------------------------------------------------------------------
>
>
>  Experiment 2: Each process sleeps for 10 sec after allocating memory
>  (usemem --init-time -w -O --sleep 10 -n 70 1g):
>
>  -------------------------------------------------------------------------------
>                     mm-unstable 9-17-2024           zswap-mTHP v6     Change wrt
>                                  Baseline                               Baseline
>                                  "before"                 "after"     (sleep 10)
>  -------------------------------------------------------------------------------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>                                       iaa                     iaa            iaa
>  -------------------------------------------------------------------------------
>  Throughput (KB/s)    86,744       93,730     157,528     113,110    82%     21%
>  sys time (sec)       308.87       315.29      477.55      629.98   -55%   -100%

What is the elapsed time for all cases?

>  memcg_high          169,450      188,700     143,691     177,887
>  memcg_swap_fail  10,131,859    9,740,646  18,738,715  19,528,110
>  pswpin                   17           16           0           0
>  pswpout           1,154,779    1,210,485           0           0
>  zswpin                  711          659       1,016         736
>  zswpout              70,212       50,128   1,235,560   1,275,917
>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  pgmajfault            6,120        6,291       8,789       6,474
>  ZSWPOUT-64kB            n/a          n/a      67,587      68,912
>  SWPOUT-64kB          72,174       75,655           0           0
>  -------------------------------------------------------------------------------
>
>
> Conclusions from the experiments:
> =================================
> 1) zswap-mTHP improves throughput as compared to the baseline, for zstd and
>    deflate-iaa.
>
> 2) Yosry's theory is proved correct in the 4G constrained swap setup.
>    When the processes are constrained to sleep 10 sec after allocating
>    memory, thereby keeping the memory allocated longer, the "Baseline" or
>    "before" with mTHP getting stored in SSD shows a degradation of 71% in
>    throughput and 238% in sys time, as compared to the "Baseline" with

Higher sys time may come from compression with CPU vs. disk writing?

>    sleep 0 that benefits from serialization of disk IO not allowing all
>    processes to allocate memory at the same time.
>
> 3) In the 4G SSD "sleep 0" case, zswap-mTHP shows an increase in sys time
>    due to the cgroup charging and consequently higher memcg.high breaches
>    and swapout activity.
>
>    However, the "sleep 10" case's sys time seems to degrade less, and the
>    memcg.high breaches and swapout activity are almost similar between the
>    before/after (confirming Yosry's hypothesis). Further, the
>    memcg_swap_fail activity in the "after" scenario is almost 2X that of
>    the "before". This indicates failure to obtain swap offsets, resulting
>    in the folio remaining active in memory.
>
>    I tried to better understand this through the 64k mTHP swpout_fallback
>    stats in the "sleep 10" zstd experiments:
>
>    --------------------------------------------------------------
>                                            "before"       "after"
>    --------------------------------------------------------------
>    64k mTHP swpout_fallback                 627,308       897,407
>    64k folio swapouts                        72,174        67,587
>    [p|z]swpout events due to 64k mTHP     1,154,779     1,081,397
>    4k folio swapouts                         70,212       154,163
>    --------------------------------------------------------------
>
>    The data indicates a higher # of 64k folio swpout_fallback with
>    zswap-mTHP, that co-relates with the higher memcg_swap_fail counts and
>    4k folio swapouts with zswap-mTHP. Could the root-cause be fragmentation
>    of the swap space due to zswap swapout being faster than SSD swapout?
>

[snip]

--
Best Regards,
Huang, Ying

