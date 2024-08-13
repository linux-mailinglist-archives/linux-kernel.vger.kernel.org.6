Return-Path: <linux-kernel+bounces-285012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EB8950815
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B7E1C22CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AFB19EEA6;
	Tue, 13 Aug 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr/zFB70"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27652364CD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560361; cv=none; b=YJzulM7z87tiSinSUjsSy+jfU6EHIUBfNx8rENSGT/ZJjKAivHs/Z+b1p+K/yG6KKrtOUUxz+ulj4iaNnXmes1OEzonlEd9Ya0LjoT85nNbt1qYGnLVLzm/JtUlkxuKqOPOXTHfmmBJRcvbxXattA62NgpimtFVShxXb1FIjcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560361; c=relaxed/simple;
	bh=gH4AfWpkX9ecT7cf9MoGztkKiShgEvcygcCrHl42nW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En40Wu/AabWfg5UNBfa1sxUHkUihBdiKs39DHKM4S454m0qGkSxKfiI1jWaDYL3ZnTWyJ7D0DXMMcbuzwerKaLn7G91cR7W4EqIXqXXHUM6S+Uh64NRTiT4c/bYXL3uUTi6t5C/R4q65t2fsOfzScgZ0ZgHpPzNuIc8dASWmNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr/zFB70; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368663d7f80so2983597f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723560357; x=1724165157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KqWpoNJ70SnzgynYJwWCiQpBrh2+HZuuBdAfogioYg=;
        b=tr/zFB70LwcxCAIV2kyF8SYcO6RaMxgUxWleaLWbG6BfGxdyJjis4FvKNN83QyeHpn
         A1na75AGK9PsCN41vJtTQECESxfUnfHoISTZHzbQOQQ8XbA9sz+ALJFogBiX8ly4Q7T2
         AqmLhbKQnEJAOTtjNSfOOYv7Us393zAtwAJdmjLVSQiEC7+VaVUgMOj7gv/MPL5WEoNn
         T/D1h5uY2N6iGuEtiU0a8Ak+NRFaIr8y7MMZleg327/5znjdFzKuMBJgFrizRbQ5xUrD
         iPWm248VD9JsyJLPN+FtOOkY+1amgywhPeLdCv5NjS2kbPcsBDy01DjVn2HH7JnhXj6C
         lwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560357; x=1724165157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KqWpoNJ70SnzgynYJwWCiQpBrh2+HZuuBdAfogioYg=;
        b=JRgvZgn/sP0Ugd2vPDB2Y5KbRuf0mExNZ27Q7inXqwl2PfkqRfKcYD3qJzh2BNMF3J
         dDO5t44FDq63QF6bFthL91qYawWo9kHMkztfxwMJzkNHhNyfFK/azncfAjztYnmV5OHh
         RNtK+oPOwvLhPRH8OTEfNja28q2U52ylxybu20m5XzarE21fUtd1uaSI1uJ4ep/sQAbP
         dDYLwXiVh9aSgDXsqRnAA02Q8HpiUxD3XgsDgY1ZgObk2t2NdCz1buvenc/BUO9i8l1z
         /EOaqk0WoW/yFXfaDzKGz20n+M4G9moeoVtOhvSJESSNnWo2TYPM4LnuEe9bPsMj30wu
         V/nw==
X-Forwarded-Encrypted: i=1; AJvYcCVtQjNZpOSLVO44wwLtnRt/NPhUBRb7TpEmzQUB+1GdfSP6lfAz/afXFqH2E//nzkzHyDHJhE4WrI/U1gQVDsAdd4oUY/r6IE8xVfrX
X-Gm-Message-State: AOJu0YxKTsPBlAampLGcHOj1V5rVu4GnFsLChR6V/sRla4PL9evnZ0ra
	VoF0eOO2uuljVLAJpVWp4r/RNUTCfMNJQJ0MmoTTiNrVpPd42m65DedY+mN+OQ8=
X-Google-Smtp-Source: AGHT+IFylDyDwvoSu3xlbdPwaHJWXbFjUmQPkuOqB+U7gUxYCuGGWAsP2bM6cTmZQDpJCnRwEnpNWQ==
X-Received: by 2002:adf:f902:0:b0:367:91d8:a1d2 with SMTP id ffacd0b85a97d-3716ccfc64dmr3297667f8f.30.1723560357326;
        Tue, 13 Aug 2024 07:45:57 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee74csm10506466f8f.48.2024.08.13.07.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:45:57 -0700 (PDT)
Message-ID: <5ac3fc9d-4ed6-46ed-b537-13d27ba46e3b@linaro.org>
Date: Tue, 13 Aug 2024 15:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] perf stat: Make default perf stat command work on Arm
 big.LITTLE
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Ze Gao <zegao2021@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240813132323.98728-1-james.clark@linaro.org>
 <CAP-5=fUVchraZxYg9LY-CtqYZ5DN05-T3vhJmaUG+24Ka6Bsyg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUVchraZxYg9LY-CtqYZ5DN05-T3vhJmaUG+24Ka6Bsyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2024 3:35 pm, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 6:24 AM James Clark <james.clark@linaro.org> wrote:
>>
>> The important patches are 3 and 5, the rest are tidyups and tests.
>>
>> I don't think there is any interaction with the other open issues
>> about the uncore DSU cycles event or JSON/legacy hw event priorities
>> because only hw events on core PMUs are used for the default
>> stat command. And also just sharing the existing x86 code works so
>> no big changes are required.
>>
>> For patch 3 the weak arch specific symbol has to continue to be used
>> rather than picking the implementation based on
>> perf_pmus__supports_extended_type() like in patch 5. This is because
>> that function ends up calling evsel__hw_name() itself which results
>> in recursion. But at least one weak arch_* construct has been removed,
>> so it's better than nothing.
> 
> Let's not do things this way. The use of strings is architecture
> neutral, means we don't need to create new arch functions on things
> like RISC-V, it encapsulates the complexity of things like topdown

If the new arch function is an issue that could be worked around by 
calling perf_pmus__supports_extended_type() on patch 3 as well? It just 
needs a small change to not recurse.

> events, Apple ARM M CPUs not supporting legacy events, etc.

If Apple M doesn't support the HW events does _any_ default Perf stat 
command (hybrid or not) work? I'm not really trying to fix that here, 
just make whatever already works work on big.LITTLE.

> Duplicating the existing x86 logic, when that was something trying to
> be removed, is not the way to go. That logic was a holdover from the
> hybrid tech debt we've been working to remove with a generic approach.
> 
> Thanks,
> Ian
> 

I think all of that may make sense, but in this case I haven't actually 
duplicated anything, rather shared the existing code to also be used on 
Arm.

This means we can have the default perf stat working on Arm from today, 
and if any other changes get made it will continue to work as I've also 
added a test for it.

>> James Clark (7):
>>    perf stat: Initialize instead of overwriting clock event
>>    perf stat: Remove unused default_null_attrs
>>    perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
>>    perf evsel: Remove duplicated __evsel__hw_name() code
>>    perf evlist: Use hybrid default attrs whenever extended type is
>>      supported
>>    perf test: Make stat test work on DT devices
>>    perf test: Add a test for default perf stat command
>>
>>   tools/perf/arch/arm64/util/Build   |  1 +
>>   tools/perf/arch/arm64/util/evsel.c |  7 ++++
>>   tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
>>   tools/perf/arch/x86/util/evsel.c   | 17 +-------
>>   tools/perf/builtin-stat.c          | 12 ++----
>>   tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
>>   tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
>>   tools/perf/util/evlist.h           |  6 +--
>>   tools/perf/util/evsel.c            | 19 +++++++++
>>   tools/perf/util/evsel.h            |  2 +-
>>   10 files changed, 119 insertions(+), 108 deletions(-)
>>   create mode 100644 tools/perf/arch/arm64/util/evsel.c
>>
>> --
>> 2.34.1
>>

