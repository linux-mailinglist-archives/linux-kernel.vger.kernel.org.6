Return-Path: <linux-kernel+bounces-339637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4E986842
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2631F23973
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244314D430;
	Wed, 25 Sep 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKsB1ur3"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F41CF93
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299406; cv=none; b=Ch+EdcmvKx9MKKTqnbPTe0iIDqVr0IjUQXIRoOmgqk76cUc8OfMNPdqKll2qSzZCatGqx+pfO1+Iknu1pg3SF1DJX0/vUFQSYMqBobavf/AL9M+33MWzw4R6K23K17M1t0LJUUejz2lBevZFa88+uhPpzlCJ5etoLRBM4hQFfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299406; c=relaxed/simple;
	bh=xzjH/92jjMnUNJmn6715vbklG+b0RjBO0jA77EpiR5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgUxV4wJbn1gPtHPX3YyeI5bDyu2CLe/AxcAtAZZ9pVvdDD2IfkpEQTUdZpUVILgN2ZCWOVv+6do2Ul4QdKa7gud+jowqUzq9xHJK0vtJB8WxD21oUzgcoBFUrqMnr334DxfmrQomY4mVXHbXj1Om7WBhuagbTs0azxT8b0EQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKsB1ur3; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49bd40d77e5so136461137.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727299404; x=1727904204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K7gyhap+H2n6PUqc57MGvJNsh7ab/hzu5M29MqKlLU=;
        b=EKsB1ur3z68YbKWx/1ubaJhva4dYkvRe3hH8VegsvgXseC92JjjPBlwvj/5ATDKrpB
         KaiJhJ3jyRg2/2SEQxhGdaKceX2W8s8tycsqG6S2rEKzQB7gzMrX0mWqqf3uG+XhFz2G
         m40mGclGX5e3LVJQAQHT0w/n7kTxuIsYw+7u5wGowzSG3XHMDGHwvok/csHvPmtycLu/
         2wX31t7NB3lsXkWd+YEakCUZw+JatPfcN5wYHI4S7GYUdLpR8bufyO9QI6UuEQQVismm
         Fsatswa+x6Yem3DtcVSdGvyFPL9NMzSAZY4MAQCK0+N6QaBAXwqZZNte55rXZcLt1Trw
         TEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299404; x=1727904204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K7gyhap+H2n6PUqc57MGvJNsh7ab/hzu5M29MqKlLU=;
        b=Glq7fpXIwbDnHfmpHXwjTcqk7ZW/DKWWdfiM09sMF30LrUGBAe0QuG7ojEsEmSbbqb
         r9lZ8C8EL3UaT7Z+HtjZKZll/W5kWWIj/cyn1sFMkfKwhBVwEUlWbR97gceff25iTGa1
         rpFf1npu/r7YD9I82W1U1DVQ20cFMnq5UPnjPmuLS6ZG8+i+jsvY2SIQJlNjp+96F9fj
         Yd3G/Pnu4DTOhSbAhbTZQ/FtTGFV8oumhgjdtXnoy2PFCKzgoVfTg6H8xPJ+lLQxesID
         etidBfNOabLZcbLSIw+CRxeVmKhzB3ovkGZ0pFqjGTU/oiCIMbdkv60lc1Bn0YauHopl
         dstw==
X-Forwarded-Encrypted: i=1; AJvYcCV0CQDo+cDQViw1neKmTQLdJDCXnTrN7kcF7321wiD47qVXrj5a0Q9efEk4z/1MqNkn7I/iM/M+4CLMApo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUotiKa8SGy9kREHoW+KfHQMFnWZ+AsNgWDU3wLyTjI66rMC5K
	F9jeqImTIkUS7iA6ocirDwXqE0nVRELw/si6zzUSPRCJsapTC3/VL08KNkXeByEGsAmKOYv0qcJ
	rgBAFPjGaFpRMSJgYMGCupQKGOYy0CHG+X42v
X-Google-Smtp-Source: AGHT+IHARl/sqH+UF9Tgj9PZ7hVymFoqDVNm06j0xdMsPZYx83BlOyjx2GcScpIQBmBMYcIWEgcI6u5EJYgdRDazAFs=
X-Received: by 2002:a05:6102:2911:b0:48f:3f9a:7609 with SMTP id
 ada2fe7eead31-4a15dc67936mr5164754137.5.1727299403620; Wed, 25 Sep 2024
 14:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925030225.236143-1-zhaoyang.huang@unisoc.com>
 <20240925024215.265614f6839e752882b1c28b@linux-foundation.org> <CAGWkznG40FyJxOzB1jRsBVGPrZhV=ceKWzTQSTq2TbzRLMAZ5w@mail.gmail.com>
In-Reply-To: <CAGWkznG40FyJxOzB1jRsBVGPrZhV=ceKWzTQSTq2TbzRLMAZ5w@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 25 Sep 2024 15:22:46 -0600
Message-ID: <CAOUHufaQh9OmbnraLvpS+RMqYQOeatSrb==CaNKn63j7yfJCgw@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate LRU_REFS_MASK bits in folio_migrate_flags
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:50=E2=80=AFAM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Wed, Sep 25, 2024 at 5:42=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 25 Sep 2024 11:02:25 +0800 "zhaoyang.huang" <zhaoyang.huang@uni=
soc.com> wrote:
> >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Bits of LRU_REFS_MASK are not inherited during migration which lead t=
o
> > > new_folio start from tier0. Fix this by migrate the bits domain.
> >
> > I'm having trouble understanding this, sorry.  Please more fully
> > describe the runtime effects of this flaw.
> Sorry for bringing confusion. According to my understanding, MGLRU
> records how many times that vfs access this page in a range of bits
> domain(LRU_REFS_MASK) in folio->flags which are not being migrated to
> new_folios so far. This commit would like to do so to have the
> new_folio inherit these bits from the old folio. Is it right and
> worthy to do?

Correct. And this was not done because
1. While LRU_REFS_MASK is useful, but it's not important, and
2. More important information, e.g., generations, is lost during migration.

So I'm not sure how much this patch can help. But you think it does, why no=
t.

> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -291,6 +291,12 @@ static inline bool lru_gen_del_folio(struct lruv=
ec *lruvec, struct folio *folio,
> > >       return true;
> > >  }
> > >
> > > +static inline void folio_migrate_refs(struct folio *new_folio, struc=
t folio *folio)

Nitpick: folio_migrate_refs(struct folio *new, struct folio *old)

> > > +{
> > > +     unsigned long refs =3D READ_ONCE(folio->flags) & LRU_REFS_MASK;
> > > +
> > > +     set_mask_bits(&new_folio->flags, LRU_REFS_MASK, refs);
> > > +}
> > >  #else /* !CONFIG_LRU_GEN */
> > >
> > >  static inline bool lru_gen_enabled(void)
> > > @@ -313,6 +319,8 @@ static inline bool lru_gen_del_folio(struct lruve=
c *lruvec, struct folio *folio,
> > >       return false;
> > >  }
> > >
> > > +static inline void folio_migrate_refs(struct folio *new_folio, struc=
t folio *folio)

Ditto.

> > > +{}

A line break between "{" and "}".

> > >  #endif /* CONFIG_LRU_GEN */
> > >
> > >  static __always_inline
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 923ea80ba744..60c97e235ae7 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -618,6 +618,7 @@ void folio_migrate_flags(struct folio *newfolio, =
struct folio *folio)
> > >       if (folio_test_idle(folio))
> > >               folio_set_idle(newfolio);
> > >
> > > +     folio_migrate_refs(newfolio, folio);
> > >       /*
> > >        * Copy NUMA information to the new page, to prevent over-eager
> > >        * future migrations of this same page.
> > > --
> > > 2.25.1

