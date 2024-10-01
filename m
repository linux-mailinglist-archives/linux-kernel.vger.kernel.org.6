Return-Path: <linux-kernel+bounces-346735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13998C82B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8588B1F2449F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA31CF2A2;
	Tue,  1 Oct 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQXs5u3x"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715D1CEEA3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821325; cv=none; b=CgmQR9sO6vLgTsRH+z2LXwst+ryD9e9vcurhoRNlmxWVZgqoItWyiJmmfP7qNNk/tvJMSH4zNKOeDjKDhj5s5QS/QvMi5h74lLXf4GTqHl3qcHagyD16aPpOei+7RADkh0fqIIqqUKVxF96Gj9ph+KU+crLStHPxeMtrCbDAbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821325; c=relaxed/simple;
	bh=vNXb4IGihwAqX1o9IBiql9solp3cIqTIiKSsOYlP3Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aijIK8WMT2hzMsKeqWJMgLKI0BkPuL113U+FQh1gKRO8dHZ85MC3Qhe18Zc41xyD//3mosE3IuoB64NgXeWq3HktNPX6JWrQHaV9vMuDYq+e90zkDDhsbT5IS68d70Fq/YiBVdRjVekoKN5Qkeg6RvCb5S/vhE0lz+J7ZzVgddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQXs5u3x; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso95355ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727821323; x=1728426123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4+ASh2bBpgSyrs7dACBG8LCNRrYO9g9+SPjFNOkkdc=;
        b=vQXs5u3xicbf8ZizvgCu8+Tb00peuf12ofpeqWSojBmx7YOCfI59VNMKxP6PqZnuG+
         TsRAY5Pg34WxxsYb568Z/EonMFH6a5ID5WnCDb7aK5a4I2T13dn89Nb3GXcGYs7kHnmd
         fEsZFno34fU2wMV4A4AU8hiWHjjMM3+WWKtcVsliK6I2kYZQFRF4a5WvcDwCXpgaDNCn
         EBrcdv7Z1VG6xvHhAa39Sxae+BK91qTJZ9RfJ3Xe23G7/62hCEz0TBrbWT1Ogn75+sdV
         eAduye5avSwJgF0FVA0JHdTf0UfIgiSyTvSt3eDAfQmWBLvWEIxczRSQA9lXcLGsjDQ+
         dM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821323; x=1728426123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4+ASh2bBpgSyrs7dACBG8LCNRrYO9g9+SPjFNOkkdc=;
        b=KViSo7vauMow/65y5fuJWgTmSUqMkbJkKM5r+T6YzYWh2ZT6GJpYjstg7jiAIk6pjx
         /Gg0ElRaPX5ekmr+XZ7evWr76ql+Y2ErOrtsfkJHCpqhSLk6KZ0BrvMuacpjo2sfbcJE
         3zRxBinTji+WruGFkfzjtN9qC8cFdkYOQt/2CM+clX/U1830dMmocybV7gjQa6ASmeI3
         0YzkzQJ6SwHqEmcQoVvtpk5LKpE1ReB7kRBCYYkX54MkJcJLbvdCevZgn8FwxLQRyX9g
         k8JSWzzPMCxufRv3QAWxP0NyXZjX2l/vFEu3YV1LdjmzFYANM0zFQCPBrlvX7y+GE+VH
         SaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaPJjl8+85Zv4OMURPYB+OPQxOIjyfXGvonV0wcsxe1GeFsqX8JrlcLcsJdtD5iYzdPUETEeg9HM4qJK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Na4CWb0Dt8feTq4qg97cVhexg7zlMAC9QS2N7uim2JmEv7ZT
	rAO85d4ax9kiNIrfUJ3PRkVOewkcHAH0KnGIYFl/c+jvvbS6fMoL6ZZE5M4fvmoT3nAe14l1N/d
	6a9MCu9auBqpVLqGvM5Kby3qZEB4b3IM2TWQw
X-Google-Smtp-Source: AGHT+IEf0rABUKm/2lk21+DLqaLsqpDxzRqvExZUALvc93fqXjXm4NxNKqk5aw4zH0xPwAEZoe1/UzTBlG+B4nD1Z2A=
X-Received: by 2002:a05:6e02:20eb:b0:3a0:8cb6:3ad1 with SMTP id
 e9e14a558f8ab-3a3660c2106mr1278555ab.20.1727821323111; Tue, 01 Oct 2024
 15:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com> <ZvxrQsHML0A1kF1P@google.com>
In-Reply-To: <ZvxrQsHML0A1kF1P@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 15:21:50 -0700
Message-ID: <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The perf_event_open might fail due to various reasons, so blindly
> > > reducing precise_ip level might not be the best way to deal with it.
> > >
> > > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > > given precise level.  Let's try again with the correct error code.
> > >
> > > This caused a problem on AMD, as it stops on precise_ip of 2 for IBS =
but
> > > user events with exclude_kernel=3D1 cannot make progress.  Let's add =
the
> > > evsel__handle_error_quirks() to this case specially.  I plan to work =
on
> > > the kernel side to improve this situation but it'd still need some
> > > special handling for IBS.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(str=
uct evsel *evsel)
> > >         return false;
> > >  }
> > >
> > > +static bool evsel__handle_error_quirks(struct evsel *evsel, int erro=
r)
> > > +{
> > > +       /* AMD IBS doesn't support exclude_kernel, forward it to core=
 PMU */
> >
> > Should the quirk handling be specific to evsels with the IBS PMU given
> > the comment above? ie this is a PMU specific workaround rather than an
> > AMD specific workaround, however, the PMU only exists on AMD :-)
> >
> > > +       if (error =3D=3D -EINVAL && evsel->precise_max && evsel->core=
.attr.precise_ip &&
> > > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
> >
> > So here rather than x86__is_amd_cpu it would be
> > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
> > the logic into pmu.c.
>
> I guess the problem is that AMD driver does implicit forwarding to IBS
> if the legacy hardware events have precise_ip.  So it might have just
> core pmu (or no pmu) in the evsel.

I think the no PMU case should probably have a PMU possibly similar to
the tool PMU in:
https://lore.kernel.org/all/20240912190341.919229-1-irogers@google.com/
But that's not in place yet. You can always use
perf_pmus__scan_core(NULL) or
perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD core
PMU whereas the code above could fire for IBS or other PMUs.

Thanks,
Ian

> >
> > > +               evsel->core.attr.precise_ip =3D 0;
> > > +               pr_debug2_peo("removing precise_ip on AMD\n");
> > > +               display_attr(&evsel->core.attr);
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map =
*cpus,
> > >                 struct perf_thread_map *threads,
> > >                 int start_cpu_map_idx, int end_cpu_map_idx)
> > > @@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *evsel,=
 struct perf_cpu_map *cpus,
> > >         return 0;
> > >
> > >  try_fallback:
> > > -       if (evsel__precise_ip_fallback(evsel))
> > > -               goto retry_open;
> > > -
> > >         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus=
),
> > >                                          idx, threads, thread, err)) =
{
> > >                 /* We just removed 1 thread, so lower the upper nthre=
ads limit. */
> > > @@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *evse=
l, struct perf_cpu_map *cpus,
> > >         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rlimit=
))
> > >                 goto retry_open;
> > >
> > > -       if (err !=3D -EINVAL || idx > 0 || thread > 0)
> > > -               goto out_close;
> > > +       if (err =3D=3D -EOPNOTSUPP && evsel__precise_ip_fallback(evse=
l))
> > > +               goto retry_open;
> > >
> > > -       if (evsel__detect_missing_features(evsel))
> > > +       if (err =3D=3D -EINVAL && evsel__detect_missing_features(evse=
l))
> > >                 goto fallback_missing_features;
> > > +
> > > +       if (evsel__handle_error_quirks(evsel, err))
> > > +               goto retry_open;
> > > +
> > >  out_close:
> > >         if (err)
> > >                 threads->err_thread =3D thread;
> > > --
> > > 2.46.1.824.gd892dcdcdd-goog
> > >

