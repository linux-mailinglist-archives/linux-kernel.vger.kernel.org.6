Return-Path: <linux-kernel+bounces-185137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD48CB108
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC381C2129A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C70143C58;
	Tue, 21 May 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bOn6K1p/"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8C143890
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304271; cv=none; b=HQoGh1UC4XpI128VPyxqDYZdFeWfAQK7fYar8QHLBjgtyA9QA6vBWMDJEyzFH9Ti+tT4A753vIb9d06kdwONGROBYt/pkdeHyh7uV+EKwuE+yrzrA0l+s1nk8ssg8EdoJhZihxokKlM6qG7u6Q89Hn7LawLbzSBe6l+TCSQytpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304271; c=relaxed/simple;
	bh=Y19ApUlNe+i8Mr1MK47nFQt8OHWh56aHjnOdDjWAzy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLA+qW6hka87R62aJ9bDJBRdbQNZ/NYOJXR+V9w3hcY1jLOaqkO22EiTlp+J7maMjVrF2B/vKG0cdO9Loy3w71TBSBsQQ1PWIKtPlgQqvJhTP/+sASxMjCbKA3OHv38IMwacTdJiNVnMGuYRRnPxaOypOA1dKTZSw/Vda/gSRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bOn6K1p/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so2308525ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716304269; x=1716909069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+THa20LYhJBIMoEUx57FLG+qkSqmFpeSpCtcp5cbto=;
        b=bOn6K1p/1IJ/WGMZJVxHU4GNMQxRvB3uVjE/fCN3b7Rt6TbnxkZKE/q918x6SM0/IT
         XIvv/hZpVm9hVBzaqjtEGEb5ZgTlOdAB3qXpx0OF1XcFyvEN/AbOAHEyjH3JKuw97FO3
         Y0hFZutPCEUwtkYoQDu1+QIoaeyG4h61w9G48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716304269; x=1716909069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+THa20LYhJBIMoEUx57FLG+qkSqmFpeSpCtcp5cbto=;
        b=pdHlmwmW0MfN6TsFDenJQ/GorPVooXr6/9ybLU9hygqYLrDM38rOUiCBWGyyMY9Pxw
         C49SZemY0LBwD5B6woZPhkIjiPFa+zBZpebZJKXI9mIntQakKmZz+yGvPLdQxIk+M9+i
         cN9jd6YsJukN8boAxeaOH1pNUEMwl4xOQI/pHMzPoak/UjuVfbB9j8uQcY9oq8i2oit3
         yizYKeYh9Z5CgTI8neqIKHUQL/P0JJM6R7xkqE99355e1miC8MjW/ofJ9nA9gD9+vRbl
         F4R/bRCoFxq6py+xcSz61J0k8KHN2/HG1XDvsjwuBL9KkQhrC3xG4HybRMrU/0OnMvsD
         n6pg==
X-Gm-Message-State: AOJu0Yx3kmsX+2eIyAKZWULiJ4MvuzOsO+t5Ow0b4tl7j1C5E2MssMcA
	xp4r35aTzJ1VA/egPJNdW9Nnb2iljy+vMTS4Q+rGpE78kKlcflW1UPTb+tn0fAkKSg9s/nHxWgZ
	0x6Q=
X-Google-Smtp-Source: AGHT+IGqylFiQiDNlXoQV0SOz5yPQXZeEgFOWiNDeAkZkqBjZsqRHCMeKV1yEXRObbKTNpwJcQShxg==
X-Received: by 2002:a92:6e11:0:b0:36d:9ec4:54fb with SMTP id e9e14a558f8ab-36d9ec4574cmr221776915ab.0.1716304269014;
        Tue, 21 May 2024 08:11:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d988d6sm64752655ab.43.2024.05.21.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:11:08 -0700 (PDT)
Message-ID: <466e5359-067c-4ab5-9476-06daa44dc83d@linuxfoundation.org>
Date: Tue, 21 May 2024 09:11:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/latency-collector: fix -Wformat-security compile
 warns
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240404011009.32945-1-skhan@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240404011009.32945-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/24 19:10, Shuah Khan wrote:
> Fix the following -Wformat-security compile warnings adding missing
> format arguments:
> 
> latency-collector.c: In function ‘show_available’:
> latency-collector.c:938:17: warning: format not a string literal and
> no format arguments [-Wformat-security]
>    938 |                 warnx(no_tracer_msg);
>        |                 ^~~~~
> 
> latency-collector.c:943:17: warning: format not a string literal and
> no format arguments [-Wformat-security]
>    943 |                 warnx(no_latency_tr_msg);
>        |                 ^~~~~
> 
> latency-collector.c: In function ‘find_default_tracer’:
> latency-collector.c:986:25: warning: format not a string literal and
> no format arguments [-Wformat-security]
>    986 |                         errx(EXIT_FAILURE, no_tracer_msg);
>        |
>                           ^~~~
> latency-collector.c: In function ‘scan_arguments’:
> latency-collector.c:1881:33: warning: format not a string literal and
> no format arguments [-Wformat-security]
>   1881 |                                 errx(EXIT_FAILURE, no_tracer_msg);
>        |                                 ^~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/tracing/latency/latency-collector.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
> index 0fd9c747d396..cf263fe9deaf 100644
> --- a/tools/tracing/latency/latency-collector.c
> +++ b/tools/tracing/latency/latency-collector.c
> @@ -935,12 +935,12 @@ static void show_available(void)
>   	}
>   
>   	if (!tracers) {
> -		warnx(no_tracer_msg);
> +		warnx("%s", no_tracer_msg);
>   		return;
>   	}
>   
>   	if (!found) {
> -		warnx(no_latency_tr_msg);
> +		warnx("%s", no_latency_tr_msg);
>   		tracefs_list_free(tracers);
>   		return;
>   	}
> @@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
>   	for (i = 0; relevant_tracers[i]; i++) {
>   		valid = tracer_valid(relevant_tracers[i], &notracer);
>   		if (notracer)
> -			errx(EXIT_FAILURE, no_tracer_msg);
> +			errx(EXIT_FAILURE, "%s", no_tracer_msg);
>   		if (valid)
>   			return relevant_tracers[i];
>   	}
> @@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
>   			}
>   			valid = tracer_valid(current_tracer, &notracer);
>   			if (notracer)
> -				errx(EXIT_FAILURE, no_tracer_msg);
> +				errx(EXIT_FAILURE, "%s", no_tracer_msg);
>   			if (!valid)
>   				errx(EXIT_FAILURE,
>   "The tracer %s is not supported by your kernel!\n", current_tracer);

Any thoughts on this patch?

thanks,
-- Shuah


