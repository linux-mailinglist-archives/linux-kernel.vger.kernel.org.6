Return-Path: <linux-kernel+bounces-257393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1A937962
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7B1F21C71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1931448E0;
	Fri, 19 Jul 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbNlRTfo"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEEB660;
	Fri, 19 Jul 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400918; cv=none; b=Z0gY/pwrBwI4lGLCcIe0r86JTOA1Y7nhZq8SbLEuNoKIuCM6dene+DD85PHBB9K7PpNEr+aNeujxLICAuVCPYz6NlFud5ub6jwT07xeOwKI6t7zqmCzIFOcJ7XjxQxLXiPCW48DAQ1r8w6LifVbCmciA4LgfyLJSKlBjfnUKSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400918; c=relaxed/simple;
	bh=UFJUDW/bCm3fdyE41VwDorx2jlc1r2meX5s1I0gY3A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqNKv4rIKEd+GmQAk7b6CpuRNIeBjMuq3FLpkbEVCvM68rGmdI7yweGLslo50GCyqWadZlX4WTQAKu1wtp8sW09DW/uYDQSgEu6MZG6zTXKwu03X3v+zsG97j1/0eLJ0SAjE0lrwaX6npuuumeoOjRdwEjlj055CaNBkp6pV3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbNlRTfo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05ecb3dbf6so2170536276.0;
        Fri, 19 Jul 2024 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721400915; x=1722005715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68yuc6NN728LxmvmV/7h6sci0WMOrieT8WjUycM9Czs=;
        b=gbNlRTfo/vf18yLCbpxnk8Dvm3ykmQnif106HyZwtuP05599vTGsKwpqfyQ/XpqVQd
         xqaQZIczknRm2qf5JGc76fMOdyRnsNZEUCLC5j5++pkGKkL+fb7RmHapXITjYr4wdDNK
         cvUHhsajaMq8HEHwlljn03IZg3x1u/d/0wFILUvMSnDoU15Ao08jHedChvV+w419/6RU
         tVNMYxiylkbjAWNRRMxJWBCMXXXBzWHXeBfud0usuKGQu5rp+hq9qWenZKuvAxxWx9IP
         X1Lnh2oYSkSXgfgotv9ceGipNgkNnk1sFu85SRw6X7Y5peo/xwbK4p5hccKXh9oPGa1/
         sr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721400915; x=1722005715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68yuc6NN728LxmvmV/7h6sci0WMOrieT8WjUycM9Czs=;
        b=Yl/KczsjV033D34eeEYyiOm7KdKEVEtYZlMbnKzZ5tc+vAf39X37E9mPYWrNOQUup3
         eOTrMH9brS37eDBjp2fDfIGYttfMOjjLhnlM7L27v5qOG1Pi5x5RfkiaoixapCnCxGnu
         wguAMWcwsPSpkxntoHo+xoh6xQ+FdWHeI9gHzRnqrCQPN8lICPE9X7WI4bOdkFw0iKnf
         KbCKdvKOHrJrODyQ03jL97w6EImBROl1WC5DOv1YZ4311/SdYqocBp5SPHTXjfzXCEHa
         /4D3YF/6mNyX6Frb5abOlhfVI5gRhwdZfBLLbPObfIq4n4qCjQ1aaCgahuIpvUIZBU5m
         XeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrN8Ijqwcv4ZNkHQPdHQ3GWuOpMmg/cxnOYYrwmMNAzg98+tDcAzEgiQKjzr0lKekBbRNkr6CcU/H2SQObFAu+YhlnGLKMurkyWzMyWYHfEDxKot4fI1AuzbU4GzR/cs00GAaDhat4
X-Gm-Message-State: AOJu0YzBzJFphYq1Nvd13hKMUROyQ8EAik1oWJ1ReVba17Zb0g1MLSE1
	Wz+wC7lgyt0vi0Jm5MT/euRb+YOUDG69xQ4jMkuTJLSUV5XPXHJKjg+EC4BH+HGUnGTCsJjUSuo
	sd0Xe796q1OZKI81TtYGEP7sGnsI=
X-Google-Smtp-Source: AGHT+IEdWHvsEjt7ddW74Wyq0ZsZOLuJ6QzPGM5zDey3dQwCJ7dfrCLIeBNvrcVeDz8GSRNcsMm0TcVaglXnrrbmG50=
X-Received: by 2002:a05:6902:18d3:b0:dff:2f2c:d6ad with SMTP id
 3f1490d57ef6-e05fec14a25mr8202645276.51.1721400915435; Fri, 19 Jul 2024
 07:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
 <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com>
 <CAKEwX=OPDkwnSno-8r9AsOpmzkZ90SzeX02xz0eDTqbL2_QL2g@mail.gmail.com> <CAJD7tkapE+qSmjFXnLBNamMvn3Lxbx=yvDF3gXW_qba45WU1tA@mail.gmail.com>
In-Reply-To: <CAJD7tkapE+qSmjFXnLBNamMvn3Lxbx=yvDF3gXW_qba45WU1tA@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 19 Jul 2024 23:55:04 +0900
Message-ID: <CAPpoddfu-FJ9XujHXnT-z+Js1on+z7P6GPgbWdGwhOhbrh4QSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you all for your reviews and comments.

2024=E5=B9=B47=E6=9C=8818=E6=97=A5(=E6=9C=A8) 3:05 Yosry Ahmed <yosryahmed@=
google.com>:
>
> On Wed, Jul 17, 2024 at 10:49=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > On Tue, Jul 16, 2024 at 7:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > [..]
> > > >
> > > > > My concern is that we are knowingly (and perhaps unnecessarily)
> > > > > creating an LRU inversion here - preferring swapping out the reje=
cted
> > > > > pages over the colder pages in the zswap pool. Shouldn't it be th=
e
> > > > > other way around? For instance, can we spiral into the following
> > > > > scenario:
> > > > >
> > > > > 1. zswap pool becomes full.
> > > > > 2. Memory is still tight, so anonymous memory will be reclaimed. =
zswap
> > > > > keeps rejecting incoming pages, and putting a hold on the global
> > > > > shrinker.
> > > > > 3. The pages that are swapped out are warmer than the ones stored=
 in
> > > > > the zswap pool, so they will be more likely to be swapped in (whi=
ch,
> > > > > IIUC, will also further delay the global shrinker).
> > > > >
> > > > > and the cycle keeps going on and on?
> > > >
> > > > I agree this does not follow LRU, but I think the LRU priority
> > > > inversion is unavoidable once the pool limit is hit.
> > > > The accept_thr_percent should be lowered to reduce the probability =
of
> > > > LRU inversion if it matters. (it is why I implemented proactive
> > > > shrinker.)
> > >
> > > Why?
> > >
> > > Let's take a step back. You are suggesting that we throttle zswap
> > > writeback to allow reclaim to swapout warmer pages to swap device. As
> > > Nhat said, we are proliferating LRU inversion instead of fixing it.
> > >
> > > I think I had a similar discussion with Johannes about this before,
> > > and we discussed that if zswap becomes full, we should instead
> > > throttle reclaim and allow zswap writeback to proceed (i.e. the
> > > opposite of what this series is doing). This would be similar to how
> > > we throttle reclaim today to wait for dirty pages to be written back.
> > >
> >
> > I completely agree with this analysis and proposal - it's somewhat
> > similar to what I have in mind, but more fleshed out :)
> >
> > > This should reduce/fix the LRU inversion instead of proliferating it,
> > > and it should reduce the total amout of IO as colder pages should go
> > > to disk while warmer pages go to zswap. I am wondering if we can reus=
e
> > > the reclaim_throttle() mechanism here.
> > >
> > > One concern I have is that we will also throttle file pages if we use
> > > reclaim_throttle(), since I don't see per-type throttling there. This
> > > could be fine, since we similarly throttle zswap reclaim if there are
> > > too many dirty file pages. I am not super familiar with reclaim
> > > throttling, so maybe I missed something obvious or there is a better
> > > way, but I believe that from a high level this should be the right wa=
y
> > > to go.
> >
> > I don't think we have any infrastructure for anon-only throttling in
> > vmscan logic, but it sounds trivial to implement if necessary :)
> >
> > >
> > > I actually think if we do this properly, and throttle reclaim when
> > > zswap becomes full, we may be able to drop the acceptance hysteresis
> > > and rely on the throttling mechanism to make sure we stop reclaim
> > > until we free up enough space in zswap to avoid consistently hitting
> > > the limit, but this could be a future extension.
> >
> > Agree - this hysteresis heuristics needs to die.
> >
> > IMHO, I think we should still have the proactive global shrinking
> > action that Takero is proposing in patch 3. The throttling is nice,
> > but it'd be even nicer if we can get ahead of that :)
>
> I have always thought that the shrinker should play this role in one
> way or another. Instead of an arbitrary watermark and asynchronous
> work, it incrementally pushes the zswap LRU toward disk as reclaim
> activity increases.
>
> Is the point behind proactive shrinking is to reduce the latency in
> the reclaim path?

For proactive shrinking, I thought the latency and throughput of
pageout should be prioritized, assuming that delaying the reclaim
progress by rejection or synchronous writeback is not always
acceptable. Similarly, patch 6 accepted breaking LRU priority to avoid
degrading pageout performance compared to zswap-disabled systems.

But It seems like zswap prefers the LRU heuristics and a larger pool.
The shrinker should writeback synchronously after the pool limit is
hit until the max pool size, and zswap should backpressure the
reclaim, right?  If so, my proposal is in the opposite direction. I
will submit patches 1 and 2 as v3.

