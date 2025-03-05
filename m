Return-Path: <linux-kernel+bounces-547836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A5A50E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6B51890A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575C263C9B;
	Wed,  5 Mar 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aE0vshac"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9818E362
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211503; cv=none; b=ocqBie00bk+rRWz6SrGS+IztHyS+T/4OQ2Oi4kurKP5aIFKbuIpsq+Y4hiLmzJyKCLpoGe2tHFHfH5lpuydGES56u/JCIPOQVR6Y8Fr/NxICYxmkXfM1uKpMSchwl7SFIAcz2AO6NaNtv97L+RAT6ZCT17NSKeFXenE9anUTHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211503; c=relaxed/simple;
	bh=01ICYTbOUYDn5wacD9HW0N7glH6QXe/owYiBxke7rQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex/DijnxmrVHtWLGLSrDLSoq9cBfbqbN/4n1tbNYuGwPc2mSnIAjKDjL7GMOWpBXEaF52ZhgaS9wociGrvpBxS8wb378nyqVyY9fLvvWhXETzC7Us+NP425MRMvqmG2UenpapjZayLdMdGQgIoZZGiVD8tMpNLXUBubDr+yQBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aE0vshac; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2237a32c03aso14235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741211501; x=1741816301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZubhIIsYYqScJTvJQURQn+6RxrzfbODl6pGutz3Xj48=;
        b=aE0vshack+OWti2chQoWS0s/sN6oJtadp8U8Fa2uxq0j3kA9NCyzN+FRXb8xEYmaMp
         SZfXgtuoifKCfNkJZzYgidwFaDBVTgRe2w4zDtR8T5/HNlq0b3jsk3eXqe5BTY6Wg6xe
         5DGvT1TEee3XgE2HVrc4QAcxvmaY2B17NjNui988or0NRDw64Oq7GMjamsit/KWFlNMe
         pfavrT5h1kGUcI0ovoxzPcNgWHYfHz7ypKlCKqFLmZEmq2B7fB6aXLu9mlXBforcKQxh
         7zAUT2KhIGTFaDj4VEnsYXKg+Pfmckecf2GpC2ElIb6X4roJYZ0iVe7V9nZasj2YBUS9
         XMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211501; x=1741816301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZubhIIsYYqScJTvJQURQn+6RxrzfbODl6pGutz3Xj48=;
        b=UwrAXlKnmcUXGPBjHAmjTSMurYTuQH3W07MGs9ieN5pf16s58OkLwP1r6doqLXP4RJ
         ZZOTiIXv0w18vjADXr3f4S6FmrvVs2moItn9qhekYH/RGlJv+PMh6o1BoJHlUX+ZwVKN
         pl5IXsI84q0DCyw4kE6sjolcFH6zhGP+4VHzGUo+o9bM4ycHo2FV8qFg9CzsRNSHd08o
         VEyFLnNThYqcB2jUmCMl9vNAjND9E9cMiSensee3Twz68MeiDby2erYEPoyiy9ZdQCnW
         wdTP3XHqhL8KeP71qsIvZ+Qf1DHHOofH+QC4PKhVvpbTq/wUlpGxN0yUY3kf4JWPIQHa
         9XUg==
X-Forwarded-Encrypted: i=1; AJvYcCVESqvihgdZ4EkKPyMyAOAB9IccZyNhzead2Tw9+I4sVSb9Fe3NgNLtTKu98ItcG8LLhRxtoIvQq1L6824=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVFsF96lVsx8J18gdgA696J4F2kEkHJXjuJrACM/4oe+1I2AQ
	NSdzHDlHzkqXNnxjfetxiwfko4cz3ZJh0VZluBH9vCLdNc/Z3iqQr7vzcbmkWXcunGYotgN3/4T
	f4LcC+MRqMpfVLJUFnYpZBUj+Jn3zi+ciKHVj
X-Gm-Gg: ASbGncsKl4g1qWlIkEPwBThcWWxFi54rufJaGrLKWUgRGKfm6TfoCHyCuTrHkpwGkKT
	0poxcDomr9KC2b2PItBfroFoJe/EYASYjoQQ0Ycl8tFYPTQggqawPJH+pQF5SMins4eLOuVzBHF
	l/wPWB9e9aBMMhX0lnnaCRlhgSOIvr8rsCzdLQ/ghEixzjKpkZnMvJKXQ=
X-Google-Smtp-Source: AGHT+IG0QWHGCEKSo652tR8jBFYTbN6br3NuD7rA7VE5i5wP7NgDWYbmmxtWePY13JKMfkEgQeDEAP6YFTRzrKVgRkM=
X-Received: by 2002:a17:902:ce11:b0:220:c905:689f with SMTP id
 d9443c01a7336-2240e4b9e0bmr71965ad.25.1741211501245; Wed, 05 Mar 2025
 13:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org> <20250304-james-perf-hybrid-list-v1-3-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-3-a363ffac283c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 13:51:30 -0800
X-Gm-Features: AQ5f1JqgDsOK30L0KW1LWPPaexfr7jsty_EekjhIiXiL-unpHg1wxzWG5JGHsu0
Message-ID: <CAP-5=fVHE41=RuBf2fS6anTmNOy3DXZbUSw6p+SBaCM9oD-YOA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Don't deduplicate core PMUs when listing events
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Commit 7afbf90ea2e2 ("perf pmu: Don't de-duplicate core PMUs") fixed a
> display mismatch related to deduplication within a single PMU, but it
> didn't fix the case where deduplicated PMUs aren't listed at all.
>
> Fix it by using the same function which takes is_core into account,
> except in the use_core_pmus block where it's always going to be true.
> Before this change, -v would be required to get the same behavior for
> core PMUs. Now it's no longer required:
>
> Before:
>  $ perf list | grep br_indirect_spec -A 1
>  br_indirect_spec
>     [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a5=
3]
>
> After:
>  $ perf list | grep br_indirect_spec -A 2
>     [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a5=
3,
>      armv8_cortex_a57]
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/pmu.c  | 5 +++--
>  tools/perf/util/pmu.h  | 2 ++
>  tools/perf/util/pmus.c | 8 +++++---
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 57450c73fb63..caff0d309012 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -834,9 +834,10 @@ static int is_sysfs_pmu_core(const char *name)
>   *
>   * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are vi=
sible
>   */
> -static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const cha=
r *name,
> -                                  bool skip_duplicate_pmus)
> +size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name=
,
> +                           bool skip_duplicate_pmus)

nit: I think the name should be perf_pmu__deduped_name_len for
consistency with the other non-static functions.

>  {
> +       name =3D name ?: "";

nit: Should this just use pmu->name ?

>         return skip_duplicate_pmus && !pmu->is_core
>                 ? pmu_name_len_no_suffix(name)
>                 : strlen(name);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b93014cc3670..ce6a394a695d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -297,5 +297,7 @@ struct perf_pmu *perf_pmus__find_core_pmu(void);
>
>  const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)=
;
>  bool perf_pmu__is_fake(const struct perf_pmu *pmu);
> +size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name=
,
> +                           bool skip_duplicate_pmus);
>
>  #endif /* __PMU_H */
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index cb1b14ade25b..1acc27af4d02 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -358,12 +358,14 @@ static struct perf_pmu *perf_pmus__scan_skip_duplic=
ates(struct perf_pmu *pmu)
>         if (!pmu) {
>                 pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
>                 pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> -       } else
> -               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "");
> +       } else {
> +               last_pmu_name_len =3D pmu_deduped_name_len(pmu, pmu->name=
,
> +                                                        /*skip_duplicate=
_pmus=3D*/true);
> +       }
>
>         if (use_core_pmus) {
>                 list_for_each_entry_continue(pmu, &core_pmus, list) {
> -                       int pmu_name_len =3D pmu_name_len_no_suffix(pmu->=
name ?: "");
> +                       int pmu_name_len =3D strlen(pmu->name ?: "");
>
>                         if (last_pmu_name_len =3D=3D pmu_name_len &&
>                             !strncmp(last_pmu_name, pmu->name ?: "", pmu_=
name_len))

Can this code be removed given there shouldn't be core PMUs with
identical names? ie:
```
if (use_core_pmus) {
    list_for_each_entry_continue(pmu, &core_pmus, list)
        return pmu;

    pmu =3D NULL;
    pmu =3D list_prepare_entry(pmu, &other_pmus, list);
}
```

Thanks,
Ian

>
> --
> 2.34.1
>

