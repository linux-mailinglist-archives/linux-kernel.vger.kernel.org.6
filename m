Return-Path: <linux-kernel+bounces-513315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733BA348C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FE4162FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025F20110B;
	Thu, 13 Feb 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EN0qjHgl"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF81FECCF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462414; cv=none; b=sFb7f2nEGVtMKdfqZVTK2uMWbAJiB7qUHaw+kiTvUIl6piAeWfrP7IIlj5C419w0UAwjSZZEDsHxOTqYbF4qpqfVzCzARCd6MdJHBBcnen6MkTBVyF3gXQdUeNwHffH+s1id4c7tUVXQODHFotR8WCa7NRfXHiforYR0BxSdRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462414; c=relaxed/simple;
	bh=tlRPiujx2gpWjfA34WayAz3yoK4kn0l7/eSxXnmoqwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ6ujQvSAulkAsS2kU41aXdPED5ZNDvIT+2PvCwJ+X+LOjNaHwJXSRrAwBbKSVCpuf2fP8pBe+uaRELbC7gja02ZJhZh6AHt/R0JdHzhQ3tgCh++ASgiUFTnVegRSuf28QOhjl0Dsx1k2dUFqW/aS4Kr8lOnT6ZeoNoTiXWZ4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EN0qjHgl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43937cf2131so7519735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739462410; x=1740067210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgDN29uKkb88V0um0RfTC0vvM9HPPQBtETeV1yITKoQ=;
        b=EN0qjHglBCoTCzA3Ds2BSJiJ6m9xNeIJ0oiFNXfvnMbcZ21hr9u/2BAUX09eke7JWM
         0RZs86NWHB3dCVdFz+TvVZPjPDa3cA/6LV2/FI+TeDhYrUETU1Fd0KVyQDbfMzoz3eOI
         JdVsZ6jsKnv9AB6VEJURIrkCXayWr29OATehm0vGQ8V4vXxEY0TsQRuhl+Q5Xh/BYwnG
         mwNU+Je7dKBM4x/qEAcOIZA/CN4BhnlU16y4fUwVJVWzUf//2gPMINxJzLcVQbXQ29NN
         R8DW6thZo0RYqTZ4ZB+YVFyfWXU93nozAZF0EKuQXRrRAQgxEr3DU9fqu934KFN+KUZh
         wYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462410; x=1740067210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgDN29uKkb88V0um0RfTC0vvM9HPPQBtETeV1yITKoQ=;
        b=xVKo6i0hABFxasVoKZkFlPJ9ycSBgoVfL55DhlBSYNowKHG9mvyc7WfcN9vSWj27zF
         qAPknvRjNfG4Po5CwqUOEEEFP1z14JgXLusizJDQuWaBy4Jjav8tRVyMK2zu3PTFGw+h
         MxdEFNykUTY+jmCzXlt0JNXD+5oPFV/V2sh8pVg9bw2qiIxFIVaq4JXgZQSU3FPY7kD0
         1cPvjhr/qm7qJ0wnYaKv8oCflosLmgd9KdfUvX59/pkTqlS9UY9Mc+/XgLQva02aGOhJ
         pO3UrqQp07m6J26vh3GCgQVN4qIQs+uIeZDPB2vBJ73EHa77eXlsBWw0oxJg1sPzbMcU
         EMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWr5fsiJrd2qg7SptqYgX5zFutfyilC9TWrqOQLw7kQaTjqhpnxgxb/RAP/pAtM1n5qhr/tMLQLBMTsXVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LNXMHFaxqIWdnd7H16BLEIU99ngk3YbknzMzA1zG+VG67WJh
	Pfy/Vy8N+L6yEVx0/oHY66v71qGdnxkuffSNK+2SLli6I8UNCyO3JreDPZjU+/c=
X-Gm-Gg: ASbGnctxbOpcOEe1c6thCm2iUjCqTvxGgBXQgWoY6IPuLtRt5IHSB+bN+bHDzbcdCu2
	T3nsp/sJ9PMkS97IkCG+CvrvbU4VmkLCQfDiScoSsQXi230FAk6ZMYTKACL5CD9iEQ9gpjZJAwf
	sCW96FLbazn9aNkBVtjB5rzS8C5leLxVAy5w5d+YB64E3NlUzbINgbFUjjevdMilkhOqAx1D/Im
	60X2dmcb7BTmtkr/CdA+1atIowAtsm18GKpIDUCoSQfjyDeXLHVB0u93cYictPPtfxCdSsWHIKQ
	pFSn2urToc9qJKEBKtgqp1uvVg==
X-Google-Smtp-Source: AGHT+IF/wXtprc1U4VPmJ1pAueprsYzKR20H2MkrRTKmejrcGzsEoDZgejq84H03liicKIeACJ4WAA==
X-Received: by 2002:a05:6000:2ce:b0:38f:287a:43e2 with SMTP id ffacd0b85a97d-38f287a45b1mr2767766f8f.11.1739462408125;
        Thu, 13 Feb 2025 08:00:08 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dd5acsm2283106f8f.35.2025.02.13.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:00:07 -0800 (PST)
Message-ID: <a633f52c-81e8-4c0d-aca7-cc18360866eb@linaro.org>
Date: Thu, 13 Feb 2025 16:00:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/7] Coresight: Introduce a new struct coresight_path
To: Jie Gan <quic_jiegan@quicinc.com>
Cc: Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20250207064213.2314482-1-quic_jiegan@quicinc.com>
 <20250207064213.2314482-5-quic_jiegan@quicinc.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250207064213.2314482-5-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/02/2025 6:42 am, Jie Gan wrote:
> Add 'struct coresight_path' to store the data that is needed by
> coresight_enable_path/coresight_disable_path. The structure will be
> transmitted to any required devices to enable related funcationalities.
> 
> The trace_id will be allocated after the path is built. Consequently,
> The ETM3x and ETM4x devices will directly read the trace_id from path
> which result in etm_read_alloc_trace_id and etm4_read_alloc_trace_id
> being deleted.
> 
> Co-developed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 106 +++++++++++++-----
>   drivers/hwtracing/coresight/coresight-dummy.c |   5 +-
>   .../hwtracing/coresight/coresight-etm-perf.c  |  30 +++--
>   .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
>   drivers/hwtracing/coresight/coresight-etm.h   |   1 -
>   .../coresight/coresight-etm3x-core.c          |  54 ++-------
>   .../coresight/coresight-etm4x-core.c          |  54 ++-------
>   drivers/hwtracing/coresight/coresight-etm4x.h |   1 -
>   drivers/hwtracing/coresight/coresight-priv.h  |  12 +-
>   drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
>   drivers/hwtracing/coresight/coresight-sysfs.c |  17 ++-
>   drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
>   include/linux/coresight.h                     |  12 +-
>   13 files changed, 143 insertions(+), 157 deletions(-)
> 
[...]
> @@ -352,7 +352,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	 * CPUs, we can handle it and fail the session.
>   	 */
>   	for_each_cpu(cpu, mask) {
> -		struct list_head *path;
> +		struct coresight_path *path;
>   		struct coresight_device *csdev;
>   
>   		csdev = per_cpu(csdev_src, cpu);
> @@ -405,15 +405,15 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   			cpumask_clear_cpu(cpu, mask);
>   			continue;
>   		}
> -
>   		/* ensure we can allocate a trace ID for this CPU */
> -		trace_id = coresight_trace_id_get_cpu_id_map(cpu, &sink->perf_sink_id_map);
> -		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
> +		trace_id = coresight_path_assign_trace_id(path, CS_MODE_PERF);
> +
> +		/* Can be 0 and valid, ETE doesn't need an ID */
> +		if (trace_id < 0) {

Not sure why I wrote it like this, but I think we should leave it as it 
was with !IS_VALID_CS_TRACE_ID(). Even with ETE it calls the trace ID 
allocator, so nothing has changed here.


