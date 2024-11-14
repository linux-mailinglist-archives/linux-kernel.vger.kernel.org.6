Return-Path: <linux-kernel+bounces-410071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0E9C9632
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A70EB237C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80991B21B3;
	Thu, 14 Nov 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAgqFCW4"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DF18E029
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627349; cv=none; b=dE9d1Kqz3P0gwhfpRpC5QYDrs0E4luz8P1vXwQ2D82YoHSrj/GlWJ0UTW6GiXB/iIRKRrkiR4sO5Af/y/5mLswmqXYeV+1vZCDIrMyTSF9dT1ITs0gP6ny4/MpVKyNxgD0K/FwpyNCmJ6wpyeLV8d5IMorwWZ1/u7jZnEgwCdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627349; c=relaxed/simple;
	bh=pN80x9+lnTyy8g1HvH/5kUI2oEcit5Gv/SrXM1zibho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl07U+N0rqoQjRXn2GfLmznlmvPLqT6hKyqRNZgg24k31wiiOrPBDOUntsPk+7iVzjDza3VdyYbp/k6qI3GA3jk4FloWRDL2pqedjUpXMraubEneAkd05DE7yAJof35AqBGJTp0AmKsP7LuDYEWsrXf7Phx8cjMnTcTkQ6os5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAgqFCW4; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a716d74c28so23015ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731627346; x=1732232146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgQfhBlkUAQ6nIjtqhBRpDx7oV+k/w2l37OKCHA0UM4=;
        b=nAgqFCW45mdpCPbmDKWEeUXvpZ/kkfDUPB+e+zCgXKH18OrXr4YU2EBTi2nkM+7WdV
         pbx9lKdVYlH3bVPmbDYXXuA9FnLF7awevrmhdHEmhP8yNCWeR45BBXb3C7CtJPyatKBn
         x2Ba6Hcakq+Pv9Ykr2BE/kDwehoou9CIOT6X3itOHArE+0ERHvVPJNXcKBMJOxu01zTm
         95e7fqzjlKCKTP3mu0j5uGXo8j4PS0RbczRX01MPA13izvl98psIiQjGFowQ+zpNwl4k
         5CZ96S+rcJnx+0b3vwM4r2yspz4O4Mb9MAeIi4cIKyAjT44A41uY63i6vHv9S7O2yFY3
         kXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627346; x=1732232146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgQfhBlkUAQ6nIjtqhBRpDx7oV+k/w2l37OKCHA0UM4=;
        b=N2XNSyr05IXSbtRGofp9pz1lz58zhwA2kiZt5Zdnr9N+a/g1YHmobHtx/F8mVgLeSd
         sD58DjUpKI9SpSCiBRxUU7nh0Ik7hGEFMD7cZVuSjTbTSTerJrozTn2pXBujvyT2TPWQ
         TNLtlViU63vRV/X4jIdl6vG5K+l4F65LHs3unyUY+mqBlsgft2uA9Nl3JMCQ9nGf4zUm
         7PFXY/VHF7Q2blNdPDkXi/4UoLQ/w96hyPE055/X+WOD2SQ6XVLMsVsvhFqcDG22kKlK
         /UsemNd/9+DVom5PtFUSoJnicl63AHx1X5yTNrhccI4a4ygOm1Al7qQI5C7YcFtG3p91
         y0dw==
X-Forwarded-Encrypted: i=1; AJvYcCWZYQ0g0N+T9bssCm6F0ig8fslNuJnNiVF5la4o+lcqSdnblrAHe0MqbTSPqej0Lf6lX7xKWSG1QBhaf+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QOSZXg5uJNCJg8IyLm12a5vtnkVMHy1Tzn6+77XSI/MByR3e
	4145yHYjFjUlRTeAsq7QdkWZbMrMO1iuJqpUYvERDfCZ9TYSCxxbnQ7Gyg5jJDVFZ6ATk9x5eRG
	BCyD+BIzJE2l0Dsz9xmBbtHVYepFpWp80q7zy
X-Gm-Gg: ASbGncu156cMS95pgYahvyCZ59h6vLbXb1j+jKKZcLNP+lWMdRIXYqbbp9fknPK9PiU
	FpACXuTfmHrHF/9kSACo6fHgOKqgaKbi8yHcqdLflYkf0dTJW01of3YHuM1UkTxw=
X-Google-Smtp-Source: AGHT+IEH16kWzu5zXGR7kRItgvQhgjRf3ErUAeZlO7mFDRvf05gsG3mdaZAiTz/F+AxRFzOjuxgNuA8jgQcRsdn5PA4=
X-Received: by 2002:a05:6e02:1fcd:b0:3a5:e506:162b with SMTP id
 e9e14a558f8ab-3a748a4be8cmr394015ab.11.1731627346310; Thu, 14 Nov 2024
 15:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114160450.295844-1-james.clark@linaro.org> <20241114160450.295844-3-james.clark@linaro.org>
In-Reply-To: <20241114160450.295844-3-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 15:35:35 -0800
Message-ID: <CAP-5=fVdNov38srPj-ax-PHtnMBhGT+y+fp+NJHGFS0dxRchew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libperf: evlist: Keep evsel idx contiguous on removal
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	thomas.falcon@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 8:07=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The only two places where evsels are removed end up fixing up the index.
> Move it into libperf so that it's always done.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

but I was also reminded that the evsel idx is just a meaningless int
and we should stop trying to make it special, so I sent out some clean
up:
https://lore.kernel.org/lkml/20241114230713.330701-1-irogers@google.com/

You may get asked by the maintainers to separate the test from the
main logic to make patches with fewer lines of code =C2=AF\_(=E3=83=84)_/=
=C2=AF

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c            | 17 +++++++------
>  tools/lib/perf/tests/test-evlist.c | 41 ++++++++++++++++++++++++++++++
>  tools/perf/builtin-record.c        | 18 +++----------
>  3 files changed, 53 insertions(+), 23 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 83c43dc13313..ffa1a28fb14f 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -52,15 +52,8 @@ static void __perf_evlist__propagate_maps(struct perf_=
evlist *evlist,
>                  * Empty cpu lists would eventually get opened as "any" s=
o remove
>                  * genuinely empty ones before they're opened in the wron=
g place.
>                  */
> -               if (perf_cpu_map__is_empty(evsel->cpus)) {
> -                       struct perf_evsel *next =3D perf_evlist__next(evl=
ist, evsel);
> -
> +               if (perf_cpu_map__is_empty(evsel->cpus))
>                         perf_evlist__remove(evlist, evsel);
> -                       /* Keep idx contiguous */
> -                       if (next)
> -                               list_for_each_entry_from(next, &evlist->e=
ntries, node)
> -                                       next->idx--;
> -               }
>         } else if (!evsel->own_cpus || evlist->has_user_cpus ||
>                 (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist=
->user_requested_cpus))) {
>                 /*
> @@ -116,8 +109,16 @@ void perf_evlist__add(struct perf_evlist *evlist,
>  void perf_evlist__remove(struct perf_evlist *evlist,
>                          struct perf_evsel *evsel)
>  {
> +       struct perf_evsel *next =3D perf_evlist__next(evlist, evsel);
> +
>         list_del_init(&evsel->node);
>         evlist->nr_entries -=3D 1;
> +
> +       /* Keep idx contiguous */
> +       if (!next)
> +               return;
> +       list_for_each_entry_from(next, &evlist->entries, node)
> +               next->idx--;
>  }
>
>  struct perf_evlist *perf_evlist__new(void)
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/te=
st-evlist.c
> index 10f70cb41ff1..06153820f408 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -571,6 +571,46 @@ static int test_stat_multiplexing(void)
>         return 0;
>  }
>
> +static int test_list_remove(void)
> +{
> +       struct perf_evlist *evlist;
> +       struct perf_evsel *evsel, *evsel0, *evsel1, *evsel2;
> +       struct perf_event_attr attr =3D {};
> +       int idx =3D 0;
> +
> +       evlist =3D perf_evlist__new();
> +       __T("failed to create evlist", evlist);
> +
> +       evsel0 =3D perf_evsel__new(&attr);
> +       __T("failed to create evsel", evsel0);
> +       evsel1 =3D perf_evsel__new(&attr);
> +       __T("failed to create evsel", evsel1);
> +       evsel2 =3D perf_evsel__new(&attr);
> +       __T("failed to create evsel", evsel2);
> +
> +       perf_evlist__add(evlist, evsel0);
> +       perf_evlist__add(evlist, evsel1);
> +       perf_evlist__add(evlist, evsel2);
> +
> +       idx =3D 0;
> +       perf_evlist__for_each_evsel(evlist, evsel)
> +               __T("idx isn't contiguous", evsel->idx =3D=3D idx++);
> +
> +       /* Test removing middle */
> +       perf_evlist__remove(evlist, evsel1);
> +       idx =3D 0;
> +       perf_evlist__for_each_evsel(evlist, evsel)
> +               __T("idx isn't contiguous", evsel->idx =3D=3D idx++);
> +
> +       /* Test removing end */
> +       perf_evlist__remove(evlist, evsel2);
> +       idx =3D 0;
> +       perf_evlist__for_each_evsel(evlist, evsel)
> +               __T("idx isn't contiguous", evsel->idx =3D=3D idx++);
> +
> +       return 0;
> +}
> +
>  int test_evlist(int argc, char **argv)
>  {
>         __T_START;
> @@ -583,6 +623,7 @@ int test_evlist(int argc, char **argv)
>         test_mmap_thread();
>         test_mmap_cpus();
>         test_stat_multiplexing();
> +       test_list_remove();
>
>         __T_END;
>         return tests_failed =3D=3D 0 ? 0 : -1;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7e99743f7e42..2ebbb0fd0064 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1359,14 +1359,13 @@ static int record__mmap(struct record *rec)
>  static int record__open(struct record *rec)
>  {
>         char msg[BUFSIZ];
> -       struct evsel *pos;
> +       struct evsel *pos, *tmp;
>         struct evlist *evlist =3D rec->evlist;
>         struct perf_session *session =3D rec->session;
>         struct record_opts *opts =3D &rec->opts;
>         int rc =3D 0;
> -       bool skipped =3D false;
>
> -       evlist__for_each_entry(evlist, pos) {
> +       evlist__for_each_entry_safe(evlist, tmp, pos) {
>  try_again:
>                 if (evsel__open(pos, pos->core.cpus, pos->core.threads) <=
 0) {
>                         if (evsel__fallback(pos, &opts->target, errno, ms=
g, sizeof(msg))) {
> @@ -1383,23 +1382,12 @@ static int record__open(struct record *rec)
>                         evsel__open_strerror(pos, &opts->target, errno, m=
sg, sizeof(msg));
>                         ui__error("Failure to open event '%s' on PMU '%s'=
 which will be removed.\n%s\n",
>                                   evsel__name(pos), evsel__pmu_name(pos),=
 msg);
> -                       pos->skippable =3D true;
> -                       skipped =3D true;
> +                       evlist__remove(evlist, pos);
>                 } else {
>                         pos->supported =3D true;
>                 }
>         }
>
> -       if (skipped) {
> -               struct evsel *tmp;
> -               int idx =3D 0;
> -
> -               evlist__for_each_entry_safe(evlist, tmp, pos) {
> -                       if (pos->skippable)
> -                               evlist__remove(evlist, pos);
> -                       pos->core.idx =3D idx++;
> -               }
> -       }
>         if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist))=
 {
>                 pr_warning(
>  "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,=
\n"
> --
> 2.34.1
>

