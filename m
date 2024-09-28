Return-Path: <linux-kernel+bounces-342621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43C989102
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CCB1F21AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E814D6EF;
	Sat, 28 Sep 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYAoL+dl"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802543C0C
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727547129; cv=none; b=WI+zinj+aGLjlzS3tazVn0rRzVnDOQ1ZS1wTkdqV/3LKQ8JnValzLAWrl48XwX5I+a/Od9zNoAeSGASlId3LcsFLVL3hddu1oKC6v36b6h2+rEA8ivJhtSrcuV1uv0fy7qcxPxbtYpLHHWCgdBmAnI2ivexFsPSocDe7y51Al44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727547129; c=relaxed/simple;
	bh=MdY/Y8s8xqDgKQuXtL5G9clOjcmnMm533GTnFcDL7lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ5mWLEGyPerzviEXlbDx6Ba727vR7jSKQLwFlrqiKk65XQK+5K1N10Nq8z3ZPAlBaaO6e0qCYNp3C03TDeI70qeEedjNIrIp1GfUYhRG/7e2ucF5rSRBQcTmzRaelcoFXRluc8gUYxhVVSSxlUwQd1BqElZp5xpk3NXmKB2org=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYAoL+dl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso572364366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727547126; x=1728151926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1tSX6KXK+1nAZ0odwK92NuRBXV6X5liZSsTngEzTrE=;
        b=VYAoL+dly/D5nlxQbAT/MFWz33X815YgudKXdUqW7Wfay8LCQRBftK+DcDKbiw9FX3
         xWOO9b6XKY/Es18adeqklQi6HSzwE7RuNMhmIbfFNmBByhcMjn3NTc93FElD22h2uqcW
         gaWMcQAJc25HNRbWnR4OC7lGczrTV6WsOunJQ26Cr2JZjOEvZnfvnMKoJDwqf0+8vCcE
         1/vd7yjsHDP6E95ETNfglh9eZKdt3uy5qL4rB4gWFXcrZpRMLq2ZQ+1VRxTvUiTynD8d
         j2+UoprUwZz/BBISx5eIQKW6qFH7HCSmn7rB2oR273ANKVw4wLzXQMw2GN2l/ARgu7CV
         Xohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727547126; x=1728151926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1tSX6KXK+1nAZ0odwK92NuRBXV6X5liZSsTngEzTrE=;
        b=dnRXAGQzREkmi7g7uLN1LmIv7u6u/oN/Z2k9d3mycFw/Drbdca6qNOHVybiuF6QsEH
         VSIrwPD+7yqCKsTU1oNgW6inbNlDbEtEKyRn35ihoug7UrIgnA/WEtM5Ua5z7ibBjZLp
         94DZaS0suzXOXotAuPPODByP1g+VOA/b0j+4WNXia3KhWiDlVO+MokIi32bEwnS+8lUJ
         Z9cn7bKA4P6y0Wcn+Nx3pFrL1LEkSbDIUrj1d0zeWYjjKYKs+GfBkkhjpKEX2HMVehII
         YGu1A9RXD1ZVooQ0grwEPUZ+6M3Dxv9KkAaQGkLDf5ReJfvdpuIzFGw1YejSy5pCYwl/
         UM/g==
X-Forwarded-Encrypted: i=1; AJvYcCXpnKomkqAGT17xUM8bkiKZ9vzY6VB5HEpRSGg1S+SnL8CFOrmwDKx8qHbh2XUf2ukB1vAd6suYyYywJNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9u7vGZMlwU0CAu5W8MXKxcC0I0ynKSX0vJM15++L/Y87mNJ8w
	GNikQ+hzYXik0vvzYaACLymb6QBgxrS39KMwnMM+XN7v3O/dhY1+jFyDFFYLsMpuoXj1G8mocfO
	XftnG9ddfuHx7FDMgdn4Ekxv02axRSOqB88Pi
X-Google-Smtp-Source: AGHT+IGRY39i/STfC2j/oMouTeJpF0nUdCDC0tCFbOs4ADr/Lq3A7oGhwV7NiUzL2y70BVk4oJ8MVd2/97kVISbiZGQ=
X-Received: by 2002:a17:907:2685:b0:a8d:42ec:e65d with SMTP id
 a640c23a62f3a-a93b157cc39mr1220243366b.7.1727547125478; Sat, 28 Sep 2024
 11:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-7-kanchana.p.sridhar@intel.com> <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>
 <20240928141514.GE957841@cmpxchg.org>
In-Reply-To: <20240928141514.GE957841@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 28 Sep 2024 11:11:28 -0700
Message-ID: <CAJD7tkbw7i=JB5NDYmmsxEw--NqkOidNeO-0+Gj0EvZfk627Dw@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 7:15=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Sep 27, 2024 at 08:42:16PM -0700, Yosry Ahmed wrote:
> > On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
> > >  {
> > > +       struct page *page =3D folio_page(folio, index);
> > >         swp_entry_t swp =3D folio->swap;
> > > -       pgoff_t offset =3D swp_offset(swp);
> > >         struct xarray *tree =3D swap_zswap_tree(swp);
> > > +       pgoff_t offset =3D swp_offset(swp) + index;
> > >         struct zswap_entry *entry, *old;
> > > -       struct obj_cgroup *objcg =3D NULL;
> > > -       struct mem_cgroup *memcg =3D NULL;
> > > -
> > > -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > > +       int type =3D swp_type(swp);
> >
> > Why do we need type? We use it when initializing entry->swpentry to
> > reconstruct the swp_entry_t we already have.
>
> It's not the same entry. folio->swap points to the head entry, this
> function has to store swap entries with the offsets of each subpage.

Duh, yeah, thanks.

>
> Given the name of this function, it might be better to actually pass a
> page pointer to it; do the folio_page() inside zswap_store().
>
> Then do
>
>                 entry->swpentry =3D page_swap_entry(page);
>
> below.

That is indeed clearer.

Although this will be adding yet another caller of page_swap_entry()
that already has the folio, yet it calls page_swap_entry() for each
page in the folio, which calls page_folio() inside.

I wonder if we should add (or replace page_swap_entry()) with a
folio_swap_entry(folio, index) helper. This can also be done as a
follow up.

>
> > >         obj_cgroup_put(objcg);
> > > -       if (zswap_pool_reached_full)
> > > -               queue_work(shrink_wq, &zswap_shrink_work);
> > > -check_old:
> > > +       return false;
> > > +}
> > > +
> > > +bool zswap_store(struct folio *folio)
> > > +{
> > > +       long nr_pages =3D folio_nr_pages(folio);
> > > +       swp_entry_t swp =3D folio->swap;
> > > +       struct xarray *tree =3D swap_zswap_tree(swp);
> > > +       pgoff_t offset =3D swp_offset(swp);
> > > +       struct obj_cgroup *objcg =3D NULL;
> > > +       struct mem_cgroup *memcg =3D NULL;
> > > +       struct zswap_pool *pool;
> > > +       size_t compressed_bytes =3D 0;
> >
> > Why size_t? entry->length is int.
>
> In light of Willy's comment, I think size_t is a good idea.

Agreed.

