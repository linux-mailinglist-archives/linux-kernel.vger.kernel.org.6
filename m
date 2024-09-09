Return-Path: <linux-kernel+bounces-322094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1119723E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A1FB210EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6718A95C;
	Mon,  9 Sep 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl0e6O9r"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592518A937
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914590; cv=none; b=UORjhrtShnTKbGuOKg9nT7xRMCAaaG8hzeLN5DRenK7G/WgDeFR7AmWnozigYg0ZOBfNaVQIZU+IFjgm8hCO8o5nlvBAi2zGk2Z3cCPCmeApdD2xyZ9jrRf8j9CwAWEDMX572qWxpgVL77w3b1WzMF34qw3ABWXLeR/JerxhKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914590; c=relaxed/simple;
	bh=CEQycjdSqCG/wH/xA7Nsyogt0a/N/Fodz7icJnE7OL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlP1WlDlvEPzjPjon/Hdh0MPscW5oUbKXYoP8HwsCiSs7ChA1spjrN/kvI/oAW2SNL5meV06dot19zc4QIw1OFYv5uGsIkPyHr+X6q3cymn4cZ09yqIf7z9BsFfPn43UX2Bwq9B0IQRbjbNExUWUqLae39wbvppoXeJ8aQVlyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fl0e6O9r; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso13525ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914587; x=1726519387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD7TFpuwj1EtsCo2pgXURtlXNry0GSQ8o4yk76QlzWU=;
        b=fl0e6O9rM16AvmCSjALFQkFt5vg5MP61qwNoiPfL5Cf6jPu8yhtI9ch+Czc/AzJRiz
         n6TVyaEiXsQR5CDiY5IWax94DWLt90TRw8Tqc214wC+rRzzOYQSm128U7S7roF3o/sD0
         OTZIQ7f2f5dSumamv9vUlmGcUS+xpqptZfVpQSLII9kPExw+o4jLMd52bnexoZ4IMS2i
         aRmGhO2YwjZT53MXYvDRHZmGgEGo/21vlLGnC/UhVoDIvd8tbv82WnByM+el4s6bz3WJ
         GpCy9kcEac7WqotSETpdgzmOr+4TuRaRhjQsSqfEyIR4vL7Ge+y8td4swOvIP7+CrNDJ
         0MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914587; x=1726519387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MD7TFpuwj1EtsCo2pgXURtlXNry0GSQ8o4yk76QlzWU=;
        b=dYxeACGtrbkZsnhGeFMDQzAsmj0yd9HE62zt+OgUpBOUBxZERmKQmjGDMJUX0lOueD
         D7xTisMLHpLGFOBgBPpNOslLtiIGgQ/Pzapku1pxgJek5CuqS8bKr2C+VXYPRr5EImgO
         cUkp1WVdqQowp2mq7vrTfk0c6qXHi8O8NVSdSx75d09KKx5v1BYE3Sdmpw/GxXV+ZmnZ
         RyMc+YJgSUqyYM/HG7YS6ltlHt3KoP50LDK2TikKuCAjIq1eXBbIc6kAQyLTL1R+SeT2
         //Trs+zxpj5eMBYaP7XpGnhIxljHjZl03xsxZ7wBWq+WWGwIqpDDCqPs+awPcSIxBgE4
         1c6w==
X-Forwarded-Encrypted: i=1; AJvYcCUt9Kg2+AQ//9IEgfRDsuysh+eRrdTmU0mFeutwxDey/gLowf8YDo8f53W9Bq2Fy27zGnkFwDdDV7KqfjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwY9fNjCJG18gwkAT9jQl26rw1GlFlo0GTEd4OFVC1GfcrL1vm
	mPGmMmUU5ONEgB934V4U5L1MrOD2HdZkSQT194d/rH2daWlJYrtbAfDtfKyG7V+Jq39tkuVvHod
	SAcA2TXgt0A1LcHHgajsBbAiIto4WG9gZZ5s/
X-Google-Smtp-Source: AGHT+IGAxDE23lbT+wgQdEQJm18EM/ah8ajTrOMydlUxhIQ/jGF3POaK7rB5tXpvmhN9nmRTw80hGAlqNMdCYt5FM3w=
X-Received: by 2002:a05:6e02:1c45:b0:377:14ab:42ea with SMTP id
 e9e14a558f8ab-3a06bae3ad1mr901025ab.16.1725914586653; Mon, 09 Sep 2024
 13:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909184201.553519-1-kan.liang@linux.intel.com>
In-Reply-To: <20240909184201.553519-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Sep 2024 13:42:55 -0700
Message-ID: <CAP-5=fVpEUJOx1Sqw6uC_0Y_DqGLprYTCFH4mgSaY4mrPmNOHw@mail.gmail.com>
Subject: Re: [PATCH] perf env: Find correct branch counter info on hybrid
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:41=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> No event is printed in the "Branch Counter" column on hybrid machines.
>
> For example,
>  $perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S"
>  -j any,counter
>  $perf report --total-cycles
>
>  # Branch counter abbr list:
>  # cpu_core/branch-instructions/pp =3D A
>  # cpu_core/branches/ =3D B
>  # '-' No event occurs
>  # '+' Event occurrences may be lost due to branch counter saturated
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles  Branch Count=
er
>  # ...............  ..............  ...........  ..........  ............=
..
>            44.54%          727.1K        0.00%           1   |+   |+   |
>            36.31%          592.7K        0.00%           2   |+   |+   |
>            17.83%          291.1K        0.00%           1   |+   |+   |
>
> The branch counter information (br_cntr_width and br_cntr_nr) in the
> perf_env is retrieved from the CPU_PMU_CAPS. However, the CPU_PMU_CAPS
> is not available on hybrid machines. Without the width information, the
> number of occurrences of an event cannot be calculated.
>
> For a hybrid machine, the caps information should be retrieved from the
> PMU_CAPS, and stored in the perf_env->pmu_caps.
>
> Add a perf_env__find_br_cntr_info() to return the correct branch counter
> information from the corresponding fields.
>
> Fixes: 6f9d8d1de2c6 ("perf script: Add branch counters")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c |  5 +++--
>  tools/perf/util/annotate.c  |  5 +++--
>  tools/perf/util/env.c       | 15 +++++++++++++++
>  tools/perf/util/env.h       |  3 +++
>  tools/perf/util/session.c   |  6 ++++--
>  5 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index dbe792b52c5c..a644787fa9e1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1241,10 +1241,11 @@ static int ip__fprintf_jump(uint64_t ip, struct b=
ranch_entry *en,
>         }
>
>         if (PRINT_FIELD(BRCNTR)) {
> -               unsigned int width =3D evsel__env(evsel)->br_cntr_width;
> -               unsigned int i =3D 0, j, num, mask =3D (1L << width) - 1;
>                 struct evsel *pos =3D evsel__leader(evsel);
> +               unsigned int i =3D 0, j, num, mask, width;
>
> +               perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &wid=
th);
> +               mask =3D (1L << width) - 1;
>                 printed +=3D fprintf(fp, "br_cntr: ");
>                 evlist__for_each_entry_from(evsel->evlist, pos) {
>                         if (!(pos->core.attr.branch_sample_type & PERF_SA=
MPLE_BRANCH_COUNTERS))
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 4990c70b1794..c6ebde9d40a8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -333,14 +333,15 @@ static int symbol__account_br_cntr(struct annotated=
_branch *branch,
>  {
>         unsigned int br_cntr_nr =3D evsel__leader(evsel)->br_cntr_nr;
>         unsigned int base =3D evsel__leader(evsel)->br_cntr_idx;
> -       unsigned int width =3D evsel__env(evsel)->br_cntr_width;
>         unsigned int off =3D offset * evsel->evlist->nr_br_cntr;
> -       unsigned int i, mask =3D (1L << width) - 1;
>         u64 *branch_br_cntr =3D branch->br_cntr;
> +       unsigned int i, mask, width;
>
>         if (!br_cntr || !branch_br_cntr)
>                 return 0;
>
> +       perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
> +       mask =3D (1L << width) - 1;
>         for (i =3D 0; i < br_cntr_nr; i++) {
>                 u64 cntr =3D (br_cntr >> i * width) & mask;
>
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index a459374d0a1a..1edbccfc3281 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -624,3 +624,18 @@ char *perf_env__find_pmu_cap(struct perf_env *env, c=
onst char *pmu_name,
>         free(cap_eq);
>         return NULL;
>  }
> +
> +void perf_env__find_br_cntr_info(struct perf_env *env,
> +                                unsigned int *nr,
> +                                unsigned int *width)
> +{
> +       if (nr) {
> +               *nr =3D env->cpu_pmu_caps ? env->br_cntr_nr :
> +                                         env->pmu_caps->br_cntr_nr;
> +       }
> +
> +       if (width) {
> +               *width =3D env->cpu_pmu_caps ? env->br_cntr_width :
> +                                            env->pmu_caps->br_cntr_width=
;
> +       }
> +}
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 2a2c37cc40b7..51b36c36019b 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -192,4 +192,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, co=
nst char *pmu_name,
>                              const char *cap);
>
>  bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_nam=
e);
> +void perf_env__find_br_cntr_info(struct perf_env *env,
> +                                unsigned int *nr,
> +                                unsigned int *width);
>  #endif /* __PERF_ENV_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b492300ec959..dbaf07bf6c5f 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -856,7 +856,6 @@ static void branch_stack__printf(struct perf_sample *=
sample,
>         struct branch_entry *entries =3D perf_sample__branch_entries(samp=
le);
>         bool callstack =3D evsel__has_branch_callstack(evsel);
>         u64 *branch_stack_cntr =3D sample->branch_stack_cntr;
> -       struct perf_env *env =3D evsel__env(evsel);
>         uint64_t i;
>
>         if (!callstack) {
> @@ -900,8 +899,11 @@ static void branch_stack__printf(struct perf_sample =
*sample,
>         }
>
>         if (branch_stack_cntr) {
> +               unsigned int br_cntr_width, br_cntr_nr;
> +
> +               perf_env__find_br_cntr_info(evsel__env(evsel), &br_cntr_n=
r, &br_cntr_width);
>                 printf("... branch stack counters: nr:%" PRIu64 " (counte=
r width: %u max counter nr:%u)\n",
> -                       sample->branch_stack->nr, env->br_cntr_width, env=
->br_cntr_nr);
> +                       sample->branch_stack->nr, br_cntr_width, br_cntr_=
nr);
>                 for (i =3D 0; i < sample->branch_stack->nr; i++)
>                         printf("..... %2"PRIu64": %016" PRIx64 "\n", i, b=
ranch_stack_cntr[i]);
>         }
> --
> 2.38.1
>

