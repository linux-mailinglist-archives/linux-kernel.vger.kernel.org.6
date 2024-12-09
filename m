Return-Path: <linux-kernel+bounces-437397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF999E92BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA918851B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880CE22069F;
	Mon,  9 Dec 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNYJ7UQO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD21F931
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744962; cv=none; b=ssnMCTad0vESbAhm2Odxzx1sLKQeWIgggvcWgv/8xUo+GABpBVmS/weKsR9bx/oclijNyAHAxFoErCEZMKVYr7f63KaOG3R5b3Bfs/vs7R0g/OYYN2N0NTijwvt2lAQ8zROKYE4Ukevzh9uV5yb3IpE2M7yzK38946ctwdDwIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744962; c=relaxed/simple;
	bh=tbukh0cajN7SyxccaE9cZMphzdrKFiU6tTMHpT3cuuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qf56JRNiKfwMaZkZz+mHb9yNJBr5rzhuswokXh0tndhs+NGZR2oS0HjXiHWLh8rCicI+4ysps/sn87Fkx+jyqr9QqEFOIcNUqBo0CLViG4H0krcxPF+CY9Cl2XuBiWmTSHcXucyGHyhe2tA6UCEcf9ocNpPiS0ZLBFs0ouFyEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNYJ7UQO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso3249575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733744958; x=1734349758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yk6+BiAdoM4boWjpdnnb0XRpYiLDHEajJSbnU4mVyE=;
        b=WNYJ7UQO3ONdenXOZHJzbF09E0vHmNoh73Kckf1pFJfSKkr3XjeyERzKHHXWsYvbCe
         GFlpVaWGxyuXxj6lbr4EHoUGKVsJ2hDp3VuqSFCOZprnijVOxcACDeIIdSxHWHBR27fV
         50nJbs4uKIVMKDtAy2sdZzhpQlakzwqsouphrkv9qqJ7XhAQTUa31EqWSo4GGByl171L
         kcJnYbGo1FIO96F+7KkiIsXuMb8ysL6fOme9X+czX21Xtpast/bkY+uxqNtACr0/elJN
         w4Bebg5p0qXqlnkvWMWaMyk1oOhRC4eRV1vMcF7EX0ZCPonjNzeIIEIVmK2m+Q3YQpaH
         qGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744958; x=1734349758;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yk6+BiAdoM4boWjpdnnb0XRpYiLDHEajJSbnU4mVyE=;
        b=ewJ1BjS+vfJ2eXFN1VJUGtgIuSOusTxadqVb0fI7vGaQzVH6UiBc2FGilKyF8pzO6/
         VW+ejomaw9IPApWpysOKCnqW0/WfnaPOtW/ZhGi8vyQBCTqzn4moN1X9mdnCLRLvm9sd
         P3Cg8FPLSBGXrW0PAI3cwDa24Rb8XAtA3M9m4j5dRGojSXtnb8ZCcoxckqDwYQYlA5f1
         xATSZttF+2vqiuL8hDGBGF4CF001bXqFZlOLm93DpVTYBWJIJGfjzxx+RMyySoOsV/xT
         Y60QRyxiLqIXjRhsAZiKpfp00qDYPZBkSApVyGLZJicAaKnFqZMxuohQYhebzFdijqWn
         cxXg==
X-Forwarded-Encrypted: i=1; AJvYcCX3FkGjgPJ75jvhA4BrPvyE+vB8Nazv89EcejoSpo7xx97+UupoEXBl+RIWXYsfxCf+Gr5AFMF2PIM0Sk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNb76toUF6E1JAs+wo+p6Jrl3+v4BVtOJ4ri2OUT/NR/XQXK1
	yeswJZdPAD53lKnKeafd4oSBsg4ETCXviT1/2TAu6bJ4y8GIVPL3KP1pPvZg8uo=
X-Gm-Gg: ASbGncuJZOOVFR+78/XwdK6WrZKRQKoUyuPRxSTGFA1vlfm/Ciir+ZG0FMsNZ4mUGlm
	nXjb16+tY949W8SNODwxPb20J2/5kYXjx+Z0Xo9ikZV4lQXGj3qCI9MoJjCV4kjk/u1E7XydZM0
	0+rUPa5SifG259sSOB1VBbOhyJOjsSegHr4N+4D3QqYs7ogorlTq75aXVJ0xrEair0bdpYiFjKi
	7Uk3QPXp1Fl+L6u9ZfGrKO/xvQ/TPEjpTwBxCJipLb0IVv+WZRkde/cIgGy3A==
X-Google-Smtp-Source: AGHT+IEAZnAolC1VRIxQlwnoGITQf7rUB4/OAbY0LvCQlZN+3lKtSAGpFGEfUof30OGA2wiivpZDBA==
X-Received: by 2002:a05:600c:3115:b0:434:9df4:5485 with SMTP id 5b1f17b1804b1-434dded2c07mr90244855e9.32.1733744958402;
        Mon, 09 Dec 2024 03:49:18 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm29735245e9.26.2024.12.09.03.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:49:18 -0800 (PST)
Message-ID: <9e9a550c-0017-40b0-af14-99f3c926290c@linaro.org>
Date: Mon, 9 Dec 2024 11:49:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf string: Avoid undefined NULL+1
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20241120065224.286813-1-irogers@google.com>
Content-Language: en-US
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241120065224.286813-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2024 6:52 am, Ian Rogers wrote:
> While the value NULL+1 is never used it triggers a ubsan
> warning. Restructure and comment the loop to avoid this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/string.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index 308fc7ec88cc..c0e927bbadf6 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -254,11 +254,20 @@ char *strpbrk_esc(char *str, const char *stopset)
>   
>   	do {
>   		ptr = strpbrk(str, stopset);
> -		if (ptr == str ||
> -		    (ptr == str + 1 && *(ptr - 1) != '\\'))
> +		if (!ptr) {
> +			/* stopset not in str. */
>   			break;
> +		}
> +		if (ptr == str) {
> +			/* stopset character is first in str. */
> +			break;
> +		}
> +		if (ptr == str + 1 && str[0] != '\\') {
> +			/* stopset chacter is second and wasn't preceded by a '\'. */
> +			break;
> +		}
>   		str = ptr + 1;
> -	} while (ptr && *(ptr - 1) == '\\' && *(ptr - 2) != '\\');
> +	} while (ptr[-1] == '\\' && ptr[-2] != '\\');
>   
>   	return ptr;
>   }

Reviewed-by: James Clark <james.clark@linaro.org>



