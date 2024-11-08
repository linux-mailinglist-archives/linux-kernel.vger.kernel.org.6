Return-Path: <linux-kernel+bounces-402042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A79C2297
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A74286DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E739199FBF;
	Fri,  8 Nov 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="eIhBgKF8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D70199949
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085167; cv=none; b=Hp0Z5AAMikC41xoUlrohudPU8xLzfJIaf9M0arj15u+WCdDoldMHIMEQ2yRwBNKjlwCfZ5AXyIux1Lypid9uz459bggSdX+GZl+2NxQw9DhmZeet14ZusDE4clipgPyWNR/t8va5VLJkfiIve2zY8lvn2hSNEfppumRWs9sGt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085167; c=relaxed/simple;
	bh=FxOwEU7IugwTghyB5emCVNuAEHOm3lbOrlBOS5dvYys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6Pt4F7EB3d1mFLJlpk8MGV1PF5M9h3AoNr7cVB+Tx8k63F8mMOsojBsp7v0VzKwelwvlek1Oeh+FkRNiyqWIUrZ5GrTkAKG5LGdaGMfWP2V74C9wM4DNC7R5X0TXXVSs9cgoiXzLe0Ti/sPcNRVvZJI068Dp7caCAdZZ0XC8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=eIhBgKF8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e44654ae3so327142966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731085163; x=1731689963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgetP3QbjEJJR1PWLs7vPWsjlPdnJzS53NVUV8Nth3g=;
        b=eIhBgKF8XCS/HR9YuKOb5LQbugUTAAybSlayyGXVqamITOjVd+UpM4NfnUfxviq84F
         0/yysm61YOFqKgv7O6o5FRBEZ6WCmPbBRCiD8BvNhiX2sd2hZip7Sz1bVC+WCfbmf0x8
         RddXfPMssrcVs18jX04Q6VI/OWN3HAjJaJWnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085163; x=1731689963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgetP3QbjEJJR1PWLs7vPWsjlPdnJzS53NVUV8Nth3g=;
        b=EGCRk3KXwA+UlciUulPPV/HdzT0SW/yNtilem18pZtx2ks6uo+SVDpo7eMsY1M2Z3T
         4ak8NZrllCYUPMNR6WJ8DX2jmvw7EAM/9SCDqwJOy6uGLqgNWw+eYk6WTl4MPmEx6DU9
         9PKm8fp6PIFj+gpV2d39lePe/e1VzcLxAZtF+IxErNVIPKY8lffj78So8hUTsvn88QCt
         hBzs2yHqk89tn+ICk0ykeNKZZV8Aj8wf01iXotA8d9ouh4gawvM3+YS5rOAoIal2pW2q
         J8Td3ZjFgV9LGyc0UplkpVW9FfKLSzIzTNcai5+s5949s858zy6KyqkVbtfpPPFGm5Fc
         qOKw==
X-Forwarded-Encrypted: i=1; AJvYcCXW5QnCSDELq32ra5Kx2eGMCNOTiqT7PE0ovya0dXReoAFf74RwbQLhwPHUoSssrc0IZ4/hpnaFrcjDkM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KUHLnif1/mdW4FVyG4gCwaT+j7VwwurNUzQR/T5mDftl+xt8
	kfPeTyDSfJ8nJc6oOgDJCbrk4KbyfbP9KroKQOV26ypH/UwdsWhXLG298GlluBIJVKUOhDWSsJX
	WSHO8VZDitdCYrj+INijsCbzY8IbGvUDa7AR8BA==
X-Google-Smtp-Source: AGHT+IFuqAeVM5yCf/A+bKTr2dEaXy0Y7y4jGGnzz6A7XL5usbkAt6whB8phaWDQTTN4T1mN8kkHJZVJG1d7rPmZbx4=
X-Received: by 2002:a17:907:6d07:b0:a99:caf5:c897 with SMTP id
 a640c23a62f3a-a9eefeecb18mr312195366b.20.1731085163199; Fri, 08 Nov 2024
 08:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com>
 <CAEmfU+ud__oG3NyQsVri1xztU-JhqA=WE-y=1STxqibejnuLYA@mail.gmail.com> <CAH0uvojrdxWSEd5r9J_8b39VV6qCTM3j0t1ZAsq8p596LTunqw@mail.gmail.com>
In-Reply-To: <CAH0uvojrdxWSEd5r9J_8b39VV6qCTM3j0t1ZAsq8p596LTunqw@mail.gmail.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 8 Nov 2024 08:59:11 -0800
Message-ID: <CAEmfU+vfYY8jVD-mLuRBVrk9M8OFCNiptXQjL1Rf+S5XtjiDVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:20=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Benjamin,
>
> On Thu, Nov 7, 2024 at 3:18=E2=80=AFPM Benjamin Peterson <benjamin@engflo=
w.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 2:07=E2=80=AFPM Howard Chu <howardchu95@gmail.co=
m> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Nov 6, 2024 at 3:46=E2=80=AFPM Benjamin Peterson <benjamin@en=
gflow.com> wrote:
> > > >
> > > > Add a test that checks that trace output is not lost to races. This=
 is
> > > > accomplished by tracing the exit_group syscall of "true" multiple t=
imes and
> > > > checking for correct output.
> > > >
> > > > Conveniently, this test also serves as a regression test for 5fb8e5=
6542a3 ("perf
> > > > trace: avoid garbage when not printing a trace event's arguments") =
because
> > > > exit_group triggers the previously buggy printing behavior.
> > > >
> > > > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > > > ---
> > > >  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++=
++++
> > > >  1 file changed, 31 insertions(+)
> > > >  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> > > >
> > > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf=
/tests/shell/trace_exit_race.sh
> > > > new file mode 100755
> > > > index 000000000000..8b70324bc5b4
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > > @@ -0,0 +1,31 @@
> > > > +#!/bin/sh
> > > > +# perf trace exit race
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +# Check that the last events of a perf trace'd subprocess are not
> > > > +# lost. Specifically, trace the exiting syscall of "true" 100 time=
s and ensure
> > > > +# the output contains 100 correct lines.
> > > > +
> > > > +# shellcheck source=3Dlib/probe.sh
> > > > +. "$(dirname $0)"/lib/probe.sh
> > > > +
> > > > +skip_if_no_perf_trace || exit 2
> > > > +
> > > > +trace_shutdown_race() {
> > > > +       for i in $(seq 100); do
> > > > +               perf trace -e syscalls:sys_enter_exit_group true 2>=
>$file
> > > > +       done
> > > > +       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_=
enter_exit_group\(\)$" $file) =3D "100" ]
> > >
> > > The test failed due to regex mismatched, I think because of this:
> > >
> > >      0.000 true/1526046 syscalls:sys_enter_exit_group( )
> > >      0.000 true/1526212 syscalls:sys_enter_exit_group( )
> > >      0.000 true/1526383 syscalls:sys_enter_exit_group(SSSSSSSSSSSSSSS=
S)
> > >
> > > Ironically the junk buffer problem you fixed last time, thanks for
> > > finding another printing problem in perf trace :), I'll figure out th=
e
> > > cause of this.
> >
> > Thanks, the problem is a parallel issue with trace__fprintf_sys_enter.
> > I will include a patch for the problem in my spin of this series.
> >
> > >
> > > Another thing is this test takes a long time to finish
> > >
> > > perf $ time ./perf test 109
> > > 109: perf trace exit race                                            =
: FAILED!
> > >
> > > real    0m38.762s
> > > user    0m15.090s
> > > sys     0m21.794s
> > >
> > > Is it really necessary to run it 100 times? To me it seems to be just
> > > a wrong handling logic of draining samples, will there be coincidence=
?
> >
> > Yes, it's racy. In my testing, sometimes the correct output would
> > appear. However, I will reduce the number of iterations to 10.
>
> Could you be a bit more specific about this race condition issue?

From the code, it's apparent that if the SIGCHLD from the traced
process is seen before the exit_group trace event, output will be
lost. If the signal is received after the trace event, the trace event
will be correctly printed.

> Could you please tell us how one might emulate and test the scenario
> you mentioned? I ran the command 1,000 times before and after applying
> the patch, and each time I got the expected output. Could you please
> provide more information about your use cases?

I can see it simply by running the unpatched perf few times in the
terminal, but it might be helpful for reproduction to create some
scheduling contention with stress.

