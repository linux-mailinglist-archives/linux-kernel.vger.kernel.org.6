Return-Path: <linux-kernel+bounces-409761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DAF9C910E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39590283509
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279618E029;
	Thu, 14 Nov 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="VG0q+I4T"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E01885A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606312; cv=none; b=FkdbvIjS6XtQ3wKoEyKhkw7spvnAo4bE+trzhECfDf2rv3PylreM/BiAvHaDVEsT9394mY0GWsiBXN3i4uCZsNUXN0QbX/HtePxHABc3iIiyBx9XY0Ct8+mLDAnb+CcmJf67QELlOdbyf4+qlIzIwkv7Bk4+MGYG+5JHwD6gOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606312; c=relaxed/simple;
	bh=Sl9e7dnmp+ogAXWAka4td7K0vZYhwZ2TL/i9U9/X5ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUp20fIkuwW9rSZFo/vgLmvqQ4gjhfFKLNUA5R7XUSqZWeKZ3NQMN1tHBJNJ/v2lwY6eKsl0SyCm8Nqx30XM2CGjn92s5xt9e/R/Rm5VU/mblqm9nLVCncy8oDHZv4YFnHBp3fIDL3B/6jYjLQSvWcqN+ZjrS7SnDCoTiIq7Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=VG0q+I4T; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso1183778a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731606308; x=1732211108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI6ZuuK/6TJl+VV2bK0mu6YHhhpmuXGN30fDCY3ZSyc=;
        b=VG0q+I4Tw+SdlenOoLJ7DQYWUCo3X00Gr6XZo8oDycTKB4C1ax/Uex4voYyiu1Qd2M
         F75S2vv1MYC64iq49vVVNo/Mcs++Ou+bE6vMa5IKN1a1RVnQU2SZq5SSHh5UlI8V2uP0
         BXYLB8ueEG6nSs8uWjchr+WIZshXwbU6AOCDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606308; x=1732211108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI6ZuuK/6TJl+VV2bK0mu6YHhhpmuXGN30fDCY3ZSyc=;
        b=h6M7DFrxX33lFACQvRHqPPD+5YMznu4kLB2QH+73CHsFmBAiPiI5t7Ns7grKp9Nbog
         0Ue35dHIAkMq6VJ2mCy/BGTqgXM3ywfeRsbfNzH6H0R6JLEDP+Rrh322kzkiM1kUW2hp
         NILiTA+lSLjAAqOq6yoYk3FNW4pBkpfHsBMuIWmt8tgwj+xpE4XBFkVSKIFZwo3DrYOJ
         O1D3PCiiSerS/ap6MO3h82Ygb89eFosf5vadhzdiJv6wgmc0XDRkWsu9/gaZMX2sXpy6
         cx13IrbrVWh3C0GfdBj2TWkwP27iYfiRsA+1tqXycDxhIXOfrVokZEZqHegf61DEjXXt
         yF9g==
X-Forwarded-Encrypted: i=1; AJvYcCULhQczOL0Xfm+g1403l+qE1HDGFJ8nCZJWv0FKRil2M/E2w4zjEaclsuJVRbkOfkbBeOVEF6kGlO5dR6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2I4AKOq/5yWy2Af57u9uWArUvIkuTPQBOl8ESiEVyWCEJktEc
	Ug1x0aoFucat6C8a93dHCMBPa7nlIHxwNwNUhDYayJiQKi5+Aplbp7S/1jCnddxspq7/nbJyHrL
	K85q5fCPDdUtnS5k2vTRjRd/lEe9fhMja/PqE2woyFoQuEzA+
X-Google-Smtp-Source: AGHT+IF95UlcOiaY9AaQ+hLN5jVZWLkGGnFhdEzbCjn4pXxrEWG4Lk93rIU+nSxThTx6gQPa60RekiCJp9UyBEbDNlY=
X-Received: by 2002:a17:907:9703:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-aa1f7e2c2aemr784530466b.0.1731606307332; Thu, 14 Nov 2024
 09:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <ZzY1bPtoyRH-nRIV@x1> <ZzY20vZluj44w1Gt@x1>
In-Reply-To: <ZzY20vZluj44w1Gt@x1>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Thu, 14 Nov 2024 09:44:56 -0800
Message-ID: <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:43=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 14, 2024 at 02:37:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Nov 06, 2024 at 11:45:18PM +0000, Benjamin Peterson wrote:
> > > Add a test that checks that trace output is not lost to races. This i=
s
> > > accomplished by tracing the exit_group syscall of "true" multiple tim=
es and
> > > checking for correct output.
> > >
> > > Conveniently, this test also serves as a regression test for 5fb8e565=
42a3 ("perf
> > > trace: avoid garbage when not printing a trace event's arguments") be=
cause
> > > exit_group triggers the previously buggy printing behavior.
> > >
> > > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > > ---
> > >  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++=
++
> > >  1 file changed, 31 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> > >
> > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/t=
ests/shell/trace_exit_race.sh
> > > new file mode 100755
> > > index 000000000000..8b70324bc5b4
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > @@ -0,0 +1,31 @@
> > > +#!/bin/sh
> > > +# perf trace exit race
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +# Check that the last events of a perf trace'd subprocess are not
> > > +# lost. Specifically, trace the exiting syscall of "true" 100 times =
and ensure
> > > +# the output contains 100 correct lines.
> > > +
> > > +# shellcheck source=3Dlib/probe.sh
> > > +. "$(dirname $0)"/lib/probe.sh
> > > +
> > > +skip_if_no_perf_trace || exit 2
> > > +
> > > +trace_shutdown_race() {
> > > +   for i in $(seq 100); do
> > > +           perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> > > +   done
> > > +   [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_=
exit_group\(\)$" $file) =3D "100" ]
> > > +}
> > > +
> > > +
> > > +file=3D$(mktemp /tmp/temporary_file.XXXXX)
> > > +
> > > +# Do not use whatever ~/.perfconfig file, it may change the output
> > > +# via trace.{show_timestamp,show_prefix,etc}
> > > +export PERF_CONFIG=3D/dev/null
> > > +
> > > +trace_shutdown_race
> > > +err=3D$?
> > > +rm -f ${file}
> > > +exit $err
> > > --
> >
> > Its failing with shellcheck, I'm trying to fix it:
> >
> >   CC      /tmp/build/perf-tools-next/builtin-trace.o
> >   TEST    /tmp/build/perf-tools-next/tests/shell/trace_exit_race.sh.she=
llcheck_log
> >
> > In tests/shell/trace_exit_race.sh line 15:
> >       for i in $(seq 100); do
> >         ^-^ SC2034 (warning): i appears unused. Verify use (or export i=
f used externally).
> >
> >
> > In tests/shell/trace_exit_race.sh line 18:
> >       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_=
exit_group\(\)$" $file) =3D "100" ]
> >           ^-- SC2046 (warning): Quote this to prevent word splitting.
> >
> > For more information:
> >   https://www.shellcheck.net/wiki/SC2034 -- i appears unused. Verify us=
e (or ...
> >   https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word =
splitt...
> > make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/tr=
ace_exit_race.sh.shellcheck_log] Error 1
> > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build=
:158: tests] Error 2
> > make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-i=
n.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
>
> I've read the links provided by ShellCheck and folded this to satisfy
> it, please consider installing ShellCheck, the perf build process will
> use it when avaiable.

Thank you.

>
> - Arnaldo
>
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests=
/shell/trace_exit_race.sh
> index 8b70324bc5b4fb4c..c37ed6bb9f7e8fab 100755
> --- a/tools/perf/tests/shell/trace_exit_race.sh
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -12,10 +12,10 @@
>  skip_if_no_perf_trace || exit 2
>
>  trace_shutdown_race() {
> -       for i in $(seq 100); do
> +       for _ in $(seq 100); do
>                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
>         done
> -       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_=
exit_group\(\)$" $file) =3D "100" ]
> +       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter=
_exit_group\(\)$' $file)" =3D "100" ]
>  }

This all looks okay.

