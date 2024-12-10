Return-Path: <linux-kernel+bounces-439066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7177B9EAA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCDF188B5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3E22E415;
	Tue, 10 Dec 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxQHLMOz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F313594F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818557; cv=none; b=HkvMaoF/6qacZD1Zqyqq2PFEfxppKYWb8GE1Q31r2S8FbTeSL1WpiBXaYtSWMWfGKwnPBND4+sxEKbnzsc9Harfwrxm38PMQMkpebo6pSgaWH7KejZNP27Ih0e5jZv7r39YaGZyYsSpRAQ82wqyNBu9tOv9tMl7S+bAgLd9wvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818557; c=relaxed/simple;
	bh=FTvF1YebxeNHRC5kpG45NY3B5GqBTrNmetA5coZUqU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrZ9fmD9pMu4oGtzIcQlbB7Ne1ckLAUNl/sHMsfGc5PnSiTq9bth4WqM7RhtrRqFzla8iBuWUgzHu+aqRXwJF40ZUSupsXrsDS84dfV8pPeib1X+XibvoPUm6/mQipaZ7vC1aD7z3jYTWdIvVNnMYC6M1O8NGaMc1iwYnplT0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxQHLMOz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3023c51146cso1209291fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733818554; x=1734423354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDNr0SQs7JARf1tXnEFLADDYHcO1kynEBs5jHdseHtQ=;
        b=DxQHLMOzXrcHMoYhMBpEOiQDKqhBxJZN4LtoAX+fdXdTSJKUgvz0zyYhObLNte4wZR
         RO1hJ7Eu5Z3F+GTDqyLXU3J0J8FEnLJVNEDebN/kMK9rMU61usPiNm9qqiESp5jlVKq3
         YP5bTnrlUNuIjma6i9OsDjsLY8CZS/gEN5F3rPscNzEtSEvA86T4iO3MBZkhQuKpQeHZ
         /jC6Mozjd0LMAm8eOIJhipe4H9uXuRmOYpbC7eHsxrhZYZQNXt1LrhurrBz+jCNn/cZD
         5qghqLwtDIDrgFSBw2210NhxVsP128Uiav8IhJb1cUndLLvui/3eeKC2PRe3s/0Zaoyd
         w9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733818554; x=1734423354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDNr0SQs7JARf1tXnEFLADDYHcO1kynEBs5jHdseHtQ=;
        b=NjmhYH6YUTWQ8rThLj/EkDPYPOyGSTXfZddc9MqzOa6c79yCojOwsAJCzBqlHYRQQP
         SWiwogq2Iqo0lKkX/bq6NE7TXEt/fRdPlOtfsx7Tw1d21uSPwskw9ggjjYvnq/9XSYQL
         36hDCB69C0vHJyAiQBsyUrsREZSGcK05uyuTuu++qNa+Aq0dIht1amEoNmfSr8K5dN4N
         5Yw53MY7+4GOB52HrqSZzc+d/eYjsrtSOLDrymJ6K5GFOb8HeG031L01LXVbM/qBJXvD
         aVdT/jMvmAGxnVDdGdT/0kDBD7CyRhRwUWdIRnacS5LnTdCAUbmCpmevhzD1B8pYuvex
         3C8g==
X-Forwarded-Encrypted: i=1; AJvYcCV3O8/KfjLwWnIwC+EkTBVaYJEhZy6PG1Iq1xx+f7xDL1DAvNGsN729BU25iPvDj3E72bch3y8ZhQ6u/DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbXyFoXbaRg8v+JXcksJLLedf/xncCox+1w2FgaJNLBB3/Xzi
	GJN13mXOTtEzQN7rbrSmfXiIpKs4GjozIlTb8qNKnERjvJKPnDMwUk3GLR5m+bK987KpUZZ1VtM
	HNpb4jlzmdbtECRHQBWdkeh5y2IU=
X-Gm-Gg: ASbGncvPfcVYSw/aeY7x4ve2SP0aChSL3wqfjiS7jImAmVP95nRNzVlbgpanMR2hXOy
	DloI1TJEGWD8t5QxdS0Kcj7EM9P5OdZROpq0=
X-Google-Smtp-Source: AGHT+IEzneTwBmpUpltRe848A10lZV7XqHl+ipUeEsWgFCV/zsCiLt5v8a7s7FlvB0Q2Guoi16YZq8WwKm9pGrze2W4=
X-Received: by 2002:a05:651c:1986:b0:302:2097:392f with SMTP id
 38308e7fff4ca-302328381d2mr8186461fa.7.1733818553302; Tue, 10 Dec 2024
 00:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-4-ryncsn@gmail.com>
 <CAJD7tkarH0G_5oYOY56Erz_4kqAEBrqnxkW6Q+jRCAfj+zt6eA@mail.gmail.com>
In-Reply-To: <CAJD7tkarH0G_5oYOY56Erz_4kqAEBrqnxkW6Q+jRCAfj+zt6eA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 10 Dec 2024 16:15:36 +0800
Message-ID: <CAMgjq7CE29aR6kQtBid-NGJM-B+dZZFTZ=ta142xoRi06zs2FQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/swap_cgroup: simplify swap cgroup definitions
To: Yosry Ahmed <yosryahmed@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:26=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Remove the intermediate struct swap_cgroup, it just a unsigned short
> > wrapper, simplify the code.
>
> Did you actually remove the struct? It doesn't seem like it.

Oops, I forgot to drop these lines of code indeed, I'll send V2
merging this into patch 4/4 so this commit can be ignored for now.

>
> >
> > Also zero the map on initialization to prevent unexpected behaviour as
> > swap cgroup helpers are suppose to return 0 on error.
>
> All the callers lookup the id of an already swapped out page, so it
> should never be uninitialized. Maybe we should WARN if the result of
> the lookup is 0 in this case?

Yes, just a fallback for robustness.

Lookup returning 0 is expected in some cases, eg. Cgroup V1 will call
mem_cgroup_swapin_uncharge_swap early when the folio is added to swap
cache, and erase the record. Then the mem_cgroup_uncharge_swap in
swapfile.c (called when the swap cache is being dropped and entry is
freed) won't double uncharge it. So we can't WARN on that.

>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_cgroup.c | 45 +++++++++++++++++++--------------------------
> >  1 file changed, 19 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > index 1770b076f6b7..a76afdc3666a 100644
> > --- a/mm/swap_cgroup.c
> > +++ b/mm/swap_cgroup.c
> > @@ -12,14 +12,12 @@ struct swap_cgroup {
> >  };
> >
> >  struct swap_cgroup_ctrl {
> > -       struct swap_cgroup *map;
> > +       unsigned short  *map;
> >         spinlock_t      lock;
> >  };
> >
> >  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> >
> > -#define SC_PER_PAGE    (PAGE_SIZE/sizeof(struct swap_cgroup))
> > -
> >  /*
> >   * SwapCgroup implements "lookup" and "exchange" operations.
> >   * In typical usage, this swap_cgroup is accessed via memcg's charge/u=
ncharge
> > @@ -33,18 +31,6 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_=
SWAPFILES];
> >   *
> >   * TODO: we can push these buffers out to HIGHMEM.
> >   */
> > -static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
> > -                                       struct swap_cgroup_ctrl **ctrlp=
)
> > -{
> > -       pgoff_t offset =3D swp_offset(ent);
> > -       struct swap_cgroup_ctrl *ctrl;
> > -
> > -       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > -       if (ctrlp)
> > -               *ctrlp =3D ctrl;
> > -       return &ctrl->map[offset];
> > -}
> > -
> >  /**
> >   * swap_cgroup_record - record mem_cgroup for a set of swap entries
> >   * @ent: the first swap entry to be recorded into
> > @@ -58,20 +44,21 @@ unsigned short swap_cgroup_record(swp_entry_t ent, =
unsigned short id,
> >                                   unsigned int nr_ents)
> >  {
> >         struct swap_cgroup_ctrl *ctrl;
> > -       struct swap_cgroup *sc;
> > +       unsigned short *map;
> >         unsigned short old;
> >         unsigned long flags;
> >         pgoff_t offset =3D swp_offset(ent);
> >         pgoff_t end =3D offset + nr_ents;
> >
> > -       sc =3D lookup_swap_cgroup(ent, &ctrl);
> > +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > +       map =3D ctrl->map;
> >
> >         spin_lock_irqsave(&ctrl->lock, flags);
> > -       old =3D sc->id;
> > -       for (; offset < end; offset++, sc++) {
> > -               VM_BUG_ON(sc->id !=3D old);
> > -               sc->id =3D id;
> > -       }
> > +       old =3D map[offset];
> > +       do {
> > +               VM_BUG_ON(map[offset] !=3D old);
> > +               map[offset] =3D id;
> > +       } while (++offset !=3D end);
>
> Why did you change the for loop here?
>
> >         spin_unlock_irqrestore(&ctrl->lock, flags);
> >
> >         return old;
> > @@ -85,20 +72,26 @@ unsigned short swap_cgroup_record(swp_entry_t ent, =
unsigned short id,
> >   */
> >  unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
> >  {
> > +       struct swap_cgroup_ctrl *ctrl;
> > +
> >         if (mem_cgroup_disabled())
> >                 return 0;
> > -       return lookup_swap_cgroup(ent, NULL)->id;
> > +
> > +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > +       pgoff_t offset =3D swp_offset(ent);
> > +
> > +       return READ_ONCE(ctrl->map[offset]);
>
> The READ_ONCE() does not exist today in lookup_swap_cgroup(). Why is it n=
eeded?
>
> >  }
> >
> >  int swap_cgroup_swapon(int type, unsigned long max_pages)
> >  {
> > -       struct swap_cgroup *map;
> > +       void *map;
> >         struct swap_cgroup_ctrl *ctrl;
> >
> >         if (mem_cgroup_disabled())
> >                 return 0;
> >
> > -       map =3D vcalloc(max_pages, sizeof(struct swap_cgroup));
> > +       map =3D vzalloc(max_pages * sizeof(unsigned short));
> >         if (!map)
> >                 goto nomem;
> >
> > @@ -117,7 +110,7 @@ int swap_cgroup_swapon(int type, unsigned long max_=
pages)
> >
> >  void swap_cgroup_swapoff(int type)
> >  {
> > -       struct swap_cgroup *map;
> > +       void *map;
>
> Why void?
>
> >         struct swap_cgroup_ctrl *ctrl;
> >
> >         if (mem_cgroup_disabled())
> > --
> > 2.47.0
> >
>

