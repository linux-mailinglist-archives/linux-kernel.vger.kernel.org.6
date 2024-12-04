Return-Path: <linux-kernel+bounces-432146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FC9E4667
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498B816A2DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F731922CC;
	Wed,  4 Dec 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lei0AyrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC0191F9C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346901; cv=none; b=CTy4XKZne6I4GVquaQRd7HP/Q9IqDjJU7qBiGbydErvbGpKv+hhZigUVMBWh7FLcCsLKN4OlIn20RTK3TGGR7tTd488Gpq8TdYbSjygCzhyRsIK/43oMS0i7ZGUq7TwJAWTirKBS1Xh4aF13M+TQFOXw5nz23Etej9IKVQY7nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346901; c=relaxed/simple;
	bh=PP9riDGVMaArGyx4h4AGn8j7GwEl3x6Pboo0zhieNfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa3Y0HlVB7ygEUIfQ/fllF9c3gpYBdPHIlbxqwkcFJeLFhGzgSLMCx3Mgu03qH0VpG/gvmLQHiWEnAOWFPGmuO/a/MmvnT0QUrdkU26YtHUtYwbHrPDh/j+9M7hjuKW0faiHc1omyCH/Z8MLY+EbWOtYciKSfXdvdX6bcfF5WzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lei0AyrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AACC4CED6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733346901;
	bh=PP9riDGVMaArGyx4h4AGn8j7GwEl3x6Pboo0zhieNfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lei0AyrPlhHCJUTcmm2voR+SBkIAKLqlw36/7W6E2tB31MjAqSkttEQgZVdTgqH4O
	 jShtr7ARbdctpMJZfbty13X9Q0LXc0fWQ6rETrP29RCQ6hcH0jiGG93pKGXWCnrMa2
	 rT5Y5XSC5Y3ACjnQq009AkJ29qmFD08z24WOltPviNr7CO3iMpbb2LcoU8vDzkj/rq
	 cHWhZh8LdWbxdZ8mNRLmQ4Xn0qSP+4Q6Ki9GRvyK8yWXlnQEoFLLlw7DSk1bJUn79G
	 0AYsZwBX05i7Nuhn5/AyVOBn9ycPwenDaRaUGqdx1nCASltD9+tzcFRJHv1PpXhTAU
	 WQ5MS3kqXyvXw==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3882273bdfso337159276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 13:15:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy4r2s8DX0aBpbM9yINTjmUO7XcHkgrGyi94pBXvCNRVT49I57Ezjqpb0UtDHXPOwXyTEiVZWmG2ptR+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6pq8+tviWoEVhSvjd4iXvt4xjskkiPr3t+G3FEPMU9zhhKXj
	GqYK7HvvQl/E1Z7y+PN57jrjxCq4tTflcfupmwpjwBi12JgTj2mq+uz1LBy1T8mZcZGuDPKc1GS
	KyVzZ81xd0KGXM7udCj5TA2FkmW/RDhUSv4iVQw==
X-Google-Smtp-Source: AGHT+IFbN/oBxB+gjk0+oluQjXjzSKrlvFaCzGobo+WMAjvS4w0CB48XlOf7h96U5Tdton4cm+nax9QC+aHH7L8ciNA=
X-Received: by 2002:a05:690c:6e13:b0:6ee:a89e:af3b with SMTP id
 00721157ae682-6efad16fb51mr112617817b3.9.1733346900383; Wed, 04 Dec 2024
 13:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-4-ryncsn@gmail.com>
 <CAJD7tkarH0G_5oYOY56Erz_4kqAEBrqnxkW6Q+jRCAfj+zt6eA@mail.gmail.com>
In-Reply-To: <CAJD7tkarH0G_5oYOY56Erz_4kqAEBrqnxkW6Q+jRCAfj+zt6eA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 4 Dec 2024 13:14:49 -0800
X-Gmail-Original-Message-ID: <CACePvbVCeQ3pkC1_O7kzqv=YYsv60Gd7nueg+_MwGrit59_dcg@mail.gmail.com>
Message-ID: <CACePvbVCeQ3pkC1_O7kzqv=YYsv60Gd7nueg+_MwGrit59_dcg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/swap_cgroup: simplify swap cgroup definitions
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:26=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
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

Right, I did not see the struct get removed either.

Anyway I will wait for the V2 to review again.

Chris

>
> >
> > Also zero the map on initialization to prevent unexpected behaviour as
> > swap cgroup helpers are suppose to return 0 on error.
>
> All the callers lookup the id of an already swapped out page, so it
> should never be uninitialized. Maybe we should WARN if the result of
> the lookup is 0 in this case?
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

