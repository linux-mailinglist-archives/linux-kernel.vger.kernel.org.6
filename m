Return-Path: <linux-kernel+bounces-305332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B22962D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B91282D60
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470B1A3BAA;
	Wed, 28 Aug 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IODBTZTM"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F291A0718
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860518; cv=none; b=Dx2nckkAkGDJTghsRPhCOvhjQUakYhctlXPDbl4RAdnjrTd+BWpVRtL1O3YBbsGMhhRdvI+pJoVBYQHnOAYrhJUSdHVkEWr2k6AN5ZsRs0b6QJ36vmZOpSsMXTIcfa9Fz4YqqiirszkQgCSNla6/duG2TnJHodgBW1gb48T7vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860518; c=relaxed/simple;
	bh=rBFkt8ZMNpetsg7aghjNNliERr2xePCImoZBcLcNUTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o69P17r+n+1vkg1gQ89H4+wmViUcsGTp9o+3gowqHqv2MpRzWmIhhc/dp3wg2Y2DmqvKornPJsl4nj1Er44bXhFBuK3TbqYaD7leJqqnM6PE6C7jlrHhMOjPbBLt5O7bnVsqVW+PJEBHeJa2I2sa9L6yEQN8tlL07VVfC3lOXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IODBTZTM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a66b813847so413138985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860515; x=1725465315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbvuBG2v10QJ9f5Xp1GfLTdM3eXCpERNZvciQcg7sU8=;
        b=IODBTZTM2V+tAOM8MuW1WqLCDi4d9wYmAckwjvbXE2CvJRR0Ox22eImxmADvV7u1Id
         PZbAM+Q41x6SXzKcNumcdC0SbeHmAfB85nFejY3sylQPHyz2aCaRUpx5NWAFcJy2Iqy+
         Zgr+lKy8tOFCM1EHnBvSaHT6v+HJ9vIF1bhODj6bKA5NL+88RtEz38PceQcjIKlz/reX
         o0EuFMQ/7tpkz8SNqgCEIE5AQ0hEWPqxyW9mpUfGzyK7D1b9NvZnKjUrf6YEX1RJsvWJ
         DQHkMsHmGhtyk6gJrTvxUqs7o2g1OW9E8TA/9mIgUXBOTnzWvewyr2TelAmdumFUhIC7
         siPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860515; x=1725465315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbvuBG2v10QJ9f5Xp1GfLTdM3eXCpERNZvciQcg7sU8=;
        b=vbjL9X4VqMcy+MiSnNq+Hg7asrpCrCErb2uCZZAgnbSnbR3eMnKpuYofbX0+b1d7nM
         G8PuHqtTRhrQWNli/w/rU03Lqj8V78ZBTQJMrPRcyxKh2cKgBUpGkY1p7RpujCAS+yYW
         jP7nA4EeiGH99JPaXU+IiS/VjiypylwG6wCmFyk4abBnB8YCCdp0r2uyE2zAr3rXE8N4
         e7NJt68QzeyfWWg0FYjnT8SOrJshu2/vhOs2a2COaU38PzGgEy6IYRUBjXnxESGpkvKf
         BwJjaGUd95MmDuH7fnvm/POGJV1Y3NpPTQfOgYY12tSEdzwXGE11bG+h0JUp8D4CQFdP
         y3/A==
X-Gm-Message-State: AOJu0Yw+K6/zMQaqJ/L4p+SRCjFouEumFArgv3ELRft644az22Ylo3c0
	PHYePNJLwFKSc8ZLUH5x9Fz7TtfBWn1q/SsUX2Rz0TuaVmtTiQH7MblQ6+GqXZYXmjAgYnfCcTG
	Hn1qnT4M4h6bMowtyWDCHS3F9zDw2zQ==
X-Google-Smtp-Source: AGHT+IEjFk8p6kwJREwE/izAvLI/ccYVMAPI035pw1YN0pB/Uha+TfBY33qz/fdAdC8sN6QVNGzNaXBokeGWJ40wT/g=
X-Received: by 2002:a05:620a:2802:b0:79e:f8de:3c64 with SMTP id
 af79cd13be357-7a7f4cf0a6amr218887485a.48.1724860515066; Wed, 28 Aug 2024
 08:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 28 Aug 2024 08:55:04 -0700
Message-ID: <CAKEwX=POQzRoiqPSqkwDnVGH=KwyEd_vrW7XNx16cXBaLWbVUQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:35=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi All,
>
> This patch-series enables zswap_store() to accept and store mTHP
> folios. The most significant contribution in this series is from the
> earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
> migrated to v6.11-rc3 in patch 2/4 of this series.
>
> [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
>      https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.rober=
ts@arm.com/T/#u
>
> Additionally, there is an attempt to modularize some of the functionality
> in zswap_store(), to make it more amenable to supporting any-order
> mTHPs. For instance, the function zswap_store_entry() stores a zswap_entr=
y
> in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
> delete all offsets corresponding to a higher order folio stored in zswap.
>
> For accounting purposes, the patch-series adds per-order mTHP sysfs
> "zswpout" counters that get incremented upon successful zswap_store of
> an mTHP folio:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
>
> This patch-series is a precursor to ZSWAP compress batching of mTHP
> swap-out and decompress batching of swap-ins based on swapin_readahead(),
> using Intel IAA hardware acceleration, which we would like to submit in
> subsequent RFC patch-series, with performance improvement data.
>
> Thanks to Ying Huang for pre-posting review feedback and suggestions!
>
> Changes since v4:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1) Published before/after data with zstd, as suggested by Nhat (Thanks
>    Nhat for the data reviews!).
> 2) Rebased to mm-unstable from 8/27/2024,
>    commit b659edec079c90012cf8d05624e312d1062b8b87.
> 3) Incorporated the change in memcontrol.h that defines obj_cgroup_get() =
if
>    CONFIG_MEMCG is not defined, to resolve build errors reported by kerne=
l
>    robot; as per Nhat's and Michal's suggestion to not require a separate
>    patch to fix the build errors (thanks both!).
> 4) Deleted all same-filled folio processing in zswap_store() of mTHP, as
>    suggested by Yosry (Thanks Yosry!).
> 5) Squashed the commits that define new mthp zswpout stat counters, and
>    invoke count_mthp_stat() after successful zswap_store()s; into a singl=
e
>    commit. Thanks Yosry for this suggestion!
>
> Changes since v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1) Rebased to mm-unstable commit 8c0b4f7b65fd1ca7af01267f491e815a40d77444=
.
>    Thanks to Barry for suggesting aligning with Ryan Roberts' latest
>    changes to count_mthp_stat() so that it's always defined, even when TH=
P
>    is disabled. Barry, I have also made one other change in page_io.c
>    where count_mthp_stat() is called by count_swpout_vm_event(). I would
>    appreciate it if you can review this. Thanks!
>    Hopefully this should resolve the kernel robot build errors.
>
> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1) Gathered usemem data using SSD as the backing swap device for zswap,
>    as suggested by Ying Huang. Ying, I would appreciate it if you can
>    review the latest data. Thanks!
> 2) Generated the base commit info in the patches to attempt to address
>    the kernel test robot build errors.
> 3) No code changes to the individual patches themselves.
>
> Changes since RFC v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1) Use sysfs for zswpout mTHP stats, as per Barry Song's suggestion.
>    Thanks Barry!
> 2) Addressed some of the code review comments that Nhat Pham provided in
>    Ryan's initial RFC [1]:
>    - Added a comment about the cgroup zswap limit checks occuring once pe=
r
>      folio at the beginning of zswap_store().
>      Nhat, Ryan, please do let me know if the comments convey the summary
>      from the RFC discussion. Thanks!
>    - Posted data on running the cgroup suite's zswap kselftest.
> 3) Rebased to v6.11-rc3.
> 4) Gathered performance data with usemem and the rebased patch-series.
>
> Performance Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Testing of this patch-series was done with the v6.11-rc3 mainline, withou=
t
> and with this patch-series, on an Intel Sapphire Rapids server,
> dual-socket 56 cores per socket, 4 IAA devices per socket.
>
> The system has 503 GiB RAM, with 176GiB ZRAM (35% of available RAM) as th=
e
> backing swap device for ZSWAP. zstd is configured as the ZRAM compressor.
> Core frequency was fixed at 2500MHz.
>
> The vm-scalability "usemem" test was run in a cgroup whose memory.high
> was fixed at 40G. The is no swap limit set for the cgroup. Following a

I thought it was 60G. Why are we reducing it to 40G here? Just curious :)

> similar methodology as in Ryan Roberts' "Swap-out mTHP without splitting"
> series [2], 70 usemem processes were run, each allocating and writing 1G =
of
> memory:
>
>     usemem --init-time -w -O -n 70 1g
>
> The vm/sysfs mTHP stats included with the performance data provide detail=
s
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
> Throughput is derived by averaging the individual 70 processes' throughpu=
ts
> reported by usemem. sys time is measured with perf. All data points are
> averaged across 3 runs.
>
>  64KB mTHP (cgroup memory.high set to 40G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
------
>                      v6.11-rc3 mainline              zswap-mTHP      Chan=
ge wrt
>                                Baseline                                Ba=
seline
>  ------------------------------------------------------------------------=
------
>  ZSWAP compressor       zstd   deflate-        zstd    deflate-   zstd de=
flate-
>                                     iaa                     iaa          =
   iaa
>  ------------------------------------------------------------------------=
------
>  Throughput (KB/s)   161,496    156,343     140,363     151,938   -13%   =
   -3%
>  sys time (sec)       771.68     802.08      954.85      735.47   -24%   =
    8%
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
>  ------------------------------------------------------------------------=
------
>
>  2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
------
>                       v6.11-rc3 mainline              zswap-mTHP     Chan=
ge wrt
>                                 Baseline                               Ba=
seline
>  ------------------------------------------------------------------------=
------
>  ZSWAP compressor       zstd    deflate-        zstd    deflate-  zstd de=
flate-
>                                      iaa                     iaa         =
   iaa
>  ------------------------------------------------------------------------=
------
>  Throughput (KB/s)    192,164    194,643     165,005     174,536  -14%   =
  -10%
>  sys time (sec)        823.55     830.42      801.72      676.65    3%   =
   19%
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
>  ------------------------------------------------------------------------=
------

OK these numbers are much more positive now. Some observation:

1. The pswpout and zswpout cells are much more sane now. I still think
we have issues with the way zswap cgroup charging interacts with our
reclaim dynamics, but my theory is that these issues only manifest in
more extreme conditions - high concurrency + fast reclaim path =3D=3D
memory.high limit constantly violated, leading to the vicious cycle of
overreclaim? zstd has a much better compression ratio than lz4, so
that probably lowers the violation amount per iteration, which
compounds overtime and drastically reduces the overreclaiming issue.
We probably should still investigate and fix it though.

2. That said, there are still regressions with respect to the mTHP
case. But it is outperforming in big THP now! This is strange.

3. I also noticed that your pswpin and zswpin rows are all 0 or really
small. Is this why we are not seeing much gains with zswap? I mean, if
you are not going to use these pages, offloading them to swap is
better by definition... I wonder if lowering the memory limit even
further would show positive numbers? Or

>
> In the "Before" scenario, when zswap does not store mTHP, only allocation=
s
> count towards the cgroup memory limit. However, in the "After" scenario,
> with the introduction of zswap_store() mTHP, both, allocations as well as
> the zswap compressed pool usage from all 70 processes are counted towards
> the memory limit. As a result, we see higher swapout activity in the
> "After" data. Hence, more time is spent doing reclaim as the zswap cgroup
> charge leads to more frequent memory.high breaches.
>
> This causes degradation in throughput and sys time with zswap mTHP, more =
so
> in case of zstd than deflate-iaa. Compress latency could play a part in
> this - when there is more swapout activity happening, a slower compressor
> would cause allocations to stall for any/all of the 70 processes.
>
> In my opinion, even though the test set up does not provide an accurate
> way for a direct before/after comparison (because of zswap usage being
> counted in cgroup, hence towards the memory.high), it still seems
> reasonable for zswap_store to support (m)THP, so that further performance
> improvements can be implemented.

Can we add a knob/config to enable/disable this? Just in case we are
regressing software compressor users for the sake of hardware
compressor users. Especially when the former are the majority of the
users, and the latter requires more investment :)

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

Thanks for the hard work, Kanchana!

>
> [2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.robert=
s@arm.com/
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
>  mm/huge_memory.c           |   3 +
>  mm/page_io.c               |   3 +-
>  mm/zswap.c                 | 231 +++++++++++++++++++++++++++----------
>  5 files changed, 180 insertions(+), 62 deletions(-)
>
>
> base-commit: b659edec079c90012cf8d05624e312d1062b8b87
> --
> 2.27.0
>

