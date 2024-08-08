Return-Path: <linux-kernel+bounces-279157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D394B9B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7063B1F22311
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E7148850;
	Thu,  8 Aug 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYyIN0sR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE0148FF9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109538; cv=none; b=PQe/h3zXe0EJ/mLu8kLOTLzPmrZW7GaY6gOjZdSyEd+j0zuzJQskCRx/wC65fuh4iUb8JxgU6f+y5MBfh20M1/cUeyoyh5x7/GrdTEj69uH50Jb8ZHZrhJtyzc0mIZpVOfmi5ltoj2/44F5oG4mKFSgubOOLfc4cOk1MP8w0RVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109538; c=relaxed/simple;
	bh=zxySVFEfrtYNocB8KZiK7dPM3yrtAPn4xMbiyP10Sf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN7tIc6Rh2uEFeyQpcqASWh0Jz4KbaBsRWhA0mICWDiqgWbYX7k1uhJfCo/dtDFgW8kCLlckigxCo2JENrgb4uYi2QCCWt/wNVGv1Ox2tuYVpnNylK1X5FzXPbAIVU9jz/mij16K8bltMFzqSNuTCFutYktj/wqWcFNXHHAGUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYyIN0sR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3683178b226so291569f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723109534; x=1723714334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJnjWxXTZVsWNlkG2+poyduCb6IkMW4+aALvzkEQB6E=;
        b=RYyIN0sRXS4oEm05mcjQpwqTWW7XjzKi6qejopcN6GpudoASn4ierQWmpcEy1mE2L/
         W+hLLKlnupU3jKZRnJebZX14qJ6EJ+PZZybATbTZr8JCjNq+e8e5Y43LsRCTaIirCq5k
         Ds/jpv33qj87SdJIF12j+snfdt1Z/NcKsQFJJjc42tiav2wdLx/NjR5I+no4aZuSCM8Q
         xh66mJ9nunK5rOwUIQupoZnknkYwJX5XsbieFSMLu66Nhf0b9AwC6zIRgfGQVstnJWBZ
         i05mmRcn6P8aM2e9pRfk/U+VjYCZL4gkk/Sh2PM2m3nUyY+WuW3rEKvOTQFVS6LOTpf6
         +j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723109534; x=1723714334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJnjWxXTZVsWNlkG2+poyduCb6IkMW4+aALvzkEQB6E=;
        b=F/UZGZt+94eMkaKrV6CRLGlrH9eFGjSlmJEQfmKeJnIMRtIY47IBdWAEw9leLzq/V/
         lSVG3pi8vVIOLe0u5e9GxxzNVzfwGQ7yqGllLeVyZFcPg6uRBY6PDsceNSQEcFiITzjt
         VmRIsXT+u0HGJ3ARjX9Y0ZT1FFDI7n51XUtBxYF5Pr3JpoNaWviVWoaC6R80Pe9Vy79w
         6nk3uvPl3RND8MGHJqN2V7tRFX/2aKXFgEdCd0nPI2uHyrRYpC8Dg8QMfCeFSyQKJip9
         cvUVWB+UTyQe45GL4xm7isLQQm6Ble4qmXU6K+NwHrZwvugOtZwMAQF1kI/E0df+hWeF
         DLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/YxFI0DxOF2KuqDJclm280eeuqlrrMSzAgc3+UvetmMzpO1pMh2XhMb+396HIODxJ/fVPNMwoEtKMiVZ7FaWmqh1AUY2GriIcuVc8
X-Gm-Message-State: AOJu0YwvaYUyw3vaPyLk+GfODN7UB49KHVYkw46ufzDUxRSy6oX2iNal
	RPTgOQqCqSGqWHtMTBHny87LETmvYOyM2VV5xgcPHaaMfGmhOMYtUgF6RL8YCnKzCMIS/hQ/rYC
	+
X-Google-Smtp-Source: AGHT+IFszfgATope1Jfc17yIw/mR6BUNSIZsl3orgqABYh+bWAVC2/1IHHu9XGbwTgIhQflBab5i6w==
X-Received: by 2002:a5d:618a:0:b0:36b:357a:bfee with SMTP id ffacd0b85a97d-36d273c8a46mr1012106f8f.1.1723109534296;
        Thu, 08 Aug 2024 02:32:14 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718f1b4sm1281952f8f.61.2024.08.08.02.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 02:32:13 -0700 (PDT)
Message-ID: <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
Date: Thu, 8 Aug 2024 10:32:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Leo Yan <leo.yan@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/08/2024 5:48 pm, Leo Yan wrote:
> Hi all,
> 
> On 8/7/2024 3:53 PM, James Clark wrote:
> 
> A minor suggestion: if the discussion is too long, please delete the
> irrelevant message ;)
> 
> [...]
> 
>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> @@ -257,6 +257,11 @@ def process_event(param_dict):
>>>                   print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>                   return
>>>
>>> +       if (stop_addr < start_addr):
>>> +               if (options.verbose == True):
>>> +                       print("Packet Dropped, Discontinuity detected
>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>>> dso))
>>> +               return
>>> +
>>
>> I suppose my only concern with this is that it hides real errors and
>> Perf shouldn't be outputting samples that go backwards. Considering that
>> fixing this in OpenCSD and Perf has a much wider benefit I think that
>> should be the ultimate goal. I'm putting this on my todo list for now
>> (including Steve's merging idea).
> 
> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
> 
>     case CS_ETM_DISCONTINUITY:
>          /*
>           * The trace is discontinuous, if the previous packet is
>           * instruction packet, set flag PERF_IP_FLAG_TRACE_END
>           * for previous packet.
>           */
>          if (prev_packet->sample_type == CS_ETM_RANGE)
>                  prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>                                        PERF_IP_FLAG_TRACE_END;
> 
> I am wandering if OpenCSD has passed the correct info so Perf decoder can
> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
> be set (it is a general flag in branch sample), then we can consider use it in
> the python script to handle discontinuous data.

No OpenCSD isn't passing the correct info here. Higher up in the thread 
I suggested an OpenCSD patch that makes it detect the error earlier and 
fixes the issue. It also needs to output a discontinuity when the 
address goes backwards. So two fixes and then the script works without 
modifications.

> 
>>
>> But in the mean time what about having a force option?
>>
>>> +       if (stop_addr < start_addr):
>>> +               if (options.verbose == True or not options.force):
>>> +                       print("Packet Dropped, Discontinuity detected
>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>>> dso))
>>> +               if (not options.force):
>>> +                       return
> 
> If the stop address is less than the start address, it must be something
> wrong. In this case, we can report a warning for discontinuity and directly
> return (also need to save the `addr` into global variable for next parsing).
> 
> I prefer to not add force option for this case - eventually, this will consume
> much time for reporting this kind of failure and need to root causing it. A
> better way is we just print out the reasoning in the log and continue to dump.

But in this case we've identified all the known issues that would cause 
the script to fail and we can fix them in Perf and OpenCSD. There may 
not even be any more issues that will cause the script to fail in the 
future so there's no point in softening the error IMO. That will only 
hide future issues (of which there may be none) and make root causing 
harder when it hits some other tool.

