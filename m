Return-Path: <linux-kernel+bounces-346462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C698C4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138D21F243B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924A1BBBC6;
	Tue,  1 Oct 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9UcUi01"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC201CBE8C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805634; cv=none; b=JRglKdNWNHo4YlWhH6FpTquDWYZVwqTEqAVfAUziI2jwlA0ZMx0jDIN+9qubbx8/CdREvY0mbsA+7lhMQxRztMg7V7JRmpZUoWLiC7lZRr0elziYLO8wqLkMWAMTYipfAnFqIciBcRF5mtqLjmhl6ci19rv4DJbj5wzJKqWP57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805634; c=relaxed/simple;
	bh=CBFM2K7Kx/1qBuWYdhmwgDhD6W3f6SltNkqJf4C8ebk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4U/tFl+ltMh3kw9Vc7WdNvJ+on0DhhFHwe8KtKT4pT8wWgZ0pNUTjNQa751Rvb8Ygq/n1/wVT5Qio3EAN7q3QmnRdjdBgtnxflBKsQNPlEchr631bxpSgagiuko2CEoTXP9worUfY58vLgkcw3cKam4u90gDOTFPpe1ihW4NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9UcUi01; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b40c7fd8eso20375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805632; x=1728410432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QAEmq9EJlzXZlTRPN3SJ5o1ctP9AyWIel8Q5sjMQRg=;
        b=S9UcUi01b0bJuy3IL3nEtH817jUcVlA+qG6Is6BWuyx7ADYnxKx0O9NutvSQjPyo4T
         tUyYj47aQptHNu1wt7ZQyFCov69OvUxpy+kftDumaZu/lqQOc6gVqnrOj/XTl5tvMek/
         Ncw0pzOMRhALgVuullObXIc5xFsu519yZmP/CfNywFOw1vKCHLwDhmFXpSy3C8jYRdTH
         FyWGAczavVFopLWwP9Zg2KAZ376kVbQWf9hMBfiA+ibPLNYB0rIwouBWti4RF5iwUT+e
         zNThJlf50Lpqj8miJLhflKn/HdK2CE5n6MpHIqAbMJAoAgzBABaVERL56eRSOG0oyuVY
         jZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805632; x=1728410432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QAEmq9EJlzXZlTRPN3SJ5o1ctP9AyWIel8Q5sjMQRg=;
        b=ceOPqQ1ffJYMu7fWx6G8NjGnHQXs+ZpWyUWgYDn1U3aq68L6YcnayXVab9kvyYuFw5
         rHjkjgXlpOmI2GcgGzxKbd8sGi4S3rndEY4QC5B4ElkVQaaiDy/Mk5e5PdGj5YMZiAlI
         SKxWoskqCGu0cLHi3d98LKLYaIdU8UokDzRCBTxTfk93HHPDInFYwdVoyuZZ/iSLflHp
         IJSA+nNyFBJqnpWkSqSuYELYv+MWyS5HzH7gz+5qojXM0C/8ugu7+EiOPnuX+Np7+10Q
         1yUyWgsV6rmqafrJNVfmSdhm5Y+dqnZ6GSYn+YAHh8/gAAE/MmnxDMOgC3XqQpkyPH9S
         vPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOK34l8E2W6MqI7y9t/mU7dwT6JALAwcl2Yv74t3NiWFBhuNNVop6V+RVQHi8ZK+rDfjcN+1Z302BcQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRBMLdrE1685UJg9pX/p/5aWX4cP7MGgizTyztccF61hP8lNd
	DjVrShJhbWYYH1LfyBPxng7tvQv2yDq2qo2oBXY9LazrQ36gVP1hlkq7FtdQzaOrYgeZRECg6K7
	bHrRG+XSWtqHLhV3bxU8QY8R2YjruSHAJwUwr
X-Google-Smtp-Source: AGHT+IHCMSjbj9KUVdVfzdQG1WHelyAxaRGmyvMSUSBU3PEtdfwkQYNy7KSIKNkUYAE1Lvyk6UkWuY9unRH4gF3Bhaw=
X-Received: by 2002:a17:902:f685:b0:205:3bdb:5515 with SMTP id
 d9443c01a7336-20bc6a8f40emr164815ad.4.1727805632200; Tue, 01 Oct 2024
 11:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-8-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-8-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 11:00:20 -0700
Message-ID: <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
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

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The perf_event_open might fail due to various reasons, so blindly
> reducing precise_ip level might not be the best way to deal with it.
>
> It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> given precise level.  Let's try again with the correct error code.
>
> This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> user events with exclude_kernel=3D1 cannot make progress.  Let's add the
> evsel__handle_error_quirks() to this case specially.  I plan to work on
> the kernel side to improve this situation but it'd still need some
> special handling for IBS.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 32e30c293d0c6198..ef8356260eea54cd 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel)
>         return false;
>  }
>
> +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> +{
> +       /* AMD IBS doesn't support exclude_kernel, forward it to core PMU=
 */

Should the quirk handling be specific to evsels with the IBS PMU given
the comment above? ie this is a PMU specific workaround rather than an
AMD specific workaround, however, the PMU only exists on AMD :-)

> +       if (error =3D=3D -EINVAL && evsel->precise_max && evsel->core.att=
r.precise_ip &&
> +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {

So here rather than x86__is_amd_cpu it would be
!strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
the logic into pmu.c.

Thanks,
Ian


> +               evsel->core.attr.precise_ip =3D 0;
> +               pr_debug2_peo("removing precise_ip on AMD\n");
> +               display_attr(&evsel->core.attr);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
>                 struct perf_thread_map *threads,
>                 int start_cpu_map_idx, int end_cpu_map_idx)
> @@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
>         return 0;
>
>  try_fallback:
> -       if (evsel__precise_ip_fallback(evsel))
> -               goto retry_open;
> -
>         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
>                                          idx, threads, thread, err)) {
>                 /* We just removed 1 thread, so lower the upper nthreads =
limit. */
> @@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *evsel, s=
truct perf_cpu_map *cpus,
>         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rlimit))
>                 goto retry_open;
>
> -       if (err !=3D -EINVAL || idx > 0 || thread > 0)
> -               goto out_close;
> +       if (err =3D=3D -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> +               goto retry_open;
>
> -       if (evsel__detect_missing_features(evsel))
> +       if (err =3D=3D -EINVAL && evsel__detect_missing_features(evsel))
>                 goto fallback_missing_features;
> +
> +       if (evsel__handle_error_quirks(evsel, err))
> +               goto retry_open;
> +
>  out_close:
>         if (err)
>                 threads->err_thread =3D thread;
> --
> 2.46.1.824.gd892dcdcdd-goog
>

