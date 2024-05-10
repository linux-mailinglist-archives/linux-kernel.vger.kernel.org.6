Return-Path: <linux-kernel+bounces-175310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875E8C1DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638D1C213B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8EF15D5BD;
	Fri, 10 May 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZQ91omp"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834771494DE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321815; cv=none; b=Rim6Gr3yKXzEfeOeSJAnO0dArATPYrS1QDpC3kqpfs48lrlzdEQiokghD5RB3kpqMSTJsr9j/hkcJsrsJ9351I8Xh27j+iaTmvg/4GR3W4uIaqipQXMT+oQsEclhob03QCCyHtlG9KJ/GYnn7LFZP0A3p4O1+/JpI11A7YNJ+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321815; c=relaxed/simple;
	bh=6feafTWRKD/pFfv6a7aXeKx22UNSWKArlBNWuqJ7QgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbb0V7bEEW1q+Qd8E1ddvbcB4BZsCerJe1t5nuqzUmeCskXSp0O1BQfCTgoTzCWIMQUeAfAKm53bhSoVQ4WjBCxo5ZSNbpb73xl547ECEY9NsJEekX6FqM02Gtao+RnnojTVIi/nPuG0gBwADTt3VcK2SOql3dDT3mfJjDwN1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ZQ91omp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43df9ac3ebcso193951cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715321812; x=1715926612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P013eBlgxlZ/UL/3+JN87mWVkNfsmaCM+AjZob2UWLs=;
        b=4ZQ91ompuwz0icugSg63hINIrh511TEMRTYeqxW/IVdOhuLI7HrgVTs0QH+Egx23qS
         v8d8up62e+FgUEtqBR3Ex17p1Q53CnB9RE+mEbCrQegUfgMaeVxs/KRv4kiJALiyU6rT
         Ss2UqUwet5nmTSCDk2M2oz3ootlGgZcjRtULAlzo0XcAQqfwb1JcJc5iAmIh9IQBkRKi
         D/9YoIbs38SwyNEIE0vrdPyIXHt0NNfzw/t2hlbkAxQsKPSTbz100HY5FfcKRF3mwGI6
         JbfudLTqFdroJ+QXdVbhDQeQxf+kFgGnL4MuTPrrdBQd33uI2N7iY3ain/kvnnl2BWbG
         RDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715321812; x=1715926612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P013eBlgxlZ/UL/3+JN87mWVkNfsmaCM+AjZob2UWLs=;
        b=EFyNbqAKJzG08EOTzerwU1PHnWbG+ifbxxf24RUFt5A2sLShi2wOkmaRWasUoE5xkZ
         rY9+u2kUkYzFtplKNNzvKMR4GU3ej/VqFCcRdvi6AXVmsQgS3/r4k/RmNUWRK+G9gfOz
         SmmWmTZ5kbK+iZEAodkl6yQf0a4opgHvZh4kGSejmyeTeze5jfyS340Vxbo3sTLX/Cyg
         dPxLMkEtZoIRPM/w8aUtePN9okHRK47K5snG/jQZ5PXJcHK6bpABXQU69MxonBGLDUMV
         rYPomFw+Zf98s70cWKqUFqs7UGJmF3BkhfNrqQ3weKXPlnFoaqpF51mOpNpDdjMTEKgo
         jjIA==
X-Forwarded-Encrypted: i=1; AJvYcCV1FJUFtDB2vNnMiSPrvCmRtYWHV3u027x15aWuerIbtL54U2cEX32cDq/no0PetiRCYX9ScPTKT3ZXauYxNPYX/BEV1/hwIcGW9ci2
X-Gm-Message-State: AOJu0YwipNBm4NCXodv55AX5rKJ/0g4B9u654nu9cGuV5/jnXO9IZw+0
	jKYRlN1wRabyBg9KWYu9sBUiufilwp1VUtBfse6hoHvt+wYTmCpXQKJxKe4ot3je4Z4uih4i78U
	FtO8yIViM/ChLSJ6EZ3fX4lDBURA6EYORNfOW
X-Google-Smtp-Source: AGHT+IFj8uz5shdiGB57AmNqO93sQ2qQyODvVTabB80D4SoJl0+JOBpTmDZ919M9UNY8Ync9DaLF5pxcLW3G9qyMVeo=
X-Received: by 2002:a05:622a:5292:b0:43a:bcee:eaa2 with SMTP id
 d75a77b69052e-43dfdce7f5dmr1976371cf.20.1715321812281; Thu, 09 May 2024
 23:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510024729.1075732-1-justin.he@arm.com> <20240510024729.1075732-3-justin.he@arm.com>
In-Reply-To: <20240510024729.1075732-3-justin.he@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 May 2024 23:16:40 -0700
Message-ID: <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf pmu: Fix num_events calculation
To: Jia He <justin.he@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:47=E2=80=AFPM Jia He <justin.he@arm.com> wrote:
>
> When pe is NULL in the function perf_pmu__new_alias(), the total number
> of events is added to loaded_json_aliases. However, if pmu->events_table
> is NULL and cpu_aliases_added is false, the calculation for the events
> number in perf_pmu__num_events() is incorrect.
>
> Then cause the error report after "perf list":
> Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//
>
> Fix it by adding loaded_json_aliases in the calculation under the
> mentioned conditions.
>
> Test it also with "perf bench internals pmu-scan" and there is no
> regression.
>
> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  tools/perf/util/pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a1eef7b2e389..a53224e2ce7e 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1639,6 +1639,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>                  nr +=3D pmu->loaded_json_aliases;
>         else if (pmu->events_table)
>                 nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) - pmu->loaded_json_aliases;
> +       else
> +               nr +=3D pmu->loaded_json_aliases;

Thanks for working on this! The "struct pmu_event *pe" in new_alias is
an entry from the json data, and "pmu->events_table" should NULL if
there is no json data. I believe the code is assuming that these lines
aren't necessary as it shouldn't be possible to load json data if the
json events table doesn't exist for the PMU - if there is no json data
then loaded_json_aliases should be 0 and no addition is necessary. I'm
wondering why this case isn't true for you.

Thanks,
Ian

>
>         return pmu->selectable ? nr + 1 : nr;
>  }
> --
> 2.34.1
>

