Return-Path: <linux-kernel+bounces-404321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5D9C4265
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED601F24E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6A19F113;
	Mon, 11 Nov 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAS8TiFY"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF951448C1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341429; cv=none; b=LPfGTc9o9lHLMCK/oBFradX7b8Nb9Wmx5zQxCIdiJSmt/MQGa+VlOL5gtGM0B92nU+z9oWz7T4INvewmdMl58jrn0cYvXrCCCuGRYUe+XnqCA/tUIehk1K3DfnQguL6Y4IUJmQXgaN0NzP8ijircKdPgesCPkGtPGAmDuFUCx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341429; c=relaxed/simple;
	bh=e7iaHqt/EwDBLBLJCozYGUGnS0CDSgQ11Uen7CkIPr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEPRAIr93HWQTq28ECEyiy3o2S/QGb9CD+yhtz3dP0B/xtW5AAF+MfLtOSK8dtquPOTgFChfffUYJH4gk2lPDHKtB1yOQ+KWeijIyZo63/pA3pVbGOd6feDu9p8ANCN7UqVgYFH8oBu/6VVDlFnqP+vVduYrUQyWsp9h3oFIvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAS8TiFY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so510685ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731341427; x=1731946227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikffGFv9vfeGkXMvxoClTn0ciNkxNsHM/SDnKUO1+ao=;
        b=sAS8TiFYha92PbgsLvlEWnX5Gq7CwYM0HQAwSfUS8lAqWAePspfM52+jvLareXdeAX
         x9I7+PhJq/ZEeoDEl8Qf30Q74eYVv9DALDxtfim8uu4LhjSE2sGeEjsRw1iz4yrfOI9W
         +xlrBh+F9BkzqDVx8Cl7EzTBjoa3iz4DfxMApRoPt4U8EWW+LB/+CWC3mxFN72Vgbgat
         7MdktETnx+TgP8Gpla3um9QTOrIM8YBxVY9kezaQqore0qX7Nmo6N4eMI8s6vAgjCJE8
         YF4kz+erzi/nk9R5pxO0Fl6jCijTESachq5Qvy9xcp0zmV0iQvVN0EqhagBUh3ByxKiK
         5NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341427; x=1731946227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikffGFv9vfeGkXMvxoClTn0ciNkxNsHM/SDnKUO1+ao=;
        b=VxeujmKwyGCpB5/DY3iUcwUDczZ+wnqazFYUCF9398kbO5M1CocVu9TI5D4r2z22Rh
         q6ZPEhuSMrl0VsTjL0WEISWJFMisp36LC58V21NPy3NaFrr7iOpjo2er61IGDXRm0Jju
         gJc70EFNlmftqmrSJbRiwYbiXTo0FN8ZdBkJvtnACg7lC13EhKmb9Kdssv2GUjaxqBPj
         evzsWiZnCH4RC/lWQc8PlPmhXnaHZ6ackavY/QzsqQhwmq7Jq0RFFVNXHsRX2c36KXS5
         8Js4m6h/yRIy2fdhs60g8lP7KlihdelYqDjtEubFBHauKhfSsIYUgQ7WLCHvefRtxxcY
         Vp9w==
X-Forwarded-Encrypted: i=1; AJvYcCW69Zu2h8jm2HLYfxSTzfo8s5zHAUnKnkKwxOAuGf+hT8rOM7FsRp4Rys+ojbjjl+ixoK71dINUuubTwTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97KeYSqr6WY/H5TJnZsVlP/qldKNJGVU8ZBxQshwlWO9NITt3
	WKVt9NL9JCQ3Og+R2K+YwO59iNEqs2csKgyOMN9EF9l97O0Q/PkhIJSfBVMTx2zw/S5qA+OHSFS
	zHhzPOKqhor7Fk5EDVC/5Kuwz6b8XxDnFiZsC
X-Gm-Gg: ASbGnctC+93+UQo+qELXxWvAVA7XgbIZ6wt++7hCo2w85E2gtWD2Fg8C2NvmForG5sR
	DyQMhxj1+nwN74+sDABc6akXR9UCbpaC5l2LS3kALgCT53bTH0C5nfQpDt0oOlqY=
X-Google-Smtp-Source: AGHT+IESn27j6H0P/bztSq05yiNWLa9YDDhZOVMUkRhXMtov7HP8xPwzz2i5bc2f1ZIQneV7+bvEsp8r6rXVXFIg6RM=
X-Received: by 2002:a05:6e02:1aa5:b0:3a6:b3b0:5696 with SMTP id
 e9e14a558f8ab-3a6f9539f08mr7856935ab.7.1731341427022; Mon, 11 Nov 2024
 08:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109160219.49976-1-irogers@google.com> <bfba7266-1903-41ca-9961-aa449f982912@linux.intel.com>
In-Reply-To: <bfba7266-1903-41ca-9961-aa449f982912@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 08:10:14 -0800
Message-ID: <CAP-5=fWxMzCDQ7v1W_gMN-Yaz4yiam=5vOc8+bter0vF4cbV+Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Add a runs-per-test flag
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:52=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-11-09 11:02 a.m., Ian Rogers wrote:
> > To detect flakes it is useful to run tests more than once. Add a
> > runs-per-test flag that will run each test multiple times.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index d2cabaa8ad92..574fbd5caff0 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -42,6 +42,8 @@
> >  static bool dont_fork;
> >  /* Fork the tests in parallel and wait for their completion. */
> >  static bool sequential;
> > +/* Numer of times each test is run. */
> > +static unsigned int runs_per_test =3D 1;
> >  const char *dso_to_test;
> >  const char *test_objdump_path =3D "objdump";
> >
> > @@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suites,=
 int argc, const char *argv[],
> >                               len =3D strlen(test_description(*t, subi)=
);
> >                               if (width < len)
> >                                       width =3D len;
> > -                             num_tests++;
> > +                             num_tests +=3D runs_per_test;
> >                       }
> >               } else {
> > -                     num_tests++;
> > +                     num_tests +=3D runs_per_test;
> >               }
> >       }
>
> Seems we just need to calculate the num_tests once at the end for each
> loop. Something as below may works. (not tested)
>
> @@ -482,20 +490,19 @@ static int __cmd_test(struct test_suite **suites,
> int argc, const char *argv[],
>
>         for (struct test_suite **t =3D suites; *t; t++) {
>                 int len =3D strlen(test_description(*t, -1));
> +               int subi =3D 0, subn =3D 1;
>
>                 if (width < len)
>                         width =3D len;
>
>                 if (has_subtests(*t)) {
> -                       for (int subi =3D 0, subn =3D num_subtests(*t); s=
ubi
> < subn; subi++) {
> +                       for (subn =3D num_subtests(*t); subi < subn; subi=
++) {
>                                 len =3D strlen(test_description(*t, subi)=
);
>                                 if (width < len)
>                                         width =3D len;
> -                               num_tests++;
>                         }
> -               } else {
> -                       num_tests++;
>                 }
> +               num_tests +=3D subn * runs_per_test;
>         }
>         child_tests =3D calloc(num_tests, sizeof(*child_tests));
>         if (!child_tests)

It's basically the same thing, instead of doing increments and then
multiplying by runs_per_test you just add on runs_per_test and avoid
the multiply.

> >       child_tests =3D calloc(num_tests, sizeof(*child_tests));
> > @@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suites,=
 int argc, const char *argv[],
> >                       }
> >
> >                       if (!has_subtests(*t)) {
> > -                             err =3D start_test(*t, curr, -1, &child_t=
ests[child_test_num++],
> > -                                              width, pass);
> > -                             if (err)
> > -                                     goto err_out;
> > +                             for (unsigned int run =3D 0; run < runs_p=
er_test; run++) {
> > +                                     err =3D start_test(*t, curr, -1, =
&child_tests[child_test_num++],
> > +                                                     width, pass);
> > +                                     if (err)
> > +                                             goto err_out;
> > +                             }
> >                               continue;
> >                       }
> > -                     for (int subi =3D 0, subn =3D num_subtests(*t); s=
ubi < subn; subi++) {
> > -                             if (!perf_test__matches(test_description(=
*t, subi),
> > -                                                     curr, argc, argv)=
)
> > -                                     continue;
> > -
> > -                             err =3D start_test(*t, curr, subi, &child=
_tests[child_test_num++],
> > -                                              width, pass);
> > -                             if (err)
> > -                                     goto err_out;
> > +                     for (unsigned int run =3D 0; run < runs_per_test;=
 run++) {
> > +                             for (int subi =3D 0, subn =3D num_subtest=
s(*t); subi < subn; subi++) {
> > +                                     if (!perf_test__matches(test_desc=
ription(*t, subi),
> > +                                                                     c=
urr, argc, argv))
> > +                                             continue;
> > +
> > +                                     err =3D start_test(*t, curr, subi=
, &child_tests[child_test_num++],
> > +                                                     width, pass);
> > +                                     if (err)
> > +                                             goto err_out;
> > +                             }
>
> Can we add a wrapper for the start_test()? Something similar to below?
> It avoids adding the loop for every places using the start_test.
>
> +static int start_test(struct test_suite *test, int i, int subi, struct
> child_test **child,
> +               int width, int pass)
> +{
> +       for (unsigned int run =3D 0; run < runs_per_test; run++) {
> +               __start_test();
> +       }
> +}

I think the issue is the code has become overly indented. Having a
start_test function that starts some number of tests feels less than
intention revealing. Perhaps (in the future I'd like to tackle other
things for now, such as new TMAs :-) ) we can create all the child
tests in one pass, then just have start_test and finish_test work with
the child tests. (Off topic) Something else I'd like is to move the
slower running tests to the end of the list of tests so you can see
the earlier results while waiting.

Thanks,
Ian


> >                       }
> >               }
> >               if (!sequential) {
> > @@ -714,6 +720,8 @@ int cmd_test(int argc, const char **argv)
> >                   "Do not fork for testcase"),
> >       OPT_BOOLEAN('S', "sequential", &sequential,
> >                   "Run the tests one after another rather than in paral=
lel"),
> > +     OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
> > +                  "Run each test the given number of times, default 1"=
),
> >       OPT_STRING('w', "workload", &workload, "work", "workload to run f=
or testing, use '--list-workloads' to list the available ones."),
> >       OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the avail=
able builtin workloads to use with -w/--workload"),
> >       OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>

