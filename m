Return-Path: <linux-kernel+bounces-229785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6134917424
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734AA1F233D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554217E8F4;
	Tue, 25 Jun 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGEXGGZI"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EF17E8E8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353649; cv=none; b=jaqsB2FQOWUP1bYLL0TtTUZmKdkf2jOZJBGUyO0o3pBelCIhbfThGBNYT+Qyx2zmOe+TFYmS8cWSq8ODYEqHOl64onBsakjbQDbckZpJuo8MamGFLpePJGDPLRF1qALu9a/3SdIP79p3A9CQmuEJ+NivWFmjUmVGiboZ0gnnTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353649; c=relaxed/simple;
	bh=59EHRdNMZr6Glpuf0REItOqnheCHwrP6v3ZlM6QqqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKcQZWadZfRVoiXAizt4C97Wd2JFyPKN5V9rjhkIoAg6nZrSH4JXTp/1frhwSSmDiVQZa4WJrKFiOhl01bIarmMvl/BL+hiURi1mml2ns9i6s/rvqpyeEI0ge0cFf+KcnqpmkhYAUwQdZNJm3Uoj0yvDzCSqObFKHjEYoh/TCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGEXGGZI; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48f5c2f066cso1212267137.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719353647; x=1719958447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBmF8qpxGKp1kzaqDCL3gOxUmnHpnL0NKHPV85ofbcw=;
        b=EGEXGGZIKo1CveLuhsddFPcx/AGWCoZ+ORQmra/dayZ3gJlje+rJA/SrHQzDF6+cP3
         k35QO1BR77l6CBrpMTJRUg07JTw5tawMdVR2yN5yPKLZYD92ShziDaRPj3fzMz8VI9WG
         p+NOnwev2IBqqUNXxhQDNfI2RM+CYXaJ45XeW+nb9nYVHu6bVKQGO2TxxEifZE2Lrnwh
         eS79FaTp5I9b45EQLpQDQV9OKbvqyIULmsGUyCJPpbgUuTmH4cE9/XM34/9SnvaCWKl4
         7HJfXhY+t3nSXLT4lU0I457sJgTxr7UpVVNNeulmGzsKpvcvtbgt/+OGBrALT3PtBozj
         3XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719353647; x=1719958447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBmF8qpxGKp1kzaqDCL3gOxUmnHpnL0NKHPV85ofbcw=;
        b=VXpRT8S3dOgLSz4UE7fcJ6ri3akQRYa2p/lM/Yi6Vn1/5T53XG2CBXvCDjfndfFGR3
         Ejv0Sehta4zEoy4gS+3LAEAidh+AMtp6RfRHY6p1q3YExKrbfFa2PcXH3BWvjIb8i51u
         I9JIEEUK5O3FUMrPug8Vy9VjudQ9ZzZCKmdEhBegpGvB4aRiPf1HPDDFdXFdnxIAy3G9
         r8uS+12wvtY0B4NT6JpRA947f8zVrNaoAVGXDAHnS0AJxM3XlVfGP/MMKTrGcKTX45N8
         cVD/dz/zbLe9fmIGjemOkaWnZQCUhzHBuT4nvqoLn281SrO5WrtMBJkpQ07UmzO20LaE
         bvyw==
X-Forwarded-Encrypted: i=1; AJvYcCXLRXbb8TSn3+NMTRpdJTAnpPwRvJhXoQU2A6YOV8/rYs4zgdqMl79gCgeF7OLlLt5xVN81rofm6wbHuiAEUtOZY4zb0Jq6g732vafE
X-Gm-Message-State: AOJu0Yyth7nLbdGgPmN7TNPj90xPyMY1AxzenRL16muZhUBSE2i/v3Ds
	+CTvK8sppwbWsL8rCDbtMZQC8JRAnUhC/1PD478W9N2EyWy+jZLGz0iX5MT4oNN3FX7/I6Oa+9J
	++6Ic/Am+g+oDisayB6i4G4bM+7w=
X-Google-Smtp-Source: AGHT+IEe3U160qIaAae3LU0qSN+AdvBf2PQzMdPzqDSRdlUQa+mlog2LEP0qLJUERlyXVjG9VKP+xuiphHVlraBul6g=
X-Received: by 2002:a05:6102:11e5:b0:48d:9b0b:903d with SMTP id
 ada2fe7eead31-48f68ff4cf2mr4849015137.5.1719353647033; Tue, 25 Jun 2024
 15:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <20240622071231.576056-2-21cnbao@gmail.com>
 <CAMgjq7BNC_O5zqh522rs78_SPiiq1KXxGyOCUstwQUgucTLgxA@mail.gmail.com>
In-Reply-To: <CAMgjq7BNC_O5zqh522rs78_SPiiq1KXxGyOCUstwQUgucTLgxA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 26 Jun 2024 10:13:55 +1200
Message-ID: <CAGsJ_4ysGD6Tw4EK6dCJ0x3S+s_6xCYZH90K-+mneE4JAp=hYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Jun 22, 2024 at 3:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Both Ryan and Chris have been utilizing the small test program to aid
> > in debugging and identifying issues with swap entry allocation. While
> > a real or intricate workload might be more suitable for assessing the
> > correctness and effectiveness of the swap allocation policy, a small
> > test program presents a simpler means of understanding the problem and
> > initially verifying the improvements being made.
> >
> > Let's endeavor to integrate it into tools/mm. Although it presently
> > only accommodates 64KB and 4KB, I'm optimistic that we can expand
> > its capabilities to support multiple sizes and simulate more
> > complex systems in the future as required.
> >
> > Basically, we have
> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation cod=
e
> > under high exercise in a short time.
> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in
> > freeing memory, as well as for munmap, app exits, or OOM killer scenari=
os.
> > This ensures new mTHP is always generated, released or swapped out, sim=
ilar
> > to the behavior on a PC or Android phone where many applications are
> > frequently started and terminated.
> > 3. Swap in with or without the "-a" option to observe how fragments
> > due to swap-in and the incoming swap-in of large folios will impact
> > swap-out fallback.
> >
> > Due to 2, we ensure a certain proportion of mTHP. Similarly, because
> > of 3, we maintain a certain proportion of small folios, as we don't
> > support large folios swap-in, meaning any swap-in will immediately
> > result in small folios. Therefore, with both 2 and 3, we automatically
> > achieve a system containing both mTHP and small folios. Additionally,
> > 1 provides the ability to continuously swap them out.
> >
> > We can also use "-s" to add a dedicated small folios memory area.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  tools/mm/Makefile                  |   2 +-
> >  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
> >  2 files changed, 234 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/mm/thp_swap_allocator_test.c
> >
> > diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> > index 7bb03606b9ea..15791c1c5b28 100644
> > --- a/tools/mm/Makefile
> > +++ b/tools/mm/Makefile
> > @@ -3,7 +3,7 @@
> >  #
> >  include ../scripts/Makefile.include
> >
> > -BUILD_TARGETS=3Dpage-types slabinfo page_owner_sort
> > +BUILD_TARGETS=3Dpage-types slabinfo page_owner_sort thp_swap_allocator=
_test
> >  INSTALL_TARGETS =3D $(BUILD_TARGETS) thpmaps
> >
> >  LIB_DIR =3D ../lib/api
> > diff --git a/tools/mm/thp_swap_allocator_test.c b/tools/mm/thp_swap_all=
ocator_test.c
> > new file mode 100644
> > index 000000000000..a363bdde55f0
> > --- /dev/null
> > +++ b/tools/mm/thp_swap_allocator_test.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * thp_swap_allocator_test
> > + *
> > + * The purpose of this test program is helping check if THP swpout
> > + * can correctly get swap slots to swap out as a whole instead of
> > + * being split. It randomly releases swap entries through madvise
> > + * DONTNEED and swapin/out on two memory areas: a memory area for
> > + * 64KB THP and the other area for small folios. The second memory
> > + * can be enabled by "-s".
> > + * Before running the program, we need to setup a zRAM or similar
> > + * swap device by:
> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> > + *  echo 64M > /sys/block/zram0/disksize
> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/=
enabled
> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/e=
nabled
> > + *  mkswap /dev/zram0
> > + *  swapon /dev/zram0
> > + * The expected result should be 0% anon swpout fallback ratio w/ or
> > + * w/o "-s".
> > + *
> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
>
> Hi Barry,
>
> Found a small issue while testing your tool.. for better
> compatibility, I think you missed <linux/mman.h>, I'm getting
> following error without it (with glibc-headers-2.28-236 on el8
> system):
>
> thp_swap_allocator_test.c:161:30: error: =E2=80=98MADV_PAGEOUT=E2=80=99 u=
ndeclared
> (first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99?
>   madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT);
>                               ^~~~~~~~~~~~
>
> Other in-tree test tools using this flag also includes <linux/mman.h>.

Thanks very much, Kairui.

I was using some toolchains on both arm64 and x86, but they didn't
complain.
I agree mman.h is the correct uapi file for MADV_PAGEOUT.

   1     72  arch/alpha/include/uapi/asm/mman.h <<MADV_PAGEOUT>>
             #define MADV_PAGEOUT 21
   2     99  arch/mips/include/uapi/asm/mman.h <<MADV_PAGEOUT>>
             #define MADV_PAGEOUT 21
   3     66  arch/parisc/include/uapi/asm/mman.h <<MADV_PAGEOUT>>
             #define MADV_PAGEOUT 21
   4    107  arch/xtensa/include/uapi/asm/mman.h <<MADV_PAGEOUT>>
             #define MADV_PAGEOUT 21
   5     73  include/uapi/asm-generic/mman-common.h <<MADV_PAGEOUT>>
             #define MADV_PAGEOUT 21

