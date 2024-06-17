Return-Path: <linux-kernel+bounces-216754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69A690A616
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2965B254BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D8186299;
	Mon, 17 Jun 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQnAlKij"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B881CD02
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607023; cv=none; b=euoi/qBpYshdO2imRbPLRWZoBA6V6kEu3RGhvo3St79sanM4m7kSurTCclUu9nJ4LU/lAChtSNmV1w/ltyiDPbCoUepXoOiozeH306xXHpIWAIIDuBn6FUoKiY8TPXslxVcHF24up5Cj3gL1DEz+/5WfsSfBufUCWjvedQ15wbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607023; c=relaxed/simple;
	bh=CE7z+x81nQmJ5TtpcjQf6If5Uv0G2DH5yhSx+OQ1SSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwfHthTrKdujDtdudR/w/YaC7H/P0Z5rPbWswtji3HbugpsyWuEX36DxZ+1gNeLRzKllFP9gZIvsHkUCl6j+Bq5nvG45t43xAqIq6cge+ALscMtt4LEwRSCwsny4RqI1qmfbKZHe/XZw4k0tm8JVbCgXmPrP2x0xgvmfl2uG9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQnAlKij; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718607021; x=1750143021;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=CE7z+x81nQmJ5TtpcjQf6If5Uv0G2DH5yhSx+OQ1SSo=;
  b=VQnAlKij6IbI9ubi1g0evF2aAUVYl1mILC/MKWv381G3ANzdCUznTdFn
   AQaxu78e2czirFrdqYgghLsatHqt1qepFEzs9Tm48rtdccRwn/IlQBPmo
   F8BEQma7ZLQwCSZCDylFgQoz4GhCGnY4CVrPpa8ZwkwIPYzYwaXdrIUEZ
   yAxZowfYtENZOZ6FISgymrL+bCMqoJWHblVjP5mJ3mbm0hiSoxCMYB7NR
   2rNspvFsuBtV94oEpropRZnJDuKPqeVdpUEgkDtVwyFKf/ZtNmVLMAvAk
   gL2E10vrnfOQzuW61MQ0RaNFjMz3k3rzqXlg8qxOB9Et6ET+t5HBgGMuf
   g==;
X-CSE-ConnectionGUID: jPZAvQrtT9eQuQanJ3Zq2g==
X-CSE-MsgGUID: zrzI3vkIT/aePbxGASlO1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="40835113"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40835113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:50:19 -0700
X-CSE-ConnectionGUID: RBtH8HKPT6SphxZWcE9fjw==
X-CSE-MsgGUID: kSZncDKMS4KFjzHgnKCz9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40982900"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:50:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  chrisl@kernel.org,  baohua@kernel.org,
  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  ryan.roberts@arm.com
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <20240615084714.37499-1-21cnbao@gmail.com> (Barry Song's message
	of "Sat, 15 Jun 2024 20:47:14 +1200")
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
	<20240615084714.37499-1-21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 14:48:26 +0800
Message-ID: <87bk405akl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Barry,

Barry Song <21cnbao@gmail.com> writes:

> On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
>>
>> On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:
>>
>> > > I'm having trouble understanding the overall impact of this on users.
>> > > We fail the mTHP swap allocation and fall back, but things continue =
to
>> > > operate OK?
>> >
>> > Continue to operate OK in the sense that the mTHP will have to split
>> > into 4K pages before the swap out, aka the fall back. The swap out and
>> > swap in can continue to work as 4K pages, not as the mTHP. Due to the
>> > fallback, the mTHP based zsmalloc compression with 64K buffer will not
>> > happen. That is the effect of the fallback. But mTHP swap out and swap
>> > in is relatively new, it is not really a regression.
>>
>> Sure, but it's pretty bad to merge a new feature only to have it
>> ineffective after a few hours use.
>>
>> > >
>> > > > There is some test number in the V1 thread of this series:
>> > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b2=
6@kernel.org
>> > >
>> > > Well, please let's get the latest numbers into the latest patchset.
>> > > Along with a higher-level (and quantitative) description of the user=
 impact.
>> >
>> > I will need Barray's help to collect the number. I don't have the
>> > setup to reproduce his test result.
>> > Maybe a follow up commit message amendment for the test number when I =
get it?
>
> Although the issue may seem complex at a systemic level, even a small pro=
gram can
> demonstrate the problem and highlight how Chris's patch has improved the
> situation.
>
> To demonstrate this, I designed a basic test program that maximally alloc=
ates
> two memory blocks:
>
>  *   A memory block of up to 60MB, recommended for HUGEPAGE usage
>  *   A memory block of up to 1MB, recommended for NOHUGEPAGE usage
>
> In the system configuration, I enabled 64KB mTHP and 64MB zRAM, providing=
 more than
> enough space for both the 60MB and 1MB allocations in the worst case. Thi=
s setup
> allows us to assess two effects:
>
> 1.  When we don't enable mem2 (small folios), we consistently allocate an=
d free
>     swap slots aligned with 64KB.  whether there is a risk of failure to =
obtain
>     swap slots even though the zRAM has sufficient free space?
> 2.  When we enable mem2 (small folios), the presence of small folios may =
lead
>     to fragmentation of clusters, potentially impacting the swapout proce=
ss for
>     large folios negatively.
>
> (2) can be enabled by "-s", without -s, small folios are disabled.
>
> The script to configure zRAM and mTHP:
>
> echo lzo > /sys/block/zram0/comp_algorithm
> echo 64M > /sys/block/zram0/disksize
> echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> mkswap /dev/zram0
> swapon /dev/zram0
>
> The test program I made today after receiving Chris' patchset v2
>
> (Andrew, Please let me know if you want this small test program to
> be committed into kernel/tools/ folder. If yes, please let me know,
> and I will cleanup and prepare a patch):
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <errno.h>
> #include <time.h>
>
> #define MEMSIZE_MTHP (60 * 1024 * 1024)
> #define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> #define ALIGNMENT_MTHP (64 * 1024)
> #define ALIGNMENT_SMALLFOLIO (4 * 1024)
> #define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> #define TOTAL_DONTNEED_SMALLFOLIO (256 * 1024)
> #define MTHP_FOLIO_SIZE (64 * 1024)
>
> #define SWPOUT_PATH \
>     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> #define SWPOUT_FALLBACK_PATH \
>     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fall=
back"
>
> static void *aligned_alloc_mem(size_t size, size_t alignment)
> {
>     void *mem =3D NULL;
>     if (posix_memalign(&mem, alignment, size) !=3D 0) {
>         perror("posix_memalign");
>         return NULL;
>     }
>     return mem;
> }
>
> static void random_madvise_dontneed(void *mem, size_t mem_size,
>                                      size_t align_size, size_t total_dont=
need_size)
> {
>     size_t num_pages =3D total_dontneed_size / align_size;
>     size_t i;
>     size_t offset;
>     void *addr;
>
>     for (i =3D 0; i < num_pages; ++i) {
>         offset =3D (rand() % (mem_size / align_size)) * align_size;
>         addr =3D (char *)mem + offset;
>         if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0) {
>             perror("madvise dontneed");
>         }
>         memset(addr, 0x11, align_size);
>     }
> }
>
> static unsigned long read_stat(const char *path)
> {
>     FILE *file;
>     unsigned long value;
>
>     file =3D fopen(path, "r");
>     if (!file) {
>         perror("fopen");
>         return 0;
>     }
>
>     if (fscanf(file, "%lu", &value) !=3D 1) {
>         perror("fscanf");
>         fclose(file);
>         return 0;
>     }
>
>     fclose(file);
>     return value;
> }
>
> int main(int argc, char *argv[])
> {
>     int use_small_folio =3D 0;
>     int i;
>     void *mem1 =3D aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
>     if (mem1 =3D=3D NULL) {
>         fprintf(stderr, "Failed to allocate 60MB memory\n");
>         return EXIT_FAILURE;
>     }
>
>     if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) !=3D 0) {
>         perror("madvise hugepage for mem1");
>         free(mem1);
>         return EXIT_FAILURE;
>     }
>
>     for (i =3D 1; i < argc; ++i) {
>         if (strcmp(argv[i], "-s") =3D=3D 0) {
>             use_small_folio =3D 1;
>         }
>     }
>
>     void *mem2 =3D NULL;
>     if (use_small_folio) {
>         mem2 =3D aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
>         if (mem2 =3D=3D NULL) {
>             fprintf(stderr, "Failed to allocate 1MB memory\n");
>             free(mem1);
>             return EXIT_FAILURE;
>         }
>
>         if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) !=3D 0) {
>             perror("madvise nohugepage for mem2");
>             free(mem1);
>             free(mem2);
>             return EXIT_FAILURE;
>         }
>     }
>
>     for (i =3D 0; i < 100; ++i) {
>         unsigned long initial_swpout;
>         unsigned long initial_swpout_fallback;
>         unsigned long final_swpout;
>         unsigned long final_swpout_fallback;
>         unsigned long swpout_inc;
>         unsigned long swpout_fallback_inc;
>         double fallback_percentage;
>
>         initial_swpout =3D read_stat(SWPOUT_PATH);
>         initial_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PATH);
>
>         random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
>                                  TOTAL_DONTNEED_MTHP);
>
>         if (use_small_folio) {
>             random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
>                                      ALIGNMENT_SMALLFOLIO,
>                                      TOTAL_DONTNEED_SMALLFOLIO);
>         }
>
>         if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) !=3D 0) {
>             perror("madvise pageout for mem1");
>             free(mem1);
>             if (mem2 !=3D NULL) {
>                 free(mem2);
>             }
>             return EXIT_FAILURE;
>         }
>
>         if (use_small_folio) {
>             if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) !=3D 0) {
>                 perror("madvise pageout for mem2");
>                 free(mem1);
>                 free(mem2);
>                 return EXIT_FAILURE;
>             }
>         }
>
>         final_swpout =3D read_stat(SWPOUT_PATH);
>         final_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PATH);
>
>         swpout_inc =3D final_swpout - initial_swpout;
>         swpout_fallback_inc =3D final_swpout_fallback - initial_swpout_fa=
llback;
>
>         fallback_percentage =3D (double)swpout_fallback_inc /
>                               (swpout_fallback_inc + swpout_inc) * 100;
>
>         printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, =
Fallback percentage: %.2f%%\n",
>                i + 1, swpout_inc, swpout_fallback_inc, fallback_percentag=
e);
>     }
>
>     free(mem1);
>     if (mem2 !=3D NULL) {
>         free(mem2);
>     }
>
>     return EXIT_SUCCESS;
> }

Thank you very for your effort to write this test program.

TBH, personally, I thought that this test program isn't practical
enough.  Can we show performance difference with some normal workloads?

[snip]

--
Best Regards,
Huang, Ying

