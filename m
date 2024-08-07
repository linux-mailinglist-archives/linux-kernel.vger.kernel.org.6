Return-Path: <linux-kernel+bounces-278243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C494ADDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED1E2826A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF013342F;
	Wed,  7 Aug 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzT6eBzg"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A482877
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047402; cv=none; b=OTy/QOvUk8tKJvXDPqCnFAONGx8CH/gx7UWODmRmMz7oXs4p+/fe1IJr5eJWod9wcsuFroBY41gGjqj4FgsHPwLBc+N29fSly85dkNjHWwZ1TtAi6LuT/n3hf8FH4l/CGp9Zj704pnvG6l7IVWhwArTJKl9idZeqMuavaoBU7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047402; c=relaxed/simple;
	bh=MI7sSboBP1NrSrNXQc3XgxcQympC6bPZQGhVik5dI5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai/AHx4x2LhmUmDK3KDNeB0FJBhr6TPPJga5bIxbEtPxCZYCTV2mQwgWHIE0ZerH4adj0AR3fJq+VgvpsHLEhkpmpEnMTdqmsV4I46z37LR64n0XJ9jrsuqhSg3flLmj4Q8pFTaEvCWNxMhQ556T4xXo4fTkfNRFDeyLms5j22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzT6eBzg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f136e23229so21558281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723047399; x=1723652199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gyjs0Rrcn0PKL+uhQ3AI6g+Fooe+lQJvWnWfkoVmruQ=;
        b=JzT6eBzgjEyfAhy3qexnOivF+Z++988a8XrFkwG6x5jddK0FcTtYhAGne9b7VlogZG
         Ra4BzegyTsjF/9YrspK09Bwdz2KRkjZV+gPPaimDDHOtM2T42G6JXz5CoyhflO6wtdR0
         v2mbf0mEInI61c3G4zAyvohhKjsv7hACHcacT5Xo+/lLR8G5SEUbCMSOc2ukZDl6xFqF
         qjMyb1eyyBAtrYgx+WMuOxQ+HSn7Aj8QuWwAAci5gv7iIHn17al0r6LnzbO2EvZmhOj0
         daUp0EaKzhGicrChFWhhykDtSVd8TkX3d47K/saWK+9kY31LIcQHE1AIdd94kRwPJxag
         rq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047399; x=1723652199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gyjs0Rrcn0PKL+uhQ3AI6g+Fooe+lQJvWnWfkoVmruQ=;
        b=mmvIxmJZJGakqy3+GmF0+3itdELtNdPm+ctFyxPc7tE4ATCgBqWO/21a+85uYQ3YbI
         Dh5kMcUgaHeFne+I0mpGWLNW8aymHs5yswYTRQ2yghH2CHzYs95cduCAMM4m6hs1gley
         M7CjeSl54lxS/5GCjGyXF9TL7nuj+gDYJZTftuA2PFGNSl+CWFmHbF8gQqvPqAf0RxwT
         pAnOwQl8jwZE+CKiyiBKiZbB1eJlJ3uXyrAL6ts9+HL1OqcpWZ8lDfM7HWrGh61QVZNR
         P1seaTqCbQLzmT6ZNuaoWcFKKrywxeBw1uxrmjV7yB3QH1br46n7EOla265Q12omGlEN
         lQOA==
X-Forwarded-Encrypted: i=1; AJvYcCUltSXGlU29QjCJGm7Hc9xZtIhTR3mD7gIP7IyI1FLsTdgTRSPlPwDUIQqxJUkfWA5Vbsg7qJ+l9vuXZhKypJS2x5vkX8hhcnaREE22
X-Gm-Message-State: AOJu0YzI8TaDYrunrVhVlNrNHMan6dRTV3smYDz7Qgth0h8U0uO4mJ/t
	d/HN08/PqY5cQKZi4SqzDNiJeMUCyb8U1odvwhavo/+KiY+8aYnWbYjyMG+VzrfzeOkGV+jmX2p
	iHLzh2T9shmx+/M6GLp+MxXP4WhBSvoY9u2w=
X-Google-Smtp-Source: AGHT+IEaohZ1aclz4TMY1PHiKBWjUNpSOcXtnY89k0ZkHaj0OEgffSMrvVY52DvfbH4PzOG+7LD7E9WE13k9kwvq1Gc=
X-Received: by 2002:a2e:3815:0:b0:2ef:2dbe:7454 with SMTP id
 38308e7fff4ca-2f15ab3995cmr130070011fa.43.1723047398598; Wed, 07 Aug 2024
 09:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807082508.358322-1-21cnbao@gmail.com> <20240807082508.358322-3-21cnbao@gmail.com>
In-Reply-To: <20240807082508.358322-3-21cnbao@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 8 Aug 2024 00:16:22 +0800
Message-ID: <CAMgjq7Cguq-W569LQQtL1TcTZdL0-iAMayRrs5Lu1UvBDbg=Vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: attempt to batch free swap entries for zap_pte_range()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, justinjiang@vivo.com, 
	chrisl@kernel.org, david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Zhiguo reported that swap release could be a serious bottleneck
> during process exits[1]. With mTHP, we have the opportunity to
> batch free swaps.
> Thanks to the work of Chris and Kairui[2], I was able to achieve
> this optimization with minimal code changes by building on their
> efforts.
> If swap_count is 1, which is likely true as most anon memory are
> private, we can free all contiguous swap slots all together.
>
> Ran the below test program for measuring the bandwidth of munmap
> using zRAM and 64KiB mTHP:
>
>  #include <sys/mman.h>
>  #include <sys/time.h>
>  #include <stdlib.h>
>
>  unsigned long long tv_to_ms(struct timeval tv)
>  {
>         return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>  }
>
>  main()
>  {
>         struct timeval tv_b, tv_e;
>         int i;
>  #define SIZE 1024*1024*1024
>         void *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (!p) {
>                 perror("fail to get memory");
>                 exit(-1);
>         }
>
>         madvise(p, SIZE, MADV_HUGEPAGE);
>         memset(p, 0x11, SIZE); /* write to get mem */
>
>         madvise(p, SIZE, MADV_PAGEOUT);
>
>         gettimeofday(&tv_b, NULL);
>         munmap(p, SIZE);
>         gettimeofday(&tv_e, NULL);
>
>         printf("munmap in bandwidth: %ld bytes/ms\n",
>                         SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>  }
>
> The result is as below (munmap bandwidth):
>                 mm-unstable  mm-unstable-with-patch
>    round1       21053761      63161283
>    round2       21053761      63161283
>    round3       21053761      63161283
>    round4       20648881      67108864
>    round5       20648881      67108864
>
> munmap bandwidth becomes 3X faster.

Hi Barry,

Thanks for the patch, I also noticed this could be optimized when
working on the batch freeing of mthp pages in the series you
mentioned, a very nice improvement.

>
> [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@viv=
o.com/
> [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148=
b9297@kernel.org/
>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/swapfile.c | 78 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 35cb58373493..25c3f98fa8d5 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struc=
t *si,
>         return true;
>  }
>
> +static bool swap_is_last_map(struct swap_info_struct *si,
> +                             unsigned long offset, int nr_pages,
> +                             bool *has_cache)
> +{
> +       unsigned char *map =3D si->swap_map + offset;
> +       unsigned char *map_end =3D map + nr_pages;
> +       bool cached =3D false;
> +
> +       do {
> +               if ((*map & ~SWAP_HAS_CACHE) !=3D 1)
> +                       return false;

I haven't tried this yet, but looking at this if. If a mthp or thp was
split, and part of the slots are "1", rest of the slots are "HAS_CACHE
| 1", this will also return true, is this a problem?

These slots with "1" don't have an entry in the swap cache, so the
following reclaim in free_swap_and_cache_nr might not work as
expected, could they be stuck in HAS_CACHE state?

