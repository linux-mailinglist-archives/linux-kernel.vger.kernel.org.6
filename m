Return-Path: <linux-kernel+bounces-276967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C62949A81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946BF281D58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC916A95E;
	Tue,  6 Aug 2024 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfCTMNpV"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13ED2AF12
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980939; cv=none; b=oF6/HPiEsu5nINV6s/YAsGbOfmICzKGIUn3xU6x/YIyWbrNwoxBR40Bh1WEoS3ow6mp5rX0vYp1s4uWTTdCgv3lDNTlz8JY36CXOZF8/92fTmWRa97wD5sbT7Q1Tll4KLikSjEweOHQZB9h+njw4vVYGJd/EqQbAmE8oZ1jemOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980939; c=relaxed/simple;
	bh=tSebhSjpGZDkCZrttA0QKnA5FmhLf8/yIAGCDJlW+70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIKs0cmNv9b1cieOmLgWjmVlWsuixn2T4/nWr3x0TlkPx3fjg4P0Q9zingciK5VH5/gsafko+fuOJYB0my4okiHQAyAxO3EnGWDJkN8u9udNp8d4ypB0Tx3UDdJ9IM+nScCcz8fItpoImpgbSiyvWugQGrRZZ55djf7N1Ms4Zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfCTMNpV; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f6b67d9608so521745e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722980936; x=1723585736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl3WXMCZeTktAWupa/M0ETvAw989O5QcqEa5h6bH4xk=;
        b=VfCTMNpV3e6MgrFDuBSTszqOiUdElvhVZZMTKSwtGoAiO/ydPRfc439EPWruToAyho
         5xtkDEgOcl3e8p2uXpfuRQEvySUPtDos4aZ6hy1VZoZCIWeWots5pqPIkzD776OLBHpJ
         Jo6TK1QghjbXK5bHgu6z/EDkyqJyuYYT14vVu5s0utwdZYRx4gVYH4FAd+rUEyTMJ6xZ
         5VTRDkWGHaVG45QBy9XKRcEkzv3TgNNne0u4KZgw3UeQRIB33C97WugxMIoOsflZf378
         qyf/n82KMxtE1fRuAYJKQ3rI3VNnwL0mNpHHfmVBLSjtalsMCicDazQQ8/Cz79IbuIVq
         /cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980936; x=1723585736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl3WXMCZeTktAWupa/M0ETvAw989O5QcqEa5h6bH4xk=;
        b=Sbi+yzlKCbXcn0eelwAzO3k7eIKzYTMJomXhxxBGC4dCn7XDzangfu6pHFtcx+5P1A
         M7Tx48t22hNuIrrAAuZa7eZQZED2z+883FAB00QInXKlcEIHAM1isVNIbp+Jc5F81W8A
         b803lkNiRe2ZPgLTA+aJuv7aEI3aVcjr3zzkuYFTdlUQFsgAcTb7jjp0oUb4Ydh9haUu
         qHOjvuHfP8dNnnrC0lbNOK2JITtywlubexSFtAKhg4FQGWSDHJq/bKhhAK5KspgsiUF2
         mXYOnGnfg2ZxbbM7EKPwuuHxIZZYK0WxqVZTa/vlp1LMRj7ggrH+SuikWjE5LeZATPPy
         V+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi++LVOOmtF3Io5IE06XZBnPJDNYRoNl0w2D/7G/CWWaoKQr1avGm0vf3Ib+34HuHESHV+hti3RHc6tDurmbj5mjk03UBY444GK4zp
X-Gm-Message-State: AOJu0Yz7llR2qFD1Iy/osnCQqUIrXgApn8hi/auwIAqB7vAcVlLAI4dQ
	1Nud1fml80LPrp/R3e3avBhGBm+e2hU9ByWOM7wEPP2w1MIrLJ5h5XpEczIRU8HNFQ22CYd+rdK
	unyavdD67oBREZrEzFt6ohUOTjf8=
X-Google-Smtp-Source: AGHT+IE1DKusDGsNsw3fyn9EbpqmMm7iO45Fw1Zxx2sqpgQjMjDKIKxDQzh7SgL9nIyBnOvX3AySX6YQQbJxz8j/gnk=
X-Received: by 2002:a05:6122:3282:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-4f89ffc8eaemr18530549e0c.9.1722980936520; Tue, 06 Aug 2024
 14:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806012409.61962-1-21cnbao@gmail.com> <1e6bcaf2-7c48-4be0-b101-ec2ddc4098ce@redhat.com>
In-Reply-To: <1e6bcaf2-7c48-4be0-b101-ec2ddc4098ce@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 04:44:44 +0800
Message-ID: <CAGsJ_4xR949nPauJ4kZpcg3cRwvcrHHWU7oSazpfGR2Tv5XNTA@mail.gmail.com>
Subject: Re: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.08.24 03:24, Barry Song wrote:
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
> >   #include <sys/mman.h>
> >   #include <sys/time.h>
> >   #include <stdlib.h>
> >
> >   unsigned long long tv_to_ms(struct timeval tv)
> >   {
> >          return tv.tv_sec * 1000 + tv.tv_usec / 1000;
> >   }
> >
> >   main()
> >   {
> >          struct timeval tv_b, tv_e;
> >          int i;
> >   #define SIZE 1024*1024*1024
> >          void *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >          if (!p) {
> >                  perror("fail to get memory");
> >                  exit(-1);
> >          }
> >
> >          madvise(p, SIZE, MADV_HUGEPAGE);
> >          memset(p, 0x11, SIZE); /* write to get mem */
> >
> >          madvise(p, SIZE, MADV_PAGEOUT);
> >
> >          gettimeofday(&tv_b, NULL);
> >          munmap(p, SIZE);
> >          gettimeofday(&tv_e, NULL);
> >
> >          printf("munmap in bandwidth: %ld bytes/ms\n",
> >                          SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
> >   }
> >
> > The result is as below (munmap bandwidth):
> >                  mm-unstable  mm-unstable-with-patch
> >     round1       21053761      63161283
> >     round2       21053761      63161283
> >     round3       21053761      63161283
> >     round4       20648881      67108864
> >     round5       20648881      67108864
> >
> > munmap bandwidth becomes 3X faster.
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
> >   mm/swapfile.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 61 insertions(+)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index ea023fc25d08..ed872a186e81 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_str=
uct *si,
> >       return true;
> >   }
> >
> > +static bool swap_is_last_map(struct swap_info_struct *si,
> > +                           unsigned long offset, int nr_pages,
> > +                           bool *has_cache)
> > +{
> > +     unsigned char *map =3D si->swap_map + offset;
> > +     unsigned char *map_end =3D map + nr_pages;
> > +     bool cached =3D false;
> > +
> > +     do {
> > +             if ((*map & ~SWAP_HAS_CACHE) !=3D 1)
> > +                     return false;
> > +             if (*map & SWAP_HAS_CACHE)
> > +                     cached =3D true;
> > +     } while (++map < map_end);
> > +
> > +     *has_cache =3D cached;
> > +     return true;
> > +}
> > +
> >   /*
> >    * returns number of pages in the folio that backs the swap entry. If=
 positive,
> >    * the folio was reclaimed. If negative, the folio was not reclaimed.=
 If 0, no
> > @@ -1469,6 +1488,39 @@ static unsigned char __swap_entry_free(struct sw=
ap_info_struct *p,
> >       return usage;
> >   }
> >
> > +static bool try_batch_swap_entries_free(struct swap_info_struct *p,
>
> Why call it "p" here and not "si" like in the other code you are touching=
?

that is because I found other _free_ functions are all using "p":

static unsigned char __swap_entry_free(struct swap_info_struct *p,
      swp_entry_t entry)
{
...
}

static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
{
...
}

For sure I can move from "p" to "si".

>
> > +             swp_entry_t entry, int nr, bool *any_only_cache)
> > +{
> > +     unsigned long offset =3D swp_offset(entry);
> > +     struct swap_cluster_info *ci;
> > +     bool has_cache =3D false;
> > +     bool can_batch;
> > +     int i;
> > +
> > +     /* cross into another cluster */
> > +     if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> > +             return false;
> > +     ci =3D lock_cluster_or_swap_info(p, offset);
> > +     can_batch =3D swap_is_last_map(p, offset, nr, &has_cache);
> > +     if (can_batch) {
> > +             for (i =3D 0; i < nr; i++)
> > +                     WRITE_ONCE(p->swap_map[offset + i], SWAP_HAS_CACH=
E);
> > +     }
> > +     unlock_cluster_or_swap_info(p, ci);
> > +
> > +     /* all swap_maps have count=3D=3D1 and have no swapcache */
> > +     if (!can_batch)
> > +             goto out;
> > +     if (!has_cache) {
> > +             spin_lock(&p->lock);
> > +             swap_entry_range_free(p, entry, nr);
> > +             spin_unlock(&p->lock);
> > +     }
> > +     *any_only_cache =3D has_cache;
> > +out:
> > +     return can_batch;
> > +}
> > +
> >   /*
> >    * Drop the last HAS_CACHE flag of swap entries, caller have to
> >    * ensure all entries belong to the same cgroup.
> > @@ -1797,6 +1849,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, in=
t nr)
> >       bool any_only_cache =3D false;
> >       unsigned long offset;
> >       unsigned char count;
> > +     bool batched;
> >
> >       if (non_swap_entry(entry))
> >               return;
> > @@ -1808,6 +1861,13 @@ void free_swap_and_cache_nr(swp_entry_t entry, i=
nt nr)
> >       if (WARN_ON(end_offset > si->max))
> >               goto out;
> >
> > +     if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) =
=3D=3D 1)) {
> > +             batched =3D try_batch_swap_entries_free(si, entry, nr,
> > +                                             &any_only_cache);
> > +             if (batched)
> > +                     goto reclaim;
> > +     }
> > +
>
> I'm wondering if we could find a way to clean this up to achieve here:
>
>
> if (WARN_ON(end_offset > si->max))
>         goto out;
>
> /*
>   * First free all entries in the range.$
>   */
> any_only_cache =3D __free_swap_entries(si, entry, nr);
>
> /*
>   * Short-circuit the below loop if none of the entries had their
>   * reference drop to zero.
>   */
> if (!any_only_cache)
>         goto out;
>
>
>
>
> Whereby move the fallback loop in that new function
>
> static bool __free_swap_entries(struct swap_info_struct *si,
>                 swp_entry_t entry, int nr)
> {
>         const unsigned long start_offset =3D swp_offset(entry);
>         const unsigned long end_offset =3D start_offset + nr;
>         bool any_only_cache =3D false;
>
>         if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) =
=3D=3D 1)) {
>                 [... what try_batch_swap_entries_free() would do ...]
>         }
>
> fallback:
>         for (offset =3D start_offset; offset < end_offset; offset++) {
>                 if (data_race(si->swap_map[offset])) {
>                 [... what the fallback code would do ...]
>         }
>         return any_only_cache;
> }
>
>

good suggestion. will do this in v2.

> >       /*
> >        * First free all entries in the range.
> >        */
> > @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, in=
t nr)
> >               }
> >       }
> >
> > +reclaim:
> >       /*
> >        * Short-circuit the below loop if none of the entries had their
> >        * reference drop to zero.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

