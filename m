Return-Path: <linux-kernel+bounces-330517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D3979F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E40D1F21546
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55714F9E2;
	Mon, 16 Sep 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEPqR6+c"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32B14E2ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483257; cv=none; b=S+L00mKWLL80FrLs1e9DYXqgbu5BJe/a8BAdTca/xdVCVgGTF4EUY0v/7X6JZpn0SOa7x/lubwkjZeofdlbyuwoIGb+k21lnYPKGZOFh9vbG2LAyCw9JhUSzPirEELtqjEOTXVIMM813z3IVicOluTv8ZTw1ptUnuyxx4D2NkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483257; c=relaxed/simple;
	bh=ntl0y1/Q/RwvsxR/8TTqJztjDFTu6S6bemSEG1jjQBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0xCcL7TmAxpNcMauocgIyms94OyyzN1QVlj/beXesG6xAd6cPOBr3qloeY/gcnKDcSM6y26wAR8vxbNxupjG6URaOHNo6aKrcObPKYT3bUXZe5z73kwNQs2+Pa1MWnpAhKmz3J+u6D+BjedhB96GkpbxSpkE5jzFo0D2r3e9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEPqR6+c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so33860555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726483254; x=1727088054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uh4NEkHKiMJymObaXISine8gbvwHrlRosoYUXwllM2M=;
        b=iEPqR6+cF99b+SSrhXpRH0/lwu0MWE0bdf0j0HL74Zf00T3Vwg/7aedv4lrlYreheE
         qeJL3DI2UPPS4/kR6qpyJdzp86TuOxcJ2d1Yw71BnVBEfspOWOKpNgYYOHVrLR2aZnfF
         cVFmysPUiIqqpstleSaWPkl/D0r5aYfnrnGeldovthPUoXNovzKIh0u3jSBAxwG3mkna
         COb3vBdPhmvC/tPDtgxRUVpahJkKtT9PlFgN0WvlDR3eSONeuR92etukoNXnOSbcRX8t
         RLF7cuOvU8ij5UQ/Hh5YLhlKn8Q/kW94R+O3oualA6K18dGaXtaBTdBhhU1HlIgzQ/0O
         I1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483254; x=1727088054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh4NEkHKiMJymObaXISine8gbvwHrlRosoYUXwllM2M=;
        b=GXVeIHYOS+np2aHJR7uYKMoM0Sa+jrHxDB4Hq8BTDjPpLiHcBSzYEzC5Y8OQDqp1Rm
         FGgNTv8Bz6NefdZ9zWZuxdUmWTbWEHAia2WFFRNOZOWMmd5OSWu8/jBc9jrKmCeFUzs7
         U+KTYMTKdOk4VV1wfetvnAj9pMBt4wuyP891li15i4WrUEOlnScLEb8DDc75KRVM/EBB
         8fvLExUfMN2f3FAnwOrj4tQe728FpiVljjKkhAweUT4G5VYPKJyDCgve1oxHNG4FHaF8
         S3ruJ8u+z8f4v/tPEStGkferQbqQsO82Cnf8TTapZ0ytliGqXkxv99by/OUSEN+T2PK3
         7Qmw==
X-Forwarded-Encrypted: i=1; AJvYcCW65TwenCJXuIa8cX0TKY2znwp3b3v96rFHMlavQ+NXf8oKe4wdyNwxDv+dQQv+SGp+W5uIJiwlhzBHAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcL42jL/mC0O/v0PfWjtFNW7FH7AUVVPvuKR1vDNtEDj2rYnC
	EUFMX4ArXvO4A7lMCoVUN/LFL85PSE0gQiWuO7AP66Xvd40djmEpOGMJUKrEX5c=
X-Google-Smtp-Source: AGHT+IEW1CK4xoE0JM0fHQi3amnmo4pcWJsFhe6LIWUR9maOlvX3yzg2IUc6+DHriOOF104fsotm+Q==
X-Received: by 2002:a05:600c:1c84:b0:42c:b5f1:4508 with SMTP id 5b1f17b1804b1-42cdb57c056mr110924355e9.23.1726483253100;
        Mon, 16 Sep 2024 03:40:53 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800237sm6875635f8f.83.2024.09.16.03.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:40:52 -0700 (PDT)
Message-ID: <ae765643-a5ac-4331-a76d-3e04c1193b6c@linaro.org>
Date: Mon, 16 Sep 2024 11:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] perf scripts python cs-etm: Add start and stop
 arguments
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-7-james.clark@linaro.org>
 <11bca9b1-7eb1-4a13-8f05-9ba5b9c46d24@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <11bca9b1-7eb1-4a13-8f05-9ba5b9c46d24@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2024 14:20, Leo Yan wrote:
> On 9/12/24 16:11, James Clark wrote:>
>> Make it possible to only disassemble a range of timestamps or sample
>> indexes. This will be used by the test to limit the runtime, but it's
>> also useful for users.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   .../scripts/python/arm-cs-trace-disasm.py     | 22 +++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index 02e957d037ea..a097995d8e7b 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -55,6 +55,11 @@ args.add_argument("-k", "--vmlinux",
>>   args.add_argument("-d", "--objdump", nargs="?", 
>> const=default_objdump(),
>>                    help="Show disassembly. Can also be used to change 
>> the objdump path"),
>>   args.add_argument("-v", "--verbose", action="store_true", 
>> help="Enable debugging log")
>> +args.add_argument("--start-time", type=int, help="Time of sample to 
>> start from")
>> +args.add_argument("--stop-time", type=int, help="Time of sample to 
>> stop at")
>> +args.add_argument("--start-sample", type=int, help="Index of sample 
>> to start from")
>> +args.add_argument("--stop-sample", type=int, help="Index of sample to 
>> stop at")
>> +
> 
> It is good to validate the ranges for time and sample indexes, in case
> the user passes unexpected values and can directly report the error.
> 
> BTW, I think it is good to clarify the time is based on monotonic clock
> but not wall-clock time.
> 
> With above changes, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 

Yep makes sense, I can add that

>>   options = args.parse_args()
>>
>>   # Initialize global dicts and regular expression
>> @@ -63,6 +68,7 @@ cpu_data = dict()
>>   disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
>>   disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
>>   cache_size = 64*1024
>> +sample_idx = -1
>>
>>   glb_source_file_name   = None
>>   glb_line_number                = None
>> @@ -151,10 +157,10 @@ def print_disam(dso_fname, dso_start, 
>> start_addr, stop_addr):
>>
>>   def print_sample(sample):
>>          print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x 
>> ip: 0x%016x " \
>> -             "pid: %d tid: %d period: %d time: %d }" % \
>> +             "pid: %d tid: %d period: %d time: %d index: %d}" % \
>>                (sample['cpu'], sample['addr'], sample['phys_addr'], \
>>                 sample['ip'], sample['pid'], sample['tid'], \
>> -              sample['period'], sample['time']))
>> +              sample['period'], sample['time'], sample_idx))
>>
>>   def trace_begin():
>>          print('ARM CoreSight Trace Data Assembler Dump')
>> @@ -216,6 +222,7 @@ def print_srccode(comm, param_dict, sample, 
>> symbol, dso):
>>   def process_event(param_dict):
>>          global cache_size
>>          global options
>> +       global sample_idx
>>
>>          sample = param_dict["sample"]
>>          comm = param_dict["comm"]
>> @@ -231,6 +238,17 @@ def process_event(param_dict):
>>          ip = sample["ip"]
>>          addr = sample["addr"]
>>
>> +       sample_idx += 1
>> +
>> +       if (options.start_time and sample["time"] < options.start_time):
>> +               return
>> +       if (options.stop_time and sample["time"] > options.stop_time):
>> +               exit(0)
>> +       if (options.start_sample and sample_idx < options.start_sample):
>> +               return
>> +       if (options.stop_sample and sample_idx > options.stop_sample):
>> +               exit(0)
>> +
>>          if (options.verbose == True):
>>                  print("Event type: %s" % name)
>>                  print_sample(sample)
>> -- 
>> 2.34.1
>>

