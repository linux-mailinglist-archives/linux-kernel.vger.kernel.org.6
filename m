Return-Path: <linux-kernel+bounces-323402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A6973CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB44B22317
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FB1A0706;
	Tue, 10 Sep 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iB38T1TY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C63188CB1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984036; cv=none; b=rKC4rzCyBMjUiYGiveFPCn2HYI2HBBu1w2+Y74fnQrQQr21Cqj9glwkaPGKgqaa0dbsBbVu5at5b9mYcduRIiZmAG9jWjRdx76QGTt3epEVJfMm1zdfWcu3eAdsbwNXFRZN243ID5SaxEcZarn4OuepXU/EefuUbYd5VYtZReA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984036; c=relaxed/simple;
	bh=V99WNH5dOmvSNnSF/BmHZyT/GRd0NVPuBJ1LTz6DTms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAJ9amV1Lh8tOILuoNX3jxPURmEjD+8N2TBApj9SERYY6VO319OzhZlXY6sGoDRQl8XPm7IrUBma/9cVzQOalC4MDSPpyGhBNSZSFOlTe0gPH7GIEpyqyjt51sqm3vSbKr8d//MhOExan0S9ZdZbPibB+Uu/v8ZSp9WWRERJNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iB38T1TY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207349fa3d7so188545ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725984034; x=1726588834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/pQ6A+pcYJ6D1seY7AqA3NxJXg0QF/AHpSLfCgBJF0=;
        b=iB38T1TYqgSWr6yPZbTHp1uMfqdb+RbnRVotO3uPu65twBEa3px6fHZIWoypyBDJZS
         pOFK5se+dbAri7jd9QszZ5zmVlVchURdUIg420tEEj8+sN9SVGxEkAKKMg8O1hz+ZMaP
         xNxTIPw3spDdWB3aPR/leUhcZATYr9m9f/y3W1Vg2t6W3m5aple7BmVDRfKa8H/WCFD/
         05l74fAo43Kdh3soP4zkvE7MP3V1kUL8dd7RqDosrjqReKmrQ6nYWRs2zsWqTdBdaOHa
         2+e/GFysYGpWuCoOsQeZ/1HGSLXpuPWS5RaExm2cDEfb/347Rk0VOPCE6IEJj3XGjK8u
         UdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984034; x=1726588834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/pQ6A+pcYJ6D1seY7AqA3NxJXg0QF/AHpSLfCgBJF0=;
        b=MNuiNRbSOSOg0w/a6Xx6eyzNKv1XQ9+Qyvo8tG0Fw3gjOpCYiMLDkXch1o9nlWM0Y0
         KGIXpMmHFNJhFGn0BUKFALhb0+JFUqFIc7BfPc4v37cfPjTVZU4es5+t3I6SoXA3GuFf
         1ttXODaJFmJbOp0gPkzsRxqPQsJ7Fleb2jHgqo1p9LbJ0LudAIVTBx59SYNg3JsZwsCl
         e7Wq72roKMeEv3Z5J9BvBhnjWpl4ofebW6GSiEPnBLq6Xte+v+T/besyrxJUkAB+Gg/C
         JYOIPgnhgzPWpYqEinkyxASJJmXRiYHQwC99KRFJB08Tz2sx7TItB+fucECyMgg8BLeO
         7Y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXCxJv+f2ScWDFEBjFkklx9a0UJvuzOi9dCWxCyZuAWLMzIzTNwKQKjB0QA1NNmLAQRp80Nd2pyswXV6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJbFRLAIKiOgkcuY6NDEmj3IUIx134K5Enqt+48tXYxfh9E8Z
	5R14qtyGb3GjMcxCc1i/YHKvQjGZDvPgrNbIIB7T72uJWTMRpjB8B+BKVsRByCIzNW97dVAzGju
	xvdQP3x0D83WiET/fleVMmV2jjMdpDCa+7eeG
X-Google-Smtp-Source: AGHT+IHRCPEz5/BbFDmFo23Gi8jP7WaCaP46OvR/6hySAeelq879cijbQ/h4qP+7bgQO4s0dbhmIgkTf4d+zhILMM0I=
X-Received: by 2002:a17:902:fa10:b0:205:6c5f:e3ac with SMTP id
 d9443c01a7336-2074c646bc1mr1059585ad.19.1725983975114; Tue, 10 Sep 2024
 08:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com> <20240907050830.6752-14-irogers@google.com>
 <Zt_eOhg7I81oGeo2@google.com>
In-Reply-To: <Zt_eOhg7I81oGeo2@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Sep 2024 08:59:23 -0700
Message-ID: <CAP-5=fXRY=ATVqnCpkyBJjgrQsb03jFwU6Knje2easrWb7j0bQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/15] perf tests: Add tool PMU test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 06, 2024 at 10:08:28PM -0700, Ian Rogers wrote:
> > Ensure parsing with and without PMU creates events with the expected
> > config values. This ensures the tool.json doesn't get out of sync with
> > tool_pmu_event enum.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/Build          |   1 +
> >  tools/perf/tests/builtin-test.c |   1 +
> >  tools/perf/tests/tests.h        |   1 +
> >  tools/perf/tests/tool_pmu.c     | 111 ++++++++++++++++++++++++++++++++
> >  4 files changed, 114 insertions(+)
> >  create mode 100644 tools/perf/tests/tool_pmu.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 5671ee530019..a771e4928247 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -67,6 +67,7 @@ perf-test-y +=3D sigtrap.o
> >  perf-test-y +=3D event_groups.o
> >  perf-test-y +=3D symbols.o
> >  perf-test-y +=3D util.o
> > +perf-test-y +=3D tool_pmu.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> >  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 470a9709427d..3b30f258c395 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] =3D {
> >       &suite__PERF_RECORD,
> >       &suite__pmu,
> >       &suite__pmu_events,
> > +     &suite__tool_pmu,
> >       &suite__dso_data,
> >       &suite__perf_evsel__roundtrip_name_test,
> >  #ifdef HAVE_LIBTRACEEVENT
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 6ea2be86b7bf..1ed76d4156b6 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
> >  DECLARE_SUITE(syscall_openat_tp_fields);
> >  DECLARE_SUITE(pmu);
> >  DECLARE_SUITE(pmu_events);
> > +DECLARE_SUITE(tool_pmu);
> >  DECLARE_SUITE(attr);
> >  DECLARE_SUITE(dso_data);
> >  DECLARE_SUITE(dso_data_cache);
> > diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> > new file mode 100644
> > index 000000000000..94d0dd8fd3cb
> > --- /dev/null
> > +++ b/tools/perf/tests/tool_pmu.c
> > @@ -0,0 +1,111 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "debug.h"
> > +#include "evlist.h"
> > +#include "parse-events.h"
> > +#include "tests.h"
> > +#include "tool_pmu.h"
> > +
> > +static int do_test(enum tool_pmu_event ev, bool with_pmu)
> > +{
> > +     struct evlist *evlist =3D evlist__new();
> > +     struct evsel *evsel;
> > +     struct parse_events_error err;
> > +     int ret;
> > +     char str[128];
> > +     bool found =3D false;
> > +
> > +     if (!evlist) {
> > +             pr_err("evlist allocation failed\n");
> > +             return TEST_FAIL;
> > +     }
> > +
> > +     if (with_pmu)
> > +             snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to=
_str(ev));
> > +     else
> > +             strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> > +
> > +     parse_events_error__init(&err);
> > +     ret =3D parse_events(evlist, str, &err);
> > +     if (ret) {
> > +             evlist__delete(evlist);
> > +             if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> > +                     ret =3D TEST_OK;
> > +                     goto out;
> > +             }
> > +
> > +             pr_debug("FAILED %s:%d failed to parse event '%s', err %d=
\n",
> > +                      __FILE__, __LINE__, str, ret);
> > +             parse_events_error__print(&err, str);
> > +             ret =3D TEST_FAIL;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D TEST_OK;
> > +     if (with_pmu ? (evlist->core.nr_entries !=3D 1) : (evlist->core.n=
r_entries < 1)) {
> > +             pr_debug("FAILED %s:%d Unexpected number of events for '%=
s' of %d\n",
> > +                      __FILE__, __LINE__, str, evlist->core.nr_entries=
);
> > +             ret =3D TEST_FAIL;
> > +             goto out;
> > +     }
> > +
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             if (perf_pmu__is_tool(evsel->pmu)) {
> > +                     if (evsel->core.attr.config !=3D ev) {
> > +                             pr_debug("FAILED %s:%d Unexpected config =
for '%s', %lld !=3D %d\n",
> > +                                     __FILE__, __LINE__, str, evsel->c=
ore.attr.config, ev);
> > +                             ret =3D TEST_FAIL;
> > +                             goto out;
> > +                     }
> > +                     found =3D true;
> > +             }
> > +     }
> > +
> > +     if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) =
{
> > +             pr_debug("FAILED %s:%d Didn't find tool event '%s' in par=
sed evsels\n",
> > +                      __FILE__, __LINE__, str);
> > +             ret =3D TEST_FAIL;
> > +     }
> > +
> > +out:
> > +     evlist__delete(evlist);
> > +     return ret;
> > +}
> > +
> > +static int test__tool_pmu_without_pmu(struct test_suite *test __maybe_=
unused,
> > +                                   int subtest __maybe_unused)
> > +{
> > +     int i;
> > +
> > +     tool_pmu__for_each_event(i) {
> > +             int ret =3D do_test(i, /*with_pmu=3D*/false);
> > +
> > +             if (ret !=3D TEST_OK)
> > +                     return ret;
> > +     }
> > +     return TEST_OK;
> > +}
> > +
> > +static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unu=
sed,
> > +                                int subtest __maybe_unused)
> > +{
> > +     int i;
> > +
> > +     tool_pmu__for_each_event(i) {
> > +             int ret =3D do_test(i, /*with_pmu=3D*/true);
> > +
> > +             if (ret !=3D TEST_OK)
> > +                     return ret;
> > +     }
> > +     return TEST_OK;
> > +}
> > +
> > +static struct test_case tests__tool_pmu[] =3D {
> > +     TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
> > +     TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
> > +     {       .name =3D NULL, }
>
> An unusual indentation.

Agreed. It matches the other tests though:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n303
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu.c?h=3Dperf-tools-next#n539
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2876

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +};
> > +
> > +struct test_suite suite__tool_pmu =3D {
> > +     .desc =3D "Tool PMU",
> > +     .test_cases =3D tests__tool_pmu,
> > +};
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >

