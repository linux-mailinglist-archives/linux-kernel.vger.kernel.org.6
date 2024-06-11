Return-Path: <linux-kernel+bounces-209108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB5902D73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AD51C215BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2C13ACC;
	Tue, 11 Jun 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDdf4q2T"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495C1173F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718064179; cv=none; b=jwE30udNR2OESPjK11y7t65olBHkliVTjx9h2LjQwtWLcRjGRZRqea5A8f06VyFGV/MgS/qRTpDC9tPfsopYnHXbrvEURPVxj5FUzathZQFcGx8J0OJrnjw8zyLc0Dp3KEARQEsE4V4eC17hJc+YOnVFSJHAiba+Mf2p+XJ7QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718064179; c=relaxed/simple;
	bh=wb9ieqV0h0WivBtLqAOZwsq/1SKW15pq7lWIwad18Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8sP/Sj/fRline0BFUPe7MKCeNM660NPa/ERKRw3HRwUXxFmMP92b0iJAFJoGO7KtwiidQ0xM1T209Nv2eXOOEotjcJBSA84XX3WKfe0VXSXKI6osmcaUbvBDF7pZFannMVlzLy192czSotp5QJquk40PVTH0T3OwCIGvNEiEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDdf4q2T; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa727d47c1so5168403276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718064177; x=1718668977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n26t2+PmJ0hXBNFN+MS0jl8gQ+UB5BKKsd8smeb5Xfw=;
        b=VDdf4q2TZb5q+z6WtblmFuNi6QJaSOJQwGnvj0FjEf4g94MEbN+nwOFF6Y9DUXHkYu
         UARmRYeS5BByhONdwROd5JYgrNPLtnh5UTRxmIqnU6ghTSBrgrBYYoQVOj+NyNRwaq0R
         WfeI9TPhgxiVyli5Y31qNnfIQYPIKnGP3zRyBpvu1bYcOMfwhwC0V4pXEMku59oW+kxL
         zbgjZHEBvrsof4+ont9TIQ6Fgfja2Ggc9KeMUcz8xqGyytq1f8tzn3pnRq8EtcLqiP2F
         Gna6l+MTYUA1O72YfAiL81ndvdkZz4aKomqn9AmRBNEodX6p+QvZLidFnPARzXtos81b
         4VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718064177; x=1718668977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n26t2+PmJ0hXBNFN+MS0jl8gQ+UB5BKKsd8smeb5Xfw=;
        b=vg6n100W9JbvrQGv5lQIV1qajo2lgmE9L7oanSiyHWarqXvDff5YwZLRGwypVojb0P
         rlCpb4SxkQ5JbLWQxlluyC3dUmDPRhPhcFgNJ3IUcjMamaKvGjBfmTay++F3f4n3UqNM
         f4gcqkG3dev/H6MoCotx2XdgR/H8mjRbdgBUuCkNYTVsX0WJ5N9jpXSjUhsoeyocRQG/
         j3Fgon40XQfFX5YID+S+TSusayO3uRze+erSmgPCVQ3oIwMmsiPVTF1mDNLiXFIRh3+c
         DB1+veVYu/B3TiPTuuYfYKX/K7laSNBcoerYAKGOzHBrfTpTv8ULCL0Kwhol3fl1xx9G
         KgLA==
X-Forwarded-Encrypted: i=1; AJvYcCUcq+DlowKQSJZu1YEKSyzO7KoRsFF+fxQWU0iiPJOmYwB4H6RehLu5nHLccZPYoYw+Qxl6ouNxjGls4GbuMyUu/8YhBLQn5nBY+3MZ
X-Gm-Message-State: AOJu0Yxk2luUYAXWiDValtiEUdgwERkryKJ4QbLvluoOLOshz/Pbju9D
	zQHVaCnS0SHKcr8JV4980AAlxPHE+XgUuagMDvZxq8p1jZmsBcVV1YN6R5A+nOW+f6lcJv/rjaC
	iF1n7PGI6ZOjd52xAFjVO4VhlLAk=
X-Google-Smtp-Source: AGHT+IE3VsycMfHZ9bzfKVao8hyhW0gX2lzQBQdmfcBmuS8LEK6MztSZPYqyzbvuWf2Rr4wNUUS3flPs/0XCFZT1kv4=
X-Received: by 2002:a25:8205:0:b0:de6:197b:ff89 with SMTP id
 3f1490d57ef6-dfaf65f0993mr8935828276.64.1718064176831; Mon, 10 Jun 2024
 17:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
 <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
 <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
 <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com>
 <CAJD7tkb0Rv4mSPS3DXqF888iVwd++nd99N3WrZYuJhLPDN+dhA@mail.gmail.com>
 <CAGsJ_4ztBavP+ic15V1F0-KUhoE1zh08xuOZ3jMMfuHu=JHNEw@mail.gmail.com> <CAJD7tka2e1tG6vxU2XXKrzZBUBAc1EfcvaLU+yhQbzZO2gh0=g@mail.gmail.com>
In-Reply-To: <CAJD7tka2e1tG6vxU2XXKrzZBUBAc1EfcvaLU+yhQbzZO2gh0=g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 12:02:45 +1200
Message-ID: <CAGsJ_4zCuwi52BU3sW2tFj67NsxapQoS=g76QHwRo=R1i5ZBCA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:41=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> [..]
> > > > > We can't always WARN_ON for large folios, as this will fire even =
if
> > > > > zswap was never enabled. The alternative is tracking whether zswa=
p was
> > > > > ever enabled, and checking that instead of checking if any part o=
f the
> > > > > folio is in zswap.
> > > > >
> > > > > Basically replacing xa_find(..) with zswap_was_enabled(..) or som=
ething.
> > > >
> > > > My point is that mm core should always fallback
> > > >
> > > > if (zswap_was_or_is_enabled())
> > > >      goto fallback;
> > > >
> > > > till zswap fixes the issue. This is the only way to enable large fo=
lios swap-in
> > > > development before we fix zswap.
> > >
> > > I agree with this, I just want an extra fallback in zswap itself in
> > > case something was missed during large folio swapin development (whic=
h
> > > can evidently happen).
> >
> > yes. then i feel we only need to warn_on the case mm-core fails to fall=
back.
> >
> > I mean, only WARN_ON  is_zswap_ever_enabled&&large folio. there is no
> > need to do more. Before zswap brings up the large folio support, mm-cor=
e
> > will need is_zswap_ever_enabled() to do fallback.
>
> I don't have a problem with doing it this way instead of checking if
> any part of the folio is in zswap. Such a check may be needed for core
> MM to fallback to order-0 anyway, as we discussed. But I'd rather have
> this as a static key since it will never be changed.

right. This is better.

>
> Also, I still prefer we do not mark the folio as uptodate in this
> case. It is one extra line of code to propagate the kernel warning to
> userspace as well and make it much more noticeable.

right. I have no objection to returning true and skipping mark uptodate.
Just searching xa is not so useful as anyway, we have to either fallback
in mm-core or bring up large folios in zswap.

>
>
> >
> > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > index 2a85b941db97..035e51ed89c4 100644
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -36,6 +36,7 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *m=
emcg);
> >  void zswap_lruvec_state_init(struct lruvec *lruvec);
> >  void zswap_folio_swapin(struct folio *folio);
> >  bool is_zswap_enabled(void);
> > +bool is_zswap_ever_enabled(void);
> >  #else
> >
> >  struct zswap_lruvec_state {};
> > @@ -65,6 +66,10 @@ static inline bool is_zswap_enabled(void)
> >         return false;
> >  }
> >
> > +static inline bool is_zswap_ever_enabled(void)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_ZSWAP_H */
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b9b35ef86d9b..bf2da5d37e47 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -86,6 +86,9 @@ static int zswap_setup(void);
> >  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
> >  static int zswap_enabled_param_set(const char *,
> >                                    const struct kernel_param *);
> > +
> > +static bool zswap_ever_enable;
> > +
> >  static const struct kernel_param_ops zswap_enabled_param_ops =3D {
> >         .set =3D          zswap_enabled_param_set,
> >         .get =3D          param_get_bool,
> > @@ -136,6 +139,11 @@ bool is_zswap_enabled(void)
> >         return zswap_enabled;
> >  }
> >
> > +bool is_zswap_ever_enabled(void)
> > +{
> > +       return zswap_enabled || zswap_ever_enabled;
> > +}
> > +
> >  /*********************************
> >  * data structures
> >  **********************************/
> > @@ -1734,6 +1742,7 @@ static int zswap_setup(void)
> >                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> >                         zpool_get_type(pool->zpools[0]));
> >                 list_add(&pool->list, &zswap_pools);
> > +               zswap_ever_enabled =3D true;
> >                 zswap_has_pool =3D true;
> >         } else {
> >                 pr_err("pool creation failed\n");
> >

Thanks
Barry

