Return-Path: <linux-kernel+bounces-257134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A689375B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BFB21ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7C81AC3;
	Fri, 19 Jul 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/oP2YcR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DD55769
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381383; cv=none; b=Fbk/BOiRDQfy0pKL062g983s7UcLMsLKuHapAWuC+B8wJ8OIZ7hCbd7p61Ai6T9Q/pyP+3ZyMgcg14MORo/LCneROzupNfM6bgs5v2WP5riLhmcs/B6vyxgoZjCIvGKlDvXNX+wYAz3Vnbef/Z30h+sG1ctZR6klNBCSuOlmqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381383; c=relaxed/simple;
	bh=NAueijy5O1aNzZDnhVGZIyKB0Cyg+gH6V2H70ZoJcJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jziRIq4TpPkQ4fP6N7RFwh5uLIqqwFNIaJKtDj7xJ28/q3ZWgM53R1XPzq7/wsS7IkLD5FcyIc1VHUE9VxWR8uaPc3oSBTlNuHLR+uqbJZ8BqXZ4QNBc3j+dVAqPiMrCvKN1eMeIE8gIlaahZ/N3D0P3Geqlcn6gyjdsAIui+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/oP2YcR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684407b2deso476400f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721381379; x=1721986179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeUxxx4F06ytA/JpMebP2usYOntjakHjEB1FCSY1FhA=;
        b=a/oP2YcR+Ahe0ogA1lI8+2IbinS7qIp6s3xM3BwVx7toWfMXCq+8N6oMx99ioYfgWr
         2OSUi7UGBvF0VotTwCFRogT7yhQ2Z9Vh5f9yHisqhk6DbOhsf7FsjMoypic34H7WhRKt
         9u61mc+A1sIUQme+3Eb8cvdF5yzvZQNyMQ/XQD2mSK4uxocpipndOtvpEHH6BNXumblI
         8vfDZpcS9RWBqWOzX3+T+AgcAVK8YbgW4tlyEbDjjbT6oQxpTk3wr9ReICOZpFjwQIgW
         c9sey5Q610cPOCzdgN1vn7WJtBrOVygT9cNhW0ajcwMO3fmxQRekWuN6avFqLFVsHEAV
         D3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381379; x=1721986179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeUxxx4F06ytA/JpMebP2usYOntjakHjEB1FCSY1FhA=;
        b=WUIrSgWGuypZj0zu5R17683tAS15ddx2/fy/tTtph41T9McWaoNN9sC4EqLUOli6xR
         Nd8KPlIJfCisRc7/4ErAoCI+7AK3kugRdUNuwwcYrVooCXIT+crcpf2TXszKgkslZBiz
         5jKmVWQqqPuHFw4s6c/Mu+eYjYbmL6uBBNeRIiB8fDb//k4I9BH0p/X4AUlDRC/Ppz2Y
         /ThnJ90wEoZ0zn6F2MkVavR29Nm2joow/7EVxGqIuMqn/5WcdcmSsblZRtmqPLAtNqO/
         gqyLQW7otOVD1/001WIHWjeDhqQqrL8bqqYk/0+RIHUmOFr7cfml6dS6a6z0VCBNKW7L
         098A==
X-Forwarded-Encrypted: i=1; AJvYcCX2Wepug5L7HNeOg46ip1k0tC9qnorWZFPTep/CqdKCFQovL5B45Mr7wbB47qee7L+wx7Iy8ktlaWoKhL0YmkUmRtoGUoBH75t9u5sX
X-Gm-Message-State: AOJu0YyPwRrrjQoPBTrnB/uNYG+qYY5PtwviOko70fLe0zleSD4qRLWu
	C6AMWOQPqur9nGFQoT8pLM5DoQMUej+Uj5SD+6jeEC8khIkuzNR/qSwYREUda1s=
X-Google-Smtp-Source: AGHT+IF2ccBsKb4YBezxTdfv3XQrmsfj5+RMN8Bx+uHeZXY6Lc5X+rfSG8nLNZeu/FWDf5tAfDywLw==
X-Received: by 2002:a5d:6488:0:b0:366:ebd1:3bc1 with SMTP id ffacd0b85a97d-368316002e9mr6055066f8f.3.1721381379395;
        Fri, 19 Jul 2024 02:29:39 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684773sm1093350f8f.7.2024.07.19.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:29:39 -0700 (PDT)
Message-ID: <3b2285e0-3ac2-448a-8a53-c1bb6ead78b8@linaro.org>
Date: Fri, 19 Jul 2024 10:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/17] coresight: Emit sink ID in the HW_ID packets
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 gankulkarni@os.amperecomputing.com, leo.yan@linux.dev,
 anshuman.khandual@arm.com, James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240712102029.3697965-1-james.clark@linaro.org>
 <20240712102029.3697965-17-james.clark@linaro.org>
 <CAJ9a7ViwpDSpEv0niuF=wWpp4497Yp5AcnMSeh_SamWnK1QQtw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7ViwpDSpEv0niuF=wWpp4497Yp5AcnMSeh_SamWnK1QQtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 4:03 pm, Mike Leach wrote:
> On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
>>
>> From: James Clark <james.clark@arm.com>
>>
>> For Perf to be able to decode when per-sink trace IDs are used, emit the
>> sink that's being written to for each ETM.
>>
>> Perf currently errors out if it sees a newer packet version so instead
>> of bumping it, add a new minor version field. This can be used to
>> signify new versions that have backwards compatible fields. Considering
>> this change is only for high core count machines, it doesn't make sense
>> to make a breaking change for everyone.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c  | 26 ++++++++++---------
>>   .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++++++++----
>>   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>>   include/linux/coresight-pmu.h                 | 17 +++++++++---
>>   4 files changed, 39 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index faf560ba8d64..c427e9344a84 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -487,23 +487,25 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
>>          return csdev;
>>   }
>>
>> +u32 coresight_get_sink_id(struct coresight_device *csdev)
>> +{
>> +       if (!csdev->ea)
>> +               return 0;
>> +
>> +       /*
>> +        * See function etm_perf_add_symlink_sink() to know where
>> +        * this comes from.
>> +        */
>> +       return (u32) (unsigned long) csdev->ea->var;
>> +}
>> +
>>   static int coresight_sink_by_id(struct device *dev, const void *data)
>>   {
>>          struct coresight_device *csdev = to_coresight_device(dev);
>> -       unsigned long hash;
>>
>>          if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> -            csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>> -
>> -               if (!csdev->ea)
>> -                       return 0;
>> -               /*
>> -                * See function etm_perf_add_symlink_sink() to know where
>> -                * this comes from.
>> -                */
>> -               hash = (unsigned long)csdev->ea->var;
>> -
>> -               if ((u32)hash == *(u32 *)data)
>> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>> +               if (coresight_get_sink_id(csdev) == *(u32 *)data)
>>                          return 1;
>>          }
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 70c99f0409b2..ad6a8f4b70b6 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -460,6 +460,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>>          struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>>          struct list_head *path;
>>          u64 hw_id;
>> +       u8 trace_id;
>>
>>          if (!csdev)
>>                  goto fail;
>> @@ -512,11 +513,16 @@ static void etm_event_start(struct perf_event *event, int flags)
>>           */
>>          if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
>>                  cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
>> -               hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>> -                                  CS_AUX_HW_ID_CURR_VERSION);
>> -               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
>> -                                   coresight_trace_id_read_cpu_id_map(cpu,
>> -                                                                      &sink->perf_sink_id_map));
>> +
>> +               trace_id = coresight_trace_id_read_cpu_id_map(cpu, &sink->perf_sink_id_map);
>> +
>> +               hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
>> +                               CS_AUX_HW_ID_MAJOR_VERSION);
>> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
>> +                               CS_AUX_HW_ID_MINOR_VERSION);
>> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, trace_id);
>> +               hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
>> +
>>                  perf_report_aux_output_id(event, hw_id);
>>          }
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> index 61a46d3bdcc8..05f891ca6b5c 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -148,6 +148,7 @@ int coresight_make_links(struct coresight_device *orig,
>>                           struct coresight_device *target);
>>   void coresight_remove_links(struct coresight_device *orig,
>>                              struct coresight_connection *conn);
>> +u32 coresight_get_sink_id(struct coresight_device *csdev);
>>
>>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>>   extern int etm_readl_cp14(u32 off, unsigned int *val);
>> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
>> index 51ac441a37c3..89b0ac0014b0 100644
>> --- a/include/linux/coresight-pmu.h
>> +++ b/include/linux/coresight-pmu.h
>> @@ -49,12 +49,21 @@
>>    * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
>>    * Used to associate a CPU with the CoreSight Trace ID.
>>    * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
>> - * [59:08] - Unused (SBZ)
>> - * [63:60] - Version
>> + * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
>> + *           Added in minor version 1.
>> + * [55:40] - Unused (SBZ)
>> + * [59:56] - Minor Version - previously existing fields are compatible with
>> + *           all minor versions.
>> + * [63:60] - Major Version - previously existing fields mean different things
>> + *           in new major versions.
>>    */
>>   #define CS_AUX_HW_ID_TRACE_ID_MASK     GENMASK_ULL(7, 0)
>> -#define CS_AUX_HW_ID_VERSION_MASK      GENMASK_ULL(63, 60)
>> +#define CS_AUX_HW_ID_SINK_ID_MASK      GENMASK_ULL(39, 8)
>>
>> -#define CS_AUX_HW_ID_CURR_VERSION 0
>> +#define CS_AUX_HW_ID_MINOR_VERSION_MASK        GENMASK_ULL(59, 56)
>> +#define CS_AUX_HW_ID_MAJOR_VERSION_MASK        GENMASK_ULL(63, 60)
>> +
>> +#define CS_AUX_HW_ID_MAJOR_VERSION 0
>> +#define CS_AUX_HW_ID_MINOR_VERSION 1
>>
>>   #endif
>> --
>> 2.34.1
>>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK

Hi Mike,

I think you miss-sent this one


