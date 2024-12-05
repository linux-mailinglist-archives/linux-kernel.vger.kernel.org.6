Return-Path: <linux-kernel+bounces-432609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922E9E4DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF41B1880462
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596B194AE2;
	Thu,  5 Dec 2024 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwi5qAgY"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC8188733
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380443; cv=none; b=Z1PjbUu2MYrbrgSsJkkUr/SbJsv/lgX2VcjQQCMxlDkF3tM4E/xfGNxub0P/sc+hkAIvEkm749wFllNjJSAQ7l0RVbYP0mxzDaZL/jqlUuwdt8UluGWA35UDJjDgWdFtZH/FFkorzClQC1lF3KTLMIal8Mx39RWeD/bB0e87gXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380443; c=relaxed/simple;
	bh=VYQxyC/l3SIBJTvrSVqsCeLz+pAkgBcm1YklVVmfRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7EgIbBMA6NhJluT0TeJYG5wIacZECJHkK7WovufWTaId8ixso1+ze47HPnRZ0iUPtVllLOrnoIYVc9piiH+RY7e9Pcq1wcMFqDEvN9loT69FxcwzLtjxXnqrDCKLBIIv3m1PuVifnPFpP/R0TKiXIJvJlcpFxSReMEY+QVE/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwi5qAgY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7bc2d7608so62215ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733380441; x=1733985241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ+PTS/O30h8AWJWzVBtOJLnncwS4BzOGPDsCRKaXKE=;
        b=Qwi5qAgYbCKV2k94FgZA32azw+Ej7LqLhXCuCltEE9l0YTNtedEWJ22Wn0vWffSZZK
         b7DqJg69VjT0r7sWS3wpDb5ZFyRe20TQGZh+LazyCEjh+xAA3/XfKtx44bLM5qRbNSvT
         nmB/K5+a++W+ziSzLEMwEI/W5jyVY3XO+3gNgf9plLGfDfnHoiPvLbataMI6JnPKnms/
         0TUkDPuWGfOiI4PoX2arpBz7ZkemPsP0qAIEuVhl2Jgmpg+z8Zp1EyGI4BI5X1DidzUK
         4SiZFVbuuWB+/GHOqc6fUhw3YZKC7frvqIki49XQVU29Azjs/4TPrIZlKUhW/HGgm1IJ
         9s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733380441; x=1733985241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ+PTS/O30h8AWJWzVBtOJLnncwS4BzOGPDsCRKaXKE=;
        b=C/nKimaah0HpesDjXIGm7E4sg9JvcqGgbzd06h0vbb/zaTAXoC5DUCW3L6yFfz0SNT
         J/N1XK0hPcUqpwHwcbTae2TVrNx/M7W1NnvmwmDinMA6b3zppONH6yGQmoRCO4qZn5vt
         GfO7QbiUyrV83npI+CCYoNzDxguAFe/ujoHRHyfHWQGvskbgUCcr2zo8A1jzU6jd2i3W
         yi5tk4rHNXiu0cg8h7q1BGtk07XY2+J99W+LMtaOjE/l2yCC2vRXsRUo8Wlrfpruuum3
         iZ0JlSdJwVF2AGpAw0YpNPCgO/n+hPJInnEfZvQDrLI9hWcxLoeLHIQc3+kUYZExRYa8
         Dq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt2gK3MOzFGgFQtVd7TI/Pfjnqsf+cbKr37hbsl6g8++Rbj4qL/2UGN1tZIQUGyskhAK+dkXsdFdJ0z68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgpEKo5yP+GiwOAuX3LY2+6KVYioduYBREBfZ+W8s8pJDDnxX
	+ukUaI6ksMTHRBfEOrk3sowg4TC/81AkjeW7+pKIvjy9wlEC31MRulP3H2Dk8Mqs4Bth8zvVaV9
	Tf7Li28a5EPwq4lY9ttsoBLjj8FvIMERNvoiV
X-Gm-Gg: ASbGncuMAjra4DrgxrrNhT6o+lBpU0jRacfdNFCggfQm0kNJ8gw2RKVbUpRymOUS3H5
	ACApLRD566drh8BH5oSsDiNw3r0C7//uh
X-Google-Smtp-Source: AGHT+IEgHHfxuE1aJp6TLehuMD4UwVg+/zaAmQLSfttijsmXQLGtoBotHEy8B0DJzdNyFucHeZ8dje/BN3+W1K5iZGg=
X-Received: by 2002:a05:6e02:3486:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3a8083bfa97mr2293065ab.10.1733380440495; Wed, 04 Dec 2024
 22:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205022305.158202-1-irogers@google.com> <Z1E-WHWSPAezVF4f@google.com>
In-Reply-To: <Z1E-WHWSPAezVF4f@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 22:33:49 -0800
Message-ID: <CAP-5=fVPw5wJtVR0fxU-7drXg34vNrBsEzurfcLLvC+wFPMAAg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> > The refactoring of tool PMU events to have a PMU then adding the expr
> > literals to the tool PMU made it so that the literal system_tsc_freq
> > was only supported on x86. Update the test expectations to match -
> > namely the parsing is x86 specific and only yields a non-zero value on
> > Intel.
> >
> > Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions a=
nd json descriptions")
> > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1=
-atrajeev@linux.vnet.ibm.com/
> > Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> It failed on my VM.
>
>   root@arm64-vm:~/build# ./perf test -v 7
>   --- start ---
>   test child forked, pid 2096
>   Using CPUID 0x00000000000f0510
>   division by zero
>   syntax error
>   Unrecognized literal '#system_tsc_freq'FAILED tests/expr.c:253 #system_=
tsc_freq =3D=3D 0
>   ---- end(-1) ----
>     7: Simple expression parser                                        : =
FAILED!

I'll need to check this. The test is looking for parsing failures, so
it's confusing to me expr__parse is returning 0. I was testing on x86
but disabling the literal in the tool PMU.

> > ---
> >  tools/perf/tests/expr.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 41ff1affdfcd..726cf8d4da28 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -75,14 +75,12 @@ static int test__expr(struct test_suite *t __maybe_=
unused, int subtest __maybe_u
> >       double val, num_cpus_online, num_cpus, num_cores, num_dies, num_p=
ackages;
> >       int ret;
> >       struct expr_parse_ctx *ctx;
> > -     bool is_intel =3D false;
> >       char strcmp_cpuid_buf[256];
> >       struct perf_cpu cpu =3D {-1};
> >       char *cpuid =3D get_cpuid_allow_env_override(cpu);
> >       char *escaped_cpuid1, *escaped_cpuid2;
> >
> >       TEST_ASSERT_VAL("get_cpuid", cpuid);
> > -     is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
> >
> >       TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
> >
> > @@ -245,12 +243,19 @@ static int test__expr(struct test_suite *t __mayb=
e_unused, int subtest __maybe_u
> >       if (num_dies) // Some platforms do not have CPU die support, for =
example s390
> >               TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies =
>=3D num_packages);
> >
> > -     TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#syst=
em_tsc_freq") =3D=3D 0);
> > -     if (is_intel)
> > -             TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> > -     else
> > -             TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(v=
al) =3D=3D FP_ZERO);
> >
> > +     if (expr__parse(&val, ctx, "#system_tsc_freq") =3D=3D 0) {
> > +             bool is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
> > +
> > +             if (is_intel)
> > +                     TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>
> Also Sasha reported that some (Intel?) guest machine doesn't have TSC
> frequency.

I think, unfortunately, this is working as intended. Intel metrics use
#system_tsc_freq in metrics for most models:
```
$ grep -ril system_tsc_freq tools/perf/pmu-events/arch/x86/
tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
```
The code to generate the TSC frequency uses the CPUID leaf
information, but this can be disabled by the host operating system for
guest operating systems. The fallback logic using `/proc/cpuinfo` is
intended for older models and it appears the more recent formatting
won't be parse-able by perf. The host has also likely disabled the
information if the CPUID leaf is hidden. So the test is correctly
failing because metrics using #system_tsc_freq would be broken inside
the guest OS. Kan was involved in the conversation when the literal
was added and this was the best we could do.

Thanks,
Ian

> > +             else
> > +                     TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpcl=
assify(val) =3D=3D FP_ZERO);
> > +     } else {
> > +#if defined(__i386__) || defined(__x86_64__)
> > +             TEST_ASSERT_VAL("#system_tsc_freq unsupported", 0);
> > +#endif
> > +     }
> >       /*
> >        * Source count returns the number of events aggregating in a lea=
der
> >        * event including the leader. Check parsing yields an id.
> > --
> > 2.47.0.338.g60cca15819-goog
> >

