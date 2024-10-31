Return-Path: <linux-kernel+bounces-391294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF29B84D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144D8B25E84
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A21CCEF1;
	Thu, 31 Oct 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8UHixsH"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531201CC8B3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408443; cv=none; b=lEISzyvFe7Tkupge33/08KV5M8jcf9S7DwE++j//KZE5MyVoRQ7mSdHNpCp4O+n/2Ofa6M0JOmB6KIuKa6BktyznAA80Fi4AuYqHXUezVfthgaLueTawd624ZF+kgD4z/bR8zewq4R3OtitwRc9jRFFm3UK2DTfetaL24op0Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408443; c=relaxed/simple;
	bh=yrh0IbJWmE/SDvjrn89FK0yLCRVdpcCFuJ7Cz4CbP/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXB91GmmJtYk5D4jUp0jJosucLF3Eaa099VQI2dtuK50EPrGg3OccXgG/V+K7r/hmkybB/EZtSPnsqQbegIxzAa65EHomCiKE2I9Ms05ZWuQGdimASomn1wBdI4zuGeYE4nsZDJTBUad0tNNoC10URi8IcBJeqE8l6hLXdGCIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8UHixsH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so1060865a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730408437; x=1731013237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkq3bj3+pAy/gZDSqj43W1LapD3B4u639cQdLu4St8=;
        b=I8UHixsH+byPFarayGP2H4wUlMhVengvMPXnW+qv4n4RCotcbnJf0rfU7tXV+iABvU
         EyUigyJntROwR1g/g229PCVziznmjsxKoAlJQJKC9wRMrkc1sQ+ovjGIJXWr0bYScuvd
         ImMMuXoP1wuT+DTXpBXCrDAcu7CXC5bZzklInKM4J8Ow9TmQc98K7iHH9xABK3zWqRLl
         PhF7xN7fy6VEJ18t81A0OIKdG4g78feZ8VZNpyiQzdRF6zqimBGG72zOluoD/+YGkusJ
         9+qh5dnd1jENJviWBVrl1YkfiFoqVC3CPwk0Gak4Ehsy4i2pdsRuJqKq0duE36S1+sXO
         qGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408437; x=1731013237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSkq3bj3+pAy/gZDSqj43W1LapD3B4u639cQdLu4St8=;
        b=pc93fYWwluX63xG2Lvjp1kCTJ+1Yu2iDCSHWtVtyyvogQBwtCEQ1JT+Acu9ffKuY3t
         dfxACWsM3HIH/i8Nd66i0kuZfDssM0Ms9ONDWRcYBu/kw2VU7Xp7pvdyyE/UIG1SVA2F
         xPWXWNsdtR60tstSEsknJpVd53oqdapk0wuwnUo4ORoHuzZ9Sg2GSaX8nIvWRllTQgza
         5e80MQuQ2xdv8igJ0UZsA7J+SGcSjrl5Oiv6J7Nm2aQGp+RhF1WN5WYPH9YqNDz7IYFm
         iDqe/H2cR8MEdiVmXxHASVY5vdeXeoKumXiAHWLKpiuuQS2DSGFLPI9MAx4sH0JPqPuq
         Hgag==
X-Forwarded-Encrypted: i=1; AJvYcCXg2b7tObqeDrxCKaR4mtnxDbJVUNZMmXkt2z8OXhERSdPdz+dBBy2vpiJMRSuAK4cVf6Go5/6cRzVsjs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnAKxr9mlBca5XGV02fSnVg2zDDTVcH0Kr66HtLOAkFj2OZOJX
	SEhV3UeiSJNHM2BYi+970FywYPf6itEfXDzUE6YMXEiYsHvXzBFwng1ybm6RPRdCpDCgNbB7ip3
	0mjGXpoqWp9Bx68qO006ei5TDaP/uM3vjhLcp
X-Google-Smtp-Source: AGHT+IEL8+W+Z1C0xOOPCRSi2hJJhzO7Ib1+CZea32cQtShRUM9YeK8I+VSn4y3/d4BSuhAUjYNQGbBeHtZ0/M6cuPE=
X-Received: by 2002:a17:90b:5306:b0:2e2:c15f:1ffe with SMTP id
 98e67ed59e1d1-2e94bdf49acmr1819149a91.0.1730408437329; Thu, 31 Oct 2024
 14:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
In-Reply-To: <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 31 Oct 2024 14:00:24 -0700
Message-ID: <CAKwvOdmZYFhz0djG0_CgQ94BLaW8rUmdW+zaoZ0G+r76Esf2+Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Arthur Eubanks <aeubanks@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 29, 2024 at 10:53=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> >
> > On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
> > > > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > > > +                   struct sframe_fde *fde)
> > > > +{
> > > > +       struct sframe_fde __user *first, *last, *found =3D NULL;
> > > > +       u32 ip_off, func_off_low =3D 0, func_off_high =3D -1;
> > > > +
> > > > +       ip_off =3D ip - sec->sframe_addr;
> > >
> > > what if ip_off is larger than 4GB? ELF section can be bigger than 4GB=
, right?
> >
> > That's baked into sframe v2.
>
> I believe we do have large production binaries with more than 4GB of
> text, what are we going to do about them? It would be interesting to
> hear sframe people's opinion. Adding such a far-reaching new format in
> 2024 with these limitations is kind of sad. At the very least maybe we
> should allow some form of chaining sframe definitions to cover more
> than 4GB segments? Please CC relevant folks, I'm wondering what
> they're thinking about this.

FWIW, Google has such large binaries, too.
https://llvm.org/devmtg/2023-10/slides/quicktalks/Eubanks-CompromisesWithLa=
rgeX86-64Binaries.pdf
--=20
Thanks,
~Nick Desaulniers

