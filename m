Return-Path: <linux-kernel+bounces-307798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20D96531A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C271C20DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587ED1B81D1;
	Thu, 29 Aug 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xuCz2mN7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BA1898E5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971780; cv=none; b=PzIHnAfiIbyH4XnAEjSmAJ1x/0xGE0O+z3K/3bL7R2yPRQsCOsi38v1gCwEm5mVW88DJ+KEi+R+8WW1edryfRizareeUK6kLxoRTXUWt1gi/G4l6FyNP0Wgv3IduX4P0ptk8zX+ckNS34Lwhrwa5z2N9GIpmRk7m1EuthfC1lO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971780; c=relaxed/simple;
	bh=8ojtP0lwSVd5Cb2bEN6VTPc/7MYxkEqMdEfy5msFlCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH7dqzNOBumtA5WSWsSO61u4eC86/064BiPCGK9XWRQtx5EzXQue0ZY4SPgLVO+3HRO9rsw8YtT/s/0SGxvQ9SfxfbtoW6Ax0vNzij0G9nqGRHL9Jll37maydj/cR2XaryFV/FsetS01IcVTCQgEF6Nz9UQVYq5BpTcNTh3SyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xuCz2mN7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533496017f8so1553558e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724971776; x=1725576576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq/4ntOkZ/DICPG1Q0id1sEfKK6qdlL2j10qZC1Qx0U=;
        b=xuCz2mN7dfGBgBNMFGJ7IMUR/iJ3cSKTCaammLrMBiFQ/1/+Nrjnz/EvUtOwn1GGmq
         iQiawPVsZbIOSvLHSP6ABOCa0j61GPL+W3M/JpinDc0Qp14YZwIZcebAZE9Nh8AsxZq0
         vGmKC7m6dK0br36N7cKRr1H87vGcU0WoOvuFI5zt6L6uhRw1LH70dIE5xdMYBtDX7Rcf
         6QBW5goqTFss6g5QOwGfIFnzj+V4Olcj2cDGnOqPXW3KuLq2cLfYMly77fDnQ12NfNwP
         gtU3PqEwVU3pm5vUN0Gq5ZFs0NAuZPquNC9STftl9fEVG8AX6sgYR9Idpq+M0ReJeEbg
         SJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971776; x=1725576576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq/4ntOkZ/DICPG1Q0id1sEfKK6qdlL2j10qZC1Qx0U=;
        b=VaoT816HSvNG/JGvjHeI3f+6t5c5zyntZ+aX8ea6KBj2BqW0AGJi9MhF2zthE7tF3N
         EhjpYdcsGxrxt3CxZBc66c+1EGB75i326QR3k9l/5KD93FTxVCNoZp5vTmxXyDv5YybW
         oYlzpb7i64vEb0Y+iog9z4lk1CrZOdXSHxhe4hfA3LkQKn9nGgjlvdQkcv5mzE0OhKWF
         +v2QIOYjC508B3PAo5IVQposUxXwQcUObsfU5mdAAZxknijtu0+UBC3aygMPj8PORp9e
         /1lGD6Em0r0lI0aqdwVuGcKwqJpEzzgLOI/aRipEhIVObObYoSYcTCSJoTnqdAWGZKlK
         l1YQ==
X-Gm-Message-State: AOJu0YwMejOTIifalnvHSf3xaiFlIsqffFXHLEBj7FIJIx6GYsT6hYHc
	AmFSL4rQzn3hdU5rEkjOrE/XmT5bC4bxZYpm1blIXFzCMuLSjhSRry79TIylk+tKqehHF6phW/M
	0VmpwUKGqYXEk9bQ29sHu4hWTKiQKyGSOh8iW
X-Google-Smtp-Source: AGHT+IFXVMafGDZCChXBYhsmR5k/msl2gc7lJQAP+3qeoy5DQFb6dUs87pNaZBLDlpRCKMDyrVH/XRc3bIgNDaHgwWc=
X-Received: by 2002:ac2:4e06:0:b0:534:3cdc:dbfe with SMTP id
 2adb3069b0e04-53546b2b9f3mr54178e87.28.1724971775619; Thu, 29 Aug 2024
 15:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 15:48:58 -0700
Message-ID: <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
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
> Thanks to Ying Huang for pre-posting review feedback and suggestions!
>
> Thanks also to Nhat, Yosry and Barry for their helpful feedback, data
> reviews and suggestions!
>
> Changes since v5:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>
> Regression Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>  ------------------------------------------------------------------------=
------
>                      mm-unstable 8-28-2024                        zswap-m=
THP v6
>                                               CONFIG_ZSWAP_STORE_THP_DEFA=
ULT_ON
>                                                                      is n=
ot set
>  ------------------------------------------------------------------------=
------
>  ZSWAP compressor        zstd     deflate-                     zstd    de=
flate-
>                                        iaa                               =
   iaa
>  ------------------------------------------------------------------------=
------
>  Throughput (KB/s)    110,775      113,010               111,550        1=
21,937
>  sys time (sec)      1,141.72       954.87              1,131.95         =
828.47
>  memcg_high           140,500      153,737               139,772        1=
34,129
>  memcg_swap_high            0            0                     0         =
     0
>  memcg_swap_fail            0            0                     0         =
     0
>  pswpin                     0            0                     0         =
     0
>  pswpout                    0            0                     0         =
     0
>  zswpin                   675          690                   682         =
   684
>  zswpout            9,552,298   10,603,271             9,566,392      9,2=
67,213
>  thp_swpout                 0            0                     0         =
     0
>  thp_swpout_                0            0                     0         =
     0
>   fallback
>  pgmajfault             3,453        3,468                 3,841         =
 3,487
>  ZSWPOUT-64kB-mTHP        n/a          n/a                     0         =
     0
>  SWPOUT-64kB-mTHP           0            0                     0         =
     0
>  ------------------------------------------------------------------------=
------
>
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
> Case 1: Baseline with CONFIG_THP_SWAP turned off, and mTHP is split in re=
claim.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> In this scenario, the "before" is CONFIG_THP_SWAP set to off, that result=
s in
> 64K/2M (m)THP to be split, and only 4K folios processed by zswap.
>
> The "after" is CONFIG_THP_SWAP set to on, and this patch-series, that res=
ults
> in 64K/2M (m)THP to not be split, and processed by zswap.
>
>  64KB mTHP (cgroup memory.high set to 40G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
-------
>                        v6.11-rc3 mainline              zswap-mTHP     Cha=
nge wrt
>                                  Baseline                               B=
aseline
>                         CONFIG_THP_SWAP=3DN       CONFIG_THP_SWAP=3DY
>  ------------------------------------------------------------------------=
-------
>  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd d=
eflate-
>                                       iaa                     iaa        =
    iaa
>  ------------------------------------------------------------------------=
-------
>  Throughput (KB/s)   136,113      140,044     140,363     151,938    3%  =
     8%
>  sys time (sec)       986.78       951.95      954.85      735.47    3%  =
    23%
>  memcg_high          124,183      127,513     138,651     133,884
>  memcg_swap_high           0            0           0           0
>  memcg_swap_fail     619,020      751,099           0           0
>  pswpin                    0            0           0           0
>  pswpout                   0            0           0           0
>  zswpin                  656          569         624         639
>  zswpout           9,413,603   11,284,812   9,453,761   9,385,910
>  thp_swpout                0            0           0           0
>  thp_swpout_               0            0           0           0
>   fallback
>  pgmajfault            3,470        3,382       4,633       3,611
>  ZSWPOUT-64kB            n/a          n/a     590,768     586,521
>  SWPOUT-64kB               0            0           0           0
>  ------------------------------------------------------------------------=
-------
>
>
>  2MB PMD-THP/2048K mTHP (cgroup memory.high set to 40G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>  ------------------------------------------------------------------------=
------
>                        v6.11-rc3 mainline              zswap-mTHP    Chan=
ge wrt
>                                  Baseline                              Ba=
seline
>                         CONFIG_THP_SWAP=3DN       CONFIG_THP_SWAP=3DY
>  ------------------------------------------------------------------------=
------
>  ZSWAP compressor       zstd    deflate-        zstd    deflate-  zstd de=
flate-
>                                      iaa                     iaa         =
   iaa
>  ------------------------------------------------------------------------=
------
>  Throughput (KB/s)    164,220    172,523      165,005     174,536  0.5%  =
    1%
>  sys time (sec)        855.76     686.94       801.72      676.65    6%  =
    1%
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
>  ------------------------------------------------------------------------=
-----
>
> We see improvements overall in throughput and sys time for zstd and
> deflate-iaa, when comparing before (THP_SWAP=3DN) vs. after (THP_SWAP=3DY=
).
>
>
> Case 2: Baseline with CONFIG_THP_SWAP enabled.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In this scenario, the "before" represents zswap rejecting mTHP, and the m=
THP
> being stored by the backing swap device.
>
> The "after" represents data with this patch-series, that results in 64K/2=
M
> (m)THP being processed by zswap.
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

We are basically comparing zram with zswap in this case, and it's not
fair because, as you mentioned, the zswap compressed data is being
accounted for while the zram compressed data isn't. I am not really
sure how valuable these test results are. Even if we remove the cgroup
accounting from zswap, we won't see an improvement, we should expect a
similar performance to zram.

I think the test results that are really valuable are case 1, where
zswap users are currently disabling CONFIG_THP_SWAP, and get to enable
it after this series.

If we really want to compare CONFIG_THP_SWAP on before and after, it
should be with SSD because that's a more conventional setup. In this
case the users that have CONFIG_THP_SWAP=3Dy only experience the
benefits of zswap with this series. You mentioned experimenting with
usemem to keep the memory allocated longer so that you're able to have
a fair test with the small SSD swap setup. Did that work?

I am hoping Nhat or Johannes would shed some light on whether they
usually have CONFIG_THP_SWAP enabled or not with zswap. I am trying to
figure out if any reasonable setups enable CONFIG_THP_SWAP with zswap.
Otherwise the testing results from case 1 should be sufficient.

>
> In my opinion, even though the test set up does not provide an accurate
> way for a direct before/after comparison (because of zswap usage being
> counted in cgroup, hence towards the memory.high), it still seems
> reasonable for zswap_store to support (m)THP, so that further performance
> improvements can be implemented.

This is only referring to the results of case 2, right?

Honestly, I wouldn't want to merge mTHP swapout support on its own
just because it enables further performance improvements without
having actual patches for them. But I don't think this captures the
results accurately as it dismisses case 1 results (which I think are
more reasonable).

Thnaks

