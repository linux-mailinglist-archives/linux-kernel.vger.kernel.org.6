Return-Path: <linux-kernel+bounces-380436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D319AEE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0C1F23110
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ADF1FE0E8;
	Thu, 24 Oct 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7s1IAvt"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DB1EF958;
	Thu, 24 Oct 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792127; cv=none; b=lFUxs9GTu7P3gXQTsdaAcCpXZQqM1fJFci7EMNAuBE+OL4qajqcGq0GqpLNDyKl1DBowiq5hOG4n4g4wQsatinznm19160/Y9u7VXnM0HDf0OSy84GI65jzs8jXf3nPK6Qs68LIHGfLOlCdE1Tb5GncZVgCZ3Ysw/oDBu3OLVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792127; c=relaxed/simple;
	bh=DYuX86PP06V43+6J0dDID5S4JWzMob+QAdvqzV8uJCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG2OWQSzJyfqIKPPwhsErMpQxG7rOLNE/k7vmthKI9El4cra4A8X1QBSzSIE2h8cWwfnZm4WRd2FAmpTVywXU6W1H6DFQL6Xefu8W+4RWq4fh8LAloX3RVA4O4lZXMhiCwil9p/zO0qVtOPj8BMuEtdCyucwGkvMfAkak0o/9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7s1IAvt; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50fc0345155so657938e0c.1;
        Thu, 24 Oct 2024 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792124; x=1730396924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26VSrA0gvzcuHws0bkRVD6tE0qvL6sGoOvCQVrQ+2Q=;
        b=T7s1IAvta1cn9+plaPaOz0hxjtqji6Fgn/vzktKzmOMPUNs9+AjKpkmHzqMw+TVzMy
         IH7/b7Ko358OeCmhSMDOOiwMSlFeiw3plPbHiu+D//T8s3uxgebN0JPHGByVZ9s6R1Yx
         EyFtGdNDpCOIG5i0lsebN30N3ISMuVV2Zsl7rQ/Slqd01zkcK6qfmZv4P+oEm+S0BUFk
         eBi4e9axqunXjChygxOYO9hrzI8mlb4ayRat3j+DaPh0aXQAymGOrC8mTgm55EtuojsY
         rtKdX1gkTsjB5UrlSIK/9X6miyTnONJhU6fzuUxSr7m904iO9s0IVv10S3IMudny+sSB
         4XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792124; x=1730396924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y26VSrA0gvzcuHws0bkRVD6tE0qvL6sGoOvCQVrQ+2Q=;
        b=qZMbJ1FxOjvOvDjKDoDMP4llqjIR4TqiPup8FjAO8ZIwkDRk2xrNGFnfknzUd4GIYz
         9ZJ0VevxBOylaEg/jcZT0GclOj3je7ol121wmpPK2++Odmll+W/sooBRYh1/Ot99q1xn
         NZ8EMLLUwqNnXlX+Fd2EJzeBJ/acUiUzWYyzAiMEA5UvvWh0W6SMV4o87CXjEun/7FRo
         kTkrYv+SYbuT7ZeIbSAwWvJDOsXusv6TogJmeB2BS7v3oIluBn5DpRuUKBIy3IY5d7ET
         ZpTYwjglnBPhLbpmxqJ8nyr3WhCd8rbBXyB6sJXQtxvsSOlRlVAKDX3dfi9jrPbWPhak
         a2MA==
X-Forwarded-Encrypted: i=1; AJvYcCUV5Q6siRnFQ+0YCcjuNvWCOyIsLk7XwzXAx1uKiTSbCYlZUHbGxc0BZ1OsdXrjkdhGp48/fOl4P3o=@vger.kernel.org, AJvYcCWZNodUk6DZsVv/o0z9dCYvofyrtClbMNAtOvXf9MnPrTKvwS6GqnLogZs6QwaWa7PZA61Dx4E/YyRbq9CM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7k6L9OO5C1hs8Kja7SOPEg9PQPUZ4MdQy3r3Tk+CCtPMS9NuB
	nLJ5uMehK4qKq2Y1gqsGyiZT8vTj4yio2TXQebFcmPpCzc099COqcQ9F9noGe+JCvUlKDyWp0Te
	F0G2DThoFWEVV2NZSBYA/l9x/5S4=
X-Google-Smtp-Source: AGHT+IGV9GbAkt4FHb/2gl8kB1oIGDVhCYRqdYecm3LmyYRUDSRbQl6WYaH0GJ1fpFtDy3v+/YIkAE/90WZif31sxMU=
X-Received: by 2002:a05:6122:922:b0:50a:cbdb:b929 with SMTP id
 71dfb90a1353d-50feb3002ffmr2884647e0c.2.1729792123560; Thu, 24 Oct 2024
 10:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
 <20241023233548.23348-1-21cnbao@gmail.com> <20241024142942.GA279597@cmpxchg.org>
In-Reply-To: <20241024142942.GA279597@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 25 Oct 2024 06:48:31 +1300
Message-ID: <CAGsJ_4zf=mnEv1LSrvXXtTJjMPKB7SnWB2Jni=6EXEbqxHiL=Q@mail.gmail.com>
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hanchuanhua@oppo.com, 
	kanchana.p.sridhar@intel.com, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, 
	nphamcs@gmail.com, riel@surriel.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:29=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Oct 24, 2024 at 12:35:48PM +1300, Barry Song wrote:
> > On Thu, Oct 24, 2024 at 9:36=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Thu, Oct 24, 2024 at 8:47=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> > > >
> > > >
> > > >
> > > > On 23/10/2024 19:52, Barry Song wrote:
> > > > > On Thu, Oct 24, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@=
gmail.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 23/10/2024 19:02, Yosry Ahmed wrote:
> > > > >>> [..]
> > > > >>>>>> I suspect the regression occurs because you're running an ed=
ge case
> > > > >>>>>> where the memory cgroup stays nearly full most of the time (=
this isn't
> > > > >>>>>> an inherent issue with large folio swap-in). As a result, sw=
apping in
> > > > >>>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. =
The
> > > > >>>>>> next swap-in then recreates the overflow, leading to a repea=
ting
> > > > >>>>>> cycle.
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> Yes, agreed! Looking at the swap counters, I think this is wh=
at is going
> > > > >>>>> on as well.
> > > > >>>>>
> > > > >>>>>> We need a way to stop the cup from repeatedly filling to the=
 brim and
> > > > >>>>>> overflowing. While not a definitive fix, the following chang=
e might help
> > > > >>>>>> improve the situation:
> > > > >>>>>>
> > > > >>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > >>>>>>
> > > > >>>>>> index 17af08367c68..f2fa0eeb2d9a 100644
> > > > >>>>>> --- a/mm/memcontrol.c
> > > > >>>>>> +++ b/mm/memcontrol.c
> > > > >>>>>>
> > > > >>>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(st=
ruct folio
> > > > >>>>>> *folio, struct mm_struct *mm,
> > > > >>>>>>                 memcg =3D get_mem_cgroup_from_mm(mm);
> > > > >>>>>>         rcu_read_unlock();
> > > > >>>>>>
> > > > >>>>>> -       ret =3D charge_memcg(folio, memcg, gfp);
> > > > >>>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(mem=
cg) <
> > > > >>>>>> MEMCG_CHARGE_BATCH)
> > > > >>>>>> +               ret =3D -ENOMEM;
> > > > >>>>>> +       else
> > > > >>>>>> +               ret =3D charge_memcg(folio, memcg, gfp);
> > > > >>>>>>
> > > > >>>>>>         css_put(&memcg->css);
> > > > >>>>>>         return ret;
> > > > >>>>>> }
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> The diff makes sense to me. Let me test later today and get b=
ack to you.
> > > > >>>>>
> > > > >>>>> Thanks!
> > > > >>>>>
> > > > >>>>>> Please confirm if it makes the kernel build with memcg limit=
ation
> > > > >>>>>> faster. If so, let's
> > > > >>>>>> work together to figure out an official patch :-) The above =
code hasn't consider
> > > > >>>>>> the parent memcg's overflow, so not an ideal fix.
> > > > >>>>>>
> > > > >>>>
> > > > >>>> Thanks Barry, I think this fixes the regression, and even give=
s an improvement!
> > > > >>>> I think the below might be better to do:
> > > > >>>>
> > > > >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > >>>> index c098fd7f5c5e..0a1ec55cc079 100644
> > > > >>>> --- a/mm/memcontrol.c
> > > > >>>> +++ b/mm/memcontrol.c
> > > > >>>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(stru=
ct folio *folio, struct mm_struct *mm,
> > > > >>>>                 memcg =3D get_mem_cgroup_from_mm(mm);
> > > > >>>>         rcu_read_unlock();
> > > > >>>>
> > > > >>>> -       ret =3D charge_memcg(folio, memcg, gfp);
> > > > >>>> +       if (folio_test_large(folio) &&
> > > > >>>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH,=
 folio_nr_pages(folio)))
> > > > >>>> +               ret =3D -ENOMEM;
> > > > >>>> +       else
> > > > >>>> +               ret =3D charge_memcg(folio, memcg, gfp);
> > > > >>>>
> > > > >>>>         css_put(&memcg->css);
> > > > >>>>         return ret;
> > > > >>>>
> > > > >>>>
> > > > >>>> AMD 16K+32K THP=3Dalways
> > > > >>>> metric         mm-unstable      mm-unstable + large folio zswa=
pin series    mm-unstable + large folio zswapin + no swap thrashing fix
> > > > >>>> real           1m23.038s        1m23.050s                     =
              1m22.704s
> > > > >>>> user           53m57.210s       53m53.437s                    =
              53m52.577s
> > > > >>>> sys            7m24.592s        7m48.843s                     =
              7m22.519s
> > > > >>>> zswpin         612070           999244                        =
              815934
> > > > >>>> zswpout        2226403          2347979                       =
              2054980
> > > > >>>> pgfault        20667366         20481728                      =
              20478690
> > > > >>>> pgmajfault     385887           269117                        =
              309702
> > > > >>>>
> > > > >>>> AMD 16K+32K+64K THP=3Dalways
> > > > >>>> metric         mm-unstable      mm-unstable + large folio zswa=
pin series   mm-unstable + large folio zswapin + no swap thrashing fix
> > > > >>>> real           1m22.975s        1m23.266s                     =
             1m22.549s
> > > > >>>> user           53m51.302s       53m51.069s                    =
             53m46.471s
> > > > >>>> sys            7m40.168s        7m57.104s                     =
             7m25.012s
> > > > >>>> zswpin         676492           1258573                       =
             1225703
> > > > >>>> zswpout        2449839          2714767                       =
             2899178
> > > > >>>> pgfault        17540746         17296555                      =
             17234663
> > > > >>>> pgmajfault     429629           307495                        =
             287859
> > > > >>>>
> > > > >>>
> > > > >>> Thanks Usama and Barry for looking into this. It seems like thi=
s would
> > > > >>> fix a regression with large folio swapin regardless of zswap. C=
an the
> > > > >>> same result be reproduced on zram without this series?
> > > > >>
> > > > >>
> > > > >> Yes, its a regression in large folio swapin support regardless o=
f zswap/zram.
> > > > >>
> > > > >> Need to do 3 tests, one with probably the below diff to remove l=
arge folio support,
> > > > >> one with current upstream and one with upstream + swap thrashing=
 fix.
> > > > >>
> > > > >> We only use zswap and dont have a zram setup (and I am a bit laz=
y to create one :)).
> > > > >> Any zram volunteers to try this?
> > > > >
> > > > > Hi Usama,
> > > > >
> > > > > I tried a quick experiment:
> > > > >
> > > > > echo 1 > /sys/module/zswap/parameters/enabled
> > > > > echo 0 > /sys/module/zswap/parameters/enabled
> > > > >
> > > > > This was to test the zRAM scenario. Enabling zswap even
> > > > > once disables mTHP swap-in. :)
> > > > >
> > > > > I noticed a similar regression with zRAM alone, but the change re=
solved
> > > > > the issue and even sped up the kernel build compared to the setup=
 without
> > > > > mTHP swap-in.
> > > >
> > > > Thanks for trying, this is amazing!
> > > > >
> > > > > However, I=E2=80=99m still working on a proper patch to address t=
his. The current
> > > > > approach:
> > > > >
> > > > > mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages=
(folio))
> > > > >
> > > > > isn=E2=80=99t sufficient, as it doesn=E2=80=99t cover cases where=
 group A contains group B, and
> > > > > we=E2=80=99re operating within group B. The problem occurs not at=
 the boundary of
> > > > > group B but at the boundary of group A.
> > > >
> > > > I am not sure I completely followed this. As MEMCG_CHARGE_BATCH=3D6=
4, if we are
> > > > trying to swapin a 16kB page, we basically check if atleast 64/4 =
=3D 16 folios can be
> > > > charged to cgroup, which is reasonable. If we try to swapin a 1M fo=
lio, we just
> > > > check if we can charge atleast 1 folio. Are you saying that checkin=
g just 1 folio
> > > > is not enough in this case and can still cause thrashing, i.e we sh=
ould check more?
> > >
> > > My understanding is that cgroups are hierarchical. Even if we don=E2=
=80=99t
> > > hit the memory
> > >  limit of the folio=E2=80=99s direct memcg, we could still reach the =
limit of
> > > one of its parent
> > > memcgs. Imagine a structure like:
> > >
> > > /sys/fs/cgroup/a/b/c/d
> > >
> > > If we=E2=80=99re compiling the kernel in d, there=E2=80=99s a chance =
that while d
> > > isn=E2=80=99t at its limit, its
> > > parents (c, b, or a) could be. Currently, the check only applies to d=
.
> >
> > To clarify, I mean something like this:
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17af08367c68..cc6d21848ee8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4530,6 +4530,29 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgr=
oup *memcg, gfp_t gfp,
> >       return 0;
> >  }
> >
> > +/*
> > + * When the memory cgroup is nearly full, swapping in large folios can
> > + * easily lead to swap thrashing, as the memcg operates on the edge of
> > + * being full. We maintain a margin to allow for quick fallback to
> > + * smaller folios during the swap-in process.
> > + */
> > +static inline bool mem_cgroup_swapin_margin_protected(struct mem_cgrou=
p *memcg,
> > +             struct folio *folio)
> > +{
> > +     unsigned int nr;
> > +
> > +     if (!folio_test_large(folio))
> > +             return false;
> > +
> > +     nr =3D max_t(unsigned int, folio_nr_pages(folio), MEMCG_CHARGE_BA=
TCH);
> > +     for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgroup(me=
mcg)) {
> > +             if (mem_cgroup_margin(memcg) < nr)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /**
> >   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for=
 swapin.
> >   * @folio: folio to charge.
> > @@ -4547,7 +4570,8 @@ int mem_cgroup_swapin_charge_folio(struct folio *=
folio, struct mm_struct *mm,
> >  {
> >       struct mem_cgroup *memcg;
> >       unsigned short id;
> > -     int ret;
> > +     int ret =3D -ENOMEM;
> > +     bool margin_prot;
> >
> >       if (mem_cgroup_disabled())
> >               return 0;
> > @@ -4557,9 +4581,11 @@ int mem_cgroup_swapin_charge_folio(struct folio =
*folio, struct mm_struct *mm,
> >       memcg =3D mem_cgroup_from_id(id);
> >       if (!memcg || !css_tryget_online(&memcg->css))
> >               memcg =3D get_mem_cgroup_from_mm(mm);
> > +     margin_prot =3D mem_cgroup_swapin_margin_protected(memcg, folio);
> >       rcu_read_unlock();
> >
> > -     ret =3D charge_memcg(folio, memcg, gfp);
> > +     if (!margin_prot)
> > +             ret =3D charge_memcg(folio, memcg, gfp);
> >
> >       css_put(&memcg->css);
> >       return ret;
>
> I'm not quite following.
>
> The charging code DOES the margin check. If you just want to avoid
> reclaim, pass gfp without __GFP_DIRECT_RECLAIM, and it will return
> -ENOMEM if there is no margin.
>
> alloc_swap_folio() passes the THP mask, which should not include the
> reclaim flag per default (GFP_TRANSHUGE_LIGHT). Unless you run with
> defrag=3Dalways. Is that what's going on?

No, quite sure "defrag=3Dnever" can just achieve the same result. Imagine w=
e only
have small folios=E2=80=94each time reclamation occurs, we have at least a
SWAP_CLUSTER_MAX buffer before the next reclamation is triggered.

 .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX),

However, with large folios, we can quickly exhaust the SWAP_CLUSTER_MAX
buffer and reach the next reclamation point.
Once we consume SWAP_CLUSTER_MAX - 1, the mem_cgroup_swapin_charge_folio()
call for the final small folio with GFP_KERNEL will trigger reclamation.
        if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
                                           GFP_KERNEL, entry)) {

Thanks
Barry

