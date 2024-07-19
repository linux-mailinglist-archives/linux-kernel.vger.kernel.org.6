Return-Path: <linux-kernel+bounces-257166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385C937618
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73014B22BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D675824AF;
	Fri, 19 Jul 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAQ1ih3j"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB12AF11
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382496; cv=none; b=u7e7LEiTzRFV2wvWkwFkd0CT+2QiyUXi3gyOT7W4G+yqPEt80v/npOFlOtsNUrF/cBgo3QpMtmesh3O1mcadW7/pHNU1gOIhd9rp6DDwxWTyEP5tjcz+tvOwFtXhbtTeWuXqQEAvHLC6o3XcyvTMK3N81UWgdbwp94XwXvMk8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382496; c=relaxed/simple;
	bh=TqsMnjBVIE3aetou6qz8juMwfKHAkCPRtLAKXnghObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfZ3zSGfysh7ZTIqsfgKJ8z9Rr+hXwANVCQLk7DqJzzdP6l6nPuK/PwqwAH15nBgCbHfAmZyrqodzdpwHwLd4Y/L7RlDZYnzT2jekrwkRn5dxKKXSUQ1v9r4nLkfwxNCKEB/Hyuu0j58kCZRd5qMGm+a/g7eo5KXufzJ7xgox50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hAQ1ih3j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso530252b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721382494; x=1721987294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhF0cG7sJRagtSnZoHiXdHI0K7iHrCSIlDJ8BuG+ZkI=;
        b=hAQ1ih3jsvY15kf/oq3yefTK3j7lMtjmSrXx7UspLVC4u/C8iPb4tdu4y7bbV1Ppm8
         D5TOmTmoUhiGkMv0X6cdzd/lgYVVTRk32UKMXprxvSUTQElv8EG+b7Zq84/Am2GL+Ngz
         pGdVrEGseIoLzQE5qklBCGUR7fGYuZV+L9gQ/6F+XyNzYGztcUCKomykFePXi9YnPRLh
         DF9hTnBD+W5DbpGSX8yO0F07EHczCPNycf3OE2I67zMSxKlPcKbTRE2v4dw7IflD2vBn
         UqGFrbZRWyaisX7M5Bivr80aLMhJJPZ0Fw142MIYYAy5d4KLy1uhNauUTpI+A6vvKexC
         Jtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382494; x=1721987294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhF0cG7sJRagtSnZoHiXdHI0K7iHrCSIlDJ8BuG+ZkI=;
        b=WsdxL1TZYrIUMkI45niIHUPtIzXIj2SCi/iISKM16l9zFY5QzuxrLyTcKM4peCuy5g
         NRA3OkPOsk9AVJ8e5+lJCqplTi/aELPMdK2JZpJ2EAXh/EQmAoBRRpCvykZs0Rm4PpvG
         tMLs1Qx8JBm4GX3Q9q2pBi4bGZVRcOCjwkZZY0kY59jWER5E5ar4NnHIR32g1pH4JOIB
         tgN6zW9LI6ydC+7UP2UqFrtzrzkFekU2SF7hqf2Ek1pDJ89gHxyoR96YohcHoLlx2nwm
         OdNKr7N/M1EU6UR6VfH+9YDcnyxtjo4VJpcpFFZbCN8qiFdSsNCYbrK1V/ypFxZ6dqIl
         pPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhD3x6bYITyfxPW6aKad9XBM4gG6Eby4ypvAj6h6Ro0zP+rcRu5AmxV9jd5/rPWuEXf3bvN1oHUuZYKRsSj/3TNxh80AXrh6/eOG/p
X-Gm-Message-State: AOJu0YyAkfERU4kqBGP+fIXJWWuv7BGEtV/GJ1BA4+5EqV0Y/AOLx3Zl
	tf9wdM/Ju30M6Lay2EQOl8/UZpPVafJR/osxsRHIU1a8UZq2jLfcwoN6yRJY6rd7u5y8/ELq24I
	HoAGfX+7BnCMQcgKer1mENGvZTE/q6cjhWFyIaw==
X-Google-Smtp-Source: AGHT+IHcgE/Y9hI4BdyGlcUQ74l1W4Cc3qlxjGfyBSOFidXWRgWEk1+LeD0CU6f5+lT4z1P3UEG/is9BsEE60bvH2tc=
X-Received: by 2002:a05:6a00:17a1:b0:70b:1c7e:829a with SMTP id
 d2e1a72fcca58-70ce503ea93mr9291348b3a.32.1721382493696; Fri, 19 Jul 2024
 02:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org>
 <20240712102029.3697965-17-james.clark@linaro.org> <CAJ9a7ViwpDSpEv0niuF=wWpp4497Yp5AcnMSeh_SamWnK1QQtw@mail.gmail.com>
 <3b2285e0-3ac2-448a-8a53-c1bb6ead78b8@linaro.org>
In-Reply-To: <3b2285e0-3ac2-448a-8a53-c1bb6ead78b8@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 19 Jul 2024 10:48:02 +0100
Message-ID: <CAJ9a7VgQ5JfxObZpxbQdiEciOjkuijH98HFfdFVK4qkn7qbNUQ@mail.gmail.com>
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

Indeed! missed out the:

Reviewed-by: Mike Leach <mike.leach@linaro.org>

On Fri, 19 Jul 2024 at 10:29, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 17/07/2024 4:03 pm, Mike Leach wrote:
> > On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
> >>
> >> From: James Clark <james.clark@arm.com>
> >>
> >> For Perf to be able to decode when per-sink trace IDs are used, emit the
> >> sink that's being written to for each ETM.
> >>
> >> Perf currently errors out if it sees a newer packet version so instead
> >> of bumping it, add a new minor version field. This can be used to
> >> signify new versions that have backwards compatible fields. Considering
> >> this change is only for high core count machines, it doesn't make sense
> >> to make a breaking change for everyone.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-core.c  | 26 ++++++++++---------
> >>   .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++++++++----
> >>   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> >>   include/linux/coresight-pmu.h                 | 17 +++++++++---
> >>   4 files changed, 39 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> >> index faf560ba8d64..c427e9344a84 100644
> >> --- a/drivers/hwtracing/coresight/coresight-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-core.c
> >> @@ -487,23 +487,25 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
> >>          return csdev;
> >>   }
> >>
> >> +u32 coresight_get_sink_id(struct coresight_device *csdev)
> >> +{
> >> +       if (!csdev->ea)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * See function etm_perf_add_symlink_sink() to know where
> >> +        * this comes from.
> >> +        */
> >> +       return (u32) (unsigned long) csdev->ea->var;
> >> +}
> >> +
> >>   static int coresight_sink_by_id(struct device *dev, const void *data)
> >>   {
> >>          struct coresight_device *csdev = to_coresight_device(dev);
> >> -       unsigned long hash;
> >>
> >>          if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> >> -            csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> >> -
> >> -               if (!csdev->ea)
> >> -                       return 0;
> >> -               /*
> >> -                * See function etm_perf_add_symlink_sink() to know where
> >> -                * this comes from.
> >> -                */
> >> -               hash = (unsigned long)csdev->ea->var;
> >> -
> >> -               if ((u32)hash == *(u32 *)data)
> >> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> >> +               if (coresight_get_sink_id(csdev) == *(u32 *)data)
> >>                          return 1;
> >>          }
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index 70c99f0409b2..ad6a8f4b70b6 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -460,6 +460,7 @@ static void etm_event_start(struct perf_event *event, int flags)
> >>          struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> >>          struct list_head *path;
> >>          u64 hw_id;
> >> +       u8 trace_id;
> >>
> >>          if (!csdev)
> >>                  goto fail;
> >> @@ -512,11 +513,16 @@ static void etm_event_start(struct perf_event *event, int flags)
> >>           */
> >>          if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
> >>                  cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
> >> -               hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
> >> -                                  CS_AUX_HW_ID_CURR_VERSION);
> >> -               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> >> -                                   coresight_trace_id_read_cpu_id_map(cpu,
> >> -                                                                      &sink->perf_sink_id_map));
> >> +
> >> +               trace_id = coresight_trace_id_read_cpu_id_map(cpu, &sink->perf_sink_id_map);
> >> +
> >> +               hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
> >> +                               CS_AUX_HW_ID_MAJOR_VERSION);
> >> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
> >> +                               CS_AUX_HW_ID_MINOR_VERSION);
> >> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, trace_id);
> >> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
> >> +
> >>                  perf_report_aux_output_id(event, hw_id);
> >>          }
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> >> index 61a46d3bdcc8..05f891ca6b5c 100644
> >> --- a/drivers/hwtracing/coresight/coresight-priv.h
> >> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> >> @@ -148,6 +148,7 @@ int coresight_make_links(struct coresight_device *orig,
> >>                           struct coresight_device *target);
> >>   void coresight_remove_links(struct coresight_device *orig,
> >>                              struct coresight_connection *conn);
> >> +u32 coresight_get_sink_id(struct coresight_device *csdev);
> >>
> >>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
> >>   extern int etm_readl_cp14(u32 off, unsigned int *val);
> >> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> >> index 51ac441a37c3..89b0ac0014b0 100644
> >> --- a/include/linux/coresight-pmu.h
> >> +++ b/include/linux/coresight-pmu.h
> >> @@ -49,12 +49,21 @@
> >>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> >>    * Used to associate a CPU with the CoreSight Trace ID.
> >>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
> >> - * [59:08] - Unused (SBZ)
> >> - * [63:60] - Version
> >> + * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
> >> + *           Added in minor version 1.
> >> + * [55:40] - Unused (SBZ)
> >> + * [59:56] - Minor Version - previously existing fields are compatible with
> >> + *           all minor versions.
> >> + * [63:60] - Major Version - previously existing fields mean different things
> >> + *           in new major versions.
> >>    */
> >>   #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
> >> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
> >> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
> >>
> >> -#define CS_AUX_HW_ID_CURR_VERSION 0
> >> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
> >> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
> >> +
> >> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
> >> +#define CS_AUX_HW_ID_MINOR_VERSION 1
> >>
> >>   #endif
> >> --
> >> 2.34.1
> >>
> >
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK
>
> Hi Mike,
>
> I think you miss-sent this one
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

