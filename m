Return-Path: <linux-kernel+bounces-547594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6BA50B64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B83AB4B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79377253B4F;
	Wed,  5 Mar 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qopDXm1s"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7324BD14
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202586; cv=none; b=EOynYmpSnfToiYkm+o8HkXSgCr+jT+xE1C0E86lEvXHQX982KGUK/sjnx0/Wk8QnYroEzbNWKpNkTSKLigNQJtVV7sTYy0NeILElcbKGLiE5vEqZdtKJdjHBgr89Ff/tE0TtwP6jEoEqi94FfJwPWfJuvJ5KkC+eJTpueueFCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202586; c=relaxed/simple;
	bh=u9bmhx1yHi5hXoDwtEMkKLqFy6j05cYMYLINTzYnCnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3LJqrlDrg94D3xZ3hl/WijJemk0Li8KhJSsK1WtktruwnAp9I6DudCizwgyhh5dJnMqeb3zx/wMP8zi4etmZww6X8dubOmOg6PCKAu15Z0s+E1jmq+3DXXHQr79Ux4DIzpbZJjGq3Hqwej/ngC1CCCNhGBZtKf4GmeyURDjAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qopDXm1s; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2237a32c03aso16715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741202584; x=1741807384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGyJKu/nD+Qnf5N+NTMUyE4lAVhr8I4DP7eKOo06iYc=;
        b=qopDXm1sX6qzmgDADFtyPi/SOhsNWG1SoI8FwQf1GD9UVS48qCYz4mAZKnIpejlOlD
         jMdRlyKYSNdSCHJ1iZw/lh1EX1ihxH7zOCYzMzsjMgQVqxDEWufasi3URP41V5kJd3kO
         jd8Xb1UgKNp9YNAUFuBx7J76G3r/PzmGG5EKi/Fi7t0Ob9zrhp2IQG2MdZwS7y5YVhQ3
         jYAn9iRP1sgpZrRX2MzcqUDSXIXKB7s6s5LHmZgN5iE5FOInTKdGCS9d/0KDmeHxnG1L
         GxUYYCKYUA0DVeSv8FA4v9YEVGqG04bQx4sYdFTzsW5RXcRmaBZ4Z40JdNK8gMky3OdS
         UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202584; x=1741807384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGyJKu/nD+Qnf5N+NTMUyE4lAVhr8I4DP7eKOo06iYc=;
        b=WaZMJYoinjDywwHZzrVx7TWsFCL35Zk57iXx3V+vbfHgZOnPVWS2viNBurjWOs60Nu
         B8CkXFcV61BpFCcL6ickah2eLRR3jZcE4yNOFnTdRQsDhF1Ap7FRw8YAvJsGe09U5eyv
         htvutJh09Z1Cz+GmN8D8DWOCPMDqlUXb7y4QAUvv2wix9++OYxse8iTwtVE2KiLwBn+k
         EDfhJDdqvL+Njw3WTngQJdJzGlgi3s3Ed8WmuKcIRn+MmooUWVSM/mh+njgrcPLYwj+k
         8C6BNc4cCe57U7DvY/AG7WmG301WZLvPhYctiqd8MD49pUG1LnH6xesvNsvWjNXxmYRq
         7tMw==
X-Forwarded-Encrypted: i=1; AJvYcCURmCLN20N/9JD7Q1z5H4/nakibG+o1D+quVd1zxxheaXGJt2vdabiAjszWer1qLlwbzc+Qcmr55ciQz8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeSq0LLB3XNt+FzDhcKbfIuSpkSuTvL/QsRl5+EiTxlvCODzF
	g4KsXrszY1mdM2AF9UxkBIrtixiNosjbha0nW61u19OU7cMjs3kiudTqN0lFQNxbbMvFPXQAs/k
	mHp5c+86urwIbEWqkjNC64wVtvHlUROKtmLt3
X-Gm-Gg: ASbGnct3odiuqElolFNb+xFhKYctmCCPXb/AUhYf98F73ISh8ns9QEMN/OAB0KSg+lS
	K7eJP/AupR1SJI9EEFKyNHsoa69tash5B+wSkFki0bzc8x+VYL5NhtRbsJA8lm3ge2Ro9as/HUT
	k/gtIKgqoQzxLCTPPbEHOh8UNkqnF4kA3iJn5UPzEL3FiwAFYxi32m0HA=
X-Google-Smtp-Source: AGHT+IEO7wzY0By+C1nypMF3yAchYa0V90ZDe2pSWoIuySujENNQdXsNBn0UqC+ZNzGUmzLGqKsUMXJZ90xEb9bHD7c=
X-Received: by 2002:a17:902:d481:b0:220:c905:689f with SMTP id
 d9443c01a7336-2240b626059mr117635ad.25.1741202584090; Wed, 05 Mar 2025
 11:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305163935.1605312-1-thomas.falcon@intel.com>
In-Reply-To: <20250305163935.1605312-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 11:22:53 -0800
X-Gm-Features: AQ5f1JohZr7JNZCeP4T_8zyJCiixX7hgqXkMKA_FZqWI4pdVtM_nR5v_7c5EuY0
Message-ID: <CAP-5=fUb0yhDHKxsMjqYTtJUfA-Me7kFHE66XRxQ+-OUSGsmLQ@mail.gmail.com>
Subject: Re: [PATCH v6] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> This patch was originally posted here:
>
> https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.c=
om/
>
> I have rebased on top of Arnaldo's patch here:
>
> https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/
>
> The original commit message:
> "
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
>
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=3D0xcd,\
> umask=3D0x01,ldlat=3D3,name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> chromium-browse   46572 [002] 544966.882384:      10000         cpu_core/=
MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7=
    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
>
> perf record -e cpu_atom/event=3D0xd0,umask=3D0x05,ldlat=3D3,\
> name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS=
_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.s=
o.0.8000.3)
>
> Some fields, such as data_src, are not included by default.
>
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
>
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> "
>
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> v4: rebase on top of Arnaldo's patch
> v5: update based on Namhyung's feedback here
> https://lore.kernel.org/lkml/Z8YcOidenzGofq7R@google.com/
> v6: update based on Ian's feedback here
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfVwrG5ZViysO7qKYUw0326WF=
fa7nOzwe70drYfHq=3DAXhA@mail.gmail.com/
> ---
>
>  tools/perf/builtin-script.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d797cec4f054..253c4ca395e1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -400,10 +400,20 @@ static inline int output_type(unsigned int type)
>
>  static inline int evsel__output_type(struct evsel *evsel)
>  {
> -       if (evsel->script_output_type =3D=3D OUTPUT_TYPE_UNSET)
> -               evsel->script_output_type =3D output_type(evsel->core.att=
r.type);
> +       int type =3D evsel->script_output_type;
>
> -       return evsel->script_output_type;
> +       if (type =3D=3D OUTPUT_TYPE_UNSET) {
> +               type =3D output_type(evsel->core.attr.type);
> +               if (type =3D=3D OUTPUT_TYPE_OTHER) {
> +                       struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +
> +                       if (pmu && pmu->is_core)
> +                               type =3D PERF_TYPE_RAW;
> +               }
> +               evsel->script_output_type =3D type;
> +       }
> +
> +       return type;
>  }
>
>  static bool output_set_by_user(void)
> --
> 2.48.1
>

