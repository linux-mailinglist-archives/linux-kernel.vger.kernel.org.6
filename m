Return-Path: <linux-kernel+bounces-325003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F029753CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF51C21D25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413DE19CC0C;
	Wed, 11 Sep 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnDhUQyX"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187A19341A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060802; cv=none; b=sauqM5mTIsvzs0vVYe0BH6Q6Of/TpBQQvrbjicDi7A2N4V4O7wj8Vfa77kvyt1FXMi3MDNATCjwj+tF5kXh3XjU46G+k9VHP6U1KBSxdVvFXESIRGuSjNPmwhSpXmBZgvEJa1VG6/P0qFqxt0pkZylAyF0ydXD4EurroSQgy6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060802; c=relaxed/simple;
	bh=D1EiHcY8P9weXlSZhRTUAEeg4iKK3QtrCo4b6y9PHW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYS148Sk0p7WPWqdBOZ/z0oHiLEl87ZhKE6vRrN6asqf/i0Fkk0/qP07zUfnpCVNFteiCTBC+amh7Lo4P1v3v4ioKyvqLtb14JTqTR7q1UUKyN6aBoYA4YvrFs3cmtjhdkRH4uineXFSPCKxZ5HltNrV9VkUg6FfR0uqY9Fd85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnDhUQyX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c6187b6eso4240161f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726060799; x=1726665599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCmH6mf58csP77BoUiBG1NiEIHJIhhD8mtjQ0XUQ2Ew=;
        b=YnDhUQyX1nl0WR0Hexusub1+WDPsIk/Z2q12qmVQZaAfqMD96CNYbmkY7qvbxZSxvT
         7WDACKLZaPbtHRLhIl+X4t6sGd6HF2FWufFzEveDCslvqtlAt3MDbeoITwVXgUsS18B9
         fBSceuGk7dhUUWEGbnyW33DOlbmoOPPlCmFsbTzGgz5w5HmyJevY1A9g74390bw2//Yj
         qTRWGUH4J5f3WbJIPeMeqt4yg6taCHR09PaeDxgC3O/gkD6qZUx+Iijlr9gxh9lBdRQi
         HQGyAhiyiC9HWFg5r4KvqxAZGcqUlws6kiouQNSZJQ7j8shHXvjzEw4ai99NH6yvyO84
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726060799; x=1726665599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCmH6mf58csP77BoUiBG1NiEIHJIhhD8mtjQ0XUQ2Ew=;
        b=GvljSslEKlEHeJLakKTUumd3aEB9og7SoR9dsSqWiFhFzHgB/DnYPrs5CjaGcIf8k4
         i6xnc6sPhSLgRd2IV1IV+r9eLcvPkkvOmjbXxcmaxn85261o9pkvjBNTvTw2Qaqb8GKT
         2eN0UF9qnlld1x3NSmMuukJ3C2xWEXY4GRRueRik6K/div4mlAK4IriemCcgBlj8v8YZ
         /SWm2/AeND0AKwaBhfFC35aQSTtCiXLde4Qaz0F2m4W8YYEt9BF0TjlcEBdsBYbnSvRT
         agCxsUjECxm7/RrvpQHq8y0HvJYNjKphkOHIg+/RgvGEA1dF0TxMBANe20jPH+kChp+l
         +EMg==
X-Forwarded-Encrypted: i=1; AJvYcCWa89gP5vIwz5znd8yxpKuWBOzDnnODZ2+/8bpdItFUSAMc2na21Jg5v0SgQ5IPtxrgFOHRXVguyb67tJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1R6ZgnVM3UfCHRnkHQdMX4JHasCpkp2CC3K0cPwmbRXNN0YP
	iislINQG3MGvRBTypufcXPR0SlfHClvb1B3Cj0Kt9kf6yN6EqpQqhK4ppTKjcgU=
X-Google-Smtp-Source: AGHT+IFEENixLL18/yVJLAJfrYAgTnbVQ6WwdXnBfanZyIiOghGVV3B0zi9SftdyFackY5eWv55XaQ==
X-Received: by 2002:adf:f582:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-378895c8952mr11094429f8f.13.1726060798926;
        Wed, 11 Sep 2024 06:19:58 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf436998sm140496745e9.29.2024.09.11.06.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:19:58 -0700 (PDT)
Message-ID: <586cc208-faee-4b76-bd9b-180ac06a0a92@linaro.org>
Date: Wed, 11 Sep 2024 14:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
To: Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 asmadeus@codewreck.org
References: <20240911121919.4167483-1-yeoreum.yun@arm.com>
 <20240911121919.4167483-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911121919.4167483-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 13:19, Levi Yun wrote:
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
>   tools/perf/builtin-stat.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 954eb37ce7b8..18197ded88a7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2875,7 +2875,10 @@ int cmd_stat(int argc, const char **argv)
>   			evlist__reset_prev_raw_counts(evsel_list);
> 
>   		status = run_perf_stat(argc, argv, run_idx);
> -		if (forever && status != -1 && !interval) {
> +		if (status == -1)
> +			break;

Was this "status != -1" here correct? Seems like everything in 
run_perf_stat() returns -1 except what's in "if (STAT_RECORD)" for some 
reason.

Maybe there is something special about -1, but that feels a bit fragile 
and relies on the whole chain to continue to do the right thing. At 
least a comment about the relevance of -1 is required, although the 
issue might not be introduced by this patch.

James


