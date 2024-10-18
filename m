Return-Path: <linux-kernel+bounces-371460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FA9A3B54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8569AB28058
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2620111A;
	Fri, 18 Oct 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eI7gmlJe"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6131FF7C2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246792; cv=none; b=nxTf0CNPkeA1lyND0ifStYXbeGgxAIP8uEkngUHANORlDXg3HUidT4BVvtucaFq+GUXJLbTmoquknK9PZ9lXv0EodXND49QH6Dd43pmh5Bf49ZMcDPY57yXYC2jal9ZmHa3R2VBgBfwsj5puvIkWktGNmt4yggWqtxNUvuG47QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246792; c=relaxed/simple;
	bh=OGd9ocCpdN1NGOtY2VTjU/vEoVVEaDKhTyJxQlCqRQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8+k04m3DLRcfF2XjdlvThVWJNu0+SUHnBkZ89yk8GcgtGpY2WIG+tl6xSLrunw7Ia4FVOsYyG9k0Mz/2YwAYg75MciRUoYWmeuAK2RhOwPrI5D1O5+031sqeHTOzcbm9Cs2kvXQcR9tHkhYBWnp3ghTxt03ps4b+cPKelWzkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eI7gmlJe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so19155505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246789; x=1729851589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08KcGJv3WQ/rsZu1dJadxRivbpgZgT+/gVvU/9ZsjLg=;
        b=eI7gmlJeHEwgGvIA2g0zpbtDA6Uys54X9csgWSooELFTXhXFNQ2UD+BdPJnMqp62dB
         nQaMZuBZHX7TIuQrOIyWw0uDuIlqWmLzXMmbmgPGgdSR1ldqB+xSjsD+LOWxPWB+BqkL
         QE70vqHIb5YZN+ZbFWnYsxv6uzKl4MJ6s3CAj64YAcKp+czZKNS4azHPUYV3V0inpAEB
         Zj1OoelhgEKeOoECiR92SEJBemQ2x90IXTSyhM/cPIAEnCZeLAezFYjv9jaHDM1Ck95w
         GxsaAEH60YN+km6ndzxAB5mj0ShTVhO8xEHEZP4cid/L/CK4nOBkWcbJ7+dAqY/5mjZ1
         0pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246789; x=1729851589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08KcGJv3WQ/rsZu1dJadxRivbpgZgT+/gVvU/9ZsjLg=;
        b=BEZcIs4NWchSDYsceJOYaav/KGfjvi4deyADQUNH0Fu3EOrcgtceBS1VbipqV4iGOG
         /2LBUMH1I0F2Suz5n9/SzsfBIogfP8ONaowCpB3yS0N1YPpbGj/cMO6oq/fS3oDpErqd
         CvzKqN10SKdonPbIfTagJvTV8im98XhTB2L8YWd2tisAmtEnTSzEzCG8xcjNE0OdMlZc
         Vw5iY/iipk6jswgAwsAxi7UIPTwaFZHoCiyHD9RxylVhL3ZAUENwCctvzQigz5PtZW5I
         sO58UYpW9krn5eqV0mRH9Ob10m8+ikH/XSZIJ0Y3GQqY1Psw+oOMuqKNYAZKeRHRsBGl
         Rasg==
X-Forwarded-Encrypted: i=1; AJvYcCW1/iM8aF12Glp4XBgkgpoYnyg9A1zRYtBn3VZrtZmE1NCyhmR3r53eu/cLIppTVIOsrOI1qYMTuZYUpaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vBNevGpe0GTI68BWTpKqcqBhfL1A2t3+qvrkMzNs+ZL9nzij
	5LPhZSP3tCoA0ocW/4G3PNbtBTx6Dy3cEFSoXvpnuIB57MU+A3rO6nApJ7dNUoV6Fu9AjtaWBEt
	4uqs=
X-Google-Smtp-Source: AGHT+IHwSPVlAyG06j8oYoxj8Rfl+iY6xNUbcjcj8kDhM1xJn2SDsMdw1BZEhVpY9UHXflDwBy4zgA==
X-Received: by 2002:a05:600c:1988:b0:431:59b2:f0d1 with SMTP id 5b1f17b1804b1-4316163614bmr12258915e9.4.1729246789347;
        Fri, 18 Oct 2024 03:19:49 -0700 (PDT)
Received: from [192.168.68.135] ([145.224.66.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf11560csm1523780f8f.93.2024.10.18.03.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:19:48 -0700 (PDT)
Message-ID: <472dbd91-9efb-4a78-abdb-95d8b0e03c00@linaro.org>
Date: Fri, 18 Oct 2024 11:19:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org>
 <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
 <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
 <CAP-5=fUi-Y408hZmPosfejOW=SkXZZTTvRm326fBz-9zrHk8ew@mail.gmail.com>
 <ZxGZfoH6pMZwANou@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZxGZfoH6pMZwANou@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/10/2024 00:10, Namhyung Kim wrote:
> On Wed, Oct 16, 2024 at 08:01:21AM -0700, Ian Rogers wrote:
>> On Wed, Oct 16, 2024 at 1:29 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>> On 15/10/2024 4:14 pm, Ian Rogers wrote:
>>>> On Tue, Oct 15, 2024 at 7:54 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>> Since the linked fixes: commit, specifying a CPU on hybrid platforms
>>>>> results in an error because Perf tries to open an extended type event
>>>>> on "any" CPU which isn't valid. Extended type events can only be opened
>>>>> on CPUs that match the type.
>>>>>
>>>>> Before (working):
>>>>>
>>>>>     $ perf record --cpu 1 -- true
>>>>>     [ perf record: Woken up 1 times to write data ]
>>>>>     [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>>>>>
>>>>> After (not working):
>>>>>
>>>>>     $ perf record -C 1 -- true
>>>>>     WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>>>>>     Error:
>>>>>     The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>>>>>     /bin/dmesg | grep -i perf may provide additional information.
>>>>>
>>>>> (Ignore the warning message, that's expected and not particularly
>>>>> relevant to this issue).
>>>>>
>>>>> This is because perf_cpu_map__intersect() of the user specified CPU (1)
>>>>> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
>>>>> CPU map. However for the purposes of opening an event, libperf converts
>>>>> empty CPU maps into an any CPU (-1) which the kernel rejects.
>>>>
>>>> Ugh. The cpumap API tries its best to confuse NULL == empty but empty
>>>> can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
>>>> lot like 'all' but sometimes 'all' is only online CPUs. I tried to
>>>> tidy up the naming a while ago, but there is still a mess.
>>>>
>>>
>>> I don't know if you think this is a good opportunity for me to have a go
>>> at finishing separating those? Or is it a dead end?
>>
>> So cpumap (and threadmap) underpin a lot of things, we also used to
>> routinely confuse CPU numbers with cpumap indices that are used to
>> densely index xyarrays with file descriptors, etc. My thought was that
>> we may end up doing a proper Rust libperf that can be under a more
>> permissive license like libbpf - currently libperf is a source of GPL
>> infection. The rewrite would be a good time to clear these things up.
>> I believe someone at RedHat has looked at doing a Rust libperf.
> 
> I really want to rewrite CPU/thread map related code but didn't have
> time to work on it. :(
> 
> It'd be great if we can rewrite it in Rust!  But current libperf API is
> pretty bad and it's not clearly separated from the tools code.  For
> example, accessing internals like evsel->core.xxx should be changed
> first.
> 
>>
>>>>> Fix it by deleting evsels with empty CPU maps in the specific case where
>>>>> user requested CPU maps are evaluated.
>>>>
>>>> If we delete evsels than the indices can be broken for certain things.
>>>> I'm guessing asan testing is clean but the large number of side data
>>>> structures that are indexed by things in another data structure makes
>>>> the whole code base brittle and I am nervous around this change.
>>>>
>>>>> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>
>>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> Ok if we're not completely opposed to doing it this way I will dig a bit
>>> more and double check everything is working.
>>
>> I think it is okay to do it this way (hence the reviewed-by tag) as
>> propagate maps should happen before the xyarrays are set up, it'd be
>> nice if these things were checked at runtime, or by the compiler...
> 
> Right, evsel index is used some places probably we need to update it
> too.
> 
> Thanks,
> Namhyung
> 

Ok I'll check for that.

James


