Return-Path: <linux-kernel+bounces-410915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61E9CF069
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7104828C3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DAE1E22F8;
	Fri, 15 Nov 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzPKoX9d"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843861D54D6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684962; cv=none; b=dA3T9Vaf7Uaci78tDw/dyrk+8LVgu2lAff7X0PnMJmxFMd7AdRMvNBhIWQ/1ElYmx7B4+ogvNJCu1Hkv+VxRFmK5E7xL1+UlcoWVYvIO1ENSeGZhbs6MqAnPsViJeyASpXWbtq9pspzOrWQwA+wRXwOyABIQ5mIBrgmWbvh7uGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684962; c=relaxed/simple;
	bh=rYvme6davXOV7S0ICIdnVJjQUxIQxCENktTfkU2/Km8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=R99zmNQTDA/Pgajz4b57dAyn0/Kssw1YsM0mcE1OEZIzfD0vHHVFVFPu5D6ouEY/13gERH4SJ9icS9ehjEghY3el6wzjGkkBtddnCqVewcjRmEo0pR4pckcWRcfXCxxCAAqlreAZiYBD/oDjR9odRAO58kfnbxBzPN0oiVY4o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzPKoX9d; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf9cd1120bso656110a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731684959; x=1732289759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1RpKflVF0bebbJaxQf/ZXjTfRFvkv41edCIwaQJcQs=;
        b=zzPKoX9d3vNb5ippLrlXv5etR4FrC9zcSvcSOQni0LEaI4P88GCkH0/nLdS7UkFOPn
         bQgiAd4GORZDHF8N81/6MP0CmPxvVblIdQTGzv31WWNEQxjfde9umNCPrY12zU5+i3Po
         hbKlSM+Gacet/oE8hJnZPAATZEj0YymIxZjMI6Yp3NA/40tMhZlybAIPVOQZRSEte7+u
         CQntrJt6lTCL9OJNu+dH8MWqDrPHAi2UU19opvXWMB71oD45uLEvFYi7jjyZypACdx+r
         RGctr3CjrVYWdTufECMKdcEiOT7ECY7ylzvXug+RUIjtXaHfM0kdCnNR1yQHBQXSFbvw
         BiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684959; x=1732289759;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1RpKflVF0bebbJaxQf/ZXjTfRFvkv41edCIwaQJcQs=;
        b=U6Rpq4oTU0GhELHoKA/TKSpqJm/K+ij5dmcLQ4B96pUpd8dyod9t9hCk2SWuJj/r6Q
         434HBUQWchZqwy9ng0RzSJFOIKIbe2uiff467R8HPBW+6J5nWmyCk20YSNB3FRuNwRos
         MkBIPTDLIymM9q8Ox5X9WIQauxe35OZmFS+8yUV3fpMm6P00KdryM2NoJ/bm/idJ4iMc
         6eTHX9HkIY1CEpD/uO7WFZtJLRDgtkoZFyqrUYL0STpoW0pqM8/fggnNlGpgHdj4QYHJ
         laLW+8PbibALCplr/ZtjqiWMQtfCUqf03im71GUnCD1iezggxQtrjr0tVAhHoJicWybZ
         L7+A==
X-Forwarded-Encrypted: i=1; AJvYcCWfNdXL6vfx/S2sagqmrL//zaVf4ILHb7yDF8wuXVgmvbvFMrMqKZN9onqyqR4ETBWnE3uUC8lAbfTld74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjwexj8Pv7B/IVNI0iFwHzJByzSy6WBQsmv7ixweqmvq5Mznry
	9/vINdrrVkUwhhEyEm+q1dnhkn/MUWqwWUGBG+pZYid4vIjtzkZeozhrw/F1A1k=
X-Google-Smtp-Source: AGHT+IECuVoSF3cpPActYMtkLKV2qemZdHFkwL1b+NBlkRP5B3JvLdOGBczovm4O75t7YTAzxqF8NQ==
X-Received: by 2002:a05:6402:34c4:b0:5cf:14fa:cd10 with SMTP id 4fb4d7f45d1cf-5cf754df234mr6631178a12.5.1731684958824;
        Fri, 15 Nov 2024 07:35:58 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.111])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0ad15sm1676898a12.66.2024.11.15.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:35:58 -0800 (PST)
Message-ID: <215ca9a2-0a63-4d0c-8402-5cb1f2bb0794@linaro.org>
Date: Fri, 15 Nov 2024 15:35:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
To: Ian Rogers <irogers@google.com>, Xu Yang <xu.yang_2@nxp.com>
References: <20241107162035.52206-1-irogers@google.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das
 <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Dima Kogan <dima@secretsauce.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/11/2024 4:20 pm, Ian Rogers wrote:
> Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> lookup:
> https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> These patches remove a lot of the logic relating CPUIDs to PMUs so
> that the PMU isn't part of the question when finding a metric table.
> For time reasons, it doesn't go as far as allowing system metrics
> without a metric table as a metric table is needed for metrics to
> refer to other metrics, and the refactoring of that resolution is a
> hassle.
> 
> Ian Rogers (7):
>    perf header: Move is_cpu_online to numa bench
>    perf header: Refactor get_cpuid to take a CPU for ARM
>    perf arm64 header: Use cpu argument in get_cpuid
>    perf header: Avoid transitive PMU includes
>    perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
>    perf jevents: Add map_for_cpu
>    perf pmu: Move pmu_metrics_table__find and remove ARM override
> 
> Xu Yang (1):
>    perf jevents: fix breakage when do perf stat on system metric
> 
>   tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
>   tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
>   tools/perf/arch/arm64/util/pmu.c         | 20 ------
>   tools/perf/arch/loongarch/util/header.c  |  4 +-
>   tools/perf/arch/powerpc/util/header.c    |  4 +-
>   tools/perf/arch/riscv/util/header.c      |  4 +-
>   tools/perf/arch/s390/util/header.c       |  6 +-
>   tools/perf/arch/x86/util/auxtrace.c      |  3 +-
>   tools/perf/arch/x86/util/header.c        |  5 +-
>   tools/perf/bench/numa.c                  | 53 +++++++++++++++
>   tools/perf/builtin-kvm.c                 |  4 +-
>   tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
>   tools/perf/pmu-events/jevents.py         | 39 ++++++-----
>   tools/perf/pmu-events/pmu-events.h       |  2 +-
>   tools/perf/tests/expr.c                  |  5 +-
>   tools/perf/util/env.c                    |  4 +-
>   tools/perf/util/expr.c                   |  6 +-
>   tools/perf/util/header.c                 | 82 ++++++++----------------
>   tools/perf/util/header.h                 | 23 +++----
>   tools/perf/util/pmu.c                    | 25 --------
>   tools/perf/util/pmu.h                    |  2 -
>   tools/perf/util/probe-event.c            |  1 +
>   22 files changed, 189 insertions(+), 229 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>


