Return-Path: <linux-kernel+bounces-212509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB76906238
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579891F212AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0412CDAF;
	Thu, 13 Jun 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6fMNDli"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025A12AAE0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247499; cv=none; b=nNXmEjAFJz7R7IGrEwQVLYqUJgKQ+GQ7BQKxwNKhVh8bSNxmrykK6qdCcR5hZZsSzSSbK9CiaBJkQ07n8rhM0/lVwlcDeixddGXCLUElJj+4VzUI4hwscJj9SRo/xDcx59jO40CTme+PjnzAjtS1NQQdzhj4y5kr3m68avW1wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247499; c=relaxed/simple;
	bh=cudCwVPFY8gj3Xql79RT0/yQoQxsiwHECqig9oVJ5Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yek2JZ6d+vGHpaIESll47pHb9HtCMuP+nj4DyuVkpG4dv1nS2XufBKicM3O0eeenQDQEyjugxBmnrVm8T9sfmXk3/eiO1/0oldOx9+rxdAMPKi4x9zOC0zuSo2pO6fOE90xDRWgD2WkIMAdNqC2XlQFGtQnrsf2M4N2FTt3ikuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6fMNDli; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cad452f8bso359199a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718247496; x=1718852296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYlALMaSt5bKOLPpkzaQGZT0pfqD9pv8OI0qHYxUheA=;
        b=l6fMNDliM0xtpewAV1oA3nGowb9jWtg018U2Sgsq5VA8Gt3qu4efvmFiUcT2PBBapM
         Tq8xS0T3BkgiPPCc+adYOvQ+H+/+cqvqkJlTzyPgT6r7cdd2cbf/Orboq921QiOio6HQ
         kYMTpBjS1V7Z60/07G7b3YHus6lp1J7qyslVQiI9vqqjlALnKG/eSitVJnztZ5xbkOuf
         nCemvfWonqDse0N9G+yCe/Sxmu+6cYW6P0bLxv43jp5w18hjsHqxNoWCtPvwlonSRsAi
         pUTnqK3gF18n1+ukT9P+8LEgNQk1shZkfZZAXU1jdrIUA7WT/82pE4QIL3xizO4J1MOF
         9+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247496; x=1718852296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYlALMaSt5bKOLPpkzaQGZT0pfqD9pv8OI0qHYxUheA=;
        b=RSqGpTzNjZ9QK5rBY2aqHN+y2dleuJKPlj+FbJZMf45BXarRdeu+oJ7AS3g0TKyVdX
         LKA/DHGusoayyzt1Qc7YBqjzQkTOaJ1ZwAJYRWSyxno6GyxrZaCpJCHbae85VLZfIXc3
         9VIJqtyV1nTW+pXr/z0izXAANWhet8pctXOFfqj6nVgH8q1Jupke92Gq2VZNaW5OdeKS
         O5EW8E+jU5htWI9YopSt62o8+UasQUd4bo2S2CtHDX19T0NnsMufgCh66GGH2Cx2RVb5
         v5Zsgz1iz7pQZg0yhhmjm4QmIIc1bVcAwTq0gfICut8UnqEBI/cR+btCbHudfgmp3xgY
         JjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfU+62mmIl2HLVdxhSdD10IUXQk516eJXilw0fcQL4Jgn73EcuXCAs5fJWB+M4p/0l+D7EhoDuW8pGjtJ3n+BgWZnE0n073wbw+IOD
X-Gm-Message-State: AOJu0Yzn8coR3scUYM+Jy3XuWSpoVLHwn7GwIkthzPnhQTX2Cq5hnG3L
	wwzBCLQDcPOB+v/N4ILKrBdoGp9r5GqTCtIPbe4K2WQrmZ6MHxjeRA3jOyoU57epg06QS1pXIoB
	jFu679j7vwrEbT2wKYNdu1DkV38+JTOXHdINp
X-Google-Smtp-Source: AGHT+IF9CciRYK/S+Ij1+KuSCnynD6lav8vXAPrkXMbU5iqPDXNWqrABMnPq8TuNELzKnGWLPQ19ZjeHQ37ywUEgQSE=
X-Received: by 2002:a17:906:c149:b0:a6f:4d38:f40c with SMTP id
 a640c23a62f3a-a6f4d391d2amr193732366b.62.1718247495476; Wed, 12 Jun 2024
 19:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
 <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com>
 <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
 <CAPpoddfj1EdfXfTUT8bLaNxat0hYiE4X9=qG38gPgRgmmVOjcw@mail.gmail.com>
 <CAJD7tkZTSGz1bpo-pMNP_=11O-7RrhubWonqhUJwrt+TB=Ougg@mail.gmail.com> <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com>
In-Reply-To: <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 12 Jun 2024 19:57:37 -0700
Message-ID: <CAJD7tkY0=0yKSmEz=E5dL7GLRsO8r6ESWyzF+HdgK0wnMpzLKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:36=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B46=E6=9C=8813=E6=97=A5(=E6=9C=A8) 11:18 Yosry Ahmed <yosryahm=
ed@google.com>:
>
> > > The corrected version of the cleaner should be:
> > > ```c
> > > void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> > > {
> > >         /* lock out zswap shrinker walking memcg tree */
> > >         spin_lock(&zswap_shrink_lock);
> > >         if (zswap_next_shrink =3D=3D memcg) {
> > >                 do {
> > >                         zswap_next_shrink =3D mem_cgroup_iter(NULL,
> > >                                         zswap_next_shrink, NULL);
> > >                         spin_unlock(&zswap_shrink_lock);
> > >                         spin_lock(&zswap_shrink_lock);
> > >                         if (!zswap_next_shrink)
> > >                                 break;
> > >                 } while (!mem_cgroup_online(zswap_next_shrink));
> > >         }
> > >         spin_unlock(&zswap_shrink_lock);
> > > }
> > > ```
> >
> > Is the idea here to avoid moving the iterator to another offline memcg
> > that zswap_memcg_offline_cleanup() was already called for, to avoid
> > holding a ref on that memcg until the next run of zswap shrinking?
> >
> > If yes, I think it's probably worth doing. But why do we need to
> > release and reacquire the lock in the loop above?
>
> Yes, the existing cleaner might leave the offline, already-cleaned memcg.
>
> The reacquiring lock is to not loop inside the critical section.
> In shrink_worker of v0 patch, the loop was restarted on offline memcg
> without releasing the lock. Nhat pointed out that we should drop the
> lock after every mem_cgroup_iter() call. v1 was changed to reacquire
> once per iteration like the cleaner code above.

I am not sure how often we'll run into a situation where we'll be
holding the lock for too long tbh. It should be unlikely to keep
encountering offline memcgs for a long time.

Nhat, do you think this could cause a problem in practice?

