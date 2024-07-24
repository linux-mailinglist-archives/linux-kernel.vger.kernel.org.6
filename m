Return-Path: <linux-kernel+bounces-261590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F393B977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF841C21905
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1381428E0;
	Wed, 24 Jul 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+ZpmtQQ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90713B58C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864176; cv=none; b=fLOABZaU4N/1rgVW4E5F40t29hDVfei9P2jDqmB/QqhciBxvvcudzPkss+EwmzWPthtQXuspfuq9tZqZu8HuFzRozMAix3SkkYRjMlDg14OChG8bzuryOhOFq2DFr8dl0ynGEKxeFt55T9Tds4YR6VB8V9EYQ8oLvzuCmPeBGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864176; c=relaxed/simple;
	bh=mAudy6PfnoQxmF7B9vUdy3Oyl/tkXuBpwUXNXx4bH4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGutp7b1Ji0tfEc5E6JA6fBkTYXNQ+GbyezAYapEhpK2FIs/DlyutsOpZdt3EtVUqaoc2UC6VKrPhr0pvQ9Ew7DW0sMFi12QZy2lp287btGEHLmetdS+v8O9gzh/ysBt3Kn2ScjIWXRrJH/DSLaHFuPig89WMzNz27uXzFVxesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+ZpmtQQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f024f468bso287631e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721864172; x=1722468972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z14TG9ioLTTUthPr+yZnTAKsDPH8dPhxP34WA6DWGI=;
        b=f+ZpmtQQVn3PhZrJ5H79y9P2TsxJeciGrKDzZyw/3GTjueIVTalGgxp5xtQkV04ps/
         Tt5EouhQ+BlmPa0hNsPowame7GhwuBJj/OHWlVi80tbdH7wSHphogRUepkX4EYrkED8r
         1fQAo6tJjGdZrAbFWTlt3Qf1U4x4pZoCvX4YaehiooEhWoYv48pqFhvkns7fpPzO99Uy
         VSZrU9UtQReieTQMF5ccTvRRQFnUYhOf08xafSbzR/HsIlDIFvBnT1+dhse2qoVui57n
         grHTkWSYeWnMxSxown5qEPSEKJblCHpIAlSsTGwYvHoOzHIFkW3UE7bP+A4dj4UcOzSk
         IwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721864172; x=1722468972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z14TG9ioLTTUthPr+yZnTAKsDPH8dPhxP34WA6DWGI=;
        b=S5nuCKi0+bGkLOft31JiW7wyWn1C/h9u6okuVpz+xMGsLroAR7/+ayv4f87x93P4qG
         IkWLueHQpLKTr1UPJMNH6CGA3099nZv9J0jqazJn7IBBRttwy4AmdfSuKA1NGwoz2xc6
         0ublFHLUh5DuptMX0X+p36LyIFC8nkulXkwlOemlcalLDLtK/SUzzenVWdEapyue+pcw
         lwp8h2HsVMrJix2DSR4chGBOFA4bZyqOdgfdPL31Hp+6s7+Clpp2cmua+kxzS0aDHLzM
         Foee8NLSHB5/xJwkHwkE1EEpyOd9hUU75702R8W5Pka3TwDezGBomVZLjxIRmfP8uJR9
         Bs9w==
X-Forwarded-Encrypted: i=1; AJvYcCWsj4DJiz+jV2sLO2UjSZrfGcf+kAbx3MxTfrnH/JBq3bDg0s+d1ks4i7p+iQc8t86h/Bh0m+je1t1TzUW5eInJWQgOVptPY6po2PV+
X-Gm-Message-State: AOJu0YykYDGiDviKEG+ajUNKazIkbgfFimS2Uedor2f/71ZjoAhv4C1A
	gpKkvcb3/HgYScwjgK4xhympPHep4h0PoBQyUp6/i8A+TBOFGODaiSSjKnKKhAOl1rgakq3sIdr
	bKycYX908rKN+FN7nhvSotE2uwAmfEbAn4X2o
X-Google-Smtp-Source: AGHT+IGCWS0jFUejC8Nzs7Lc+2SXRvrtXA7Nz3f6ntT2JmGEMIeIIzGjTLtivQUEp0ahRgP4rBevjanPg2hd9f1ozAk=
X-Received: by 2002:a05:6512:32c9:b0:52d:582e:4117 with SMTP id
 2adb3069b0e04-52fd608f044mr91074e87.54.1721864171356; Wed, 24 Jul 2024
 16:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-2-roman.gushchin@linux.dev> <CAJD7tkYOgYMKp+u97wm6biA+C_2BR-B2hy6zi=cVqHovUxLTRA@mail.gmail.com>
 <ZqGO7jtUCM2tG_QZ@google.com>
In-Reply-To: <ZqGO7jtUCM2tG_QZ@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jul 2024 16:35:35 -0700
Message-ID: <CAJD7tkbSaSLOaxM_ZNQjSzBR1HMVSWB14g+ekXRkb==hjvG0Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: memcg: don't call propagate_protected_usage() needlessly
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:32=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Jul 24, 2024 at 04:13:17PM -0700, Yosry Ahmed wrote:
> > On Wed, Jul 24, 2024 at 1:21=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > >
> > > Memory protection (min/low) requires a constant tracking of
> > > protected memory usage. propagate_protected_usage() is called
> > > on each page counters update and does a number of operations
> > > even in cases when the actual memory protection functionality
> > > is not supported (e.g. hugetlb cgroups or memcg swap counters).
> > >
> > > It's obviously inefficient and leads to a waste of CPU cycles.
> > > It can be addressed by calling propagate_protected_usage() only
> > > for the counters which do support memory guarantees. As of now
> > > it's only memcg->memory - the unified memory memcg counter.
> > >
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  include/linux/page_counter.h |  8 +++++++-
> > >  mm/hugetlb_cgroup.c          |  4 ++--
> > >  mm/memcontrol.c              | 16 ++++++++--------
> > >  mm/page_counter.c            | 16 +++++++++++++---
> > >  4 files changed, 30 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/include/linux/page_counter.h b/include/linux/page_counte=
r.h
> > > index 860f313182e7..b31fd5b208aa 100644
> > > --- a/include/linux/page_counter.h
> > > +++ b/include/linux/page_counter.h
> > > @@ -32,6 +32,7 @@ struct page_counter {
> > >         /* Keep all the read most fields in a separete cacheline. */
> > >         CACHELINE_PADDING(_pad2_);
> > >
> > > +       bool protection_support;
> > >         unsigned long min;
> > >         unsigned long low;
> > >         unsigned long high;
> > > @@ -45,12 +46,17 @@ struct page_counter {
> > >  #define PAGE_COUNTER_MAX (LONG_MAX / PAGE_SIZE)
> > >  #endif
> > >
> > > +/*
> > > + * Protection is supported only for the first counter (with id 0).
> > > + */
> > >  static inline void page_counter_init(struct page_counter *counter,
> > > -                                    struct page_counter *parent)
> > > +                                    struct page_counter *parent,
> > > +                                    bool protection_support)
> >
> > Would it be better to make this an internal helper (e.g.
> > __page_counter_init()), and add another API function that passes in
> > protection_support=3Dtrue, for example:
> >
> > static inline void page_counter_init_protected(..)
> > {
> >        __page_counter_init(.., true);
> > }
> >
> > This will get rid of the naked booleans at the callsites of
> > page_counter_init(), which are more difficult to interpret. It will
> > also reduce the diff as we only need to change the page_counter_init()
> > calls of memcg->memory.
> >
> > WDYT?
>
> No strong opinion here. There are basically 2 call sites and I don't expe=
ct
> this number to grow, so not sure if it makes sense to add 2 new helpers.
>
> Another option I thought about is to leave page_counter_init() as it is
> and add a separate function to enable the protection tracking.

Yeah this should work too, in fact it should give us a chance to
choose a more descriptive name that page_counter_init_protected()
(e.g. page_counter_enable_protection()).

My main concern is the naked booleans, and secondarily the unnecessary
diff to other init sites. I also don't feel strongly about it though.

>
> Thanks!

