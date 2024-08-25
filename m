Return-Path: <linux-kernel+bounces-300606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4195E5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C92815A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECA80025;
	Sun, 25 Aug 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxcYnUHh"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FA1C3D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724629945; cv=none; b=GRVGm0ro72Dy7UEpY3ikhWUuZ6i1BDZpg7IPdhJ5jk+PMmYaXGWHTIvUu5hK0T7lKOwy41FsAMyp1HXPEFTehVQiXdBkZB66Mf6yy0fo+rWkQRe4PPkyeeIRvB5doGAzaCiOHyZnti4Ze98Xebh3/i+ugEn1TGT7aZdHHyU9X7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724629945; c=relaxed/simple;
	bh=n1uZkJNbXeHLfiNH8G7uNB/bTvtRwSB5jERMNK/igNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOlbnBUmbk1pGz5KuvVelWDORucuqpoytjaJkYK+d9yOTfc+WComy1v68LrNey+TfggziV12REb/SBvt/Fm2mRBgTr57LKTJs6C/HhEt1dfTqonrf/AooB+184zOfY5QxMDa1VaoJ2kk4KMNyLUmbWFaEDhKfepWWqLqwds4oTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxcYnUHh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-498d14e7965so1909477137.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724629942; x=1725234742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRzEQlj9dVdhpBntlcvy/iu/aFogUcce2etmAOCAWEg=;
        b=jxcYnUHhcnVB4tbdD1NP9FrqK6h7c/eCn6epazC49Y26hW9zFWpq8WafDYFXLmD3h4
         8fYMFul9DXaJZs/0jYIxEsAfEwOHenlhokW6d3VH1y13/SYoFa0A1R3Kp/4aXqrDskC/
         n1VOY3RXk3ulqxX9dNwJrcMTskvXKKMGtnDCwiANiSNYIbW9H6eqIzPgfqf4ntwnzXf1
         ECxy9irASbKaqkpSKx94+JzMt5MinGb8i8BoTcYCEZII21a2Hlp8E8+k6DRK2qZnPj2X
         zKi8Me4IvF/1I0GuDWVDDe3A6X7Paa+l+a5rjUWynLkEHuJsHjPRetwBzZnhNn8Or+FJ
         HZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724629942; x=1725234742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRzEQlj9dVdhpBntlcvy/iu/aFogUcce2etmAOCAWEg=;
        b=JzVgsM55YGwB/5VtyMCuhiV/sLd6djoN1UPleOEvnTTYf9bIS/FhcLVias6r3sjzpO
         /yRGA+9viiZgr+Cu6HBL2+4BdbbVl7fRI8rfAXiLEAMLAgAS6S+aCLa/9fzn7HeyyxvJ
         Yowf/Epda3Lo1fxiYQjahtHgmmhyXiWlZBUA5FwfSTwauZSZ45AtoWbY/YH9LkElp456
         5NVgft6jOvLWqzY+WK/Gc1TCJPeO8kQM2HtuYqx/Nj2MU6QW43tuBJzSzhYqJyeAyOFb
         Mjqe/yC1W9Zuk1Io1/4iBy91JyOGl3sKVk23PHqQzypwCsLdw0xYw7jd7Z0Ti0bioDgw
         F1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXrJxVQ7s6yBcw3iUg2PX2gkhT4cWRdvHjyJiIlEhS6Cig0JpxKA4AWQYTSXpjQrFWVW6JULDXpAISIZK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77XKJyZi/ZVdFYbNtHtaIMDmgwCnQfF48xkTEwePtZY40iy8C
	iRyg9PDvlpJUl/+GBlUIL1cwzALX7CqL10GVylL21wyBuQcYFdUNz+JvJAYRE0+qiqCxDsow1eA
	Mbb3Ew8s6UM8OLnxB95dk6NWKNEU=
X-Google-Smtp-Source: AGHT+IFjCJK32Xbrqyvw6T+/4qKGZJjZA1L8VgK12nCFbg2fz/iIiSIaUYSOUvrAPA/kqoBZDEs9Ria+fQ1k67TwHUc=
X-Received: by 2002:a05:6102:32c3:b0:493:c261:1a9c with SMTP id
 ada2fe7eead31-498f3d070cfmr5944995137.5.1724629941652; Sun, 25 Aug 2024
 16:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com>
 <20240815215308.55233-1-21cnbao@gmail.com> <33f34a88-0130-5444-9b84-93198eeb50e7@google.com>
In-Reply-To: <33f34a88-0130-5444-9b84-93198eeb50e7@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Aug 2024 11:52:10 +1200
Message-ID: <CAGsJ_4zPDLL61DATTFd62sD-ZMd+4sFDaFCLsQatq=qAmOEnew@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: attempt to batch free swap entries for zap_pte_range()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, chrisl@kernel.org, david@redhat.com, 
	justinjiang@vivo.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 8:09=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Fri, 16 Aug 2024, Barry Song wrote:
> > Subject: [PATCH] mm: check all swaps belong to same swap_cgroup in
> >  swap_pte_batch()
> >
> > Right now, it is possible two folios are contiguous in swap slots
> > but they don't belong to one memcg. In this case, even we return
> > a large nr, we can't really batch free all slots.
> >
> > Reported-by: Yosry Ahmed <yosryahmed@google.com>
> > Reported-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/internal.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index adbf8c88c9df..d1f1e221212d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> >  #include <linux/swapops.h>
> > +#include <linux/swap_cgroup.h>
> >  #include <linux/tracepoint-defs.h>
> >
> >  /* Internal core VMA manipulation functions. */
> > @@ -275,18 +276,22 @@ static inline int swap_pte_batch(pte_t *start_pte=
p, int max_nr, pte_t pte)
> >  {
> >       pte_t expected_pte =3D pte_next_swp_offset(pte);
> >       const pte_t *end_ptep =3D start_ptep + max_nr;
> > +     swp_entry_t entry =3D pte_to_swp_entry(pte);
> >       pte_t *ptep =3D start_ptep + 1;
> > +     unsigned short cgroup_id;
> >
> >       VM_WARN_ON(max_nr < 1);
> >       VM_WARN_ON(!is_swap_pte(pte));
> > -     VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
> > +     VM_WARN_ON(non_swap_entry(entry));
> >
> > +     cgroup_id =3D lookup_swap_cgroup_id(entry);
> >       while (ptep < end_ptep) {
> >               pte =3D ptep_get(ptep);
> >
> >               if (!pte_same(pte, expected_pte))
> >                       break;
> > -
> > +             if (lookup_swap_cgroup_id(pte_to_swp_entry(pte)) !=3D cgr=
oup_id)
> > +                     break;
> >               expected_pte =3D pte_next_swp_offset(expected_pte);
> >               ptep++;
> >       }
> > --
>
> [PATCH] mm: check all swaps belong to same swap_cgroup in swap_pte_batch(=
) fix
>
> mm-unstable swap_pte_batch() adds a new usage of lookup_swap_cgroup_id(),
> which crashes if CONFIG_MEMCG kernel booted with "cgroup_disable=3Dmemory=
":
> it now needs a mem_cgroup_disabled() check.

sorry for the trouble.

>
> Fixes: 92b50df44566 ("mm: check all swaps belong to same swap_cgroup in s=
wap_pte_batch()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  mm/swap_cgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index db6c4a26cf59..da1278f0563b 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -161,6 +161,8 @@ unsigned short swap_cgroup_record(swp_entry_t ent, un=
signed short id,
>   */
>  unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
>  {
> +       if (mem_cgroup_disabled())
> +               return 0;
>         return lookup_swap_cgroup(ent, NULL)->id;
>  }
>
> --
> 2.35.3

