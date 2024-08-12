Return-Path: <linux-kernel+bounces-283659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB194F778
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0281F22DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AE1917C0;
	Mon, 12 Aug 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGVqPX5m"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8B18E02B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490777; cv=none; b=cmnNL+25a5PdbuIxiBMlpHgxNipuPrExDKt2C1w2PnZPhbsYmlkdgxZkjuZ8Ou4SBRX0mz6k7hPqgs35gohCSZTvvb+pU3VBgSYSfCV0Gjl7N+3TkuhL7Nx58Wb0Bi1Pi1a4SEK89N8GOxZHZLvllJ1ccMls8IqvlLwFVOsW4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490777; c=relaxed/simple;
	bh=+iCfWlB2qK00CgemPwOLacXMlY7BioE6jBZqc37YHus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C53ZKh9yPKfxBTF12vOO7mTtfctneV8vP1+k7SSJHtsBW9wu8RnKXNUMjcINmsRNU6nsnxPKI2L2Xj3NuEd5mMigAHX94i0uaO0Oz+fDeVsuPcwCZ34BtYiikMoG+8AUp6ars2AHBsZ14eU+Zlgic17pA0JlE/jhAYkD7bpIBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGVqPX5m; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65fdfd7b3deso43345557b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723490775; x=1724095575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qOTNxJuDi4l+kkwsANOYH20hBs3wkhnJKGca4BkDSE=;
        b=cGVqPX5mWpJm8+O++KRfnRhjvIDwQNdxRNZnV4lnpQBewEUJXPRouq5YfMND0M83eR
         0erSjGBchoClmjWzv7c1DjqANJQpxSv/0E0j4H19P7nJNkuY2Efy5xN+pZhczH53K4PU
         8e8HRdBFg7NzY7McNLd+PMv9oeGBbwjexqsynHyh/tjp99rhGti1wg4go1g7p1KRdr0t
         ei8yHu3d4eLEr7y/v4OiWHabWfjKZ8MZ0vOLYoPpgUuIW5ILbmaJi77+JcNDhIa+50QX
         90lGDT4utlvtgxb6ht/TXFbsCBUae2+2Le7Ok0QdJqAI4/DOmgpd6WK/R25vkTUQunL4
         Pw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490775; x=1724095575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qOTNxJuDi4l+kkwsANOYH20hBs3wkhnJKGca4BkDSE=;
        b=U7LajY/IE3+HCJedd1Z93ffYf+ObbhrUN3RgZ9Iz0bIn0gwBwrC/IZEbcB6ohG9Fds
         FlhlxA6H/FnMOaGx2ilWmOt08e3k3izORiC/TaDZ1xnKHhkZjEtrM/5+1w9nQwXFXnY0
         dO03nTCUy0MvgXbqNzOoj0BNAjIHQ002s/CzzL4E4dwbhIMOGv4jhBi85z5ctfoIE5k5
         BpZ1/86LK5Bwn/BDhmUMUDWtwPECyxOxF5S73lXrgTyZ5HzHNSnd7tetTILtJ1fhebEj
         kC2ZyNwObM0gRri4bFwrmJYGACJKHewdwEgK3bdtIhcFIcoEWgJS+xciOKVDUD577ri2
         ah0w==
X-Forwarded-Encrypted: i=1; AJvYcCUDu2WW3osWZXkRnJIasToiYviMtyzNR6nc74BeOT0EM+RQjt0ns5FQw5TqIdLb5Iw3a5pleBG02oFyqSXzzBfE3H1riYsH0QKT+77d
X-Gm-Message-State: AOJu0Yxh+Ftzb0gGTUac+eekaVicsf8KPeZoFvxCws3ecL2yGorjYWTY
	RozLd90rsI7ugP6fyMZis7pvBiCvR74uIZ6O3EccK869eF7PpWTFESrawe4cUebjWiVy0zw/91M
	3Tp0wPEkusLWc6YVWmhd265pu2dtrISaY6NUH
X-Google-Smtp-Source: AGHT+IFGf0WycWYbTvNVHWKDUUMcMceyv4Kuc59J35T7TEhghacRgHCE3k3Dm4XPQhix0qKukNFnNbUSv4OHcf60U58=
X-Received: by 2002:a05:690c:f0c:b0:664:badf:5a8c with SMTP id
 00721157ae682-6a9718f3671mr15973087b3.3.1723490774408; Mon, 12 Aug 2024
 12:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812184455.86580-1-surenb@google.com> <CAJuCfpFFEa43D2qMkO_DpscYSAjKrvPo7b3hFMtxDrDAmo=fmg@mail.gmail.com>
 <CAJuCfpHgj4X9yEMsqoO5uNPT=C36rpQbK5ie959Qv1QE5xOChQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHgj4X9yEMsqoO5uNPT=C36rpQbK5ie959Qv1QE5xOChQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Aug 2024 12:26:03 -0700
Message-ID: <CAJuCfpFfv4ot4=UnoLP2TcBaUB0yLE6PKP4P2FHnghvDOPuUbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark pages reserved during CMA activation
 as not tagged
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Aug 12, 2024 at 12:11=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > On Mon, Aug 12, 2024 at 11:44=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > During CMA activation, pages in CMA area are prepared and then freed
> > > without being allocated. This triggers warnings when memory allocatio=
n
> > > debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> > > by marking these pages not tagged before freeing them.
> >
> > This should also have:
> >
> > Fixes: d224eb0287fb "codetag: debug: mark codetags for reserved pages a=
s empty"
>
> And Cc: stable@vger.kernel.org # v6.10
>
> Let me post v2 with these corrections...

v2 with corrections posted at
https://lore.kernel.org/all/20240812192428.151825-1-surenb@google.com/

>
> >
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/mm_init.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 75c3bd42799b..ec9324653ad9 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct=
 page *page)
> > >
> > >         set_pageblock_migratetype(page, MIGRATE_CMA);
> > >         set_page_refcounted(page);
> > > +
> > > +       /* pages were reserved and not allocated */
> > > +       if (mem_alloc_profiling_enabled()) {
> > > +               union codetag_ref *ref =3D get_page_tag_ref(page);
> > > +
> > > +               if (ref) {
> > > +                       set_codetag_empty(ref);
> > > +                       put_page_tag_ref(ref);
> > > +               }
> > > +       }
> > >         __free_pages(page, pageblock_order);
> > >
> > >         adjust_managed_page_count(page, pageblock_nr_pages);
> > >
> > > base-commit: d74da846046aeec9333e802f5918bd3261fb5509
> > > --
> > > 2.46.0.76.ge559c4bf1a-goog
> > >

