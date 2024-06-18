Return-Path: <linux-kernel+bounces-218611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170490C28B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333E81C21AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB4819CCED;
	Tue, 18 Jun 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjJEIQqH"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528B136E1D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682154; cv=none; b=svxCpH2ClNPgni5yIhQjA6ppMyHz9B17vRFaWcIgZIYAi827EdjeM3JxRgXcWX7fC+uhY5sM74F6sUyvBlhGihm9KKPmENRwuYx15NC+padFOm+9SsNz5cocSS2Z6qppFGerhc4tPmD0kflBpwibUFddnJzm+2fEIdvvrD48VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682154; c=relaxed/simple;
	bh=mr9Umo5O3LBLHMSACCL8BnvvbHbeF/lv//SWSngEDfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWOo56UGkeHY4OKr1p7ZlyUH5Zn6pf8h02WgO3F6SVtOLlkj4iF9cax7uvNY0l455kOyIFuDqItVIUz8JoIcn+GCgZpDI5fvcr/vP40jBNNxOpyzW1p2jvS55WPgRuryFvAeW8/9mj5cAXMd9FA5vhqC160fJb7gC7atbWGHelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjJEIQqH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so51827451fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718682149; x=1719286949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQlgYRumVUXLHTiMx5rAYm4M7MKQ2xqVXRN5Nr59i5c=;
        b=WjJEIQqH2kx9NcMSJ+boRCx55xs7CKhsjHvN3MttrZk+a7njmCp3vcWjWOjVqMDjDO
         EfgbAfWTXD6aN0jEbrCuW7s3Mmtt95z5JS2/7bbRWaRsIrjNzqIQKrBAgZFolF2qoeA5
         B1DN5DQEABgQRE2RV7lnZ/zPsUncworX6kxTRFNIBVGWDBit2HBhhb2kUFvmBVBNT+9r
         LXHbx29Gm3kXBe4A2cCWS0frlxK2C0CtAVEKpwSUO9mgSy8FbLCvYA5bz/x3pGbQZVG9
         YkwtKZ9KV8EuMx0ywiSTXrg14nQhaUM0lxN12PdkcsI9SGdAAUkFh4dqpaRYymONF+SS
         5KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718682149; x=1719286949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQlgYRumVUXLHTiMx5rAYm4M7MKQ2xqVXRN5Nr59i5c=;
        b=KRT08vEO8hKKDmgp2fLXuL2e9qaSBX5GrykBv9VRmlFeU2AoibOSKtQUgJNiL3fZek
         GpXmnluNNIHIXOT113C9KfuIY8sELWBBCC24HpTgM3Qma5YOzHt6+Dpkt4ZTQaE37Bzw
         CGJLxotqLsPIb2iqXEcmKVm1PG0MxvDc7v0DojVLCTQuCo4KrCSUBLlxWsGPhFR80LXf
         wvJFZ3ZQ3+uZ1D9TSqlKt1jlQY0maaDJhAPz0ETepCnstN1ek080yzNX91PWo9xpnJ12
         6KV/TX+mcEw+WlKtnl/NZaaePga4uD2JmW8cXuURV7nLQJyYniyJSzJs4CQoRhUT33cR
         WsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdCUcOHAdMHoPRdow8rE18CWVbO2b7lCtWfY51NT5PGXf3mI68nZgssmJnHy89bM0ATIbJvlaWGtFIXVmMqNYOi5nLnxfooO0YkQo
X-Gm-Message-State: AOJu0Yw8BpucIfKtOTolpic7VVgGL5p6D2pcGSZlOx7fwAcR+tlbMLYS
	8JNu2sV3o9agBCXENC67Yj/kaX9EKanXEsYAdiFU2l5HvM60uNDPHYu/lRVaBbfRsz8VP+8sVMG
	YCpBRRZfbUvY0HmwV0udewqgO1EvY9mD/
X-Google-Smtp-Source: AGHT+IG15zlh+lCtXaMz7BpFoslec2WYJbCbU8nDBzFG6htRZfLeCw6IvXRIohIVvjbp1+iRfiXytcW2o5/LX0Obopg=
X-Received: by 2002:a05:651c:221f:b0:2ec:1042:fafc with SMTP id
 38308e7fff4ca-2ec1042fbdemr87438671fa.0.1718682148958; Mon, 17 Jun 2024
 20:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com>
 <ZnD8qYvpyhYtWeHd@casper.infradead.org> <CAGWkznG2Ts0khArZ_X5EYKG7n9=HmcO8d16KVUZ+uQffEc3vrw@mail.gmail.com>
 <ZnD_mcxk_PCyWNmQ@casper.infradead.org>
In-Reply-To: <ZnD_mcxk_PCyWNmQ@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 18 Jun 2024 11:42:17 +0800
Message-ID: <CAGWkznFgPzqX4w25H26rHaagqmD3Nh7g_VhvhHFouWiQjt1b9A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix hard lockup in __split_huge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:31=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Jun 18, 2024 at 11:27:12AM +0800, Zhaoyang Huang wrote:
> > On Tue, Jun 18, 2024 at 11:19=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Tue, Jun 18, 2024 at 10:09:26AM +0800, zhaoyang.huang wrote:
> > > > Hard lockup[2] is reported which should be caused by recursive
> > > > lock contention of lruvec->lru_lock[1] within __split_huge_page.
> > > >
> > > > [1]
> > > > static void __split_huge_page(struct page *page, struct list_head *=
list,
> > > >                 pgoff_t end, unsigned int new_order)
> > > > {
> > > >         /* lock lru list/PageCompound, ref frozen by page_ref_freez=
e */
> > > > //1st lock here
> > > >         lruvec =3D folio_lruvec_lock(folio);
> > > >
> > > >         for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
> > > >                 __split_huge_page_tail(folio, i, lruvec, list, new_=
order);
> > > >                 /* Some pages can be beyond EOF: drop them from pag=
e cache */
> > > >                 if (head[i].index >=3D end) {
> > > >                         folio_put(tail);
> > > >                             __page_cache_release
> > > > //2nd lock here
> > > >                                folio_lruvec_relock_irqsave
> > >
> > > Why doesn't lockdep catch this?
> > It is reported by a regression test of the fix patch which aims at the
> > find_get_entry livelock issue as below. I don't know the details of
> > the kernel configuration.
> >
> > https://lore.kernel.org/linux-mm/5f989315-e380-46aa-80d1-ce8608889e5f@m=
arcinwanat.pl/
>
> Go away.
ok, you are the boss anyway. But this series of call chain does have
the risk of deadlock, right? Besides, the livelock issue which is
caused by zero ref-count folio within find_get_entry is kept being
reported by different users.

https://lore.kernel.org/linux-mm/CALOAHbC8NM7R-pKvPW6m4fnn_8BQZuPjJrNZaEN=
=3Dsg67Gp+NGQ@mail.gmail.com/

