Return-Path: <linux-kernel+bounces-257792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74977937EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BA282033
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEBD535;
	Sat, 20 Jul 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7YxT9Kl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9431B67D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721451192; cv=none; b=Uxpg227+bGcaTlVQkxJeUvF0paeMW8rK53RKDEaGBt8Iv4nrfOfvkw35Hz+nqFgQ7gW81q313JCeydMyIZ/xO/cJ5QLcyR9h+FiHtvngy1HsnJsKviFN5eoEd/8DHqflFoaOI73DZ4MkRu1peqG4Iexr9AL4nmLj7qfTZidUE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721451192; c=relaxed/simple;
	bh=H2k2l7JgCsBFkV5JACOdQKLwvUVvJd0wvKwI6imVZ3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBTL84nMNwM+Y7RS8GtdU03BenIYhiCbNlt4ad17sQtI8x6ObA/aMWasenUdqSZbp1l9/dt8H3jD9Ob+PuvisbrB259kxiYAPJ3untlWUl+Sz3fs1AbQJWdUrsmyRn5S9hQR569rj54Ad//tTIdC+eXmDwSHs4Msk9bfGbNVuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7YxT9Kl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so261292066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721451188; x=1722055988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HvZkcpZdJwtVEMfsUyDpdFr/ZrEH8j2lB/wRls5Y1k=;
        b=u7YxT9Klbw+icASOWZv8ZNWQevshd3iA5p1P0l3sOZFgV411kZMvrju/cr+aedMPND
         3M3mO1VebZXfzItH3U/QD2NMms72Z9CUNfGhWuEx6MTqkR2MpGhNj7h5eHIeLCrw3seP
         AIFv1K1mhORJ4hgLiTGTI9/PGTfvRrlIG7RktKx9cjUF5hI3r2NaImdI+ezBxpYFVKcf
         wf4oOjIFiXpPtYC9302YVTylgjL1tIZEyHc+vJtVGA8vN1+nFGGNfc8Pv9oGWtl1Eog+
         JUfML3JCbxnwg3nbTw9ZSQkNRCX6psUgbqWlGqlAPFnYgcRODA9IOQT1lBzeHD8QtClU
         tR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721451188; x=1722055988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HvZkcpZdJwtVEMfsUyDpdFr/ZrEH8j2lB/wRls5Y1k=;
        b=Ej45QUtDg8sy7DpbxFaHIz6At0Bzf9HfmE0KWOE3+j+GLWkthcbD13cVsgf6Wt73kZ
         7krPL/2oaGONb5sza1tU9Y00FCTnuvr3eWjPn65X75/ppHFs4TUjz5ZlvlpTN5FfbXYt
         54A0BOcLWP2BvFKlQk7UKH37fqZgiNRxQBTuPRw7TeFy1M9eGqTDVe9vKSnvj6HH1IM+
         0CtaJ+8p6ry8CmOSSAR860Yxvuc9SVFux3Da2pESBmIjDU0YGXVbfqYxEZlktPmuO1Aj
         OYx3qD5Lkht8B3BCGPRgmJbLy8ep51CD5gE5uRqlU6680NJgKyEE8UoMwJzML3doKQR+
         aYGA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcnnoOFLz33Jnu/ca9fv9rL7Z1DaEas3uxVTdHSQYf7pYF9OOklS4aRO/dt8HK5mFVREesCJY1xdv05BVegaz0ZpN+w8P+eIqSAgc
X-Gm-Message-State: AOJu0Yy7/rZBP4iFsuc3hKKIYSyT1yjynyUVrcuYP7Ug/+u+Y69Sm91o
	zTJZ5U1WTBQz2ogHznkj+vN8fU1HrBi7qitymqkL8FXI+jyxhFqVlfuHkK7FX1lBbaG1b8aW7a0
	FY5s/oZoDCQvKeswdg6dQ4t9hZGViKU4Lj9ug
X-Google-Smtp-Source: AGHT+IEBtcKhMX4a7FkKEgtIIzfnWRLuBADucgwX1FvHsdXKYU63mXZRF70j5SRBDAypHp4vYIKH2WsFbbU0fgz8G24=
X-Received: by 2002:a17:907:94c9:b0:a7a:3904:f45 with SMTP id
 a640c23a62f3a-a7a4bf39545mr26767166b.8.1721451187421; Fri, 19 Jul 2024
 21:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
In-Reply-To: <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jul 2024 21:52:31 -0700
Message-ID: <CAJD7tkaypFa3Nk0jh_ZYJX8YB0i7h9VY2YFXMg7GKzSS+f8H5g@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > >
> > >
> > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > Hi Jesper,
> > > >
> > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrot=
e:
> > > > >
> > > > [...]
> > > > >
> > > > >
> > > > > Looking at the production numbers for the time the lock is held f=
or level 0:
> > > > >
> > > > > @locked_time_level[0]:
> > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
     |
> > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                              =
     |
> > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                               =
     |
> > > > >
> > > >
> > > > Is it possible to get the above histogram for other levels as well?
> > >
> > > Data from other levels available in [1]:
> > >  [1]
> > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kern=
el.org/
> > >
> > > IMHO the data shows we will get most out of skipping level-0 root-cgr=
oup
> > > flushes.
> > >
> >
> > Thanks a lot of the data. Are all or most of these locked_time_level[0]
> > from kswapds? This just motivates me to strongly push the ratelimited
> > flush patch of mine (which would be orthogonal to your patch series).
>
> Jesper and I were discussing a better ratelimiting approach, whether
> it's measuring the time since the last flush, or only skipping if we
> have a lot of flushes in a specific time frame (using __ratelimit()).
> I believe this would be better than the current memcg ratelimiting
> approach, and we can remove the latter.
>
> WDYT?

Forgot to link this:
https://lore.kernel.org/lkml/CAJD7tkZ5nxoa7aCpAix1bYOoYiLVfn+aNkq7jmRAZqsxr=
uHYLw@mail.gmail.com/

>
> >
> > Shakeel

