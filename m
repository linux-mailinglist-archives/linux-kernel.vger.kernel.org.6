Return-Path: <linux-kernel+bounces-278449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641594B05E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE03228186E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542A143891;
	Wed,  7 Aug 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJbgSZsI"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C9143729
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058078; cv=none; b=Q7mXV2XN5phVAA8IckxnkOrlaUN5RrkAmO9R5bhIidkKKX6N94kVF9UvNkFR3xruBkJWKyPm6Z/Ntkop6RtARjfS9xubrGM0JyufgID2LIxaZFgXK96MXtX/Ly6E8RnBDmFvU41EKfd1e7EV5E8qEErhBHmNYUGPcK7bOZ4yZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058078; c=relaxed/simple;
	bh=2xgWBzf+vJGthpzzCnKpx0/ASfwgziSQRHBTdR6+gqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKd/2H3vpqZsplggVNowHxuwIHrYknvp9TOgFEvcHK4XAuwox/+6lD25/8rW1KBXSLQHPBMlUPSrcLrj+rDtNYscgAwaKUzNHPILoU08pMMvzB3bMvruPrpxnvqYcQnKC4t/kPaVsB5Qz5lvTFh2vc/EgSo6o17AGKCmJNQH8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJbgSZsI; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso76019e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058076; x=1723662876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Txen1vMHjqTbifFDrmTNIVjuEdhWqsncnmyTY75FWRs=;
        b=OJbgSZsI8h5CXTSF13NK4CEI4NQkw+MVCSbdjGy20iVdOR6zPW4DQ+3ZY536WEZD+M
         q6A39sUXBaZhK0Rz2EA6wYB41J0ZuQWd9GpaZhEFcjp0jQmAsnhdjFr6xApaWWVzgUPM
         6T560Ymdoux9kMIpQ7g6zmvigEeMYJRFP9N/KlHbMpgoeD1fz/3epwYP5H8cxZZWRFd4
         9Doxl7acFnzQg0dGVRdSMbcXlayhosx7ZfDt+haD6C4zoQ7TB3f03y1hde+18z2tCxgN
         ANe7BdraRC4Bq22ZbHQZS3Yipr+NFhAOFNADwlGoy+Plpbqg/kOoBgQ4IDjuuBFzaOng
         au+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058076; x=1723662876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Txen1vMHjqTbifFDrmTNIVjuEdhWqsncnmyTY75FWRs=;
        b=g3mHGl98iQFfFOI0nQSNkAQaOpna0YpKVldykUrjqmOrHwG7KHuIDDXofTKmUpEH9S
         ++FtO9U3iBis75sF7uDmc43yNXl3xahiW2UVGNTNDMPZh4P7jgKL4dUt/eDKJQ4kTpgZ
         38lpptEHkyhmM81d1NBrSDnW/kY+K/4nEIUNThKW7lRGMFj27L7fOKNhvtxf3RmEIbsC
         slx9wyG//7WGf0mKOeLYxzRssDLORp9qg2D8Fqj5kpdDpklhJaRZLxQCF4L9C8a3X7GK
         E+5/qkIuqgxU8WpgrwjXfstojvmdiZyCjNh3BtrSAC5rLCcBA1O2bo1HOl8oXbsM2iAs
         j39g==
X-Forwarded-Encrypted: i=1; AJvYcCUiu6RRHFpPPLTtKMvfOcxjhMtajF3/OYsOVNSXk/wRCDa8Nb7AN4J6M+7fIJcNehgSDZY70I12p6NApLuaJWjiBn0BifHfVqgGFCQ2
X-Gm-Message-State: AOJu0YxXu4HrxoGYzmj113XJLCuFfzKGql1suhsNX1KA53uAo+ZDqxbH
	I1lym/a74IUTehRL6wByTasbtCAH43YlqC6yJF4XX5ErLPjgM5yvX9pn7igvdawrbMtloOv3Oss
	ZUUFC7OE7KjSEZRzHOJOTN/7Hmyk=
X-Google-Smtp-Source: AGHT+IGj6z+UuGEVKFCQ8RupY/iF+B1Q+VPuDNen3+0wRZ9Qug4ekyeq7ewC/zoVj3h3dTfcuEOQCir8c2CuM9WQdP8=
X-Received: by 2002:a05:6122:1da9:b0:4f5:25c0:af07 with SMTP id
 71dfb90a1353d-4f8a0002390mr20797403e0c.9.1723058075754; Wed, 07 Aug 2024
 12:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807082508.358322-1-21cnbao@gmail.com> <20240807082508.358322-3-21cnbao@gmail.com>
 <CAMgjq7Cguq-W569LQQtL1TcTZdL0-iAMayRrs5Lu1UvBDbg=Vw@mail.gmail.com>
In-Reply-To: <CAMgjq7Cguq-W569LQQtL1TcTZdL0-iAMayRrs5Lu1UvBDbg=Vw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Aug 2024 07:14:23 +1200
Message-ID: <CAGsJ_4ywsuYCOEeip66xc_2CH1tkykHEGDHQ00bzTXbDOS1jaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: attempt to batch free swap entries for zap_pte_range()
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, justinjiang@vivo.com, 
	chrisl@kernel.org, david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 4:16=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Wed, Aug 7, 2024 at 4:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Zhiguo reported that swap release could be a serious bottleneck
> > during process exits[1]. With mTHP, we have the opportunity to
> > batch free swaps.
> > Thanks to the work of Chris and Kairui[2], I was able to achieve
> > this optimization with minimal code changes by building on their
> > efforts.
> > If swap_count is 1, which is likely true as most anon memory are
> > private, we can free all contiguous swap slots all together.
> >
> > Ran the below test program for measuring the bandwidth of munmap
> > using zRAM and 64KiB mTHP:
> >
> >  #include <sys/mman.h>
> >  #include <sys/time.h>
> >  #include <stdlib.h>
> >
> >  unsigned long long tv_to_ms(struct timeval tv)
> >  {
> >         return tv.tv_sec * 1000 + tv.tv_usec / 1000;
> >  }
> >
> >  main()
> >  {
> >         struct timeval tv_b, tv_e;
> >         int i;
> >  #define SIZE 1024*1024*1024
> >         void *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >         if (!p) {
> >                 perror("fail to get memory");
> >                 exit(-1);
> >         }
> >
> >         madvise(p, SIZE, MADV_HUGEPAGE);
> >         memset(p, 0x11, SIZE); /* write to get mem */
> >
> >         madvise(p, SIZE, MADV_PAGEOUT);
> >
> >         gettimeofday(&tv_b, NULL);
> >         munmap(p, SIZE);
> >         gettimeofday(&tv_e, NULL);
> >
> >         printf("munmap in bandwidth: %ld bytes/ms\n",
> >                         SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
> >  }
> >
> > The result is as below (munmap bandwidth):
> >                 mm-unstable  mm-unstable-with-patch
> >    round1       21053761      63161283
> >    round2       21053761      63161283
> >    round3       21053761      63161283
> >    round4       20648881      67108864
> >    round5       20648881      67108864
> >
> > munmap bandwidth becomes 3X faster.
>
> Hi Barry,
>
> Thanks for the patch, I also noticed this could be optimized when
> working on the batch freeing of mthp pages in the series you
> mentioned, a very nice improvement.
>
> >
> > [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@v=
ivo.com/
> > [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c1=
48b9297@kernel.org/
> >
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/swapfile.c | 78 +++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 67 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 35cb58373493..25c3f98fa8d5 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_str=
uct *si,
> >         return true;
> >  }
> >
> > +static bool swap_is_last_map(struct swap_info_struct *si,
> > +                             unsigned long offset, int nr_pages,
> > +                             bool *has_cache)
> > +{
> > +       unsigned char *map =3D si->swap_map + offset;
> > +       unsigned char *map_end =3D map + nr_pages;
> > +       bool cached =3D false;
> > +
> > +       do {
> > +               if ((*map & ~SWAP_HAS_CACHE) !=3D 1)
> > +                       return false;
>
> I haven't tried this yet, but looking at this if. If a mthp or thp was
> split, and part of the slots are "1", rest of the slots are "HAS_CACHE
> | 1", this will also return true, is this a problem?
>
> These slots with "1" don't have an entry in the swap cache, so the
> following reclaim in free_swap_and_cache_nr might not work as
> expected, could they be stuck in HAS_CACHE state?

good catch. Kairui, Thanks! In this case, I am leaking swap slots whose
count =3D=3D 1.
The original non-batch code will still free those slots in non-batched mode
but my code will just write them to SWAP_HAS_CACHE.
this can be fixed by:

static bool swap_is_last_map(struct swap_info_struct *si,
                unsigned long offset, int nr_pages, bool *has_cache)
{
        unsigned char *map =3D si->swap_map + offset;
        unsigned char *map_end =3D map + nr_pages;
        unsigned char count =3D *map;

        if (swap_count(count) !=3D 1)
                return false;

        do {
                if (*map !=3D count)
                        return false;
        } while (++map < map_end);

        *has_cache =3D !!(count & SWAP_HAS_CACHE);
        return true;
}

Thanks
Barry

