Return-Path: <linux-kernel+bounces-195170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7B8D4872
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702F01F242DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361206F31C;
	Thu, 30 May 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpXZEcmq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF2183962
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061145; cv=none; b=T5zyr65z9Lgsf2w7RYwJZxqcKjl8NKRB2yDJ5OsiIyqDM/U8BoUW1836mv0shOtI6LbLGQKB4QGiF0W8CRZEjwHobZPR3a/zRILlbxmOXbCt/i0r68SiCsQza9eYIZbW+q1GJKASx7Ui0psobKNXDJMecEQc1C6GdTIf5FqJr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061145; c=relaxed/simple;
	bh=ExWK5h+AIhYI/mdd6hBybr/n+242JHMbYnLsHFryIKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzP3mzbD9xJQbjFYsBIVWd1h/9LLDk3rjDe0hKPn5dq2BxMJ9NVVmwtnnFaWBu/xpAFXtS6L9f5ZpBe7RG8bjjiiUJneaRFDko7ZOSiLMdYBK55ON8mv4j9Oj/GI2e/lxISSYfmypa2vUv3Ujuc4h/BZKSpAVTkp1sHxMrGwXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpXZEcmq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e974857588so6718611fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717061142; x=1717665942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qEQtI0w/h5uhl2GdND/gyfYte2np2VCW52giOM0EVI=;
        b=hpXZEcmqemgX6JjTyWtjZjf6vUGB4ij7ZeFm5PxXKSLsdbpiJAa09XKylACCtTocfB
         zYkLvUWzlwy6htoI4KfJhRnLfmLRKqXrGCDMB6+t73FHciaHQvfwvwUbBKfVyKDVxgMj
         9oSrI4R/LZmks/Tx3BFZ6BTp7usOAPNfzXE9JStyo+/bnM6ohxpstkH7AiOUJWKAJJwl
         1pKV+4S6R3Yf8na34hw9PF1NY4dXewXqZe+9PWgrkYFPNR5QVZsmhhJoWnld9urs/im8
         Wbx5KViY/6IAQ7ufevFFowZPVRZdGseOGfA1miF/JFmA5slbnc9V2g9aocLwSgdTVHC4
         IjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061142; x=1717665942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qEQtI0w/h5uhl2GdND/gyfYte2np2VCW52giOM0EVI=;
        b=pLs0weKo2IgJzUH2jgvlBbCFum2c9qJswIJi5XHzMCWVSnr7DjPjhZMYjLmB915mpl
         GAJbs2bGtpMZWYoIlebfUaqSHXqzse1l7RAM90fAhVoLKIIcEGkKWOeYxLgWneP1zakl
         bll3iH18wX2nG+178R8FjlrtR5PT2cJQWE5CsHymVSKw40yC8VT3RrP6ynNzYVHhk/Sa
         R2Z6NbtkAjVEbF0Hg3iMJwHGVKSH+EJ4hPBovtdsbrnYBjAM+JI2rComrnULBNzusdpH
         JUS/TNpuU8YqlU7l7dWSMUJAK18RHikfN8lTxRAblSMw/v4KlLXAaDvaW+YikLCv4+lJ
         1IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXqhtONxX1+QKj4xd1d9qgDk7aEDqWk9r8rgbeqZP/wGY04Hwk5UtuEMc2RajGvB1SI1XnzsT40W5AefAo64d7mJkV1YWmF1j1gobS
X-Gm-Message-State: AOJu0Yyj6lSQg7Bz0CMdI155dVDzzl2LRQzlXaRpADCEeZM/gAIN6FIA
	Csue8NmZLCgSgh5rMcP4oL9siX17NTkx/rJauKb/ZkpOExAkg3g37nXuR6PbdzdaiFrJrq+ieOT
	7eRWUhfW28G8A9X4mxnDg6qBOyy8=
X-Google-Smtp-Source: AGHT+IFkDVKnM9FMlK+mk303DRx15yfjrrlVBsQEQpVmKYHUMA7zyUldVw343zu9ctJujyJMU7LZ43kbf2xohD7qPzY=
X-Received: by 2002:a2e:2c0f:0:b0:2e1:a15b:b504 with SMTP id
 38308e7fff4ca-2ea8485bcc1mr7658761fa.37.1717061141494; Thu, 30 May 2024
 02:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com> <CANzGp4+HJE_h+kBsx9cJzKxJRi3u_y204-numUgzYgJBo2AJfg@mail.gmail.com>
In-Reply-To: <CANzGp4+HJE_h+kBsx9cJzKxJRi3u_y204-numUgzYgJBo2AJfg@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 30 May 2024 17:25:30 +0800
Message-ID: <CAGWkznFdsxQRUd-fs82ZYveu8idJ7mDPw2LVty8qPOu=dn0rng@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: Chuanhua Han <chuanhuahan@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:16=E2=80=AFPM Chuanhua Han <chuanhuahan@gmail.com=
> wrote:
>
> zhaoyang.huang <zhaoyang.huang@unisoc.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=
=8830=E6=97=A5=E5=91=A8=E5=9B=9B 10:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Broken vbq->free reported on a v6.6 based system which is caused
> > by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
> > This should be introduced by the Fixes below which ignored vbq->lock
> > matter.
> >
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized =
blocks")
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmalloc.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..112b50431725 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *v=
b)
> >  }
> >
> >  static bool purge_fragmented_block(struct vmap_block *vb,
> > -               struct vmap_block_queue *vbq, struct list_head *purge_l=
ist,
> > -               bool force_purge)
> > +               struct list_head *purge_list, bool force_purge)
> >  {
> > +       struct vmap_block_queue *vbq;
> > +
> >         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> >             vb->dirty =3D=3D VMAP_BBMAP_BITS)
> >                 return false;
> > @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_bl=
ock *vb,
> >         if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
> >                 return false;
> >
> > +       vbq =3D container_of(addr_to_vb_xa(vb->va->va_start),
> > +               struct vmap_block_queue, vmap_blocks);
> This seems to be the same as before fix :),  the vbq found by
> addr_to_vb_xa is still added to the xarray vbq, not necessarily to the
> free_list vbq,
Yes, my fault. Should we expand the vmap_block_queue by introducing a
cpu_id which I actually do in my local regression.

> These two vbqs may not be the same, we need to find the vbq when added
> to free_list.
>
> For example:
> We add vb to vbq1's xarray and vbq2's free_list, and we need to find
> vbq2 instead of vbq1.
> So I feel like this place isn't really fixed=EF=BC=9F
> >         /* prevent further allocs after releasing lock */
> >         WRITE_ONCE(vb->free, 0);
> >         /* prevent purging it again */
> > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> >                         continue;
> >
> >                 spin_lock(&vb->lock);
> > -               purge_fragmented_block(vb, vbq, &purge, true);
> > +               purge_fragmented_block(vb, &purge, true);
> >                 spin_unlock(&vb->lock);
> >         }
> >         rcu_read_unlock();
> > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start=
, unsigned long end, int flush)
> >                          * not purgeable, check whether there is dirty
> >                          * space to be flushed.
> >                          */
> > -                       if (!purge_fragmented_block(vb, vbq, &purge_lis=
t, false) &&
> > +                       if (!purge_fragmented_block(vb, &purge_list, fa=
lse) &&
> >                             vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_=
BITS) {
> >                                 unsigned long va_start =3D vb->va->va_s=
tart;
> >                                 unsigned long s, e;
> > --
> > 2.25.1
> >
> >
>
>
> --
> Thanks,
> Chuanhua

