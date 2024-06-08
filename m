Return-Path: <linux-kernel+bounces-206857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA55900EE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FB41C2140B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D433EE;
	Sat,  8 Jun 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgjUOQpV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EA1391
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717806773; cv=none; b=haUO2IImx6j9ppCMDX4K4/CWiTA5acfnOC+Bdh58RNr7bAS9mwmP5GRLjfV0zai1qr91W4zd1sK68o0Rx55PSqS2/mNK6hQ4v//shqeIo+y/EzlSYyTTZMfqQY/pkFchpcNmzhLnqt/n/9kZ2G51nljTw5Mtn6ccX+hAA81PkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717806773; c=relaxed/simple;
	bh=Gjga0hn0EKlhttYQ3pJWY9jgRupfj6fc9njlrirZU18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2LTx70+qbEzrsYTAg9XpfPFwUh8NtYYjVecFd+GM7tAvO9DhN6QJNDc1CZl//oown/Ou0e2hAmntGLzZkPPW0TgPOK/U4JSTbo6sPjn9yBfsSVoJj5/eZuUWHvE2c2weuIwNBYJkmTF54Io0Q3HPmTxABNIeYdsA3HLnHXTcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgjUOQpV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so4059121a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717806770; x=1718411570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjga0hn0EKlhttYQ3pJWY9jgRupfj6fc9njlrirZU18=;
        b=WgjUOQpVszBXyV5B3we64OkkpL+xfrorIdIrsGr5hZDR5obU806t1jPd7NYjach4NB
         gDkzYNXyNwYVr55gYZubtWHeEm2AB/IW2Efah+0dWK/fjpdCWWM8udcxH7B9tyJalqDs
         6mpI/OwXEfMktl2lUFWAb56dIAm5TGcfBYkhOgK94FqXmyB5jJeYKxZjW9dFrD3fAncx
         YTkGGhBSHZJEUbT6Wpu1ubxJo2gQ7YEHv9ouWxiCqCurbKY8glUgc6X4HJKcG28cZItx
         dAVC72hb+Pxir8y7k1xbOlg+sJ7GpHqZKSwVTSks5ZFc7Zzw+WW5iMIrfUxPgI2tomjr
         dH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717806770; x=1718411570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjga0hn0EKlhttYQ3pJWY9jgRupfj6fc9njlrirZU18=;
        b=Cl5SFpk3NHAOOXHNAi/nJd+vJGsOuKFudgayZuy+w6rYE5hnl5jMgY5r0idO42mnuh
         siOR6xnXkC46vc2+9V11RGXLX9YTLKcchrQm8ZcI3DRUD67GQynqGnvo5lDb4O+q6Y8X
         8Iv1Q2Dm7OIA5ri13QtPy0zjV82jZYQqe2iSQOS8IZQx+by1oKpUZfqCEtLHdpo5nuMh
         9WYr3TmE7flnsE469ncTge+lPMAOLtls8gk5jhtuFDrdTzlA1xt/5Kqu3H6j0mrWA9Or
         t1+Hi0EBR+e/lbnAmkQBhcHmIB3oDA8S8gRl93RVN79iLTx2VuGhkuR7YvLFexBtGdrg
         c6lg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6a7XC516mwITd5wouAOxAZqAbrRMGGUBAymXRQqUWmzrN5kzz5Lr7nCyqxkq5+S7+gk/WAlemKFmC++e2onCmeNV0szsboYBqjiU
X-Gm-Message-State: AOJu0Yyg54USTp9+42e9UpThWJF5SYhyYKw5KOttscDVzI6EqHn7ImcB
	kEfcwSKYqCTbqF0vZKmx3eiF91Bm4oPjtAvfzoHO13QOx6wOU7If2adBYHc3IUJiDh4BdiuSf/I
	+3ETZE9WGS8Z9YsQfRzwMAmQRyxiKClPEdpGw
X-Google-Smtp-Source: AGHT+IG5qAZMEPlKi0knM0nu5fvRiQ9tBkRXKkdt/ErKfAH8fr867ynO0Mfm3VjxFrMs3Xe0Y5p68pQQwQ9U710RooQ=
X-Received: by 2002:a17:906:3299:b0:a62:cf3b:77ad with SMTP id
 a640c23a62f3a-a6cdaa07abfmr290069566b.49.1717806770173; Fri, 07 Jun 2024
 17:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com> <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
 <CAGsJ_4ywmVbO+nrbcxz9YMdzi_y5qSUG3Cg=3oz3kNpQ6gg6iA@mail.gmail.com>
 <CAJD7tkZkChE_bGJCnf3u0493PZOe1=+Y8S_nq2=j1uP-BtZ9Mg@mail.gmail.com> <CAGsJ_4zU0fVj8M-qKnQAKoXdrQrBuQchs_yZ32=e2uY80kvxxA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zU0fVj8M-qKnQAKoXdrQrBuQchs_yZ32=e2uY80kvxxA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 17:32:13 -0700
Message-ID: <CAJD7tkZH8gHouYM=GT-njsKmV7=wD6bxSKn5zEwQsE_GAUzsfQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:28=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Jun 8, 2024 at 7:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > [..]
> > > > One problem is that even if zswap was never enabled, the warning wi=
ll
> > > > be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable o=
r
> > > > static key if zswap was "ever" enabled.
> > > >
> > > > Barry, I suspect your is_zswap_enabled() check is deficient for
> > > > similar reasons, zswap could have been enabled before then became
> > > > disabled.
> > >
> > > I don't understand this. if zswap was enabled before but is disabled =
when
> > > I am loading data, will I get corrupted data before zswap was once en=
abled?
> > > If not, it seems nothing important.
> >
> > If zswap was enabled and then disabled, some pages may still be in
> > zswap. We do not load the pages from zswap when it is disabled, we
> > just stop storing new pages.
> >
> > So if you just rely in checking whether zswap is enabled at swapin
> > time to decide whether to use large folios, you may end up with a
> > situation where zswap is disabled, yet parts of the large folio you
> > are trying to swapin (or all of it) is in zswap.
> >
> > This is why I think we'll need to track whether zswap was ever enabled
> > instead (or if a page was ever stored).
>
> Thanks! It doesn't seem good. Do we have a simple way to clean zswap
> when it is disabled? seems not easy? Just like we do swapoff, or disable
> cache, we ensure they are clean - this is a real "disable".

I think it's just simpler, and disabling zswap at runtime is not that
common. Keep in mind that if zswap being disabled takes time, then
we'll want to handle races between zswap being disabled and incoming
swapins, it will probably end up being a state machine or so.

Without a valid use case, I think the complexity is not justified.
It's probably simpler to just track if zswap was ever used, and
disable large folio swapin. This should be a transitional state
anyway.

