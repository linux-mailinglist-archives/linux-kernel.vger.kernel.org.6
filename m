Return-Path: <linux-kernel+bounces-275816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CC948A52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B1B1F21737
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDA16A940;
	Tue,  6 Aug 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpCh4ruo"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA268166F0C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930147; cv=none; b=Ei32XkjzCYEAcf+wVS99nYsLaXdBq0lwTA2BPymQWNfsNuWaT39nvODx09rKdYiYMebtGO/RL1/0C63wiGSIF4VedBTTskQ+e9gWYsEA7S8fzZgvbxFw/Cv7vbGvaXC8eHMafOFj5deWhPEhqccU2UdJTsru6sBKvq2WNqC3jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930147; c=relaxed/simple;
	bh=aCKwki1FBCu5e7ALCBhU9W3oxmgofEN0w9U+mCx/wCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyFl+nJWudQVMLYMr7soNi4KIMPtTta0YW9ki7cIIiqwsRYXen5ifol0hPCWOio7ZbHnsba3Zz8L9P9o/PkydH+HUH+YfDSPgdzIInHaRgkL9qrhXIuw22RArjCmoPajXL7hMqyVT+tmZ4ieKBJZMj3e/+i5Sr5ThA6JNE1XLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpCh4ruo; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4928e347ac5so80576137.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722930144; x=1723534944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z72ZH5WstJ8PQ6OG5yNQlTG29Wc6jbLbmu7WIcbAjCQ=;
        b=JpCh4ruonEWB0RO1ksbZh6enhtYr67SOccBorhB+LYCXBi6IUyW3/rYvj/YSndAlIt
         IggnQxgNhVDRwmmwV1u/lJLV20PNQ/gM//+NEkSvO+SScmTm97pwZqNny/DIfq8wcuLf
         36B8a/HsUveJrG2reFBciOc5/TOBJsnK22FeERpleShV4teL6Wc8FRq73/NAsZLuPHSU
         FtLtxWGIuYgsiLB6Y8BcCf3C9IMS2Fg7I45gsWQG5d1j7HiBLNsNsSpzeur5ElhY4/m8
         89tG0x/pnIbLSJsHvPBK193Qtd6ErOomrl1VPFwoeieMtZw2XcV4xJGujdibtBxpMdEt
         OE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722930144; x=1723534944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z72ZH5WstJ8PQ6OG5yNQlTG29Wc6jbLbmu7WIcbAjCQ=;
        b=NW+5FKTohKEFYPLme1WGcQV3Cqbpj+EvS4xW1GtdTzdJCDTtxUN5gqkeZkgX/62I4e
         TtspNs/JN0xoMnkhCAY3Lywluvr5Z5wP49tQEur15QrrqBY4zL2Db5welOQ5dnbAS0ca
         avjHkZ/WzxtZSOKzsIhhbXsLA6H6fBdxc6Q5R+uKkk/RRAEZzSCZO+xK7l574WXxaOuE
         p+QAwabJ7dcy4Hgamaa7zeRazQR+IsWZBwCjnrd3eYRpiMSO1urLfxTp2dr9n0fM/NAi
         k84sb0aH3qlk6gQV96ye1eYckCCdiKTpY//bb7T6TX6WOJl5xveAJj6XSglmVmmm8AyI
         My/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7zYmQ+TB5CWrh/tsnQPcmJE23nTn3BXfOYEfWL8MEQFk5nW8VLSq1buzUcWui4AVEHgTvZDuuG/Yuuzpd6OglV14S1fMCzfaIou18
X-Gm-Message-State: AOJu0YymHhBK1kXqKdJqqqZ9sg1fABtBSPtLM1UWqYvM9SL1AHFXbs3T
	hEMAv3vYUXgMUxWM1ibIGzTLvgBQYpCHN2oKjiOHOTiqwpDbutAbmKg8ovl+OvzaqF8blrcMco9
	u8oBGFGaSSgp1FiNfoymI93vAF/k=
X-Google-Smtp-Source: AGHT+IECDCtz4JVrjWyfHJK+FGbR5G0jM+xZkmlR7TiDbL+YPPYhJ4hKuUqFe73tLk04APgc5J7pofvlF6Hve8rxjA8=
X-Received: by 2002:a05:6102:c03:b0:48f:e8f9:5d9f with SMTP id
 ada2fe7eead31-4945bddc51fmr11298182137.7.1722930144277; Tue, 06 Aug 2024
 00:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2ea5b52-311d-4c6c-a59d-9982b8723738@vivo.com>
In-Reply-To: <b2ea5b52-311d-4c6c-a59d-9982b8723738@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Aug 2024 14:38:13 +0800
Message-ID: <CAGsJ_4yKEGmXKd=rCavt6WGokjGg+w2Eky=PzP0b2562NKhbRA@mail.gmail.com>
Subject: Re: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
To: 20240806012409.61962-1-21cnbao@gmail.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Next time, please use "> "  and ">> " etc to reply to emails.

On Tue, Aug 6, 2024 at 3:23=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> w=
rote:
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
>   #include <sys/mman.h>
>   #include <sys/time.h>
>   #include <stdlib.h>
>
>   unsigned long long tv_to_ms(struct timeval tv)
>   {
>          return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>   }
>
>   main()
>   {
>          struct timeval tv_b, tv_e;
>          int i;
>   #define SIZE 1024*1024*1024
>          void *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>          if (!p) {
>                  perror("fail to get memory");
>                  exit(-1);
>          }
>
>          madvise(p, SIZE, MADV_HUGEPAGE);
>          memset(p, 0x11, SIZE); /* write to get mem */
>
>          madvise(p, SIZE, MADV_PAGEOUT);
>
>          gettimeofday(&tv_b, NULL);
>          munmap(p, SIZE);
>          gettimeofday(&tv_e, NULL);
>
>          printf("munmap in bandwidth: %ld bytes/ms\n",
>                          SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>   }
>
> The result is as below (munmap bandwidth):
>                  mm-unstable  mm-unstable-with-patch
>     round1       21053761      63161283
>     round2       21053761      63161283
>     round3       21053761      63161283
>     round4       20648881      67108864
>     round5       20648881      67108864
>
> munmap bandwidth becomes 3X faster.
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
>   mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ea023fc25d08..ed872a186e81 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struc=
t *si,
>         return true;
>   }
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
> +               if (*map & SWAP_HAS_CACHE)
> +                       cached =3D true;
> +       } while (++map < map_end);
> +
> +       *has_cache =3D cached;
> +       return true;
> +}
> +
>   /*
>    * returns number of pages in the folio that backs the swap entry. If p=
ositive,
>    * the folio was reclaimed. If negative, the folio was not reclaimed. I=
f 0, no
> @@ -1469,6 +1488,39 @@ static unsigned char __swap_entry_free(struct swap=
_info_struct *p,
>         return usage;
>   }
>
> +static bool try_batch_swap_entries_free(struct swap_info_struct *p,
> +               swp_entry_t entry, int nr, bool *any_only_cache)
> +{
> +       unsigned long offset =3D swp_offset(entry);
> +       struct swap_cluster_info *ci;
> +       bool has_cache =3D false;
> +       bool can_batch;
> +       int i;
> +
> +       /* cross into another cluster */
> +       if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> +               return false;
> My understand of mTHP swap entries alloced by by cluster_alloc_swap()
> is that they belong to the same cluster in the same swapinfo , so
> theoretically it will not appear for
> (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)?
> Can you help confirm?

zap_pte_range() has no concept of folios (mTHP) as folios could have
gone. you could have the case:
folio1:  last 16 slots of cluster1
folio2:  first 16 slots of cluster2.
folio1 and folio2 are within the same PMD and virtually contiguous
before they are unmapped.

when both folio1 and folio2 have gone, zap_pte_range() 's
nr =3D swap_pte_batch(pte, max_nr, ptent);

nr will be 32.  "mTHP swap entries alloced by by cluster_alloc_swap() belon=
g
to the same cluster" is correct, but when you zap_pte_range(), your mTHPs
could have gone.

>
> +       ci =3D lock_cluster_or_swap_info(p, offset);
> +       can_batch =3D swap_is_last_map(p, offset, nr, &has_cache);
> +       if (can_batch) {
> +               for (i =3D 0; i < nr; i++)
> +                       WRITE_ONCE(p->swap_map[offset + i], SWAP_HAS_CACH=
E);
> +       }
> +       unlock_cluster_or_swap_info(p, ci);
> +
> +       /* all swap_maps have count=3D=3D1 and have no swapcache */
> +       if (!can_batch)
> +               goto out;
> +       if (!has_cache) {
> +               spin_lock(&p->lock);
> +               swap_entry_range_free(p, entry, nr);
> +               spin_unlock(&p->lock);
> +       }
> +       *any_only_cache =3D has_cache;
> +out:
> +       return can_batch;
> +}
> +
>   /*
>    * Drop the last HAS_CACHE flag of swap entries, caller have to
>    * ensure all entries belong to the same cgroup.
> @@ -1797,6 +1849,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>         bool any_only_cache =3D false;
>         unsigned long offset;
>         unsigned char count;
> +       bool batched;
>
>         if (non_swap_entry(entry))
>                 return;
> @@ -1808,6 +1861,13 @@ void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr)
>         if (WARN_ON(end_offset > si->max))
>                 goto out;
>
> +       if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) =
=3D=3D 1)) {
> +               batched =3D try_batch_swap_entries_free(si, entry, nr,
> +                                               &any_only_cache);
> +               if (batched)
> +                       goto reclaim;
> +       }
> The mTHP swap entries are batch freed as a whole directly by skipping
> percpu swp_slots caches, instead of freeing every swap entry separately,
> which can accelerate the mTHP swap entries release. I think it is
> valuable.

yes. I have seen 3X performance improvement.

>
> +
>         /*
>          * First free all entries in the range.
>          */
> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>                 }
>         }
>
> +reclaim:
>         /*
>          * Short-circuit the below loop if none of the entries had their
>          * reference drop to zero.
> --
> 2.34.1
>
> Thanks
> Zhiguo
>
>
>

Thanks
Barry

