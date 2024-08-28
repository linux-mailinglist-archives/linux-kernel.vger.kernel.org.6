Return-Path: <linux-kernel+bounces-305363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98A962D86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F341C235F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9EB1A3BC3;
	Wed, 28 Aug 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCBL2ah7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B841A38D5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862008; cv=none; b=sCWvk8Rpdqi4dNsxptMF9KyYslgbuL0HwWMmrevRTk9SAJhPLrkP+du31u4EVXsLO/jIJvv1y3odvT8pMvIK0/9YSbgyqly+kXIwBiZ579aogdcaJdb4Heh/OUl2b3f2ZsyT70D4SRHaxh6P0uHEdhUCUvpZNVZftpPbXlFLFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862008; c=relaxed/simple;
	bh=wbzs+I04BU9XhVPnz3eD2YQLMMfH0yIftoO8Lc0IfFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Chcp5izvyrjdt7Rho8FcRaXuT2sjm5oBvWgeelSEI8LWifQczxNgtiNZwOOAyTIi+5ngnqM7fNX/cvF7ZqaFp4Zduzgjzd/Tenhz4uIpu4NXgbsYmWaBOusNFtSev/Wy/RFvM146+ExZOl8nRz9ctt9cIS7wfTG/WAApt5MP3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCBL2ah7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso22992851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724862004; x=1725466804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L5T6bR47s8I9GFp4Od/4AURRtilJQBGgEgnTBuJ5/k=;
        b=yCBL2ah7/p9vvoGXljZN+cgGwSPrsLynKjYQGQMpTW1aKGHNkrYT58kAGKa3UoOXt9
         V2dP7ebL4G/lp7dtAQ+J6Xj/L18Cs1bjp7wxUi9/qKm1KN0ea3/H4QN9QUP15B1GLgx6
         NoX/vgNGqy8IO3TKT7h3v1bVpxqH1imp8qkZY4hYm1O5QWyHTD/Cd/Bn76dL3MqThE86
         PbvtJLp0ooqfxvFzmGngat0HAanNBB83p92O8DYhDRfF09ZcvULn0ZizJRkZccnBdegG
         P8Pt7XGVBwDi9FqV+VtkmN3XW8NSDZ8D18xo1tL5cNKEYVyyeg7Yq8KCcKTD2z2IP21j
         Rq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862004; x=1725466804;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0L5T6bR47s8I9GFp4Od/4AURRtilJQBGgEgnTBuJ5/k=;
        b=rlIBPda2NCBB98OVqssLm79zzzKVPoVOTU7iZs6QgYKYy+NzuCZhl9EWNXV+nmiHTi
         f6zs8eiyjpPN+f17paV6hIGCJNkfQ4h7mZ+VWtZlDRRJGEDfVWWn2zvFjtsPmqgPamZf
         NRujppXcy4exuKnq+BfubygFS5gGvlCjUB0ryV1ptvMCYdsf5yRy/Yjq+138GfrIdEn8
         +Dhq4tcCKcu18oHwFuzMuTAttrbarEXx5WvLfQfp/lxu9TOlDqHnfJrrfS/HmV1vfd6E
         E9DQZQX/oxqHi4VW8OO3iZ77lJ9W05L4ZkCXRtIyUZnmhjUDXfubk5DnKn4Z3STHMiiX
         3a9A==
X-Forwarded-Encrypted: i=1; AJvYcCVnDAWZNIEGZgji0ZsRk0cIURHRk8U/fZtxqGMt//+HQ5u0grMZ+4gVA3FSZ9/+4XtBB5OEMTWGmxZv38k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEyur3ubhoj69DgHHWoE2Rzecrb+QTKa2cBEeySc+8vEaBD1J
	TyFpqCKNZ9GcYP/sDvvHnAIxQ7It6/N/mX20BwE747ihKuf2hcSz8a5oSeXH5tM=
X-Google-Smtp-Source: AGHT+IFjEECQv/dy2V1ZZwU9whBHYkpP2eODfAABxUrPHqjiEIP4rRfdW9SwHOQ0hMzrY+Ls51Kb2A==
X-Received: by 2002:a2e:a545:0:b0:2f3:f4e2:869c with SMTP id 38308e7fff4ca-2f6108ad29dmr1397731fa.44.1724862003484;
        Wed, 28 Aug 2024 09:20:03 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4722b0sm2399288a12.69.2024.08.28.09.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 09:20:02 -0700 (PDT)
Message-ID: <f80c4933-6531-4578-87de-60e5eccc6cc4@linaro.org>
Date: Wed, 28 Aug 2024 17:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] perf arm-spe: Dump metadata with version 2
To: Leo Yan <leo.yan@arm.com>
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-10-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20240827164417.3309560-10-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2024 5:44 pm, Leo Yan wrote:
> This commit dumps metadata with version 2. It uses two string arrays
> metadata_hdr_fmts and metadata_per_cpu_fmts as string formats for the
> header and per CPU data respectively, and the arm_spe_print_info()
> function is enhanced to support dumping metadata with the version 2
> format.
> 
> After:
> 
>    0 0 0x4a8 [0x170]: PERF_RECORD_AUXTRACE_INFO type: 4
>    PMU Type           :13
>    Version            :2
>    Num of CPUs        :8
>      CPU #            :0
>      MIDR             :0x410fd801
>      Bound PMU Type   :-1
>      Min Interval     :0
>      Load Data Source :0
>      CPU #            :1
>      MIDR             :0x410fd801
>      Bound PMU Type   :-1
>      Min Interval     :0
>      Load Data Source :0
>      CPU #            :2
>      MIDR             :0x410fd870
>      Bound PMU Type   :13
>      Min Interval     :1024
>      Load Data Source :1
>      CPU #            :3
>      MIDR             :0x410fd870
>      Bound PMU Type   :13
>      Min Interval     :1024
>      Load Data Source :1
>      CPU #            :4
>      MIDR             :0x410fd870
>      Bound PMU Type   :13
>      Min Interval     :1024
>      Load Data Source :1
>      CPU #            :5
>      MIDR             :0x410fd870
>      Bound PMU Type   :13
>      Min Interval     :1024
>      Load Data Source :1
>      CPU #            :6
>      MIDR             :0x410fd850
>      Bound PMU Type   :14
>      Min Interval     :1024
>      Load Data Source :1
>      CPU #            :7
>      MIDR             :0x410fd850
>      Bound PMU Type   :14
>      Min Interval     :1024
>      Load Data Source :1
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 43 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 87cf06db765b..be34d4c4306a 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1067,16 +1067,49 @@ static bool arm_spe_evsel_is_auxtrace(struct perf_session *session __maybe_unuse
>   	return strstarts(evsel->name, ARM_SPE_PMU_NAME);
>   }
>   
> -static const char * const arm_spe_info_fmts[] = {
> -	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
> +static const char * const metadata_hdr_fmts[] = {
> +	[ARM_SPE_PMU_TYPE]		= "  PMU Type           :%"PRId64"\n",
> +	[ARM_SPE_HEADER_VERSION]	= "  Version            :%"PRId64"\n",
> +	[ARM_SPE_CPU_NUM]		= "  Num of CPUs        :%"PRId64"\n",
>   };
>   
> -static void arm_spe_print_info(__u64 *arr)
> +static const char * const metadata_per_cpu_fmts[] = {
> +	[ARM_SPE_CPU]			= "    CPU #            :%"PRId64"\n",
> +	[ARM_SPE_CPU_MIDR]		= "    MIDR             :0x%"PRIx64"\n",
> +	[ARM_SPE_CPU_PMU_TYPE]		= "    Bound PMU Type   :%"PRId64"\n",
> +	[ARM_SPE_CAP_MIN_IVAL]		= "    Min Interval     :%"PRId64"\n",
> +	[ARM_SPE_CAP_LDS]		= "    Load Data Source :%"PRId64"\n",
> +};
> +
> +static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
>   {
> +	unsigned int i, cpu, header_size, cpu_num, per_cpu_size;
> +
>   	if (!dump_trace)
>   		return;
>   
> -	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
> +	if (spe->metadata_ver == 1) {
> +		cpu_num = 0;
> +		header_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
> +		per_cpu_size = 0;
> +	} else if (spe->metadata_ver == 2) {

Assuming future version updates are backwards compatible and only add 
new info this should be spe->metadata_ver >= 2, otherwise version bumps 
end up causing errors when files get passed around.

I know there are arguments about what should and shouldn't be supported 
when opening new files on old perfs, but in this case it's easy to only 
add new info to the aux header and leave the old stuff intact.

> +		cpu_num = arr[ARM_SPE_CPU_NUM];
> +		header_size = ARM_SPE_AUXTRACE_V2_PRIV_MAX;
> +		per_cpu_size = ARM_SPE_AUXTRACE_V2_PRIV_PER_CPU_MAX;

I think for coresight we also save the size of each per-cpu block rather 
than use a constant, that way new items can be appended without breaking 
readers.

That kind of leads to another point that this mechanism is mostly 
duplicated from coresight. It saves a main header version, then per-cpu 
groups of variable size with named elements. I'm not saying we should 
definitely try to share the code, but it's worth keeping in mind.

> +	} else {
> +		pr_err("Cannot support metadata ver: %ld\n", spe->metadata_ver);
> +		return;
> +	}
> +
> +	for (i = 0; i < header_size; i++)
> +		fprintf(stdout, metadata_hdr_fmts[i], arr[i]);
> +
> +	arr += header_size;
> +	for (cpu = 0; cpu < cpu_num; cpu++) {
> +		for (i = 0; i < per_cpu_size; i++)
> +			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
> +		arr += per_cpu_size;
> +	}
>   }
>   
>   static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
> @@ -1383,7 +1416,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>   	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
>   	session->auxtrace = &spe->auxtrace;
>   
> -	arm_spe_print_info(&auxtrace_info->priv[0]);
> +	arm_spe_print_info(spe, &auxtrace_info->priv[0]);
>   
>   	if (dump_trace)
>   		return 0;

