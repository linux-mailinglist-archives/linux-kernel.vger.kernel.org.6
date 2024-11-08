Return-Path: <linux-kernel+bounces-402503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD19C286C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7CE1C222F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941BD2076D2;
	Fri,  8 Nov 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sgobm0wZ"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E531F5854
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109730; cv=none; b=IKftoaLBGvgnqXMrCM/Dg8OCgqXGjdyT9Tf4fE9GAzm5ij/7QbiNr08cuGSPO/ewXevH4yiNv+n7f7cBAjVd1uaspAHHZRrmlq8fI6Kb4iIbamnAr/jCsggWCQ9qz2x2+vzl3Hlp0zDHylTlO/d0PZtDtPAnXkuHcXlMJ1PG+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109730; c=relaxed/simple;
	bh=eldVNcOZV+dAqGAKoK8atTprbd5V1cvI+q5K78Tedzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHELMp5OE56GSTk2eysi/YQdy3hJR4Bf/KvzZA0jgCR8nlFFNqfQL72Ck/UP53YW+hGeXrTjSm5IoUzD0HPcWN3Gedu9GPJvcJgMd9I6CYcCfRln2rGKI6hvc2h3DslcNLiDe8KrGz67TIJsQUsDtFod2dJgn09BO0WkAPY0JGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sgobm0wZ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso24455ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109728; x=1731714528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6ACjej3qFHiDBwX/5MZoHRQoXlJ92/vOePkD2qZBMA=;
        b=Sgobm0wZq15HchUG8zngSNe/4XqHnhp92hg7dMTMWpiGS7VIoTruwycVI2dbCsldpt
         YqC2sytU+80bcZ5yeIfxmFy2WVmINfzuYjUzEXsiyQcePTl0JeQN9EfK58mXbkDBLXy0
         HsC7+rYWLKMJxscPnF6KabF/Sr/6MJh9k1IaQIou6IueYcUsguCwEnmBY9mcVr7pn6jF
         krTG/XNEgPwelq4XgApffviCnm+lZGUvTl9c5JmafCxS+uQv+2uRTl/QSWLp/zth7Anm
         UckMzU9/qci/XxD/WWx/UamX1MnaIX1oxhG4FIWtkI51GAOr0KfgdVGb8+FkJnnhEbC8
         N1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109728; x=1731714528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6ACjej3qFHiDBwX/5MZoHRQoXlJ92/vOePkD2qZBMA=;
        b=uZhYdJwAzc1X/oIvv+ChHVcF5gGtmWX3FIINeyqrs+BDCx7cnv7qDkXpCoCsvhXNy5
         lVH216TgVLYDdWHMsDVsR1SceIakIYUsbWuqFKa2WMJtKyXQuaLN1hYSXSIYVpSAUWC3
         acGrGtabLQ2g8GY9+QZYohxBTMd7gLmY7lpw7mIDcfy96iZUkts4rwAN0bOrPHzrhUpv
         W784UB1/dpmWj6SrW6smZDqkbpKor76SU0AGfnn8bwkgjvTIPquG9Q3W082QwBXsG7u/
         FH32R8BJAssEOCzMrp2+u1Pw8yXb1/yS97WaRy1BckQTgOlZtsvGF55voaRge5J35TlR
         I/KA==
X-Forwarded-Encrypted: i=1; AJvYcCW3v5RRlWP8+FgWSv4PjCgeEgHJV1m5U8BEDAnUq+iAbPQoqY3kGgvQSAYX8iKLozr9MdV52IQtrQ6isu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VvtZh2sZvU9Qwty6fVsHWBKA9eILLlHKBBnTKiADqx7NclDR
	JAkWPwKXlWlM/fJyYxIEfUYZfBFXyVqq3C0CoD3/sfYr01VsNDUkIkMsNl3gezvUG3cFT/CmOmJ
	msGu4raU+ZjW7f+UVdq1eSWAIBLZJByxBemo7
X-Gm-Gg: ASbGncui1hjWrXbHk4vobrv2STT7vQomYPdjVGvR3HZx/eNlSaLYwkR0XUdqQwNOLi5
	XXK5cs0CDTPd1VzlJM4//cVKD1y3qo+QR
X-Google-Smtp-Source: AGHT+IGsiNqGbblt06vCKPbyra8i4Hf34BSjRawfCIzrFi3h3II6x8w2o+uPctRngacGVbN8V0ILfoGArMwQCBQ8RL0=
X-Received: by 2002:a05:6e02:1c84:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3a6f8a085camr1201525ab.10.1731109727853; Fri, 08 Nov 2024
 15:48:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com> <20241108174936.262704-4-irogers@google.com>
 <Zy5nxlGZ5cZ69F5G@google.com>
In-Reply-To: <Zy5nxlGZ5cZ69F5G@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 15:48:36 -0800
Message-ID: <CAP-5=fUnwY1BMw8epL+HS=grAmY6quRS5AZiED_HVDQZy2F8mg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] perf test: Add hwmon filename parser test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:34=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 08, 2024 at 09:49:32AM -0800, Ian Rogers wrote:
> > Filename parsing maps a hwmon filename to constituent parts enum/int
> > parts for the hwmon config value. Add a test case for the parsing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/Build          |   1 +
> >  tools/perf/tests/builtin-test.c |   1 +
> >  tools/perf/tests/hwmon_pmu.c    | 110 ++++++++++++++++++++++++++++++++
> >  tools/perf/tests/tests.h        |   1 +
> >  tools/perf/util/hwmon_pmu.c     |   2 +-
> >  5 files changed, 114 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/perf/tests/hwmon_pmu.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 01ed9335db4d..ec4e1f034742 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -66,6 +66,7 @@ perf-test-y +=3D sigtrap.o
> >  perf-test-y +=3D event_groups.o
> >  perf-test-y +=3D symbols.o
> >  perf-test-y +=3D util.o
> > +perf-test-y +=3D hwmon_pmu.o
> >  perf-test-y +=3D tool_pmu.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index d2cabaa8ad92..8dcf74d3c0a3 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] =3D {
> >       &suite__PERF_RECORD,
> >       &suite__pmu,
> >       &suite__pmu_events,
> > +     &suite__hwmon_pmu,
> >       &suite__tool_pmu,
> >       &suite__dso_data,
> >       &suite__perf_evsel__roundtrip_name_test,
> > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.=
c
> > new file mode 100644
> > index 000000000000..f5b58486d8d3
> > --- /dev/null
> > +++ b/tools/perf/tests/hwmon_pmu.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "debug.h"
> > +#include "hwmon_pmu.h"
> > +#include "tests.h"
> > +#include <linux/compiler.h>
> > +#include <linux/kernel.h>
> > +
> > +static int test__parse_hwmon_filename(struct test_suite *test __maybe_=
unused,
> > +                                   int subtest __maybe_unused)
> > +{
> > +     const struct hwmon_parse_test {
> > +             const char *filename;
> > +             enum hwmon_type type;
> > +             int number;
> > +             enum hwmon_item item;
> > +             bool alarm;
> > +             bool parse_ok;
> > +     } tests[] =3D {
> > +             {
> > +                     .filename =3D "cpu0_accuracy",
> > +                     .type =3D HWMON_TYPE_CPU,
> > +                     .number =3D 0,
> > +                     .item =3D HWMON_ITEM_ACCURACY,
> > +                     .alarm =3D false,
> > +                     .parse_ok =3D true,
> > +             },
> > +             {
> > +                     .filename =3D "temp1_input",
> > +                     .type =3D HWMON_TYPE_TEMP,
> > +                     .number =3D 1,
> > +                     .item =3D HWMON_ITEM_INPUT,
> > +                     .alarm =3D false,
> > +                     .parse_ok =3D true,
> > +             },
> > +             {
> > +                     .filename =3D "fan2_vid",
> > +                     .type =3D HWMON_TYPE_FAN,
> > +                     .number =3D 2,
> > +                     .item =3D HWMON_ITEM_VID,
> > +                     .alarm =3D false,
> > +                     .parse_ok =3D true,
> > +             },
> > +             {
> > +                     .filename =3D "power3_crit_alarm",
> > +                     .type =3D HWMON_TYPE_POWER,
> > +                     .number =3D 3,
> > +                     .item =3D HWMON_ITEM_CRIT,
> > +                     .alarm =3D true,
> > +                     .parse_ok =3D true,
> > +             },
> > +             {
> > +                     .filename =3D "intrusion4_average_interval_min_al=
arm",
> > +                     .type =3D HWMON_TYPE_INTRUSION,
> > +                     .number =3D 4,
> > +                     .item =3D HWMON_ITEM_AVERAGE_INTERVAL_MIN,
> > +                     .alarm =3D true,
> > +                     .parse_ok =3D true,
> > +             },
> > +             {
> > +                     .filename =3D "badtype5_baditem",
> > +                     .type =3D HWMON_TYPE_NONE,
> > +                     .number =3D 5,
> > +                     .item =3D HWMON_ITEM_NONE,
> > +                     .alarm =3D false,
> > +                     .parse_ok =3D false,
> > +             },
> > +             {
> > +                     .filename =3D "humidity6_baditem",
> > +                     .type =3D HWMON_TYPE_NONE,
> > +                     .number =3D 6,
> > +                     .item =3D HWMON_ITEM_NONE,
> > +                     .alarm =3D false,
> > +                     .parse_ok =3D false,
> > +             },
> > +     };
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(tests); i++) {
> > +             enum hwmon_type type;
> > +             int number;
> > +             enum hwmon_item item;
> > +             bool alarm;
> > +
> > +             TEST_ASSERT_EQUAL("parse_hwmon_filename",
> > +                             parse_hwmon_filename(
> > +                                     tests[i].filename,
> > +                                     &type,
> > +                                     &number,
> > +                                     &item,
> > +                                     &alarm),
> > +                             tests[i].parse_ok
> > +                     );
> > +             if (tests[i].parse_ok) {
> > +                     TEST_ASSERT_EQUAL("parse_hwmon_filename type", ty=
pe, tests[i].type);
> > +                     TEST_ASSERT_EQUAL("parse_hwmon_filename number", =
number, tests[i].number);
> > +                     TEST_ASSERT_EQUAL("parse_hwmon_filename item", it=
em, tests[i].item);
> > +                     TEST_ASSERT_EQUAL("parse_hwmon_filename alarm", a=
larm, tests[i].alarm);
> > +             }
> > +     }
> > +     return TEST_OK;
> > +}
> > +
> > +static struct test_case tests__hwmon_pmu[] =3D {
> > +     TEST_CASE("Basic parsing test", parse_hwmon_filename),
> > +     {       .name =3D NULL, }
> > +};
> > +
> > +struct test_suite suite__hwmon_pmu =3D {
> > +     .desc =3D "Hwmon PMU",
> > +     .test_cases =3D tests__hwmon_pmu,
> > +};
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index af284dd47e5c..cb58b43aa063 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -92,6 +92,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
> >  DECLARE_SUITE(syscall_openat_tp_fields);
> >  DECLARE_SUITE(pmu);
> >  DECLARE_SUITE(pmu_events);
> > +DECLARE_SUITE(hwmon_pmu);
> >  DECLARE_SUITE(tool_pmu);
> >  DECLARE_SUITE(attr);
> >  DECLARE_SUITE(dso_data);
> > diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> > index ee5fb1c41da3..f4b7b3b6a052 100644
> > --- a/tools/perf/util/hwmon_pmu.c
> > +++ b/tools/perf/util/hwmon_pmu.c
> > @@ -126,7 +126,7 @@ bool parse_hwmon_filename(const char *filename,
> >       fn_item_len =3D strlen(fn_item);
> >       if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm=
")) {
> >               assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
> > -             strlcpy(fn_type, fn_item, fn_item_len - 6);
> > +             strlcpy(fn_type, fn_item, fn_item_len - 5);
>
> Why is it changed?

Should be part of the last commit, there is an off-by-1 caused by
strlcpy counting copying the \0. I'll resend.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >               fn_item =3D fn_type;
> >               *alarm =3D true;
> >       }
> > --
> > 2.47.0.277.g8800431eea-goog
> >

