Return-Path: <linux-kernel+bounces-361339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42C99A700
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF79C1F23246
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30162405FB;
	Fri, 11 Oct 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed9tz3b2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB662E403
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658497; cv=none; b=UiAtgwNtZEh0O4TIKH5VzYA/GE/e9rQ6rk9tmeZdJ1ZecTTJzJeY/3+KIpJfm6zWXueuft7qlF+9EH3AD1h+IqO0jOUMiKWtNY3vQv7E/hirLQuodDXZV2OKq1EcAcheWghcCtX4uc7E2QYqkaj0JEKK3nv8xlEAtPY7Llq30dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658497; c=relaxed/simple;
	bh=ayOP6kmT0Uhxqgho5scUs/ofCyaD3oPtnl1pskkLz5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcxjBoLSN2tnxeHlCAQPgVPVQiADsKkihGXyrmW/Jy71xchCnZvTcXv5CXWb13HmrdUXfKvdW1G1h2MJGJyUs6mYC4eunglIh37gs/e3ZZJhRKUDmyZsvXe1xzQ+8OEkb7nZo1aXjdk/WhK5JDrQiO1VfJ2vMpiSxHfTeWnSGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ed9tz3b2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2375652e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728658494; x=1729263294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqJdH6KvlGOaJs6LPdOjTJk5FO4Bru3b1GwmXSj7OG0=;
        b=ed9tz3b2N1MfcdCGQcfVoznA64jeL8e3DVCWAatIi7fbH7XuC6x+90RWiyHdX7fwkR
         IpgQ2a5rDA9AQesDEiaWo3iaCLPbYxU2YSmyE0qVlzm0zLP+RFsxovosiNCTRsqSsIEk
         DL5N6blfm5CbkL1dlZF38+VNXGWxL9CFuKPiG1G8cBTo5b8U2LO2TLa6JkChyU7+pzb2
         zNSEDTWKX7idKL7ew/jbXuJMTltOLX8YAJ/I8fF5EzNHYxY3FpLcUMIQtAf2OjHN/7oo
         JEQ5p7s66QvJ8Sh1OC9iIRjBuDs7zJ7T9ZIodf2C+8oTCwFVnsJe0JM2OsJdRwsZHkXc
         h0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658494; x=1729263294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqJdH6KvlGOaJs6LPdOjTJk5FO4Bru3b1GwmXSj7OG0=;
        b=awoHVgZQHAwreOjtk+VA1xuf0i0j7BjrsPGGcMtF+30I/SLnRi3wdRvfPvgD/csbjA
         hY25cbIFtZpWTBIbcGuqJ/yoDQkzLKvXJtUPmkQmsJqcNXDio55q3YMlhYE5iw2R1nAw
         zX3vzEyPUswRtcrhoDe2HrhpZ7dPYp9+qtR3VVH6Ugjw4Twvd7CvhVaoX70ppsDc3nTr
         zNLcHLHx47bG6y4qbQSSNkMnqS2VC97NNh3TgOii/tqJ1vu2WYgp+jmpmAVH7AW3/1+A
         w7i6F58akhikYwMMP98RZMNtFxMzJOAD1D9XkojaCs3v2NKvTvnqfgE36iwCAyd4dxeP
         kN1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8jaty35dBJhfbQArSz7gYkbY8Q9j05FENJiKtpf/QW/5BhGcMRW+l8VVVQjIVm7E4G6GG7kHcGsT8nXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR601TO9N7HMhbQCwUZJ6YCgt9wSMv2efvJiGXBauDNlokZMBH
	21rIFj7gSDjQhmJ9oY2iBScqNbPPnBAs6dEDN1fhPBlPN87CNBh4Efn7+yFZSyY=
X-Google-Smtp-Source: AGHT+IGEqpHxLhsvoJ3aD2Hs3uY1bxru/hFDC2inGgVcpwnr5oCn1DIcDbUUVYp2qv7/GuTpsG+sdg==
X-Received: by 2002:a05:6512:3a8d:b0:52e:7542:f469 with SMTP id 2adb3069b0e04-539da22cdf6mr1789366e87.0.1728658493944;
        Fri, 11 Oct 2024 07:54:53 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm44130005e9.12.2024.10.11.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:54:53 -0700 (PDT)
Message-ID: <9513f8d7-7f42-4c1e-bdc9-d2078d46ba1f@linaro.org>
Date: Fri, 11 Oct 2024 15:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf test: Introduce '-w --list' to list the
 available workloads
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241011143906.1285675-1-acme@kernel.org>
 <20241011143906.1285675-3-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011143906.1285675-3-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 3:39 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Using it:
> 
>    $ perf test -w noplop
>    No workload found: noplop
>    $
>    $ perf test -w
>     Error: switch `w' requires a value
>     Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]
> 
>        -w, --workload <work>
>                              workload to run for testing, use '-w --list' to list the available ones.
>    $
>    $ perf test -w --list
>    noploop
>    thloop
>    leafloop
>    sqrtloop
>    brstack
>    datasym
>    landlock
>    $
> 
> Would be good at some point to have a description in 'struct test_workload'.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/tests/builtin-test.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 2201f7ed432ce9f2..f0d10d2dd0d40019 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -505,10 +505,26 @@ static int perf_test__list(int argc, const char **argv)
>   	return 0;
>   }
>   
> +static int workloads__fprintf_list(FILE *fp)
> +{
> +	struct test_workload *twl;
> +	int printed = 0;
> +
> +	workloads__for_each(twl)
> +		printed += fprintf(fp, "%s\n", twl->name);
> +
> +	return printed;
> +}
> +
>   static int run_workload(const char *work, int argc, const char **argv)
>   {
>   	struct test_workload *twl;
>   
> +	if (!strcmp(work, "--list")) {
> +		workloads__fprintf_list(stdout);
> +		return 0;
> +	}
> +

Very minor nit, but I think searching the workload name for an argument 
instead of having a 'proper' toplevel argument seems a bit weird, but I 
can see why you did it that way.

But maybe something like this might be a bit more readable especially 
when searching in the usual places for an argument. And in the future 
might survive auto doc attempts of known arguments:

   $ perf test --list-workloads

And add it with OPT_BOOLEAN() etc.

>   	workloads__for_each(twl) {
>   		if (!strcmp(twl->name, work))
>   			return twl->func(argc, argv);
> @@ -544,7 +560,7 @@ int cmd_test(int argc, const char **argv)
>   	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
>   	OPT_BOOLEAN('S', "sequential", &sequential,
>   		    "Run the tests one after another rather than in parallel"),
> -	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
> +	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '-w --list' to list the available ones."),
>   	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>   	OPT_STRING(0, "objdump", &test_objdump_path, "path",
>   		   "objdump binary to use for disassembly and annotations"),


