Return-Path: <linux-kernel+bounces-331610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8597AEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E74B1C2215A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56B1DFE4;
	Tue, 17 Sep 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8OXs0j8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56A1662F4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569331; cv=none; b=n3XepS+eUVLTUORRRSi16ObgL2sgprwJZP5oFSReDty4brFN7YQUJTxF4rg1BY+p8H4aJMALlcRaiB5aQrIPZgttvyIXVZj2KLwqVgc2Nj6LshehoXSi/lnu9LxIWhyDNXsMuYEC38PinkXzoXd46Ftbbzw6geHPmek1LEmAwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569331; c=relaxed/simple;
	bh=OLLhui7Jzx1RAtm7SPJ/skbZFwqbpC+tssfd5yQyu4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWpuwSj8df5uiPCtTkwLe0AEQ0fF866fCpBbAXsndhqumq5oLg3h88zVn7+zIMdZN9tqjzAGy/YDVuvVryLRViveHrVqT5BwVSzZnL5cNFVjTkachNJeiTQPxa6BWZNVVlF9QFJDIrtXR5oSVACZ5Ckol46LSZ6thKJrkeZ5kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8OXs0j8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so53524695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569327; x=1727174127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAMPodNnJ2ZsXz40AQFpJhiS0Su6b6Jl7GEjAbtsmnw=;
        b=T8OXs0j8mhT0ebYPwAGmaqJucLUO3XalxUL/WdhFZb0QFvc+fS57kObLKtCoQ94fEr
         sfWcIhLr2WWunNKi7eu0MN/szUgFKkgQ2hkPurUDRBM/Q5LkQD6vqYEspv4TutCdt6J2
         ilHz7ThyC5xFwJYCZammBy3xOz2dlycJ6X9Q/B2/fEdigDF7VxP4nbYQ6hXLwe9nZoA5
         NuNXhMqcfy7FxdRcJdWykQDNwFA88lnxbdwn0R3VQbq6+Wn7gn/Yw5wz0gXCGtpeYlII
         +Q9ZplXKpq1hcDqckZudPcePxLK2XGyAaHmEVAlXr81xY0a0yN6/mrurZAeGt2Vrkqrv
         4qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569327; x=1727174127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAMPodNnJ2ZsXz40AQFpJhiS0Su6b6Jl7GEjAbtsmnw=;
        b=L4Y+OIDCNnBWzONOY/d2PQFlo5W2InZIId57Bu/YiOlWzLJXZ5mtr6FGzs/9HtVdMp
         CGqoY+lLZGipsYn/GrJL3yT6f91hHXPOSgiVF7N10wvc9YzOPE4Dh+0fLgJvgl3msrqV
         9v+5sVhGnjnLlXgoieRz/pHBUPp3fyd1ED3NORAMf0d13pbAh2lNJq3mMol99/5qQvZy
         BYrCmC5yQgwBO7CfFuczoEn+eapYVgk04apw8QqRAiXKlKtwdQEiP2dBjIQ6FODk6pVd
         oniDTMiskJaLU+YZJ5fxPqJjBaNXRVyJ2ILTTWdb1eAZvQXA1euM1GlcNJgYFFRlVn8E
         6Sig==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1t9r7ai/hOyPQQ/3QP4uXg+48LIwW9w4Bf9QwrvOLreu+Jc44Nazqvv3ipLEYt2/0HWmuys0NG0Xapw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE29Q8MqyG34Uf1vcfS+0knavvtkN6UpUZGYuOzZaX175d01+3
	8oSpi7E6f/rDnVjQljAkNegvlTclKhKqBlRWSEcToaV0mI3m3NBUsDQs46x/NYM=
X-Google-Smtp-Source: AGHT+IHm2U6xGx8sJ45qJ+gaD5HpJzgUWnBj/vF3uyDj48BPvEIizm46jt2g7TAhkcwfXFaD/x2Spw==
X-Received: by 2002:a05:600c:45cf:b0:42c:a802:540a with SMTP id 5b1f17b1804b1-42cdb511f33mr152169365e9.7.1726569326660;
        Tue, 17 Sep 2024 03:35:26 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6bc2c7c2sm9952775e9.0.2024.09.17.03.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:35:26 -0700 (PDT)
Message-ID: <f022afad-793d-4a3d-acad-13fd27dd5e62@linaro.org>
Date: Tue, 17 Sep 2024 11:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf sched: Introduce stats tool
To: Ravi Bangoria <ravi.bangoria@amd.com>, swapnil.sapkal@amd.com
Cc: yu.c.chen@intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 void@manifault.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2024 17:47, Ravi Bangoria wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
> 
> USAGE
> -----
> 
>    # perf sched stats record
>    # perf sched stats report
> 
> Note: Although `perf sched stats` tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since the
> /proc/schedstat is a systemwide file.
> 
> HOW TO INTERPRET THE REPORT
> ---------------------------
> 
> The `perf sched stats report` starts with total time profiling was active
> in terms of jiffies:
> 
>    ----------------------------------------------------------------------------------------------------
>    Time elapsed (in jiffies)                                   :       24537
>    ----------------------------------------------------------------------------------------------------
> 
> Next is CPU scheduling statistics. These are simple diffs of
> /proc/schedstat CPU lines along with description. The report also
> prints % relative to base stat.
> 
> In the example below, schedule() left the CPU0 idle 98.19% of the time.
> 16.54% of total try_to_wake_up() was to wakeup local CPU. And, the total
> waittime by tasks on CPU0 is 0.49% of the total runtime by tasks on the
> same CPU.
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU 0
>    ----------------------------------------------------------------------------------------------------
>    sched_yield() count                                         :           0
>    Legacy counter can be ignored                               :           0
>    schedule() called                                           :       17138
>    schedule() left the processor idle                          :       16827 ( 98.19% )
>    try_to_wake_up() was called                                 :         508
>    try_to_wake_up() was called to wake up the local cpu        :          84 ( 16.54% )
>    total runtime by tasks on this processor (in jiffies)       :  2408959243
>    total waittime by tasks on this processor (in jiffies)      :    11731825 ( 0.49% )
>    total timeslices run on this cpu                            :         311
>    ----------------------------------------------------------------------------------------------------
> 
> Next is load balancing statistics. For each of the sched domains
> (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
> the following three categories:
> 
>    1) Idle Load Balance: Load balancing performed on behalf of a long
>                          idling CPU by some other CPU.
>    2) Busy Load Balance: Load balancing performed when the CPU was busy.
>    3) New Idle Balance : Load balancing performed when a CPU just became
>                          idle.
> 
> Under each of these three categories, sched stats report provides
> different load balancing statistics. Along with direct stats, the
> report also contains derived metrics prefixed with *. Example:
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU 0 DOMAIN SMT CPUS <0, 64>
>    ----------------------------------------- <Category idle> ------------------------------------------
>    load_balance() count on cpu idle                                 :          50   $      490.74 $
>    load_balance() found balanced on cpu idle                        :          42   $      584.21 $
>    load_balance() move task failed on cpu idle                      :           8   $     3067.12 $
>    imbalance sum on cpu idle                                        :           8
>    pull_task() count on cpu idle                                    :           0
>    pull_task() when target task was cache-hot on cpu idle           :           0
>    load_balance() failed to find busier queue on cpu idle           :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu idle           :          42   $      584.21 $
>    *load_balance() success count on cpu idle                        :           0
>    *avg task pulled per successful lb attempt (cpu idle)            :        0.00
>    ----------------------------------------- <Category busy> ------------------------------------------
>    load_balance() count on cpu busy                                 :           2   $    12268.50 $
>    load_balance() found balanced on cpu busy                        :           2   $    12268.50 $
>    load_balance() move task failed on cpu busy                      :           0   $        0.00 $
>    imbalance sum on cpu busy                                        :           0
>    pull_task() count on cpu busy                                    :           0
>    pull_task() when target task was cache-hot on cpu busy           :           0
>    load_balance() failed to find busier queue on cpu busy           :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu busy           :           1   $    24537.00 $
>    *load_balance() success count on cpu busy                        :           0
>    *avg task pulled per successful lb attempt (cpu busy)            :        0.00
>    ---------------------------------------- <Category newidle> ----------------------------------------
>    load_balance() count on cpu newly idle                           :         427   $       57.46 $
>    load_balance() found balanced on cpu newly idle                  :         382   $       64.23 $
>    load_balance() move task failed on cpu newly idle                :          45   $      545.27 $
>    imbalance sum on cpu newly idle                                  :          48
>    pull_task() count on cpu newly idle                              :           0
>    pull_task() when target task was cache-hot on cpu newly idle     :           0
>    load_balance() failed to find busier queue on cpu newly idle     :           0   $        0.00 $
>    load_balance() failed to find busier group on cpu newly idle     :         382   $       64.23 $
>    *load_balance() success count on cpu newly idle                  :           0
>    *avg task pulled per successful lb attempt (cpu newly idle)      :        0.00
>    ----------------------------------------------------------------------------------------------------
> 
> Consider following line:
> 
>    load_balance() found balanced on cpu newly idle                  :         382    $      64.23 $
> 
> While profiling was active, the load-balancer found 382 times the load
> needs to be balanced on a newly idle CPU 0. Following value encapsulated
> inside $ is average jiffies between two events (24537 / 382 = 64.23).

This explanation of the $ fields is quite buried. Is there a way of 
making it clearer with a column header in the report? I think even if it 
was documented in the man pages it might not be that useful.

There are also other jiffies fields that don't use $. Maybe if it was 
like this it could be semi self documenting:

----------------------------------------------------------------------
     Time elapsed (in jiffies)               :        $  24537        $ 
  ----------------------------------------------------------------------

------------------<Category newidle> ---------------------------------
   load_balance() count on cpu newly idle    :   427  $     57.46 avg $
----------------------------------------------------------------------


Other than that:

Tested-by: James Clark <james.clark@linaro.org>

