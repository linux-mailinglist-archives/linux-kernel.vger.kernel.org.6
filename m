Return-Path: <linux-kernel+bounces-535681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA0DA475E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5B188CB80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FF21B9DF;
	Thu, 27 Feb 2025 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5E79zdB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30411DDD1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637309; cv=none; b=pY7Nltb4I/yUUomhVRTzPsf0pDypaf+rRSz8RDLQqyHCz1tJPgnJAAAn3wSP4IgUHba1kMpwyGbQvZrJW2wnE9/I06X6cg92Rg36PFYHdQUF7MibhbiHwwtha/0R8GvXyTgPwRcw1iQBplfu1FZcfUWAxNixtkyn8hvUEiueAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637309; c=relaxed/simple;
	bh=9BQwvYLFuyKz8+vOPc/7vB9NDt1wrVlSjQz/uL+F0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZC7lTS+lhhUom4JIyyix9/+0DHgKmWI9g+dGPFwVPYqCLMI61MxZ5jMFAF63wZll1MkeNzyxzWk07Bwx1kDQOPHB1I36jNRPgT4FrGrb6p/XVfCqN/BYqmoQSilCtwEwbC6KffXApKqmd+LDa6acP+BjYXFNlQbkjmGtRLFEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5E79zdB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212222d4cdso91205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740637307; x=1741242107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLGPv8wfagepaDcd3kRNoXQJFGOdNe+csTfwazr/hns=;
        b=C5E79zdBts/WekRaOqTBW4NUd7jNOx26K33t+64WyuwT5g0zYwEiNR4DqGHuqZ/ZLj
         1kY8Jxtf9jBOp2c/SNYSSXI4gbHj++an0Yey9cDM5kvtwMD4FTn5EDJcd3UwLbkUw6p2
         rk+RA/KjjppJ7slmUr6F9vj+FjBLCviuqdr7rrGwrZXKPJ6pRzq90fKCErrgV9oGZrta
         teNty+Mw2iXcuNeiIMoxuNwFrj9KW1Bs+HM+sCDQmD6FbYWLWpi2TkcMGz3fgrTyexa1
         5bphDqUWu16jV3EGpYRFluLfVbOuRDUdV464diDhiSfQIgcUpdZ4Yk7A42tOPPct9GUG
         A6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740637307; x=1741242107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLGPv8wfagepaDcd3kRNoXQJFGOdNe+csTfwazr/hns=;
        b=glflwsZygg3tsQpREPXWq0hSqvXmTUcjo2hxyQVHr5WhCNC4kvRlGME0e9JoWoSLVX
         Ai55ULkweXTbXei3nY8HVTO8h0y0HjxdTtn2iWryvLK8QIqUsHImyUVQip8RRQ/sHRFK
         tn9Cj0SEzjdlgPgFsmqmKjKEk2gkb7JImnP57/bS/C3H7QT22e+8hsFS0l8vLogxHEyC
         DS3GCP9opWWavLxibDNrs1jVkJZStNsMt41HWUAoTgFiOREcfnri0ufuvtR25Ezgb+sx
         Rxj6xzIldEUgMJLBzQ/eoK1j61eu/OUryR2Wh5U84qI8Xt281VMViDb5GmTtnZ37FqW+
         eL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFPQ0BqS/KqKwPD4ePZukjuYcC6CfZG3Uf6FyfBQvZbWLf4q+SWRwpPfL22bsiDHvKjlF3cPCAF9JVwDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzds9bgz26C8+L5avS42Lpg+7hioKtShASOhRe9ZbkhhPpUyMgq
	SX9FTBFhX0fUO5QdDX62N8ikI7NJyjYjWOkJSs4Hf61GNmIHBWDA0hYoJGLdGXD/g0+mo+vhwMp
	5MI0pbSYv4VH9VWaAy5eeMPxlzVVoxhZ1Tipz
X-Gm-Gg: ASbGncuIBUzEjkKAoDpwKvxMCG8RwTVnvkXkqbHB2mMIHlWadQR4Z90gveaKi39zfC+
	ZPjcuBzYrrJWpptB0Ko+QqE+jcvMk093hqM9OJwHjqdZ5ZSyVCNfLts1y0XR+1fnp8F9PIiEgsQ
	EbmQ7sUJ8d
X-Google-Smtp-Source: AGHT+IFEuuEK6gaJuEGoSW8v3ux9ytfx/BKpe7Ddlphni4oexNX3FSPoLq0aEXkLj+RhJyqZhVf2g6IeAdF1OYoSh3c=
X-Received: by 2002:a17:902:f802:b0:215:8232:5596 with SMTP id
 d9443c01a7336-2234d5c9a54mr1849385ad.16.1740637306890; Wed, 26 Feb 2025
 22:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-11-irogers@google.com>
 <CAH0uvoj=PJMbOR_iQDFxRsGN+Q04tkkHdAceReHoZANOtv3uCA@mail.gmail.com>
In-Reply-To: <CAH0uvoj=PJMbOR_iQDFxRsGN+Q04tkkHdAceReHoZANOtv3uCA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 22:21:35 -0800
X-Gm-Features: AQ5f1Jq9EUr_I848tMwfXYm17qUq1MvC7vt3jNKL1cfdGcj5Bzyn94grIV-BDHM
Message-ID: <CAP-5=fXpfBJCENkHGd=mDKCBOhCmVr0ieF5-MvUbbV03DSA_hg@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] perf python: Add evlist.config to set up record options
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:46=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add access to evlist__config that is used to configure an evlist with
> > record options.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
>
> <SNIP>
>
> > +               .user_interval       =3D ULLONG_MAX,
> > +               .freq                =3D 4000,
> > +               .target              =3D {
> > +                       .uses_mmap   =3D true,
> > +                       .default_per_cpu =3D true,
> > +               },
> > +               .nr_threads_synthesize =3D 1,
> > +               .ctl_fd              =3D -1,
> > +               .ctl_fd_ack          =3D -1,
> > +                       .no_buffering =3D true,
> > +                       .no_inherit =3D true,
>
> Are these indentations intentional?

Nope, not sure what happened. I'll fix it in v2.

Thanks and thanks for the tags!
Ian

>
> Thanks,
> Howard

