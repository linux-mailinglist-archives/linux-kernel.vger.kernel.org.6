Return-Path: <linux-kernel+bounces-446458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC339F2485
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1096B164AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550B18FC7E;
	Sun, 15 Dec 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNzKafT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1118039
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275109; cv=none; b=SikwqgtV3HLSMPDg8dCECjfqwQDut7e4QWH0zsniD9jA2plQ2TxOjIXzjB8jVELDlUke5y+4OHBEj3wGWucNEhiYZrwe/mARDIoZpQcLRVdcR40SCV3R3hotylH5TI/+t17RSAMC7nmD5UMm3jz4wFKoI3H2+IfHpeMTSZ0mPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275109; c=relaxed/simple;
	bh=+Kj3xJFv8izYEL+HCpmNVhZmnq59sFrQ9yzwcNHINHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0CTEonh7dSdRjBDFDn1MsoDF2+dZc//08odjQHhX8xFPB/m/bobAhcy/pyf3S4QpNnNUmE2IiK21DJfePbbtCgihFTT3q80aLc3DomhN/1Ps++I373oUSsl2g2F20pBZ4zyh7qiZnBGH5w2/S6+UtB96nk10ZyJze8v+GFStCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNzKafT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9281BC4CEDD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734275108;
	bh=+Kj3xJFv8izYEL+HCpmNVhZmnq59sFrQ9yzwcNHINHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YNzKafT6xvU+6845KZzcmt5iw76Zi0N/N6IsA2MhotMkGArVxd/ahS4anKr6h2C8x
	 2x/QmCtZxh640B6ovzJO9Ct9+wIpmV46389pjJ70RIPX4wQULV9rdODP3ha04yuIAO
	 JQ0bguNmv9kW7kqrshq1lwArkvDN3evCG2R0PZVJyakc9BPDaQCrGGFVPB0rpGkLeR
	 zL/+/+kzjudKCkqaS3qNU6rHYuCMCb4nV3BEm/6MFwqsJSozyfQL0JX+JDAtGuwAwX
	 bjqZmE7fdiuiAt+oYmB7anNWuVIvZzaaEbSMWsknHlnoqcJHdFzJg+s03laTQcSqbM
	 do3cHRl5nmK/w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b22fso34682791fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 07:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUbR4LP8ivxqujurbKyhF7tpHSSKns8aZN3Z9TauMWlKv1Pn9h1XUlqvevHq+81zYMh0gvFLJp2+tyPA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGEFp/3DnETJxxZg5zkOEOkKxcb+UTKME7fLRLKDxkdUmLe53
	PqDaZGaW7RZXKvNHpMTmQu9jgGd9NEiopibiud7R7GtnyduV3Hwa4iVPNk5Hh4fH77hXvrfeaoC
	des2SpC7o0sPQ22/hgoL9GRlwGw==
X-Google-Smtp-Source: AGHT+IGU+GxDh/4rDUsMQSl00cmOVScHum5073oQMBpLAKWzA5k0SDG5O3mlSQohCd7fBL3uEXLpS3VV8OfA+jcPyJo=
X-Received: by 2002:a2e:b8c4:0:b0:302:4171:51f0 with SMTP id
 38308e7fff4ca-3025434c5b8mr30816341fa.0.1734275107169; Sun, 15 Dec 2024
 07:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210092805.87281-1-ryncsn@gmail.com> <20241210092805.87281-4-ryncsn@gmail.com>
 <CACePvbUoije1wgy3jPambP9-rbYs_Yq1Pajnv3U1MDOxFGU2fg@mail.gmail.com> <CAMgjq7D43TQtvdrUyECq0GfaobbEpA2ANgyAqBnh-yJ3n74YAQ@mail.gmail.com>
In-Reply-To: <CAMgjq7D43TQtvdrUyECq0GfaobbEpA2ANgyAqBnh-yJ3n74YAQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 15 Dec 2024 07:04:55 -0800
X-Gmail-Original-Message-ID: <CANeU7QnVwH=9NeWafukJdF_Ls7N3=NEQ5KmXXWOiU9x=5XeHFg@mail.gmail.com>
Message-ID: <CANeU7QnVwH=9NeWafukJdF_Ls7N3=NEQ5KmXXWOiU9x=5XeHFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sun, Dec 15, 2024 at 12:07=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Tue, Dec 10, 2024 at 1:29=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintai=
nance")
> > > replaced the cmpxchg/xchg with a global irq spinlock because some arc=
hs
> > > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
> > >
> > > And as commented in swap_cgroup.c, this lock is not needed for map
> > > synchronization.
> > >
> > > Emulation of 2 bytes xchg with atomic cmpxchg isn't hard, so implemen=
t
> > > it to get rid of this lock. Introduced two helpers for doing so and t=
hey
> > > can be easily dropped if a generic 2 byte xchg is support.
> > >
> > > Testing using 64G brd and build with build kernel with make -j96 in 1=
.5G
> > > memory cgroup using 4k folios showed below improvement (10 test run):
> > >
> > > Before this series:
> > > Sys time: 10809.46 (stdev 80.831491)
> > > Real time: 171.41 (stdev 1.239894)
> > >
> > > After this commit:
> > > Sys time: 9621.26 (stdev 34.620000), -10.42%
> > > Real time: 160.00 (stdev 0.497814), -6.57%
> > >
> > > With 64k folios and 2G memcg:
> > > Before this series:
> > > Sys time: 8231.99 (stdev 30.030994)
> > > Real time: 143.57 (stdev 0.577394)
> > >
> > > After this commit:
> > > Sys time: 7403.47 (stdev 6.270000), -10.06%
> > > Real time: 135.18 (stdev 0.605000), -5.84%
> > >
> > > Sequential swapout of 8G 64k zero folios with madvise (24 test run):
> > > Before this series:
> > > 5461409.12 us (stdev 183957.827084)
> > >
> > > After this commit:
> > > 5420447.26 us (stdev 196419.240317)
> > >
> > > Sequential swapin of 8G 4k zero folios (24 test run):
> > > Before this series:
> > > 19736958.916667 us (stdev 189027.246676)
> > >
> > > After this commit:
> > > 19662182.629630 us (stdev 172717.640614)
> > >
> > > Performance is better or at least not worse for all tests above.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/swap_cgroup.c | 73 +++++++++++++++++++++++++++++-----------------=
--
> > >  1 file changed, 45 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > > index 1770b076f6b7..a0a8547dc85d 100644
> > > --- a/mm/swap_cgroup.c
> > > +++ b/mm/swap_cgroup.c
> > > @@ -7,19 +7,20 @@
> > >
> > >  static DEFINE_MUTEX(swap_cgroup_mutex);
> > >
> > > +/* Pack two cgroup id (short) of two entries in one swap_cgroup (ato=
mic_t) */
> >
> > Might not be two short if the atomic_t is more than 4 bytes. The
> > assumption here is that short is 2 bytes and atomic_t is 4 bytes. It
> > is hard to conclude that is the case for all architecture.
> >
> > > +#define ID_PER_SC (sizeof(atomic_t) / sizeof(unsigned short))
> >
> > You should use "sizeof(struct swap_cgroup) / sizeof(unsigned short)",
> > or get rid of struct swap_cgroup and directly use atomic_t.
> >
> > > +#define ID_SHIFT (BITS_PER_TYPE(unsigned short))
> > > +#define ID_MASK (BIT(ID_SHIFT) - 1)
> > >  struct swap_cgroup {
> > > -       unsigned short          id;
> > > +       atomic_t ids;
> >
> > You use struct swap_cgroup and atomic_t which assumes no padding added
> > to the struct. You might want to build an assert on sizeof(atomic_t)
> > =3D=3D sizeof(struct swap_cgroup).
>
> Good idea, asserting struct swap_croup is an atomic_t ensures no
> unexpected behaviour.
>
> >
> > >  };
> > >
> > >  struct swap_cgroup_ctrl {
> > >         struct swap_cgroup *map;
> > > -       spinlock_t      lock;
> > >  };
> > >
> > >  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> > >
> > > -#define SC_PER_PAGE    (PAGE_SIZE/sizeof(struct swap_cgroup))
> > > -
> > >  /*
> > >   * SwapCgroup implements "lookup" and "exchange" operations.
> > >   * In typical usage, this swap_cgroup is accessed via memcg's charge=
/uncharge
> > > @@ -30,19 +31,32 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[M=
AX_SWAPFILES];
> > >   *    SwapCache(and its swp_entry) is under lock.
> > >   *  - When called via swap_free(), there is no user of this entry an=
d no race.
> > >   * Then, we don't need lock around "exchange".
> > > - *
> > > - * TODO: we can push these buffers out to HIGHMEM.
> > >   */
> > > -static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
> > > -                                       struct swap_cgroup_ctrl **ctr=
lp)
> > > +static unsigned short __swap_cgroup_id_lookup(struct swap_cgroup *ma=
p,
> > > +                                             pgoff_t offset)
> > >  {
> > > -       pgoff_t offset =3D swp_offset(ent);
> > > -       struct swap_cgroup_ctrl *ctrl;
> > > +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;
> >
> > Might not want to assume the ID_PER_SC is two. If some architecture
> > atomic_t is 64 bits then that code will break.
>
> Good idea, atomic_t is by defining an int, not sure if there is any
> strange archs will change the size though, more robust code is always
> better.
>
> Can change this to (offset % ID_PER_SC) instead, the generated machine
> code should be still the same for most archs.
>
> >
> > > +       unsigned int old_ids =3D atomic_read(&map[offset / ID_PER_SC]=
.ids);
> >
> > Here assume sizeof(unsigned int) =3D=3D sizeof(atomic_t). Again,some
> > strange architecture might break it. Better use unsigned version of
> > aotmic_t;
> >
> >
> > >
> > > -       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > > -       if (ctrlp)
> > > -               *ctrlp =3D ctrl;
> > > -       return &ctrl->map[offset];
> > > +       return (old_ids & (ID_MASK << shift)) >> shift;
> >
> > Can be simplified as (old_ids >> shift) & ID_MASK. You might want to
> > double check that.
> >
> > > +}
> > > +
> > > +static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
> > > +                                           pgoff_t offset,
> > > +                                           unsigned short new_id)
> > > +{
> > > +       unsigned short old_id;
> > > +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;
> >
> > Same here, it assumes ID_PER_SC is 2.
> >
> > > +       struct swap_cgroup *sc =3D &map[offset / ID_PER_SC];
> > > +       unsigned int new_ids, old_ids =3D atomic_read(&sc->ids);
> >
> > Again it assumes  sizeof(unsigned int) =3D=3D sizeof(atomic_t).
>
> I think this should be OK? The document says "atomic_t, atomic_long_t
> and atomic64_t use int, long and s64 respectively".
>
> Could change this with some wrapper but I think it's unnecessary.

Ack.

>
> >
> > > +
> > > +       do {
> > > +               old_id =3D (old_ids & (ID_MASK << shift)) >> shift;
> > Can be simplify:
> > old_id =3D (old_ids >> shift) & ID_MASK;
> >
> > > +               new_ids =3D (old_ids & ~(ID_MASK << shift));
> > > +               new_ids |=3D ((unsigned int)new_id) << shift;
> >
> > new_ids |=3D (atomic_t) new_id << shift;
>
> atomic_t doesn't work with bit operations, it must be an arithmetic
> type, so here I think it has to stay like this.

Ack

Chris

