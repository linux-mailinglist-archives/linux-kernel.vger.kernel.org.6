Return-Path: <linux-kernel+bounces-268026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69605941F81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2111C232B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634818A92F;
	Tue, 30 Jul 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qr4kTpqb"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4D16C44A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363854; cv=none; b=q1rWH2sazA3v3NN1EKjaetwxIBS6sOYzywyJoKXIytXsUYJBUiAKuzI68Swftv1RHdWA+5imlD/0dC3PzE+qE93F0s3BNEliCQV1d9mq95jKF7QXm1LhXxQfxis2KQp0t0zi73nvgdrfP22a4COtZ4SnrV7V//mh8jFeQ63wokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363854; c=relaxed/simple;
	bh=cQHWKG/nVySOQS+Ef6ysuyUXCSFnnF1K/ca9qz2n2mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW4T+0/TxfjErjIy93IXyNFgMuI42BaiYg0bFZrDVVMVPXByD0IpP9yNwfeTC24Fx3K5mailkIYJMlt1CpCoWPtN/BFPiPF9qcOp7bnA2u4k3/Nr982/wfme3cHCWvdh+7OGhKi4f9k3l0nbQLO+7BiIdLHGm8AFtbcHurrg3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qr4kTpqb; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49294575ad8so72759137.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722363852; x=1722968652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgn98Rs0vFZ6vwFLptR9+FqcC4bD5nEP0/iSprZQXIE=;
        b=qr4kTpqbJwVMLbN4lV4empHFxpl7SYz93LBysX3byQxqdDne9ZcShZynHh1ylkyHRg
         dGL182ZwjE3tAxW0sLsZ1df1peaygcqIXjSFVR2PoRZb9OdqGD7wvsDtnFdZKqJ1vn1e
         vMTqam7UgCQdsR4eb+LduGFr4vFTHfrPHJNlIE+/v4ar8RHjuzSnZ9J2K0L1uD/NGjzO
         TVKLiXIQQIlKCm+0RTdIiE7fA9OwY68kFODA9g+mFnhfFbvSTSXFCMxRdOq9hN2cgan1
         01yxKkYAC1ZP1jwc87ywXGjnLS7ZBWtfinxCAYEQXA58NbuZkbMDbnqAj/YlyfAqEX/O
         TgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363852; x=1722968652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgn98Rs0vFZ6vwFLptR9+FqcC4bD5nEP0/iSprZQXIE=;
        b=qwRMEWw6/aOISy152i7u8XFSlrRvl03hs6MBCNUnkwJszmMRhsKC9Zoj9/9mn3mall
         /HYfjLOhKaMK+vxfU8yrXNSP7iGlAq1/TYtnXIExp4b5H2DkP0sEF1Uq5SG/+JkLBmwV
         N+Gsfs5AAD1i0ULUWUI2GoL5FpofRaAuPlPUktrbx+chXAQGUGsz1lK/bTMHQshq4Xbp
         9OZREIrc0ZSX/iKEJYQjhOaQxDq0cmx4WtPEmKr+YtqEiLg75yU4RyDgxD8O2ku4RITQ
         aE2prmMp3hJVpfTzrmB9R4tIw4NXvm8VkfTK9VJ5QGOMPRCEM/Ysdnm1O3DZzHk15lH6
         8Ixg==
X-Forwarded-Encrypted: i=1; AJvYcCW04qNkB3sGMco7J79FXg3qDftKcWGvly7hS8O4bi4WSVwtc+G7UdAjFe+8Xz/UlGHRTHwTj96Afm810FrHT3qkLWlvlbbR47nL0F4W
X-Gm-Message-State: AOJu0Yz8TNUTrPZxvaglcseI4xmW2Q/HNGjwx9ID3V6GJ/OQ0IpmojpY
	6KSCNj1RhuLO8Q+K7VkGXTnK1ltj1WfFoJ7+dfqC1vnPykEvPlCjzP25R5NYuWvGkpcROb2VA+q
	yAH65GFObpVIM5orFsM6h8uvMwrDpI2n7Ccvo
X-Google-Smtp-Source: AGHT+IHqMhIcIB7MmFSRCmP+6Dl5wgB3Ta7vjwrWUhyeeqUD31fdpY7fSWauWCYAoV8voiWfscrwOuHigapRlXklOJo=
X-Received: by 2002:a05:6102:5489:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-49435606a62mr1793572137.5.1722363851381; Tue, 30 Jul 2024
 11:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727230635.3170-1-flintglass@gmail.com> <20240727230635.3170-2-flintglass@gmail.com>
 <CAJD7tkYKC8Cy0tCc=1m5x=bXVaXPhzRhWjeP5n6YofuPeTgOwg@mail.gmail.com> <CAPpoddcHCgZGx3DZXBzDCZRVNYpzf+aoeTYYd8Fr3GyndtNC2w@mail.gmail.com>
In-Reply-To: <CAPpoddcHCgZGx3DZXBzDCZRVNYpzf+aoeTYYd8Fr3GyndtNC2w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Jul 2024 11:23:32 -0700
Message-ID: <CAJD7tkZzb=PDtm=ba03hjPz_AOasmKEYBU+P9c0xWr-Hjd0XPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:25=E2=80=AFPM Takero Funaki <flintglass@gmail.co=
m> wrote:
>
> 2024=E5=B9=B47=E6=9C=8830=E6=97=A5(=E7=81=AB) 3:24 Yosry Ahmed <yosryahme=
d@google.com>:
> >
> > On Sat, Jul 27, 2024 at 4:06=E2=80=AFPM Takero Funaki <flintglass@gmail=
.com> wrote:
> > >
> > > This patch fixes an issue where the zswap global shrinker stopped
> > > iterating through the memcg tree.
> > >
> > > The problem was that shrink_worker() would restart iterating memcg tr=
ee
> > > from the tree root, considering an offline memcg as a failure, and ab=
ort
> > > shrinking after encountering the same offline memcg 16 times even if
> > > there is only one offline memcg. After this change, an offline memcg =
in
> > > the tree is no longer considered a failure. This allows the shrinker =
to
> > > continue shrinking the other online memcgs regardless of whether an
> > > offline memcg exists, gives higher zswap writeback activity.
> > >
> > > To avoid holding refcount of offline memcg encountered during the mem=
cg
> > > tree walking, shrink_worker() must continue iterating to release the
> > > offline memcg to ensure the next memcg stored in the cursor is online=
.
> > >
> > > The offline memcg cleaner has also been changed to avoid the same iss=
ue.
> > > When the next memcg of the offlined memcg is also offline, the refcou=
nt
> > > stored in the iteration cursor was held until the next shrink_worker(=
)
> > > run. The cleaner must release the offline memcg recursively.
> > >
> > > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > > ---
> > >  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++----------------=
--
> > >  1 file changed, 49 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index adeaf9c97fde..e9b5343256cd 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -765,12 +765,31 @@ void zswap_folio_swapin(struct folio *folio)
> > >         }
> > >  }
> > >
> > > +/*
> > > + * This function should be called when a memcg is being offlined.
> > > + *
> > > + * Since the global shrinker shrink_worker() may hold a reference
> > > + * of the memcg, we must check and release the reference in
> > > + * zswap_next_shrink.
> > > + *
> > > + * shrink_worker() must handle the case where this function releases
> > > + * the reference of memcg being shrunk.
> > > + */
> > >  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> > >  {
> > >         /* lock out zswap shrinker walking memcg tree */
> > >         spin_lock(&zswap_shrink_lock);
> > > -       if (zswap_next_shrink =3D=3D memcg)
> > > -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_nex=
t_shrink, NULL);
> > > +       if (zswap_next_shrink =3D=3D memcg) {
> > > +               do {
> > > +                       zswap_next_shrink =3D mem_cgroup_iter(NULL, z=
swap_next_shrink, NULL);
> > > +               } while (zswap_next_shrink && !mem_cgroup_online(zswa=
p_next_shrink));
> > > +               /*
> > > +                * We verified the next memcg is online.  Even if the=
 next
> > > +                * memcg is being offlined here, another cleaner must=
 be
> > > +                * waiting for our lock.  We can leave the online mem=
cg
> > > +                * reference.
> > > +                */
> >
> > I thought we agreed to drop this comment :)
> >
> > > +       }
> > >         spin_unlock(&zswap_shrink_lock);
> > >  }
> > >
> > > @@ -1304,43 +1323,49 @@ static void shrink_worker(struct work_struct =
*w)
> > >         /* Reclaim down to the accept threshold */
> > >         thr =3D zswap_accept_thr_pages();
> > >
> > > -       /* global reclaim will select cgroup in a round-robin fashion=
. */
> > > +       /* global reclaim will select cgroup in a round-robin fashion=
.
> >
> > nit: s/global/Global
> >
> > > +        *
> > > +        * We save iteration cursor memcg into zswap_next_shrink,
> > > +        * which can be modified by the offline memcg cleaner
> > > +        * zswap_memcg_offline_cleanup().
> > > +        *
> > > +        * Since the offline cleaner is called only once, we cannot l=
eave an
> > > +        * offline memcg reference in zswap_next_shrink.
> > > +        * We can rely on the cleaner only if we get online memcg und=
er lock.
> > > +        *
> > > +        * If we get an offline memcg, we cannot determine if the cle=
aner has
> > > +        * already been called or will be called later. We must put b=
ack the
> > > +        * reference before returning from this function. Otherwise, =
the
> > > +        * offline memcg left in zswap_next_shrink will hold the refe=
rence
> > > +        * until the next run of shrink_worker().
> > > +        */
> > >         do {
> > >                 spin_lock(&zswap_shrink_lock);
> > > -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_nex=
t_shrink, NULL);
> > > -               memcg =3D zswap_next_shrink;
> > >
> > >                 /*
> > > -                * We need to retry if we have gone through a full ro=
und trip, or if we
> > > -                * got an offline memcg (or else we risk undoing the =
effect of the
> > > -                * zswap memcg offlining cleanup callback). This is n=
ot catastrophic
> > > -                * per se, but it will keep the now offlined memcg ho=
stage for a while.
> > > -                *
> > > +                * Start shrinking from the next memcg after zswap_ne=
xt_shrink.
> > > +                * When the offline cleaner has already advanced the =
cursor,
> > > +                * advancing the cursor here overlooks one memcg, but=
 this
> > > +                * should be negligibly rare.
> > > +                */
> > > +               do {
> > > +                       memcg =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> > > +                       zswap_next_shrink =3D memcg;
> > > +               } while (memcg && !mem_cgroup_tryget_online(memcg));
> >
> > Let's move spin_lock() and spin_unlock() to be right above and before
> > the do-while loop, similar to zswap_memcg_offline_cleanup(). This
> > should make it more obvious what the lock is protecting.
> >
> > Actually, maybe it would be cleaner at this point to move the
> > iteration to find the next online memcg under lock into a helper, and
> > use it here and in zswap_memcg_offline_cleanup(). zswap_shrink_lock
> > and zswap_next_shrink can be made static to this helper and maybe some
> > of the comments could live there instead. Something like
> > zswap_next_shrink_memcg().
> >
> > This will abstract this whole iteration logic and make shrink_worker()
> > significantly easier to follow. WDYT?
> >
> > I can do that in a followup cleanup patch if you prefer this as well.
> >
>
> I'd really appreciate it. Sorry to have kept you waiting for a novice
> coder. Thank you for all your comments and support.

I will send a followup patch after this lands in mm-unstable. For this
patch, feel free to add:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

