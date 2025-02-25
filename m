Return-Path: <linux-kernel+bounces-532054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49DA4483E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81C33AD790
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0E198A34;
	Tue, 25 Feb 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnZJ2oC8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350A198A29
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504156; cv=none; b=nJRhXirB4olg3i4io6HH63sSBmx68nqSjCdx7kabOeIVw7il6ke6g/W6GW++mRMQXZ90fcWxEf7+jo88o+4cjasz3ESRHabIPTlbOlTtwZVxqVowC7kcKhB6AiZrqtbZM6/TxufrSZSoksWnT+Oz1xayYStl58KOxu7d0YeVUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504156; c=relaxed/simple;
	bh=JIeUx3BzU/ZODIoOOD0QErBmHhS4E8HKerCMEOFrwTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz5G3PqY/TE10Vft55T0ND8iht7JUu1JCVs66gvlvS+xg242M4sfvYMDTqQjYgaSVUX+ewT95Qw26WJZyTo5+KxVRINFDFhWDmCVNESq7KMeS231B2UgjtuZ7eYNaMrcLe7jIklgyzcGWWLemlv1mG7mDVcYOooRJz0OS5QY2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnZJ2oC8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2212222d4cdso180535ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504153; x=1741108953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TdCf94j2D/GNCBrCR6raqdAGMckUm3M+L8hvmuyCBE=;
        b=QnZJ2oC8JfBvuM8M3H6hjyPh0xVybB9MYL4AN1MR1AnjOQaxDo2D1AhUnqvUmWpxeQ
         rSp4IeWT3ri/RemWC7bo4eLuCba0jDIOiBPA0NBfnkzsoTOLm2R9VPDZ+vDyMMD32mit
         NQB5ujBuYVnpVYv3JW1wLqRm/DLAKuiC1K4CppfsyzCjmjT9lLVQwGiiP/crttaOrW8C
         fgNMb1zfTJpNMHeuVGow7IGMGFKnxoVhUw0mdnxDdklHN585D4dP7oo3nAGgQ4UJMOLS
         IKBkjhmTa6MGIYQnUzaw0qjO2JvMVH9eQqUo3QMUowMc1YrnY5cg+OAP56fiVhIrgKix
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504153; x=1741108953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TdCf94j2D/GNCBrCR6raqdAGMckUm3M+L8hvmuyCBE=;
        b=MmYNnMMPtI+GK2TvntJ/XX8DczQdZKDxFATd4D4s6L5m3eIphHEjsl8dG+5nFKCDEe
         eecfYmy0OnpW8wGBYOqS0XcSe7tagehIGU1w60Diq89NSOlI57OVCpfhFJ1zLb7mp0Jl
         A6HVmYnCuICEAAlQMIXSGGVx4OHDdzhgqN4dAqmKUektFh6sh1OaqOhYN/IHGgvAMocg
         +J4Fy+yqcarVFDudC/oEeUw06hGJX/KgFaFJXDXGlRylJqK0/UTptJlyVCDbt8rD+pXM
         zS91QK1KuclCysBwEziIzr3a9sJC3fHLpspq7OtCK/LoxuQ9jJGF10rkUvURFbRcHeGW
         MH4A==
X-Forwarded-Encrypted: i=1; AJvYcCXE8PGqDaIuV7Hh0bxD9jHzp+cBVyPNRj2P3AWi33BFTiQYmDLDp0Qlfsf7QlmA4NmWjqWY13yU6p1SQCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTld35FVLbRQ7XWwzukyrztYqFuIvCT1JvvwoK6BdV+UENXZl
	/GrXHfrhQcR1V3Rlekw/29aOLfaB/dVKEkXisx4fOhHqWgdQnv6hPEYP4TAwof54JnMyosDuOI6
	pLMVv7aqxnsuf2kq5ursYB/U3sO6qCgJX+paG
X-Gm-Gg: ASbGncu7SLFE4zKqjv900+Y8/k5CbFcea1dVc1+oaeFdrYg/1sjau5XsCfmreTc7bpS
	FV7VumdaWjtofIJGEE36OS0sxlvXHNF6XDCSvU2Ga7kNgXcVvEHAG8d8QOTR/rM3He9Rs6Gkuho
	fk5s9RyelyafMg9MHMMR6iEydfIED3fKDKoD8=
X-Google-Smtp-Source: AGHT+IEAWZUpS8aee2ncOiylaN+UB5bleg1SLRMJy/O3MuWwMZoGo+SH1x8VOaEPbNFK605vxNGCxIxEuBp1Uswegjc=
X-Received: by 2002:a17:902:d581:b0:220:c905:689f with SMTP id
 d9443c01a7336-22307aab530mr3663625ad.25.1740504153005; Tue, 25 Feb 2025
 09:22:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225164639.522741-1-james.clark@linaro.org> <20250225164639.522741-3-james.clark@linaro.org>
In-Reply-To: <20250225164639.522741-3-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 09:22:22 -0800
X-Gm-Features: AWEUYZnqRks2gG_y3jE5Euy-VLrRzoZfY0UmvtNSXU4Kcowi0S3jplVfiIhrMLc
Message-ID: <CAP-5=fVKX6029y9W8JCw-kjMuL9O5z0Ut2LDUhz=Ske3Qg7vDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf pmu: Don't double count common sysfs and json events
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> After pmu_add_cpu_aliases() is called, perf_pmu__num_events() returns an
> incorrect value that double counts common events and doesn't match the
> actual count of events in the alias list. This is because after
> 'cpu_aliases_added =3D=3D true', the number of events returned is
> 'sysfs_aliases + cpu_json_aliases'. But when adding 'case
> EVENT_SRC_SYSFS' events, 'sysfs_aliases' and 'cpu_json_aliases' are both
> incremented together, failing to account that these ones overlap and
> only add a single item to the list. Fix it by adding another counter for
> overlapping events which doesn't influence 'cpu_json_aliases'.
>
> There doesn't seem to be a current issue because it's used in perf list
> before pmu_add_cpu_aliases() so the correct value is returned. Other
> uses in tests may also miss it for other reasons like only looking at
> uncore events. However it's marked as a fixes commit in case any new fix
> with new uses of perf_pmu__num_events() is backported.
>
> Fixes: d9c5f5f94c2d ("perf pmu: Count sys and cpuid JSON events separatel=
y")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 7 ++++---
>  tools/perf/util/pmu.h | 5 +++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ec3878c890a9..72aa6167c090 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -596,7 +596,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, =
const char *name,
>                         };
>                         if (pmu_events_table__find_event(pmu->events_tabl=
e, pmu, name,
>                                                          update_alias, &d=
ata) =3D=3D 0)
> -                               pmu->cpu_json_aliases++;
> +                               pmu->cpu_common_json_aliases++;
>                 }
>                 pmu->sysfs_aliases++;
>                 break;
> @@ -1884,9 +1884,10 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>         if (pmu->cpu_aliases_added)
>                  nr +=3D pmu->cpu_json_aliases;
>         else if (pmu->events_table)
> -               nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) - pmu->cpu_json_aliases;
> +               nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) -
> +                       pmu->cpu_common_json_aliases;
>         else
> -               assert(pmu->cpu_json_aliases =3D=3D 0);
> +               assert(pmu->cpu_json_aliases =3D=3D 0 && pmu->cpu_common_=
json_aliases =3D=3D 0);
>
>         if (perf_pmu__is_tool(pmu))
>                 nr -=3D tool_pmu__num_skip_events();
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index f5306428c03f..b93014cc3670 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -136,6 +136,11 @@ struct perf_pmu {
>         uint32_t cpu_json_aliases;
>         /** @sys_json_aliases: Number of json event aliases loaded matchi=
ng the PMU's identifier. */
>         uint32_t sys_json_aliases;
> +       /**
> +        * @cpu_common_json_aliases: Number of json events that overlappe=
d with sysfs when
> +        * loading all sysfs events.
> +        */
> +       uint32_t cpu_common_json_aliases;
>         /** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
>         bool sysfs_aliases_loaded;
>         /**
> --
> 2.34.1
>

