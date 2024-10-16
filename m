Return-Path: <linux-kernel+bounces-368750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F349A1470
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A79B1F23168
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3A1D1747;
	Wed, 16 Oct 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUSjF5KO"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C111C2324
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112038; cv=none; b=NTJao6OCoZBdX71MOWin+rB3evHb+ksUgVwJMFJ20vzVfhYNQBBfns1HN6NLnZzNgFum/IgH/pFIZ+KaYY5UzOh9EHBFc9DiPl+QTKTsjm5O6L6fmlEx+aGJnJNC/2YjjH61d4Y+r2nZu35pObKU3lKSfadrOYWPQmGtasNBn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112038; c=relaxed/simple;
	bh=u5MdepGIfBilLu0ziohieyw51PFn74HZe6J1lNo9KzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IMD94UWiKEEEPLU5BZdZtMdGSB/UZdfONzCsC35GOo1KCV4CZWHh812tj7cC/W6qS3gV3fDx0ZiWfDXvcZuv+BLCOreHOkpdk+0zSQmyQ+JinbAPRhOFFpjbCqw0JEdJBFMGSt5vTUk6UmxVglgi5INXV4h1vkIzCTvMtyRCWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUSjF5KO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so19055ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729112036; x=1729716836; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNY+GVmNb1YId0Xh+4NvDDftMMReKhqSCa5776z8e3M=;
        b=HUSjF5KO64TlfW5MCosu2seXqObyooz/42c01/FXZri9kXbkSnlx6kmG9oYJFNViDh
         /5HJYYREJzojlbcK12o+LR9B18YUKWkJSecJwtUo1a0NFabG2norLNFAdr8JwF9/cTTB
         nb3nCAzoQnALkSNddKVD7XGqDG0m2X5uJqS4i6Ue/9lJ1PILmmuc18jJpm8cwsdKKESA
         ExyRs0Opn7HivO5KF1bpU/PcxFZttzrg1y66uzRt4IwZmMCdtIPcQ7MRRedWEjdpiKJp
         7rn71RbkQQFmwHnB3SCIorypmhTPQxOzsNHfAMjUzU71nSP3MaxRbipv5liJeMl69qXl
         8gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112036; x=1729716836;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNY+GVmNb1YId0Xh+4NvDDftMMReKhqSCa5776z8e3M=;
        b=gMFNRqlFGwbDcjd31d2P73go4irfMrUq6UQ/2R1SvmSc+HaE66z714oOV6FrQxN9+/
         8QBNZ1SmNomCcpKbVK/4ZT3Us4zR4H/TGHNKVq+IEiv7PW0pjCOP4u30kXVUw+pr/ivC
         2g9JaTAfTUb+TnRaFkQ3/YskdSR+paWAXomSLSmWX9PYoT8QhKDL2673xDV/uOKp4dB+
         GiMt6ZuyMcOihGrSiCNpZctD3P5XXyqB3lU0OhhzSdbf6PLorjfWXQU9/4CI0CqpRmfZ
         C1gFseU2YkzIqjGYAx8ds+CJiBkJPDIvlSJ0aAPTT8nUXS+qGoyP/X+jsaNE20xvnMnM
         f2jA==
X-Forwarded-Encrypted: i=1; AJvYcCUXsVy7ShJtDWX+ybIUY1UzbrmyVMl/ebTcFs2deVx+c6s/X8YAfAaE4gcY8cqV7kJwAPr2p/YU5d/+xI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6rt+ROqomDl4odPR8Pr6EGYkqJNKm/CrTO6uxQ0H8m9QUv12
	kkv/2cHkecWsihoYMmRSPqZDnJ0n1BmwnPUXFUeHLE+cB/rikOoz/dzjxXWsy0HMRToFBTGpPul
	Vtyf9bncJOH7AQIelJ1IZi8/TD4zxcmgLlthr
X-Google-Smtp-Source: AGHT+IFRXjyLQm+uJRX9z5lMKycMDQ18nfRsWOGMMiRoWsn7MPBvQvAuRvyfFmTSPONwCTNADh4XSh3SjIL8fpLfJPU=
X-Received: by 2002:a05:6e02:20cc:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a3ea02489cmr233945ab.13.1729112036282; Wed, 16 Oct 2024
 13:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 13:53:42 -0700
Message-ID: <CAP-5=fUUv4M0nKao1grRhjiSN3E7ntM0VRp-GJDEq0c3xnFFOw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:53=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants in a CSV column or json
> dictionary value.
>
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
>
> v3. Rebase.
> v2. Don't display metric-value for json output if there is no unit.

I'm going to change this. On a hypervisor where counters fail to open
the CSV output is losing a column. I hate the stat-display code as it
is spaghetti, I'm just going to disable metric thresholds with CSV
output.

Thanks,
Ian

> Ian Rogers (8):
>   perf color: Add printf format checking and resolve issues
>   perf stat: Fix/add parameter names for print_metric
>   perf stat: Display "none" for NaN with metric only json
>   perf stat: Drop metric-unit if unit is NULL
>   perf stat: Change color to threshold in print_metric
>   perf stat: Display metric threshold value in CSV output
>   perf stat: Add metric-threshold to json output
>   perf stat: Disable metric thresholds for CSV/JSON metric-only mode
>
>  tools/perf/Documentation/perf-stat.txt        |   1 +
>  tools/perf/arch/x86/util/iostat.c             |   2 +-
>  tools/perf/builtin-sched.c                    |   2 +-
>  tools/perf/builtin-script.c                   |   6 +-
>  tools/perf/builtin-stat.c                     |   8 ++
>  tools/perf/builtin-trace.c                    |   2 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
>  tools/perf/util/arm-spe.c                     |   2 +-
>  tools/perf/util/color.h                       |   9 +-
>  tools/perf/util/intel-bts.c                   |   2 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/s390-cpumsf.c                 |   2 +-
>  tools/perf/util/s390-sample-raw.c             |   6 +-
>  tools/perf/util/stat-display.c                |  85 +++++++++---
>  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
>  tools/perf/util/stat.h                        |  16 ++-
>  17 files changed, 191 insertions(+), 111 deletions(-)
>
> --
> 2.47.0.105.g07ac214952-goog
>

