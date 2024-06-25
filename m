Return-Path: <linux-kernel+bounces-229378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01220916F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4BB2852FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2309178390;
	Tue, 25 Jun 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPLB7Ol3"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBB178361
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336158; cv=none; b=DBfeOD3AwnCLVPfm7mqLu1EQS06tYFouSyAyuKjTg+nW36iwq3eN0x0Fzmi1VNevrr/f7VE2X5+REH9VuE0m827nvL81Ftld/N9bZt42bQ3P09d/Y5UUczKsAC/2qqD0LcMehcO58OWnYbfAUE24QBIoBvRwZoC0FfVi2GTxRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336158; c=relaxed/simple;
	bh=dqG7w43iPHnt0PDr2DMEYcCiCAJjt30o8hAILUS/iJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYRUVDkFxZdbH+lM0GTY7yiaEPNT8Fe5Iq4q4qWGrU0jwhQoBQpeTSSc2lnHkaBFWS7gC9APKvQqCfJCKkHKIEvIS4l/7WyGofA8S9nYx0YQd1sn+xuwAAunKdeo4fuZA6LpWnEYhH70NjfP40jKVsTRWcG+2LecA8hJjG2GhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPLB7Ol3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso71536641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336155; x=1719940955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8+vxqtoku9WMxCA6PXoqwBfKDqGzEMaoj9vVLQWGmg=;
        b=fPLB7Ol3vzGD74KsnaSC8WbN4C3U5sSAegZiFd/eezcBkdUEEBWY3hVeNyTZOMSe1b
         C6Y4aCfQobfECCBjrQmbf2OUvIc7BQ4Alj9t5dYDyKOVgzQZeZCypfSzX7yJnDYon8Xq
         44z5aNs3d3tFizLzsKoRDcB7sRipN5vgqCGCTAxo9p927+a+iCASWawSoyRDDbbhJhbV
         +AxJTXlEB3YQqyK5Eu1gMd6YXh2A1jkWhleVjc6nuVIBdzJFlWfGxUVoDQd/tobpuhrp
         uHWrtrwtdAQuPh/N9iar6GBGk5t9nqcMPmYfstHu8JCfx92VpbiMytgeZuQpPkpt9iMA
         quNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336155; x=1719940955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8+vxqtoku9WMxCA6PXoqwBfKDqGzEMaoj9vVLQWGmg=;
        b=JDz0WsM25/JcEx+Wyt+cUabrX1iVvSq6c211OGvvClxPei54sam9/21crjhTAHSKQL
         vgX6G+Cn+uwq9kFPzrKjJ2JvR9aBKRtuXKwVJxlDyoZZfgmqSJKA/1UERnZ43w6I5Cti
         otVc807rlu1UGxrHWYY+MscdiS1GBzRLlcMFy+w2gnqCZ16GZXTC4iFqF8WZtb6j+5zU
         aR3PzPCSiojcdkyZ6ToxESOehtpmz03tVNNVii6viXD3obvrxca+ztDcFWcMfPb5x0YP
         yVVNJFpOYZgM9pvoAMBxsFFIt3WsqU0bCQsYvRl/cCr+3maAx0+1jamccYhtXkGV57RV
         iidQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLQtMfyHFMYW1A65tDdISy4By4RL0m0wf0cfrB4Fv3o9oTNV7h4NrK5saQYzfJjbAy4lZj5w7WqwuzgzzVC+7lc3D8DLypOvlKxkg
X-Gm-Message-State: AOJu0Yz2Mwl636tHKZrLIkgqLuGH8T2we5frSpBS4xGVxa54NfjctZgS
	d8dHwrLxizncPUjLn2yAw9NXlDgh0ff13CvPwWV0r6yOYXAJ7/QXRLPhRpBFEWguLOe4tn6QQ4e
	yDNHIYnzH2+f6aNroLnJDwKK4yyM=
X-Google-Smtp-Source: AGHT+IENflu0IhOwnz3G7CoO5qIYDSrf3yQTxo4pN2s8oFrddW68LdZ70xyM8SUrG1NNxvukXAkxa3vCptR2WVA9VfU=
X-Received: by 2002:a05:651c:b0d:b0:2ec:5f0d:8b08 with SMTP id
 38308e7fff4ca-2ec5f0d8f83mr62208701fa.37.1719336154320; Tue, 25 Jun 2024
 10:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <20240622071231.576056-2-21cnbao@gmail.com>
In-Reply-To: <20240622071231.576056-2-21cnbao@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 26 Jun 2024 01:22:17 +0800
Message-ID: <CAMgjq7BNC_O5zqh522rs78_SPiiq1KXxGyOCUstwQUgucTLgxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 3:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Both Ryan and Chris have been utilizing the small test program to aid
> in debugging and identifying issues with swap entry allocation. While
> a real or intricate workload might be more suitable for assessing the
> correctness and effectiveness of the swap allocation policy, a small
> test program presents a simpler means of understanding the problem and
> initially verifying the improvements being made.
>
> Let's endeavor to integrate it into tools/mm. Although it presently
> only accommodates 64KB and 4KB, I'm optimistic that we can expand
> its capabilities to support multiple sizes and simulate more
> complex systems in the future as required.
>
> Basically, we have
> 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code
> under high exercise in a short time.
> 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in
> freeing memory, as well as for munmap, app exits, or OOM killer scenarios=
.
> This ensures new mTHP is always generated, released or swapped out, simil=
ar
> to the behavior on a PC or Android phone where many applications are
> frequently started and terminated.
> 3. Swap in with or without the "-a" option to observe how fragments
> due to swap-in and the incoming swap-in of large folios will impact
> swap-out fallback.
>
> Due to 2, we ensure a certain proportion of mTHP. Similarly, because
> of 3, we maintain a certain proportion of small folios, as we don't
> support large folios swap-in, meaning any swap-in will immediately
> result in small folios. Therefore, with both 2 and 3, we automatically
> achieve a system containing both mTHP and small folios. Additionally,
> 1 provides the ability to continuously swap them out.
>
> We can also use "-s" to add a dedicated small folios memory area.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  tools/mm/Makefile                  |   2 +-
>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 tools/mm/thp_swap_allocator_test.c
>
> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> index 7bb03606b9ea..15791c1c5b28 100644
> --- a/tools/mm/Makefile
> +++ b/tools/mm/Makefile
> @@ -3,7 +3,7 @@
>  #
>  include ../scripts/Makefile.include
>
> -BUILD_TARGETS=3Dpage-types slabinfo page_owner_sort
> +BUILD_TARGETS=3Dpage-types slabinfo page_owner_sort thp_swap_allocator_t=
est
>  INSTALL_TARGETS =3D $(BUILD_TARGETS) thpmaps
>
>  LIB_DIR =3D ../lib/api
> diff --git a/tools/mm/thp_swap_allocator_test.c b/tools/mm/thp_swap_alloc=
ator_test.c
> new file mode 100644
> index 000000000000..a363bdde55f0
> --- /dev/null
> +++ b/tools/mm/thp_swap_allocator_test.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * thp_swap_allocator_test
> + *
> + * The purpose of this test program is helping check if THP swpout
> + * can correctly get swap slots to swap out as a whole instead of
> + * being split. It randomly releases swap entries through madvise
> + * DONTNEED and swapin/out on two memory areas: a memory area for
> + * 64KB THP and the other area for small folios. The second memory
> + * can be enabled by "-s".
> + * Before running the program, we need to setup a zRAM or similar
> + * swap device by:
> + *  echo lzo > /sys/block/zram0/comp_algorithm
> + *  echo 64M > /sys/block/zram0/disksize
> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/en=
abled
> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/ena=
bled
> + *  mkswap /dev/zram0
> + *  swapon /dev/zram0
> + * The expected result should be 0% anon swpout fallback ratio w/ or
> + * w/o "-s".
> + *
> + * Author(s): Barry Song <v-songbaohua@oppo.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>

Hi Barry,

Found a small issue while testing your tool.. for better
compatibility, I think you missed <linux/mman.h>, I'm getting
following error without it (with glibc-headers-2.28-236 on el8
system):

thp_swap_allocator_test.c:161:30: error: =E2=80=98MADV_PAGEOUT=E2=80=99 und=
eclared
(first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=80=99?
  madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT);
                              ^~~~~~~~~~~~

Other in-tree test tools using this flag also includes <linux/mman.h>.

