Return-Path: <linux-kernel+bounces-380688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16D9AF492
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99D31C2165C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C471A76AC;
	Thu, 24 Oct 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeMNCkFH"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7C7641E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804580; cv=none; b=D48QSncGPR8BN9/fZPZhvJkdyJJ/VMncfn9kZXoPrd+eahS7X/co/pV6D8qmyG/mqqcVfp6qfhD/BLkSDqfIHwYx2IAjmmP38F1Ptm4vkfH/sW5osS3ag1yWzpSF4BEe8/BENOy/J+Gs0XEcjpq5r8tdJ8Ywz0HF0l2k1tcIpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804580; c=relaxed/simple;
	bh=HuDRTFCcJugr8iU8JNvPc5rklWi+L/1EeBWQ1xEM29U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugD1VLL54VOEYRuGv4QeSTGgED6rhgatEBkG1VVnxnOOYLibHdiFC8Skfh/53cgSyXi8BRn0pkMspNGpLIFoxN1JErJn02FQmpCC21T5rCYzoPZyzwKp+LdDvaFtoMVD1H13OJ9VDxbNcjK3sD74e7Uo5loyKHD9Jf+dtssEeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeMNCkFH; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a46eeb84a0so405621137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804576; x=1730409376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQTCqNUduHyWXPxZTMfE/mLw9XjdvE2Tl6TDlgx+Fmo=;
        b=HeMNCkFHvcYwfyh2sqo1kxo7PqtD0agyvCZe26b3zYyA1qwtDrceYibe9M0JQpptL5
         psgdN8RJmxjOo8vUEcRBD3C0tnHogvr8hopuvEAwdNxg9UAG114sDKyOb3Yvicdf1Gwh
         zgm5oqWFldD+g5dJlxf1jQgJmIoXiMdJlOQxz/iXGO4uTK2HiP/p3mJzzZwlJmS0x2gY
         8iE5Y8cIhY2mbAQBwZsepb3/0p7RSjbtlufyNhrE5CABukYN3Dz9XMPaqdyZUE4uJU0E
         sOe3EnWYPuLgRsKwKoeNzVwQpx6miagAkGQVegXuX0kwhHZ2a7r1ouvW41MfVgBvOnGd
         C1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804576; x=1730409376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQTCqNUduHyWXPxZTMfE/mLw9XjdvE2Tl6TDlgx+Fmo=;
        b=QFt8VwCbKT8rfgKKC0c7hXubO3pEUTMMr6tiarczebJnYt3A1iWnMGZwdJjjcDxhxI
         WCgWsW/HwGrtkMw1tfxQk7z7FndOdCucN5/BK/Mya/IL5FDWBx8gHnJ2yPUs7Ivy/JUF
         jetuz/KwxsYqn8kyK1qGL67nhJ0VNj/7zzKAMCThbUWgJ3DhxVP5mhiScUB/qVjef/jH
         cdnlZDkLBKS/5P+NJWrzRAWD7hvwwGb2j0deYHuYAM26van309ymYq/5ueuls7U4VxW6
         O3WO5XlCJVCuulk6DuaGQptXMH95qY1FtXBsLUTFcvbkmalD/u6MIhrbGEnlWKVYV1g8
         6Irw==
X-Forwarded-Encrypted: i=1; AJvYcCUzaujt4GpKWAc6JlAT+breVcHkHSt7xQobuPlPT30zJ4PnrcM/SHbCUyLCMm/gMPVnYOjBzSApe2F8jH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqVlSpIM3NFY4I85YhUlsk+3UybaCLpjdtqS9WhJgIV+wK8GO
	UnPp7riv4dbyBhsUfKD3aR78UgCEzf3ozqlTHgONYJdgvhyiI3VdHk/Zq0+tehZBblsEI43s4gI
	0OGU9nAkcu+KFiUotXQrjbxPf/opmvZw/ajUz
X-Google-Smtp-Source: AGHT+IFyGfRVQ4B9yOdAPvEizSuLviG372ZLWQQ5w14MVBrpQL6sMsecsu0bcgPZiDHoOjujVWyV4ZSjUAucNOxHn94=
X-Received: by 2002:a05:6102:5489:b0:4a3:c9b6:b311 with SMTP id
 ada2fe7eead31-4a8711e6d2cmr4493406137.26.1729804575971; Thu, 24 Oct 2024
 14:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
 <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com>
 <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz> <CAOUHufb=Ze1pj2BeasCLYpAvOhBQfKXcz678Zo_==9DeMbgT9Q@mail.gmail.com>
 <b594795a-7f26-4c0d-80f4-88d242fdc0fb@suse.cz>
In-Reply-To: <b594795a-7f26-4c0d-80f4-88d242fdc0fb@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 24 Oct 2024 15:15:39 -0600
Message-ID: <CAOUHufaHSYFibie=mb7jZYm2-xS=k-C+nvCA=wG-O_ZQDGCxFQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:16=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/24/24 06:35, Yu Zhao wrote:
> > On Wed, Oct 23, 2024 at 1:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/23/24 08:36, Yu Zhao wrote:
> >> > On Tue, Oct 22, 2024 at 4:53=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> >> >>
> >> >> +Cc Mel and Matt
> >> >>
> >> >> On 10/21/24 19:25, Michal Hocko wrote:
> >> >>
> >> >> Hm I don't think it's completely WAI. The intention is that we shou=
ld be
> >> >> able to unreserve the highatomic pageblocks before going OOM, and t=
here
> >> >> seems to be an unintended corner case that if the pageblocks are fu=
lly
> >> >> exhausted, they are not reachable for unreserving.
> >> >
> >> > I still think unreserving should only apply to highatomic PBs that
> >> > contain free pages. Otherwise, it seems to me that it'd be
> >> > self-defecting because:
> >> > 1. Unreserving fully used hightatomic PBs can't fulfill the alloc
> >> > demand immediately.
> >>
> >> I thought the alloc demand is only blocked on the pessimistic watermar=
k
> >> calculation. Usable free pages exist, but the allocation is not allowe=
d to
> >> use them.
> >
> > I think we are talking about two different problems here:
> > 1. The estimation problem.
> > 2. The unreserving policy problem.
> >
> > What you said here is correct w.r.t. the first problem, and I was
> > talking about the second problem.
>
> OK but the problem with unreserving currently makes the problem of
> estimation worse and unfixable.
>
> >> > 2. More importantly, it only takes one alloc failure in
> >> > __alloc_pages_direct_reclaim() to reset nr_reserved_highatomic to 2M=
B,
> >> > from as high as 1% of a zone (in this case 1GB). IOW, it makes more
> >> > sense to me that highatomic only unreserves what it doesn't fully us=
e
> >> > each time unreserve_highatomic_pageblock() is called, not everything
> >> > it got (except the last PB).
> >>
> >> But if the highatomic pageblocks are already full, we are not really
> >> removing any actual highatomic reserves just by changing the migratety=
pe and
> >> decreasing nr_reserved_highatomic?
> >
> > If we change the MT, they can be fragmented a lot faster, i.e., from
> > the next near OOM condition to upon becoming free. Trying to persist
> > over time is what actually makes those PBs more fragmentation
> > resistant.
>
> If we assume the allocations there have similar sizes and lifetimes, then=
 I
> guess yeah.
>
> >> In fact that would allow the reserves
> >> grow with some actual free pages in the future.
> >
> > Good point. I think I can explain it better along this line.
> >
> > If highatomic is under the limit, both your proposal and the current
> > implementation would try to grow, making not much difference. However,
> > the current implementation can also reuse previously full PBs when
> > they become available. So there is a clear winner here: the current
> > implementation.
>
> I'd say it depends on the user of the highatomic blocks (the workload),
> which way ends up better.
>
> > If highatomic has reached the limit, with your proposal, the growth
> > can only happen after unreserve, and unreserve only happens under
> > memory pressure. This means it's likely that it tries to grow under
> > memory pressure, which is more difficult than the condition where
> > there is plenty of memory. For the current implementation, it doesn't
> > try to grow, rather, it keeps what it already has, betting those full
> > PBs becoming available for reuse. So I don't see a clear winner
> > between trying to grow under memory pressure and betting on becoming
> > available for reuse.
>
> Understood. But also note there are many conditions where the current
> implementation and my proposal behave the same. If highatomic pageblocks
> become full and then only one or few pages from each is freed, it suddenl=
y
> becomes possible to unreserve them due to memory pressure, and there is n=
o
> reuse for those highatomic allocations anymore. This very different outco=
me
> only depends on whether a single page is free for the unreserve to work, =
but
> from the efficiency of pageblock reusal you describe above a single page =
is
> only a minor difference. My proposal would at least remove the sudden cha=
nge
> of behavior when going from a single free page to no free page.
>
> >> Hm that assumes we're adding some checks in free fastpath, and for tha=
t to
> >> work also that there will be a freed page in highatomic PC in near eno=
ugh
> >> future from the decision we need to unreserve something. Which is not =
so
> >> much different from the current assumption we'll find such a free page
> >> already in the free list immediately.
> >>
> >> > To summarize, I think this is an estimation problem, which I would
> >> > categorize as a lesser problem than accounting problems. But it soun=
ds
> >> > to me that you think it's a policy problem, i.e., the highatomic
> >> > unreserving policy is wrong or not properly implemented?
> >>
> >> Yeah I'd say not properly implemented, but that sounds like a mechanis=
m, not
> >> policy problem to me :)
> >
> > What about adding a new counter to keep track of the size of free
> > pages reserved for highatomic?
>
> That's doable but not so trivial and means starting to handle the highato=
mic
> pageblocks much more carefully, like we do with CMA pageblocks and
> NR_FREE_CMA_PAGES counter, otherwise we risk drifting the counter unrecov=
erably.

The counter would be protected by the zone lock:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..86c63d48c08e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -824,6 +824,7 @@ struct zone {
  unsigned long watermark_boost;

  unsigned long nr_reserved_highatomic;
+ unsigned long nr_free_highatomic;

  /*
  * We don't know if the memory that we're going to allocate will be
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..4d8031817c59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -644,6 +644,17 @@ static inline void account_freepages(struct zone
*zone, int nr_pages,
  __mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
 }

+static void account_highatomic_freepages(struct zone *zone, unsigned
int order, int old_mt, int new_mt)
+{
+ int nr_pages =3D 1 < order;
+
+ if (is_migrate_highatomic(old_mt))
+ zone->nr_free_highatomic -=3D nr_pages;
+
+ if (is_migrate_highatomic(new_mt))
+ zone->nr_free_highatomic +=3D nr_pages;
+}
+
 /* Used for pages not on another list */
 static inline void __add_to_free_list(struct page *page, struct zone *zone=
,
        unsigned int order, int migratetype,
@@ -660,6 +671,8 @@ static inline void __add_to_free_list(struct page
*page, struct zone *zone,
  else
  list_add(&page->buddy_list, &area->free_list[migratetype]);
  area->nr_free++;
+
+ account_highatomic_freepages(zone, order, -1, migratetype);
 }

 /*
@@ -681,6 +694,8 @@ static inline void move_to_free_list(struct page
*page, struct zone *zone,

  account_freepages(zone, -(1 << order), old_mt);
  account_freepages(zone, 1 << order, new_mt);
+
+ account_highatomic_freepages(zone, order, old_mt, new_mt);
 }

 static inline void __del_page_from_free_list(struct page *page,
struct zone *zone,
@@ -698,6 +713,8 @@ static inline void
__del_page_from_free_list(struct page *page, struct zone *zon
  __ClearPageBuddy(page);
  set_page_private(page, 0);
  zone->free_area[order].nr_free--;
+
+ account_highatomic_freepages(zone, order, migratetype, -1);
 }

 static inline void del_page_from_free_list(struct page *page, struct
zone *zone,
@@ -3085,7 +3102,7 @@ static inline long
__zone_watermark_unusable_free(struct zone *z,
  * over-estimate the size of the atomic reserve but it avoids a search.
  */
  if (likely(!(alloc_flags & ALLOC_RESERVES)))
- unusable_free +=3D z->nr_reserved_highatomic;
+ unusable_free +=3D z->nr_free_highatomic;


 #ifdef CONFIG_CMA
  /* If allocation can't use CMA areas don't use free CMA pages */

