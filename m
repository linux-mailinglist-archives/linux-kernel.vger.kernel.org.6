Return-Path: <linux-kernel+bounces-311532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C0D968A26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C365AB23C02
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFD6FC3;
	Mon,  2 Sep 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7F/y6b"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459631A263A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288049; cv=none; b=pbKIH02I7bRYGrheAbOvWIYaRgRT57FfURG8fQ/7DIeCtbPTlOL+gXzYQHgZyn4GjNiph1VIJf4OrbQSnx7hIjpBBoLC/TbxH6USt1x9GE/26vnG3+GAUhG1RSYltOxWW5rEYQpkqXzsDd7kgRQcGuLgH/n0HTryZqvZS/hVDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288049; c=relaxed/simple;
	bh=wHtqJlFxOEL77Fs7LkfCE07SI01gJF6fOyqy9TJWyf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMB4LqhJLmk55IapXY8aGE8HvUHFcqkCDTOpqZ0Ltx55vnG3ccOaJQVJTYpx863UfHtPmXo+VeoRn/d2iCgsFmacOroXVZ65A4TSmoDirK4JNtx1wtokXBOi52ACisGRR0+2+HCLxmvIAcszdrpz1TvwwMU9apGkIRBI25ixvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7F/y6b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8696e9bd24so500820966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725288045; x=1725892845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7q5njZvVeSCgvXzDY2jeTbtkx0/sQYZZ8/yGHkt8/I=;
        b=FU7F/y6bXpGb5XvWssLhE1poc5ZjzkwfVECHCfqNiKs7A2Ak/0apGiuxrt8SW77HVE
         bSM9almnFg2P+7z1VaImpC0aP8tFB1nrs8J+4UgGpjMggIhrA4Wjo2aY/oYqAg16sb+f
         fQXD07OhNtmEeofUH8psWnD8gUXI448BV4aRhmINyLx/o9hopFVxSWDA36yis+RjQ0Kn
         XevMIqSj/q91vKwUERAzJBDR+ML29dxsfG3jH1mB+dTu3neIC263DN+w4lEARWjmQD3I
         oyV+o3OR5SteYQKySDsl0UO0n0Z9eRRt4gqxLErjwRAmQJQjCNNHn2DLeRrzBji4ZI8O
         00Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725288045; x=1725892845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7q5njZvVeSCgvXzDY2jeTbtkx0/sQYZZ8/yGHkt8/I=;
        b=hPlYsVSZhjMSTK0jgpQqqFlK0BZagEJDiVpSpiSBi2XEnuAXgyn8oFHzV9zLCsblLS
         nqqgyFRSqhUkVwDwNvzdSPPhz8jj5jWxN3EH0ysrIqqj+KkwpwYv9LgxMa+NgZczk6rU
         2r0k0wyia6Io47e+Yl7565K2GlVOFSuqLbVZBLgK0flUObhkLN4zjcVYLmfyJ/1fPOz6
         IvtIsMrY9X8VU4oADNEdhgS9MXAZtL2vu0z9x9g1Nb6lHM0CxDYuPkdVhct6NS+cvSko
         BkvAG1veogPa94xEh/ZeSu1EXz7l4a0oqBNNylyUYElciWHNfMSKjiKmFtO5AHpw8BOc
         CU/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbW2TtiY6gVXN29UN8Hwar9QoOA6xt5AGJNB8L6IRIdE6/HKcWU8lp0JJYEPJMQAeA3n8b589ZWFTEsPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXh+ccTos63RBjq8Fmff/US8cZsgoM5pZ2hzzNmpkUv9UqSVH
	0VC5Zd72yRFD9ibVbh893zWvAwHIKDJmfRM24lJK00r4VMs3L+xy
X-Google-Smtp-Source: AGHT+IHdvR5BhsvXcfkGmP6zSaHC3CN+heqiMf2rtKIUDoIYQKb9pkUU0j8/KndMfin3TTI536WNSw==
X-Received: by 2002:a17:907:7d8e:b0:a86:a6ee:7dad with SMTP id a640c23a62f3a-a897fa6edabmr946050766b.52.1725288044798;
        Mon, 02 Sep 2024 07:40:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:76e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898922276asm565544766b.204.2024.09.02.07.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:40:44 -0700 (PDT)
Message-ID: <cf062292-65d1-4d55-9ec6-d4e73956ecbc@gmail.com>
Date: Mon, 2 Sep 2024 15:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/08/2024 17:27, Kanchana P Sridhar wrote:
> Hi All,
> 
> This patch-series enables zswap_store() to accept and store mTHP
> folios. The most significant contribution in this series is from the 
> earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
> migrated to v6.11-rc3 in patch 2/4 of this series.
> 
> [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
>      https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
> 
> Additionally, there is an attempt to modularize some of the functionality
> in zswap_store(), to make it more amenable to supporting any-order
> mTHPs. For instance, the function zswap_store_entry() stores a zswap_entry
> in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
> delete all offsets corresponding to a higher order folio stored in zswap.
> 
> For accounting purposes, the patch-series adds per-order mTHP sysfs
> "zswpout" counters that get incremented upon successful zswap_store of
> an mTHP folio:
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
> 
> A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> will enable/disable zswap storing of (m)THP. When disabled, zswap will
> fallback to rejecting the mTHP folio, to be processed by the backing
> swap device.
> 
> This patch-series is a precursor to ZSWAP compress batching of mTHP
> swap-out and decompress batching of swap-ins based on swapin_readahead(),
> using Intel IAA hardware acceleration, which we would like to submit in
> subsequent RFC patch-series, with performance improvement data.
> 
Hi Kanchana,

If I am repeating any of the questions raised in previous revisions
over here, please feel free to just point to earlier responses!

Just wanted to check what does compress batching of mTHP swap-out means?
Does it mean that zswap will not compress mTHP page by page, but will compress the entire mTHP?
If it improves performance and possibly the numbers for case 2 below, maybe its worth
adding it to this series?

> Thanks to Ying Huang for pre-posting review feedback and suggestions!
> 
> Thanks also to Nhat, Yosry and Barry for their helpful feedback, data
> reviews and suggestions!
> 
> Changes since v5:
> =================
> 1) Rebased to mm-unstable as of 8/29/2024,
>    commit 9287e4adbc6ab8fa04d25eb82e097fed877a4642.
> 2) Added CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default) to
>    enable/disable zswap_store() of mTHP folios. Thanks Nhat for the
>    suggestion to add a knob by which users can enable/disable this
>    change. Nhat, I hope this is along the lines of what you were
>    thinking.
> 3) Added vm-scalability usemem data with 4K folios with
>    CONFIG_ZSWAP_STORE_THP_DEFAULT_ON off, that I gathered to make sure
>    there is no regression with this change.
> 4) Added data with usemem with 64K and 2M THP for an alternate view of
>    before/after, as suggested by Yosry, so we can understand the impact
>    of when mTHPs are split into 4K folios in shrink_folio_list()
>    (CONFIG_THP_SWAP off) vs. not split (CONFIG_THP_SWAP on) and stored
>    in zswap. Thanks Yosry for this suggestion.
> 
> Changes since v4:
> =================
> 1) Published before/after data with zstd, as suggested by Nhat (Thanks
>    Nhat for the data reviews!).
> 2) Rebased to mm-unstable from 8/27/2024,
>    commit b659edec079c90012cf8d05624e312d1062b8b87.
> 3) Incorporated the change in memcontrol.h that defines obj_cgroup_get() if
>    CONFIG_MEMCG is not defined, to resolve build errors reported by kernel
>    robot; as per Nhat's and Michal's suggestion to not require a separate
>    patch to fix the build errors (thanks both!).
> 4) Deleted all same-filled folio processing in zswap_store() of mTHP, as
>    suggested by Yosry (Thanks Yosry!).
> 5) Squashed the commits that define new mthp zswpout stat counters, and
>    invoke count_mthp_stat() after successful zswap_store()s; into a single
>    commit. Thanks Yosry for this suggestion!
> 
> Changes since v3:
> =================
> 1) Rebased to mm-unstable commit 8c0b4f7b65fd1ca7af01267f491e815a40d77444.
>    Thanks to Barry for suggesting aligning with Ryan Roberts' latest
>    changes to count_mthp_stat() so that it's always defined, even when THP
>    is disabled. Barry, I have also made one other change in page_io.c
>    where count_mthp_stat() is called by count_swpout_vm_event(). I would
>    appreciate it if you can review this. Thanks!
>    Hopefully this should resolve the kernel robot build errors.
> 
> Changes since v2:
> =================
> 1) Gathered usemem data using SSD as the backing swap device for zswap,
>    as suggested by Ying Huang. Ying, I would appreciate it if you can
>    review the latest data. Thanks!
> 2) Generated the base commit info in the patches to attempt to address
>    the kernel test robot build errors.
> 3) No code changes to the individual patches themselves.
> 
> Changes since RFC v1:
> =====================
> 
> 1) Use sysfs for zswpout mTHP stats, as per Barry Song's suggestion.
>    Thanks Barry!
> 2) Addressed some of the code review comments that Nhat Pham provided in
>    Ryan's initial RFC [1]:
>    - Added a comment about the cgroup zswap limit checks occuring once per
>      folio at the beginning of zswap_store().
>      Nhat, Ryan, please do let me know if the comments convey the summary
>      from the RFC discussion. Thanks!
>    - Posted data on running the cgroup suite's zswap kselftest.
> 3) Rebased to v6.11-rc3.
> 4) Gathered performance data with usemem and the rebased patch-series.
> 
> 
> Regression Testing:
> ===================
> I ran vm-scalability usemem 70 processes without mTHP, i.e., only 4K
> folios with mm-unstable and with this patch-series. The main goal was
> to make sure that there is no functional or performance regression
> wrt the earlier zswap behavior for 4K folios,
> CONFIG_ZSWAP_STORE_THP_DEFAULT_ON is not set, and zswap_store() of 4K
> pages goes through the newly added code path [zswap_store(),
> zswap_store_page()].
> 
> The data indicates there is no regression.
> 
>  ------------------------------------------------------------------------------
>                      mm-unstable 8-28-2024                        zswap-mTHP v6
>                                               CONFIG_ZSWAP_STORE_THP_DEFAULT_ON
>                                                                      is not set
>  ------------------------------------------------------------------------------
>  ZSWAP compressor        zstd     deflate-                     zstd    deflate-
>                                        iaa                                  iaa
>  ------------------------------------------------------------------------------
>  Throughput (KB/s)    110,775      113,010               111,550        121,937
>  sys time (sec)      1,141.72       954.87              1,131.95         828.47
>  memcg_high           140,500      153,737               139,772        134,129
>  memcg_swap_high            0            0                     0              0
>  memcg_swap_fail            0            0                     0              0
>  pswpin                     0            0                     0              0
>  pswpout                    0            0                     0              0
>  zswpin                   675          690                   682            684
>  zswpout            9,552,298   10,603,271             9,566,392      9,267,213
>  thp_swpout                 0            0                     0              0
>  thp_swpout_                0            0                     0              0
>   fallback                                                                     
>  pgmajfault             3,453        3,468                 3,841          3,487
>  ZSWPOUT-64kB-mTHP        n/a          n/a                     0              0
>  SWPOUT-64kB-mTHP           0            0                     0              0
>  ------------------------------------------------------------------------------
>                                                  
> 
> Performance Testing:
> ====================
> Testing of this patch-series was done with the v6.11-rc3 mainline, without
> and with this patch-series, on an Intel Sapphire Rapids server,
> dual-socket 56 cores per socket, 4 IAA devices per socket.
> 
> The system has 503 GiB RAM, with 176GiB ZRAM (35% of available RAM) as the
> backing swap device for ZSWAP. zstd is configured as the ZRAM compressor.
> Core frequency was fixed at 2500MHz.
> 
> The vm-scalability "usemem" test was run in a cgroup whose memory.high
> was fixed at 40G. The is no swap limit set for the cgroup. Following a
> similar methodology as in Ryan Roberts' "Swap-out mTHP without splitting"
> series [2], 70 usemem processes were run, each allocating and writing 1G of
> memory:
> 
>     usemem --init-time -w -O -n 70 1g
> 
> The vm/sysfs mTHP stats included with the performance data provide details
> on the swapout activity to ZSWAP/swap.
> 
> Other kernel configuration parameters:
> 
>     ZSWAP Compressors : zstd, deflate-iaa
>     ZSWAP Allocator   : zsmalloc
>     SWAP page-cluster : 2
> 
> In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
> IAA "compression verification" is enabled. Hence each IAA compression
> will be decompressed internally by the "iaa_crypto" driver, the crc-s
> returned by the hardware will be compared and errors reported in case of
> mismatches. Thus "deflate-iaa" helps ensure better data integrity as
> compared to the software compressors.
> 
> Throughput is derived by averaging the individual 70 processes' throughputs
> reported by usemem. sys time is measured with perf. All data points are
> averaged across 3 runs.
> 
> Case 1: Baseline with CONFIG_THP_SWAP turned off, and mTHP is split in reclaim.
> ===============================================================================
> 
> In this scenario, the "before" is CONFIG_THP_SWAP set to off, that results in
> 64K/2M (m)THP to be split, and only 4K folios processed by zswap.
> 
> The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that results
> in 64K/2M (m)THP to not be split, and processed by zswap.
> 
>  64KB mTHP (cgroup memory.high set to 40G):
>  ==========================================
> 
>  -------------------------------------------------------------------------------
>                        v6.11-rc3 mainline              zswap-mTHP     Change wrt
>                                  Baseline                               Baseline
>                         CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y
>  -------------------------------------------------------------------------------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd deflate-
>                                       iaa                     iaa            iaa
>  -------------------------------------------------------------------------------
>  Throughput (KB/s)   136,113      140,044     140,363     151,938    3%       8%
>  sys time (sec)       986.78       951.95      954.85      735.47    3%      23%
>  memcg_high          124,183      127,513     138,651     133,884
>  memcg_swap_high           0            0           0           0
>  memcg_swap_fail     619,020      751,099           0           0
>  pswpin                    0            0           0           0
>  pswpout                   0            0           0           0
>  zswpin                  656          569         624         639
>  zswpout           9,413,603   11,284,812   9,453,761   9,385,910

I would expect zswpout to either remain the same or slightly increase when using
CONFIG_THP_SWAP. But for deflate-iaa, there is a 17% decrease in zswpout, which
doesn't make sense?

>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  pgmajfault            3,470        3,382       4,633       3,611
>  ZSWPOUT-64kB            n/a          n/a     590,768     586,521
>  SWPOUT-64kB               0            0           0           0
>  -------------------------------------------------------------------------------
> 
> 
>  2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
>  =======================================================
> 
>  ------------------------------------------------------------------------------
>                        v6.11-rc3 mainline              zswap-mTHP    Change wrt
>                                  Baseline                              Baseline
>                         CONFIG_THP_SWAP=N       CONFIG_THP_SWAP=Y
>  ------------------------------------------------------------------------------
>  ZSWAP compressor       zstd    deflate-        zstd    deflate-  zstd deflate-
>                                      iaa                     iaa            iaa
>  ------------------------------------------------------------------------------
>  Throughput (KB/s)    164,220    172,523      165,005     174,536  0.5%      1%
>  sys time (sec)        855.76     686.94       801.72      676.65    6%      1%
>  memcg_high            14,628     16,247       14,951      16,096
>  memcg_swap_high            0          0            0           0
>  memcg_swap_fail       18,698     21,114            0           0
>  pswpin                     0          0            0           0
>  pswpout                    0          0            0           0
>  zswpin                   663        665        5,333         781
>  zswpout            8,419,458  8,992,065    8,546,895   9,355,760
>  thp_swpout                 0          0            0           0
>  thp_swpout_           18,697     21,113            0           0
>   fallback
>  pgmajfault             3,439      3,496        8,139       3,582
>  ZSWPOUT-2048kB           n/a        n/a       16,684      18,270
>  SWPOUT-2048kB              0          0            0           0
>  -----------------------------------------------------------------------------
> 
> We see improvements overall in throughput and sys time for zstd and
> deflate-iaa, when comparing before (THP_SWAP=N) vs. after (THP_SWAP=Y).
> 
> 
> Case 2: Baseline with CONFIG_THP_SWAP enabled.
> ==============================================
> 
> In this scenario, the "before" represents zswap rejecting mTHP, and the mTHP
> being stored by the backing swap device.
> 


Just curious, how did you make the before case of zswap rejecting mTHP work?

> The "after" represents data with this patch-series, that results in 64K/2M
> (m)THP being processed by zswap.
> 
>  64KB mTHP (cgroup memory.high set to 40G):
>  ==========================================
> 
>  ------------------------------------------------------------------------------
>                      v6.11-rc3 mainline              zswap-mTHP      Change wrt
>                                Baseline                                Baseline
>  ------------------------------------------------------------------------------
>  ZSWAP compressor       zstd   deflate-        zstd    deflate-   zstd deflate-
>                                     iaa                     iaa             iaa
>  ------------------------------------------------------------------------------
>  Throughput (KB/s)   161,496    156,343     140,363     151,938   -13%      -3%
>  sys time (sec)       771.68     802.08      954.85      735.47   -24%       8%
>  memcg_high          111,223    110,889     138,651     133,884
>  memcg_swap_high           0          0           0           0
>  memcg_swap_fail           0          0           0           0
>  pswpin                   16         16           0           0
>  pswpout           7,471,472  7,527,963           0           0
>  zswpin                  635        605         624         639
>  zswpout               1,509      1,478   9,453,761   9,385,910
>  thp_swpout                0          0           0           0
>  thp_swpout_               0          0           0           0
>   fallback
>  pgmajfault            3,616      3,430       4,633       3,611
>  ZSWPOUT-64kB            n/a        n/a     590,768     586,521
>  SWPOUT-64kB         466,967    470,498           0           0
>  ------------------------------------------------------------------------------
> 
>  2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
>  =======================================================
> 
>  ------------------------------------------------------------------------------
>                       v6.11-rc3 mainline              zswap-mTHP     Change wrt
>                                 Baseline                               Baseline
>  ------------------------------------------------------------------------------
>  ZSWAP compressor       zstd    deflate-        zstd    deflate-  zstd deflate-
>                                      iaa                     iaa            iaa
>  ------------------------------------------------------------------------------
>  Throughput (KB/s)    192,164    194,643     165,005     174,536  -14%     -10%
>  sys time (sec)        823.55     830.42      801.72      676.65    3%      19%
>  memcg_high            16,054     15,936      14,951      16,096
>  memcg_swap_high            0          0           0           0
>  memcg_swap_fail            0          0           0           0
>  pswpin                     0          0           0           0
>  pswpout            8,629,248  8,628,907           0           0
>  zswpin                   560        645       5,333         781
>  zswpout                1,416      1,503   8,546,895   9,355,760
>  thp_swpout            16,854     16,853           0           0
>  thp_swpout_                0          0           0           0
>   fallback
>  pgmajfault             3,341      3,574       8,139       3,582
>  ZSWPOUT-2048kB           n/a        n/a      16,684      18,270
>  SWPOUT-2048kB         16,854     16,853           0           0
>  ------------------------------------------------------------------------------
> 
> In the "Before" scenario, when zswap does not store mTHP, only allocations
> count towards the cgroup memory limit. However, in the "After" scenario,
> with the introduction of zswap_store() mTHP, both, allocations as well as
> the zswap compressed pool usage from all 70 processes are counted towards
> the memory limit. As a result, we see higher swapout activity in the
> "After" data. Hence, more time is spent doing reclaim as the zswap cgroup
> charge leads to more frequent memory.high breaches.
> 

hmm, if that was the case, wouldn't "after" zswpout be much more than the "before"
pswpout. But they look very similar? (Even goes down for zstd)

If pswpout in before is approximately equal to zswpout in after, then doesnt it mean
that swap is performing better than zswap? which probably shouldnt happen.

Thanks,
Usama

> This causes degradation in throughput and sys time with zswap mTHP, more so
> in case of zstd than deflate-iaa. Compress latency could play a part in
> this - when there is more swapout activity happening, a slower compressor
> would cause allocations to stall for any/all of the 70 processes.
> 
> In my opinion, even though the test set up does not provide an accurate
> way for a direct before/after comparison (because of zswap usage being
> counted in cgroup, hence towards the memory.high), it still seems
> reasonable for zswap_store to support (m)THP, so that further performance
> improvements can be implemented.
> 
> One of the ideas that has shown promise in our experiments is to improve
> ZSWAP mTHP store performance using batching. With IAA compress/decompress
> batching used in ZSWAP, we are able to demonstrate significant
> performance improvements and memory savings with IAA in scalability
> experiments, as compared to software compressors. We hope to submit
> this work as subsequent RFCs.
> 
> I would greatly appreciate your code review comments and suggestions!
> 
> Thanks,
> Kanchana
> 
> [2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
> 
> 
> Kanchana P Sridhar (3):
>   mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
>   mm: zswap: zswap_store() extended to handle mTHP folios.
>   mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout
>     stats.
> 
>  include/linux/huge_mm.h    |   1 +
>  include/linux/memcontrol.h |   4 +
>  mm/Kconfig                 |   8 ++
>  mm/huge_memory.c           |   3 +
>  mm/page_io.c               |   3 +-
>  mm/zswap.c                 | 243 +++++++++++++++++++++++++++----------
>  6 files changed, 200 insertions(+), 62 deletions(-)
> 
> 
> base-commit: 9287e4adbc6ab8fa04d25eb82e097fed877a4642


