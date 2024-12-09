Return-Path: <linux-kernel+bounces-437140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9549E8F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7211886A16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735C2163AB;
	Mon,  9 Dec 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ke7FpOli"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800E174EDB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738512; cv=none; b=hF4TtqJM4XzGY1n+ndvz39+VXIrfHGZybOwgNmnf+ESVU7t3nwh+YRJjxmljtjPXEFJSVGvjnY1Jamd7Xn6NjNETjn5yLuE5Zu5Z5l2+AJ7Jo8Y0rikijWkT1Da+vz55M740DWydZc6l41EsPwnuS2siheospELvuefvEF59ZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738512; c=relaxed/simple;
	bh=gSGNSzf8zXM/Mg9PLTj7i4j/GKoM07kA+g4SuzboP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cs+0+w8VOgOTDaMgdODta9KCRknZXVQJi6sAaS5IL4yRlf+EjSEXX5Lp3+uybBG3qMuukMy1BKpR59BJTbi9ZU0fqpPytADhv6CeWfTHGE3o56xSy8VcM/GHQPfTj4h99gWz4MdngoN1NSptUTGwq6RMRMoVFsE2RWgPwsOvfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ke7FpOli; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434f094c636so8315625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738508; x=1734343308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDlwyDroBq6zcVrCDpDlItZdzZfKhDPhfE9JnSAIaJU=;
        b=ke7FpOli9zkkXOYZtnPy1hK3CVM4Wjq9GlO07dK14kXak4u+2Geuu1rjrmHSfoEAmW
         +AcXa3IMZ7gP7LGwjPzDaGAyscxjcPR4PMu053caYzYsrfrCdAYpQdozeIBIEEDrnOV/
         OfbKIG6YKr0aAy5QDAgDDHw+QdYbq41tSK5O+3K4370fpaK+rxVoWqDkA6YMvZUwEjKL
         rX00EkMTX/RI/tTQw/bAuFj9V0TSNY03/5N8S2EEJTCWxAon20bUgHJBlaVDxmxV276q
         NHOusNZpcbNa5YSHzpHVvxFQ+OezRajk/1MEnGRYI3EXUaoAK/GarHY42eRy+v8RfSxO
         4BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738508; x=1734343308;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDlwyDroBq6zcVrCDpDlItZdzZfKhDPhfE9JnSAIaJU=;
        b=EbQxn4jadBGudhWncisIIKDOxxoHdKDCrc6m1Ct2REQwTVwsOh533Db+HtBPWq0N76
         rJ2g6m4Ho1Mi8khu11mI8u0vExNV1qNAiIK8Tp7Nrc6rXhm1mqSXbHMEDkRKxGlXpO1c
         LBsbyBPC6rRptEgQXAkG2QQlkZVFy6XROmMPSS6lmwXFH4NhD1fh8+JGrhBGmiFeJlfR
         4zMKQcdc3WODZpP6UHXiJ8ba4tErwPiV/0ebJasHfYp1pXDt3QmVqu3g2r/EFn2rLilG
         lBvIw4i5a6gwkgzYqm8qjyHu4tFFF6QOegV1QqSw/r/HFTCMf7j8lD1H5jeRk1EBEWcP
         RbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLrRoT93E7OBaKvLyhZ3OVFIKi9+ZxciZT41UUT5Hcm/ap9Xc9eTuuL+x1Jw4q+gHoSireAnY9S3zqu5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHuPoKBBUY6mGWbRkMiwfKBjRndi5uhhgsM36YOF2qrlsLu0n
	zxT5bTkQYhyZojvEfbSOVXwZWKKrjipeTJXrv+/KRMO5MUoQiMGbpk/kxOhGzYY=
X-Gm-Gg: ASbGncs2Bxne2xBhSNH8bzRU9/BytCMc5YsFx5GpmmGcJhI1hanI30UcGf/OBytdFaq
	bPrXev5qKo+ST/SolAPH7U5u1lMFvW/4mif7Q1sw/gg6C3iBb98K0gVV+5IQHMZiN5EWJCryWg/
	YfrL274WHjS67QF6teLXD+n9JdK4jv//9CH6pggCjfwYOL6Hs9mPdcsOviDPreWYrK0/BvIW0IC
	kMpz+T2AWLatNnAzPIIPlwSJMhWK6cQC7CWlWj+9StAwJRCe+YLIeH+eT3rqQ==
X-Google-Smtp-Source: AGHT+IGwtp3FQpoGqZyO22hYjk1/F0qh54u6BpRMMDp3hLcMSs789LWDskm/IYygzHoEct0bsoKghQ==
X-Received: by 2002:a05:600c:1f8c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434ddeb5379mr84518625e9.11.1733738507736;
        Mon, 09 Dec 2024 02:01:47 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2b08972sm57369755e9.27.2024.12.09.02.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:01:47 -0800 (PST)
Message-ID: <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
Date: Mon, 9 Dec 2024 10:01:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, Xu Yang <xu.yang_2@nxp.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Lucas Stach
 <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>, nick.forrington@arm.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2024 6:48 am, Yoshihiro Furudera wrote:
>      Add pmu events for FUJITSU-MONAKA.
>      And, also updated common-and-microarch.json and recommended.json.
> 
>      FUJITSU-MONAKA Specification URL:
>      https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
> Changes in v2:
> - Change "SVE_INT64_DIV_SPEC" to "SVE_INT_DIV64_SPEC" in tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json.
> - Link to v1: https://lore.kernel.org/all/20241111024529.2985894-1-fj5100bi@fujitsu.com/
> 
>   .../arch/arm64/common-and-microarch.json      | 858 ++++++++++++++++++
>   .../fujitsu/monaka/cycle_accounting.json      | 146 +++
>   .../arch/arm64/fujitsu/monaka/energy.json     |  20 +
>   .../arch/arm64/fujitsu/monaka/exception.json  |  32 +
>   .../arm64/fujitsu/monaka/fp_operation.json    | 194 ++++
>   .../arch/arm64/fujitsu/monaka/gcycle.json     | 116 +++
>   .../arch/arm64/fujitsu/monaka/general.json    |   8 +
>   .../arch/arm64/fujitsu/monaka/hwpf.json       |  62 ++
>   .../arch/arm64/fujitsu/monaka/l1d_cache.json  | 101 +++
>   .../arch/arm64/fujitsu/monaka/l1i_cache.json  |  47 +
>   .../arch/arm64/fujitsu/monaka/l2_cache.json   | 146 +++
>   .../arch/arm64/fujitsu/monaka/l3_cache.json   | 185 ++++
>   .../arch/arm64/fujitsu/monaka/ll_cache.json   |   8 +
>   .../arch/arm64/fujitsu/monaka/memory.json     |   8 +
>   .../arch/arm64/fujitsu/monaka/pipeline.json   | 230 +++++
>   .../arch/arm64/fujitsu/monaka/retired.json    |  29 +
>   .../arm64/fujitsu/monaka/spec_operation.json  | 158 ++++
>   .../arch/arm64/fujitsu/monaka/stall.json      |  83 ++
>   .../arch/arm64/fujitsu/monaka/sve.json        | 146 +++
>   .../arch/arm64/fujitsu/monaka/tlb.json        | 404 +++++++++
>   .../arch/arm64/fujitsu/monaka/trace.json      |  20 +
>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>   .../pmu-events/arch/arm64/recommended.json    |   6 +
>   23 files changed, 3008 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 492083b99256..50fc4b2df361 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -533,6 +533,12 @@
>           "EventName": "SVE_INST_SPEC",
>           "BriefDescription": "SVE operations speculatively executed"
>       },
> +    {
> +        "PublicDescription": "This event counts architecturally executed Advanced SIMD and SVE operations.",
> +        "EventCode": "0x8007",
> +        "EventName": "ASE_SVE_INST_SPEC",
> +        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE operations."
> +    },

Hi Yoshihiro,

You don't need to duplicate the descriptions if they are the same. Just 
BriefDescription is enough and it will show for both normal and verbose 
mode.

Also in the common files, we're using the description strings from the 
Arm ARM. I noticed that the ones from your spec are slightly different. 
This is ok for now, but if we add any new Arm cores that use the same 
events this description may get overwritten. For example 
ASE_SVE_INST_SPEC in the Arm ARM is currently "Operation speculatively 
executed, Advanced SIMD or SVE".

If you have any actual relevant details that are different from the 
common string, you should put them in .../arch/arm64/fujitsu/monaka. But 
if you are ok with the potential overwrite (which looks like it should 
be ok) then you can leave them as is.

[...]

> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> new file mode 100644
> index 000000000000..80bf17fb8f4c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES"
> +    },

Other cores put CPU_CYCLES in bus.json. For user friendlyness I would 
put the common ones into the same existing groups. The same issue 
applies for some other common events.


Thanks
James


