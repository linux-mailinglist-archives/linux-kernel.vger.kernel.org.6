Return-Path: <linux-kernel+bounces-555309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E6A5B57C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E9F1883FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2D79EA;
	Tue, 11 Mar 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npmzZEd/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E81E511
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654202; cv=none; b=KgBqcWNrouR75/1UjqC+6yIaEwFG+aoUV0mk+MDwCAIlbs0iuLzAXUjtxW1K9PMsCv6OAUYCGT0g2n5tCCZzQgcRPuN/SIyOpcsPaTP7UXoa3qtZJeD6hzf5Noc9s/jd4VI/EWmnRkrg2vd7Z32/iJO9ueeheoIWfpVKYW2kDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654202; c=relaxed/simple;
	bh=WtPsxI1mF4Fib2DjqG5aZoiAI/3+o8KEkEiK2O4adpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKnOnvTohjmg1FRHNRTfw+jCqY1ItpkKjo1hfJXoxMwIT6HbMgKHdMOBKRtfJnoM82uFQT3XWS9wgkLvvY80Oaez+HqcGAHc1JulID5W5H6fEkYQN8FKJx2D2LJgicn4lR9JYmK+sIC/SPxhQ4KGfKwRg7igf7t7BjtyLNMqbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npmzZEd/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242aca53efso45855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741654200; x=1742259000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UG8l3rw6w9CG+I5rCOCbRTQtWDKiaYPahM4qkw1drI=;
        b=npmzZEd/Dx18md7aAbJWfRUXMtI2YnsGbFy/brZ3M8yS3Kxz7go38yCEQF1lvi+lJd
         Q0Ky6XFEuzbEwOf1YGNB0BEjFX2QOMtBaF2OTmEmZ4ZpIwXHoCZ9Q5Ymr966DQAB1z5T
         xq4aOTt4+lnOEP+/M3I+r/rgz6ptQ8ro2prlIjJnT6Qn/ZUHd7j2xrUro5ebknSDGOOP
         FukWxjOiog+Np5S8Ae3j8lu53OJ1Sg5D4kDHFQR4BgYJBABbpVJYNwP+xSOmJgQTnvdg
         odMZoDvpuzAUvsiae4VJj2QnUt20N2RtcMXyUbvpKTOPO+DIVp5E23wZMn829dmQalFV
         yW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654200; x=1742259000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UG8l3rw6w9CG+I5rCOCbRTQtWDKiaYPahM4qkw1drI=;
        b=X397FlKotY83xU8NQeEQNMufHDMRdrmfOO8J2if5dn6QBGf9N1plAxCg19oH89eHPC
         mJodRXDF1zJC7GYH2rxbpwF9c3iDzKmV4gFqLoBxw5V/IUqRZUqBILUXncl9OvjGdVEj
         e3BUkRz7BrQIvh4e7FtbCk878J8SC8cSVIkn+i+EKDEVRH33Z7JjdX76gpIrNXJSXq5D
         HHOv/GIw8vx9rLgbZxQuxYiRbb1ZwCr+CbHL8wBne2LFc90Xp+1RNwvyr3WXsADt6Iv9
         43ZeEiI9al3JT8q7DeQt+/bDH+m2mfOOfpbXAiDH76sr5GhePy6cDl6Io4LXOvJh4TGA
         yAPw==
X-Forwarded-Encrypted: i=1; AJvYcCXoZs5Gr4oLPPXEbZ/yOhvrXqos2+w/o5FMjVuePjNCnfbLLoeHWtn/hznuuAVx5kLEXDV9U8UF5cF86bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rbayxqNwAiQiAB6+XECj/3VBFGhjlT1v4ANWXLK+7U2oWiwW
	4/4eRswkrWSrXz/j81JSho1i6OnYKTjPuIrlgApHovEpF+CrX7HmuvuDeC6jl+LQwdoHsccK4QB
	rXaw0ANBBojexLSWmdOqyKC25KTkqxFSiYc5X2pqELI52iwHPquA0
X-Gm-Gg: ASbGncsZL3cKkk/UlLEOEMF9Yz6CmHv01vfms3gTnPOrB3Flni07rSbw6DXoe8wta+R
	R/3WQBQpbpBqFKUpW7tP6taVN1CN4uMaaQ5wBAgTb+V5h+Cfj7FGSxsZLKWx5ZVrSliOirApcrt
	pXzB56kf4N9aE1nD/G/i0V3apHk1E=
X-Google-Smtp-Source: AGHT+IGUkygBX681xnbfirGOTjQluV+0g5jegoBPrwfvr9MndofFJ0GXNxXRPycRCA3k/vgWPNtPC+irlc8ALtVcmqk=
X-Received: by 2002:a17:902:e801:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-225416231b2mr6556665ad.14.1741654200354; Mon, 10 Mar 2025
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311000416.817631-1-namhyung@kernel.org>
In-Reply-To: <20250311000416.817631-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 17:49:48 -0700
X-Gm-Features: AQ5f1Jq8mMPoQKD-wR3efNTTSPJME4zCkdfDivNpUiKdeNqml3I0fbO2xhFEuO0
Message-ID: <CAP-5=fWSU8m1eae=5GFTpVTz1CPtwv=eDmivT1v14VjT40SptA@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix a memory leak for perf_env on AMD
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The env.pmu_mapping can be leaked when it reads data from a pipe on AMD.
> For a pipe data, it reads the header data including pmu_mapping from
> PERF_RECORD_HEADER_FEATURE runtime.  But it's already set in:
>
>   perf_session__new()
>     __perf_session__new()
>       evlist__init_trace_event_sample_raw()
>         evlist__has_amd_ibs()
>           perf_env__nr_pmu_mappings()
>
> Then it'll overwrite that when it processes the HEADER_FEATURE record.
> Here's a report from address sanitizer.
>
>   Direct leak of 2689 byte(s) in 1 object(s) allocated from:
>     #0 0x7fed8f814596 in realloc ../../../../src/libsanitizer/lsan/lsan_i=
nterceptors.cpp:98
>     #1 0x5595a7d416b1 in strbuf_grow util/strbuf.c:64
>     #2 0x5595a7d414ef in strbuf_init util/strbuf.c:25
>     #3 0x5595a7d0f4b7 in perf_env__read_pmu_mappings util/env.c:362
>     #4 0x5595a7d12ab7 in perf_env__nr_pmu_mappings util/env.c:517
>     #5 0x5595a7d89d2f in evlist__has_amd_ibs util/amd-sample-raw.c:315
>     #6 0x5595a7d87fb2 in evlist__init_trace_event_sample_raw util/sample-=
raw.c:23
>     #7 0x5595a7d7f893 in __perf_session__new util/session.c:179
>     #8 0x5595a7b79572 in perf_session__new util/session.h:115
>     #9 0x5595a7b7e9dc in cmd_report builtin-report.c:1603
>     #10 0x5595a7c019eb in run_builtin perf.c:351
>     #11 0x5595a7c01c92 in handle_internal_command perf.c:404
>     #12 0x5595a7c01deb in run_argv perf.c:448
>     #13 0x5595a7c02134 in main perf.c:556
>     #14 0x7fed85833d67 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
>
> Let's free the existing pmu_mapping data if any.

Can we simplify `evlist__has_amd_ibs` as there seems no reason to be
creating/parsing strings. For example:
```
bool evlist__has_amd_ibs(struct evlist *evlist)
{
   return perf_pmus__find("ibs_op") !=3D NULL ||
perf_pmus__find("ibs_fetch") !=3D NULL;
}
```

Similarly the variables `ibs_fetch_type` and `ibs_op_type` can be
found with `perf_pmus__find("ibs_op")->type` and
`perf_pmus__find("ibs_op")->type` respectively. It probably makes more
sense to just cache access to the PMUs rather than do the finds all
the time.

I wonder there is a problem with the pmus alternative that currently
the pmus are global and not part of say the session, not loaded from
the perf.data file, etc. So use on a different machine than the
recording could be broken by what I suggest. I guess then, just
throwing in the free is simplest.

Thanks,
Ian



> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/header.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 1900965f87527948..e3cdc3b7b4ab2409 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2770,6 +2770,8 @@ static int process_pmu_mappings(struct feat_fd *ff,=
 void *data __maybe_unused)
>                 free(name);
>                 pmu_num--;
>         }
> +       /* AMD may set it by evlist__has_amd_ibs() from perf_session__new=
() */
> +       free(ff->ph->env.pmu_mappings);
>         ff->ph->env.pmu_mappings =3D strbuf_detach(&sb, NULL);
>         return 0;
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

