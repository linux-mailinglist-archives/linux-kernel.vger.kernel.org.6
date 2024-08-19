Return-Path: <linux-kernel+bounces-292771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2C957421
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990F51F2417A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43E1D54EA;
	Mon, 19 Aug 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEb37k3D"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C11891D2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094385; cv=none; b=AE8e4GjxSThS3HVFVWgVf3KiEwkxcydYmsDK8fai+AAlJ7nhW1UYN1nwMXjeAhTRtKr9pb1PRBaENB0eUKXWfsSeFcrGYD8t58UsuTV9wbliDKGfOqKprD4F7EhMNKtVO+Ky3UMbE/sAJzYFDY+qeDM5YObZIMKbnPaVYffCTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094385; c=relaxed/simple;
	bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT8kOs65dY1cwJDpm6Mf2cA5hmFvi6yNFQ5l3+IR6hwJpVYxjgSL4G0ztuxGrirwwq/wVkHnW1qMV8geQGIrO/FoB7LjPnko3MZenNjFQBvNPZgUu9iaA4PXQrfojJvik7IzQYY0cs2uReZQ23WXoxhxk7vN8NH1A0xLWKmjlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEb37k3D; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so6358291a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724094382; x=1724699182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
        b=dEb37k3DTKLhz8943FgPqhFCqn/inW5/lh4q2piW4ieU3PxNsum/pDuOBxLn6OsUM+
         eZSiU2IOIKdEbpRDk0L898hVGU9rNHKDwrni1G/vcuNyHD41NoOfFNOPO+mnsOi2i9lP
         3srNcKxgGG4TQq2xZbsfzegoMc2h5bEDj4HP6gqn1WbhlJ83+l202SJYRkvkfuKUzZtv
         hQezWimQM1NjAD9JlOk9yt306H0yKJLA5jPzAYAu/M3tQ5PIFHA8M41hSc5ehwsH4ZLF
         MwDbuuwIaZ+nycZRhY89voLmmibkNPf2gJxL36zcU7mVW+dh3JIpSlhBPBjsIOQBQeDX
         2fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094382; x=1724699182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VISjCPnbKrAiztzAFSiDft/7IotbQpEpNxABM+V65y4=;
        b=PIk9y61QhDSw6isMr2gDt1IYxmuxNUy4jYEJ9h4RuEXjh4t4a3OT7UIqnOPeV4cO3m
         yloa1hDFKPURfdSsEB562S5g8/8hHAHjAne1J961ljCdhVT4IVY37FI6nXdbEmiSsbeT
         jbOMSpZcNVbJPncF72daIsndXgfrgoPHbKjuE97O/mYU8LbAubnZIsBxJoirQgmF3JHY
         9q1nsAqWA5wVOB1BDVWe497UpcoCwsoYka9f8x9Vy2+G+nFJbp3eX4VJM8855qwS7K9g
         3x1gvcg2EBxqvSE+WOgf3JZh5V9KU7FTuAd5FN4R78YEUZtUXi/OX4Yr0303puqMY7Tg
         meOA==
X-Forwarded-Encrypted: i=1; AJvYcCVLzc4srU1W0/jNObHNZq4tm80PoNUzWOR9rLb/VdQqzu0QDu7UOk+t67oqhkPq9YDRqAkpkBERCy6dLuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqlz+93dsEGgQVpCwYOfXxeLK0j6A2hSZHo188O1J5WJaZmFK1
	RM7okpwHvdC4UjOs8qVCVxkNe8MmPRO2IkvvCAiBHoJWrDhyTLsvBkIIvP3+SH6c8T0R7QyCq1Q
	9jD31zJvDvfe1ChTfu4sJpZ46LYhcZe1MwloXRHWLT4NAqnsvVA==
X-Google-Smtp-Source: AGHT+IH0iRyJtUrU93XJ+DPiBi62y8rSBstCZOvrLtJz+l82/qtYFsRaQGGJ3beTy9fdroDR3Is5QPxMwnhk7Ke6ktU=
X-Received: by 2002:a17:907:3f0d:b0:a7d:c464:d5f3 with SMTP id
 a640c23a62f3a-a8643f7712amr60252866b.11.1724094381681; Mon, 19 Aug 2024
 12:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
 <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
 <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com> <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
In-Reply-To: <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 12:05:44 -0700
Message-ID: <CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Yuan <me@yhndnzj.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:32=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Aug 15, 2024 at 3:10=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Aug 15, 2024 at 3:08=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrot=
e:
> > >
> > > > > Yeah, I thought about the other way around and reached the same
> > > > > conclusion.
> > > > > And there's permission boundary in the mix too - if root disables=
 zswap
> > > > > writeback for its cgroup, the subcgroups, which could possibly be=
 owned
> > > > > by other users, should not be able to reenable this.
> > > >
> > > > Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> > > > doesn't affect our use case AFAICS, and the code looks solid to me,
> > > > so:
> > > >
> > > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > >
> > > But you'd still like an update to Documentation/admin-guide/cgroup-v2=
.rst?
> >
> >
> > Yeah I'd rather see a v2 with updated docs, and hopefully a selftest
> > if the existing tests problem is resolved.
>
> Ah yeah, I was thinking this could be done in a follow-up patch.
>
> But yes, please - documentation. Preferably everything together as v2.
>
> >
> > Also, do we want a Fixes tag and to backport this so that current
> > users get the new behavior ASAP?
>
> Hmm, I wonder if it's more confusing for users to change the behavior
> in older kernels.
>
> (OTOH, if this already is what people expect, then yeah it's a good
> idea to backport).

My rationale is that if people will inevitably get the behavior change
when they upgrade their kernel, I'd rather they get it sooner rather
than later, before more users start depending on the old behavior.

I am guessing there is a chance this is not what backports are meant
for. Andrew, any thoughts on this?

