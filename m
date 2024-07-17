Return-Path: <linux-kernel+bounces-255328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9C933F38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D21F21A64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD51822E6;
	Wed, 17 Jul 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjjdpi3O"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AD181BAB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228646; cv=none; b=cqbM+HoNyEJU9QNvGO5CSHvbiGgHh3zagb4dUSQnYa67p0I9f6eKUPXxQJDJFIqxi+O3/5QpF0nPujqqzy4VHnBYPx6YGdrZXPouqKDq0j3LyfKYZodPJiGB/LDX+ChfDGONkXCDr+BPZYTl4uTyDvpqVp7DHRXs1ffWYrr31uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228646; c=relaxed/simple;
	bh=ltAM7XGit+2Yma7oYeKus3MLrvcpkrawHqmDb0gqPoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vkhqud4DKNmVl8ux4htJ3OxqitAsISPw0g+1gsbiCR0LtkvwTn2E4dtuFHchfQisWMitGhir0MdQX69W5coEjARMABel+3o/nXl0Ao+KZwRzk+SVIIX2brnSj5OYgVg1itJfpMsv6lp4Sx75jy6dG1Xn8uCoy0huIifQDXnBzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vjjdpi3O; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b7a528331so2904603b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228644; x=1721833444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ascaNctnq7uvd+OydTeIwlQPxoFxG0hR3xpxVorsGM=;
        b=vjjdpi3Oe1ebIqs0KLTydPCGNAJDn0iDtYhZ6C/sjGezPBcdQ+hvph3ofTRGo1Oajd
         mTbe9k7JoNi2Brkc7TcErJ1UzTZjj/4n6VnFdYVYWz2vQ9fe5vJ+ael8DoloXcdFscgB
         Z+Uvf5mIySOMySPoBh8aEpaEPTn58v+pwzNG6iifaxjCzeUSt6znDxytxu0nF11ideEW
         XCZ3ZDWr298H6jjUmYElT9t5VSFIWYJfw2x5GBDk+46op3AqBg+5jMuntqoQ4wGK/N1s
         LtX6MebSwU0pvfI3si8WL7LcrzuwJzpexEUegg4V2HJ1tx3Ow+eSvgx3ibVQsaPdeI+n
         kblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228644; x=1721833444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ascaNctnq7uvd+OydTeIwlQPxoFxG0hR3xpxVorsGM=;
        b=LhaF2uTDbegt7ciGLK4M8U02xB5IbrHb7mTgd1pp6XfQO6k/L71xotLtc80X2utkdx
         lm90mG1MUhUqav8tmBIsq2cbD3i0zIgmpbmPIiKO12GuLrijW4EjzlvkKXe0atPt/H2l
         3HEeXKL7NClNFnO61x7wHVAp6NSHHwnblVCxYrOH30RYCcUJ2S3Lw/iBXQuXtxY8/u5M
         0IVMai7qRnO4FNed2m3rqoJ3FoN1AxHl/rFUhk6TiTAVQzChla0/52dwn+Hx9l5/96jQ
         jqtl/emGeSBlIPhveND9+Oev+eUz5wXKkdd7/dYovjmZquNCqOW45xBWL6tnkZ7+WGyT
         Rnzg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZKRncOKwWNJO7QmltCgzg5e+tnFjfp6deJW7iD5fbR4obi+bNl5a+8PkDkZDOq7Wkc1p1kWTuY23Bt9yR1NOy1PwiqHw9Hko4DD6
X-Gm-Message-State: AOJu0YynDElF3hjuFEUaY9OpGPNhM2pMj8Hkh6sNcndXkIwLxxl8Hm3N
	kWwZ5ra5V4QoLzQ/vL56oAgG/JZ0Y88jEgU7qGDXbu6Uhx7hYzH9A2tDXp6HDnK/CvhHZl1jEws
	xQJZmUZN8sDBpR0qM93Og26dW/6QNgH/N/HhDMA==
X-Google-Smtp-Source: AGHT+IExqnE+FNSc7zp9dv1O/rSOtgI13egN7BdykQVCwRmNspCW10dy60NGgyaFxzHfgFQfmkcW/qpcqpGqPq4k6Fs=
X-Received: by 2002:a05:6300:668b:b0:1c3:ff89:1fc6 with SMTP id
 adf61e73a8af0-1c3ff89208amr1918330637.53.1721228644183; Wed, 17 Jul 2024
 08:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-18-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-18-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:51 +0100
Message-ID: <CAJ9a7Vg4YF-frWF2VNvhL-qyHp2wBaVD7TxzW=QG-LsUMKutHQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] coresight: Make trace ID map spinlock local to
 the map
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

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Reduce contention on the lock by replacing the global lock with one for
> each map.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  |  1 +
>  .../hwtracing/coresight/coresight-trace-id.c  | 26 +++++++++----------
>  include/linux/coresight.h                     |  1 +
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index c427e9344a84..ea38ecf26fcb 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1164,6 +1164,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>
>         if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>             csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +               spin_lock_init(&csdev->perf_sink_id_map.lock);
>                 csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
>                 if (!csdev->perf_sink_id_map.cpu_map) {
>                         kfree(csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index bddaed3e5cf8..d98e12cb30ec 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -15,12 +15,10 @@
>  /* Default trace ID map. Used in sysfs mode and for system sources */
>  static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
>  static struct coresight_trace_id_map id_map_default = {
> -       .cpu_map = &id_map_default_cpu_ids
> +       .cpu_map = &id_map_default_cpu_ids,
> +       .lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
>  };
>
> -/* lock to protect id_map and cpu data  */
> -static DEFINE_SPINLOCK(id_map_lock);
> -
>  /* #define TRACE_ID_DEBUG 1 */
>  #if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
>
> @@ -123,11 +121,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
>         unsigned long flags;
>         int cpu;
>
> -       spin_lock_irqsave(&id_map_lock, flags);
> +       spin_lock_irqsave(&id_map->lock, flags);
>         bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
>         for_each_possible_cpu(cpu)
>                 atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
> -       spin_unlock_irqrestore(&id_map_lock, flags);
> +       spin_unlock_irqrestore(&id_map->lock, flags);
>         DUMP_ID_MAP(id_map);
>  }
>
> @@ -136,7 +134,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>         unsigned long flags;
>         int id;
>
> -       spin_lock_irqsave(&id_map_lock, flags);
> +       spin_lock_irqsave(&id_map->lock, flags);
>
>         /* check for existing allocation for this CPU */
>         id = _coresight_trace_id_read_cpu_id(cpu, id_map);
> @@ -163,7 +161,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>         atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>
>  get_cpu_id_out_unlock:
> -       spin_unlock_irqrestore(&id_map_lock, flags);
> +       spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID_CPU(cpu, id);
>         DUMP_ID_MAP(id_map);
> @@ -180,12 +178,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
>         if (!id)
>                 return;
>
> -       spin_lock_irqsave(&id_map_lock, flags);
> +       spin_lock_irqsave(&id_map->lock, flags);
>
>         coresight_trace_id_free(id, id_map);
>         atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>
> -       spin_unlock_irqrestore(&id_map_lock, flags);
> +       spin_unlock_irqrestore(&id_map->lock, flags);
>         DUMP_ID_CPU(cpu, id);
>         DUMP_ID_MAP(id_map);
>  }
> @@ -195,10 +193,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
>         unsigned long flags;
>         int id;
>
> -       spin_lock_irqsave(&id_map_lock, flags);
> +       spin_lock_irqsave(&id_map->lock, flags);
>         /* prefer odd IDs for system components to avoid legacy CPU IDS */
>         id = coresight_trace_id_alloc_new_id(id_map, 0, true);
> -       spin_unlock_irqrestore(&id_map_lock, flags);
> +       spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID(id);
>         DUMP_ID_MAP(id_map);
> @@ -209,9 +207,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave(&id_map_lock, flags);
> +       spin_lock_irqsave(&id_map->lock, flags);
>         coresight_trace_id_free(id, id_map);
> -       spin_unlock_irqrestore(&id_map_lock, flags);
> +       spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID(id);
>         DUMP_ID_MAP(id_map);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 197949fd2c35..c13342594278 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -233,6 +233,7 @@ struct coresight_trace_id_map {
>         DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
>         atomic_t __percpu *cpu_map;
>         atomic_t perf_cs_etm_session_active;
> +       spinlock_t lock;
>  };
>
>  /**
> --
> 2.34.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

