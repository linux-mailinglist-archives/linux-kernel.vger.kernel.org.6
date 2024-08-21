Return-Path: <linux-kernel+bounces-295698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DB95A031
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B71C2254B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A619995B;
	Wed, 21 Aug 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTlKjLfP"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B60160796
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251392; cv=none; b=mlXvGODkoy4+PRcH4t1zyG8wYxrJgIInh4MC3Oekp4ex9LNwuXQJd7tM86S4uuicwVfSfv5grOfIljdIyVzzCYW2/pUAdp+Pz3hiMcd3vHcd16qivwNLbSg/IZxw9vtjvlGan/7+ru65SpZdHhg6HYhBOJhZVqN9A4vquSfAehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251392; c=relaxed/simple;
	bh=SmW4T5gIGEqQpUN8h/IywqyKznb0R9hv3kztb56kgqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWae+Y1pU5hnMizUj+Rn7pYX1iQKtG8bCxkacOZuZeSCgyraTHN2UiH1woSU0lBuPvV9ak00WABG4DeP6EO19EYVjLt1wSyIMZiDB/446OvfzTqS7DVpAO73Fa+C/FEbv1BW7hxAPI3UXwJQDkaWor/MsRH3KV9ZpidXI+6XmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTlKjLfP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d42da3e9so438187385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724251389; x=1724856189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hTkgzcR3AnSxa314EMmlKAfjbthoWMYj15N6KUnLXU=;
        b=kTlKjLfPzjX+L8jL/QbRyp1TaFML6Dm7efLwo2QdRjVp4YN99otWUFwrwru+eVrXv9
         L3C7GvvlN47M89q7cdpX6DnR7Knqw2P9fx/c+hoNx2IB3mx835s8DMXU7IXs6xWzyoxD
         cYEATVpxQFDBAj6IZ8pfukGcwQAZllrvai2iWl1vzzDZi2jpKS3MX89geKJqWsv2Y/e3
         A4XRDOjti1R2LKE5ntVcvjzJkM/n5ofZlHrs5opZo0lpnyx9bFGCtXHAw/xXOPntkb+E
         bTvG0aLE/Mq9BWpYcRsSyB01JesVbVcQ8wuOdAw+x6k/n3McAAztRzQyAV/ZBnwxTG80
         6Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251389; x=1724856189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hTkgzcR3AnSxa314EMmlKAfjbthoWMYj15N6KUnLXU=;
        b=wM0EpyHw2BsV+8oGgyc3cN9PDSsMfITrBLSvZJ3Iqn6w3ZmPSb35q+p8QEe34Rydpj
         c3qY09OcoyyYUJ2FgsA/IDjiNwEr+OeODk6eyf+XuV8JGjTprB+6IONngo4kxWcPTc4m
         Me/R8Hbhrjz667CgzQwy+ngmopZF7Ql+oU9F3YuBmXy1CY8q6g2XdfuLqmGwXNXBwdbI
         8rBNVap+NPR0d86+LCG4sEAVkenzNxAx0ePM2mlV0HU3dVjcpPPpukehWSlzt7wS08Vh
         G2H5civw4YQ7/f0oe7MxZbnfXksjnFbK6iKAFO3s4IZ4vI3DJ6TyEg/kCnRruqmufYoQ
         l2ZQ==
X-Gm-Message-State: AOJu0YxGIaE/5pr2maGcH7vCvJgGR/zUPR9uH4v+fuKpbnRo9efmG71B
	aCxRVXNBZEWiOkAlL1lqU9xr440ZEmURpIW59SzGgKhxSugk6DBEOwlOFriWSG6W/0USezhKTbV
	GDIn7akSOtu3bPZOWFQU16CuFxNs=
X-Google-Smtp-Source: AGHT+IFb4eaLx4KxBuCDTnWqFPKFmaBCDDtJS88BDxxBHN7+mARkycK57RU2F+b2XSz8kDdnMm9pCDcFZiASEe5Q3XA=
X-Received: by 2002:a05:6214:578a:b0:6bf:7fc1:64c7 with SMTP id
 6a1803df08f44-6c155d71e5bmr33636526d6.15.1724251388880; Wed, 21 Aug 2024
 07:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 21 Aug 2024 10:42:57 -0400
Message-ID: <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 10:16=E2=80=AFPM Kanchana P Sridhar
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
> mTHPs.
>
> For instance, the determination of whether a folio is same-filled is
> based on mapping an index into the folio to derive the page. Likewise,
> there is a function "zswap_store_entry" added to store a zswap_entry in
> the xarray.
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
> The system has 503 GiB RAM, with a 4G SSD as the backing swap device for
> ZSWAP. Core frequency was fixed at 2500MHz.
>
> The vm-scalability "usemem" test was run in a cgroup whose memory.high
> was fixed. Following a similar methodology as in Ryan Roberts'
> "Swap-out mTHP without splitting" series [2], 70 usemem processes were
> run, each allocating and writing 1G of memory:
>
>     usemem --init-time -w -O -n 70 1g
>
> Since I was constrained to get the 70 usemem processes to generate
> swapout activity with the 4G SSD, I ended up using different cgroup
> memory.high fixed limits for the experiments with 64K mTHP and 2M THP:
>
> 64K mTHP experiments: cgroup memory fixed at 60G
> 2M THP experiments  : cgroup memory fixed at 55G
>
> The vm/sysfs stats included after the performance data provide details
> on the swapout activity to SSD/ZSWAP.
>
> Other kernel configuration parameters:
>
>     ZSWAP Compressor  : LZ4, DEFLATE-IAA
>     ZSWAP Allocator   : ZSMALLOC
>     SWAP page-cluster : 2
>
> In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
> IAA "compression verification" is enabled. Hence each IAA compression
> will be decompressed internally by the "iaa_crypto" driver, the crc-s
> returned by the hardware will be compared and errors reported in case of
> mismatches. Thus "deflate-iaa" helps ensure better data integrity as
> compared to the software compressors.
>
> Throughput reported by usemem and perf sys time for running the test
> are as follows, averaged across 3 runs:
>
>  64KB mTHP (cgroup memory.high set to 60G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ------------------------------------------------------------------
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
>  |                    |                   |       KB/s |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |
>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    388,154 |        16% |
>  |------------------------------------------------------------------|
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
>  |                    |                   |        sec |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
>  |zswap-mTHP=3DStore    | ZSWAP lz4         |     265.43 |      -191% |
>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     235.60 |      -158% |
>   ------------------------------------------------------------------

Yeah no, this is not good. That throughput regression is concerning...

Is this tied to lz4 only, or do you observe similar trends in other
compressors that are not deflate-iaa?


>
>   -----------------------------------------------------------------------
>  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP =
|
>  |                              |   mainline |       Store |       Store =
|
>  |                              |            |         lz4 | deflate-iaa =
|
>  |-----------------------------------------------------------------------=
|
>  | pswpin                       |          0 |           0 |           0 =
|
>  | pswpout                      |    174,432 |           0 |           0 =
|
>  | zswpin                       |        703 |         534 |         721 =
|
>  | zswpout                      |      1,501 |   1,491,654 |   1,398,805 =
|
>  |-----------------------------------------------------------------------=
|
>  | thp_swpout                   |          0 |           0 |           0 =
|
>  | thp_swpout_fallback          |          0 |           0 |           0 =
|
>  | pgmajfault                   |      3,364 |       3,650 |       3,431 =
|
>  |-----------------------------------------------------------------------=
|
>  | hugepages-64kB/stats/zswpout |            |      63,200 |      63,244 =
|
>  |-----------------------------------------------------------------------=
|
>  | hugepages-64kB/stats/swpout  |     10,902 |           0 |           0 =
|
>   -----------------------------------------------------------------------
>

Yeah this is not good. Something fishy is going on, if we see this
ginormous jump from 175000 (z)swpout pages to almost 1.5 million
pages. That's a massive jump.

Either it's:

1.Your theory - zswap store keeps banging on the limit (which suggests
incompatibility between the way zswap currently behaves and our
reclaim logic)

2. The data here is ridiculously incompressible. We're needing to
zswpout roughly 8.5 times the number of pages, so the saving is 8.5
less =3D> we only save 11.76% of memory for each page??? That's not
right...

3. There's an outright bug somewhere.

Very suspicious.

>
>  2MB PMD-THP/2048K mTHP (cgroup memory.high set to 55G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>   ------------------------------------------------------------------
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
>  |                    |                   |       KB/s |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |    190,827 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |     32,026 |       -83% |
>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    203,772 |         7% |
>  |------------------------------------------------------------------|
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
>  |                    |                   |        sec |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |      27.23 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |     156.52 |      -475% |
>  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     171.45 |      -530% |
>   ------------------------------------------------------------------

I'm confused. This is a *regression* right? A massive one that is -
sys time is *more* than 5 times the old value?

>
>   -----------------------------------------------------------------------=
--
>  | VMSTATS, mTHP ZSWAP/SSD stats  |  v6.11-rc3 |  zswap-mTHP |  zswap-mTH=
P |
>  |                                |   mainline |       Store |       Stor=
e |
>  |                                |            |         lz4 | deflate-ia=
a |
>  |-----------------------------------------------------------------------=
--|
>  | pswpin                         |          0 |           0 |           =
0 |
>  | pswpout                        |    797,184 |           0 |           =
0 |
>  | zswpin                         |        690 |         649 |         66=
9 |
>  | zswpout                        |      1,465 |   1,596,382 |   1,540,76=
6 |
>  |-----------------------------------------------------------------------=
--|
>  | thp_swpout                     |      1,557 |           0 |           =
0 |
>  | thp_swpout_fallback            |          0 |       3,248 |       3,75=
2 |

This is also increased, but I supposed we're just doing more
(z)swapping out in general...

>  | pgmajfault                     |      3,726 |       6,470 |       5,69=
1 |
>  |-----------------------------------------------------------------------=
--|
>  | hugepages-2048kB/stats/zswpout |            |       2,416 |       2,26=
1 |
>  |-----------------------------------------------------------------------=
--|
>  | hugepages-2048kB/stats/swpout  |      1,557 |           0 |           =
0 |
>   -----------------------------------------------------------------------=
--
>

I'm not trying to delay this patch - I fully believe in supporting
zswap for larger pages (both mTHP and THP - whatever the memory
reclaim subsystem throws at us).

But we need to get to the bottom of this :) These are very suspicious
and concerning data. If this is something urgent, I can live with a
gate to enable/disable this, but I'd much prefer we understand what's
going on here.

