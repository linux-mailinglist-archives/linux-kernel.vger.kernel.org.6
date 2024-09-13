Return-Path: <linux-kernel+bounces-327816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664A977B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C74B28F27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB031D6DAD;
	Fri, 13 Sep 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPds3xcD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE851D6DAC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217137; cv=none; b=kYc/pebSjxfkyWKjBhQw4isfotYyx5fKw7HtwqGFuzYwVQkxZ2kcHwW5GbQOba0RHB1J2gC1lmUKz1tx9HbgileemOPTiDzFedHRHiJ6N+qWAab8nzb2t0Sojqd+740JdxU3bMGMDdpRBNYB0CgKdgMRwKA+sdlYJTa8mzDyHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217137; c=relaxed/simple;
	bh=3yZ/LOdhIe5CHf1AWmQKkYe5Wjc3+MuuaW5UmU8FqKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l4JVtqfnZPmEPopGlUSKra+HLXAd0Fu9ypCROibwF+jXxZdM/XXWQZMcd7q3frpf/AWW4Vo7rdZWxO/2CvSniH1knvsbWFR8wqUkzOp77wtTgBZq69DYQjvvof4gfBz62cUOBDDJPX/nNYmtjf5esM8x3bjUrOZw32l86Qc8TPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kPds3xcD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso11586835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726217133; x=1726821933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0yQtJG58JXUoEFDgK33aK3NTSveYSA8trxI5g+ylw1M=;
        b=kPds3xcD4TtzxncThi8a/ZY9wb31RhLV0PwigsklAKqP156E24tItrghVdr4sH5mKD
         8DVoifmOjqfh/s6zfDny2juvHkg/GjEMiKLfOYLMm+FOeOVpY6BbolKkrutJXzGnlmFx
         pL2lNnO7TSt23lWPaqHAMgxRkD5pSw6dC9GUmsc7lm3fmbuZhT9zPJSA8knCqlCnNs0D
         HpMhGD69rYBfQ8vMGGnQH3v7b+h3BSkl+wbrpDIiUFDdbFh2dGxVwdxB8ThQueXkLKqm
         4Nv4KuKp7cmrWvOlm+xMTd4Jt6T9yxGuBGc8ywCLy+aLg75kFxS8O+cEESC222TGj6iJ
         jaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726217133; x=1726821933;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yQtJG58JXUoEFDgK33aK3NTSveYSA8trxI5g+ylw1M=;
        b=gXQz8J1XGAxrQsNBp4ZPCnI5/7PNRqDakVlQ1T4ydnCu9ZAvrkZFGu3+0HI326zlrW
         6cXW7X1Xwcdns1QYtsAL20igLlOAGQe3mfJmKvRoe822nuT1yyq5GMTJ52HSi9g7QsU+
         EW8GwQuoz/Wv6hjWrbGqlxRPOIQvdXLiy1N4/0x9VAYdG0X8DximHRv937lwSK5PAFnJ
         Gmn8ZVp8KvQ3my5KzdsEqRHOQGZvBDXWmh8ur8LRbchLdt4UVHwX8itsA+H+o6KreAyz
         6mwsqjn3SLunRL62tuJUSYR6gWF0W/17N8tOnsX+ePKT0aXZqZ9/R0W59Zn8qXM6WZqg
         lgvA==
X-Forwarded-Encrypted: i=1; AJvYcCXgCgYvRNifn2uY+L+5PPj8H37dHhX/FqhriQHtwaIkp+gJzV6XyrDxb9RLOiMIsyitKescfJkBaqhAC9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD8JqSBXgdjdMrwkls7lRK7kpjiy8/XYLSkfNYfMX7AnT5Okj
	d0tQLpLhuozQt9aImo0OCutW3I5B9KUKjuSG/Yo+4ovkXYApHLsLRnH2DHw9YJrYijQjQarsZUn
	yiIqPYA==
X-Google-Smtp-Source: AGHT+IF0j6qGvoyaP+7nUI1CxqqzuRNVbEf9qU1/AjyLXbd9/zthodEAAXNUXlKvklMGrB9M4YpGFg==
X-Received: by 2002:a05:600c:3555:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-42cdbf44f4fmr34910335e9.0.1726217132676;
        Fri, 13 Sep 2024 01:45:32 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de00fsm16216331f8f.99.2024.09.13.01.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:45:31 -0700 (PDT)
Message-ID: <4181eab7-9d86-4043-bff8-1be898946b12@linaro.org>
Date: Fri, 13 Sep 2024 09:45:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
From: James Clark <james.clark@linaro.org>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, asmadeus@codewreck.org
References: <20240913020209.520104-1-yeoreum.yun@arm.com>
 <20240913020209.520104-3-yeoreum.yun@arm.com>
 <39eafc82-dfa8-4e22-9d8a-071ed09460d3@linaro.org>
Content-Language: en-US
In-Reply-To: <39eafc82-dfa8-4e22-9d8a-071ed09460d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2024 09:36, James Clark wrote:
> 
> 
> On 13/09/2024 03:02, Levi Yun wrote:
>> Exit when run_perf_stat() returns an error to avoid continuously
>> repeating the same error message. It's not expected that COUNTER_FATAL
>> or internal errors are recoverable so there's no point in retrying.
>>
>> This fixes the following flood of error messages for permission issues,
>> for example when perf_event_paranoid==3:
>>    perf stat -r 1044 -- false
>>
>>    Error:
>>    Access to performance monitoring and observability operations is 
>> limited.
>>    ...
>>    Error:
>>    Access to performance monitoring and observability operations is 
>> limited.
>>    ...
>>    (repeating for 1044 times).
>>
>> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
>> ---
>> Changes in v2:
>>    - Add some comments.
>> ---
>>   tools/perf/builtin-stat.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 954eb37ce7b8..0153925f2382 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -2875,7 +2875,15 @@ int cmd_stat(int argc, const char **argv)
>>               evlist__reset_prev_raw_counts(evsel_list);
>>
>>           status = run_perf_stat(argc, argv, run_idx);
>> -        if (forever && status != -1 && !interval) {
>> +        /*
>> +         * * Meet COUNTER_FATAL situation (i.e) can't open event 
>> counter.
>> +         * * In this case, there is a high chance of failure in the 
>> next attempt
>> +         * * as well with the same reason. so, stop it.
>> +         * */
> 
> There's something wrong with the formatting here.
> 
> But I don't think the comment answers my question about the other return 
> codes. It just states what the code does.
> 
> There are many more return -1's than just for COUNTER_FATAL, so it's not 
> just that situation anyway. And in addition to that, there is -ENOMEM 
> and others that aren't -1 which aren't explained that they are 
> deliberately explicit retry or ignores.
> 

If I'm understanding what I think it means, what about something like this:

/*
  * Returns -1 for fatal errors which signifies to not continue
  * when in repeat mode.
  *
  * Returns < -1 error codes when stat record is used. These
  * result in the stat information being displayed, but writing
  * to the file fails and is non fatal.
  */
static int __run_perf_stat(int argc, const char **argv, int run_idx)
{



