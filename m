Return-Path: <linux-kernel+bounces-333905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4397CFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C4C1F23010
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F3AD51;
	Fri, 20 Sep 2024 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INnDx1tv"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A58460
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726795073; cv=none; b=QPgobpFjnTi4n3qVedXxiBCFDG2D6tTxjUZVsMZLvZbJATbUM2xTf2WZnmgv05k+h3D+oG77X/Rq6EA1tzdrB6faytbqH6dCv5Ia30Q32OtZXKMv9m8foDYzMXkKkk3ej6j6WmPXeM7GhMxsMCaQyyqntTP+Rg1sIS0yHCXL090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726795073; c=relaxed/simple;
	bh=UasmtNtDAgrKbtDafju7pPcjzCkGJjb1MOyxY7iBmw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdbclb6E5ekGO+CI5QaR/TpsxedZ2NO1aiTym9TnLofW873Yn+dzhvCoSNa+d0o7k8MBbUyHGIfBqrCs8knot7qrnP4Bs7P8sbB7WxNFeUJ/i4zjFZRZdBAm/EOuxSkjZqFBDuVo/4VpcLOkR78YUZMxTIMiTVAUxfkx2J1KpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INnDx1tv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-502fbf07c47so469654e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726795071; x=1727399871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX7VnUBV70ok1CsWs4uuxCawlBRamTI320cKATVeV/U=;
        b=INnDx1tvzHZXHe8+dhN4SEQEweluWKPCbNr+lX5QU9Uf85edP8PRVzf7hnnIe1k+k7
         jWlpq7ExKJmEv/l4qrW2N8U7xhOdf7R60ozE/vSP1eSOzfrr5AlEfvFn1ZS7DCLP07S4
         8cZUaEE3BUzvlfWo8ZyofcCRQBiNFCcop07oGLE2eeAUpRALqWOe06hdmvyOUiLBg5bV
         XNs2k4phc3RXUyRHvc1V2c2wY6uq4l1nUJELFFtvftvxLvwHthrW0ONudfevwaufiOKF
         d02kTLdmBAfFTtzN9bdsDTmaUAcusAXoSQWAAnVnZEdic5ta9pbTrC1w2BhSSaXDPrTs
         HbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726795071; x=1727399871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX7VnUBV70ok1CsWs4uuxCawlBRamTI320cKATVeV/U=;
        b=Ii1dSpeOjolwKgZKDt52+50mqyjVat2OCoi99sp98w9Mt5Ux1qFwg3z/O3gL3Iw8/8
         iSR8Ij9e+p4bu/cjgRAcXxvTcUw/g2vIhWzIB9IX81wMxpGQWakRzDKJob3Ulvo/AmmY
         C69vxSpwc1YIPg0zZ0UoCB26/pJJ+emR0BfG0QFE/LhFlQ8/WntIi01c2fBtjSlnvwTS
         FkuA7fCEFde3GANJ8RL0GP/EDaLxjVs6waJZOqVcgGY0PxXUY1S/hxf6emTkjbEs73+E
         HuM8/dgDXWnKW4hTDTkzKuuzkq60CM6gBLy+Ous81+ZLtNQEAGsuc797l6T3P/uM+uJ0
         70Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUy/hqpJgMbuSHRSHb5rTP8r2Wq+1t/oXSZlI9DRGn5vwX/YWS6KrAviw9iIfSOI3a2iqWGxruEzoAW6oU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2V/cLvYSfc1BuuysXruXSmLzhLBOfS7oSFKF3jcGyaI9kJJMM
	/4mMFJps29FKkpvPuhLyXPi2fJYGsQUI8Bm9eI9ZQYqpCtmJlETdMwO7AE9fx05pBtc+jmx7L4T
	Ww2NauwEfQDczkmIwMjQnd42s4Fg=
X-Google-Smtp-Source: AGHT+IGOFrA8BORH1lrZai9uzR4jQVe3Xr7M5V6raCquF3aTBK+AZJv5OSZMmT9HE6qg7PHykUqSgfyPKGDZIXpjchQ=
X-Received: by 2002:a05:6122:1826:b0:502:6d58:4501 with SMTP id
 71dfb90a1353d-503e03c1293mr1562857e0c.2.1726795070694; Thu, 19 Sep 2024
 18:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914063746.46290-1-21cnbao@gmail.com> <02ff6c8e2199487b9d43ad2aa1fd813a@honor.com>
In-Reply-To: <02ff6c8e2199487b9d43ad2aa1fd813a@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 20 Sep 2024 13:17:39 +1200
Message-ID: <CAGsJ_4ygV+VgyyLRinutgaA3oj1NZbukyGbc1tq0BC=3Ncd=qg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
To: gaoxu <gaoxu2@honor.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"mhocko@suse.com" <mhocko@suse.com>, fengbaopeng <fengbaopeng@honor.com>, 
	"hailong.liu@oppo.com" <hailong.liu@oppo.com>, "kaleshsingh@google.com" <kaleshsingh@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lokeshgidra@google.com" <lokeshgidra@google.com>, "ngeoffray@google.com" <ngeoffray@google.com>, 
	"shli@fb.com" <shli@fb.com>, "surenb@google.com" <surenb@google.com>, yipengxiang <yipengxiang@honor.com>, 
	"david@redhat.com" <david@redhat.com>, "yuzhao@google.com" <yuzhao@google.com>, 
	"minchan@kernel.org" <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 6:19=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This follows up on the discussion regarding Gaoxu's work[1]. It's
> > unclear if there's still interest in implementing a separate LRU
> > list for lazyfree folios, but I decided to explore it out of
> > curiosity.
> >
> > According to Lokesh, MADV_FREE'd anon folios are expected to be
> > released earlier than file folios. One option, as implemented
> > by Gao Xu, is to place lazyfree anon folios at the tail of the
> > file's `min_seq` generation. However, this approach results in
> > lazyfree folios being released in a LIFO manner, which conflicts
> > with LRU behavior, as noted by Michal.
> >
> > To address this, this patch proposes maintaining a separate list
> > for lazyfree anon folios while keeping them classified under the
> > "file" LRU type to minimize code changes. These lazyfree anon
> > folios will still be counted as file folios and share the same
> > generation with regular files. In the eviction path, the lazyfree
> > list will be prioritized for scanning before the actual file
> > LRU list.
> It seems like a very feasible solution. I will conduct comparative tests
> based on this patch and synchronize the test results (it will take some t=
ime);
> Thanks to Barry for providing the patch=EF=BC=81

Thank you, I will await your test results.

> >
> > [1]
> > https://lore.kernel.org/linux-mm/f29f64e29c08427b95e3df30a5770056@honor
> > .com/
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/mm_inline.h |  5 +-
> >  include/linux/mmzone.h    |  2 +-
> >  mm/vmscan.c               | 97 +++++++++++++++++++++++----------------
> >  3 files changed, 61 insertions(+), 43 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index f4fe593c1400..118d70ed3120 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -225,6 +225,7 @@ static inline bool lru_gen_add_folio(struct lruvec
> > *lruvec, struct folio *folio,
> >       int gen =3D folio_lru_gen(folio);
> >       int type =3D folio_is_file_lru(folio);
> >       int zone =3D folio_zonenum(folio);
> > +     int lazyfree =3D type ? folio_test_anon(folio) : 0;
> >       struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> >
> >       VM_WARN_ON_ONCE_FOLIO(gen !=3D -1, folio);
> > @@ -262,9 +263,9 @@ static inline bool lru_gen_add_folio(struct lruvec
> > *lruvec, struct folio *folio,
> >       lru_gen_update_size(lruvec, folio, -1, gen);
> >       /* for folio_rotate_reclaimable() */
> >       if (reclaiming)
> > -             list_add_tail(&folio->lru, &lrugen->folios[gen][type][zon=
e]);
> > +             list_add_tail(&folio->lru, &lrugen->folios[gen][type + la=
zyfree][zone]);
> >       else
> > -             list_add(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +             list_add(&folio->lru, &lrugen->folios[gen][type + lazyfre=
e][zone]);
> >
> >       return true;
> >  }
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 17506e4a2835..5d2331778528 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -434,7 +434,7 @@ struct lru_gen_folio {
> >       /* the birth time of each generation in jiffies */
> >       unsigned long timestamps[MAX_NR_GENS];
> >       /* the multi-gen LRU lists, lazily sorted on eviction */
> > -     struct list_head
> > folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> > +     struct list_head folios[MAX_NR_GENS][ANON_AND_FILE +
> > 1][MAX_NR_ZONES];
> For better understanding and future scalability, could use enum types
> instead of numbers, Create a new type, such as: enum folio_type.

I'd rather follow the "trick" that Yu Zhao has been using such as
int type =3D folio_is_file_lru(folio);
while I agree providing two macros as below
#define LRU_TYPE_ANON 0
#define LRU_TYPE_FILE   1

might improve the readability by things like:

int list_num =3D (type  =3D=3D LRU_TYPE_FILE) ? 2 : 1;

However, considering the code in a larger context, since type =3D
folio_is_file_lru(folio),
doesn't that imply that type is already set to file? Therefore, the compari=
son
type =3D=3D LRU_TYPE_FILE seems redundant.

So, if we want to continue using this approach, it seems that there=E2=80=
=99s nothing
worth changing?

> >       /* the multi-gen LRU sizes, eventually consistent */
> >       long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> >       /* the exponential moving average of refaulted */
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 96abf4a52382..9dc665dc6ba9 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3725,21 +3725,25 @@ static bool inc_min_seq(struct lruvec *lruvec, =
int
> > type, bool can_swap)
> >
> >       /* prevent cold/hot inversion if force_scan is true */
> >       for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> > -             struct list_head *head =3D &lrugen->folios[old_gen][type]=
[zone];
> > +             int list_num =3D type ? 2 : 1;
> > +             struct list_head *head;
> >
> > -             while (!list_empty(head)) {
> > -                     struct folio *folio =3D lru_to_folio(head);
> > +             for (int i =3D list_num - 1; i >=3D 0; i--) {
> > +                     head =3D &lrugen->folios[old_gen][type + i][zone]=
;
> > +                     while (!list_empty(head)) {
> > +                             struct folio *folio =3D lru_to_folio(head=
);
> >
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o),
> > folio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), f=
olio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type,
> > folio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one,
> > folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_test_unevicta=
ble(folio),
> > folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_test_active(f=
olio), folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(f=
olio) !=3D type,
> > folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio=
) !=3D zone,
> > folio);
> >
> > -                     new_gen =3D folio_inc_gen(lruvec, folio, false);
> > -                     list_move_tail(&folio->lru,
> > &lrugen->folios[new_gen][type][zone]);
> > +                             new_gen =3D folio_inc_gen(lruvec, folio, =
false);
> > +                             list_move_tail(&folio->lru, &lrugen->foli=
os[new_gen][type +
> > i][zone]);
> >
> > -                     if (!--remaining)
> > -                             return false;
> > +                             if (!--remaining)
> > +                                     return false;
> > +                     }
> >               }
> >       }
> >  done:
> > @@ -4291,6 +4295,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio
> > *folio, struct scan_c
> >       int refs =3D folio_lru_refs(folio);
> >       int tier =3D lru_tier_from_refs(refs);
> >       struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > +     int lazyfree =3D type ? folio_test_anon(folio) : 0;
> >
> >       VM_WARN_ON_ONCE_FOLIO(gen >=3D MAX_NR_GENS, folio);
> >
> > @@ -4306,7 +4311,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio
> > *folio, struct scan_c
> >
> >       /* promoted */
> >       if (gen !=3D lru_gen_from_seq(lrugen->min_seq[type])) {
> > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +             list_move(&folio->lru, &lrugen->folios[gen][type + lazyfr=
ee][zone]);
> >               return true;
> >       }
> >
> > @@ -4315,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio
> > *folio, struct scan_c
> >               int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
> >
> >               gen =3D folio_inc_gen(lruvec, folio, false);
> > -             list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> > +             list_move_tail(&folio->lru, &lrugen->folios[gen][type +
> > lazyfree][zone]);
> >
> >               WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
> >                          lrugen->protected[hist][type][tier - 1] + delt=
a);
> > @@ -4325,7 +4330,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio
> > *folio, struct scan_c
> >       /* ineligible */
> >       if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
> >               gen =3D folio_inc_gen(lruvec, folio, false);
> > -             list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> > +             list_move_tail(&folio->lru, &lrugen->folios[gen][type +
> > lazyfree][zone]);
> >               return true;
> >       }
> >
> > @@ -4333,7 +4338,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio
> > *folio, struct scan_c
> >       if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> >           (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> >               gen =3D folio_inc_gen(lruvec, folio, true);
> > -             list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> > +             list_move(&folio->lru, &lrugen->folios[gen][type + lazyfr=
ee][zone]);
> >               return true;
> >       }
> >
> > @@ -4377,7 +4382,7 @@ static bool isolate_folio(struct lruvec *lruvec, =
struct
> > folio *folio, struct sca
> >  static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
> >                      int type, int tier, struct list_head *list)
> >  {
> > -     int i;
> > +     int i, j;
> >       int gen;
> >       enum vm_event_item item;
> >       int sorted =3D 0;
> > @@ -4399,33 +4404,38 @@ static int scan_folios(struct lruvec *lruvec, s=
truct
> > scan_control *sc,
> >               LIST_HEAD(moved);
> >               int skipped_zone =3D 0;
> >               int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
> > -             struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
> > -
> > -             while (!list_empty(head)) {
> > -                     struct folio *folio =3D lru_to_folio(head);
> > -                     int delta =3D folio_nr_pages(folio);
> > -
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o),
> > folio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), f=
olio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type,
> > folio);
> > -                     VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one,
> > folio);
> > -
> > -                     scanned +=3D delta;
> > +             int list_num =3D type ? 2 : 1;
> > +             struct list_head *head;
> > +
> > +             for (j =3D list_num - 1; j >=3D 0; j--) {
> > +                     head =3D &lrugen->folios[gen][type + j][zone];
> > +                     while (!list_empty(head)) {
> > +                             struct folio *folio =3D lru_to_folio(head=
);
> > +                             int delta =3D folio_nr_pages(folio);
> > +
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_test_unevicta=
ble(folio),
> > folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_test_active(f=
olio), folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(f=
olio) !=3D type,
> > folio);
> > +                             VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio=
) !=3D zone,
> > folio);
> > +
> > +                             scanned +=3D delta;
> > +
> > +                             if (sort_folio(lruvec, folio, sc, tier))
> > +                                     sorted +=3D delta;
> > +                             else if (isolate_folio(lruvec, folio, sc)=
) {
> > +                                     list_add(&folio->lru, list);
> > +                                     isolated +=3D delta;
> > +                             } else {
> > +                                     list_move(&folio->lru, &moved);
> > +                                     skipped_zone +=3D delta;
> > +                             }
> >
> > -                     if (sort_folio(lruvec, folio, sc, tier))
> > -                             sorted +=3D delta;
> > -                     else if (isolate_folio(lruvec, folio, sc)) {
> > -                             list_add(&folio->lru, list);
> > -                             isolated +=3D delta;
> > -                     } else {
> > -                             list_move(&folio->lru, &moved);
> > -                             skipped_zone +=3D delta;
> > +                             if (!--remaining || max(isolated, skipped=
_zone) >=3D
> > MIN_LRU_BATCH)
> > +                                     goto isolate_done;
> >                       }
> > -
> > -                     if (!--remaining || max(isolated, skipped_zone) >=
=3D
> > MIN_LRU_BATCH)
> > -                             break;
> >               }
> >
> > +isolate_done:
> >               if (skipped_zone) {
> >                       list_splice(&moved, head);
> >                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_=
zone);
> > @@ -5586,8 +5596,15 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
> >       for (i =3D 0; i <=3D MIN_NR_GENS + 1; i++)
> >               lrugen->timestamps[i] =3D jiffies;
> >
> > -     for_each_gen_type_zone(gen, type, zone)
> > +     for_each_gen_type_zone(gen, type, zone) {
> >               INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
> > +             /*
> > +              * lazyfree anon folios have a separate list while using
> > +              * file as type
> > +              */
> > +             if (type)
> > +                     INIT_LIST_HEAD(&lrugen->folios[gen][type + 1][zon=
e]);
> > +     }
> >
> >       if (mm_state)
> >               mm_state->seq =3D MIN_NR_GENS;
> > --
> > 2.39.3 (Apple Git-146)
>

Thanks
Barry

