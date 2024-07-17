Return-Path: <linux-kernel+bounces-255322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C9933F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27811C22379
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC5181BBA;
	Wed, 17 Jul 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHVZFPKv"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83861180A9C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228601; cv=none; b=Zt5w4jDQFYFI6yx+2AATQg8eppxHlYknI+rJg7Y12F/QErIBcrj1LsHU968gW6frsCBXFRkxxAK1UyiI/vAfEAkeJWMc5QcCQpTHRrzYE7WPindSzy3m9ELrgghfIDi66u7x8jeVhSBpNdwJ3Jufw2QcYshSBzNGrHMhYG/JTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228601; c=relaxed/simple;
	bh=uY31lfeTX1cmAKXAoE/5m2w0v2AqdQRD+3CAB+KJm8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvIIyoy0mLMHP8A5PYeLQjyUeukGkGTx5ZFkzDOtTHU68qcpYQAnQUrtbM+kvJ8OcfjKOn+6WhxsT0FpeLZMb/C9wpywHAsOjqVdXAuozyKipHQEKEUklxZkE/+Gn19+r9oEfiDD23++c/drI1jRivW1hMOGxIJo2NTOxfFbGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHVZFPKv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70ce3d66a8bso558768b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228599; x=1721833399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aoj6MPXt3lY6CL1odJ5ENy6WZ+0W2WmSL5RmTE2y7+c=;
        b=pHVZFPKvkY/NWC8hcplxv8kDR+DXl9qcTd/FSlgjtjFPdH44ebjJzxwyqr/vO1VW4p
         RRGOHqF/C+z+W9lb6/iDEVglMZBVcB5n6pzBmj7Lz0qkELFSrpPk1NxDvXaKX/RygHkx
         LyNrTyTDxOE4ih3dadolhhfFrrxmePuogysrMGbSX5ikP0rx/nx0pzVXLwgQE4AKR3Gy
         9yyLlJkRgXFm7LkujC1iiFTl8RZT7yfm4X3GbcKUz7xOztLZGsYjRsJP2dMoOr8+0FI4
         XddDG5JmVmP7+RtWz32hP8ExDRosfRvNEzXsWcsJjLknQNKXgKUR4GT+eTzcwZRu/ea2
         1/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228599; x=1721833399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoj6MPXt3lY6CL1odJ5ENy6WZ+0W2WmSL5RmTE2y7+c=;
        b=MaQH/rO6mO8qi8rEytj81kyrT/JY1m5ftcqJvEk1sQlo0EtCUB+hQu8MVQAndTl/eP
         ikLTrEY6pslO3F8P+53PBS1xELVlrlqkLRhMs/Vn78tGKBsxbibJxv4H47dauumz0vGe
         bpmLIh9IHR9DklOq94KbeD2zqzCUL/52UAOeoW0UmMockZ4EOup1ozIsqGYWcCozQfOV
         zQaClVUl9T7tXqIx0k/wKF3I0QSrX88LjAmnYZF2UAM2e1FTrbhbDsI+5OYF0XIUxQv9
         ZtQe2N5Yj4gGUtMWZAancvD3qjKaR9Dn1ZRpVGwkdh6SZdDardoQkekRvDThMR649FDi
         XM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWko6YP6fWfkzTQzgSoQJlkBWX0dDb6aLIAVFVZkOn/sRWBwlyZNOydLfgPpAaS4M7ZdPxdJZtOMmZ5RYkYJ72OHNggLMSBf6sXklRu
X-Gm-Message-State: AOJu0YzRMd7eJWBVK56TgPhnr8YS8q6RV5WWgsSxK3X6Yxw82ywWQQ4y
	Z0cTblhZMfwzCz3P/f2JxREFNV8yK3qm0oPzGLzWp/4JKqhZHHGD04GoiyaMsEqm5g2er/HM5BM
	zvxvwJM/VdU8Jxk9LmwABtTWRCmNowN12/82Z1g==
X-Google-Smtp-Source: AGHT+IFpEJoYB4/aLQ+2EIUEuDPzDGUgyjI1Za81GceThY75kI5rjxj1Be/WOTCW8A92e5IPmUyo1zFQeyLqZOPaOu8=
X-Received: by 2002:a05:6a00:3e08:b0:70a:f40e:f2c7 with SMTP id
 d2e1a72fcca58-70ce4fff8fdmr2379281b3a.24.1721228598728; Wed, 17 Jul 2024
 08:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-13-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-13-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:07 +0100
Message-ID: <CAJ9a7Vgg4EN+S-HpemwGMDTbfcEGcPHSgNns8k_Yr_Z-_SDD8w@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] coresight: Expose map arguments in trace ID API
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> The trace ID API is currently hard coded to always use the global map.
> Add public versions that allow the map to be passed in so that Perf
> mode can use per-sink maps. Keep the non-map versions so that sysfs
> mode can continue to use the default global map.
>
> System ID functions are unchanged because they will always use the
> default map.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-trace-id.c  | 36 ++++++++++++++-----
>  .../hwtracing/coresight/coresight-trace-id.h  | 20 +++++++++--
>  2 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 19005b5b4dc4..5561989a03fa 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -12,7 +12,7 @@
>
>  #include "coresight-trace-id.h"
>
> -/* Default trace ID map. Used on systems that don't require per sink mappings */
> +/* Default trace ID map. Used in sysfs mode and for system sources */
>  static struct coresight_trace_id_map id_map_default;
>
>  /* maintain a record of the mapping of IDs and pending releases per cpu */
> @@ -47,7 +47,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
>  #endif
>
>  /* unlocked read of current trace ID value for given CPU */
> -static int _coresight_trace_id_read_cpu_id(int cpu)
> +static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         return atomic_read(&per_cpu(cpu_id, cpu));
>  }
> @@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
>         DUMP_ID_MAP(id_map);
>  }
>
> -static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         unsigned long flags;
>         int id;
> @@ -160,7 +160,7 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>         spin_lock_irqsave(&id_map_lock, flags);
>
>         /* check for existing allocation for this CPU */
> -       id = _coresight_trace_id_read_cpu_id(cpu);
> +       id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>         if (id)
>                 goto get_cpu_id_clr_pend;
>
> @@ -196,13 +196,13 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>         return id;
>  }
>
> -static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         unsigned long flags;
>         int id;
>
>         /* check for existing allocation for this CPU */
> -       id = _coresight_trace_id_read_cpu_id(cpu);
> +       id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>         if (!id)
>                 return;
>
> @@ -254,22 +254,40 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>
>  int coresight_trace_id_get_cpu_id(int cpu)
>  {
> -       return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> +       return _coresight_trace_id_get_cpu_id(cpu, &id_map_default);
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
>
> +int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +       return _coresight_trace_id_get_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id_map);
> +
>  void coresight_trace_id_put_cpu_id(int cpu)
>  {
> -       coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> +       _coresight_trace_id_put_cpu_id(cpu, &id_map_default);
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
>
> +void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +       _coresight_trace_id_put_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id_map);
> +
>  int coresight_trace_id_read_cpu_id(int cpu)
>  {
> -       return _coresight_trace_id_read_cpu_id(cpu);
> +       return _coresight_trace_id_read_cpu_id(cpu, &id_map_default);
>  }
>  EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
>
> +int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +       return _coresight_trace_id_read_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id_map);
> +
>  int coresight_trace_id_get_system_id(void)
>  {
>         return coresight_trace_id_map_get_system_id(&id_map_default);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 49438a96fcc6..840babdd0794 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -42,8 +42,6 @@
>  #define IS_VALID_CS_TRACE_ID(id)       \
>         ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>
> -/* Allocate and release IDs for a single default trace ID map */
> -
>  /**
>   * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
>   *
> @@ -59,6 +57,12 @@
>   */
>  int coresight_trace_id_get_cpu_id(int cpu);
>
> +/**
> + * Version of coresight_trace_id_get_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>  /**
>   * Release an allocated trace ID associated with the CPU.
>   *
> @@ -72,6 +76,12 @@ int coresight_trace_id_get_cpu_id(int cpu);
>   */
>  void coresight_trace_id_put_cpu_id(int cpu);
>
> +/**
> + * Version of coresight_trace_id_put_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>  /**
>   * Read the current allocated CoreSight Trace ID value for the CPU.
>   *
> @@ -92,6 +102,12 @@ void coresight_trace_id_put_cpu_id(int cpu);
>   */
>  int coresight_trace_id_read_cpu_id(int cpu);
>
> +/**
> + * Version of coresight_trace_id_read_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>  /**
>   * Allocate a CoreSight trace ID for a system component.
>   *
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

