Return-Path: <linux-kernel+bounces-260145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46293A3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4811C2256F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7054155A52;
	Tue, 23 Jul 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ8J0w2b"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE81534FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748917; cv=none; b=V3IY5nYGMNCgxzWk14/xGMs0RaNAXOidApawSKq3KWyvZq1BnOdeokA1u1D/P+f8jDaCnHlwCb0BEudyvWO0rX1EOeqI4TbJSa53sLRpEbQdTUUbCUkJeDX4zQuU93iL3bYm8SeN1L23cqA4FuBopKSVIHL2ihRY+xYWlLvFDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748917; c=relaxed/simple;
	bh=g0kkbBzImF/tU5MvslL7HpZbOl0MYOVA4J8hm/SK4ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJyuS6eqI37T3pGapfGviEqfzoPYRr5RcTF4S53Spkq52UZtEbLF9i6fOSYbiR8PRzHIZszaWjXqdqFq6yqtAtLdSHlPE5t/guIddqkh/O8c/ZA6b7dL5fzTyQEVnFVYWPa3gt+Ker2RhwNtQ/TlifMPSmvx3gmk2/FmeduUKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ8J0w2b; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so6083480276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721748914; x=1722353714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEWtktvlhhKGtS7ypqK5XQEDZZZuM3sheGLw0Jcss8g=;
        b=gJ8J0w2bz227pU3oD7aHhwhR4P05XSsLhM8StwJux/+yr3Lsmqs+9EEB/dY+yOXSO4
         I0xLrNGqC38UN54zkS33RaiITnmAvELJiMDfdXKUIeH40+Wuc+U6zfoHqxUFsIpFRvfe
         SOZ2oOgNNAhtb3eXPIStd4b7LgHduDy2mK18BT4DWv25G/GVY37L1518xkMOlaL6NUp2
         bDdmrm7sjn9MkZFZ71AVcWl1UokG5k0gFWuSXO5hdFW47iG9aN/qBPk+pB6rGTKw8bih
         GXJuU+Kc5LtWIYuNJlJBpNfpiAMZ2sLVXRMTa/eJ+yJoi5dS8hRhVn43fN8ZvIqJXmhG
         LO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721748914; x=1722353714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEWtktvlhhKGtS7ypqK5XQEDZZZuM3sheGLw0Jcss8g=;
        b=oDioo84ORh65Fsyi9IsSO6z7CnewLslYPq53A5PyoaGvZhNuAef/QX87jfPo5buxDR
         Kp1aO5jYbUlgvSCl1dTCDw28p4siVJ/qPjK4Tv9XlfyxJtoZM6vysoTDK3AkhpG2JR6p
         ktHoDriWZNR6RC38YY3/zXUBb3eG5/H3JDe30sX1+vUkSoHvRBMa8Mcowg+iRksvFe14
         IDINGm5j/pwV6NAYDguLIrdl9lVh+NplCEl0CVKclg8YM4e4bfskTJz3lKsvZU6ZMOX1
         IwPb4VdMPVVWEW4qDYOTShyFyYkbAj3LIYDc0oAV2eUuqW2pmAyuxbTg8g/maQ3B6BRs
         9YQw==
X-Forwarded-Encrypted: i=1; AJvYcCUabgmbUpW4bC17uO1mkKVgIbekEAKqlhGNbzdTTrlHUuNn+WBMSKLxu3Sm9U1UumDmO2pyLTzIidCxpyXFXlNm4arPt1Dbp8pfKilO
X-Gm-Message-State: AOJu0Yw6DIz544fxnpqcHpvnPGd8x4BSsq6/iYE0MRwitBQYCeFkEybK
	SH6nUA+AwfFX0+FCBVKB2Q2coCOoK3NoD+6lkhIyUoVrCjxYyukplHq8ShpACwUPPGwNznPHUJ4
	kr+DcrPJzVwfeuRwibVftSoAvCcUS5ORT
X-Google-Smtp-Source: AGHT+IGKMH+dcaVNTsXNK8AYPostkHDBYgQ96LvIvNO+U+bChlyoYXIqNBF1V99PHrygv64yqroC9k3m7sxxmR+hgYI=
X-Received: by 2002:a05:6902:703:b0:e03:ab31:9aa6 with SMTP id
 3f1490d57ef6-e08701898c5mr14273091276.24.1721748914582; Tue, 23 Jul 2024
 08:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
 <CAKEwX=NGu_MM3bzT9eXAAJhvCvv+x4Qvf77=_RFD-M7zxKFriA@mail.gmail.com>
In-Reply-To: <CAKEwX=NGu_MM3bzT9eXAAJhvCvv+x4Qvf77=_RFD-M7zxKFriA@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 24 Jul 2024 00:35:04 +0900
Message-ID: <CAPpoddeGo3o4vWLYCwi2g0zs7RGi__QYuLBAVi1Y0gzP1X+7Gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8823=E6=97=A5(=E7=81=AB) 6:39 Nhat Pham <nphamcs@gmail=
.com>:
>
> On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch fixes an issue where the zswap global shrinker stopped
> > iterating through the memcg tree.
> >
> > The problem was that shrink_worker() would stop iterating when a memcg
> > was being offlined and restart from the tree root.  Now, it properly
> > handles the offline memcg and continues shrinking with the next memcg.
> >
> > To avoid holding refcount of offline memcg encountered during the memcg
> > tree walking, shrink_worker() must continue iterating to release the
> > offline memcg to ensure the next memcg stored in the cursor is online.
> >
> > The offline memcg cleaner has also been changed to avoid the same issue=
.
> > When the next memcg of the offlined memcg is also offline, the refcount
> > stored in the iteration cursor was held until the next shrink_worker()
> > run. The cleaner must release the offline memcg recursively.
> >
> > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> Hmm LGTM for the most part - a couple nits
> [...]
> > +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> > +                                       zswap_next_shrink, NULL);
> nit: this can fit in a single line right? Looks like it's exactly 80 char=
acters.

Isn't that over 90 chars? But yes, we can reduce line breaks using
memcg as temporary, like:
-       if (zswap_next_shrink =3D=3D memcg)
-               zswap_next_shrink =3D mem_cgroup_iter(NULL,
zswap_next_shrink, NULL);
+       if (zswap_next_shrink =3D=3D memcg) {
+               do {
+                       memcg =3D mem_cgroup_iter(NULL, zswap_next_shrink, =
NULL);
+                       zswap_next_shrink =3D memcg;
+               } while (memcg && !mem_cgroup_online(memcg));


> [...]
> > +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> > +                                               zswap_next_shrink, NULL=
);
> Same with this.
> [...]
> > +               /*
> > +                * We verified the memcg is online and got an extra mem=
cg
> > +                * reference.  Our memcg might be offlined concurrently=
 but the
> > +                * respective offline cleaner must be waiting for our l=
ock.
> > +                */
> >                 spin_unlock(&zswap_shrink_lock);
> nit: can we remove this spin_unlock() call + the one within the `if
> (!memcg)` block, and just do it unconditionally outside of if
> (!memcg)? Looks like we are unlocking regardless of whether memcg is
> null or not.
>
> memcg is a local variable, not protected by zswap_shrink_lock, so this
> should be fine right?
>
> Otherwise:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Ah that's right. We no longer modify zswap_next_shrink in the if
branches. Merging the two spin_unlock.

