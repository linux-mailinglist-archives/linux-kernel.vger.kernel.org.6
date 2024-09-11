Return-Path: <linux-kernel+bounces-324956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45956975323
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782241C22F25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F3189F2D;
	Wed, 11 Sep 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1r2bSOn"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB620185606
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059725; cv=none; b=TrhI7kjqKovSs7hyFkO/yhSn/b5pUOXBE1zE6f9aaFp5u0YLo/QAr7Xay6iOPpfeN/b+Rqefczn/TRIvfVcNaPjwxA2bX/7oOzEsqc97h+2q9Viq2PqJ0+UXOelWnmVGOeKTNpwPwKwVfpR/24phSMJlxcAOFYiiS9do3ZsqYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059725; c=relaxed/simple;
	bh=bgYY4a11CuGiUEuP/UCn3kK8xN15UmmXH54N5WhmRx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1FcZIMm5zsJ9e0Krloyr9rWIyJeXHc+Ixv4/IcoCdm446QMxop+KJ6tykoi5f/PNDFh5ff6EqI+C06VKJ3nyNDHYmaVJ5ivMHR1hRjzfKOg7ecbqOA6eM9CHFFeGtZsgijJGiT+Hm2ze4lSSJ8IFtVriTbjT/S+CJrkkSyQa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1r2bSOn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c7d14191so555646f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726059722; x=1726664522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUq++Ei2esXDAys8clIHN80mRA7dfTbWnLwq32Zv7Xs=;
        b=R1r2bSOn2CHCo633dk2h8dXz8IbdNnxyE8OYcfgtiNAZdN8FUJ0y2WWdax+o8KQh6f
         4IRJvwXfmJj1Ej/E3LZc17NEe1RAuo1JZx0bSSTzBoI76pFJO0m2dSc1277J9arL2/Uv
         jVCSLYrQ/+u7QAjpW9u5pU+6/r4QXEhMKyodGt4DaUBwDjfzKNdONt1WKIyI1c01cqvl
         qZ1dPjXsPs/gQ1U5uRB2a14decQ2QNWiy8k2cFAt3BDhCm+KShK4IYmKD3GzXiws6kmb
         WGFsUOq2/YQ/eQpQFWePvQttebYXUUUowX27xRjPM775uUlfiQ5zDD9yvLgLy9KBe2nQ
         kFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059722; x=1726664522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUq++Ei2esXDAys8clIHN80mRA7dfTbWnLwq32Zv7Xs=;
        b=s9C4CXYh8lZWTu90mMS7vCjfLkfqjdp/wJdKB36JdRV3RIevQUQdBCz+lol+WkHTqZ
         JOrTy/BxZRwk7ITZv8ZjZyCdruqsUBxTViSfV1livaanfpaqvCiRszxruoZd1rb5ZVak
         IiX/s+XD/ZTmstVhdvOwbfDk4jG8sdDNDGfbranhf5lb7iLdLElnF/BeFrYVDuWmN/M3
         Jl7txqio4i7C4bubGb9iDJYp3I3RAa8YjFiza/vP62q5PxhojXd8Ry0XiCOqfJ65Z6Mz
         osF9SSZDDmTLK/A/8vOzbDrQfjyFPLm7fJ69X106n2D41m6e1rSYPCZyG417A7thRXfq
         78jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr5CJ6Oxz7CRICkH/xq2VUMybQs7DY/Ic9i22rKuoRmLqMMgBCP0oCItSwqB2uVvW7bOYiB2+QBP//2GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLfdhvOJSppmoq50hZhRajwIp7vlBJXgeD6qRJS9E9pEW6g4U
	lY5AuXHs73Dgawnof5x9pp12yj0cxIFtwB4TFLLXxlt34YlB8SYFh3LhfaWi9sU=
X-Google-Smtp-Source: AGHT+IFvM2e3c4KEhBUlw1tk1W/xDQpirqXo2+Qhd/4++Q3qZEqhKN8wml9N0gJtVpKblcV8wkkTBw==
X-Received: by 2002:adf:fb52:0:b0:367:938f:550 with SMTP id ffacd0b85a97d-378a8a83f57mr3527796f8f.25.1726059720928;
        Wed, 11 Sep 2024 06:02:00 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35b9sm11541163f8f.70.2024.09.11.06.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:02:00 -0700 (PDT)
Message-ID: <4a893ab4-38d2-44bb-a42b-abb95b062e21@linaro.org>
Date: Wed, 11 Sep 2024 14:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
To: Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 asmadeus@codewreck.org
References: <20240911121919.4167483-1-yeoreum.yun@arm.com>
 <20240911121919.4167483-2-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911121919.4167483-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 13:19, Levi Yun wrote:
> When create_perf_stat_counter() failed, it doesn't close workload.cork_fd
> open in evlist__prepare_workload(). This could make too many open file
> error while __run_perf_stat() repeats.
> 
> Introduce evlist__cancel_workload to close workload.cork_fd and
> wait workload.child_pid until exit to clear child process
> when create_perf_stat_counter() is failed with COUNTER_FATAL.
> 
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/builtin-stat.c |  4 ++++
>   tools/perf/util/evlist.c  | 14 +++++++++++++-
>   tools/perf/util/evlist.h  |  1 +
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 661832756a24..954eb37ce7b8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -763,6 +763,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> 
>   			switch (stat_handle_error(counter)) {
>   			case COUNTER_FATAL:
> +				if (forks)
> +					evlist__cancel_workload(evsel_list);
>   				return -1;
>   			case COUNTER_RETRY:
>   				goto try_again;
> @@ -804,6 +806,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> 
>   				switch (stat_handle_error(counter)) {
>   				case COUNTER_FATAL:
> +					if (forks)
> +						evlist__cancel_workload(evsel_list);
>   					return -1;
>   				case COUNTER_RETRY:
>   					goto try_again_reset;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 3a719edafc7a..51a221679c92 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -46,6 +46,7 @@
>   #include <sys/mman.h>
>   #include <sys/prctl.h>
>   #include <sys/timerfd.h>
> +#include <sys/wait.h>
> 
>   #include <linux/bitops.h>
>   #include <linux/hash.h>
> @@ -1465,7 +1466,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
>   		 * For cancelling the workload without actually running it,
>   		 * the parent will just close workload.cork_fd, without writing
>   		 * anything, i.e. read will return zero and we just exit()
> -		 * here.
> +		 * here (See evlist__cancel_workload()).
>   		 */
>   		if (ret != 1) {
>   			if (ret == -1)
> @@ -1546,6 +1547,17 @@ int evlist__start_workload(struct evlist *evlist)
>   	return 0;
>   }
> 
> +void evlist__cancel_workload(struct evlist *evlist)
> +{
> +	int status;
> +
> +	if (evlist->workload.cork_fd > 0) {
> +		close(evlist->workload.cork_fd);
> +		evlist->workload.cork_fd = -1;
> +		waitpid(evlist->workload.pid, &status, WNOHANG);
> +	}
> +}
> +
>   int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
>   {
>   	struct evsel *evsel = evlist__event2evsel(evlist, event);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index cb91dc9117a2..12f929ffdf92 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -184,6 +184,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target,
>   			     const char *argv[], bool pipe_output,
>   			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
>   int evlist__start_workload(struct evlist *evlist);
> +void evlist__cancel_workload(struct evlist *evlist);
> 
>   struct option;
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

