Return-Path: <linux-kernel+bounces-195211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA08D48E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053E21F22F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC4152169;
	Thu, 30 May 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9kzsMX4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1E6F2F5
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062377; cv=none; b=Oii/gP69sHFZnjmUXQzPVCL3OLA+IKAXHm5wkm/hmUhT1fwrSKZB7Lv/AUb57wTqq/MvOCUKtFo0BlBdf9CoNBeFXaHe1wSYD4sKnqCr9hh+64xp0f/j5fT7w1/Hwgm22hrrcUz9CzaYw1bloiCExfhmQaqPtg0ZPWP3z/uvSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062377; c=relaxed/simple;
	bh=v5FiueanyiAdssPVA8M8weviQmpRcJrMZdKtNpRU4HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIudnt0HejTwCePFo8s2EF1ZaymAeoCLOBcyz7BYdY+7zGjqPOmxn0IF036jrsiWp07/cafO+0sN5+WWwjNHLPg7xBvs1UHLXdfEKo9CU5qU6fQAmmtneTSFU1+mDmhsTQ83MoMURWe5dMpF68RBvRsvojZdt67fTrKnUXWkGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9kzsMX4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a183ad429so707611a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717062374; x=1717667174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qGGE11+jWCidkU+JhPI7sjHvslJ/hX9g6PtMtW7PGQ=;
        b=j9kzsMX4TvEEKtsuP2g3X0nsR4eOcVKt2d1DJ2isW6gnxUodtq7Y0ooZw5ui20GEK7
         sLX1bYsq/uGmKgQGRnSFoGTJRJObBj93HFea2yzJ+zF9crjayuvOgncGICglVA84CKRL
         nV7Mro1qtSEtdiDszAgMVqPpB821SC/zQmGO244zXO12llpSQPJeeNUbijaMUhz7zojC
         05yI+S8U5/RX45WgUnJtvMzsU8KBHFkHY3vrao1PvgdTVfqZhbNyypzRw0BiduxJfg2V
         +1MkedOpljUgULf7KcG69KnVthIR1G4fCaGGdSQi/hH2xvqsKpKCH/p9Tjz9Mvtx8pmO
         damg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717062374; x=1717667174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qGGE11+jWCidkU+JhPI7sjHvslJ/hX9g6PtMtW7PGQ=;
        b=UAglaGwcJyGkIbXWwAI3WurV5wbqm1q9bS7SoZH1AR0GYnC/2iqIkn9Lzy6Rlvr71R
         iwc0mXPjvSqUiLv9zXzDiGc6y1L2ZbeZTCTZWmVts7cn84nOkQe4CYxSHvU11rgz6QSH
         AiR5Rfw6rjivzNN5+OSs7N9VdEDb9osSOvKwL2jUR/oLIFtDSYm3oF4g30KEhhIUGBrQ
         00Jk3viucF4/hdT4PT+09OBD5l+lklEEHDqCcwjydMD/fgeGToFxq5ePuZEncly4Nq8v
         Ym6pHkGTwRpoyjhXkqGVT7uw/oku2tqgfc/E/ucWhsDLjq62OZNdlojLZVsKTq5rixEX
         5nbg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ihLgiOG9fx+vUyJTuE76IAXlBz8bnq5XK6mrGqGodmfnsE7ONrXKgoQ+3eqWsH5YOjp22la9b4WVLDmcOUcmkjjx7AJr58Zy0bln
X-Gm-Message-State: AOJu0YydhYVQTfbJUKI/1kSIg/ROStqPVM1WQqJESZJLdeUAinCcArFf
	JDIprC/fKxTYHSbBwnmGTE5pgtmswTyudzsXgXKeyEwXX2pJF2Bqus1juNQLncqZvWr/527nSO5
	zH0f+G3t+QA7ULDltVmlw1UhDrgU=
X-Google-Smtp-Source: AGHT+IHfW4iIJfZWncmG4l87GYMVJordClmrKqso5ENCApfTl6oezuCgix0L2rNJURtLFqoZZkvAr4muXcDmnZY6SQo=
X-Received: by 2002:a50:ccd7:0:b0:578:67e9:a46e with SMTP id
 4fb4d7f45d1cf-57a1795316bmr957835a12.32.1717062373580; Thu, 30 May 2024
 02:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
 <CANzGp4+HJE_h+kBsx9cJzKxJRi3u_y204-numUgzYgJBo2AJfg@mail.gmail.com> <CAGWkznFdsxQRUd-fs82ZYveu8idJ7mDPw2LVty8qPOu=dn0rng@mail.gmail.com>
In-Reply-To: <CAGWkznFdsxQRUd-fs82ZYveu8idJ7mDPw2LVty8qPOu=dn0rng@mail.gmail.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Thu, 30 May 2024 17:46:01 +0800
Message-ID: <CANzGp4+mM1YOtj6__yaxkTdE3ZiW_t3G+wPWW61qUnbyaqNX6A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zhaoyang Huang <huangzhaoyang@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 17:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 30, 2024 at 5:16=E2=80=AFPM Chuanhua Han <chuanhuahan@gmail.c=
om> wrote:
> >
> > zhaoyang.huang <zhaoyang.huang@unisoc.com> =E4=BA=8E2024=E5=B9=B45=E6=
=9C=8830=E6=97=A5=E5=91=A8=E5=9B=9B 10:52=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Broken vbq->free reported on a v6.6 based system which is caused
> > > by invalid vbq->lock protect over vbq->free in purge_fragmented_block=
.
> > > This should be introduced by the Fixes below which ignored vbq->lock
> > > matter.
> > >
> > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilize=
d blocks")
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  mm/vmalloc.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22aa63f4ef63..112b50431725 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block =
*vb)
> > >  }
> > >
> > >  static bool purge_fragmented_block(struct vmap_block *vb,
> > > -               struct vmap_block_queue *vbq, struct list_head *purge=
_list,
> > > -               bool force_purge)
> > > +               struct list_head *purge_list, bool force_purge)
> > >  {
> > > +       struct vmap_block_queue *vbq;
> > > +
> > >         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> > >             vb->dirty =3D=3D VMAP_BBMAP_BITS)
> > >                 return false;
> > > @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_=
block *vb,
> > >         if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
> > >                 return false;
> > >
> > > +       vbq =3D container_of(addr_to_vb_xa(vb->va->va_start),
> > > +               struct vmap_block_queue, vmap_blocks);
> > This seems to be the same as before fix :),  the vbq found by
> > addr_to_vb_xa is still added to the xarray vbq, not necessarily to the
> > free_list vbq,
> Yes, my fault. Should we expand the vmap_block_queue by introducing a
> cpu_id which I actually do in my local regression.
You may need to embed a cpu_id in vb, and then use cpu_id to get the
vbq where the free_list is located
>
> > These two vbqs may not be the same, we need to find the vbq when added
> > to free_list.
> >
> > For example:
> > We add vb to vbq1's xarray and vbq2's free_list, and we need to find
> > vbq2 instead of vbq1.
> > So I feel like this place isn't really fixed=EF=BC=9F
> > >         /* prevent further allocs after releasing lock */
> > >         WRITE_ONCE(vb->free, 0);
> > >         /* prevent purging it again */
> > > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> > >                         continue;
> > >
> > >                 spin_lock(&vb->lock);
> > > -               purge_fragmented_block(vb, vbq, &purge, true);
> > > +               purge_fragmented_block(vb, &purge, true);
> > >                 spin_unlock(&vb->lock);
> > >         }
> > >         rcu_read_unlock();
> > > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long sta=
rt, unsigned long end, int flush)
> > >                          * not purgeable, check whether there is dirt=
y
> > >                          * space to be flushed.
> > >                          */
> > > -                       if (!purge_fragmented_block(vb, vbq, &purge_l=
ist, false) &&
> > > +                       if (!purge_fragmented_block(vb, &purge_list, =
false) &&
> > >                             vb->dirty_max && vb->dirty !=3D VMAP_BBMA=
P_BITS) {
> > >                                 unsigned long va_start =3D vb->va->va=
_start;
> > >                                 unsigned long s, e;
> > > --
> > > 2.25.1
> > >
> > >
> >
> >
> > --
> > Thanks,
> > Chuanhua



--=20
Thanks,
Chuanhua

