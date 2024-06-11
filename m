Return-Path: <linux-kernel+bounces-210420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C00904374
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A721C2326E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D571B30;
	Tue, 11 Jun 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk1JWX39"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30832249E5;
	Tue, 11 Jun 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130386; cv=none; b=Pe4flBs0dg5PnKod2WdMAUSxz1beTlQ74qQndhk3oshHTMy8QsOO3XR0FNJZwZMpXFylII9IVQGXOkDke/0oWnrZvg76+pH0AsmFsGiYjO9fmjkP2JtUFvoflSYQbx20HOKpPBUdMN5yM5TKY5RYUL+/Q0uuUVYd0ykqnVoBgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130386; c=relaxed/simple;
	bh=AxAmbeCFEiVm4XUbvZswX7cyf3ah2tphneIRKbd0Q1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7MgtkfT6qXYjILhUiDwxbWb0hV3CKaetZ+Tr9Z8zpclm8JtBeO/rpCp2xDSFzPGJlN6oywLsPPSe+TssZ0ULESR4h57zsaSV4+mdzg620HJqNpXUH1Vjx4UVXMoFVVw/sV5BxUp/5m59lCpoafuLKjzAXnQDRDEu4aCtcXzwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk1JWX39; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44051a577easo23514621cf.2;
        Tue, 11 Jun 2024 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130383; x=1718735183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx/97KVP+3IrA7BDYOY/vWXjIAWDZj39a6aZjMqO+Qw=;
        b=Nk1JWX399xvBJEpMm2lxaANCPt8KrJO3fgQIHX4/hbjL8gZTeD4ttO4NN2wv0HM+lQ
         yESGdZ3NHSm6NhP69U0q1CD/GiZs0VD9xnW6qnm9Zpb/ryr2QKzmWYNMhbOu2hI24cUZ
         PeHma36Af5K6FI0LRw4mFfsHbbncN4xci/MdrckA+8p1Inr3HTQ4H178rcxKfN8/tgai
         BGiATgv16vmZ3Ze6cPC951Rmfr/lIwMlnQIgL6dks2GiAYXKERVgQnG8UsgyjdrEhngg
         juS5W+bMG1hsDWZoOmQEQH+wFKU/T1geOJdYUCPRQgbyUQnXYaeqA6aszb2tFhAs9gXB
         R2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130383; x=1718735183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx/97KVP+3IrA7BDYOY/vWXjIAWDZj39a6aZjMqO+Qw=;
        b=hBphZRn5hDLhCgOgWNjOATuCQtEyQY1tr4Fu+0GxmwmTF8AuPUoDEBA2pjdvFoBRdg
         vKBiYHdwWmktHmMWQuYoEazlhhlPJS1wuapb3YMav9+objY7zs/8uvCokRtBj0L/aFqG
         h+Se1U0rGlDhbqgDqzMwSiY4oOBmDfqyGRTAGRgVYclS0o4mfAp+3X8h0HQyVRbdmLRC
         T64Nvo92/cWvNhjg/vtVuLunVDLTgr+LXUy/R2i+43dJz457LFADn+Bx+j7+GEe5zT2N
         Ak+koA8R8ZD68zl4ZYtyQrF0oQCHGDcknIeK7yLBCxBvW0TZTY7xraPqB/jKf5i2GcS1
         r2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX96M3WXSK6eRZVVICJcjMTtCt+W4sDEeSzN3IalAxWyJCxfhqY8yICzIMGiDquA+aLPp2KP/fyYZibPEuuiCuDVRIzZEme61sMHVrz0PCSc+KkxsCf2dgIIGsvgy8W/d7Ooa4Reh1z
X-Gm-Message-State: AOJu0YxrlmIuV9rZFlRaiAljIaLKIdOtluADa4g2gNTxYebxFz+FfnPD
	0Q99xEA7D/XVTcdRaHu1XC5g10aGvvpFoxyT7XfZ+90QEceTHEtmvWBKPKgG4chPuQnz9rDUZQD
	4mtThqiu+TMeKxe9xOJ8Wh94O9Lg=
X-Google-Smtp-Source: AGHT+IHFN6sVSYA40zzZBqCr8PAU+d9mRS6vS72srGcbMmX/Mq5CHxpjucNAE1JbeD0EBCqKlVBjM84vdcJ2zUa2AOs=
X-Received: by 2002:a05:6214:2d42:b0:6b0:82a9:936a with SMTP id
 6a1803df08f44-6b082a995d2mr57151716d6.2.1718130382913; Tue, 11 Jun 2024
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-2-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 11:26:12 -0700
Message-ID: <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that `shrink_worker()` would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlining memcg and continues shrinking with the next memcg.
>
> This patch also modified handing of the lock for offlined memcg cleaner
> to adapt the change in the iteration, and avoid negligibly rare skipping
> of a memcg from shrink iteration.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 87 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 68 insertions(+), 19 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 80c634acb8d5..d720a42069b6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -827,12 +827,27 @@ void zswap_folio_swapin(struct folio *folio)
>         }
>  }
>
> +/*
> + * This function should be called when a memcg is being offlined.
> + *
> + * Since the global shrinker shrink_worker() may hold a reference
> + * of the memcg, we must check and release the reference in
> + * zswap_next_shrink.
> + *
> + * shrink_worker() must handle the case where this function releases
> + * the reference of memcg being shrunk.
> + */
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
>         /* lock out zswap shrinker walking memcg tree */
>         spin_lock(&zswap_shrink_lock);
> -       if (zswap_next_shrink =3D=3D memcg)
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> +
> +       if (READ_ONCE(zswap_next_shrink) =3D=3D memcg) {
> +               /* put back reference and advance the cursor */
> +               memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +               WRITE_ONCE(zswap_next_shrink, memcg);
> +       }
> +
>         spin_unlock(&zswap_shrink_lock);
>  }

As I have noted in v0, I think this is unnecessary and makes it more confus=
ing.

>
> @@ -1401,25 +1416,44 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>
>  static void shrink_worker(struct work_struct *w)
>  {
> -       struct mem_cgroup *memcg;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct mem_cgroup *next_memcg;
>         int ret, failures =3D 0;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /* global reclaim will select cgroup in a round-robin fashion.
> +        *
> +        * We save iteration cursor memcg into zswap_next_shrink,
> +        * which can be modified by the offline memcg cleaner
> +        * zswap_memcg_offline_cleanup().
> +        *
> +        * Since the offline cleaner is called only once, we cannot aband=
one
> +        * offline memcg reference in zswap_next_shrink.
> +        * We can rely on the cleaner only if we get online memcg under l=
ock.
> +        * If we get offline memcg, we cannot determine the cleaner will =
be
> +        * called later. We must put it before returning from this functi=
on.
> +        */
>         do {
> +iternext:
>                 spin_lock(&zswap_shrink_lock);
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> -               memcg =3D zswap_next_shrink;
> +               next_memcg =3D READ_ONCE(zswap_next_shrink);
> +
> +               if (memcg !=3D next_memcg) {
> +                       /*
> +                        * Ours was released by offlining.
> +                        * Use the saved memcg reference.
> +                        */
> +                       memcg =3D next_memcg;
> +               } else {
> +                       /* advance cursor */
> +                       memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +                       WRITE_ONCE(zswap_next_shrink, memcg);
> +               }

I suppose I'm fine with not advancing the memcg when it is already
advanced by the memcg offlining callback.

>
>                 /*
> -                * We need to retry if we have gone through a full round =
trip, or if we
> -                * got an offline memcg (or else we risk undoing the effe=
ct of the
> -                * zswap memcg offlining cleanup callback). This is not c=
atastrophic
> -                * per se, but it will keep the now offlined memcg hostag=
e for a while.
> -                *
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> @@ -1434,16 +1468,25 @@ static void shrink_worker(struct work_struct *w)
>                 }
>
>                 if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> +                       /*
> +                        * It is an offline memcg which we cannot shrink
> +                        * until its pages are reparented.
> +                        *
> +                        * Since we cannot determine if the offline clean=
er has
> +                        * been already called or not, the offline memcg =
must be
> +                        * put back unconditonally. We cannot abort the l=
oop while
> +                        * zswap_next_shrink has a reference of this offl=
ine memcg.
> +                        */
>                         spin_unlock(&zswap_shrink_lock);
> -
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> +                       goto iternext;

Hmmm yeah in the past, I set it to NULL to make sure we're not
replacing zswap_next_shrink with an offlined memcg, after that zswap
offlining callback for that memcg has been completed..

I suppose we can just call mem_cgroup_iter(...) on that offlined
cgroup, but I'm not 100% sure what happens when we call this function
on a cgroup that is currently being offlined, and has gone past the
zswap offline callback stage. So I was just playing it safe and
restart from the top of the tree :)

I think this implementation has that behavior right? We see that the
memcg is offlined, so we drop the lock and go to the beginning of the
loop. We reacquire the lock, and might see that zswap_next_shrink =3D=3D
memcg, so we call mem_cgroup_iter(...) on it. Is this safe?

Note that zswap_shrink_lock only orders serializes this memcg
selection loop with memcg offlining after it - there's no guarantee
what's the behavior is for memcg offlining before it (well other than
one reference that we manage to acquire thanks to
mem_cgroup_iter(...), so that memcg has not been freed, but not sure
what we can guarantee regarding its place in the memcg hierarchy
tree?).

Johannes, do you have any idea what we can expect here? Let me also cc Shak=
eel.





>                 }
> +               /*
> +                * We got an extra memcg reference before unlocking.
> +                * The cleaner cannot free it using zswap_next_shrink.
> +                *
> +                * Our memcg can be offlined after we get online memcg he=
re.
> +                * In this case, the cleaner is waiting the lock just beh=
ind us.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
> @@ -1457,6 +1500,12 @@ static void shrink_worker(struct work_struct *w)
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> +
> +       /*
> +        * We can still hold the original memcg reference.
> +        * The reference is stored in zswap_next_shrink, and then reused
> +        * by the next shrink_worker().
> +        */
>  }
>
>  /*********************************
> --
> 2.43.0
>

