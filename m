Return-Path: <linux-kernel+bounces-360860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEA99A0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0228FB24F37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30220B1F8;
	Fri, 11 Oct 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TByPLizJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7BC20C462
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640886; cv=none; b=S8D7APYebuysK9B9Gj5EeFmcRKUGpP6MrcuPSIxoOF8W5ulje67WTkTqtAYT6rFHJVXn7S6XUnCyiScvUtJCpOZSYGF9orvPal0keMGgcZ9FMILe4+jhsWdPfGlZee9Ogt+RXygHAn8adEg5PZl3qpj1jwiDm/kqeJhIB7oQ5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640886; c=relaxed/simple;
	bh=Nn8/Ny+5UIYgEWhQEJ+8Qu2PlAEHXJzIvzUmL0e2bz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jSGsYEKB5whtSp8qN+ZNrT2AmQ8B6o8km0q3UTQhsDQxSPsy1F5F574/EUyfxaYErMsU1wHJfU3z4shEz4mpiTvLrLF1XHka2EpIq65O6zYP8kRwALmyycSqdAvPhcmcyk9udjmlI8MfSojcWCRxYvKGos86hKr8ZR4/LS0PoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TByPLizJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43123368ea9so356475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728640883; x=1729245683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdYi5S+1fYwQU95KCqtuWAyYlZLMOLSPd31LVg7L3Qo=;
        b=TByPLizJjIn4fLbZY2AJ/UYNk8gqWjRUPzUsgwEQ2epZWleaBsKqSnbuustzh6AIHl
         ewPyEjLe/QhL7I7NGqcMxwqm2GB5qcriTLkjlm9nvD1LSLip5D7JjE9W1QomaD5tz+rb
         J1FNcCwZaESvpS3DtQAAYKd0ax8WmR1nPpRNksDnVEcQHOiWhz42lhL4sgJ3AxJ2qF7f
         vv6qMEYUr7saR9awgCgSgW+wpXkok99T9ak8+iWr7xUSJbA4mFAuD5gt7DK4xhoyowCt
         pNzfxyRLvBxAKNDYzuVP0s1LCO3xbuEkJL4uCC8QMzTGw4tfCqZC89AqlCZtYQqdOvVu
         ZuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640883; x=1729245683;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdYi5S+1fYwQU95KCqtuWAyYlZLMOLSPd31LVg7L3Qo=;
        b=kSFtSAKYX3NKamaxozukA7ZXiq/aAA77nk4pNFnHDx6kTM2y1M5dSVo2OVl84/qfuB
         gW9Dz/q4DWWQNTRn6ls/cphbSNhHXa+2b/6hEZsLWlMXY39Mz0/5opIQge8ShYtW+ebV
         C1e1GvwGsaV7rG+AdvvODWId5DOAUsYwt5ciz5lJTwDNIrZAzPJKQG8wpr52f8b+uxfH
         Abt2i5AvzVPHAsZWlI0a3ZSU3sLeGGFJ7lUppDfMI//xgCZsQJpzremk6lYQOtfHnknv
         Ahtm8+nU+wFIGWAbJLZZCAIcoauRJKb/wU+TTFwYoJMftRtCNIbjFfVnu85w9Y6KTdKx
         ptxg==
X-Forwarded-Encrypted: i=1; AJvYcCUAL23PpFuGouzrTuLqdiP5SUo+N7OCrBML7Q94tGHLhxG5u7QbYhA8i1BMFeSENEi8jvEW/MKgaWGrtbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMe3NA6y2yNJ8NJdCZbJmvHYYGBqeGyPY55zQyWvkwwjv2RI9
	B0BumfeOB6+91oyznz7/7QXH3I7PpLm5tIIB1hWps6I68FeMUUie/okQJ6W3ADY=
X-Google-Smtp-Source: AGHT+IHy7hJTnyeLkbpXb4pXHj3JW4yE6YMOaGazzDN7HshV58tnZRxeDbNFw2Erg4m63PaJihjCOQ==
X-Received: by 2002:a05:600c:5117:b0:42f:68e8:d874 with SMTP id 5b1f17b1804b1-4311df8cbd8mr13034295e9.31.1728640882950;
        Fri, 11 Oct 2024 03:01:22 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf22d46sm70444095e9.10.2024.10.11.03.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:01:22 -0700 (PDT)
Message-ID: <c32f8c46-3895-49e0-a837-98859345039b@linaro.org>
Date: Fri, 11 Oct 2024 11:01:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] perf test: Tag parallel failing shell tests with
 "(exclusive)"
To: Ian Rogers <irogers@google.com>
References: <20241011073559.431302-1-irogers@google.com>
 <20241011073559.431302-6-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20241011073559.431302-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 8:35 am, Ian Rogers wrote:
> Some shell tests compete for resources and so can't run with other
> tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
> to describe how the tests run as if holding a lock.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/perftool-testsuite_report.sh | 2 +-
>   tools/perf/tests/shell/record.sh                    | 2 +-
>   tools/perf/tests/shell/record_lbr.sh                | 2 +-
>   tools/perf/tests/shell/record_offcpu.sh             | 2 +-
>   tools/perf/tests/shell/stat_all_pmu.sh              | 2 +-
>   tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
>   tools/perf/tests/shell/test_stat_intel_tpebs.sh     | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 

The following ones would also need to be marked as exclusive, not sure 
if you can include those here or you want me to send a patch:

  tools/perf/tests/shell/coresight/asm_pure_loop.sh
  tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
  tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
  tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
  tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
  tools/perf/tests/shell/test_arm_coresight.sh
  tools/perf/tests/shell/test_arm_coresight_disasm.sh
  tools/perf/tests/shell/test_arm_spe.sh

In theory all tests using probes would also need to be exclusive because 
they install and delete probes globally. In practice I don't think I saw 
any failures, whether that's just luck or because of some skips I'm not 
sure.

And this one fails consistently in parallel mode on Arm:

   22: Number of exit events of a simple workload 

     : FAILED!

But it's a C test so I assume there isn't an exclusive mechanism to skip 
it? It doesn't look like it should be affected though, so maybe we could 
leave it failing as a real bug.

Thanks
James


