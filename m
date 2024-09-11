Return-Path: <linux-kernel+bounces-324663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2A974F72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A74C1C224D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54583184537;
	Wed, 11 Sep 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQDWD+xW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1247DA81
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049713; cv=none; b=X8SJFQzfCyT0lazMKOdYREAoepoQ+32aXKrIRYXIK/MeMawBeRz3rKMa4/TBt1N5yk7cqfQoqSFoXLWKfIUVtNkXjt7JC4UIBxOLf3ncnAFM+j5hjZJ+2ZnqAYwcrD/7zWtZvdfGeXs3kcxCGWz07gFCFhkszsHyk/TsvdbpZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049713; c=relaxed/simple;
	bh=aXYn4ogEDH0r/0ZfDYk09+4jV7K8oaN8MsbvSky+PKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev0kiAPwnpT1TxU3pxmWsqeJZ/cxaIr7Ru8w9cocKbhPTLwDwbh4FPjXBJn3eMWwHRRwEC8khdR8mU4XxyLm84fKcv/kCkWWP9dBCgutZx/mOYedbTC8uIW77YNr4UuCu8QSZbwHhqqByQUFzoR678eTsgr4o4Y2YGgIEUJH+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQDWD+xW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so5851339f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049710; x=1726654510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5RCSLLYkiPWbvkMq55gqucmS0XFLKP5JVxEa0qPBEA=;
        b=RQDWD+xWsRFJ94zmgqzzkqcyDydtUKAgWpyWd6RrZ/9UNwfsdD8kofqAxj8BTGEn0f
         m5E24KNjpPz9GXwM8hey80pTVbR8mJ4oqfLKeS3LoRyU2JSdiDiVHcOe5fenCagPphpW
         /SN2A4kY9W1YVLqq6MFdH1jXCSxTNsV53xqn8YqpT0i0YTIj7JM3RkhCmKHggmEqaJxW
         MMEbatAeBxZ6go+z0YTjQpBSHx5+Hv0rK3ClrVjK6XRvHkuDB8VDIhJRO8ifWAUAw2Ns
         3UQWFWMUWh5Dg37/ny//2HJojqTS0EhronOlCr3a01qYwp4K7Iktdn/gI8OHYUacpZrg
         K3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049710; x=1726654510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5RCSLLYkiPWbvkMq55gqucmS0XFLKP5JVxEa0qPBEA=;
        b=GShoYAcITBjEWOLqRu55URqr8Cqqwk/Mw0emG7HWlcRI44sBx8EL3zXaxFiEXA0NBV
         SSdjDwyPLpCKWKXTevMF5zGY69RkNoUBYZF0aiTXYf4xAs49HQE7hy3OwLTayfzz9pTU
         CuMc3zT/S8leXnSVvlW07jE3Ehib52LI55YdkBArCaeccN6Fy1xVmwmVpvCrmapFXQCC
         RvfBJmWlcoOdra3KJsRpbDsokk+t66xpuJVJNxGumgQFKtOIaJRldecsyRedjD94+c7C
         4CYm4GXaOdIzV2mMzy9vQX54lwSGkg584xInUrMH42eAA+3IP7uNdUD0YVojZKnV0nb9
         jNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW94ncIvvA3UfJ9rG7OUDKEo8tV8CMFrlCFb0RZCHvmNl6vXlUmpgbw4qP0a2SUwoZDBGI5vgGjl2/J1zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+wswpj7Zeigd7zcQ8JDkDMaLoNh72ECBEfSoZCq9zVXdoDGp
	/6kMPDdScH//Bx2JPIAdrEsBPIfhAvP+FzO4dRE2EeTgR7Ti+Y7l0vm/O8bjiLQ=
X-Google-Smtp-Source: AGHT+IEwtA2BAwCy8dZFIsDc1pAg7VcTciPDzhUXTruAUTrFdpFgeQ+jVnBwNxAD3asUMqyEB1RRSw==
X-Received: by 2002:adf:f247:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-378922a6c62mr12205131f8f.21.1726049708974;
        Wed, 11 Sep 2024 03:15:08 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8644sm11111446f8f.114.2024.09.11.03.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:15:08 -0700 (PDT)
Message-ID: <c37492e5-6a1a-4506-810c-ec59056ee85b@linaro.org>
Date: Wed, 11 Sep 2024 11:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on
 system
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240911100126.900779-1-changbin.du@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911100126.900779-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 11:01, Changbin Du wrote:
> To make error messages more accurate, this change detects whether ftrace is
> enabled on system by checking trace file "set_ftrace_pid".
> 
> Before:
> ~ # perf ftrace
> failed to reset ftrace
> 
> After:
> ~ # perf ftrace
> ftrace is not supported on this system
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> v2: rebase on perf-tools-next.
> ---
>   tools/perf/builtin-ftrace.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 88a87bf387d2..abcdc49b7a98 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -80,6 +80,24 @@ static bool check_ftrace_capable(void)
>   	return false;
>   }
>   
> +static bool is_ftrace_supported(void)
> +{
> +	char *file;
> +	bool supported = false;
> +
> +	file = get_tracing_file("set_ftrace_pid");
> +	if (!file) {
> +		pr_debug("cannot get tracing file set_ftrace_pid\n");
> +		return false;
> +	}
> +
> +	if (!access(file, F_OK))
> +		supported = true;
> +
> +	put_tracing_file(file);
> +	return supported;
> +}
> +
>   static int __write_tracing_file(const char *name, const char *val, bool append)
>   {
>   	char *file;
> @@ -1583,6 +1601,11 @@ int cmd_ftrace(int argc, const char **argv)
>   	if (!check_ftrace_capable())
>   		return -1;
>   
> +	if (!is_ftrace_supported()) {
> +		pr_err("ftrace is not supported on this system\n");
> +		return -ENOTSUP;
> +	}
> +
>   	ret = perf_config(perf_ftrace_config, &ftrace);
>   	if (ret < 0)
>   		return -1;

Reviewed-by: James Clark <james.clark@linaro.org>

