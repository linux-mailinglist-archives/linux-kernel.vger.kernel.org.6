Return-Path: <linux-kernel+bounces-218151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA990B9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7402870E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550C194C6A;
	Mon, 17 Jun 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr8LGHO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187B134C6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649304; cv=none; b=cd9F1RWvHiRpIAEaAEewJTg1/frDdzpwrnRYDB5C+ikIX6q/H00EC1x79Ox40M6hbeaJfThrwHnPaBs4gwSjnwAw+FwO3+p2W/1Ci+QpUWS3J3/rvARFY4zr9P07WGSJmSNywTsqqGCBwNNYDbn/i2jokiOsLeHBaWSb25bf+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649304; c=relaxed/simple;
	bh=fELvopcxFnF0yifS1qptosL2deTlkkYU16lWuhHnAnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5L8jaxNSHhoNMkeAokxtqgrs6fDz56iua91ZV+b84J6xOIDSK0Z3IQAoi9rpFmLHP9dtCs8v7xviKEmqUjQ+B4KFzG9lFtFquCGOMvafvw8LlHM1yOwoN7U9AxaJRQrPtJfPuhjS8r3/lQFxanffjQj2Z0etvA199W9FkowR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr8LGHO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE4FC4AF49
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718649303;
	bh=fELvopcxFnF0yifS1qptosL2deTlkkYU16lWuhHnAnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pr8LGHO8jsy4uB9LYcNXVBDEK3rxYiDB8aIudqttlD2fTg2gcgXs0kTip41Jl7d8I
	 4siivEi17n+Ei6fVZi9qAfACcUN+HjoTrTzfhuU4a5ry4oKYnLAR8nPyvzVOsiJaAN
	 +46rv29ubKOhJQC6V5VuYQjTVOBV6hEEWVU+P4XJjxEXkXGCcKYQjTPdfE7mxk0XZh
	 gEhpP28VxUVJo5Q+4KwtrCKxLnLH1CjZNMooYEUg07WlTTUNu8tBWX9Z4tFugHa2ai
	 tGpfG5yAdGmBy9ss/3AVCeRN4Fx+3hpsm2fh8/xfOZGm3OyYXSddbPTNjrx87d+AEM
	 Qj2xvDHTDulbA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375858224adso19533185ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:35:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsSCztZlh6O599tSjREVTkccLTO8uqKWxL8wr8/ms8WYYOK7/cSiSfNukLV7THLGFMG2vo7mV/vABGJT5H5zztinDnfM+sEyUnZ6lx
X-Gm-Message-State: AOJu0YyDl9PMUWmeGy6kvkngn3S7YYxuY5oCxJFKOkaw4q4QXkBN9kwh
	oScOLKiV1mRMPL8GhFmj9711eOrgvtb9/GBFEOG6nigVCdC9zTuIlkGIV0QeZW+6VDgtafZh0CB
	93isoGdBjrQsLpWFdKCdwdLDs6IzbafL+eVB8
X-Google-Smtp-Source: AGHT+IGyIYO91XMWXMr1mHG0yqPIXVRlrf/qml6BYROKyhrTsFkwRBl55bZQrzBl7P/vwuk6l2+hdPiAQUwJn06M4Zo=
X-Received: by 2002:a05:6e02:b2a:b0:375:af34:c13e with SMTP id
 e9e14a558f8ab-375e0e47e99mr120387635ab.12.1718649302473; Mon, 17 Jun 2024
 11:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org> <20240615084714.37499-1-21cnbao@gmail.com>
In-Reply-To: <20240615084714.37499-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 17 Jun 2024 11:34:50 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNAuuR489b=etm3-ZNLcvMmuQhUAP2cdG=AgKSLMoZ2wg@mail.gmail.com>
Message-ID: <CAF8kJuNAuuR489b=etm3-ZNLcvMmuQhUAP2cdG=AgKSLMoZ2wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 1:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:
> >
> > > > I'm having trouble understanding the overall impact of this on user=
s.
> > > > We fail the mTHP swap allocation and fall back, but things continue=
 to
> > > > operate OK?
> > >
> > > Continue to operate OK in the sense that the mTHP will have to split
> > > into 4K pages before the swap out, aka the fall back. The swap out an=
d
> > > swap in can continue to work as 4K pages, not as the mTHP. Due to the
> > > fallback, the mTHP based zsmalloc compression with 64K buffer will no=
t
> > > happen. That is the effect of the fallback. But mTHP swap out and swa=
p
> > > in is relatively new, it is not really a regression.
> >
> > Sure, but it's pretty bad to merge a new feature only to have it
> > ineffective after a few hours use.
> >
> > > >
> > > > > There is some test number in the V1 thread of this series:
> > > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b=
26@kernel.org
> > > >
> > > > Well, please let's get the latest numbers into the latest patchset.
> > > > Along with a higher-level (and quantitative) description of the use=
r impact.
> > >
> > > I will need Barray's help to collect the number. I don't have the
> > > setup to reproduce his test result.
> > > Maybe a follow up commit message amendment for the test number when I=
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

Thanks for the test program. I will certainly use it to stress and
debug my patches. Currently I have some tests to exercise the swap
stack, but not stress it enough.

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
>
> w/o Chris' patchset:
>
> Test A. without small folios
>
> $ /home/barry/develop/linux/mthp_swpout_test
>
> Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 221, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 189, swpout fallback inc: 42, Fallback percentag=
e: 18.18%
> Iteration 5: swpout inc: 6, swpout fallback inc: 212, Fallback percentage=
: 97.25%
> Iteration 6: swpout inc: 0, swpout fallback inc: 227, Fallback percentage=
: 100.00%
> Iteration 7: swpout inc: 0, swpout fallback inc: 224, Fallback percentage=
: 100.00%
> Iteration 8: swpout inc: 0, swpout fallback inc: 222, Fallback percentage=
: 100.00%
> Iteration 9: swpout inc: 0, swpout fallback inc: 217, Fallback percentage=
: 100.00%
> Iteration 10: swpout inc: 1, swpout fallback inc: 226, Fallback percentag=
e: 99.56%
> Iteration 11: swpout inc: 0, swpout fallback inc: 226, Fallback percentag=
e: 100.00%
> Iteration 12: swpout inc: 0, swpout fallback inc: 227, Fallback percentag=
e: 100.00%
> Iteration 13: swpout inc: 0, swpout fallback inc: 231, Fallback percentag=
e: 100.00%
> ...
>
> mthp swpout fallback ratio immediately goes up to 100%!!!
>
> Test B. with small folios
>
> $ /home/barry/develop/linux/mthp_swpout_test -s
>
> Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 229, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 229, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 20, swpout fallback inc: 206, Fallback percentag=
e: 91.15%
> Iteration 5: swpout inc: 26, swpout fallback inc: 201, Fallback percentag=
e: 88.55%
> Iteration 6: swpout inc: 2, swpout fallback inc: 216, Fallback percentage=
: 99.08%
> Iteration 7: swpout inc: 16, swpout fallback inc: 209, Fallback percentag=
e: 92.89%
> Iteration 8: swpout inc: 5, swpout fallback inc: 222, Fallback percentage=
: 97.80%
> Iteration 9: swpout inc: 0, swpout fallback inc: 226, Fallback percentage=
: 100.00%
> Iteration 10: swpout inc: 0, swpout fallback inc: 224, Fallback percentag=
e: 100.00%
> Iteration 11: swpout inc: 0, swpout fallback inc: 228, Fallback percentag=
e: 100.00%
> Iteration 12: swpout inc: 0, swpout fallback inc: 227, Fallback percentag=
e: 100.00%
> Iteration 13: swpout inc: 0, swpout fallback inc: 226, Fallback percentag=
e: 100.00%
> Iteration 14: swpout inc: 0, swpout fallback inc: 234, Fallback percentag=
e: 100.00%
> ...
>
> mthp swpout fallback ratio immediately goes up to 100%!!!
>
>
> w/ Chris' patchset:
>
> Test C. without small folios
> $ /home/barry/develop/linux/mthp_swpout_test
>
> Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 221, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 231, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 5: swpout inc: 218, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 6: swpout inc: 227, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 8: swpout inc: 222, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 10: swpout inc: 227, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 11: swpout inc: 226, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 12: swpout inc: 210, swpout fallback inc: 17, Fallback percenta=
ge: 7.49%
> Iteration 13: swpout inc: 230, swpout fallback inc: 1, Fallback percentag=
e: 0.43%
> Iteration 14: swpout inc: 209, swpout fallback inc: 13, Fallback percenta=
ge: 5.86%
> Iteration 15: swpout inc: 214, swpout fallback inc: 16, Fallback percenta=
ge: 6.96%
> Iteration 16: swpout inc: 214, swpout fallback inc: 12, Fallback percenta=
ge: 5.31%
> Iteration 17: swpout inc: 227, swpout fallback inc: 6, Fallback percentag=
e: 2.58%
> Iteration 18: swpout inc: 203, swpout fallback inc: 24, Fallback percenta=
ge: 10.57%
> Iteration 19: swpout inc: 229, swpout fallback inc: 1, Fallback percentag=
e: 0.43%
> Iteration 20: swpout inc: 224, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 21: swpout inc: 217, swpout fallback inc: 13, Fallback percenta=
ge: 5.65%
> Iteration 22: swpout inc: 205, swpout fallback inc: 17, Fallback percenta=
ge: 7.66%
> Iteration 23: swpout inc: 213, swpout fallback inc: 15, Fallback percenta=
ge: 6.58%
> Iteration 24: swpout inc: 234, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 25: swpout inc: 205, swpout fallback inc: 18, Fallback percenta=
ge: 8.07%
> Iteration 26: swpout inc: 217, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 27: swpout inc: 219, swpout fallback inc: 6, Fallback percentag=
e: 2.67%
> Iteration 28: swpout inc: 215, swpout fallback inc: 14, Fallback percenta=
ge: 6.11%
> Iteration 29: swpout inc: 227, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 30: swpout inc: 208, swpout fallback inc: 13, Fallback percenta=
ge: 5.88%
> Iteration 31: swpout inc: 219, swpout fallback inc: 6, Fallback percentag=
e: 2.67%
> Iteration 32: swpout inc: 216, swpout fallback inc: 7, Fallback percentag=
e: 3.14%
> Iteration 33: swpout inc: 201, swpout fallback inc: 28, Fallback percenta=
ge: 12.23%
> Iteration 34: swpout inc: 232, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 35: swpout inc: 215, swpout fallback inc: 17, Fallback percenta=
ge: 7.33%
> Iteration 36: swpout inc: 209, swpout fallback inc: 16, Fallback percenta=
ge: 7.11%
> Iteration 37: swpout inc: 202, swpout fallback inc: 29, Fallback percenta=
ge: 12.55%
> Iteration 38: swpout inc: 200, swpout fallback inc: 18, Fallback percenta=
ge: 8.26%
> Iteration 39: swpout inc: 219, swpout fallback inc: 12, Fallback percenta=
ge: 5.19%
> Iteration 40: swpout inc: 218, swpout fallback inc: 9, Fallback percentag=
e: 3.96%
> Iteration 41: swpout inc: 212, swpout fallback inc: 14, Fallback percenta=
ge: 6.19%
> Iteration 42: swpout inc: 204, swpout fallback inc: 15, Fallback percenta=
ge: 6.85%
> Iteration 43: swpout inc: 222, swpout fallback inc: 5, Fallback percentag=
e: 2.20%
> Iteration 44: swpout inc: 205, swpout fallback inc: 20, Fallback percenta=
ge: 8.89%
> Iteration 45: swpout inc: 217, swpout fallback inc: 6, Fallback percentag=
e: 2.69%
> Iteration 46: swpout inc: 209, swpout fallback inc: 19, Fallback percenta=
ge: 8.33%
> Iteration 47: swpout inc: 205, swpout fallback inc: 13, Fallback percenta=
ge: 5.96%
> Iteration 48: swpout inc: 223, swpout fallback inc: 4, Fallback percentag=
e: 1.76%
> Iteration 49: swpout inc: 203, swpout fallback inc: 21, Fallback percenta=
ge: 9.38%
> Iteration 50: swpout inc: 193, swpout fallback inc: 19, Fallback percenta=
ge: 8.96%
> Iteration 51: swpout inc: 197, swpout fallback inc: 29, Fallback percenta=
ge: 12.83%
> Iteration 52: swpout inc: 195, swpout fallback inc: 29, Fallback percenta=
ge: 12.95%
> Iteration 53: swpout inc: 217, swpout fallback inc: 17, Fallback percenta=
ge: 7.26%
> Iteration 54: swpout inc: 207, swpout fallback inc: 11, Fallback percenta=
ge: 5.05%
> Iteration 55: swpout inc: 213, swpout fallback inc: 10, Fallback percenta=
ge: 4.48%
> Iteration 56: swpout inc: 203, swpout fallback inc: 23, Fallback percenta=
ge: 10.18%
> Iteration 57: swpout inc: 197, swpout fallback inc: 34, Fallback percenta=
ge: 14.72%
> Iteration 58: swpout inc: 209, swpout fallback inc: 13, Fallback percenta=
ge: 5.86%
> Iteration 59: swpout inc: 212, swpout fallback inc: 19, Fallback percenta=
ge: 8.23%
> Iteration 60: swpout inc: 196, swpout fallback inc: 24, Fallback percenta=
ge: 10.91%
> Iteration 61: swpout inc: 203, swpout fallback inc: 13, Fallback percenta=
ge: 6.02%
> Iteration 62: swpout inc: 221, swpout fallback inc: 7, Fallback percentag=
e: 3.07%
> Iteration 63: swpout inc: 207, swpout fallback inc: 17, Fallback percenta=
ge: 7.59%
> Iteration 64: swpout inc: 205, swpout fallback inc: 15, Fallback percenta=
ge: 6.82%
> Iteration 65: swpout inc: 223, swpout fallback inc: 3, Fallback percentag=
e: 1.33%
> Iteration 66: swpout inc: 215, swpout fallback inc: 13, Fallback percenta=
ge: 5.70%
> Iteration 67: swpout inc: 225, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 68: swpout inc: 215, swpout fallback inc: 8, Fallback percentag=
e: 3.59%
> Iteration 69: swpout inc: 222, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 70: swpout inc: 204, swpout fallback inc: 17, Fallback percenta=
ge: 7.69%
> Iteration 71: swpout inc: 227, swpout fallback inc: 6, Fallback percentag=
e: 2.58%
> Iteration 72: swpout inc: 207, swpout fallback inc: 16, Fallback percenta=
ge: 7.17%
> Iteration 73: swpout inc: 217, swpout fallback inc: 9, Fallback percentag=
e: 3.98%
> Iteration 74: swpout inc: 206, swpout fallback inc: 9, Fallback percentag=
e: 4.19%
> Iteration 75: swpout inc: 193, swpout fallback inc: 26, Fallback percenta=
ge: 11.87%
> Iteration 76: swpout inc: 225, swpout fallback inc: 3, Fallback percentag=
e: 1.32%
> Iteration 77: swpout inc: 205, swpout fallback inc: 25, Fallback percenta=
ge: 10.87%
> Iteration 78: swpout inc: 213, swpout fallback inc: 12, Fallback percenta=
ge: 5.33%
> Iteration 79: swpout inc: 212, swpout fallback inc: 10, Fallback percenta=
ge: 4.50%
> Iteration 80: swpout inc: 210, swpout fallback inc: 9, Fallback percentag=
e: 4.11%
> Iteration 81: swpout inc: 225, swpout fallback inc: 4, Fallback percentag=
e: 1.75%
> Iteration 82: swpout inc: 211, swpout fallback inc: 3, Fallback percentag=
e: 1.40%
> Iteration 83: swpout inc: 216, swpout fallback inc: 10, Fallback percenta=
ge: 4.42%
> Iteration 84: swpout inc: 226, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 85: swpout inc: 213, swpout fallback inc: 13, Fallback percenta=
ge: 5.75%
> Iteration 86: swpout inc: 225, swpout fallback inc: 3, Fallback percentag=
e: 1.32%
> Iteration 87: swpout inc: 204, swpout fallback inc: 22, Fallback percenta=
ge: 9.73%
> Iteration 88: swpout inc: 225, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 89: swpout inc: 225, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 90: swpout inc: 221, swpout fallback inc: 8, Fallback percentag=
e: 3.49%
> Iteration 91: swpout inc: 212, swpout fallback inc: 13, Fallback percenta=
ge: 5.78%
> Iteration 92: swpout inc: 207, swpout fallback inc: 18, Fallback percenta=
ge: 8.00%
> Iteration 93: swpout inc: 209, swpout fallback inc: 25, Fallback percenta=
ge: 10.68%
> Iteration 94: swpout inc: 213, swpout fallback inc: 13, Fallback percenta=
ge: 5.75%
> Iteration 95: swpout inc: 206, swpout fallback inc: 18, Fallback percenta=
ge: 8.04%
> Iteration 96: swpout inc: 206, swpout fallback inc: 17, Fallback percenta=
ge: 7.62%
> Iteration 97: swpout inc: 216, swpout fallback inc: 11, Fallback percenta=
ge: 4.85%
> Iteration 98: swpout inc: 210, swpout fallback inc: 13, Fallback percenta=
ge: 5.83%
> Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 100: swpout inc: 205, swpout fallback inc: 21, Fallback percent=
age: 9.29%
> ...
>
> mthp swpout fallback ratio is stable and low in 100 iterations!!!
> Though the number is very good, I wonder why it is not 0% since 64MB is l=
arger
> than 60MB? Chris, do you have any idea?
>
> Test D. with small folios
> $ /home/barry/develop/linux/mthp_swpout_test -s
>
> [ 1013.535798] ------------[ cut here ]------------
> [ 1013.538886] expecting order 4 got 0

This warning means there is a bug in this series somewhere I need to hunt d=
own.
The V1 has the same warning but I haven't heard it get triggered in
V1, it is something new in V2.

Andrew, please consider removing the series from mm-unstable until I
resolve this warning assert.


> [ 1013.540622] WARNING: CPU: 3 PID: 104 at mm/swapfile.c:600 scan_swap_ma=
p_try_ssd_cluster+0x340/0x370
> [ 1013.544460] Modules linked in:
> [ 1013.545411] CPU: 3 PID: 104 Comm: mthp_swpout_tes Not tainted 6.10.0-r=
c3-ga12328d9fb85-dirty #285
> [ 1013.545990] Hardware name: linux,dummy-virt (DT)
> [ 1013.546585] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [ 1013.547136] pc : scan_swap_map_try_ssd_cluster+0x340/0x370
> [ 1013.547768] lr : scan_swap_map_try_ssd_cluster+0x340/0x370
> [ 1013.548263] sp : ffff8000863e32e0
> [ 1013.548723] x29: ffff8000863e32e0 x28: 0000000000000670 x27: 000000000=
0000660
> [ 1013.549626] x26: 0000000000000010 x25: ffff0000c1692108 x24: ffff0000c=
27c4800
> [ 1013.550470] x23: 2e8ba2e8ba2e8ba3 x22: fffffdffbf7df2c0 x21: ffff0000c=
27c48b0
> [ 1013.551285] x20: ffff800083a946d0 x19: 0000000000000004 x18: fffffffff=
fffffff
> [ 1013.552263] x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008=
4b13568
> [ 1013.553292] x14: ffffffffffffffff x13: ffff800084b13566 x12: 6e6974636=
5707865
> [ 1013.554423] x11: fffffffffffe0000 x10: ffff800083b18b68 x9 : ffff80008=
014c874
> [ 1013.555231] x8 : 00000000ffffefff x7 : ffff800083b16318 x6 : 000000000=
0002850
> [ 1013.555965] x5 : 40000000fffff1ae x4 : 0000000000000fff x3 : 000000000=
0000000
> [ 1013.556779] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c=
24a1bc0
> [ 1013.557627] Call trace:
> [ 1013.557960]  scan_swap_map_try_ssd_cluster+0x340/0x370
> [ 1013.558498]  get_swap_pages+0x23c/0xc20
> [ 1013.558899]  folio_alloc_swap+0x5c/0x248
> [ 1013.559544]  add_to_swap+0x40/0xf0
> [ 1013.559904]  shrink_folio_list+0x6dc/0xf20
> [ 1013.560289]  reclaim_folio_list+0x8c/0x168
> [ 1013.560710]  reclaim_pages+0xfc/0x178
> [ 1013.561079]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
> [ 1013.561524]  walk_pgd_range+0x390/0x808
> [ 1013.561920]  __walk_page_range+0x1e0/0x1f0
> [ 1013.562370]  walk_page_range+0x1f0/0x2c8
> [ 1013.562888]  madvise_pageout+0xf8/0x280
> [ 1013.563388]  madvise_vma_behavior+0x314/0xa20
> [ 1013.563982]  madvise_walk_vmas+0xc0/0x128
> [ 1013.564386]  do_madvise.part.0+0x110/0x558
> [ 1013.564792]  __arm64_sys_madvise+0x68/0x88
> [ 1013.565333]  invoke_syscall+0x50/0x128
> [ 1013.565737]  el0_svc_common.constprop.0+0x48/0xf8
> [ 1013.566285]  do_el0_svc+0x28/0x40
> [ 1013.566667]  el0_svc+0x50/0x150
> [ 1013.567094]  el0t_64_sync_handler+0x13c/0x158
> [ 1013.567501]  el0t_64_sync+0x1a4/0x1a8
> [ 1013.568058] irq event stamp: 0
> [ 1013.568661] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 1013.569560] hardirqs last disabled at (0): [<ffff8000800add44>] copy_p=
rocess+0x654/0x19a8
> [ 1013.570167] softirqs last  enabled at (0): [<ffff8000800add44>] copy_p=
rocess+0x654/0x19a8
> [ 1013.570846] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 1013.571330] ---[ end trace 0000000000000000 ]---
> Iteration 1: swpout inc: 226, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 229, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 229, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 226, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 6: swpout inc: 218, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 7: swpout inc: 225, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 8: swpout inc: 227, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 9: swpout inc: 224, swpout fallback inc: 2, Fallback percentage=
: 0.88%
> Iteration 10: swpout inc: 213, swpout fallback inc: 11, Fallback percenta=
ge: 4.91%
> Iteration 11: swpout inc: 219, swpout fallback inc: 9, Fallback percentag=
e: 3.95%
> Iteration 12: swpout inc: 207, swpout fallback inc: 20, Fallback percenta=
ge: 8.81%
> Iteration 13: swpout inc: 193, swpout fallback inc: 33, Fallback percenta=
ge: 14.60%
> Iteration 14: swpout inc: 215, swpout fallback inc: 19, Fallback percenta=
ge: 8.12%
> Iteration 15: swpout inc: 217, swpout fallback inc: 12, Fallback percenta=
ge: 5.24%
> Iteration 16: swpout inc: 207, swpout fallback inc: 15, Fallback percenta=
ge: 6.76%
> Iteration 17: swpout inc: 207, swpout fallback inc: 23, Fallback percenta=
ge: 10.00%
> Iteration 18: swpout inc: 198, swpout fallback inc: 30, Fallback percenta=
ge: 13.16%
> Iteration 19: swpout inc: 199, swpout fallback inc: 26, Fallback percenta=
ge: 11.56%
> Iteration 20: swpout inc: 197, swpout fallback inc: 27, Fallback percenta=
ge: 12.05%
> Iteration 21: swpout inc: 192, swpout fallback inc: 25, Fallback percenta=
ge: 11.52%
> Iteration 22: swpout inc: 190, swpout fallback inc: 30, Fallback percenta=
ge: 13.64%
> Iteration 23: swpout inc: 203, swpout fallback inc: 27, Fallback percenta=
ge: 11.74%
> Iteration 24: swpout inc: 197, swpout fallback inc: 32, Fallback percenta=
ge: 13.97%
> Iteration 25: swpout inc: 184, swpout fallback inc: 41, Fallback percenta=
ge: 18.22%
> Iteration 26: swpout inc: 203, swpout fallback inc: 28, Fallback percenta=
ge: 12.12%
> Iteration 27: swpout inc: 193, swpout fallback inc: 31, Fallback percenta=
ge: 13.84%
> Iteration 28: swpout inc: 191, swpout fallback inc: 43, Fallback percenta=
ge: 18.38%
> Iteration 29: swpout inc: 194, swpout fallback inc: 31, Fallback percenta=
ge: 13.78%
> Iteration 30: swpout inc: 180, swpout fallback inc: 50, Fallback percenta=
ge: 21.74%
> Iteration 31: swpout inc: 205, swpout fallback inc: 22, Fallback percenta=
ge: 9.69%
> Iteration 32: swpout inc: 199, swpout fallback inc: 24, Fallback percenta=
ge: 10.76%
> Iteration 33: swpout inc: 192, swpout fallback inc: 34, Fallback percenta=
ge: 15.04%
> Iteration 34: swpout inc: 186, swpout fallback inc: 38, Fallback percenta=
ge: 16.96%
> Iteration 35: swpout inc: 190, swpout fallback inc: 32, Fallback percenta=
ge: 14.41%
> Iteration 36: swpout inc: 181, swpout fallback inc: 41, Fallback percenta=
ge: 18.47%
> Iteration 37: swpout inc: 181, swpout fallback inc: 47, Fallback percenta=
ge: 20.61%
> Iteration 38: swpout inc: 173, swpout fallback inc: 45, Fallback percenta=
ge: 20.64%
> Iteration 39: swpout inc: 196, swpout fallback inc: 27, Fallback percenta=
ge: 12.11%
> Iteration 40: swpout inc: 195, swpout fallback inc: 27, Fallback percenta=
ge: 12.16%
> Iteration 41: swpout inc: 195, swpout fallback inc: 31, Fallback percenta=
ge: 13.72%
> Iteration 42: swpout inc: 189, swpout fallback inc: 34, Fallback percenta=
ge: 15.25%
> Iteration 43: swpout inc: 185, swpout fallback inc: 41, Fallback percenta=
ge: 18.14%
> Iteration 44: swpout inc: 189, swpout fallback inc: 34, Fallback percenta=
ge: 15.25%
> Iteration 45: swpout inc: 177, swpout fallback inc: 49, Fallback percenta=
ge: 21.68%
> Iteration 46: swpout inc: 193, swpout fallback inc: 36, Fallback percenta=
ge: 15.72%
> Iteration 47: swpout inc: 197, swpout fallback inc: 30, Fallback percenta=
ge: 13.22%
> Iteration 48: swpout inc: 188, swpout fallback inc: 24, Fallback percenta=
ge: 11.32%
> Iteration 49: swpout inc: 187, swpout fallback inc: 29, Fallback percenta=
ge: 13.43%
> Iteration 50: swpout inc: 181, swpout fallback inc: 48, Fallback percenta=
ge: 20.96%
> Iteration 51: swpout inc: 191, swpout fallback inc: 28, Fallback percenta=
ge: 12.79%
> Iteration 52: swpout inc: 184, swpout fallback inc: 43, Fallback percenta=
ge: 18.94%
> Iteration 53: swpout inc: 184, swpout fallback inc: 44, Fallback percenta=
ge: 19.30%
> Iteration 54: swpout inc: 173, swpout fallback inc: 49, Fallback percenta=
ge: 22.07%
> Iteration 55: swpout inc: 170, swpout fallback inc: 47, Fallback percenta=
ge: 21.66%
> Iteration 56: swpout inc: 185, swpout fallback inc: 43, Fallback percenta=
ge: 18.86%
> Iteration 57: swpout inc: 178, swpout fallback inc: 55, Fallback percenta=
ge: 23.61%
> Iteration 58: swpout inc: 178, swpout fallback inc: 50, Fallback percenta=
ge: 21.93%
> Iteration 59: swpout inc: 181, swpout fallback inc: 45, Fallback percenta=
ge: 19.91%
> Iteration 60: swpout inc: 180, swpout fallback inc: 45, Fallback percenta=
ge: 20.00%
> Iteration 61: swpout inc: 172, swpout fallback inc: 56, Fallback percenta=
ge: 24.56%
> Iteration 62: swpout inc: 184, swpout fallback inc: 44, Fallback percenta=
ge: 19.30%
> Iteration 63: swpout inc: 174, swpout fallback inc: 42, Fallback percenta=
ge: 19.44%
> Iteration 64: swpout inc: 166, swpout fallback inc: 51, Fallback percenta=
ge: 23.50%
> Iteration 65: swpout inc: 172, swpout fallback inc: 57, Fallback percenta=
ge: 24.89%
> Iteration 66: swpout inc: 180, swpout fallback inc: 40, Fallback percenta=
ge: 18.18%
> Iteration 67: swpout inc: 173, swpout fallback inc: 63, Fallback percenta=
ge: 26.69%
> Iteration 68: swpout inc: 186, swpout fallback inc: 43, Fallback percenta=
ge: 18.78%
> Iteration 69: swpout inc: 175, swpout fallback inc: 53, Fallback percenta=
ge: 23.25%
> Iteration 70: swpout inc: 170, swpout fallback inc: 54, Fallback percenta=
ge: 24.11%
> Iteration 71: swpout inc: 166, swpout fallback inc: 62, Fallback percenta=
ge: 27.19%
> Iteration 72: swpout inc: 169, swpout fallback inc: 54, Fallback percenta=
ge: 24.22%
> Iteration 73: swpout inc: 175, swpout fallback inc: 50, Fallback percenta=
ge: 22.22%
> Iteration 74: swpout inc: 160, swpout fallback inc: 60, Fallback percenta=
ge: 27.27%
> Iteration 75: swpout inc: 173, swpout fallback inc: 45, Fallback percenta=
ge: 20.64%
> Iteration 76: swpout inc: 172, swpout fallback inc: 61, Fallback percenta=
ge: 26.18%
> Iteration 77: swpout inc: 173, swpout fallback inc: 50, Fallback percenta=
ge: 22.42%
> Iteration 78: swpout inc: 160, swpout fallback inc: 65, Fallback percenta=
ge: 28.89%
> Iteration 79: swpout inc: 165, swpout fallback inc: 61, Fallback percenta=
ge: 26.99%
> Iteration 80: swpout inc: 183, swpout fallback inc: 43, Fallback percenta=
ge: 19.03%
> Iteration 81: swpout inc: 206, swpout fallback inc: 22, Fallback percenta=
ge: 9.65%
> Iteration 82: swpout inc: 176, swpout fallback inc: 49, Fallback percenta=
ge: 21.78%
> Iteration 83: swpout inc: 184, swpout fallback inc: 45, Fallback percenta=
ge: 19.65%
> Iteration 84: swpout inc: 181, swpout fallback inc: 45, Fallback percenta=
ge: 19.91%
> Iteration 85: swpout inc: 175, swpout fallback inc: 56, Fallback percenta=
ge: 24.24%
> Iteration 86: swpout inc: 157, swpout fallback inc: 59, Fallback percenta=
ge: 27.31%
> Iteration 87: swpout inc: 171, swpout fallback inc: 54, Fallback percenta=
ge: 24.00%
> Iteration 88: swpout inc: 189, swpout fallback inc: 34, Fallback percenta=
ge: 15.25%
> Iteration 89: swpout inc: 185, swpout fallback inc: 45, Fallback percenta=
ge: 19.57%
> Iteration 90: swpout inc: 173, swpout fallback inc: 49, Fallback percenta=
ge: 22.07%
> Iteration 91: swpout inc: 170, swpout fallback inc: 58, Fallback percenta=
ge: 25.44%
> Iteration 92: swpout inc: 184, swpout fallback inc: 44, Fallback percenta=
ge: 19.30%
> Iteration 93: swpout inc: 193, swpout fallback inc: 37, Fallback percenta=
ge: 16.09%
> Iteration 94: swpout inc: 181, swpout fallback inc: 38, Fallback percenta=
ge: 17.35%
> Iteration 95: swpout inc: 205, swpout fallback inc: 25, Fallback percenta=
ge: 10.87%
> Iteration 96: swpout inc: 164, swpout fallback inc: 49, Fallback percenta=
ge: 23.00%
> Iteration 97: swpout inc: 158, swpout fallback inc: 65, Fallback percenta=
ge: 29.15%
> Iteration 98: swpout inc: 168, swpout fallback inc: 57, Fallback percenta=
ge: 25.33%
> Iteration 99: swpout inc: 163, swpout fallback inc: 56, Fallback percenta=
ge: 25.57%
> Iteration 100: swpout inc: 180, swpout fallback inc: 44, Fallback percent=
age: 19.64%
>
> It is getting worse than test C but still way better than test
> A and B.
>
> I previously observed a 100% fallback ratio in test v1 on an actual phone=
, especially
> when order-0 and mthp were combined within one zRAM. This likely triggere=
d a scenario
> where order-0 had to scan swap to locate free slots, resulting in fragmen=
tation
> across all clusters.
>
> Not quite sure if this still happens in v2. Will arrange a phone test nex=
t week. If
> yes, I am still eager to see some approach to prevent order-0 from spread=
ing across
> all clusters.
>
> BTW, Chris,
>
> Is the warning "expecting order 4 got 0" normal in the above test?

Not normal. That means there is a bug some where I introduced in V2.

Chris

>
> >
> > Yep, I alter changelogs all the time.
> >
> > > >
> > > > I'll add this into mm-unstable now for some exposure, but at this p=
oint
> > > > I'm not able to determine whether it should go in as a hotfix for
> > > > 6.10-rcX.
> > >
> > > Maybe not need to be a hotfix. Not all Barry's mTHP swap out and swap
> > > in patch got merged yet.
>
> This could be a hotfix, considering swapping out a mTHP is slower than
> swapping nr_pages small folios with the overhead of splitting folio
> if we have to fallback. Ryan had the regression data before[1]
>
> "
> | alloc size |                baseline |           + this series |
> |            | mm-unstable (~v6.9-rc1) |                         |
> |:-----------|------------------------:|------------------------:|
> | 4K Page    |                    0.0% |                    1.3% |
> | 64K THP    |                  -13.6% |                   46.3% |
> | 2M THP     |                   91.4% |                   89.6% |
>
> So with this change, the 64K swap performance goes from a 14% regression =
to a
> 46% improvement. While 2M shows a small regression I'm confident that thi=
s is
> just noise."
>
> Ryan reported a 14% regression if mthp can not be swapped out as a whole
> comparing to only using small folios.
>
> [1] https://lore.kernel.org/all/20240408183946.2991168-1-ryan.roberts@arm=
.com/
>
> >
> > OK, well please let's give appropriate consideration to what we should
> > add to 6.10-rcX in order to have this feature working well.
>
> Thanks
> Barry
>
>

