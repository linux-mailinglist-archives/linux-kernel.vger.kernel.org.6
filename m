Return-Path: <linux-kernel+bounces-210408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3690434B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9011C213DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1CC1CAA4;
	Tue, 11 Jun 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL6/IoVb"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99E4F5F9;
	Tue, 11 Jun 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129718; cv=none; b=bHRPgJ4HicIZQAJNTOfpgHfyrHcGOGMiGXmmCtHZpVoPCUBubx7lrwGp+fL2hHWnCYIdcddmJw+/m4TtWAG8nIKUAvd5D5yO9Ojn4ShwEmJNf1wpTNtAs9S3zwxgyBlVPFSYwFZ2aWxLrehZMloVLvEV0Ej2mqNfXID9lt7zwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129718; c=relaxed/simple;
	bh=6ter9A29iljt2p01SMea/YwvMQNBAtZ/t4eQ1aElSTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBPyPqgi05xSB69AiZcOQUceDp+OIOYXiCO4KH1/HhA9u0PCojWOKQDmJtdunqCHJLV/en8LouqmCJtmfa5BpCh/jkYD3MeWUfmoqJ5Svyh0mWpFtSOKH825XUddbvJo/DIqOmXR7p/gJWFFFEaG9RLOXDD5ZSgak95ASgCawpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL6/IoVb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a08091c2bso18855197b3.0;
        Tue, 11 Jun 2024 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718129716; x=1718734516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14f966zVBiKsoEm0nil8946zXnPreZZGrr2tPrKZ4I4=;
        b=BL6/IoVbKoHzElZ3hLmJiwI3SaVIJbBP9NJ3xskgfbQdbQLO1kur/yhFgGH6vLErNN
         JGtUoxycC13sPM/2a86Ehrpe3bvZamNwHQxeO/iTdvn6x2zfoggXhkWL76zUiYMfiVrU
         BuNAcbTF6jvOAGcRwKReuFXju5ddcsO+fWPhjsGAQnPs6OxQwBXbqkJibn4wdDcUOs9Y
         3v/7oYfCV3oQqNd2z+1hAovYc858kWxcMAyQT8ddW8omDc29F6Vd71V078S2d/KrMERT
         YAD9FNrofEDg0bsSUZr/ZGTUZc6dlmdRBmqo4drqtwNZNhvtIL1a7wXm2gj/7b9nDMwY
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129716; x=1718734516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14f966zVBiKsoEm0nil8946zXnPreZZGrr2tPrKZ4I4=;
        b=BOT+rMn1f4YH4+LkmELcR6Meu83jILlMTcGhAarScqqeEzA1GtHK5tTu9aOImvmEXk
         jsuQcJpjA2BjJAJQ31Pd29M0KrBTxR4SSNC0+PDEOQJ5nKnFqH9bKjhWIYr4Oak8vGYf
         Yexb6xqQztATq5eLwwMonPaOy3lMYVXz6mlkcDgGtxv7nOCWNWyZssVRoKty0KLx9Svx
         jt8rek8J/U4SbqPY6zLDIxLqm8Khix6fztObkHFy/HP0TavsUFpNHtLJrKOEEpkwam0D
         pGoE6mvSnd6jeRf4pmXBuHaYSbOFFVAdjk0+o1yxKxriiln5mxkVWLhlTUhmBK0iaQGh
         YH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLJb32fEgvk6KON9dvuzmQ8vstWkmI9ivWBrFMTxc/niRSYC4CKLK8aGF/sz+1IcUAWziQVW9Y5ZnOii0nNFXFh3R4z3Is24Z0VKpn7CxrTwun8tdHZUShdGinXo1Rcv46glASB5Xk
X-Gm-Message-State: AOJu0YzK9NfuqRjDVaP4JLKg26rxKcJNzNK2ZOh8BmI/ViNMrxG7/pTZ
	6rco0b3YIiZLsdgOo6kcj31HxxajOox4NXxGpl43E+Nds1gSdKOnzekeAOe2C86esue65+NtvQW
	jQb4keF94XRgGO49mW3Qubipn23M=
X-Google-Smtp-Source: AGHT+IGJQzKrUtwgpXTD2YBmrKy4KAaGfAg2+NxxIhvC+ziLy+gmkCGfvVZN1Osa98tYSGutnyTwYZh+/tJEx0weIaw=
X-Received: by 2002:a81:4f87:0:b0:627:df2a:6306 with SMTP id
 00721157ae682-62cd55e0bb4mr127824657b3.21.1718129715813; Tue, 11 Jun 2024
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-3-flintglass@gmail.com>
 <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com>
In-Reply-To: <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 11:15:05 -0700
Message-ID: <CAKEwX=O4VEfO8f+GFDW_LL_=Ne6xgFEby2E+dxamhXKbFj0VAg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: zswap: fix global shrinker error handling logic
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:28=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.co=
m> wrote:
> >
> > This patch fixes zswap global shrinker that did not shrink zpool as
> > expected.
> >
> > The issue it addresses is that `shrink_worker()` did not distinguish
> > between unexpected errors and expected error codes that should be
> > skipped, such as when there is no stored page in a memcg. This led to
> > the shrinking process being aborted on the expected error codes.
> >
> > The shrinker should ignore these cases and skip to the next memcg.
> > However,  skipping all memcgs presents another problem. To address this=
,
> > this patch tracks progress while walking the memcg tree and checks for
> > progress once the tree walk is completed.
> >
> > To handle the empty memcg case, the helper function `shrink_memcg()` is
> > modified to check if the memcg is empty and then return -ENOENT.
> >
> > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > ---
> >  mm/zswap.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index d720a42069b6..1a90f434f247 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1393,7 +1393,7 @@ static struct shrinker *zswap_alloc_shrinker(void=
)
> >
> >  static int shrink_memcg(struct mem_cgroup *memcg)
> >  {
> > -       int nid, shrunk =3D 0;
> > +       int nid, shrunk =3D 0, stored =3D 0;
> >
> >         if (!mem_cgroup_zswap_writeback_enabled(memcg))
> >                 return -EINVAL;
> > @@ -1408,9 +1408,16 @@ static int shrink_memcg(struct mem_cgroup *memcg=
)
> >         for_each_node_state(nid, N_NORMAL_MEMORY) {
> >                 unsigned long nr_to_walk =3D 1;
> >
> > +               if (!list_lru_count_one(&zswap_list_lru, nid, memcg))
> > +                       continue;
> > +               ++stored;
> >                 shrunk +=3D list_lru_walk_one(&zswap_list_lru, nid, mem=
cg,
> >                                             &shrink_memcg_cb, NULL, &nr=
_to_walk);
> >         }
> > +
> > +       if (!stored)
> > +               return -ENOENT;
> > +
>
> Can't we just check nr_to_walk here and return -ENOENT if it remains as 1=
?
>
> Something like:
>
> if (nr_to_walk)
>     return -ENOENT;
> if (!shrunk)
>     return -EAGAIN;
> return 0;
>
> >         return shrunk ? 0 : -EAGAIN;
> >  }
> >
> > @@ -1418,12 +1425,18 @@ static void shrink_worker(struct work_struct *w=
)
> >  {
> >         struct mem_cgroup *memcg =3D NULL;
> >         struct mem_cgroup *next_memcg;
> > -       int ret, failures =3D 0;
> > +       int ret, failures =3D 0, progress;
> >         unsigned long thr;
> >
> >         /* Reclaim down to the accept threshold */
> >         thr =3D zswap_accept_thr_pages();
> >
> > +       /*
> > +        * We might start from the last memcg.
> > +        * That is not a failure.
> > +        */
> > +       progress =3D 1;
> > +
> >         /* global reclaim will select cgroup in a round-robin fashion.
> >          *
> >          * We save iteration cursor memcg into zswap_next_shrink,
> > @@ -1461,9 +1474,12 @@ static void shrink_worker(struct work_struct *w)
> >                  */
> >                 if (!memcg) {
> >                         spin_unlock(&zswap_shrink_lock);
> > -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > +
> > +                       /* tree walk completed but no progress */
> > +                       if (!progress && ++failures =3D=3D MAX_RECLAIM_=
RETRIES)
> >                                 break;
>
> It seems like we may keep iterating the entire hierarchy a lot of
> times as long as we are making any type of progress. This doesn't seem
> right.
>

Ah actually, reading your comment closer then yeah the
shrink-until-accept is the intended-ish behavior (from Domenico's
older patches to re-work zswap reclaim). The one-page-per-attempt is
also "intended" behavior, but not any of our's intentions - just
something that remains from the past implementation as we rework this
codebase one change at a time :)

