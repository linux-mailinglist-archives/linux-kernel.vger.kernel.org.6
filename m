Return-Path: <linux-kernel+bounces-327788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2504977B31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73F5B2715A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B891D6C7D;
	Fri, 13 Sep 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPnThKTt"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC41D6C7C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216604; cv=none; b=ailKietaaY1vQ5MaIffziptwP7SQGaVLTdxO6lYmFjIix+0FP9HdwWDRnFNYQCyT1wKw9VcH1bVyO/QYeVNO91w6Cr/a2LplfJhj8V11BH/nZqDImrvjW4VmVMq4/8uulV8+sAU2r775Y76vEkNFfF1HfxQs+WO8ybwNpkvi2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216604; c=relaxed/simple;
	bh=zAMShyBfk0di8PVtRRMQX+UtUolVAfO18RJ9JXP23AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLmXMmypZIQxNUX6a5dzfMqBeFXofxPrhSFm9ZBRWHaI95KCRpXU5FFrvdHv+iQJ0ZNcsV0kDhG0N2BMXrssbYTLwQQvcTI6GtVYkmlTvSFgVVTqBhIYOS3FSyi/5zaVMEjXfBS0RaePXV73RDNvcd7qJyMZCCMxSCRi8nuZ1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPnThKTt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b25263a3so475179f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726216600; x=1726821400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4pnwolBQoa9ieXVMZZHl9gf+CGD4ivypyvaluO9F24=;
        b=NPnThKTtuyd+IBbUka9ae+GMZ2WnIPAwoUJJOuaZeBi4/m0k1E3zeVlzQbNskDkZPq
         d8y2sOHITb6Wet/oZiejhhHFG1WCja7dBH3so6uiZgQdyRfb1DriBhMkmZZMSMXxtQae
         0jZXaSMmYiXWmHitn6mLcEpl6D5WzVZaeuOcfvKDM/id4vVcndr/Mh64TVjZRMokFVdL
         rIfXYlwmCrhZ+t+FyXXK8t4k5XE+oQRitR1tp5wJEm6GoNvQEr5P6vV6oO5NUsVTVo01
         BNQMFiDjYi5kx8uInvlvxyQTJW4EKh26X61gk4cvUxdkJJzE+RXQJ7goHgagihUUPCDr
         3X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726216600; x=1726821400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4pnwolBQoa9ieXVMZZHl9gf+CGD4ivypyvaluO9F24=;
        b=std405Mchy4dPqdYT7KZvrXWch0uDXCr5exMWKkbf6uN3Zhuph8d9bj/Y+sLSxxyXH
         EJRY0+xyxgc/CYu3r7v+MhUZEMeyNHpSn9sgS+FwjjXDymAWyk23gbjT11SY39HxJpS1
         wU9EHgYfK59AKodFhAnls6KmpEe7aNMe5vekY26Nk3gwScFPezGbPIcff7tYV/QkOlhx
         b6/4ccqMAhwcVwlhk7zoaaWywxNWmcIZCyf+tKP/AoGCYAnOsUUMQUlSx3aJFyleUM16
         NE8g3wWQd+/RbDHzR4GM0kixKJT12/MNHZFDJyRBsIQkH4DGxfxDP8TA5wCnWRVFOWGU
         NOTg==
X-Forwarded-Encrypted: i=1; AJvYcCUKasnbHrnpt1S4gGLFzkmRuaJ3LJVU3YFJhO56KOzwqIy918rFJbdoDcglNNuQG+bK+DjSKm1dQZaUaIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkiOKK+v6V2t6fg5Y+FrxMWidjL+RRxx0JvJPKshEIlSuRMQR
	triB/D1D7vnN5yDbbpNqUT8OzpGpcL/PynFgeEcuUu/xB98MYWt7mufz3I1LM+k=
X-Google-Smtp-Source: AGHT+IHx+OMzS4wGVJnmmQnNusmr45zTxb9hpuk4RDO/rxJ2QU/ShBAVN25ERI2yQhQcZdcHa5uSFg==
X-Received: by 2002:a05:6000:1841:b0:378:7f65:e13a with SMTP id ffacd0b85a97d-378d61d4fc8mr1097306f8f.2.1726216600193;
        Fri, 13 Sep 2024 01:36:40 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3d4sm16159955f8f.108.2024.09.13.01.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:36:39 -0700 (PDT)
Message-ID: <39eafc82-dfa8-4e22-9d8a-071ed09460d3@linaro.org>
Date: Fri, 13 Sep 2024 09:36:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
To: Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, asmadeus@codewreck.org
References: <20240913020209.520104-1-yeoreum.yun@arm.com>
 <20240913020209.520104-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240913020209.520104-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/09/2024 03:02, Levi Yun wrote:
> Exit when run_perf_stat() returns an error to avoid continuously
> repeating the same error message. It's not expected that COUNTER_FATAL
> or internal errors are recoverable so there's no point in retrying.
> 
> This fixes the following flood of error messages for permission issues,
> for example when perf_event_paranoid==3:
>    perf stat -r 1044 -- false
> 
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    (repeating for 1044 times).
> 
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
> Changes in v2:
>    - Add some comments.
> ---
>   tools/perf/builtin-stat.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 954eb37ce7b8..0153925f2382 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2875,7 +2875,15 @@ int cmd_stat(int argc, const char **argv)
>   			evlist__reset_prev_raw_counts(evsel_list);
> 
>   		status = run_perf_stat(argc, argv, run_idx);
> -		if (forever && status != -1 && !interval) {
> +		/*
> +		 * * Meet COUNTER_FATAL situation (i.e) can't open event counter.
> +		 * * In this case, there is a high chance of failure in the next attempt
> +		 * * as well with the same reason. so, stop it.
> +		 * */

There's something wrong with the formatting here.

But I don't think the comment answers my question about the other return 
codes. It just states what the code does.

There are many more return -1's than just for COUNTER_FATAL, so it's not 
just that situation anyway. And in addition to that, there is -ENOMEM 
and others that aren't -1 which aren't explained that they are 
deliberately explicit retry or ignores.

> +		if (status == -1)
> +			break;
> +
> +		if (forever && !interval) {
>   			print_counters(NULL, argc, argv);
>   			perf_stat__reset_stats();
>   		}
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

