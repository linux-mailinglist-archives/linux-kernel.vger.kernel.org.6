Return-Path: <linux-kernel+bounces-185759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029858CBA56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251B61C20A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C46757F3;
	Wed, 22 May 2024 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3rKumOD"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7B360
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351948; cv=none; b=VTXS02agY5fVxP5D5JERZTt/P49NQWu4H5+EHwQSUvWH1gLcAzDEEEmpiArvPEBgZvEAXPqjUf5Eg2IzYAY55Fb4Ey41zU/JbV7JlPz/LfeMcMKm8M+vzaJM1o0kC6rlPzdiWtiOpivjH/3k1tySTDXelcFeez9qInadnI/W0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351948; c=relaxed/simple;
	bh=Ou6X6m/2kefLRsGNAXTUX7d5rpezBW1+XAMIepgdWfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnAezpcsln/Uyyb16uzhD1pn1GI9I+3XQdoc/K1bTIXSPKyzIpc3xY1DWvR5wF12/LAvRebJVTpRz8Ho6QT1XnxVIBMjFX1P+TXTRWpZ41xuRlNox2yDa9FzHrBsE+W0HheQROlbonnK1ASkrN0MaLKtnq5SpZL4bnuH4RwqxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3rKumOD; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47eef2569fbso19401137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716351945; x=1716956745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoEyaON6bOHu//PM+k5sLus7VRvUa5Mvysv5QRluRoA=;
        b=e3rKumOD2aKESz4EnfYu21BSbUkpgAqSsFBXxW5mgCXMgd9kAYpFhtFsdlrVKv2FGA
         2w4uYPcq3rusvIY73fy/Q8uhb1ga0JRGo2jRtPnXAg9a4gsegalRzV6b/5XWCqhBHlKO
         2a0wWBbl5hbnIEh7vhvdEKsHm9Rpw4inH00sp+11ABFyXwcX6BpYZdI3l+IgS/Zy5DpH
         w6B9ewy4diIWS0RRkVePHRzIjBWwnXVSJmdv1RLHHWCKXlieeIUMFeF6s5qlgZDqdEpp
         LLTlHr+vb98eMPgo+xDGfd7bh7KveQD3izltPPQm7kstLGDfovV5Pgm6p+hk0wYadiT3
         F+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716351945; x=1716956745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoEyaON6bOHu//PM+k5sLus7VRvUa5Mvysv5QRluRoA=;
        b=dZeoOgXY+enzIlK6PNUTAUiHh74pkqWvLfajuGFVnY5mKK/YjFhQO/BwpYT3zEHI9K
         /yYelPHA4VlE0f7ugPv7HWcMcSTpTwLkIW6oLwZWtAMX/Mtexr9sIrCSyk19JE3pfFSp
         sIOPzw6gXdwkQ0kUdOGm2YmXsThvNE5CQNqLeh9O0COG8N5N5A/OceRHBoblU0tTcA6j
         FVxMdAsLkHamaFqazWjYnqiiuuIBiEDuHe37c1x3BPnnE95+A4IF+CATPmDxGP9Fzcld
         RtHFt0pprXIN1azm74Esfx61RrVfdG0z3nVzWaicD4iZBtUCCPfgWC5wzmsPUCAtPvwy
         aM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDov+ws7QN+iRRZ6713EAhEnCyiBbIRjsOaN0Uc9ziU8eizlRI+ejWCwlONnxciBgAHbTN1lSTkWeO1r3qvqqfG+kkxFD2khezFQgc
X-Gm-Message-State: AOJu0YxJEuQah8/TXVBShBiMsJW5gFqXLng+tPGr7GaPunB+7IspB0Rw
	430+rbROdyx+Q1OpXlixaQ9UxLlHlqfII+7+KhO6bxnhStuWT8cxygxruMpibnOnLB1g0lbmtEk
	578/YTHjVEK/QquTaEz7FSQ3ipAhNwHcR
X-Google-Smtp-Source: AGHT+IE7E4VShkf6E8Ol3D0jJOJt63Se/Y23/bzstsm9OfyWFH9XAkJ45T3xXUI0XhXdqzSZ6gHhUmEnqnFy3fN6ZXU=
X-Received: by 2002:a67:e8cd:0:b0:47f:1bc9:37b7 with SMTP id
 ada2fe7eead31-4890a12b43cmr932120137.2.1716351941877; Tue, 21 May 2024
 21:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com> <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
In-Reply-To: <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 22 May 2024 12:25:30 +0800
Message-ID: <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
To: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brendan,

On Tue, May 21, 2024 at 8:57=E2=80=AFPM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> These fields are written by memory hotplug under mem_hotplug_lock but
> read without any lock. It seems like reader code is robust against the
> value being stale or "from the future", but we also need to account
> for:
>
> 1. Load/store tearing (according to Linus[1], this really happens,
>    even when everything is aligned as you would hope).
>
> 2. Invented loads[2] - the compiler can spill and re-read these fields
>    ([2] calls this "invented loads") and assume that they have not
>    changed.
>
> Note we don't need READ_ONCE in paths that have the mem_hotplug_lock
> for write, but we still need WRITE_ONCE to prevent store-tearing.
>
> [1] https://lore.kernel.org/all/CAHk-=3Dwj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kG=
yfH3WFEoH+YQ@mail.gmail.com/T/#u
>     As discovered via the original big-bad article[2]
> [2] https://lwn.net/Articles/793253/
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  include/linux/mmzone.h | 14 ++++++++++----
>  mm/compaction.c        |  2 +-
>  mm/memory_hotplug.c    | 20 ++++++++++++--------
>  mm/mm_init.c           |  2 +-
>  mm/page_alloc.c        |  2 +-
>  mm/show_mem.c          |  8 ++++----
>  mm/vmstat.c            |  4 ++--
>  7 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 194ef7fed9d6..bdb3be76d10c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1018,11 +1018,13 @@ static inline unsigned long zone_cma_pages(struct=
 zone *zone)
>  #endif
>  }
>
> +/* This is unstable unless you hold mem_hotplug_lock. */
>  static inline unsigned long zone_end_pfn(const struct zone *zone)
>  {
> -       return zone->zone_start_pfn + zone->spanned_pages;
> +       return zone->zone_start_pfn + READ_ONCE(zone->spanned_pages);
>  }
>
> +/* This is unstable unless you hold mem_hotplug_lock. */
>  static inline bool zone_spans_pfn(const struct zone *zone, unsigned long=
 pfn)
>  {
>         return zone->zone_start_pfn <=3D pfn && pfn < zone_end_pfn(zone);
> @@ -1033,9 +1035,10 @@ static inline bool zone_is_initialized(struct zone=
 *zone)
>         return zone->initialized;
>  }
>
> +/* This is unstable unless you hold mem_hotplug_lock. */
>  static inline bool zone_is_empty(struct zone *zone)
>  {
> -       return zone->spanned_pages =3D=3D 0;
> +       return READ_ONCE(zone->spanned_pages) =3D=3D 0;
>  }
>
>  #ifndef BUILD_VDSO32_64
> @@ -1485,10 +1488,13 @@ static inline bool managed_zone(struct zone *zone=
)
>         return zone_managed_pages(zone);
>  }
>
> -/* Returns true if a zone has memory */
> +/*
> + * Returns true if a zone has memory.
> + * This is unstable unless you old mem_hotplug_lock.
> + */
>  static inline bool populated_zone(struct zone *zone)
>  {
> -       return zone->present_pages;
> +       return READ_ONCE(zone->present_pages);
>  }
>
>  #ifdef CONFIG_NUMA
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e731d45befc7..b8066d1fdcf5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2239,7 +2239,7 @@ static unsigned int fragmentation_score_zone_weight=
ed(struct zone *zone)
>  {
>         unsigned long score;
>
> -       score =3D zone->present_pages * fragmentation_score_zone(zone);
> +       score =3D READ_ONCE(zone->present_pages) * fragmentation_score_zo=
ne(zone);
>         return div64_ul(score, zone->zone_pgdat->node_present_pages + 1);
>  }
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 431b1f6753c0..71b5e3d314a2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -463,6 +463,8 @@ static void shrink_zone_span(struct zone *zone, unsig=
ned long start_pfn,
>         int nid =3D zone_to_nid(zone);
>
>         if (zone->zone_start_pfn =3D=3D start_pfn) {
> +               unsigned long old_end_pfn =3D zone_end_pfn(zone);
> +
>                 /*
>                  * If the section is smallest section in the zone, it nee=
d
>                  * shrink zone->zone_start_pfn and zone->zone_spanned_pag=
es.
> @@ -470,13 +472,13 @@ static void shrink_zone_span(struct zone *zone, uns=
igned long start_pfn,
>                  * for shrinking zone.
>                  */
>                 pfn =3D find_smallest_section_pfn(nid, zone, end_pfn,
> -                                               zone_end_pfn(zone));
> +                                               old_end_pfn);
>                 if (pfn) {
> -                       zone->spanned_pages =3D zone_end_pfn(zone) - pfn;
> +                       WRITE_ONCE(zone->spanned_pages, old_end_pfn - pfn=
);
>                         zone->zone_start_pfn =3D pfn;
>                 } else {
>                         zone->zone_start_pfn =3D 0;
> -                       zone->spanned_pages =3D 0;
> +                       WRITE_ONCE(zone->spanned_pages, 0);
>                 }
>         } else if (zone_end_pfn(zone) =3D=3D end_pfn) {
>                 /*
> @@ -488,10 +490,11 @@ static void shrink_zone_span(struct zone *zone, uns=
igned long start_pfn,
>                 pfn =3D find_biggest_section_pfn(nid, zone, zone->zone_st=
art_pfn,
>                                                start_pfn);
>                 if (pfn)
> -                       zone->spanned_pages =3D pfn - zone->zone_start_pf=
n + 1;
> +                       WRITE_ONCE(zone->spanned_pages,
> +                                  pfn - zone->zone_start_pfn + 1);
>                 else {
>                         zone->zone_start_pfn =3D 0;
> -                       zone->spanned_pages =3D 0;
> +                       WRITE_ONCE(zone->spanned_pages, 0);
>                 }
>         }
>  }
> @@ -710,7 +713,8 @@ static void __meminit resize_zone_range(struct zone *=
zone, unsigned long start_p
>         if (zone_is_empty(zone) || start_pfn < zone->zone_start_pfn)
>                 zone->zone_start_pfn =3D start_pfn;
>
> -       zone->spanned_pages =3D max(start_pfn + nr_pages, old_end_pfn) - =
zone->zone_start_pfn;
> +       WRITE_ONCE(zone->spanned_pages,
> +                  max(start_pfn + nr_pages, old_end_pfn) - zone->zone_st=
art_pfn);
>  }
>
>  static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsi=
gned long start_pfn,
> @@ -795,7 +799,7 @@ static void auto_movable_stats_account_zone(struct au=
to_movable_stats *stats,
>                                             struct zone *zone)
>  {
>         if (zone_idx(zone) =3D=3D ZONE_MOVABLE) {
> -               stats->movable_pages +=3D zone->present_pages;
> +               stats->movable_pages +=3D READ_ONCE(zone->present_pages);
>         } else {
>                 stats->kernel_early_pages +=3D zone->present_early_pages;
>  #ifdef CONFIG_CMA
> @@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page *page, s=
truct memory_group *group,
>          */
>         if (early_section(__pfn_to_section(page_to_pfn(page))))
>                 zone->present_early_pages +=3D nr_pages;
> -       zone->present_pages +=3D nr_pages;
> +       WRITE_ONCE(zone->present_pages, zone->present_pages + nr_pages);

I'm not sure that using the WRITE_ONCE() wrapper would prevent load tearing
on 'zone->present_pages', but it's probably just me overthinking it :)

Thanks,
Lance

>         zone->zone_pgdat->node_present_pages +=3D nr_pages;
>
>         if (group && movable)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index c725618aeb58..ec66f2eadb95 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1540,7 +1540,7 @@ void __ref free_area_init_core_hotplug(struct pglis=
t_data *pgdat)
>         for (z =3D 0; z < MAX_NR_ZONES; z++) {
>                 struct zone *zone =3D pgdat->node_zones + z;
>
> -               zone->present_pages =3D 0;
> +               WRITE_ONCE(zone->present_pages, 0);
>                 zone_init_internals(zone, z, nid, 0);
>         }
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5116a2b9ea6e..1eb9000ec7d7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5728,7 +5728,7 @@ __meminit void zone_pcp_init(struct zone *zone)
>
>         if (populated_zone(zone))
>                 pr_debug("  %s zone: %lu pages, LIFO batch:%u\n", zone->n=
ame,
> -                        zone->present_pages, zone_batchsize(zone));
> +                        READ_ONCE(zone->present_pages), zone_batchsize(z=
one));
>  }
>
>  void adjust_managed_page_count(struct page *page, long count)
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index bdb439551eef..667680a6107b 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -337,7 +337,7 @@ static void show_free_areas(unsigned int filter, node=
mask_t *nodemask, int max_z
>                         K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
>                         K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
>                         K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
> -                       K(zone->present_pages),
> +                       K(READ_ONCE(zone->present_pages)),
>                         K(zone_managed_pages(zone)),
>                         K(zone_page_state(zone, NR_MLOCK)),
>                         K(zone_page_state(zone, NR_BOUNCE)),
> @@ -407,11 +407,11 @@ void __show_mem(unsigned int filter, nodemask_t *no=
demask, int max_zone_idx)
>
>         for_each_populated_zone(zone) {
>
> -               total +=3D zone->present_pages;
> -               reserved +=3D zone->present_pages - zone_managed_pages(zo=
ne);
> +               total +=3D READ_ONCE(zone->present_pages);
> +               reserved +=3D READ_ONCE(zone->present_pages) - zone_manag=
ed_pages(zone);
>
>                 if (is_highmem(zone))
> -                       highmem +=3D zone->present_pages;
> +                       highmem +=3D READ_ONCE(zone->present_pages);
>         }
>
>         printk("%lu pages RAM\n", total);
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8507c497218b..5a9c4b5768e5 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1708,8 +1708,8 @@ static void zoneinfo_show_print(struct seq_file *m,=
 pg_data_t *pgdat,
>                    min_wmark_pages(zone),
>                    low_wmark_pages(zone),
>                    high_wmark_pages(zone),
> -                  zone->spanned_pages,
> -                  zone->present_pages,
> +                  READ_ONCE(zone->spanned_pages),
> +                  READ_ONCE(zone->present_pages),
>                    zone_managed_pages(zone),
>                    zone_cma_pages(zone));
>
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
>

