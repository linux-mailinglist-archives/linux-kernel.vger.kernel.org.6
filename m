Return-Path: <linux-kernel+bounces-379324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A205E9ADD12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C942281824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F3189F37;
	Thu, 24 Oct 2024 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHUsoMRO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6616EB56
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753683; cv=none; b=O74GwT3rQAGzfVL6Qu3DL39aWsr/bGbjQ61C6cb5eW4wYjLVIv2AbhAkvJT8Z5GuCN9ZPczH9m4Awubt8a2l5jQjs/sQ0mRpIP9U4DxhyT2/92kSzpFdTw227FEYQJMulGlEG1TN3HMHxyZBVDTM/AoFFLrfDkoSF9kHd76ogmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753683; c=relaxed/simple;
	bh=NauFo3WBlImoLtFsJOMl+FLWJ0VfI6WpEaNhQHEaHS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdpPlxHo1jTx1tGh7b+wSF2mIE/ERbbsPqJYhIXe6I14IDWDCPY5UbL4Zk68F+Azny46dWTR0fhO9NIVCsVutl0g1gyQPitjbfkBvWS8XuRLDApaAuSBmyFW/lK3HekvRDTG8G2xJKdvDfH6KIlC0rSPSVGZ8N4IZTvST9PrxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHUsoMRO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso49385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729753680; x=1730358480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufgf6SU5y6MU1sS4oN/MrtWQ1EZH9od+Vif+VJ4QaT8=;
        b=YHUsoMROAvkphczO7F6lZ1zE3Vdvb74DIHyHZCkILuyW19FmO7dFgzztk62hBnmwEY
         nxhbMNsHqOgIFVVCn3/okKxlMSoSGhR98xTodKXelbnLW59rkcEbq7DtGLE4pDWthPOy
         1Srhipz1A/useqw7qrUr5UQFWOyvXfp0a8CJ9suOBfv9mggJXx1ic0gkOzKuY572g5aG
         KjFBaSCw1boMr54xPw9qPIiNA77bNqp8XH6xbaB1wgpL8YWpuQOsLaur6X0TYC7UhJRv
         ctOFnzR4j3PiQn4/59Mf0QbXdLLVP5nS3t7qFtAUYqt5bU8JqHtDPtAymngtQmEYLCtR
         g+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729753681; x=1730358481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufgf6SU5y6MU1sS4oN/MrtWQ1EZH9od+Vif+VJ4QaT8=;
        b=pkWt+twS0NFmWQvhwlwmsNVZ+khWNuxGz5Tg8m/CRppFUVga83MMKE5AgCKOBko70n
         1R238m5NFrlbAiM1p6y3zzzfoi+JywhmXmp+Ejg510meBq9MKfX6UdlYuDsoOP9I7l2y
         WFpSvKpzjRs/bUZjY1dys+Z7Kb0/Tqo3u7XDxGEaRqT+fhmCB2aZgE6emYU7y0FrOvUt
         Yduo3a1NwLt3ls68tFfgj088CUNsJAC3fcOVl5SFdgoilYSzX79LwSCtKYCMATPtFm7R
         IoKPMwoVQM0wg+ywiav/upCApomUcdWo87+PVrmN+ML6cYHp1IHWsK1vZc7/Bz5gPbBJ
         Xksg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8tabVC0oDx9aeq60c/NprBuA5SrXjtwqWExWHd2pnS3Nz+gxwLGpybRLEtKTBj+8U2VCtcmGqnN7Y4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrR58d7YetW59gSl/2+7H/WDI/UwoH12SuSb3ybOa6tg41EKyF
	5QiSQZ/Fsi4NTE9HDlNy4IAygrgdCf0RVkNFmnZSLnrMtg5EiP8z5ILQEaRzpADbWnjwr/LQVWK
	mJ3Iy2xSlP18R584MmQDO3wm6UyjmQWcglVB+
X-Google-Smtp-Source: AGHT+IFe5aNvZD97KruIlUL4kGgN0v01ZzrWZ8AcP0Ivwbbhf/A67Fw0cHOyj6OyvXujk4w9nmI9nc7qoYmhvbKLlw0=
X-Received: by 2002:a17:902:e543:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-20fb5f2ee73mr2079375ad.6.1729753680197; Thu, 24 Oct 2024
 00:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com> <Zxm5w6wXLxpbERZx@google.com>
In-Reply-To: <Zxm5w6wXLxpbERZx@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Oct 2024 00:07:46 -0700
Message-ID: <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
> > Following the convention of the tool PMU, create a hwmon PMU that
> > exposes hwmon data for reading. For example, the following shows
> > reading the CPU temperature and 2 fan speeds alongside the uncore
> > frequency:
> > ```
> > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/=
 -M UNCORE_FREQ -I 1000
> >      1.001153138              52.00 'C   temp_cpu
> >      1.001153138              2,588 rpm  fan1
> >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> >      1.001153138                  8      tool/num_cpus_online/
> >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET              =
   #     1.08 UNCORE_FREQ
> >      1.001153138      1,012,773,595      duration_time
> > ...
> > ```
> >
> > Additional data on the hwmon events is in perf list:
> > ```
> > $ perf list
> > ...
> > hwmon:
> > ...
> >   temp_core_0 OR temp2
> >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=3D1=
00'C crit_alarm=3D0'C. Unit:
> >         hwmon_coretemp]
> > ...
> > ```
> >
> > v6: Add string.h #include for issue reported by kernel test robot.
> > v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> > v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
> >     the update to perf_pmu to use it. Try to make source of literal
> >     strings clearer via named #defines. Fix a number of GCC warnings.
> > v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> >
> > Ian Rogers (5):
> >   tools api io: Ensure line_len_out is always initialized
> >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> >   perf pmu: Add calls enabling the hwmon_pmu
> >   perf test: Add hwmon "PMU" test
> >   perf docs: Document tool and hwmon events
>
> I think the patch 2 can be easily splitted into core and other parts
> like dealing with aliases and units.  I believe it'd be helpful for
> others (like me) to understand how it works.
>
> Please take a look at 'perf/hwmon-pmu' branch in:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks Namhyung but I'm not really seeing this making anything simpler
and I can see significant new bugs. Your new patch:
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git/com=
mit/?h=3Dperf/hwmon-pmu&id=3D85c78b5bf71fb3e67ae815f7b2d044648fa08391
Has taken about 40% out of patch 2, but done so by splitting function
declarations from their definitions, enum declarations from any use,
etc. It also adds in code like:

snprintf(buf, sizeof(buf), "%s_input", evsel->name);

but this would be a strange thing to do. The evsel->name is rewritten
by fallback logic, so cycles may become cycles:u if kernel profiling
is restricted. This is why we have metric-id in the evsel as we cannot
rely on the evsel->name not mutating when looking up events for the
sake of metrics. Using the name as part of a sysfs filename lookup
doesn't make sense to me as now the evsel fallback logic can break a
hwmon event. In the original patch the code was:

snprintf(buf, sizeof(buf), "%s%d_input", hwmon_type_strs[key.type], key.num=
);

where those two values are constants and key.type and key.num both
values embedded in the config value the evsel fallback logic won't
change. But bringing in the code that does that basically brings in
all of the rest of patch 2.

So the patch is adding a PMU that looks broken, so rather than
simplifying things it just creates a broken intermediate state and
should that be fixed for the benefit of bisects?
It also complicates understanding as the declarations of functions and
enums have kernel-doc, but now the definitions of enums and functions
are split apart. For me, to understand the code I'd want to squash the
patches back together again so I could see a declaration with its
definition.

Thanks,
Ian

