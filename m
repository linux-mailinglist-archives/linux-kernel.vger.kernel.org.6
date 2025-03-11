Return-Path: <linux-kernel+bounces-555909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2C1A5BE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA1C3A84DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FC2505C2;
	Tue, 11 Mar 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/vyKU0s"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117E2500D0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690305; cv=none; b=I9zTdCGLIz79sXKp3RvEBPAZxIQ/+Lwl8L3ppz0ySLGYkBzW9a61XsYLALiW7LkDKrml9Ov46YiNfh0Eso4DqMict3Aceta02Cgscav70yxpinFFbENATft+zDxTCnY0aN5MRqCy9SPMVJa56Rr21wkf4PjCPJRbuTpw6I4cPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690305; c=relaxed/simple;
	bh=y9Y+L+RYU/vPFTxhKBW/X2KEc/Ka9PkU+4XKpuknK+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry9L7P7/twfMjv6a1LzEakoXbZl+5qq05v8Zfb9BTMHiyvmMxi/sFzuwhZoiGBWtUFxRoO0ZZDR7kNok6NwmpLG7NqmS/MvTTzOh1stKDV799UqZx6A7466imENS/X2u8PhlM1TFred+DgFAzVbCJNyPmSjoB5Zkoiakq0osX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/vyKU0s; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso1701748f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741690301; x=1742295101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2P8F2GGLfkUFwRkVZ5dm2/U96V9+4Rkx3rPGsZzhfo=;
        b=V/vyKU0s3M2gH4By6dJvksBvlwK4yNXCvABT/ve8OHOKjXglb3SMdkFaZigsLVNPeW
         ut6q83hf2uMdNJHvL3d3u94yKTIfmBJhu1RU4twaJVyVVrylapgi0fQu/QQsENSyhuod
         xeGwzXmKIaj2xEi53Hysl9CPGrqpw78IPiALSj6IhcE5o+SPVIQUbekaBbuxMvGXkhfL
         4HB+yRT0K96XhQ2matdmpPhEFaxYwrqGO62Wmtb2Zxa6DTPgDc0WLGjcnOFUhkZsxvAo
         4tIhKbo64isw/fb37uFLC/EpMuT55sx9G/6kV8JxLNnYGCnI0jR+mp8mj9CdXp06yMnc
         8/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741690301; x=1742295101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2P8F2GGLfkUFwRkVZ5dm2/U96V9+4Rkx3rPGsZzhfo=;
        b=AGN2YLTann/Hm66rlzFt5FqUt0Nzt693Igcn2TAkxbh+WxUD1wbv9WOuk2EZzkeYHj
         xT+wx5IJFHVBQ3RbP3cDldya7ORfNTwdQh3AdgJWq6/b8rJDXdilaoMe388ArqTpWoBQ
         NDKXueNZ28+LBz1kXakSbpLybEGd7PY2UJHa3sz31Xz26loTHAmaA+WDzgqAlkY22Rbp
         qLuFsG3NPG2sWyMBXwBsJgkn2KSCSq9DmfBO4tjzIKd+/OYiji95hyUUIa8g5VVOyB2V
         nNulQrQLdPSipuz0b+duLwI+36fFnT4iJK+uTk3IVv5cEWEHTrVja1KuyrW/ZhvET2us
         ZpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZTLV4OsoY+Es2MLR0peenbf7qL2ALeu12fNqFHjxS+4dWOHFoscOQYgK6VxSLbT0Ul2YfTQOpbSrQYxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6xAJ9YuX3QtjagJd6QbaIVS/r8nL28xkcB6sPgCS/re1J2Lr
	sM9fERZMe6YIurDTcjIlZvIVaAqbtdXNiLk+Z1BdAKMlrkHMe22t2wtAkiX9zlg=
X-Gm-Gg: ASbGncsl/dcKSyA0S8WfyqhvdaIRcpPzm5khecQ+goSlgPOhk54DMQHOq9N43i/VCBA
	d/mvruicNSCBr7r6fKnpYySaYFCeUWQhQwR8rhvpP3PyRlpGbF/NbmrWJvYU4W/2AG4SdJXWvBK
	w48XwgVfyD/rGoruHGnhtrROZRqYdG/lY72c80hT7ebTlH/62EbWW7J2+dE8tjvBsmmyc3ym3K1
	PfQlxvSbSjbLXY9ntfqAPWinxgpxeSTgs/qxj6RhXqjXWZ/nvHKVPk/i7xJYxRUghP4aQo+HLdq
	GhszyjaGl+tgleUJLHD9hodS8C0UIxsvK4yXvxRbXh2SkVaivnxm
X-Google-Smtp-Source: AGHT+IEJJPzNgLfcptl57EHHb0UnEGh9dFS0tVqdsWVTsz37qYMFtHuocJnwj7Ln7c4mEz9FzGnpLQ==
X-Received: by 2002:a5d:47c1:0:b0:390:f6aa:4e77 with SMTP id ffacd0b85a97d-39132d3a8f5mr14219936f8f.15.1741690301180;
        Tue, 11 Mar 2025 03:51:41 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfde7sm18093077f8f.32.2025.03.11.03.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:51:40 -0700 (PDT)
Message-ID: <898f1265-522f-44aa-a7da-879870b18807@linaro.org>
Date: Tue, 11 Mar 2025 10:51:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, yeoreum.yun@arm.com,
 Mike Leach <mike.leach@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Leo Yan <leo.yan@linux.dev>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210144933.295798-1-james.clark@linaro.org>
 <20250311102200.GJ9682@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250311102200.GJ9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/2025 10:22 am, Leo Yan wrote:
> On Tue, Dec 10, 2024 at 02:49:28PM +0000, James Clark wrote:
>>
>> Previously the sink had to be specified, but now it auto selects one by
>> default. Including a sink in the examples causes issues when copy
>> pasting the command because it might not work if that sink isn't
>> present. Remove the sink from all the basic examples and create a new
>> section specifically about overriding the default one.
>>
>> Make the text a but more concise now that it's in the advanced section,
>> and similarly for removing the old kernel advice.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/trace/coresight/coresight.rst   | 41 ++++++++-----------
>>   .../userspace-api/perf_ring_buffer.rst        |  4 +-
>>   2 files changed, 18 insertions(+), 27 deletions(-)
>>
>> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
>> index d4f93d6a2d63..806699871b80 100644
>> --- a/Documentation/trace/coresight/coresight.rst
>> +++ b/Documentation/trace/coresight/coresight.rst
>> @@ -462,44 +462,35 @@ queried by the perf command line tool:
>>
>>                  cs_etm//                                    [Kernel PMU event]
>>
>> -       linaro@linaro-nano:~$
>> -
>>   Regardless of the number of tracers available in a system (usually equal to the
>>   amount of processor cores), the "cs_etm" PMU will be listed only once.
>>
>>   A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
>> -listed along with configuration options within forward slashes '/'.  Since a
>> -Coresight system will typically have more than one sink, the name of the sink to
>> -work with needs to be specified as an event option.
>> -On newer kernels the available sinks are listed in sysFS under
>> +provided along with configuration options within forward slashes '/' (see
>> +`Config option formats`_).
>> +
>> +Advanced Perf framework usage
>> +-----------------------------
>> +
>> +Sink selection
>> +~~~~~~~~~~~~~~
>> +
>> +An appropriate sink will be selected automatically for use with Perf, but since
>> +there will typically be more than one sink, the name of the sink to use may be
>> +specified as a special config option prefixed with '@'.
>> +
>> +The available sinks are listed in sysFS under
>>   ($SYSFS)/bus/event_source/devices/cs_etm/sinks/::
>>
>>          root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
>>          tmc_etf0  tmc_etr0  tpiu0
> 
> Just a minor comment.  To reflect the latest hardware, it is good to
> mention the TRBE case, users should not and cannot specify TRBE as the

Is that strictly true? From looking at the code I think you could pick 
one TRBE sink as long as you are only tracing from a single ETM. 
Although yeah it would be pointless.

> sink name.  The driver will give priority for TRBE by default unless
> users specify other sink types.
> 

IMO mentioning TRBE would be overly wordy and not really add anything. 
Removing the sink from all the base examples is exactly to make TRBE 
work without going into detail about why. And the advanced section 
doesn't mention TRBE because manually picking it is never right.

> Otherwise, this is a good polish for me.
> 
> Thanks,
> Leo
> 
>> -On older kernels, this may need to be found from the list of coresight devices,
>> -available under ($SYSFS)/bus/coresight/devices/::
>> -
>> -       root:~# ls /sys/bus/coresight/devices/
>> -        etm0     etm1     etm2         etm3  etm4      etm5      funnel0
>> -        funnel1  funnel2  replicator0  stm0  tmc_etf0  tmc_etr0  tpiu0
>>          root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
>>
>> -As mentioned above in section "Device Naming scheme", the names of the devices could
>> -look different from what is used in the example above. One must use the device names
>> -as it appears under the sysFS.
>> -
>> -The syntax within the forward slashes '/' is important.  The '@' character
>> -tells the parser that a sink is about to be specified and that this is the sink
>> -to use for the trace session.
>> -
>>   More information on the above and other example on how to use Coresight with
>>   the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
>>   repository [#third]_.
>>
>> -Advanced perf framework usage
>> ------------------------------
>> -
>>   AutoFDO analysis using the perf tools
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> @@ -508,7 +499,7 @@ perf can be used to record and analyze trace of programs.
>>   Execution can be recorded using 'perf record' with the cs_etm event,
>>   specifying the name of the sink to record to, e.g::
>>
>> -    perf record -e cs_etm/@tmc_etr0/u --per-thread
>> +    perf record -e cs_etm//u --per-thread
>>
>>   The 'perf report' and 'perf script' commands can be used to analyze execution,
>>   synthesizing instruction and branch events from the instruction trace.
>> @@ -572,7 +563,7 @@ sort example is from the AutoFDO tutorial (https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fwiki%2FAutoFDO%2FTuto&data=05%7C02%7Cleo.yan%40arm.com%7C0d4875673b894a332a5508dd192a1f35%7Cf34e597957d94aaaad4db122a662184d%7C0%7C0%7C638694390923618348%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=vX1RVi4hA2gEqrVk9lvMV8UFVDzvClvUN7yILwv0788%3D&reserved=0
>>          Bubble sorting array of 30000 elements
>>          5910 ms
>>
>> -       $ perf record -e cs_etm/@tmc_etr0/u --per-thread taskset -c 2 ./sort
>> +       $ perf record -e cs_etm//u --per-thread taskset -c 2 ./sort
>>          Bubble sorting array of 30000 elements
>>          12543 ms
>>          [ perf record: Woken up 35 times to write data ]
>> diff --git a/Documentation/userspace-api/perf_ring_buffer.rst b/Documentation/userspace-api/perf_ring_buffer.rst
>> index bde9d8cbc106..dc71544532ce 100644
>> --- a/Documentation/userspace-api/perf_ring_buffer.rst
>> +++ b/Documentation/userspace-api/perf_ring_buffer.rst
>> @@ -627,7 +627,7 @@ regular ring buffer.
>>   AUX events and AUX trace data are two different things.  Let's see an
>>   example::
>>
>> -        perf record -a -e cycles -e cs_etm/@tmc_etr0/ -- sleep 2
>> +        perf record -a -e cycles -e cs_etm// -- sleep 2
>>
>>   The above command enables two events: one is the event *cycles* from PMU
>>   and another is the AUX event *cs_etm* from Arm CoreSight, both are saved
>> @@ -766,7 +766,7 @@ only record AUX trace data at a specific time point which users are
>>   interested in.  E.g. below gives an example of how to take snapshots
>>   with 1 second interval with Arm CoreSight::
>>
>> -  perf record -e cs_etm/@tmc_etr0/u -S -a program &
>> +  perf record -e cs_etm//u -S -a program &
>>     PERFPID=$!
>>     while true; do
>>         kill -USR2 $PERFPID
>> --
>> 2.34.1
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org


