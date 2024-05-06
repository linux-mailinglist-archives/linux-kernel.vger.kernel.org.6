Return-Path: <linux-kernel+bounces-170408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF97F8BD66C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C4283272
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCA15B566;
	Mon,  6 May 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4T/O2TW6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BF15B550
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028138; cv=none; b=W3tGNgMROD9GoIkqnFhpCuYeDgDPQ08VXEQbFhXvQrLrrS8nqlATsrSgB1NnTpinZOnBc59b8hemz7eA/Pn/OvVTNCauHYg02sBFUMhP6uLNFhUpnU8eLvuc0d3pKVQzwV6f+SKLS5Dk+d1ndfiUZE5gNVFs/pdFmzU67uEtL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028138; c=relaxed/simple;
	bh=NM4gizkWmsykt0Iu+8uvFwpYOT4kS/3cQ89r4BPWkeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6kVYIJlbcQOgpKH7ynDzPSiqo0brdchYHxKg0i9rof5UU8VLVIqGc5kgeDRt/3AaZSHroBxm7tngMjHk6cc0WWFBXxv1YyWE/guVle2ajoFDCanew388WzZCvCm+muko+LnfbWyW189VJGaG+Tw2hnDq7hr0Vi0+zJ1v8gN7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4T/O2TW6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599af16934so580095166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715028135; x=1715632935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqjodXzTW0rNwIpAxPfnGxHwUTylHmXn+/HV+LShC/Y=;
        b=4T/O2TW6NdXdbtL6xoE5nmAtvKt2AdIcXzHP6QAktLc4Rbp2myxdSYNj9ZoPM0h827
         SphuR+E0+kW0ozDTh1mcpgXiCGxXWxRvwmHmPZz5i0murFMAR/wX5CbC9GUq8L49EqwG
         X5ljushrw/MrLpMz4AsMmgk0iRjXBmxzpgJk8INutf/kl5Bfu/tlohAMuOy/3psBLaOA
         AGw4sc34JUlrmcbZXmzUZykQF93rde+NBGdlMpvEfzROgHaqJWGdHma0m9nFLMYqGc29
         YnZf523of2V+JMYC2H6uz9N9YN022G6NnGzSJWHo6LPVOuNOiRpFG6J87V88n2QarhLf
         7SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028135; x=1715632935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqjodXzTW0rNwIpAxPfnGxHwUTylHmXn+/HV+LShC/Y=;
        b=olTaeBefc6uAhapzBX5LtmMzIvdBnWHrKAkOJtwSTuvEiGh0aV6mWFhoeXITegJmzc
         NzVLRBVC3cP/tdbd8q0bD5GQ8oy6fYGxaWrYz7HhxO6ZXYUSzLnJ8dN9C8eODksqYmE2
         iDMpO1kA0sXpRDcH6SI9K+WHXCWLEFd2yIvDdJKGNrXyVcwYByH8i1tc/Q5hsbUvjgUY
         RXpg40K+ACzxhFDXGuh31HTDsf/NpE6aSNGNpaYUgqYO1tn4gumZi+cQdfYlnW1zIHs7
         diiIBJATWHbKqa4bNg762Nwp2HkqPccVNLNL8pUoGvfuHQYLR4s6RJLwq2hi0fG8W9m0
         s0WA==
X-Forwarded-Encrypted: i=1; AJvYcCXStjiwdbGgAvscrcLq+7yVYn/50jRdab1DQR8bsfBMaypanjKTF6h8b12zb4RsPJCMqp/ohgbsRe/5YpSU5FaxjiK8ugVXgbagaeOc
X-Gm-Message-State: AOJu0YwQBsdbk6Ir40sJ4A4bPZVGnq/xjldcXxH/+VfIpxYh8vixV7hu
	QBZWyfv1LRcUMlcjcf5aTWfU/FYo/pHfKrPREO9t9bJckIaGcxawfVVa7hnrmPPML6Z1Cnj/Ksi
	hsB1TTBora7dL2+bs6l8aWBV6eab6l6hL3nTI
X-Google-Smtp-Source: AGHT+IEWbexmwiqgS6EJbE9+us5EtjbzkfVqomXoksmrmMeAzkfSh6xHMTpgAE+iaoShueQeiS7QwhDw8vmoE4t1Tx8=
X-Received: by 2002:a17:907:6d03:b0:a59:bc9d:a0a3 with SMTP id
 sa3-20020a1709076d0300b00a59bc9da0a3mr5109816ejc.75.1715028135229; Mon, 06
 May 2024 13:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506192924.271999-1-yosryahmed@google.com>
 <d99b6375-cbae-41f1-9221-f1dd25aab150@redhat.com> <Zjk7AJGUsjR7TOBr@google.com>
 <42b09dc5-cfb1-4bd7-b5e3-8b631498d08f@redhat.com>
In-Reply-To: <42b09dc5-cfb1-4bd7-b5e3-8b631498d08f@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 13:41:38 -0700
Message-ID: <CAJD7tkYvSAWRL1fPZP8dAWtS2ZAenp9nngvwtANAzZsUSjnoJg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:31=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.05.24 22:18, Yosry Ahmed wrote:
> > On Mon, May 06, 2024 at 09:50:10PM +0200, David Hildenbrand wrote:
> >> On 06.05.24 21:29, Yosry Ahmed wrote:
> >>> Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
> >>> although some of those fields are not exposed anywhere. Commit
> >>> 14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
> >>> changed this such that we only maintain the stats we actually expose
> >>> per-memcg via a translation table.
> >>>
> >>> Additionally, commit 514462bbe927b ("memcg: warn for unexpected event=
s
> >>> and stats") added a warning if a per-memcg stat update is attempted f=
or
> >>> a stat that is not in the translation table. The warning started firi=
ng
> >>> for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. Thes=
e
> >>> stats are not maintained per-memcg, and hence are not in the translat=
ion
> >>> table.
> >>>
> >>> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED =
and
> >>> NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which update=
s
> >>> the global per-node stats only.
> >>>
> >>> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@goo=
gle.com
> >>> Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
> >>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>> ---
> >>>    mm/rmap.c | 15 +++++++++------
> >>>    1 file changed, 9 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 12be4241474ab..ed7f820369864 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_=
rmap(struct folio *folio,
> >>>             struct page *page, int nr_pages, struct vm_area_struct *v=
ma,
> >>>             enum rmap_level level)
> >>>    {
> >>> +   pg_data_t *pgdat =3D folio_pgdat(folio);
> >>>     int nr, nr_pmdmapped =3D 0;
> >>>     VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> >>>     nr =3D __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapp=
ed);
> >>>     if (nr_pmdmapped)
> >>> -           __lruvec_stat_mod_folio(folio, folio_test_swapbacked(foli=
o) ?
> >>> +           __mod_node_page_state(pgdat, folio_test_swapbacked(folio)=
 ?
> >>>                     NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmap=
ped);
> >>>     if (nr)
> >>>             __lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> >>> @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>             enum rmap_level level)
> >>>    {
> >>>     atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>> +   pg_data_t *pgdat =3D folio_pgdat(folio);
> >>>     int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>     bool partially_mapped =3D false;
> >>>     enum node_stat_item idx;
> >>> @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
> >>>     }
> >>>     if (nr_pmdmapped) {
> >>> +           /* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg=
 */
> >>>             if (folio_test_anon(folio))
> >>> -                   idx =3D NR_ANON_THPS;
> >>> -           else if (folio_test_swapbacked(folio))
> >>> -                   idx =3D NR_SHMEM_PMDMAPPED;
> >>> +                   __lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_=
pmdmapped);
> >>>             else
> >>> -                   idx =3D NR_FILE_PMDMAPPED;
> >>> -           __lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
> >>> +                   __mod_node_page_state(pgdat,
> >>
> >> folio_pgdat(folio) should fit here easily. :)
> >>
> >> But I would actually suggest something like the following in mm/rmap.c
> >
> > I am not a big fan of this. Not because I don't like the abstraction,
> > but because I think it doesn't go all the way. It abstracts a very
> > certain case: updating nr_pmdmapped for file folios.
> >
>
> Right. It only removes some of the ugliness ;)

I think if we do this we just add one unnecessary layer of indirection
to one case. If anything people will wonder why we have a helper only
for this case. Just my 2c :)

>
> > I think if we opt for abstracting the stats updates in mm/rmap.c, we
> > should go all the way with something like the following (probably split
> > as two patches: refactoring then bug fix). WDYT about the below?
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 12be4241474ab..70d6f6309da01 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1269,6 +1269,28 @@ static void __page_check_anon_rmap(struct folio =
*folio, struct page *page,
> >                      page);
> >   }
> >
> > +static void __foio_mod_stat(struct folio *folio, int nr, int nr_pmdmap=
ped)
> > +{
> > +     int idx;
> > +
> > +     if (nr) {
> > +             idx =3D folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE=
_MAPPED;
> > +             __lruvec_stat_mod_folio(folio, idx, nr);
> > +     }
> > +     if (nr_pmdmapped) {
> > +             if (folio_test_anon(folio)) {
> > +                     idx =3D NR_ANON_THPS;
> > +                     __lruvec_stat_mod_folio(folio, idx, nr_pmdmapped)=
;
> > +             } else {
> > +                     /* NR_*_PMDMAPPED are not maintained per-memcg */
> > +                     idx =3D folio_test_swapbacked(folio) ?
> > +                             NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED;
> > +                     __mod_node_page_state(folio_pgdat(folio), idx,
> > +                                           nr_pmdmapped);
> > +             }
> > +     }
> > +}
> > +
>
> I didn't suggest that, because in the _anon and _file functions we'll
> end up introducing unnecessary folio_test_anon() checks that the
> compiler cannot optimize out.

I convinced myself that the folio_test_anon() will be #free because
the struct folio should be already in the cache at this point, of
course I may be delusional :)

We can pass in an @anon boolean parameter, but it becomes an ugliness
tradeoff at this point :)

Anyway, I don't feel strongly either way. I am fine with keeping the
patch as-is, the diff I proposed above, or the diff I proposed with an
@anon parameter of folio_test_anon(). The only option I don't really
like is adding a helper just for the file pmdmapped case.

>
> But at least in the removal path it's a clear win.
>
> --
> Cheers,
>
> David / dhildenb
>

