Return-Path: <linux-kernel+bounces-315143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9696BE82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587231F25CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538801DA2E0;
	Wed,  4 Sep 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZSw18nK"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001791E884
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456512; cv=none; b=gV7Nk/lC3azPu4ExI91SFDEqRkm8mbT/txsaxm5kAlW1lhfi41m7/1wMXOsfCTdyhPG/X0iWIBG5owo8UfstlE8tuFF4uPaERa8N2vnjjy8fMv6unNJ1evLWZptOX/dv/9IlfFem2X5T207EUwCadKVS9rV6YarBJ07ewf81X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456512; c=relaxed/simple;
	bh=kjtUooGlIVtIOxJwJi7x8rWAGVQWz7lE9mL2SCVM9uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1eYJiRGsbncuu/j8zuQQJhTyMrxwuUbmt0qXxhErrKYlez/lxqGEvMqgAhI+Ign14DhcYZ9vxLUg/K35/GkGCMQV5VslAJIb+s8vhmoLSgO7Nj5yd2AD3Po32cZb7Ylzs1QedSkKuTewNo1aH7qNbavEVKHJci/Fi96XJoi2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZSw18nK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37747c1d928so567289f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456509; x=1726061309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XU32USFrbwro1OvLR8WXsDMT2lnVNSJ9E7U7jb14JMc=;
        b=qZSw18nKskWn3Mih3pR3S25TWccaRn98+XC0e6Q8f9FSS3+580ccIvMOz+UwImIzEO
         dj1rmq3lOJCEgoVc/BBxqwJV2cnMnSAZREedsou+iLZqCAo+0Mq8b7kDsvCU+SZ8PI8H
         s3RF7J0XNbKCw1GRv6gpsBQb69SkDw0SXbVxDwoi0pAkR30wk/nfJi0DUEgKS6X4IS0L
         efoeSLCgMW8zz73NjKP3DSrDAoLb1U0gMeLvfRFihCL7NZFBDWcpt98VtwKmbz+hirlw
         +uCCVbY2MtZUMFi+DY0C95N2sK2AqUT+o+ir5neik0sNwfhUmHWyyh4F1voAGLaRm5Bb
         ovxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456509; x=1726061309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XU32USFrbwro1OvLR8WXsDMT2lnVNSJ9E7U7jb14JMc=;
        b=DuOLGlik8CLPYtHrznZDVV8m9QYZ4aDFo8p4yMIITl20gTCmxKXW4yQ6IgBs2NwPpC
         DEnYt+YfufQpv/3SWIYOX79NQ69A9NI2sWOyznUDMgzkKjd3bziQ2YinQ7jXoTboELyP
         j5rtVcISSWtXTvZfIve0z6lYLmOc8kJAvz5CuDlLX5ydkE8zi3uaMAv63UDUDhmNV3ij
         oKVrk9StVEb4WUwMs0Z1+GU5mW12MpI5E5Xi/YQoGO+Xg7KGFSF8uoCzh5Cp8VWNDHon
         XXhm8XfGDPwCGP2iF9WWeuZbbz/iuvy/27G/jo/MV/ZfzK/3ZS/begRRPCfPRZvR2C/U
         emRA==
X-Forwarded-Encrypted: i=1; AJvYcCWfyqInVqulE7gAUh7SZYLmSn5bN+DDO/6ILAaDSwUKZChan5THQ0C0fclkqAKiQBVDSxys1V1FyPLNwss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhLMVHVPTYxsT5WtJneW3IEp+RjTKgNIislxAgLDvElrrt4+F
	J63pD6nZlSpUvfodQSjXQ1Q1q/TUZjKSEnhviaDJjfOfLjn9zAT8Or5ahvFGFw4=
X-Google-Smtp-Source: AGHT+IFrT6nrogPPqIWvJa9fPGdGGcQqvcYSi6315XSahz/d7wlDHLKLmbXyQJt6+ieMU3kp92cqSg==
X-Received: by 2002:a5d:4990:0:b0:374:b24e:d2bf with SMTP id ffacd0b85a97d-374bf168f19mr9219346f8f.27.1725456508371;
        Wed, 04 Sep 2024 06:28:28 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ef35sm16841258f8f.13.2024.09.04.06.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:28:27 -0700 (PDT)
Message-ID: <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org>
Date: Wed, 4 Sep 2024 14:28:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf tools: Add fallback for exclude_guest
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <20240904064131.2377873-8-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240904064131.2377873-8-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2024 7:41 am, Namhyung Kim wrote:
> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
> if not.  Let's add a fallback so that it can work with default events.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/util/evsel.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 0de0a72947db3f10..8c4d70f7b2f5b880 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3400,6 +3400,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
>   			  "to fall back to excluding hypervisor samples", paranoid);
>   		evsel->core.attr.exclude_hv = 1;
>   
> +		return true;
> +	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
> +		   !evsel->exclude_GH) {
> +		const char *name = evsel__name(evsel);
> +		char *new_name;
> +		const char *sep = ":";
> +
> +		/* Is there already the separator in the name. */
> +		if (strchr(name, '/') ||
> +		    (strchr(name, ':') && !evsel->is_libpfm_event))
> +			sep = "";
> +
> +		if (asprintf(&new_name, "%s%su", name, sep) < 0)
> +			return false;
> +
> +		free(evsel->name);
> +		evsel->name = new_name;
> +		/* Apple M1 requires exclude_guest */
> +		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
> +		evsel->core.attr.exclude_guest = 1;
> +
>   		return true;
>   	}
>   

Not sure if this is working, for some reason it doesn't try the 
fallback. With exclude guest made mandatory in the Arm PMU, then:

  $ perf stat -e cycles -vvv -- true

   Control descriptor is not initialized
   Opening: cycles
   ------------------------------------------------------------
   perf_event_attr:
     type                             0 (PERF_TYPE_HARDWARE)
     size                             136
     config                           0xb00000000
     sample_type                      IDENTIFIER
     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
     disabled                         1
     inherit                          1
     enable_on_exec                   1
   ------------------------------------------------------------
   sys_perf_event_open: pid 698  cpu -1  group_fd -1  flags 0x8
   sys_perf_event_open failed, error -95
   Warning:
   cycles event is not supported by the kernel.
   Opening: cycles
   ------------------------------------------------------------
   perf_event_attr:
     type                             0 (PERF_TYPE_HARDWARE)
     size                             136
     config                           0xa00000000
     sample_type                      IDENTIFIER
     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
     disabled                         1
     inherit                          1
     enable_on_exec                   1
   ------------------------------------------------------------
   sys_perf_event_open: pid 698  cpu -1  group_fd -1  flags 0x8
   sys_perf_event_open failed, error -95
   Warning:
   cycles event is not supported by the kernel.
   failed to read counter cycles
   failed to read counter cycles

    Performance counter stats for 'true':

      <not supported>      armv8_cortex_a53/cycles/ 

      <not supported>      armv8_cortex_a57/cycles/ 




Other than that, all the tests are passing on Juno (without the 
exclude_guest requirement).

