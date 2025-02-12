Return-Path: <linux-kernel+bounces-511657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A8A32DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46795169BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875E25D52F;
	Wed, 12 Feb 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGOSbwVD"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A625D52E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382500; cv=none; b=oIHz20DPzI0k79PcGXN8AYv/l78ca/s82ApIhYKrOCTkFLbFpbldJSTrXmz4eSCN38PbL4n1HMi/7j6JWZTzUHKHaaE27gWC7lKVj0Y/5aD4WAbpkXtW0H9vD7JQW2oddKBTwonAQaGyCNsSWsmS8K1JbZdrpImg/NPxKFlLc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382500; c=relaxed/simple;
	bh=L0jdKS1YiQB1xypxo06sYem+JAjwxJlfR149uzO62Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtLyp+qxsWXRlXLzqBTiwb6fLNi+EdoNY1BLXxJ7bENHoMuhxMEL0sinh4Kh4DhYy2M5fKAg9I/uo8Xu0pISbmGl+c9XtVlndcIJZMgnJJ8HNUEKIf5OMeNFP0f3OndGtrdu1z+6sLo8BymOzU3iFUS93T6+PWQNokF9HDrS4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGOSbwVD; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so11485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739382496; x=1739987296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt7D4r1xEvWIWLzWgdvMdCOaHSAzfJA8cSi5o7NwZf8=;
        b=jGOSbwVDFPBqmhS1Q4xZ+WBjPh+YvXXBVlC7RhJP909M6HoFsATuF6RV+retJ1WI5x
         ny93qD66kfer11j6B/do4RQabZ78RIMvyreHmoZSZaLzk0AYmbS3BmeQj/Xsc6e92+n1
         /FL+zQUO6EzFfRXVWfFkUbUDlYUQcTvq+LlZVHL1398zRmpd8f4EtX6ixoGKPkS1V43q
         DOh85/fMV+ciGeHWiV3bPBVJLXvTTjuGYo/mLnnnO7v1svRaokGEJiUdJDFh/P810fZ1
         v1rKaBYFqdwilq+8cwFocBfWbkufDp+yJSX/ZMijeKjjJezxFZVrsLc7pdoLdSpW1IVT
         +c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382496; x=1739987296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt7D4r1xEvWIWLzWgdvMdCOaHSAzfJA8cSi5o7NwZf8=;
        b=Yx73x5F8ytEGvFAkGItgycVoKJknGE68r6i5jFxjryjvxV6y/VacDx5dFMlY2GQ1jN
         34+Q2pqCxbnKmBRU1vA9pxlEAHA8gfj66xEgYRAqCwLLyBxt5AORDqxKcELqYItmdE7t
         IPyObAuu50nk5tv5lxAJnop8fUi3O43JrWsq7r/IM7bgqaJe7Qc2nonYe3AZt1litr7R
         ou9BduxIMX4ssJbAi+/pcaKRl4JewK/tAkCRfhzpPxPcxGgo94XhQe+W03aEG1uBgyiD
         kmwOdVeB0jNrrM8p68zgp2CovXR7WAWE4bNi0Ab3iwc8+1lofrj67DpcoGxT2sbPVu8n
         lDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8CXptzMZsFev8j/onfHZEnZJsvrFbusYzHUyKfL44ciCV9cSHSNaRIT8DDLjl5HyicQOz75gX3R3UWFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFDt/uS/wUv27MMpQTEeNyiwHqK763nR4YVL7CQysLzpVcKng
	5n8bMaHyhBs705SxzAKzfo45uTmcAFQfp6pTtMWyXmA+/6aMytornKYvFV18r8HFctCtImwdkNS
	niZfZfapw9q18Qhx1jdq6IPFCgmmlb5JDjS77
X-Gm-Gg: ASbGncsVWZhMKS3OLjjrojTDa7dPox8/QI3P0R/G95Fcai4zkBDB1Vw/XxZcKx1vb1P
	mz+iVSEkrBCSxMiiNhRTx3v3rSsJ5iSeipudGBzlACzkQsJ8inx6aEeUIc0k1yrc8MOorOVYq1h
	Q1ZVWhtKqSUbPmIUYf41Psz21P
X-Google-Smtp-Source: AGHT+IH9RKm27XQbmHh58Pz+JCF0bZ7NSN+BmwBjNae4zPcqJENouojrXcqIdDizAMwgnFBU+h3t7OTAv2/bkF7zBKQ=
X-Received: by 2002:a05:6e02:1388:b0:3d0:55b1:44fd with SMTP id
 e9e14a558f8ab-3d17cdf5082mr4193115ab.20.1739382496456; Wed, 12 Feb 2025
 09:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212122413.1184503-1-james.clark@linaro.org>
In-Reply-To: <20250212122413.1184503-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 09:48:05 -0800
X-Gm-Features: AWEUYZnS5MVynzktqK-HyVROJHhiEXTDykfpawL-S_AXrMzRAvSLdhv-ssUJVoU
Message-ID: <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Legacy hybrid events have attr.type =3D=3D PERF_TYPE_HARDWARE, so they lo=
ok
> like plain legacy events if we only look at attr.type. But legacy events
> should still be uniquified if they were opened on a non-legacy PMU.
> Previously we looked at the PMU type to determine legacy vs hybrid
> events here so revert this particular check to how it was before the
> linked fixes commit.
>
> counter->pmu doesn't need to be null checked twice, in fact it is
> required for any kind of uniquification so make that a separate check.
>
> This restores PMU names on hybrid systems and also changes "perf stat
> metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
> test was gated on "cycles" appearing alone which doesn't happen on
> here.
>
> Before:
>
>   $ perf stat -- true
>   ...
>      <not counted>      instructions:u                           (0.00%)
>            162,536      instructions:u            # 0.58  insn per cycle
>   ...
>
> After:
>
>  $ perf stat -- true
>  ...
>      <not counted>      cpu_atom/instructions/u                  (0.00%)
>            162,541      cpu_core/instructions/u   # 0.62  insn per cycle
>  ...
>
> Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/stat-display.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index e65c7e9f15d1..eae34ba95f59 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evse=
l *counter, const struct perf_s
>                 return;
>         }
>
> -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.att=
r.type !=3D PERF_TYPE_RAW) {
> +       if (!counter->pmu) {

Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
things like this. I'm uncomfortable using an evsel having/not-having a
PMU as an indication of whether uniquification is necessary. It is
kind of a side-effect of parsing whether the PMU variable is non-NULL,
it'd kind of be nice to stop things using `evsel->pmu` directly and
switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
events will get the core PMU, a tracepoint PMU, etc. so we'd never
expect this variable to be NULL.

Your commit message gives me enough to think about what the issue is,
so let me give it some thought.

Thanks!
Ian

> +               /* evsel__uniquify_counter() uses counter->pmu for the na=
me */
> +               return;
> +       }
> +
> +       if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type !=3D=
 PERF_TYPE_RAW) {
>                 /* Legacy event, don't uniquify. */
>                 return;
>         }
>
> -       if (counter->pmu && counter->pmu->is_core &&
> +       if (counter->pmu->is_core &&
>             counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX) {
>                 /* A sysfs or json event replacing a legacy event, don't =
uniquify. */
>                 return;
> --
> 2.34.1
>

