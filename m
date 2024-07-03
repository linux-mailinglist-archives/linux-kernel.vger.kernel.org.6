Return-Path: <linux-kernel+bounces-238868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BA925259
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B13B2884C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364E2BAF9;
	Wed,  3 Jul 2024 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAIW4T6N"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA708F7D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981059; cv=none; b=t+P05O1ExW0x+vprHxFU/2M69YXG054J8+cNe10vTr/Yd5RnH3omqagQVQM2Ba/lMN0RUBcUvxRNLfj5XbDSKVy9+46y7t6ggN57cs7nyNWX6z5V0XgN8m+DtlqSowJzB8boW0POAcHZOLB27JSgRdwbZzOvfN5AKrQbEmsxsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981059; c=relaxed/simple;
	bh=37IRr2QcxmjVzF/4OYuhh8xlkChugP8dheumQYsEPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a99jnUH6kGSaQYXjgHhwd0Mw/UGh0kkm1XeNzbFx8KE2iJ52fSl02VmY0TXj0rWcOzUdd2dqCXTRwX/wflv/2+JU8zgCzIx8m/TYbH4jNAhs75h7dJyqbfUNvrhEITgaOhnTVpk0A8b3pV0XwE6x8RRy6f2h2ejcl5x28eka9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAIW4T6N; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so107145ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 21:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719981056; x=1720585856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2d/8FSFxLyr3PF+EAPuvO1a3XugFvqr/M7rp6FqW4A=;
        b=wAIW4T6N1wruStmEiQL3jpaVwHI8RYMONrlTBLOXtTvYujDJ3rq1ZvwPw0YxXxYwjP
         RwbebL2XWVRQiJh+f8drU1OyTmmciapEx8hV7KfguLu+RIAran2rzM+k+8yGqGCCyFEN
         1/mCVGwk2wNrPqksE08AyorfZchoZIKyR4W9ceV0wxQo2dDocOq9/xqhCy0bfrgBcd9g
         wioc/obJ85jdfiqnDpNvCKlLVLj7jJZQlNPvhxpdcOeLIzfk9rzm3jjI+FDukvPhhfG5
         mRU6ybv+IbgYczAHpvjQaVnDi4xVWNPAi9QYKxiS8mduKSmnU1LzzTSBQ1QujJtbYnqV
         T6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719981056; x=1720585856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2d/8FSFxLyr3PF+EAPuvO1a3XugFvqr/M7rp6FqW4A=;
        b=qxp3QDk7cxjkNU4NBJ5gS92Q+ep/W7J0bHvBY2LxA//MJmQGRL7iHcjouv8S363Bh1
         fenw5LTJ0/7HazXJH2uHHL9DA4Mkh98FIFHTPCPnfMnV5Fo8bDO9OIOEJrXkYApi3R1Q
         pZURK1V8FhyUReAtK+Gmpo7L9vscVpUMSSTdP8ZpEFYP+oPSCsYLwSdWR25m5yy/59RS
         SV19dgmveZl54Ig003XDltYVExbZmAIkjMfpV2aQ3L9xj+XSVxNLbO80QJjrRmhzNrje
         Lqt/h90KaGV5yncLfFR17lbJmwowYuO3O2ACnLIMQd8uRVmUZewW2hKRWHs2ojwMj1rL
         ww7A==
X-Forwarded-Encrypted: i=1; AJvYcCXgfi/olJ9mm71WdnoyJ4gRKbC7TuNRzdSsmjLE5h8mjpqxaPyAgFBvEuJHJpSCLBSH+lP2iBQ8bEB6GukACDoUB1gfdNPWgXeYrl7f
X-Gm-Message-State: AOJu0YyzGU/jU8znETrqSH+rijYUHku8xXAYP/B3zdDwwPlT86nEmLfE
	G4arGp8r9+rt5FIMfzu0pBiGgZpCrgTwkVpR2cR7qZrOoLQ0zJ/cjN36kbkHECQzuHDVUNErUZw
	0HPCXzLvtOIYf/IU5777MfXkoxU4owcd9NXCm
X-Google-Smtp-Source: AGHT+IFXPppgrfUZ9wzndJtLIV3m/OExMdUArsOD6IWmmUY6gH0OFlqJAYMeTLuK9VunbmIadO/XvcoWrMEdIBJ0jDk=
X-Received: by 2002:a05:6e02:1a8a:b0:374:a294:58bf with SMTP id
 e9e14a558f8ab-381e13c5980mr1959735ab.10.1719981056012; Tue, 02 Jul 2024
 21:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com> <20240701044236.475098-3-irogers@google.com>
 <ZoTIDCXKZw0bnthC@google.com>
In-Reply-To: <ZoTIDCXKZw0bnthC@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jul 2024 21:30:44 -0700
Message-ID: <CAP-5=fUAeVL57Q14hL=girAeNev-xjgz0Wv5Vpc_OMwXoouoTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf test: Display number of remaining tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sun, Jun 30, 2024 at 09:42:36PM -0700, Ian Rogers wrote:
> > Before polling or sleeping to wait for a test to complete, print out
> > ": Running (<num> remaining)" where the number of remaining tests is
> > determined by iterating over the remaining tests and seeing which
> > return true for check_if_command_finished. After the delay, erase the
> > line and either update it with the new number of remaining tests, or
> > print the test's result. This allows a user to know a test is running
> > and in parallel mode (default) how many of the tests are waiting to
>
> It's not default anymore. :)
>
>
> > complete. If color mode is disabled then avoid displaying the
> > "Running" message.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
> >  tools/perf/util/color.h         |  1 +
> >  2 files changed, 53 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index c3d84b67ca8e..23be9139f229 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -241,7 +241,10 @@ static int run_test_child(struct child_process *pr=
ocess)
> >       return -err;
> >  }
> >
> > -static int print_test_result(struct test_suite *t, int i, int subtest,=
 int result, int width)
> > +#define TEST_RUNNING -3
> > +
> > +static int print_test_result(struct test_suite *t, int i, int subtest,=
 int result, int width,
> > +                          int remaining)
> >  {
> >       if (has_subtests(t)) {
> >               int subw =3D width > 2 ? width - 2 : width;
> > @@ -251,6 +254,9 @@ static int print_test_result(struct test_suite *t, =
int i, int subtest, int resul
> >               pr_info("%3d: %-*s:", i + 1, width, test_description(t, s=
ubtest));
> >
> >       switch (result) {
> > +     case TEST_RUNNING:
> > +             color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d re=
maining)\n", remaining);
> > +             break;
> >       case TEST_OK:
> >               pr_info(" Ok\n");
> >               break;
> > @@ -272,13 +278,15 @@ static int print_test_result(struct test_suite *t=
, int i, int subtest, int resul
> >       return 0;
> >  }
> >
> > -static int finish_test(struct child_test *child_test, int width)
> > +static int finish_test(struct child_test **child_tests, int running_te=
st, int child_test_num,
> > +                    int width)
> >  {
> > +     struct child_test *child_test =3D child_tests[running_test];
> >       struct test_suite *t =3D child_test->test;
> >       int i =3D child_test->test_num;
> >       int subi =3D child_test->subtest;
> >       int err =3D child_test->process.err;
> > -     bool err_done =3D err <=3D 0;
> > +     bool err_done =3D false;
> >       struct strbuf err_output =3D STRBUF_INIT;
> >       int ret;
> >
> > @@ -293,7 +301,7 @@ static int finish_test(struct child_test *child_tes=
t, int width)
> >        * Busy loop reading from the child's stdout/stderr that are set =
to be
> >        * non-blocking until EOF.
> >        */
> > -     if (!err_done)
> > +     if (err > 0)
> >               fcntl(err, F_SETFL, O_NONBLOCK);
> >       if (verbose > 1) {
> >               if (has_subtests(t))
> > @@ -307,29 +315,48 @@ static int finish_test(struct child_test *child_t=
est, int width)
> >                         .events =3D POLLIN | POLLERR | POLLHUP | POLLNV=
AL,
> >                       },
> >               };
> > -             char buf[512];
> > -             ssize_t len;
> > -
> > -             /* Poll to avoid excessive spinning, timeout set for 100m=
s. */
> > -             poll(pfds, ARRAY_SIZE(pfds), /*timeout=3D*/100);
> > -             if (!err_done && pfds[0].revents) {
> > -                     errno =3D 0;
> > -                     len =3D read(err, buf, sizeof(buf) - 1);
> > -
> > -                     if (len <=3D 0) {
> > -                             err_done =3D errno !=3D EAGAIN;
> > -                     } else {
> > -                             buf[len] =3D '\0';
> > -                             if (verbose > 1)
> > -                                     fprintf(stdout, "%s", buf);
> > -                             else
> > +             if (perf_use_color_default) {
> > +                     int tests_in_progress =3D running_test;
> > +
> > +                     for (int y =3D running_test; y < child_test_num; =
y++) {
> > +                             if (check_if_command_finished(&child_test=
s[y]->process))
> > +                                     tests_in_progress++;
> > +                     }
> > +                     print_test_result(t, i, subi, TEST_RUNNING, width=
,
> > +                                       child_test_num - tests_in_progr=
ess);
> > +             }
> > +
> > +             err_done =3D true;
> > +             if (err <=3D 0) {
> > +                     /* No child stderr to poll, sleep for 10ms for ch=
ild to complete. */
> > +                     usleep(10 * 1000);
> > +             } else {
> > +                     /* Poll to avoid excessive spinning, timeout set =
for 100ms. */
> > +                     poll(pfds, ARRAY_SIZE(pfds), /*timeout=3D*/100);
>
> When I tested this patch, I saw it refreshes too often in parallel mode.
> Maybe 100ms is too short?  I don't know if it's from usleep (10ms) or
> here.

It's usually the poll and I suspect it is the test writing a lot of
output. I agree it can look a little flickery but it is also
responsive in terms of not waiting too long before moving to the next
test. I think it is possible to improve on the code here, the main
thing I was after was making the output writing self contained and not
split between start test and finish test, as that won't work well in
the parallel case.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     if (pfds[0].revents) {
> > +                             char buf[512];
> > +                             ssize_t len;
> > +
> > +                             len =3D read(err, buf, sizeof(buf) - 1);
> > +
> > +                             if (len > 0) {
> > +                                     err_done =3D false;
> > +                                     buf[len] =3D '\0';
> >                                       strbuf_addstr(&err_output, buf);
> > +                             }
> >                       }
> >               }
> > +             if (err_done)
> > +                     err_done =3D check_if_command_finished(&child_tes=
t->process);
> > +
> > +             if (perf_use_color_default) {
> > +                     /* Erase "Running (.. remaining)" line printed be=
fore poll/sleep. */
> > +                     fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
> > +             }
> >       }
> >       /* Clean up child process. */
> >       ret =3D finish_command(&child_test->process);
> > -     if (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL) {
> > +     if (verbose > 1 || (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL)) {
> >               /* Add header for test that was skipped above. */
> >               if (has_subtests(t))
> >                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_d=
escription(t, subi));
> > @@ -338,7 +365,7 @@ static int finish_test(struct child_test *child_tes=
t, int width)
> >               fprintf(stderr, "%s", err_output.buf);
> >       }
> >       strbuf_release(&err_output);
> > -     print_test_result(t, i, subi, ret, width);
> > +     print_test_result(t, i, subi, ret, width, /*remaining=3D*/0);
> >       if (err > 0)
> >               close(err);
> >       return 0;
> > @@ -354,7 +381,7 @@ static int start_test(struct test_suite *test, int =
i, int subi, struct child_tes
> >               pr_debug("--- start ---\n");
> >               err =3D test_function(test, subi)(test, subi);
> >               pr_debug("---- end ----\n");
> > -             print_test_result(test, i, subi, err, width);
> > +             print_test_result(test, i, subi, err, width, /*remaining=
=3D*/0);
> >               return 0;
> >       }
> >
> > @@ -379,7 +406,7 @@ static int start_test(struct test_suite *test, int =
i, int subi, struct child_tes
> >       err =3D start_command(&(*child)->process);
> >       if (err || !sequential)
> >               return  err;
> > -     return finish_test(*child, width);
> > +     return finish_test(child, /*running_test=3D*/0, /*child_test_num=
=3D*/1, width);
> >  }
> >
> >  #define for_each_test(j, k, t)                                       \
> > @@ -464,7 +491,7 @@ static int __cmd_test(int argc, const char *argv[],=
 struct intlist *skiplist)
> >       }
> >       for (i =3D 0; i < child_test_num; i++) {
> >               if (!sequential) {
> > -                     int ret  =3D finish_test(child_tests[i], width);
> > +                     int ret  =3D finish_test(child_tests, i, child_te=
st_num, width);
> >
> >                       if (ret)
> >                               return ret;
> > diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> > index 01f7bed21c9b..4b9f8d5d4439 100644
> > --- a/tools/perf/util/color.h
> > +++ b/tools/perf/util/color.h
> > @@ -22,6 +22,7 @@
> >  #define MIN_GREEN    0.5
> >  #define MIN_RED              5.0
> >
> > +#define PERF_COLOR_DELETE_LINE       "\033[A\33[2K\r"
> >  /*
> >   * This variable stores the value of color.ui
> >   */
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >

