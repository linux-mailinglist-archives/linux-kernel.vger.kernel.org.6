Return-Path: <linux-kernel+bounces-346450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05498C4DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D7A1F245F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8F1CCEEC;
	Tue,  1 Oct 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bffRVUGn"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE91CCEC3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805197; cv=none; b=birqKK0bfsfBPM3Vub1WpEWBeJICmfroEThz26px3qXIE/6i9ra4hXqcq2CFzkGDRJwtnBY5Gm8RvLGUpQR9kr40/sh3r86Gz9X+uu5QZoX7lLBc1JP8h93BsxU19fEGYD1f7QzFkWcOvfYtroVPxxYQVMxkoRPf0oxyNt0MMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805197; c=relaxed/simple;
	bh=HvfV771p9SpNflU09QJhrpVjpuEOOILdsvGW+K/26kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCVXWmb+a0H6tgbOO+PvbNqV55VreZSxZq9QjSsBmrtNrGsqrUYHMnYekyau274kIB9gJyuzqmJPpWG0Z3hJMsIxYE3biCQFVJkTHjrEFTaPFdu88cS2l8bnuSyQA++hn6GzxyL8RApsL6dqmgYB+JNS8ktANTNamhdcda6moZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bffRVUGn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b061b7299so15215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805194; x=1728409994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zNZIvgOTzPRRkE0xHkf+iIBsdvuygvhCHoCihiVvDQ=;
        b=bffRVUGnu9XBnmebnFujBoEqHbZHp4rNsGllaCKwrw2FlzVtncUYJCehHtKb1h1bmQ
         C4lcUXvT6pJVJOVcMazH7Wud1hFpocscz5kk2FueMTpfKBogGyL6Y88yKtV0p58swNE7
         6SBs+pVV0OfueZvw+Eu6xdCQAiebyVw6wgPq7q6Fv6mBmBnDdKhdN4WZMGZ/XalH95jM
         VvdeT/bCmLh/nOl+uJHkeFS5gp6Z+0Gii23hJ+JxzVcIQmD3eYGFERYOR2PW6CPMDYgZ
         bdtJPlFkCEhPYpBtHo+T12rVJ60IkQ8wGPrtvGO59f9EhCbtAo5mwffvDSb+3exxILv7
         8Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805194; x=1728409994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zNZIvgOTzPRRkE0xHkf+iIBsdvuygvhCHoCihiVvDQ=;
        b=fvduE/YJ9+G2T9QMCaKb8OF19oVBtPBwfrwnkg8TeAVpiS792eUNPxm4f3wQbop5K6
         qh7Nbsv/aEpL38IvvkNQLfh56md8vjexsjvVXMhmiCLaGjhOGCh652wJfx6fgJldsGq1
         76/DHPKGjKxpmF9OwHJeqWBYMKsrxziIkS34x7s3Fa9CPVBGJqDM5u0clXZy8y/YGNj2
         eihCsW1s9UtFQjXa9aNcRUI267KsisjI6/lY4O7EbPSSZLG2/tlyHMdZdjIEOHNFtp25
         zioq1L8gwHRcWUXYKAbNTc/K1zIQ3CaKN+sjaG5OBgfZFcbhn+UXdQ5e2boCWZuu+XJL
         6ktg==
X-Forwarded-Encrypted: i=1; AJvYcCWPESwXBHHcO2iKL2EkHuaSx7ECuKcUd1yy/lnck2WhIQhJhgSlIePTxiLc3gSOV6gsUDZziPcUc1qxX3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ku6RNS9n2CbJzAmcqKO+LWcpnPzmT0XXx2ewJTtqyFvzmIjz
	OzK23o6DE1xL5Pqoa1+aMiFcH0M+FdkVthbq/LPREFB5XTleGgv5++GhrJ/KyB+CWDjR9IvSKKF
	uNoaIAJ29ZlgsUl9enwu1gJqMC2NC/0USivlO
X-Google-Smtp-Source: AGHT+IEkBrCYCuLdrIIq5ZQzTMx0neZL5kEzphJLAuy0GHHfBFt/UZkxMJN5P8NSMU4spMfr408T8O+Ak8Z6ZiprWMU=
X-Received: by 2002:a17:902:ecce:b0:205:8ceb:79a7 with SMTP id
 d9443c01a7336-20bc6fc62b2mr20725ad.23.1727805194079; Tue, 01 Oct 2024
 10:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-6-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:53:02 -0700
Message-ID: <CAP-5=fVrptOSOK+sBo0rHR1QWQ0i1WigMaFRy=So-HATKr=R9A@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf tools: Detect missing kernel features properly
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
> The evsel__detect_missing_features() is to check if the attributes of
> the evsel is supported or not.  But it checks the attribute based on the
> given evsel, it might miss something if the attr doesn't have the bit or
> give incorrect results if the event is special.
>
> Also it maintains the order of the feature that was added to the kernel
> which means it can assume older features should be supported once it
> detects the current feature is working.  To minimized the confusion and
> to accurately check the kernel features, I think it's better to use a
> software event and go through all the features at once.
>
> Also make the function static since it's only used in evsel.c.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 345 +++++++++++++++++++++++++++++-----------
>  tools/perf/util/evsel.h |   1 -
>  2 files changed, 249 insertions(+), 97 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f202d28147d62a44..32e30c293d0c6198 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -20,6 +20,7 @@
>  #include <linux/zalloc.h>
>  #include <sys/ioctl.h>
>  #include <sys/resource.h>
> +#include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <dirent.h>
>  #include <stdlib.h>
> @@ -2150,120 +2151,272 @@ int evsel__prepare_open(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>         return err;
>  }
>
> -bool evsel__detect_missing_features(struct evsel *evsel)
> +static bool has_attr_feature(struct perf_event_attr *attr, unsigned long=
 flags)
>  {
> +       int fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*cpu=
=3D*/-1,
> +                        /*group_fd=3D*/-1, flags);
> +       close(fd);
> +
> +       if (fd < 0) {
> +               attr->exclude_kernel =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       if (fd < 0) {
> +               attr->exclude_hv =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       if (fd < 0) {
> +               attr->exclude_guest =3D 1;
> +
> +               fd =3D syscall(SYS_perf_event_open, attr, /*pid=3D*/0, /*=
cpu=3D*/-1,
> +                            /*group_fd=3D*/-1, flags);
> +               close(fd);
> +       }
> +
> +       attr->exclude_kernel =3D 0;
> +       attr->exclude_guest =3D 0;
> +       attr->exclude_hv =3D 0;
> +
> +       return fd >=3D 0;
> +}
> +
> +static void evsel__detect_missing_brstack_features(struct evsel *evsel)

In the future could other PMU specific unsupported features be added
not just brstack? Perhaps evsel__detect_missing_pmu_features would
better capture that.

> +{
> +       static bool detection_done =3D false;
> +       struct perf_event_attr attr =3D {
> +               .type =3D evsel->core.attr.type,
> +               .config =3D evsel->core.attr.config,
> +               .disabled =3D 1,
> +               .sample_type =3D PERF_SAMPLE_BRANCH_STACK,
> +               .sample_period =3D 1000,
> +       };
> +       int old_errno;
> +
> +       if (detection_done)
> +               return;
> +
> +       old_errno =3D errno;
> +
>         /*
>          * Must probe features in the order they were added to the
> -        * perf_event_attr interface.
> +        * perf_event_attr interface.  These are PMU specific limitation
> +        * so we can detect with the given hardware event and stop on the
> +        * first one succeeded.
>          */
> -       if (!perf_missing_features.branch_counters &&
> -           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS)) {
> -               perf_missing_features.branch_counters =3D true;
> -               pr_debug2("switching off branch counters support\n");
> -               return true;
> -       } else if (!perf_missing_features.read_lost &&
> -           (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
> -               perf_missing_features.read_lost =3D true;
> -               pr_debug2("switching off PERF_FORMAT_LOST support\n");
> +
> +       /* Please add new feature detection here. */
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_COUNTERS;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.branch_counters =3D true;

It feels like these global variables should be part of the PMU state.
There is already perf_pmu.missing_features.

Thanks,
Ian

> +       pr_debug2("switching off branch counters support\n");
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.branch_hw_idx =3D true;
> +       pr_debug2("switching off branch HW index support\n");
> +
> +       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_NO_CYCLES | PERF_S=
AMPLE_BRANCH_NO_FLAGS;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.lbr_flags =3D true;
> +       pr_debug2_peo("switching off branch sample type no (cycles/flags)=
\n");
> +
> +found:
> +       detection_done =3D true;
> +       errno =3D old_errno;
> +}
> +
> +static bool evsel__detect_missing_features(struct evsel *evsel)
> +{
> +       static bool detection_done =3D false;
> +       struct perf_event_attr attr =3D {
> +               .type =3D PERF_TYPE_SOFTWARE,
> +               .config =3D PERF_COUNT_SW_TASK_CLOCK,
> +               .disabled =3D 1,
> +       };
> +       int old_errno;
> +
> +       if (evsel__has_br_stack(evsel))
> +               evsel__detect_missing_brstack_features(evsel);
> +
> +       if (detection_done)
> +               goto check;
> +
> +       old_errno =3D errno;
> +
> +       /*
> +        * Must probe features in the order they were added to the
> +        * perf_event_attr interface.  These are kernel core limitation
> +        * not PMU-specific so we can detect with a software event and
> +        * stop on the first one succeeded.
> +        */
> +
> +       /* Please add new feature detection here. */
> +
> +       attr.read_format =3D PERF_FORMAT_LOST;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.read_lost =3D true;
> +       pr_debug2("switching off PERF_FORMAT_LOST support\n");
> +       attr.read_format =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_WEIGHT_STRUCT;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.weight_struct =3D true;
> +       pr_debug2("switching off weight struct support\n");
> +       attr.sample_type =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_CODE_PAGE_SIZE;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.code_page_size =3D true;
> +       pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support\n=
");
> +       attr.sample_type =3D 0;
> +
> +       attr.sample_type =3D PERF_SAMPLE_DATA_PAGE_SIZE;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.data_page_size =3D true;
> +       pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support\n=
");
> +       attr.sample_type =3D 0;
> +
> +       attr.cgroup =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.cgroup =3D true;
> +       pr_debug2_peo("Kernel has no cgroup sampling support\n");
> +       attr.cgroup =3D 0;
> +
> +       attr.aux_output =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.aux_output =3D true;
> +       pr_debug2_peo("Kernel has no attr.aux_output support\n");
> +       attr.aux_output =3D 0;
> +
> +       attr.bpf_event =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.bpf =3D true;
> +       pr_debug2_peo("switching off bpf_event\n");
> +       attr.bpf_event =3D 0;
> +
> +       attr.ksymbol =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.ksymbol =3D true;
> +       pr_debug2_peo("switching off ksymbol\n");
> +       attr.ksymbol =3D 0;
> +
> +       attr.write_backward =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.write_backward =3D true;
> +       pr_debug2_peo("switching off write_backward\n");
> +       attr.write_backward =3D 0;
> +
> +       attr.use_clockid =3D 1;
> +       attr.clockid =3D CLOCK_MONOTONIC;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.clockid =3D true;
> +       pr_debug2_peo("switching off clockid\n");
> +       attr.use_clockid =3D 0;
> +       attr.clockid =3D 0;
> +
> +       if (has_attr_feature(&attr, /*flags=3D*/PERF_FLAG_FD_CLOEXEC))
> +               goto found;
> +       perf_missing_features.cloexec =3D true;
> +       pr_debug2_peo("switching off cloexec flag\n");
> +
> +       attr.mmap2 =3D 1;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.mmap2 =3D true;
> +       pr_debug2_peo("switching off mmap2\n");
> +       attr.mmap2 =3D 0;
> +
> +       /* set this unconditionally? */
> +       perf_missing_features.sample_id_all =3D true;
> +       pr_debug2_peo("switching off sample_id_all\n");
> +
> +       attr.inherit =3D 1;
> +       attr.read_format =3D PERF_FORMAT_GROUP;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.group_read =3D true;
> +       pr_debug2_peo("switching off group read\n");
> +       attr.inherit =3D 0;
> +       attr.read_format =3D 0;
> +
> +found:
> +       detection_done =3D true;
> +       errno =3D old_errno;
> +
> +check:
> +       if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS) &&
> +           perf_missing_features.branch_counters)
>                 return true;
> -       } else if (!perf_missing_features.weight_struct &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
> -               perf_missing_features.weight_struct =3D true;
> -               pr_debug2("switching off weight struct support\n");
> +
> +       if ((evsel->core.attr.read_format & PERF_FORMAT_LOST) &&
> +           perf_missing_features.read_lost)
>                 return true;
> -       } else if (!perf_missing_features.code_page_size &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) =
{
> -               perf_missing_features.code_page_size =3D true;
> -               pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE s=
upport, bailing out\n");
> -               return false;
> -       } else if (!perf_missing_features.data_page_size &&
> -           (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) =
{
> -               perf_missing_features.data_page_size =3D true;
> -               pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE s=
upport, bailing out\n");
> -               return false;
> -       } else if (!perf_missing_features.cgroup && evsel->core.attr.cgro=
up) {
> -               perf_missing_features.cgroup =3D true;
> -               pr_debug2_peo("Kernel has no cgroup sampling support, bai=
ling out\n");
> -               return false;
> -       } else if (!perf_missing_features.branch_hw_idx &&
> -           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_=
INDEX)) {
> -               perf_missing_features.branch_hw_idx =3D true;
> -               pr_debug2("switching off branch HW index support\n");
> +
> +       if ((evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) &&
> +           perf_missing_features.weight_struct)
>                 return true;
> -       } else if (!perf_missing_features.aux_output && evsel->core.attr.=
aux_output) {
> -               perf_missing_features.aux_output =3D true;
> -               pr_debug2_peo("Kernel has no attr.aux_output support, bai=
ling out\n");
> -               return false;
> -       } else if (!perf_missing_features.bpf && evsel->core.attr.bpf_eve=
nt) {
> -               perf_missing_features.bpf =3D true;
> -               pr_debug2_peo("switching off bpf_event\n");
> +
> +       if (evsel->core.attr.use_clockid && evsel->core.attr.clockid !=3D=
 CLOCK_MONOTONIC &&
> +           !perf_missing_features.clockid) {
> +               perf_missing_features.clockid_wrong =3D true;
>                 return true;
> -       } else if (!perf_missing_features.ksymbol && evsel->core.attr.ksy=
mbol) {
> -               perf_missing_features.ksymbol =3D true;
> -               pr_debug2_peo("switching off ksymbol\n");
> +       }
> +
> +       if (evsel->core.attr.use_clockid && perf_missing_features.clockid=
)
>                 return true;
> -       } else if (!perf_missing_features.write_backward && evsel->core.a=
ttr.write_backward) {
> -               perf_missing_features.write_backward =3D true;
> -               pr_debug2_peo("switching off write_backward\n");
> -               return false;
> -       } else if (!perf_missing_features.clockid_wrong && evsel->core.at=
tr.use_clockid) {
> -               perf_missing_features.clockid_wrong =3D true;
> -               pr_debug2_peo("switching off clockid\n");
> +
> +       if ((evsel->open_flags & PERF_FLAG_FD_CLOEXEC) &&
> +           perf_missing_features.cloexec)
>                 return true;
> -       } else if (!perf_missing_features.clockid && evsel->core.attr.use=
_clockid) {
> -               perf_missing_features.clockid =3D true;
> -               pr_debug2_peo("switching off use_clockid\n");
> +
> +       if (evsel->core.attr.mmap2 && perf_missing_features.mmap2)
>                 return true;
> -       } else if (!perf_missing_features.cloexec && (evsel->open_flags &=
 PERF_FLAG_FD_CLOEXEC)) {
> -               perf_missing_features.cloexec =3D true;
> -               pr_debug2_peo("switching off cloexec flag\n");
> +
> +       if ((evsel->core.attr.branch_sample_type & (PERF_SAMPLE_BRANCH_NO=
_FLAGS |
> +                                                   PERF_SAMPLE_BRANCH_NO=
_CYCLES)) &&
> +           perf_missing_features.lbr_flags)
>                 return true;
> -       } else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2=
) {
> -               perf_missing_features.mmap2 =3D true;
> -               pr_debug2_peo("switching off mmap2\n");
> +
> +       if (evsel->core.attr.inherit && (evsel->core.attr.read_format & P=
ERF_FORMAT_GROUP) &&
> +           perf_missing_features.group_read)
>                 return true;
> -       } else if (evsel->core.attr.exclude_guest || evsel->core.attr.exc=
lude_host) {
> -               if (evsel->pmu =3D=3D NULL)
> -                       evsel->pmu =3D evsel__find_pmu(evsel);
> -
> -               if (evsel->pmu)
> -                       evsel->pmu->missing_features.exclude_guest =3D tr=
ue;
> -               else {
> -                       /* we cannot find PMU, disable attrs now */
> -                       evsel->core.attr.exclude_host =3D false;
> -                       evsel->core.attr.exclude_guest =3D false;
> -               }
>
> -               if (evsel->exclude_GH) {
> -                       pr_debug2_peo("PMU has no exclude_host/guest supp=
ort, bailing out\n");
> -                       return false;
> -               }
> -               if (!perf_missing_features.exclude_guest) {
> -                       perf_missing_features.exclude_guest =3D true;
> -                       pr_debug2_peo("switching off exclude_guest, exclu=
de_host\n");
> -               }
> +       if (evsel->core.attr.ksymbol && perf_missing_features.ksymbol)
>                 return true;
> -       } else if (!perf_missing_features.sample_id_all) {
> -               perf_missing_features.sample_id_all =3D true;
> -               pr_debug2_peo("switching off sample_id_all\n");
> +
> +       if (evsel->core.attr.bpf_event && perf_missing_features.bpf)
>                 return true;
> -       } else if (!perf_missing_features.lbr_flags &&
> -                       (evsel->core.attr.branch_sample_type &
> -                        (PERF_SAMPLE_BRANCH_NO_CYCLES |
> -                         PERF_SAMPLE_BRANCH_NO_FLAGS))) {
> -               perf_missing_features.lbr_flags =3D true;
> -               pr_debug2_peo("switching off branch sample type no (cycle=
s/flags)\n");
> +
> +       if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_=
INDEX) &&
> +           perf_missing_features.branch_hw_idx)
>                 return true;
> -       } else if (!perf_missing_features.group_read &&
> -                   evsel->core.attr.inherit &&
> -                  (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
> -                  evsel__is_group_leader(evsel)) {
> -               perf_missing_features.group_read =3D true;
> -               pr_debug2_peo("switching off group read\n");
> +
> +       if (evsel->core.attr.sample_id_all && perf_missing_features.sampl=
e_id_all)
>                 return true;
> -       } else {
> -               return false;
> -       }
> +
> +       return false;
>  }
>
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3e751ea769ac4d3a..ea3140cd91c589fd 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -368,7 +368,6 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_=
map *cpus,
>  void evsel__close(struct evsel *evsel);
>  int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>                 struct perf_thread_map *threads);
> -bool evsel__detect_missing_features(struct evsel *evsel);
>
>  bool evsel__precise_ip_fallback(struct evsel *evsel);
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>

