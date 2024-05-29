Return-Path: <linux-kernel+bounces-194122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137488D36EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBF528A9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B4D527;
	Wed, 29 May 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrEa4Tj4"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9D23AD;
	Wed, 29 May 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987616; cv=none; b=UgJLEZZ8vPvrpwQzXfQciDJer6mOTCSLui74iUZ2rKzj9Lrh+KH3sL7h8G4JJ5KzXCLgtjSF8BFUiB7wSfgsmMBrnePAEC89yJJITQNsDtSIqomF8yg5Lq4HzdmWv6kSg7jftUizAbQ3LN4/ySP16g2hQreedg2FQPkOpij1Yjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987616; c=relaxed/simple;
	bh=+7MAXcpEI2V0dn74e9ZJ+0ezqO0as0UObbIP44gwxOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsrtzOVkA2XopI2Ax6lwWPPb5RhxpRwHp7Oxd3fW8bIlQVYzJKa2OBP3bsoXSxDeSHam4DzbZSn+NkTwOFVRkfKfzPAQDY/XHGYLbiUcI3s6zwp/BvFVl+MaCEvnO1FNgT3CoSt1qA9oP1nID4pTalxpOu7wbTwhrfoKDgRs5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrEa4Tj4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a2424ecb8so18795737b3.1;
        Wed, 29 May 2024 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716987614; x=1717592414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8xSjHIJtxOZ2a/v+doe+8LgtILr0Bo4UnJUupQYDU8=;
        b=XrEa4Tj4PUqZ6PGzlD26vI04XWCDM8KSa6Wft/miSdo+5Tx8mHRCuOvHGXE5ZTWYd/
         rtWJ35qbFtPmoNR16FwobUe8EbV5NtTl2fxSnWZDFeMAsDwICZk9jXG7frs9/yFOWCZY
         By843T6Ql/jVYi3DWWpgrF06ux0mL6IHt3DZkUwi5V2skT4UTWKXZuzc4HyR5/E0aug7
         oKcDf2wh43TJ+RWnCg42Bwe1ue2rhJXEG4+m6fWBk7/l/G+1h0umkkpojqA0100BBwH0
         X4kkfyjhoU7fipxBP0wvT2IrN8CDvDizDRYmjOdZAk9VF/CnzDPIhd/8JRM67TvOUAQ/
         Cy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987614; x=1717592414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8xSjHIJtxOZ2a/v+doe+8LgtILr0Bo4UnJUupQYDU8=;
        b=nYrzdGPvaZpr6B0GYJBmrMIGI8DknankbS6aCtrrApmnSh+1N1JNEoQLekktzNQACp
         LGO/09w+M7YxvhZAMZ80iJSOrYAvqJLxY0hhF5AKvuw9CUSCGP6lqo8F4AIrIG2cNNHS
         PFUW3RKz9m9ljBGUx92CRh++voyasRkP9qJtzREL5D69S9FjS3ZrGW7xrYBlcHTCnDtA
         g3+sXT+iD1F+gGFYHtdqMPY+vIHb3hUx3+WS7KMKX4fHMz4RCnHpqP11ykU679B+T8QA
         RJKJ3FHJGmFwULQ3rp0PvOrrx3b8BOEuKJwRQP3Zi3f57cjuudmmujN5RixyIVlfeNHH
         HkYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9dMmDu6gotGIeSg/YTZFEuTw6jGS+O3tJJKAWw3HvSUyA5Kcfb9w6VQyf/sQt1d9FRDsSsj2YnH5p2nSrJ9TrOqff4xItDZwULqeFo/fInhP8GkZ4gRsOOa09AvBteCw5h2DvyJdh
X-Gm-Message-State: AOJu0YyAgGkRas4/rlw9Nhp/7TdJEJH/7oCNxntqUFUY3tgHpePb9MrA
	w8ydqKp7mdhQAACsisdDyqEjq068HtBkPZ9IauFnAUnajnEhbSW7RpkmwSwzW+xGkxC357H/Bsu
	Eqt7ssrRKU70DLK70A/L7ufQ34owN1FT5vVI=
X-Google-Smtp-Source: AGHT+IHec4C5468aehPFSf+H+IRsi2KOo7M1H9KdehWrWGG2japGsiZWWYbaXE8DwyOOFQCDUWY+syODWJolEyUTa3k=
X-Received: by 2002:a81:6cd6:0:b0:61b:6757:a3df with SMTP id
 00721157ae682-62a08eb4a6emr145503807b3.33.1716987612935; Wed, 29 May 2024
 06:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-4-flintglass@gmail.com>
 <CAKEwX=NnigYafFtQ63mknr_Gi7AVG5rp514GHi0a1K5PiNUxSQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NnigYafFtQ63mknr_Gi7AVG5rp514GHi0a1K5PiNUxSQ@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 29 May 2024 22:00:02 +0900
Message-ID: <CAPpodddOjhqh27Nt_Gkf=BTG0NBvWR4sxLPWQRHmPmwGOk0JAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: zswap: fix global shrinker error handling logic
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=B0=B4) 0:11 Nhat Pham <nphamcs@gmail=
com>:
>
> On Mon, May 27, 2024 at 9:34=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
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
> > index 0b1052cee36c..08a6f5a6bf62 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1304,7 +1304,7 @@ static struct shrinker *zswap_alloc_shrinker(void=
)
> >
> >  static int shrink_memcg(struct mem_cgroup *memcg)
> >  {
> > -       int nid, shrunk =3D 0;
> > +       int nid, shrunk =3D 0, stored =3D 0;
> >
> >         if (!mem_cgroup_zswap_writeback_enabled(memcg))
> >                 return -EINVAL;
> > @@ -1319,9 +1319,16 @@ static int shrink_memcg(struct mem_cgroup *memcg=
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
> >         return shrunk ? 0 : -EAGAIN;
> >  }
> >
> > @@ -1329,12 +1336,18 @@ static void shrink_worker(struct work_struct *w=
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
> > @@ -1366,9 +1379,12 @@ static void shrink_worker(struct work_struct *w)
> >                  */
> >                 if (!memcg) {
> >                         spin_unlock(&zswap_shrink_lock);
> > -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > +
> > +                       /* tree walk completed but no progress */
> > +                       if (!progress && ++failures =3D=3D MAX_RECLAIM_=
RETRIES)
> >                                 break;
> >
> > +                       progress =3D 0;
> >                         goto resched;
> >                 }

Here, the `progress` counter tracks how many memcgs successfully evict
a page in a tree walking. (not per the while loop) then reset to 0.
progress > 0 ensures there is progress.
If we visit the tree root (NULL) without any progress, it will be a failure=
.

Before the loop starts, progress counter is initialized to 1 because
the first tree walk might not  iterate all the memcgs, e.g. the
previous worker was terminated at the very last memcg.


> >
> > @@ -1391,10 +1407,15 @@ static void shrink_worker(struct work_struct *w=
)
> >                 /* drop the extra reference */
> >                 mem_cgroup_put(memcg);
> >
> > -               if (ret =3D=3D -EINVAL)
> > -                       break;
> > +               /* not a writeback candidate memcg */
> > +               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOENT)
> > +                       continue;
> > +
>
> Can we get into an infinite loop or a really long running loops here
> if all memcgs have their writeback disabled?
>
> >                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
> >                         break;
> > +
> > +               ++progress;
> > +               /* reschedule as we performed some IO */
> >  resched:
> >                 cond_resched();
> >         } while (zswap_total_pages() > thr);
> > --
> > 2.43.0
> >



--=20

<flintglass@gmail.com>

