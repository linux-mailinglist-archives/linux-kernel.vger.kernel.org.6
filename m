Return-Path: <linux-kernel+bounces-565983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792AA671C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F283A96CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55F209689;
	Tue, 18 Mar 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCBKcgP3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60E2080C3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294831; cv=none; b=H3FzMPWaE1hs1xvfxSZtEElOY0WBJT+aiCVTRjyl/VSBANrcTgI+myB1weUJ6FcI03e16VIAJ1zR1guKAGaei8/I/H8IDggp6OVo36EGvw0ZuVwtQ9ehMattFEAtYuuEbDqakRlTEXsFut8YYPKLCqZ1kYqXci4LwLlqPDlv3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294831; c=relaxed/simple;
	bh=Y34qxDTwNMg0m9MBtsSoqkiAcL4CddgiFLwuhpRSLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFNo02d6E7f1jR7jOeN2DedWpvK2t7aB8UsASO106jPwKDxDa8xEyzdydpR8ruJn6Id60NfAUjXQlNbCLc8/EGkW2FgTzCm6mg4V71fe9h3Mhtl6Nqe4oGesWPe4I44iytUAp3Z/pFFuzOEDovy8ALLxra6cepRCaUiNBtXQzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCBKcgP3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912baafc58so4678370f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742294824; x=1742899624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wfB7k7gMEQrYDY7VtPxjD0ttrzFbn4Ekh8A5LusVLg=;
        b=QCBKcgP3h//TDCB8AcFEMwejhJ/kx5BpU1aKbmo1Xv23u7ms2l1buKTwYaXNwiqXrU
         6IWQa/7RAApEizxaokk6GNELjSF7QWKuADK1aG6FLQQXhlta3uvRRQXUtcAVqKn2uxio
         15b2pB7ahaoMx+TzVZEhFJf2Cm7scFO+F0QAFX7/EpW6fxPOiDuzyw5BPSuWTiUXN+g8
         3XbaxLHjZj2nvkwyDmeMWz98oHzh/Oj35tDfWBvqbk9JJtISbNQ8Tb04qzDq5gwuiXe3
         QfHz3CLi291khFmtMP63TRpWk2LYaTlu7VNn3RVaBV6xvYFGSrpGlPWQcVYyHr4uWwDY
         XWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294824; x=1742899624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wfB7k7gMEQrYDY7VtPxjD0ttrzFbn4Ekh8A5LusVLg=;
        b=odn/KlTXZKcAkFjWRstXV48e00iq/M291+wgyKt5yzuvPXuuA0UJASUdtWyIToSAJE
         oz0+OBKedE4LXMBiHaDwre1LpT6K+8S0gwknozN78rtaxhq+3gO4SE1uOgWt0SlDBcQr
         Koq9iiwTaIMIbQeuh/zJ1SDaoSudIgWtk7eMhAe5rBd2XI96pxP2KlOx0hSXRDvjKEjW
         E83j3IyUH1N23pCMMmPIPviJJIfyua/07Dx4nwtw+fhQ03+9AXC3vifEr8iWDJGwpyqr
         iBUvX/2f8KX5nkZxTxA5HDndR2wi/xPJdofAAbH4hCilub1aOAwm0TnF+18nqaSbRfUS
         BXlg==
X-Forwarded-Encrypted: i=1; AJvYcCUim9/qWbULz79GdFDREgEq3i+W4MZekr9BdceH799AUeXrTTMLUHPidqENMMs30yKuoKFANi2hZHoyQgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMs6C20v0sIWd4HfjlEz2cPCEUPc2/+hZxu1g7lkRCWBnJE6f
	sV9PBABVWp1hpu+1/vxf1RXmwHVE7btuS3WcnEcbfCertSiaVLb9xJC5LblbTlE=
X-Gm-Gg: ASbGncv6EAlYjt5Cj1GnPcx7Ao8IYafSquHOR0ZTz+LqY/kWqxGR2zQ3J8RdtfzwckK
	8OOUSdTOvTOdk1l0KcL4siFF0EHh6GHfXZFNCJfeEU5LyH5liDQs9DMYLeoRuQeRtHmqTSNaZcH
	/SQQzRgyF1Y9WYz7BeBVCF/KeByEt+w3MJaLmOYZcrVp3Jgddy9b+Bsu7UQUuFhAfgWwhPnLJa/
	DvPzGKfwk21n55Q3R8NwoYQ8zgggtCpjQG0RVrOhrOOlL43IuLXE81tDuUJHmdk+mXmpWY7vp8C
	DY4jDTaqT9pHnaIACpBMzOTA+9QxmlYIDvyzhnSw04j9iTmmQzNnxg==
X-Google-Smtp-Source: AGHT+IG0L+hGt6w3IZk92zDd4DNaC/NC9eZTtg+wTxtfM4mV6V6YpzKmb5xSvPPVdoJTGLTCbNMaHQ==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr14129706f8f.9.1742294824127;
        Tue, 18 Mar 2025 03:47:04 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm17880141f8f.62.2025.03.18.03.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:47:03 -0700 (PDT)
Message-ID: <880bebc4-5a59-451e-beb2-60cee9a3efd5@linaro.org>
Date: Tue, 18 Mar 2025 10:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf vendor events arm64 AmpereOneX: Fix
 frontend_bound calculation
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
 <20250313201559.11332-3-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313201559.11332-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 8:15 pm, Ilkka Koskinen wrote:
> frontend_bound metrics was miscalculated due to different scaling in
> a couple of metrics it depends on. Change the scaling to match with
> AmpereOne.
> 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index c5d1d22bd034..5228f94a793f 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -229,19 +229,19 @@
>       },
>       {
>           "MetricName": "slots_lost_misspeculation_fraction",
> -        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
> +        "MetricExpr": "100 * (OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
>           "BriefDescription": "Fraction of slots lost due to misspeculation",
>           "DefaultMetricgroupName": "TopdownL1",
>           "MetricGroup": "Default;TopdownL1",
> -        "ScaleUnit": "100percent of slots"
> +        "ScaleUnit": "1percent of slots"
>       },
>       {
>           "MetricName": "retired_fraction",
> -        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
> +        "MetricExpr": "100 * OP_RETIRED / (CPU_CYCLES * #slots)",
>           "BriefDescription": "Fraction of slots retiring, useful work",
>           "DefaultMetricgroupName": "TopdownL1",
>           "MetricGroup": "Default;TopdownL1",
> -        "ScaleUnit": "100percent of slots"
> +        "ScaleUnit": "1percent of slots"

I never considered that ScaleUnit could be an issue when the metric was 
included in other metrics with different scales. Seems like an easy trap.

Reviewed-by: James Clark <james.clark@linaro.org>


