Return-Path: <linux-kernel+bounces-371459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F19A3B51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E651F27F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95045202647;
	Fri, 18 Oct 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ns0Nlx0E"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE86168C3F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246739; cv=none; b=J5y+R1msH3eNHXerh1e33gsWTo2zz2g+MHugRxBl2q4P28nCDxjOUXdMhlaXr9/lI28GFT20Fo20OF69HrByG1e0FgGpoFADUZB2azFZvhJU+2YG0RVp4uOCQISzvO+PIUMtbpD1lolRGuvudi9y4z8/UCEo2i12Wttjkv82rGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246739; c=relaxed/simple;
	bh=i4pI4wQ6cZA7a8el+WySqRZ2VQCvPBOauH/7EeA/C18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIlsGhI03PSE6x42RXA8/9Yw5VzxQA0Aa1ieIfKp63yGdRdHUhFfizm5EC4Mp+5E2YlE0GR40p5CWJFT+vs4l6nDoxKuUAjHa/AQnpLe+PSwwADWRotJRtME+PikGRE1Rp3Y+EBcteqmXODXtPbp7ewDa8i3yncfTZhIkuo7NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ns0Nlx0E; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1330194f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246737; x=1729851537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mROB2jN6ZMxFraxZNO7iuXbN2awZgK28C7XXu0zIs2k=;
        b=ns0Nlx0EwsUz4nWPdpAfCZhU4aj2zkODzwfZK3d7SZUKdYDqyWkf3Y0ex7bp2DBIyI
         YcPbs6DswunsD7ZqhsQ80GevP+xJAko49PcNC+D45MXt+e24us2U7oRq03b47bHnOE0M
         /pyUZm2ipGOLz2nYC2mE03Xq8UyW1cIOzIt6oCjz5U6Mgh9QHx7Powzo+wJ2tieYQvia
         aIO6cTxn8FB7iykR27DEy+iSo1pULJwDXXaYTweJH5lPAjpH3mPg5Gxtmtw/2JFEju1W
         T3h3E1vzepV8viyVmxX6mQcINzEfQV5wVNubI4eFoFzsufB4IJTHerkylXMn/BFA/nL7
         7jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246737; x=1729851537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mROB2jN6ZMxFraxZNO7iuXbN2awZgK28C7XXu0zIs2k=;
        b=RGI/NqcK+w9whMsZg+0X7ncfDGSWE096H/kxLzmtXqmfLa1wzzbWnMhxVstlPrGFWT
         zt4INXMltdxoDtfXtgW9Rpw5gxvkYJePaeyD1GYI3MOMGgFG4h6V3ihS8dzHxxvjJtIp
         xLH5NLOPzeHBwl61qCkrAc8X/IYimrjELrpmyJj5CYq681voeBvQEo1IlSApvrsrdy+v
         Ak+b+P7K4QqBUmic8b7vKXsrmQZ8Y0MkgkRJSrEHFQiuTflReHL4vS1PrZVSCgSspAUs
         inLiJ4R3zT25tb87i9HGMEvqgu4DOopcm06uGn0lK05WZemVK4RCbGJhktJwJCu5EXC0
         eE5A==
X-Forwarded-Encrypted: i=1; AJvYcCWZc0yp+yd1Fw9x5y6ytVU6hbiWKt30BIjq1OtE9e6jzfx4GC1bJw3oAIGXGsoY7fT4ugahNMhbf1xPQds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAIWg/X4pIBHJz/3aFbxa2rIg09CptRhtOWXxWJjt54Vhgvt+
	HEF59YDuh7erm62xIYYVvoyXcvf1jD2j8YCR8wvyPKrRPSFnr8CXWeG7FDzar1c=
X-Google-Smtp-Source: AGHT+IH35NnqWf8UiBEDjnM1fPjomSDsor0UF59zUDDQcVrtpyw3Qqk4yDgCdGmN7ucKFBx1gP4uEw==
X-Received: by 2002:adf:f2ca:0:b0:37d:3999:7b4 with SMTP id ffacd0b85a97d-37eab4ee7camr1456800f8f.17.1729246736460;
        Fri, 18 Oct 2024 03:18:56 -0700 (PDT)
Received: from [192.168.68.135] ([145.224.66.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf056418sm1533587f8f.34.2024.10.18.03.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:18:56 -0700 (PDT)
Message-ID: <c1987667-c4e5-4c73-8de1-2acacc967c40@linaro.org>
Date: Fri, 18 Oct 2024 11:18:54 +0100
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
 <ZxGXjX_JiTED24wN@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZxGXjX_JiTED24wN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2024 00:02, Namhyung Kim wrote:
> On Tue, Oct 15, 2024 at 03:54:15PM +0100, James Clark wrote:
>> Since the linked fixes: commit, specifying a CPU on hybrid platforms
>> results in an error because Perf tries to open an extended type event
>> on "any" CPU which isn't valid. Extended type events can only be opened
>> on CPUs that match the type.
>>
>> Before (working):
>>
>>    $ perf record --cpu 1 -- true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>>
>> After (not working):
>>
>>    $ perf record -C 1 -- true
>>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>>    Error:
>>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>>    /bin/dmesg | grep -i perf may provide additional information.
>>
>> (Ignore the warning message, that's expected and not particularly
>> relevant to this issue).
>>
>> This is because perf_cpu_map__intersect() of the user specified CPU (1)
>> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
>> CPU map. However for the purposes of opening an event, libperf converts
>> empty CPU maps into an any CPU (-1) which the kernel rejects.
>>
>> Fix it by deleting evsels with empty CPU maps in the specific case where
>> user requested CPU maps are evaluated.
> 
> I think there's a discussion about making default events skippable and
> hide them in the output unless all of them fail.
> 
> Thanks,
> Namhyung
> 

In this case it's still broken if you do -e cycles, not just for default 
events. So I'm not sure if that would help.

James



