Return-Path: <linux-kernel+bounces-536008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE6A47A68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7258F16EAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0B22A80F;
	Thu, 27 Feb 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irmQPac9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96B22A4E4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652538; cv=none; b=I4ivIrWJNaqiyiXYhVUKtQe5f0w4/fZYnMIGIXIaGO1bHC8XGDjKW8jC91u3IcfuB02Mj3M2Cvf+OzwWS1zPU8M0EyXsYZPXKcL0jT7EYhAia2LnJmq3xMGFkVkpFhgbMHPLR8lyc4iK5wttqmH5Fz9Th/bOP27VQOIypRKnhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652538; c=relaxed/simple;
	bh=XiUg4lquAssfrYJ7zIy7C8r9PFTuRNbILtU8GvqzcGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=g83tnPF5B8E98R3DeFfhm0TFFONb4ED0iBuTSTXbnz9WhHDCx3LnQ8xcpZIgQaTy5nE/ScVRbbX25dQ8pKJRy3XldaXdab5FZil9dXQsCrm/GSfgvZeh/AK0kWlt6todHLq1AqPvuC05+xm6Cb9xRM76/jGzC4jaJUBzaNPEt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=irmQPac9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439a2780b44so4857055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740652532; x=1741257332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPFzFL3HoPChXCAEL+cQ7eabmafPxqsFZAdvcYb7obQ=;
        b=irmQPac99v/jByhVzEFJZiDzQgtXUA9fieu2dd4PtBnhhvk/S1zl0rUtt2u9dE8anW
         Qla7uA1kOIiuG9PG7mMaj3mlNmrHKsdvjta1QyA7N728tY4YoTODJEMUXZrsNqh/7Vip
         7HTPV0fWrhyu3qyRyq7GiMacw5qWJkdxCHrQWeyAUqO6mqOcIiriJqgSqqqImS4yJNRJ
         gtjL8xczKTUbKCUT2LmQwmLfA8Z0ZpHVzIzP+48EApldzJDEPJIOpD+GVBF9DU6o85TN
         uJY9fEDrIPt2CwDw9aLBHTYyAqj5TVC1v0HNbi+bPPU2rEe+uEuVsyrlO+QvJ/C0I1hH
         D/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652532; x=1741257332;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPFzFL3HoPChXCAEL+cQ7eabmafPxqsFZAdvcYb7obQ=;
        b=QzMQFVDdMdxqXKZOnTVhC2PRAGsvap1KKk/Z/RcFdDW9lau9hVua7h+ji+KIxcJfXI
         2Ul1eZgi6iN9/1tGS8VK7uDzCY9RYmits0Z0hSqWoVqPpH6MMVIffXTFAvGaY1qNlb00
         EV1x210iRWKG/GW23HBDOSUyiM9fLMtFWpfWoKGvYG8pukOyOCR2uWobw+FaofkU32ro
         kjtRdq8U6afrsO9gWVZGVGc/SRBS6dIaTI4OGDjHGCkAl2fUuV5FqVNWwUG1lS+OQvik
         DBwmKxGb5Ph6cln5ZB7V3KsdOqKWpi7mNMbk6HViqUlnnGznpVMZhTGXzWrxj3c1whDW
         eYnw==
X-Forwarded-Encrypted: i=1; AJvYcCXtI8zy2JNIpX5/SjahZufubw+wKNCellbeT/RIxQu1QjDdAfhxE5TGe1c3qUUt6ZBcCFkfELVLycXmhic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOkeEex8QC7jDKKZewG+v7aTNMgYg9OpB1WDiqkKiWE9GCTZG
	TnDM5uo6FqH+LHAO18ZjVM6De8F4XVub/dm66dlVOkZRz9f1FCeCANVdEH45JsI=
X-Gm-Gg: ASbGncu2FPBcxd0EIG39lYi8aStcDKzjFhdGVHZQNW/bzx9nRm50/IMs2K1BrtM/4Jv
	HqqALc/VRCV0MSmeTi9Z1oDNc6OlzS4rDWMYb975FCQ1EnushvTH2+Il7a1IgXk/p0Z8Dsly77U
	8nwqPCctm5T9vrUHL0PYYYdjJMlx0adM4+iXXJyIJz0OS/OvxzU+NwhQ5iVMrHKNXWYdGk+6s4H
	JSLycQhwKJIghhva0cEE2weK5eg7J/qzWzB804xKyQ79LTRFBraRUJ+eKP67I6D+TWPy1kCIeqr
	vgaO/j4jDqx/wheBDqiaU3sYW7np3IiXBQ==
X-Google-Smtp-Source: AGHT+IGTDFJiC8AWbAlrfhtEWtcbYEibMXKjCqlgRiPvFG3whc3Ax0mp1g7LPuKQXJRD9RGqRIyApA==
X-Received: by 2002:a05:600c:34c9:b0:439:9828:c422 with SMTP id 5b1f17b1804b1-43abdcd387amr33419975e9.18.1740652531994;
        Thu, 27 Feb 2025 02:35:31 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm49746715e9.30.2025.02.27.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:35:31 -0800 (PST)
Message-ID: <ac1350fd-ef8d-485c-ab70-b38a3ffe9b87@linaro.org>
Date: Thu, 27 Feb 2025 10:35:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests: Fix data symbol test with LTO builds
To: Ian Rogers <irogers@google.com>
References: <20250226230109.314580-1-irogers@google.com>
 <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/02/2025 5:42 am, Ian Rogers wrote:
> On Wed, Feb 26, 2025 at 3:01 PM Ian Rogers <irogers@google.com> wrote:
>>
>> With LTO builds, although regular builds could also see this as
>> all the code is in one file, the datasym workload can realize the
>> buf1.reserved data is never accessed. The compiler moves the
>> variable to bss and only keeps the data1 and data2 parts as
>> separate variables. This causes the symbol check to fail in the
>> test. Make the variable volatile to disable the more aggressive
>> optimization. Rename the variable to make which buf1 in perf is
>> being referred to.
>>
>> Before:
>> ```
>> $ perf test -vv "data symbol"
>> 126: Test data symbol:
>> --- start ---
>> test child forked, pid 299808
>> perf does not have symbol 'buf1'
>> perf is missing symbols - skipping test
>> ---- end(-2) ----
>> 126: Test data symbol                                                : Skip
>> $ nm perf|grep buf1
>> 0000000000a5fa40 b buf1.0
>> 0000000000a5fa48 b buf1.1
>> ```
>>
>> After:
>> ```
>> $ nm perf|grep buf1
>> 0000000000a53a00 d buf1
>> $ perf test -vv "data symbol"126: Test data symbol:
>> --- start ---
>> test child forked, pid 302166
>>   a53a00-a53a39 l buf1
>> perf does have symbol 'buf1'
>> Recording workload...
>> Waiting for "perf record has started" message
>> OK
>> Cleaning up files...
>> ---- end(0) ----
>> 126: Test data symbol                                                : Ok
>> ```
>>
>> Fixes: 3dfc01fe9d12 ("perf test: Add 'datasym' test workload")
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ah, I see we're trying to force -O0 and -fno-inline in the Makefile
> (git.kernel.org is giving 403s):
> https://github.com/torvalds/linux/blob/master/tools/perf/tests/workloads/Build#L11
> Which LTO later undoes. I'm not seeing LTO breakages for brstack.c and
> the shell test "Check branch stack sampling". I think LTO is able to
> optimize this case as it is a variable/struct being optimized, so the
> "-O0" and "-fno-inline" mustn't be being made to apply. Not a wholly
> satisfactory reason to add the volatile, but I'm short on
> alternatives.
> 
> Thanks,
> Ian
> 
> 
> 

Adding -fno-lto to that file works for me (llvm-15):

   CFLAGS_datasym.o          = -fno-lto -g -O0 -fno-inline ...

In fact it looks like we should add this to everywhere we're already 
doing -g and -O0. If lto is just another form of optimisation it should 
be disabled as well.


