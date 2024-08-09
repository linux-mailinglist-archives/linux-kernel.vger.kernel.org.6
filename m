Return-Path: <linux-kernel+bounces-281116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9888E94D345
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2733F1F213B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D35197A98;
	Fri,  9 Aug 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+K06c75"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F91DFE1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216803; cv=none; b=chtdgrKuSUkAvDfFghLCU0EtHcvNf4zoGNpoc3gyOq/AymEpDXodEdHBfYO0l6Cx4KOQl8lbUI0aRadTIkM3CHSpuvOaKvlFrRjVLzM1Q4cxpIFczJuwTVdY0rl0i2rVhk/hv0iCB6hZ7fsChytnQJb6vzhknbcs066hBG8uwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216803; c=relaxed/simple;
	bh=iwUPLESXx6SeVlovMPVG7VEd7FJAhgD94g0Aubv+Mto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms9X84NQGUNl1CNsSTdfWNl4a0pB3Hr95r/7C+zMct3YSVRswDSVAasIv9IvFkCYd2k9M3KA3CZ0AAYBpYdciIgqh6ySpkl1PpyvW5ZzFp0u2fokKxxqFuUVDRipghWIjyEdzgB3FAq8VeU6ih436cjGbjoiCa5G8NqZpTlWm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+K06c75; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so1770834b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723216801; x=1723821601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuHjjD0+jbbUA+k6XyGgH2RnuLm3A6KZozTWTGWl80Q=;
        b=K+K06c75LFqxy0+qRQlWJo30Qp3k2E1s49cE8lJliiL4qZdXfawiSaQlZg5qMH/iDN
         Xirclh9RL914JxDpujhpIAIrJTtIvzk1XtFaJns7JlmWVi1wje4kyke77YQmXgHhB2Jk
         cwmmTzeP7tFxQ+/GNtXo2b7V5qsvhYbf3bw8EEukFozG/JaBBwH35cLN+EmWBWnnEfer
         1x/rW62GBTy7jPXvhqY/BffT8p89l2/znPwN7VjgDQ/swQjwYgIG/ZUaAnJQBiOa2ZoL
         GhaQAYngiPYorhN/SygzC3xvwLEbtiARQaFumVhgNGiBcmP0aiMkVv5w+3CjaRrzHetr
         PkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216801; x=1723821601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuHjjD0+jbbUA+k6XyGgH2RnuLm3A6KZozTWTGWl80Q=;
        b=SnAYpqfCG0tei3n8s8TzK4t3/BkBfBnMGh3XDA5Q5g+vjEZP3aOHLsLLg1rwr5mlHa
         aBHLu4YseY0OTT0j2vBzN5l1os+k0to42KeyXMQXCfQt8yYTDfEaAARbH+k2oIhCBosJ
         NdJY3VjE3jnjbwaGL3AjmVIIQyrpiSwyENuwgtSuf6pEAdoQwV8Z4+pSmjphLBrMqxEY
         K6i5jkiGRzkF54ODKKwkdgbT7KzJcLzDeHxr7CDqu6klA2ETuIGSC9vQy6frn/9Ldnkb
         tZk6OMBMeNCl6KH/qywgA9nHYQpzcgL4+hKQ9+cCEdyzuYpiw6JWVRcC0GoUeXis+/fy
         d8+g==
X-Forwarded-Encrypted: i=1; AJvYcCUEFGzLg4AOCiS9Z2C9nPkTM3p2ItfDSwjWBVMyKC8YQlgmus0hF5cHLbnDkS8fjv8eOS8MdsM2VRBppKH6RxlgeM0RQolasUGoY2bt
X-Gm-Message-State: AOJu0Yyf+7gxzesU8y00TcmxQgnQ3+3gx2hdFLD3cuXzb6MKrT3zYFtN
	J++nS2+0hngd0iCZCFP6fnY0vVFuX6pwrybFftL7ttnVqIflNGlWh9aSnanvjpk=
X-Google-Smtp-Source: AGHT+IG70S5uas7buLXlBz4OkM/rW/DPbP9Mgzb9nG4/GURKryVDE1KhwW9GHFD3PTJx5V0QNrHdIA==
X-Received: by 2002:a05:6a00:39a7:b0:706:747c:76b6 with SMTP id d2e1a72fcca58-710dcae9b0emr2183570b3a.22.1723216800898;
        Fri, 09 Aug 2024 08:20:00 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a076sm2827545b3a.11.2024.08.09.08.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:20:00 -0700 (PDT)
Message-ID: <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
Date: Fri, 9 Aug 2024 16:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 scclevenger@os.amperecomputing.com, acme@redhat.com,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
 james.clark@arm.com, suzuki.poulose@arm.com, Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
 <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/08/2024 3:13 pm, Mike Leach wrote:
> Hi James
> 
> On Thu, 8 Aug 2024 at 10:32, James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 07/08/2024 5:48 pm, Leo Yan wrote:
>>> Hi all,
>>>
>>> On 8/7/2024 3:53 PM, James Clark wrote:
>>>
>>> A minor suggestion: if the discussion is too long, please delete the
>>> irrelevant message ;)
>>>
>>> [...]
>>>
>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> @@ -257,6 +257,11 @@ def process_event(param_dict):
>>>>>                    print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>>>                    return
>>>>>
>>>>> +       if (stop_addr < start_addr):
>>>>> +               if (options.verbose == True):
>>>>> +                       print("Packet Dropped, Discontinuity detected
>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>>>>> dso))
>>>>> +               return
>>>>> +
>>>>
>>>> I suppose my only concern with this is that it hides real errors and
>>>> Perf shouldn't be outputting samples that go backwards. Considering that
>>>> fixing this in OpenCSD and Perf has a much wider benefit I think that
>>>> should be the ultimate goal. I'm putting this on my todo list for now
>>>> (including Steve's merging idea).
>>>
>>> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
>>>
>>>      case CS_ETM_DISCONTINUITY:
>>>           /*
>>>            * The trace is discontinuous, if the previous packet is
>>>            * instruction packet, set flag PERF_IP_FLAG_TRACE_END
>>>            * for previous packet.
>>>            */
>>>           if (prev_packet->sample_type == CS_ETM_RANGE)
>>>                   prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>>>                                         PERF_IP_FLAG_TRACE_END;
>>>
>>> I am wandering if OpenCSD has passed the correct info so Perf decoder can
>>> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
>>> be set (it is a general flag in branch sample), then we can consider use it in
>>> the python script to handle discontinuous data.
>>
>> No OpenCSD isn't passing the correct info here. Higher up in the thread
>> I suggested an OpenCSD patch that makes it detect the error earlier and
>> fixes the issue. It also needs to output a discontinuity when the
>> address goes backwards. So two fixes and then the script works without
>> modifications.
>>
> 
> Which address is going backwards here? - OpenCSD generates trace
> ranges only by walking forwards from the last known address till it
> hits a branch. Unless this wraps round 0x000000 this will never result
> in a backwards address as far as I can see.
> Do you have an example dump with OpenCSD outputting a range packet
> with backwards addresses?
> 
> Mike
> 
The example I have I think is something like this:

1.  Start address / trace on
2.  E
3.  Output range
     ...
4.  Periodic address update
     ...
5.  E
6.  Output range

If decode has gone wrong (but undetectably) between steps 1 and 3. Then 
the next steps still output a second range based on the last periodic 
address received. (I think it might not necessarily have to be a 
periodic address but could also be indirect address packet?). Perf 
converts the ranges into branch samples by taking the end of the first 
range and beginning of the second range. Then the disassembly script 
converts those samples into ranges again by taking the source and 
destination of the last two branch samples.

The original issue that Ganapat saw was that the periodic address causes 
OpenCSD to put the source address of the second range somewhere before 
the first one, even though it didn't output a branch or discontinuity 
that would explain how it got there.

But yes you're right the ranges themselves always go forwards from the 
point of view of their own start and end addresses.

I thought it might be possible for OpenCSD to check against the last 
range output? Although I wasn't sure if maybe it's actually valid to do 
a backwards jump like that without the trace on/off packets with address 
filtering or something?

The root cause is still the incorrect image, but I think this check 
along with the other direct branch check should make it pretty difficult 
for people to make the mistake.

