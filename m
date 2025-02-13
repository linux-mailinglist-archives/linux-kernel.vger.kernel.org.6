Return-Path: <linux-kernel+bounces-512722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9BA33CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C15188B516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50422080D4;
	Thu, 13 Feb 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql+NBd07"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BB41C6A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443933; cv=none; b=DJHcf48/vuqoBSyU39LrAGR185KU+3V2+fG5Y/p4bSJtS4ZViwqKMFubkWb97R36FdkCGEkE1qU0B9YKh3/OvJIEwYYTTE0fvOPIdPEohzH9/sXuCgHmpqXkchlwQHp6m/vtBwyFBH0OmcacOI9qtGXU2ynuar8RGsWTQ7umDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443933; c=relaxed/simple;
	bh=NNwffCnuthUEjMjoVnRCHsMOFoRrFLd5Mhj8Yauwhdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx6pH7Ko5udpVldVoOqkmxtWSDSm2kVobmRJvqCZEJhMWBuwVU8Ia8kCQw+39gv8K2wKVHJE8daEh6PLmFVnSkgECzsRE3g4UzoQMq0Y84F/GXn8PWPx7Vj17/x5+13dpVloU5l6xuVurWxO/y8U7NpJooKxGn763ho6j5VcZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ql+NBd07; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so7946405e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739443929; x=1740048729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfW5BGT5pTjwhGTP5m8htmZ9lluyeh+guldKWayNHGg=;
        b=Ql+NBd07wdb2Wocy3/1v4nmddOreDXblFy8bt9LFQAgaMtumy9PoPw/TQO0gi0kXyZ
         WmpDSe3A7cmnbEuuZ2SoalS8Ec9vf2RntUiPDVpw+ihmlLuLmuwV+VCDRxYfhK6uTbu0
         ARS4ZVT6JxsvIRkQHSAfKurRgumkV5ppGtRN7kk7TXWYUhBGF7OEazHrR796YDpztpVf
         PR+j5EkjVgqYQj+/YdBC45JZypvPjnpfRfJT7DsliPsXiBguXbA998zaTJpBTSkltxeV
         GRvuAUZJmVvaDMbkR6bF/yCsBwxAvgF5zfSUHuQ6T87nHkiwrJuL46joem0tMS4tVVUh
         mgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443929; x=1740048729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfW5BGT5pTjwhGTP5m8htmZ9lluyeh+guldKWayNHGg=;
        b=TYxxdXD9TNiqv9VTgDbw/SFonDKS1CuIFCG/hVhlOPFoBwW9RcZ0fL6leLty3lJopi
         /KYAa8wY3FcMRbQp58QtPhG0KQOv9sQJ7k7w8aoGIWjhRw0guTp1mk34Uw1FDfCp1Y2b
         cFdaN0swGdSaHnY55cRk6Miyilq5x2TVXE/llvclLnK08aaDdc1IZTMp/I6WUMowJydl
         IecRbLW3FpvD9q+UtIsIxGTTqBqk1b3Yymvh46NHiPrEVixWo0QbeGUm7ePVSgMsEA28
         cZZYhnO7Cf21Blij9uPkR2LMz1NDyLrDUqLeSGEX/h2AryjL8M237sRpTaXwcL7CQn7g
         pjOg==
X-Forwarded-Encrypted: i=1; AJvYcCVScA8VWJWhDZv9MnZUO64KrdRph0LwSg+MqdA/7LGFUuD40DCyYPk6t4iPlstWk3A58FiGsuDuwW5JUGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEFJYTZkx+vrkz/ooGL51jXBHbBgeFdGEbP46yjj3IHgTg3YP
	8BcQgOzfBi7nOyK0CzmWwS98tUWEkEFYuhZyk2G/0QAxSA3w0G3elYmItLo3erw=
X-Gm-Gg: ASbGncthNFOFMVMVQgrgPmuRrkClV4kY4s8L5Qh4E+RsbaRQyPeUjkAp4QuvaO1y1Fi
	VJ9G2vGwscSPCtHbgzvnBe75YvF82sPGqxxfJf/DyEJPrXbYxT8sQhFSzvr3dFd1FAYk4Jx6NQm
	9KbEsoHg43PHe3maSJ1plHdptHAOMae8zGLNObTfmQmp3ULHYHy9Vv6WpKeJw8kfJe2mIwV1+mP
	KOEFdIqDiURxlN7h3weXmVmyUKiVgnIdrLnDuW6EN2QwMMuWJOYZBvfKfwHilN5Yx9Zc+uktQPm
	dYA8pdAHLzwIrtyDn3kVrkzYWg==
X-Google-Smtp-Source: AGHT+IE3cVCMFeTiplAdl6oIol2hwK+z0KRfMjE6tnhaJF9qrn7yWiTvmVjpIcI0wTDSh3lcSVhCfg==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr64782085e9.22.1739443929479;
        Thu, 13 Feb 2025 02:52:09 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617ffa28sm13991045e9.14.2025.02.13.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:52:08 -0800 (PST)
Message-ID: <5f4e90f2-1956-4f12-b2f4-b355012beb6e@linaro.org>
Date: Thu, 13 Feb 2025 10:52:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Fix incorrect CPU_CYCLE in
 metrics expr
To: Yangyu Chen <cyy@cyyself.name>, linux-perf-users@vger.kernel.org,
 irogers@google.com, namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, fj3333bs@aa.jp.fujitsu.com,
 fj5100bi@fujitsu.com, john.g.garry@oracle.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, leo.yan@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, mike.leach@linaro.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org
References: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 8:44 am, Yangyu Chen wrote:
> Some existing metrics for Neoverse N3 and V3 expressions use CPU_CYCLE
> to represent the number of cycles, but this is incorrect. The correct
> event to use is CPU_CYCLES.
> 
> I encountered this issue while working on a patch to add pmu events for
> Cortex A720 and A520 by reusing the existing patch for Neoverse N3 and
> V3 by James Clark [1] and my check script [2] reported this issue.
> 
> [1] https://lore.kernel.org/lkml/20250122163504.2061472-1-james.clark@linaro.org/
> [2] https://github.com/cyyself/arm-pmu-check
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Thanks for the fix. I'll report this issue on the source data.

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   .../perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json | 6 +++---
>   .../perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> index 1f7c9536cb88..eb3a35f244e7 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> @@ -169,7 +169,7 @@
>       },
>       {
>           "MetricName": "fp_ops_per_cycle",
> -        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
> +        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -383,7 +383,7 @@
>       },
>       {
>           "MetricName": "nonsve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -421,7 +421,7 @@
>       },
>       {
>           "MetricName": "sve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> index d022ae25c864..4a671f55eaf3 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> @@ -169,7 +169,7 @@
>       },
>       {
>           "MetricName": "fp_ops_per_cycle",
> -        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
> +        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -383,7 +383,7 @@
>       },
>       {
>           "MetricName": "nonsve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -421,7 +421,7 @@
>       },
>       {
>           "MetricName": "sve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"


