Return-Path: <linux-kernel+bounces-438747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B39EA510
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA581619A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF213D8B1;
	Tue, 10 Dec 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f29T40LX"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78617233159
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797475; cv=none; b=eADf4lsR2+drrqKt3EqpK1iNi+LUApG0ccvMC1MCgbUcWjRG/+X78i61YZyNm+pkOuspYdt2WtLnVEv1KP/JvoqVxR0mSHX1PnSrYhaeoc9W0/Grv9zA78CUguBbGeSGFE/1h3x4r3ZZKeed3QGcu0rV/AdhQQb13qO8Eh5NFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797475; c=relaxed/simple;
	bh=injzNcZBgJArZYT+6fm83qpC+YrYDAWr/bo/OWhvyko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf+XO5ARY/dgl19TOqhDOP4NKUpB5G/0qaNtLDrQOUsHW7CsL3OyAnJ1wfTAoTUz9bu2FzCk1nCQm5Tts5Jk0e2+UXNjELSpolu/XXpomZ/1L+Rzt7sftf0KxMgBDeFEZXKoO0MKQJc1+t1fF6Mvc4nnJHBkL2HmdSMJ3fX3gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f29T40LX; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso22955ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733797472; x=1734402272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkFkXtK1ob85Gpc/gCvXK5MVVI7soGwKsTu/K6lmE+U=;
        b=f29T40LXZiv24pT+yUccHPSJDrSL778eX6fuF8qVF974/zMi83DBR5tWl0c/nMtHFF
         xi2ziCo/G7qkWpNJnjrmlrThr6MuoVaKpiQ2lPRj/3CvRFOtBmMLWBwDKw7gD7+JxXQ4
         n7D+arbs7OpNsGSmsGjQnTM7lcqUCGQW86b3juOuVeA5pqoKA0ie1wKu06KEkS1tGLYY
         3D9pru0itBseDhJy9adFIFVxE2iUmacCJLqpuwm4i5wMhc40q/DmDNz2MyY0bctxny5x
         dLCKaslcbt9vxd8HZIGCIwC5rmEc16GHA6C6mW6v1uZOD9krPzk/7CWXL6AKOYQnGoaq
         B8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733797472; x=1734402272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkFkXtK1ob85Gpc/gCvXK5MVVI7soGwKsTu/K6lmE+U=;
        b=qA9LpJZnOVAs45t420+2Pn2bFCaINjOfTRiBH3X/4EtdY4x7z95gisEvDZaUMdVR72
         YgdEerPEa3qd8pYgsIz5rcr6aYgMj8w4ejDDJSUQZBEYkAQrfvbX4LvlZyPOt7zDoYxw
         FSvU6VoHkfGItM1z232vxfw3fXjpfBeshlZ9BzhdFcukkOBgSQWx5vkZrAaXV5+lncH3
         mNifo21AhNLf7zHkxzDGXEzu3Qkpq8kqqlYH8sB61rq4PEeTsg4icDWA4Wbakt0Gm6Fa
         P/cUdOm3/JD3w41hVhdrjBbku2yHeietgdpu9zwFz6K+4LCivRiMkfUTax0isUSD2j2Y
         z1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVjM1AAHa1O8AJvdRdxU3+I1WLuWGssx10y2mtTV+5rlFWkJOWKZnmZW+l+Wh67eRSb6Mj5XuDfX42uBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RiqmedoZFJAleSgmSG2/vFUyaWpmd8KufPX/NDcdE9kpJxdt
	zise7M7p3jlr6hkoSYKxx7ugwlE5WgVriXfkiy/KwAe6z3G2iSm3x+vdIAWVdx9YAVpiSqlImXH
	B9EP5R0mkwvFMTh3SNEZhM7+oPPN55jCfJxDh
X-Gm-Gg: ASbGncuzOcPanbKeIOLjnS2Xbe3SgexMVK0w6ocUNO96NRh6ej1pX8ht6x+dXWA9Jj2
	jsOBLD2/oCuLFuxRo4SZ7xc5c5R7RkW0JNEbN
X-Google-Smtp-Source: AGHT+IFRn1lel39bJxFKf168ISRGvZ6Hxnd4URuzDfxXkRDEKZ+YKw+zjBRcXYWO42fUfu9gFjfJMOf0bfdfD/qA5TA=
X-Received: by 2002:a05:6e02:3497:b0:3a7:9082:50f6 with SMTP id
 e9e14a558f8ab-3a9ddaafa52mr1722705ab.22.1733797472434; Mon, 09 Dec 2024
 18:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122043840.217453-1-howardchu95@gmail.com>
 <20241122043840.217453-2-howardchu95@gmail.com> <Z1eGw52LThYh1Gjx@google.com>
In-Reply-To: <Z1eGw52LThYh1Gjx@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 18:24:21 -0800
Message-ID: <CAP-5=fUm6kWmX3FzFYJ_xoBgfgs0zPigyMKLy7VrXvNt1sC+iQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] perf record --off-cpu: Add --off-cpu-thresh option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Howard,
>
> Sorry for the late review.
>
> On Thu, Nov 21, 2024 at 08:38:31PM -0800, Howard Chu wrote:
> > Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> > the unit is us (microsecond). Default value is 500,000us (500ms, 0.5s).
>
> I guess we mostly care about more than milli-seconds of off-cpu times.
> Can we change the unit to msec?

I wonder if there should be two values, one for the command line and
one in the code. I think microseconds make most sense in the code, 1ms
being roughly 1000 context switches. On the command line millisecond
would align with perf stat's -I option, and as you point out, users
aren't usually working at the granularity of a microsecond. Having the
code be microsecond oriented allows the option to have a more precise
command line option in the future, autotuning, etc.

Thanks,
Ian

> Also I think this commit can be moved to later in this series - like
> after implementing direct offcpu samples.  If I see the commit in
> history later, I'd think it works.  But it's not at this point.
>
> Otherwise, looks all good to me. :)
>
> Thanks,
> Namhyung
>
> >
> > Example:
> >
> >   perf record --off-cpu --off-cpu-thresh 400000
> >
> > The example above collects off-cpu samples whose off-cpu time is longer
> > than 400,000us
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  9 ++++++++
> >  tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
> >  tools/perf/util/off_cpu.h                |  1 +
> >  tools/perf/util/record.h                 |  1 +
> >  4 files changed, 37 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docu=
mentation/perf-record.txt
> > index 242223240a08..05c8977983de 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
> >       only, as of now.  So the applications built without the frame
> >       pointer might see bogus addresses.
> >
> > +     off-cpu profiling consists two types of samples: direct samples, =
which
> > +     share the same behavior as regular samples, and the accumulated
> > +     samples, stored in BPF stack trace map, presented after all the r=
egular
> > +     samples.
> > +
> > +--off-cpu-thresh::
> > +     Once a task's off-cpu time reaches this threshold, it generates a
> > +     direct off-cpu sample.
> > +
> >  --setup-filter=3D<action>::
> >       Prepare BPF filter to be used by regular users.  The action shoul=
d be
> >       either "pin" or "unpin".  The filter can be used after it's pinne=
d.
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index f83252472921..c069000efe5c 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct=
 option *opt,
> >       return ret;
> >  }
> >
> > +static int record__parse_off_cpu_thresh(const struct option *opt,
> > +                                     const char *str,
> > +                                     int unset __maybe_unused)
> > +{
> > +     struct record_opts *opts =3D opt->value;
> > +     char *endptr;
> > +     u64 off_cpu_thresh_us;
> > +
> > +     if (!str)
> > +             return -EINVAL;
> > +
> > +     off_cpu_thresh_us =3D strtoull(str, &endptr, 10);
> > +
> > +     /* threshold isn't string "0", yet strtoull() returns 0, parsing =
failed */
> > +     if (*endptr || (off_cpu_thresh_us =3D=3D 0 && strcmp(str, "0")))
> > +             return -EINVAL;
> > +     else
> > +             opts->off_cpu_thresh_us =3D off_cpu_thresh_us;
> > +
> > +     return 0;
> > +}
> > +
> >  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts =
__maybe_unused)
> >  {
> >  }
> > @@ -3342,6 +3364,7 @@ static struct record record =3D {
> >               .ctl_fd              =3D -1,
> >               .ctl_fd_ack          =3D -1,
> >               .synth               =3D PERF_SYNTH_ALL,
> > +             .off_cpu_thresh_us   =3D OFFCPU_THRESH,
> >       },
> >  };
> >
> > @@ -3564,6 +3587,9 @@ static struct option __record_options[] =3D {
> >       OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
> >       OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
> >                  "BPF filter action"),
> > +     OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> > +                  "Dump off-cpu samples if off-cpu time reaches this t=
hreshold. The unit is microsecond (default: 500000)",
> > +                  record__parse_off_cpu_thresh),
> >       OPT_END()
> >  };
> >
> > diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> > index 2dd67c60f211..c6edc0f7c40d 100644
> > --- a/tools/perf/util/off_cpu.h
> > +++ b/tools/perf/util/off_cpu.h
> > @@ -16,6 +16,7 @@ struct record_opts;
> >                             PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN =
| \
> >                             PERF_SAMPLE_CGROUP)
> >
> > +#define OFFCPU_THRESH 500000ull
> >
> >  #ifdef HAVE_BPF_SKEL
> >  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index a6566134e09e..2ca74add26c0 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -79,6 +79,7 @@ struct record_opts {
> >       int           synth;
> >       int           threads_spec;
> >       const char    *threads_user_spec;
> > +     u64           off_cpu_thresh_us;
> >  };
> >
> >  extern const char * const *record_usage;
> > --
> > 2.43.0
> >

