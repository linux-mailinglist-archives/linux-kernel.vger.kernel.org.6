Return-Path: <linux-kernel+bounces-216791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175990A680
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC79287E58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19318C321;
	Mon, 17 Jun 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9G2XRtd"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1679D3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608122; cv=none; b=It3xO+6bXwI9LaGHIY4I3ngTH+sW/M9gLJgY9O9hztlC0GzQrZlo6HVpQBqGJdqKpYDhv2CGGjvv/IVCh8iMYCSTKVfaU1at4lg1iJlc5fIrVXie08MKRdmokS6aXLfVpnrIcnwkFAWNPb7+yZ7JEz6clG00df2fEK9eLOyEROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608122; c=relaxed/simple;
	bh=UxifHNXdF0WIrVcC/oY+IkV/M1T/Ksju/KCKMba4XDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKdcrnDOQBVupsRbjtdcBtEv4+EFV6rhhSxDbWYGstw3/dEHW+VuQBoNZKXcOZEhMJOmYoDm+KQ21Ss5TuapmIkbwcFUEpL2gduGWtoUISRpAXCj6l1XiMSpt3r+FvhEVwuDqMERryj+xgkl0z/c8nifhvWRWPtQfaUa39hGaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9G2XRtd; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48c5133a2adso1292686137.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718608119; x=1719212919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTSUxbZ58gO2uuyvGy7K8h6s7XmT/ufVF/lSatLTiZQ=;
        b=Y9G2XRtdJOwrX4XIINvefpCivwU6oPQI1QKL5TFxI1rgIG+BSE46RDrmVfeMkVW+OO
         AXk+cnFHRgp3Ac8j3hYC3EnDZ0OdExSWssqNsdfoM/eK7adZWoXL08w9PFiRM6l6DYp2
         IFvrPemR3A9gdbxvgacvgbV1/z+RnJexXsgGntZeMPJ3WHQvC1b9h/BsCBSOxiO0OmU6
         /GnyEZ8fbQ6oSzy9mTj9sR/lsCX7PlA/mvF89u4II7KvFiDeu1Z7/uWBJa6aJW7u5BBt
         cvUWR43ioDi3Kl6v42L9dFnwBPedGR+dHFqoOakM5VNeLH/bpssLnRuG4L/J9hdJwXdI
         IC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608119; x=1719212919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTSUxbZ58gO2uuyvGy7K8h6s7XmT/ufVF/lSatLTiZQ=;
        b=btUuzz6HE1+oh9aNKKz7GY/iHhH/0hgFxpis1eDrbek+W2NwZ/dGSOCUDwa/ybIU2C
         kKOxi9IWPuVECPZ6bd8WpfLCroVH8ejpYqpXZEZpLnk+Xujn6fDOczH4SaAxFdjTAO0i
         eJuZ/pJUpy32z7r3mjU8xcnN3i65Q+HJBSLLS5zPXm8IL7Z0wAZvvmQ0JxU8dtHzp9zq
         dxflnqonsiNzoptYioqCGtINNlbCeYZfCnTPTdz4ehV/BS3Urt8l7yB2uljJA7anQflL
         gpAcFIom8g6acC+nRhDVnoe4TAAQTmZnXeipqIfJT2ZdkSvf4KsuN6r5KGfn9FFqxoLd
         ru1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUkNSlSzkzlbSn2bvopifMRxgDwX2Y8nJ7rWpdDqqK8otELxui3ocbVwCwPKOKRlbJq0+htNf0ElhBdGFcW0nAgyYD01Qel7qe8Q83
X-Gm-Message-State: AOJu0YxoY+2L2qRBw8t7CQQiJ9enDJe0pVvIeOsybPQvvkF1Cru/vN2I
	YQJvWXONnztT/He0y77DiQEulkf+nJdQBcU+HJ1jMK75agoGtERas/IPILtcLN9JS9I2xQvtQFx
	4qgIJvJxcKa1duEfeO01/f1X6BFM=
X-Google-Smtp-Source: AGHT+IGyXYkkwcBZ9+XOW52yrHvXrTX56lCWtABQ3YIC/2n4rgpCVy/f5/LrDDazRcCjCeSG4YVkTm+EkfxDrfTfuQ0=
X-Received: by 2002:a05:6102:9c7:b0:48d:96fa:f0a7 with SMTP id
 ada2fe7eead31-48dae32b935mr8051525137.2.1718608119323; Mon, 17 Jun 2024
 00:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
 <20240615084714.37499-1-21cnbao@gmail.com> <87bk405akl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk405akl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 19:08:27 +1200
Message-ID: <CAGsJ_4yO+zZLyxnJCiOKVY+jkogo7vAyo8SY0PcsiM6JqYfduA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:50=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Barry,
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>
> >> On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:
> >>
> >> > > I'm having trouble understanding the overall impact of this on use=
rs.
> >> > > We fail the mTHP swap allocation and fall back, but things continu=
e to
> >> > > operate OK?
> >> >
> >> > Continue to operate OK in the sense that the mTHP will have to split
> >> > into 4K pages before the swap out, aka the fall back. The swap out a=
nd
> >> > swap in can continue to work as 4K pages, not as the mTHP. Due to th=
e
> >> > fallback, the mTHP based zsmalloc compression with 64K buffer will n=
ot
> >> > happen. That is the effect of the fallback. But mTHP swap out and sw=
ap
> >> > in is relatively new, it is not really a regression.
> >>
> >> Sure, but it's pretty bad to merge a new feature only to have it
> >> ineffective after a few hours use.
> >>
> >> > >
> >> > > > There is some test number in the V1 thread of this series:
> >> > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423=
b26@kernel.org
> >> > >
> >> > > Well, please let's get the latest numbers into the latest patchset=
.
> >> > > Along with a higher-level (and quantitative) description of the us=
er impact.
> >> >
> >> > I will need Barray's help to collect the number. I don't have the
> >> > setup to reproduce his test result.
> >> > Maybe a follow up commit message amendment for the test number when =
I get it?
> >
> > Although the issue may seem complex at a systemic level, even a small p=
rogram can
> > demonstrate the problem and highlight how Chris's patch has improved th=
e
> > situation.
> >
> > To demonstrate this, I designed a basic test program that maximally all=
ocates
> > two memory blocks:
> >
> >  *   A memory block of up to 60MB, recommended for HUGEPAGE usage
> >  *   A memory block of up to 1MB, recommended for NOHUGEPAGE usage
> >
> > In the system configuration, I enabled 64KB mTHP and 64MB zRAM, providi=
ng more than
> > enough space for both the 60MB and 1MB allocations in the worst case. T=
his setup
> > allows us to assess two effects:
> >
> > 1.  When we don't enable mem2 (small folios), we consistently allocate =
and free
> >     swap slots aligned with 64KB.  whether there is a risk of failure t=
o obtain
> >     swap slots even though the zRAM has sufficient free space?
> > 2.  When we enable mem2 (small folios), the presence of small folios ma=
y lead
> >     to fragmentation of clusters, potentially impacting the swapout pro=
cess for
> >     large folios negatively.
> >
> > (2) can be enabled by "-s", without -s, small folios are disabled.
> >
> > The script to configure zRAM and mTHP:
> >
> > echo lzo > /sys/block/zram0/comp_algorithm
> > echo 64M > /sys/block/zram0/disksize
> > echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabl=
ed
> > echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enable=
d
> > mkswap /dev/zram0
> > swapon /dev/zram0
> >
> > The test program I made today after receiving Chris' patchset v2
> >
> > (Andrew, Please let me know if you want this small test program to
> > be committed into kernel/tools/ folder. If yes, please let me know,
> > and I will cleanup and prepare a patch):
> >
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <string.h>
> > #include <sys/mman.h>
> > #include <errno.h>
> > #include <time.h>
> >
> > #define MEMSIZE_MTHP (60 * 1024 * 1024)
> > #define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> > #define ALIGNMENT_MTHP (64 * 1024)
> > #define ALIGNMENT_SMALLFOLIO (4 * 1024)
> > #define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> > #define TOTAL_DONTNEED_SMALLFOLIO (256 * 1024)
> > #define MTHP_FOLIO_SIZE (64 * 1024)
> >
> > #define SWPOUT_PATH \
> >     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> > #define SWPOUT_FALLBACK_PATH \
> >     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fa=
llback"
> >
> > static void *aligned_alloc_mem(size_t size, size_t alignment)
> > {
> >     void *mem =3D NULL;
> >     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> >         perror("posix_memalign");
> >         return NULL;
> >     }
> >     return mem;
> > }
> >
> > static void random_madvise_dontneed(void *mem, size_t mem_size,
> >                                      size_t align_size, size_t total_do=
ntneed_size)
> > {
> >     size_t num_pages =3D total_dontneed_size / align_size;
> >     size_t i;
> >     size_t offset;
> >     void *addr;
> >
> >     for (i =3D 0; i < num_pages; ++i) {
> >         offset =3D (rand() % (mem_size / align_size)) * align_size;
> >         addr =3D (char *)mem + offset;
> >         if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0) {
> >             perror("madvise dontneed");
> >         }
> >         memset(addr, 0x11, align_size);
> >     }
> > }
> >
> > static unsigned long read_stat(const char *path)
> > {
> >     FILE *file;
> >     unsigned long value;
> >
> >     file =3D fopen(path, "r");
> >     if (!file) {
> >         perror("fopen");
> >         return 0;
> >     }
> >
> >     if (fscanf(file, "%lu", &value) !=3D 1) {
> >         perror("fscanf");
> >         fclose(file);
> >         return 0;
> >     }
> >
> >     fclose(file);
> >     return value;
> > }
> >
> > int main(int argc, char *argv[])
> > {
> >     int use_small_folio =3D 0;
> >     int i;
> >     void *mem1 =3D aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
> >     if (mem1 =3D=3D NULL) {
> >         fprintf(stderr, "Failed to allocate 60MB memory\n");
> >         return EXIT_FAILURE;
> >     }
> >
> >     if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) !=3D 0) {
> >         perror("madvise hugepage for mem1");
> >         free(mem1);
> >         return EXIT_FAILURE;
> >     }
> >
> >     for (i =3D 1; i < argc; ++i) {
> >         if (strcmp(argv[i], "-s") =3D=3D 0) {
> >             use_small_folio =3D 1;
> >         }
> >     }
> >
> >     void *mem2 =3D NULL;
> >     if (use_small_folio) {
> >         mem2 =3D aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
> >         if (mem2 =3D=3D NULL) {
> >             fprintf(stderr, "Failed to allocate 1MB memory\n");
> >             free(mem1);
> >             return EXIT_FAILURE;
> >         }
> >
> >         if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) !=3D 0) =
{
> >             perror("madvise nohugepage for mem2");
> >             free(mem1);
> >             free(mem2);
> >             return EXIT_FAILURE;
> >         }
> >     }
> >
> >     for (i =3D 0; i < 100; ++i) {
> >         unsigned long initial_swpout;
> >         unsigned long initial_swpout_fallback;
> >         unsigned long final_swpout;
> >         unsigned long final_swpout_fallback;
> >         unsigned long swpout_inc;
> >         unsigned long swpout_fallback_inc;
> >         double fallback_percentage;
> >
> >         initial_swpout =3D read_stat(SWPOUT_PATH);
> >         initial_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PATH);
> >
> >         random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
> >                                  TOTAL_DONTNEED_MTHP);
> >
> >         if (use_small_folio) {
> >             random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
> >                                      ALIGNMENT_SMALLFOLIO,
> >                                      TOTAL_DONTNEED_SMALLFOLIO);
> >         }
> >
> >         if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) !=3D 0) {
> >             perror("madvise pageout for mem1");
> >             free(mem1);
> >             if (mem2 !=3D NULL) {
> >                 free(mem2);
> >             }
> >             return EXIT_FAILURE;
> >         }
> >
> >         if (use_small_folio) {
> >             if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) !=3D 0)=
 {
> >                 perror("madvise pageout for mem2");
> >                 free(mem1);
> >                 free(mem2);
> >                 return EXIT_FAILURE;
> >             }
> >         }
> >
> >         final_swpout =3D read_stat(SWPOUT_PATH);
> >         final_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PATH);
> >
> >         swpout_inc =3D final_swpout - initial_swpout;
> >         swpout_fallback_inc =3D final_swpout_fallback - initial_swpout_=
fallback;
> >
> >         fallback_percentage =3D (double)swpout_fallback_inc /
> >                               (swpout_fallback_inc + swpout_inc) * 100;
> >
> >         printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu=
, Fallback percentage: %.2f%%\n",
> >                i + 1, swpout_inc, swpout_fallback_inc, fallback_percent=
age);
> >     }
> >
> >     free(mem1);
> >     if (mem2 !=3D NULL) {
> >         free(mem2);
> >     }
> >
> >     return EXIT_SUCCESS;
> > }
>
> Thank you very for your effort to write this test program.
>
> TBH, personally, I thought that this test program isn't practical
> enough.  Can we show performance difference with some normal workloads?

Right.

The whole purpose of this small program is to demonstrate the problem
in the current code - even swap slots are always allocated and released
aligned with mTHP, the current mainline will soon get 100% fallback ratio
though swap space is enough, and swap slots are not fragmented at all.
as long as we lose empty clusters, we lose the chance to do mthp
swapout.

We are still running tests using real Android phones with real workloads, a=
nd
will update you with the result hopefully this week. I am a little worried =
that
the  triggered WARN_ONCE will lead to the failure of the test.

>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

