Return-Path: <linux-kernel+bounces-172911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C48BF885
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6D3B226AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CA5026D;
	Wed,  8 May 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp12ydVm"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2F1EB56
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157028; cv=none; b=uVzBcCYnx6lqD+3vdD0bV4A3Zkwvx2ue/Nh2KCQxqjWkjJyuoQ0LpD1Gy/j5YPTyCBDoI3zBC1t0Z3+v897jhe8+EfmrlucqT4RglqZNILBc9vKOfoD9BBV9LALYxZc57F6JQeMWtgOA1ciK50q8k3/3d3YbnFRcUqxcD+35XO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157028; c=relaxed/simple;
	bh=+3ReGjuhVd6zQ3RcnRj3ZV+iMuDv13+l7oOLnOiEWY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLZ+rahsdjAScs+VD0ig3fr4CDHSYMs7mmU0v7WcKGAfoNybnOQnF0oJz21xidy7Bn4ANcXOBxeX25SFwaZoxyK04OxbxWJL5PD+QDVAVKy2qWwAsPEav1zKp1M6LuxL5ecDgQX3EdvdXLam/zCPQKKwxq2bYfjFFYT2CcKdo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp12ydVm; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4df1cb3c87eso1296458e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715157026; x=1715761826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUJDG03Mjw+2XpovVR7RPuA7B88kWpbfRCW3yD4FtR4=;
        b=Xp12ydVmApexN4DzWodd+uWOmPBoOv+ckDmfLAkAzxVip2TwiUZfGlbyXJIJtgtlPh
         PaCUkkINjdxoY5ud8mEXUCnqHI+41XbkKc9T3yuVdWsdHyqYhGN/hp1eKIRO+h0I3sqV
         V0esBoEKXZC3Ls5xpLUxgJEpVyIGcI3WHPiZ5E1JXKEtvFIkTlolkEbzJWUE7abpNRw0
         NfQfXNm4aS/1oU8166Dfx7sdVRwspr4655AruodaOTxmZFQi9o1IH7AIQVG2zWi77HEx
         WpBRMCO8RHnq57VjrW5mHBqgnqdIyJ4BZiw9j1KjFRk0UNJ++CZnqCgmZ1pMg9rrl24F
         a4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157026; x=1715761826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUJDG03Mjw+2XpovVR7RPuA7B88kWpbfRCW3yD4FtR4=;
        b=T+b4fh6dcFXD9qOpqjMTS/RUU0CYg5Qz4qQJC7s3Aj5tGRDece3O1z/yBmceCoXkVG
         QyqQpSC/d3xKVvLR6sohad3rwKHLGw9K3439Lf/rzJiMMt3jCJRf01w0ZuGHpEa+kBJF
         biSpmQbfN1xuDTkz0NZvOon2tVjNnOnSVe8SmoNqkotV/K7bFi/N5W/wiiBauKtbmd0q
         n9mhZ7hRqU3fDS7rmwvUMON2va1osrvJHhxvo5eVHueUfOv0JBopseUkcZX+h7V1efWz
         UTWBTMleQ2Sd29fdCSZXQbz7D5/0tDqE0Z6diKNwNrctmfyH5btShb0HAVZInUzdd98N
         LjYw==
X-Forwarded-Encrypted: i=1; AJvYcCV/sSyW+Y10F3asZUGkQ4kNny81yp3q4qmJ8PUWoxcwX8ibdDznvS8Y4NC62h9gj6F5LhK1YFtBEECDEGWYU/McXufXC3BhPBw1m/CV
X-Gm-Message-State: AOJu0YywPgdohbp/Zk6OwTnqMzG76nA/BduTv+Jt8keF9sCXyKbJSKR3
	cvqgDLcF6fTjPnCO2P4fl10qfx8Q89vOEw0HG+/J5aeaJbvE9fv6fA+iM+6cXKHTJ5oT47vpanN
	s1204bjErmqaFZm+/JDxwpZXnRu4=
X-Google-Smtp-Source: AGHT+IFpK2nFxJdMD/Vo1UFasc9ih/H09ABF9W1Bnr4S7XIG/z2E2Wiqwk8mVWA2bStZXhLjSXL1ulkmP1H5ESDLaCs=
X-Received: by 2002:a05:6122:2089:b0:4d4:2069:eafb with SMTP id
 71dfb90a1353d-4df692bfa01mr1784456e0c.9.1715157024145; Wed, 08 May 2024
 01:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com> <87y18kivny.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y18kivny.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 8 May 2024 20:30:12 +1200
Message-ID: <CAGsJ_4wnS8-vjVx4uuKwQ_=Y4g8EN58QJZ=cXR=cmuX1ZE84RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use swap_free_nr()
To: "Huang, Ying" <ying.huang@intel.com>, Christoph Hellwig <hch@infradead.org>, chrisl@kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, yosryahmed@google.com, 
	yuzhao@google.com, ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:58=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Ryan Roberts <ryan.roberts@arm.com> writes:
>
> > On 03/05/2024 01:50, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> To streamline maintenance efforts, we propose discontinuing the use of
> >> swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
> >> to 1. This adjustment offers the advantage of enabling batch processin=
g
> >> within kernel/power/swap.c. Furthermore, swap_free_nr() is designed wi=
th
> >> a bitmap consisting of only one long, resulting in overhead that can b=
e
> >> ignored for cases where nr equals 1.
> >>
> >> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Pavel Machek <pavel@ucw.cz>
> >> Cc: Len Brown <len.brown@intel.com>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> ---
> >>  include/linux/swap.h |  5 -----
> >>  kernel/power/swap.c  |  7 +++----
> >>  mm/memory.c          |  2 +-
> >>  mm/rmap.c            |  4 ++--
> >>  mm/shmem.c           |  4 ++--
> >>  mm/swapfile.c        | 19 +++++--------------
> >>  6 files changed, 13 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index d1d35e92d7e9..f03cb446124e 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t=
, gfp_t);
> >>  extern void swap_shmem_alloc(swp_entry_t);
> >>  extern int swap_duplicate(swp_entry_t);
> >>  extern int swapcache_prepare(swp_entry_t);
> >> -extern void swap_free(swp_entry_t);
> >
> > I wonder if it would be cleaner to:
> >
> > #define swap_free(entry) swap_free_nr((entry), 1)
> >
> > To save all the churn for the callsites that just want to pass a single=
 entry?
>
> I prefer this way.  Although I prefer inline functions.

Yes, using static inline is preferable. I've recently submitted
a checkpatch/codestyle for this, which can be found at:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
everything&id=3D39c58d5ed036
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
everything&id=3D8379bf0b0e1f5

Using static inline aligns with the established rule.

>
> Otherwise, LGTM.  Feel free to add
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks!

>
> in the future version.

I believe Christoph's vote leans towards simply removing swap_free_nr
and renaming it to swap_free, while adding a new parameter as follows.

void swap_free(swp_entry_t entry, int nr);
{
}

now I see Ryan and you prefer

static inline swap_free()
{
        swap_free_nr(...., 1)
}

Chris slightly favors discouraging the use of swap_free() without the
new parameter. Removing swap_free() can address this concern.

It seems that maintaining swap_free() and having it call swap_free_nr() wit=
h
a default value of 1 received the most support.

To align with free_swap_and_cache() and free_swap_and_cache_nr(),
I'll proceed with the "static inline" approach in the new version. Please
voice any objections you may have, Christoph, Chris.

>
> >>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >> @@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t s=
wp)
> >>      return 0;
> >>  }
> >>
> >> -static inline void swap_free(swp_entry_t swp)
> >> -{
> >> -}
> >> -
> >>  static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
> >>  {
> >>  }
> >> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> >> index 5bc04bfe2db1..6befaa88a342 100644
> >> --- a/kernel/power/swap.c
> >> +++ b/kernel/power/swap.c
> >> @@ -181,7 +181,7 @@ sector_t alloc_swapdev_block(int swap)
> >>      offset =3D swp_offset(get_swap_page_of_type(swap));
> >>      if (offset) {
> >>              if (swsusp_extents_insert(offset))
> >> -                    swap_free(swp_entry(swap, offset));
> >> +                    swap_free_nr(swp_entry(swap, offset), 1);
> >>              else
> >>                      return swapdev_block(swap, offset);
> >>      }
> >> @@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
> >>
> >>      while ((node =3D swsusp_extents.rb_node)) {
> >>              struct swsusp_extent *ext;
> >> -            unsigned long offset;
> >>
> >>              ext =3D rb_entry(node, struct swsusp_extent, node);
> >>              rb_erase(node, &swsusp_extents);
> >> -            for (offset =3D ext->start; offset <=3D ext->end; offset+=
+)
> >> -                    swap_free(swp_entry(swap, offset));
> >> +            swap_free_nr(swp_entry(swap, ext->start),
> >> +                         ext->end - ext->start + 1);
> >>
> >>              kfree(ext);
> >>      }
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index eea6e4984eae..f033eb3528ba 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4225,7 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>       * We're already holding a reference on the page but haven't mapp=
ed it
> >>       * yet.
> >>       */
> >> -    swap_free(entry);
> >> +    swap_free_nr(entry, 1);
> >>      if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>              folio_free_swap(folio);
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 087a79f1f611..39ec7742acec 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1865,7 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >>                              goto walk_done_err;
> >>                      }
> >>                      if (arch_unmap_one(mm, vma, address, pteval) < 0)=
 {
> >> -                            swap_free(entry);
> >> +                            swap_free_nr(entry, 1);
> >>                              set_pte_at(mm, address, pvmw.pte, pteval)=
;
> >>                              goto walk_done_err;
> >>                      }
> >> @@ -1873,7 +1873,7 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >>                      /* See folio_try_share_anon_rmap(): clear PTE fir=
st. */
> >>                      if (anon_exclusive &&
> >>                          folio_try_share_anon_rmap_pte(folio, subpage)=
) {
> >> -                            swap_free(entry);
> >> +                            swap_free_nr(entry, 1);
> >>                              set_pte_at(mm, address, pvmw.pte, pteval)=
;
> >>                              goto walk_done_err;
> >>                      }
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index fa2a0ed97507..bfc8a2beb24f 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -1836,7 +1836,7 @@ static void shmem_set_folio_swapin_error(struct =
inode *inode, pgoff_t index,
> >>       * in shmem_evict_inode().
> >>       */
> >>      shmem_recalc_inode(inode, -1, -1);
> >> -    swap_free(swap);
> >> +    swap_free_nr(swap, 1);
> >>  }
> >>
> >>  /*
> >> @@ -1927,7 +1927,7 @@ static int shmem_swapin_folio(struct inode *inod=
e, pgoff_t index,
> >>
> >>      delete_from_swap_cache(folio);
> >>      folio_mark_dirty(folio);
> >> -    swap_free(swap);
> >> +    swap_free_nr(swap, 1);
> >>      put_swap_device(si);
> >>
> >>      *foliop =3D folio;
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index ec12f2b9d229..ddcd0f24b9a1 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_st=
ruct *p, swp_entry_t entry)
> >>      swap_range_free(p, offset, 1);
> >>  }
> >>
> >> -/*
> >> - * Caller has made sure that the swap device corresponding to entry
> >> - * is still around or has not been recycled.
> >> - */
> >> -void swap_free(swp_entry_t entry)
> >> -{
> >> -    struct swap_info_struct *p;
> >> -
> >> -    p =3D _swap_info_get(entry);
> >> -    if (p)
> >> -            __swap_entry_free(p, entry);
> >> -}
> >> -
> >>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> >>              unsigned long offset, int nr_pages)
> >>  {
> >> @@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_in=
fo_struct *sis,
> >>      unlock_cluster_or_swap_info(sis, ci);
> >>  }
> >>
> >> +/*
> >> + * Caller has made sure that the swap device corresponding to entry
> >> + * is still around or has not been recycled.
> >> + */
> >>  void swap_free_nr(swp_entry_t entry, int nr_pages)
> >>  {
> >>      int nr;
> >> @@ -1930,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma,=
 pmd_t *pmd,
> >>              new_pte =3D pte_mkuffd_wp(new_pte);
> >>  setpte:
> >>      set_pte_at(vma->vm_mm, addr, pte, new_pte);
> >> -    swap_free(entry);
> >> +    swap_free_nr(entry, 1);
> >>  out:
> >>      if (pte)
> >>              pte_unmap_unlock(pte, ptl);
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

