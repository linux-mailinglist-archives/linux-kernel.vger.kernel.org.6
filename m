Return-Path: <linux-kernel+bounces-441107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414199EC9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A8F169C83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710E236FAC;
	Wed, 11 Dec 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agtTFFEE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1198236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910627; cv=none; b=f+okGtN0BF1pYUh+AJLF9y+Hcj+B1fLSwtxZUzrVvwYG9Y0WFIWGb98fSk0feyDQSzl26V3SOGs5z0CEBjai5XIkMzyGL6oADF1mccgU0Olv/m5xmgn4CXFllqx6uwghsLl7pLidUOtE6Oj0sbsv/KakYpsTjNJJB05+j4adlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910627; c=relaxed/simple;
	bh=79Y2J60i/jBcsrblqYc4FLqObVvr3StOVIJMFYlmu80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PoN+ZUQgkf2FvzLmKGelczpheabazi5Fe9GuAQMU09j/6+iOJYscqjvQ7bWpZMpOKT/bDsCHeSjm97Uf+fs37HYcBpuEuIkvjHspLtRiCKpbKZcJjSUFoj4okBzL+w/TGABMVRa+5FdmNgdnkiw/gqxdFAEa21upAnhJCjES6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agtTFFEE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434f80457a4so2637005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733910624; x=1734515424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGWXQh2y/a4pUNmJ5UgKe43cJc98Qm0WVvIS6JUL+7c=;
        b=agtTFFEETsRHylNhX8OINKR3lyouyEtfM1oEBoPaNFHpMzYdt6P9AMyYp+froBvCiN
         Om4n9unPF5nwc9lPoJJbndcqNxWB8FiKZcmQPf/OBiFr84jL8B88fGFUtaPwDW+oLiK5
         ijUMFvZIhzJyVT8zhCLyunBR6AViL4dbbOlKQxnq4j3mpydx/cgkUh1HE5MTqq6+CBbH
         Y+2QJrf9+lepzN3zhbwbSFqXl1JSQzOHlUiDMJJof2/rwe7bt9OzX5xSfg7RNuUVpzSw
         vlx3rS6466AZV39a20B3fxFMPbrIGTF4HbbXSTi845PCyr6Rx0l/T8OmDtH+VfAOHbb6
         kUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910624; x=1734515424;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGWXQh2y/a4pUNmJ5UgKe43cJc98Qm0WVvIS6JUL+7c=;
        b=E5ciQaR+vGjDPgP2IpbMzu/YFdTs/Wh7vjlgCK3Gg47T4x+pkOzIP6U7Ygwd0/WVDE
         tKzk42t3KUpp0CgT9Z2BbPlC2Mdp5F0+H3YTYbuxiDkRp6Old8wl9BiwdJ2fE8GArjZB
         EikpdnbJdazQBeQ9ZD5tEyHxJEf8rNvGII4Y2jMtRYk5Z+4Z8+STV1NGjvnfJZ6Ver+Y
         es3Xegxw6XSEsiy8J0sbtAXEgjvYK01VnCM3g61YynDLaYjQvZG9eDYEuNgQJFRPF2zF
         iMY+Wv1ze63xk1+YSX8e93WeHBs2kdAARXoNP1ZCyNJu5S73nWwc0UXYjRHzkScIf0H4
         F0jA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ra1k34/8YFZli24Moz2ZqEB602t9/E4IqcK8JT03oDM0aIet1J8S97F5TZWbJz4bUApEcAAqdsiMpu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBGWpIHzwguF7N1EHz1f53FX4vkCrLriNGRWq5QenOPXUZlzP
	geBea1ybxIqA8U802b48m6k6hTQGiMoTK3egUyo7lfT486blHx1VOJhc3j0iV9M=
X-Gm-Gg: ASbGncuvZmKMHUQ4cDn/8ZDGHvIWju10WBRauHWP1ibxIt2iNMEJDDyLWrNhRr3htZb
	4FKcXqB2um6YPbnVH6WHIW7alNc/y2AdU2KDONTW/Xk5aqsb2QMrbobBrbbrDc0r58u9wzy/MqJ
	izXUZNtgW7rh/drrePG+2u1yT3jHEITYP34KbfWqQWZU1ZCbmUS/HCUeV9RBBHzvynK0o665Qwt
	NiOqgDROdEDgxsP7UreSqP0lhFUv9OVcUW3hB/oYRS48fcx5NtfhV1UUgmy5LDSlw==
X-Google-Smtp-Source: AGHT+IFkmAYF/4ple1UJDkLPOCeYZOjR8X/YoiUVeI4zDyJ0l2Wc/JKpoP9the1ZI3JMJKeQfZNidQ==
X-Received: by 2002:a05:600c:3b9b:b0:434:fc5d:179c with SMTP id 5b1f17b1804b1-4361cd65b6bmr14401705e9.13.1733910624039;
        Wed, 11 Dec 2024 01:50:24 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434faeda409sm87538405e9.7.2024.12.11.01.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:50:23 -0800 (PST)
Message-ID: <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
Date: Wed, 11 Dec 2024 09:50:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>
References: <20241211061010.806868-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241211061010.806868-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2024 6:10 am, Ian Rogers wrote:
> The cycles event will fallback to task-clock in the hybrid test when
> running virtualized. Change the test to not fail for this.
> 
> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/stat.sh | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..60cea07350e1 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -165,9 +165,13 @@ test_hybrid() {
>   
>     if [ "$pmus" -ne "$cycles_events" ]
>     then
> -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> -    err=1
> -    return
> +     # If virtualized the software task-clock event will be used.
> +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
> +     then
> +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> +       err=1
> +       return
> +     fi
>     fi
>     echo "hybrid test [Success]"
>   }

Hi Ian,

Isn't the distinction between task-clock and cpu-clock whether the event 
is per-cpu or not?

$ perf stat -C 1 -- true 2>&1 | grep cpu-clock
               1.49 msec cpu-clock       #    0.917 CPUs utilized

$ perf stat -- true 2>&1 | grep task-clock
               0.30 msec task-clock      #    0.366 CPUs utilized

The test uses per-task mode so this change makes it always pass, even 
when the number of cycles events doesn't match the PMUs.

Thanks
James


