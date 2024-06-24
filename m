Return-Path: <linux-kernel+bounces-227663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B6915530
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5071F24540
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A259192B67;
	Mon, 24 Jun 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJUxlNDY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCC1E485
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249378; cv=none; b=gjqmdTDZ+xkD7iahDdACpRUYA5NHm1nIZv5mguCZqlc8IJmBLUKSH1uDK2Ua8DEoIPRmckB8cOdJv/V0IlOIuR+Q0socLbQPAd4Hyk+Jm8qjWvr+K/gK9dCx/kiSjYDZr2LWAbqYC1G5mOi+GhsbJQXvT78WwE7/SQWDSaiayto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249378; c=relaxed/simple;
	bh=H9edwEjS5B7AQGy8AmllZkCean26qdfioKRwxdDtaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWmE/ZIPVzeEK61upz6dFTyqAw7C6OrS4jOAESBH/6RTL9NlA4SBDUZxvyYy5s1SG4CnWxj6wCQgiehJDDDqO1GZo++R3c/u0h7XGIS/8zSvmrALPNgA6dAIXNEY3ZXCZSs5f/GQEI1eQgNaSmX0QcWxaPnUSf9A5clh3Uhga1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJUxlNDY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724e067017so175617566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719249375; x=1719854175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9edwEjS5B7AQGy8AmllZkCean26qdfioKRwxdDtaZM=;
        b=xJUxlNDY4OanN/a8oPFpbdUv05nTSm9F8DPL4O0bJ5+Ecl6uujudUR6kSECzyPOYk/
         +bCTBN8hdnxpDlTLGSo/77mVI/dsEqTsT6nCD+ttbUdD1qwA6+NT7mKYaNGrOfLr0Qvw
         A39RNlxLZg0eTXLNbJCv1GiN80l7hho+oDsKFdJ8GqfnNJthDkk8zRdKQYDLivXfrgpp
         gLLq+LlO4DjnD/dZwqVISEGMF2idLHW13UR7IM/VO538F4fWhFgozoRt6gb3SqDF1KII
         Bdyln+UO90F729x2ckxZJNEtNq5S/fgNN6352fXswoFnmkJns6Ctnm1wqCawdCqbQZZ/
         ZhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719249375; x=1719854175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9edwEjS5B7AQGy8AmllZkCean26qdfioKRwxdDtaZM=;
        b=COpvrEx79Qa82Xdb3nHUL6nMQVYTFrOSw87BcRmhbpTs4IhadXWMbezkcb8Vm+2zQh
         axakYRLAWI19Iksf8Mx45/Em3SksEjSVrc9Bu8mYQMzo6CjjHaHWq6sPFbxlhQGpS6Q7
         oQL8v+RRX7yAckh9z2+CtYLE3IRvqRAQjkzQ3LlZMqalPyrJ8c30cY3j224L8woV2QBR
         Mkm7wEBzOwNy6lS9NN+kqmKtdvs1KrwdOs7J/glQ6TkK8z/sqaKqtULf8bLepJMYxEXU
         k3ABJSxq1aajU6bReW+bWFqQclvg7w0+XX33NOiWqUK5lbZ9E1OwBp1hv4KfJ17ahOrT
         MPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXywtj+14RRMeoiGzt7VFntlUmE65svCmAN7sHaI+u6U2ZP3/gE4Qr5v+IqZvnZej5WLSn08j23rK1gI9CEUxPG5mKlcZPMckvNEl0W
X-Gm-Message-State: AOJu0YzUEffjW2KggcU7sdijdO6kw5fn2AVg0wUGXDJYySch9vndChy/
	hlOwZpNh/n2eGaQvCmFz0WH/c3h20PBlFOcm8Pw6Ce0WRW+O4PeqtVdnPUjHArg0RE4TlgcAp87
	Q2JzSK1+MP0ECVQaV6vTslGrPViw/0eB8YURQ
X-Google-Smtp-Source: AGHT+IF3DivSB1Y0R37Xum45ilT5dPAswxJ1cca5C+af3pFyHB5n6SH2IuHQCHYHYtktDQdWe0pXFeLe9qTCaoCFqT0=
X-Received: by 2002:a17:906:a8d:b0:a6f:e552:aae4 with SMTP id
 a640c23a62f3a-a7245b648aamr298567066b.25.1719249374740; Mon, 24 Jun 2024
 10:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
 <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com> <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
In-Reply-To: <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 10:15:38 -0700
Message-ID: <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:02=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > > and I will explain why below. I know it may be a necessary
> > > > evil, but I would like us to make sure there is no other option bef=
ore
> > > > going forward with this.
> > >
> > > Instead of necessary evil, I would call it a pragmatic approach i.e.
> > > resolve the ongoing pain with good enough solution and work on long t=
erm
> > > solution later.
> >
> > It seems like there are a few ideas for solutions that may address
> > longer-term concerns, let's make sure we try those out first before we
> > fall back to the short-term mitigation.
> >
>
> Why? More specifically why try out other things before this patch? Both
> can be done in parallel. This patch has been running in production at
> Meta for several weeks without issues. Also I don't see how merging this
> would impact us on working on long term solutions.

The problem is that once this is merged, it will be difficult to
change this back to a normal flush once other improvements land. We
don't have a test that reproduces the problem that we can use to make
sure it's safe to revert this change later, it's only using data from
prod.

Once this mitigation goes in, I think everyone will be less motivated
to get more data from prod about whether it's safe to revert the
ratelimiting later :)

>
> [...]
> >
> > Thanks for explaining this in such detail. It does make me feel
> > better, but keep in mind that the above heuristics may change in the
> > future and become more sensitive to stale stats, and very likely no
> > one will remember that we decided that stale stats are fine
> > previously.
> >
>
> When was the last time this heuristic change? This heuristic was
> introduced in 2008 for anon pages and extended to file pages in 2016. In
> 2019 the ratio enforcement at 'reclaim root' was introduce. I am pretty
> sure we will improve the whole rstat flushing thing within a year or so
> :P

Fair point, although I meant it's easy to miss that the flush is
ratelimited and the stats are potentially stale in general :)

>
> > >
> > > For the cache trim mode, inactive file LRU size is read and the kerne=
l
> > > scales it down based on the reclaim iteration (file >> sc->priority) =
and
> > > only checks if it is zero or not. Again precise information is not
> > > needed.
> >
> > It sounds like it is possible that we enter the cache trim mode when
> > we shouldn't if the stats are stale. Couldn't this lead to
> > over-reclaiming file memory?
> >
>
> Can you explain how this over-reclaiming file will happen?

In one reclaim iteration, we could flush the stats, read the inactive
file LRU size, confirm that (file >> sc->priority) > 0 and enter the
cache trim mode, reclaiming file memory only. Let's assume that we
reclaimed enough file memory such that the condition (file >>
sc->priority) > 0 does not hold anymore.

In a subsequent reclaim iteration, the flush could be skipped due to
ratelimiting. Now we will enter the cache trim mode again and reclaim
file memory only, even though the actual amount of file memory is low.
This will cause over-reclaiming from file memory and dismissing anon
memory that we should have reclaimed, which means that we will need
additional reclaim iterations to actually free memory.

I believe this scenario would be possible with ratelimiting, right?

[..]
> > >
> > > Please note that this is not some user API which can not be changed
> > > later. We can change and disect however we want. My only point is not=
 to
> > > wait for the perfect solution and have some intermediate and good eno=
ugh
> > > solution.
> >
> > I agree that we shouldn't wait for a perfect solution, but it also
> > seems like there are a few easy-ish solutions that we can discover
> > first (Jesper's patch, investigating update paths, etc). If none of
> > those pan out, we can fall back to the ratelimited flush, ideally with
> > a plan on next steps for a longer-term solution.
>
> I think I already explain why there is no need to wait. One thing we
> should agree on is that this is hard problem and will need multiple
> iterations to comeup with a solution which is acceptable for most. Until
> then I don't see any reason to block mitigations to reduce pain.

Agreed, but I expressed above why I think we should explore other
solutions first. Please correct me if I am wrong.

