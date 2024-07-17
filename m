Return-Path: <linux-kernel+bounces-255327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B24933F37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D01F211D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B78181CEA;
	Wed, 17 Jul 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGa/IhXj"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3491181BAB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228638; cv=none; b=NignjgA3TXqeUMimerXwc6t70uN8OnoxR2NYWUAg1bI2d1pH/TLnDj5ZP5DGvKZYpj6fuqbazgpg1rwuQd44hLFaLXfDonkAqG398N4ts1jREzQq626J6rJBJDCK+XlqUzKUowk2Led6v7VcwpcGBU9sqEHw4BSVixMuj2AZ0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228638; c=relaxed/simple;
	bh=3OLt9CaI68LxWwWX9xjN442w8ZNIC2ZLThIHQvtHcDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwpOe4mz6tRmTRltaq6eGrY/Wpg00dVq5GKvNNkOHKODQetytiiRzvUlmWmjwg9PxW092qGTCMg3hWGdsPJDk9Qg2bnSl7xlDjOPcEW7RkvzaKbl93l+Qi/IQhB/awJpWDjeVjDSLkgz7kzoDjtm+8sNdQEiao+SKaGolJZOGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IGa/IhXj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70afe18837cso4460532b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228636; x=1721833436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47ivNPINYDdIALCmBMGJVr8a0JPn5a19pn0RWfCpesU=;
        b=IGa/IhXjYj6wdCBiPGYkqncXhEg039UDGujr+ulQ9nKNaPmoSyX2Vu/uLDDrCU2upQ
         tk//DH3MGHXZvcvuzrBtq0ilxcdRrR2Pn4EaOgRizJUW1/zxAiXiZTUNOp7XX9UeDCng
         ASx1ffFDlMAd/Y5Ne/TsLOXRlgS+q62+xw/xF1X5ggvb3dORMagtW0hPIuf5fnquR4En
         H8eqZqrRRI0h/wiBbsQ95WamYgvwyW1uV1+NiWaFTUvd7Vb/jtvzFIInHtLY5POZlr8e
         mAdw24gHMYiLVZh6oatgroanabzreltRpwLSVXagnOvYCgMpBdQBgqtVsnamcLBKNtX7
         K+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228636; x=1721833436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47ivNPINYDdIALCmBMGJVr8a0JPn5a19pn0RWfCpesU=;
        b=EwWnVHPyqInsnv/iG8aNRSHqGfTfNlh/+j0JjC4u2UEcQJI122U+xiMo+A1O0SQvq+
         q0ObDt1YT3+10pv00EA3+zhWXenSq7+UVeLmkqfLqIQywN0IJkfIOxX4wOJO+gQpeO4L
         L9SGSesw7dpMnKGYhX+9ws/NwRpg7Kt2NyhBMkUSuuHPmPm88bF00FxrJm4abV3fMS/y
         E5yp2mRDGKSL0FaTBFJ2NT92+AjkHH9GkIES8bKK3cYWZOrIHxZeOJA33plARJ5udIJQ
         gIPBEESAEjhaM3Eu6F8Cbrl2oG8FjtZPCro4ytq0KD5VtIg+R8rQEmYXnoAQp5ETrYGT
         ao3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSvXyG4HUtK9Kyzo3ety6l7lzlHypieQOWBMSEiIvhxkdCKA1V4GImmAOR+JsKWMMZNrTMr0W2k1HVhxnnz2pqtiY1QmV6uCgfyxex
X-Gm-Message-State: AOJu0YwA1XH3REeci2L3ZZTF5J9C/61EpqgQ/ukU17Otudnbiy++3r0b
	LgYviA0k0nArLcDu8upjsMjDiRRdzRftsm1K4ionRzFg9tFuVNmIG5ueu9ilH0CuxJTgeX9DGfU
	osSgwUumF6j7Plq/ILNsweM72s4jk5aA3vwWOXA==
X-Google-Smtp-Source: AGHT+IF4Qf3S4WEbr4QPFSk2b+cX4hoD3rsc31RVhoAaJlpxpIAawZ0K1WdDi/3cWthWlp3qnOxYZxgJfBldjPTXYqQ=
X-Received: by 2002:a05:6a00:2288:b0:708:2602:f62c with SMTP id
 d2e1a72fcca58-70ce4f7476cmr2052661b3a.4.1721228635840; Wed, 17 Jul 2024
 08:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-17-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-17-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:43 +0100
Message-ID: <CAJ9a7ViwpDSpEv0niuF=wWpp4497Yp5AcnMSeh_SamWnK1QQtw@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] coresight: Emit sink ID in the HW_ID packets
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
> For Perf to be able to decode when per-sink trace IDs are used, emit the
> sink that's being written to for each ETM.
>
> Perf currently errors out if it sees a newer packet version so instead
> of bumping it, add a new minor version field. This can be used to
> signify new versions that have backwards compatible fields. Considering
> this change is only for high core count machines, it doesn't make sense
> to make a breaking change for everyone.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  | 26 ++++++++++---------
>  .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++++++++----
>  drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>  include/linux/coresight-pmu.h                 | 17 +++++++++---
>  4 files changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index faf560ba8d64..c427e9344a84 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -487,23 +487,25 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
>         return csdev;
>  }
>
> +u32 coresight_get_sink_id(struct coresight_device *csdev)
> +{
> +       if (!csdev->ea)
> +               return 0;
> +
> +       /*
> +        * See function etm_perf_add_symlink_sink() to know where
> +        * this comes from.
> +        */
> +       return (u32) (unsigned long) csdev->ea->var;
> +}
> +
>  static int coresight_sink_by_id(struct device *dev, const void *data)
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
> -       unsigned long hash;
>
>         if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> -            csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> -
> -               if (!csdev->ea)
> -                       return 0;
> -               /*
> -                * See function etm_perf_add_symlink_sink() to know where
> -                * this comes from.
> -                */
> -               hash = (unsigned long)csdev->ea->var;
> -
> -               if ((u32)hash == *(u32 *)data)
> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +               if (coresight_get_sink_id(csdev) == *(u32 *)data)
>                         return 1;
>         }
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 70c99f0409b2..ad6a8f4b70b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -460,6 +460,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>         struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>         struct list_head *path;
>         u64 hw_id;
> +       u8 trace_id;
>
>         if (!csdev)
>                 goto fail;
> @@ -512,11 +513,16 @@ static void etm_event_start(struct perf_event *event, int flags)
>          */
>         if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
>                 cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
> -               hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
> -                                  CS_AUX_HW_ID_CURR_VERSION);
> -               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> -                                   coresight_trace_id_read_cpu_id_map(cpu,
> -                                                                      &sink->perf_sink_id_map));
> +
> +               trace_id = coresight_trace_id_read_cpu_id_map(cpu, &sink->perf_sink_id_map);
> +
> +               hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
> +                               CS_AUX_HW_ID_MAJOR_VERSION);
> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
> +                               CS_AUX_HW_ID_MINOR_VERSION);
> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, trace_id);
> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
> +
>                 perf_report_aux_output_id(event, hw_id);
>         }
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 61a46d3bdcc8..05f891ca6b5c 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -148,6 +148,7 @@ int coresight_make_links(struct coresight_device *orig,
>                          struct coresight_device *target);
>  void coresight_remove_links(struct coresight_device *orig,
>                             struct coresight_connection *conn);
> +u32 coresight_get_sink_id(struct coresight_device *csdev);
>
>  #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>  extern int etm_readl_cp14(u32 off, unsigned int *val);
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 51ac441a37c3..89b0ac0014b0 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -49,12 +49,21 @@
>   * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
>   * Used to associate a CPU with the CoreSight Trace ID.
>   * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
> - * [59:08] - Unused (SBZ)
> - * [63:60] - Version
> + * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
> + *           Added in minor version 1.
> + * [55:40] - Unused (SBZ)
> + * [59:56] - Minor Version - previously existing fields are compatible with
> + *           all minor versions.
> + * [63:60] - Major Version - previously existing fields mean different things
> + *           in new major versions.
>   */
>  #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
>
> -#define CS_AUX_HW_ID_CURR_VERSION 0
> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
> +
> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
> +#define CS_AUX_HW_ID_MINOR_VERSION 1
>
>  #endif
> --
> 2.34.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

