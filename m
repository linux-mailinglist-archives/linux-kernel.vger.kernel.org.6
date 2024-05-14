Return-Path: <linux-kernel+bounces-178311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BF8C4BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD8E1C22FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A104134C4;
	Tue, 14 May 2024 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zu+u4Faw"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C74125AC
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662135; cv=none; b=rCCevfH8Lx6+gXBvtvyhEvUJDpecShVue70MlhFQj5+CGcmsxuWbGQ4PWffULTfZqtlnvYDaZOosce9MX2RQ63k/fQ5WmPQHfTPHpFQzenJIUs3UOL9lGqTnwSafYuXpMSYY0zfoikgXHiM79LdFlyLno8gwU8xGcF5FiIw+fCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662135; c=relaxed/simple;
	bh=xA6emBQVwVuglSd8BdKXUOzTu+AXBbD0wHHpuBd1VRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZU7RZ1pLpb5lh5QG31EMqyw/2zB3+pP/jgaxl472EQB5V1lkECz07OfFP7u1mVPqr3Hr4h/iy/5xiS5vnkvM4/XEQ7yGTHZqkuU9HaXXeDovmkdLfrWClqiOSguHJYlQBhkUvRLqPbDGneb0aFvCT+jIdXSyGopIDk9n8DGIXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zu+u4Faw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43df9ac3ebcso1074521cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715662132; x=1716266932; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXFf6Eq00urqf0wFdNRBo6rl3kq0as0cRcr6U5+BnfU=;
        b=zu+u4FawyAFkqJeP3EkVra4NL2EvwFt4KNbJ/e2BsDn6fJvgqv6dKcDdeVyYsdV+We
         3+Ndr83vGyHJiBx/ttxIVa+cpOuLtN5L/rBKL3yyjraYMbLja0xNLtf0VTeXyUaoOA7C
         UjxzyvND6AhUfWQyRZlMAutwupsqZ4xo1FBzS7CMSYk5PrH5YWdKVHwcVpX685jdY6O8
         4nVzsr1+09DrHr8jOqbX8HtZJbFIIbFK21JouWopQyuAy8nDzhVBjML1c+jvi4d1by0K
         9Q+5S9F41xeaDvOxljocqCek3vB3xKrPcaYgz7UoggBRBH9GOjyTemMqK2bYHjV6S25j
         MiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715662132; x=1716266932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXFf6Eq00urqf0wFdNRBo6rl3kq0as0cRcr6U5+BnfU=;
        b=Zy2ueJT1FYkmhC1BQI9hZNOJbg4F3RZXLw+aEwSQdaMTgIr9JoPm6XReWCx36YU/Wn
         EayVgm0XUBisAfGRxUESni2dzFhlpQhV1nD/HR6dCj88Y1FZ84KPrftzWm34NK2Y9KYC
         Abp38Ln3tjWs9Ur6vFj0w4Uvz/TF3yNeDxSqR7ud6MdI5F90tKttiwhj5UEl7bAEnYDe
         2U/8LwCVkPvpjXKUo19PFIwm+fO48oFV1im6x77KatiK/iot3qS9fdmBT06qjx7cLhJq
         bLxkNIMweBVvglyfjpgqiuSWn5hlvtCEnEm1AbILRIKT3EyqGY4wfvlU8L0jBeXNFNy0
         1jnw==
X-Forwarded-Encrypted: i=1; AJvYcCV7A1wK0sn3SjZLReTgNrL6VrCBemyDV/BlQpEfrBpRU6IZgMLl8uliMH5xI3FNDTB8BBWcTw0Eq4pJnoVzkZX9r1HCPkgiDXT7idl3
X-Gm-Message-State: AOJu0YxpQ1nqZAHt8hafuPJXo6a70Te4Gp/TwYC3Aa7sZgmSN+jSVwN2
	SlJp/baW8aREqAFoQYbDgVZUJ64w0Gq3v3hOsCi9rh81tOo7W+uRu+wfPuCtQR4DNNOcDqH28lH
	ylgqlpzs/7BcFciYB/Xwni4RcKMHiAN3qlKXL
X-Google-Smtp-Source: AGHT+IEaJEKQvY6jBBoB4XoOHxarSpuByI4wdMGrcHyrxgOa4Qt93kUKoinfcp6O09S4vAXY3qaeTBVGvSvGAat8z7Q=
X-Received: by 2002:a05:622a:4886:b0:43d:a002:b with SMTP id
 d75a77b69052e-43e0a1c2014mr6775881cf.9.1715662131679; Mon, 13 May 2024
 21:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 21:48:40 -0700
Message-ID: <CAP-5=fW_Ri1yOfq2QS1_NOV0+kNm+n+Vv03v3FjfbRet4Ztn7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Event parsing fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:38=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> For the default events, parse from strings rather than use pre-cooked
> perf_event_attr. This fixes non-x86 heterogeneous CPUs where legacy
> hardware events wouldn't be opened for all PMUs. v2 was previously
> just patch 3 but it is extended in v3 to incorporate related fixes.
>
> When a sysfs/json event is used in preference to a legacy event, allow
> evsel__match to still function using a saved hardware config
> number. This fixes hard coded metrics in stat-shadow for events like
> "instructions" on Intel that have a sysfs file.
>
> Fix/improve uniquifying event names fixing the test "102: perf stat
> metrics (shadow stat) test:" that was broken by a formatting issue
> when the sysfs instructions event was used.
>
> Having evsel->pmu_name and evsel->pmu->name is confusing, get rid of
> the former. Fix/improve evsel__sys_has_perf_metrics in the process.
>
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name

Hopefully the first 3 patches here can be a priority given the fixes.

Thanks,
Ian

>  tools/perf/arch/x86/util/evlist.c |  74 +-------
>  tools/perf/arch/x86/util/evsel.c  |  35 +++-
>  tools/perf/builtin-diff.c         |   6 +-
>  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
>  tools/perf/tests/parse-events.c   |   2 +-
>  tools/perf/util/evlist.c          |  46 +----
>  tools/perf/util/evlist.h          |  12 --
>  tools/perf/util/evsel.c           |  28 ++-
>  tools/perf/util/evsel.h           |  22 +--
>  tools/perf/util/metricgroup.c     |   4 +-
>  tools/perf/util/parse-events.c    |  52 ++++--
>  tools/perf/util/parse-events.h    |   6 +
>  tools/perf/util/pmu.c             |   6 +-
>  tools/perf/util/pmu.h             |   2 +-
>  tools/perf/util/stat-display.c    | 101 ++++++++---
>  tools/perf/util/stat-shadow.c     |  14 +-
>  tools/perf/util/stat.c            |   2 +-
>  17 files changed, 305 insertions(+), 398 deletions(-)
>
> --
> 2.45.0.118.g7fe29c98d7-goog
>

