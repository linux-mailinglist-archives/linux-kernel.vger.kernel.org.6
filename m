Return-Path: <linux-kernel+bounces-210659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A009046DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D032286572
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1C1552E1;
	Tue, 11 Jun 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtqLYQEZ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566318EAB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144411; cv=none; b=M3S92zmxSjWfdU/boRvNNBQVpFUV5VdwoaH5E8gQqpQEmOFApDoXJD9ekJTWwFBcxptXkAZ3XzyaS/jtKtMgkgz0LdaxrvUoYJXKuY20vvE3AuPcPffr/tKa9b/NTYZfZOwMmx9EOOB4cnZTi0bg4OoUGC8qXvCzZ8n9OQP56ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144411; c=relaxed/simple;
	bh=Luzz8SE63QZXxbCDkOElzpZzSqBJuROxHhvtQ3lKmJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0e1j/hs/ZlQn9LepQlPeWfXn2R1CKHxnpmdvwyF8B2tYy88XZf6+Fl6YMmeBGa7HEZ/du7j2DRmBHuqk6aGYIfIgU22m4vGl/tHL3Fp452jiZ5I2fD5RLlbsdQ5eFfYhClpm5LB9x2EWSaTfdP5s4JASh38Fb3ivYEU/g0AQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtqLYQEZ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfe41f7852cso170238276.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718144409; x=1718749209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWvoilUykDD9/rgz0mp3zLYBtz2E5uf7UCO+Al15jwE=;
        b=dtqLYQEZxXdTHsxgez4wF7TLPrRwHuk6AJd06eIYPpyzq4rmGuBA6kyD+3UlzdcfcN
         EXWj9vzPkPX3PYM6Jl1VC/93LrbK/vCVzDAsdcnmOd0sK1yUYhv8DdPkUI4VniI4w34R
         k0b3KeZ3zNPYxdO+CNnJgSm38VXCBMaNpUq/gx0+nw7jPTsGYlzOuyvNGA7UaZ8JAUAW
         8N0rqil50993VvKu9AY9mqRXbFW0A7RkOQjznPemN9yxvGGUrjE8tcc7AtDwDOPuC4hd
         NkYUilaLNNGJNqoCUPWXwCkyfYUcW1IPGOIKgh64UbfPkKcyPDsDUq31SZOD5fjsdYHg
         kWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144409; x=1718749209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWvoilUykDD9/rgz0mp3zLYBtz2E5uf7UCO+Al15jwE=;
        b=pegzBL4oFYRgKdmnHSg+DeDr3fVJRAIbyfaR/h/oycVdK+ojqE5SHU7lVK3Cc8KR51
         f4uCMPTOh4Ce8iNcOcjyOud9+IlRaRzLZEo2+5kY6Bqqd5uv94AhnQ0Z74jdD4JXSkUE
         cUIFjsa8PzkKUxgsnd9S4bWDmUp1ahZJe42fcgzUt7DyoSr0tMCOjPC30xJ4g2K9+4k7
         XFUixVDU2IfmJJyLYXk0EhSkdipW/pzZJ6HmBlKuc4WcyDaeHjeHzN+m9YfZHAYSWRDa
         okuxyjfF5NitY4WSHr9UEboTcKPTC+PbEzh+jwu+haoxzp9sXZog3tCswhoJkDyeKGi2
         b1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCV9fcvta2snVdmBgbEuQQM/W8dDv/pN0mSkbU4qg3S2GxHNg9ZKPYMgvqZVk+nqfALLfF0CAwSeW20xGd9+ItVe8Nf1SrX8Uy8tYKFQ
X-Gm-Message-State: AOJu0Yx3VWMxbXdYKrogYPsZCPaBRA9QVcMem2JVZOssp1140IFo3ho9
	Pqb2onfLO4MWPJFW7SoivwWa4dd7v+ejW2e+lK46QaWtl9Rtavpr67t3PPpHvcca5CzDhyT7gon
	Kv0uprQ1MFZN1IEoBND2d8AKqG5g=
X-Google-Smtp-Source: AGHT+IED8SIQCLlOTJ3/mg4iIlebKngKR0y316II+f7atzv0vSoCaGqhsB7kaH/nn00uvkjSU0JyapO85dSqnBAyLYM=
X-Received: by 2002:a25:5f4f:0:b0:dfa:7e09:21c4 with SMTP id
 3f1490d57ef6-dfe66464f86mr72064276.3.1718144409057; Tue, 11 Jun 2024 15:20:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
 <20240611024516.1375191-2-yosryahmed@google.com> <CAGsJ_4w3LDE1OuDiX_LAeTxEGUFPVOwqMxoOF+Dr55bdLUZQ7w@mail.gmail.com>
 <CAJD7tkY6h1RkbYHbaQcTuVXOsY-t=arytf5HtcKfx7A75x06bg@mail.gmail.com>
In-Reply-To: <CAJD7tkY6h1RkbYHbaQcTuVXOsY-t=arytf5HtcKfx7A75x06bg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 12 Jun 2024 10:19:58 +1200
Message-ID: <CAGsJ_4xAHR-fMP6c8w6Xf5cVF2OJYwChiGn5Y66qvM_qiEnEDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 9:55=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 11, 2024 at 2:53=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Jun 11, 2024 at 2:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > Add zswap_never_enabled() to skip the xarray lookup in zswap_load() i=
f
> > > zswap was never enabled on the system. It is implemented using static
> > > branches for efficiency, as enabling zswap should be a rare event. Th=
is
> > > could shave some cycles off zswap_load() when CONFIG_ZSWAP is used bu=
t
> > > zswap is never enabled.
> > >
> > > However, the real motivation behind this patch is two-fold:
> > > - Incoming large folio swapin work will need to fallback to order-0
> > >   folios if zswap was ever enabled, because any part of the folio cou=
ld
> > >   be in zswap, until proper handling of large folios with zswap is
> > >   added.
> > >
> > > - A warning and recovery attempt will be added in a following change =
in
> > >   case the above was not done incorrectly. Zswap will fail the read i=
f
> > >   the folio is large and it was ever enabled.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  mm/zswap.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index a8c8dd8cfe6f5..7fcd751e847d6 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -83,6 +83,7 @@ static bool zswap_pool_reached_full;
> > >  static int zswap_setup(void);
> > >
> > >  /* Enable/disable zswap */
> > > +static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_ON, zswap_ever_e=
nabled);
> > >  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
> > >  static int zswap_enabled_param_set(const char *,
> > >                                    const struct kernel_param *);
> > > @@ -136,6 +137,11 @@ bool zswap_is_enabled(void)
> > >         return zswap_enabled;
> > >  }
> > >
> > > +static bool zswap_never_enabled(void)
> > > +{
> > > +       return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_e=
ver_enabled);
> > > +}
> >
> > Will we "extern" this one so that mm-core can use it to fallback
> > to small folios?
> > or you prefer this to be done within the coming swapin series?
>
> My intention was to keep it static for now, and expose it in the
> header when needed (in the swapin series). If others think it's better
> to do this now to avoid the churn I am happy to do it as well.

Personally, I'd vote for exposing it now to avoid one more patch which migh=
t
come shortly. And this patchset serves the clear purpose of drawing attenti=
on
from mm-core to fallback to small folios.

Thanks
Barry

