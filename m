Return-Path: <linux-kernel+bounces-279312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C67994BBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD966B24371
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974E18A925;
	Thu,  8 Aug 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f047jw5F"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F618A6AB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114266; cv=none; b=g4MWgLYJ8GfDkr1FS+0nXMroqVQCicbov4GRjgIwcpQuGbj+2Q8W7WIp8+7nMmippXJnXJSmLzg57al1/CIAQdrJ1uwotR5sQDBV/kzf68eTGflWuU8oAWE0jGI4VMFAc7VnqkHmfzVDDMRZRIRB1stnaeoQbZAAoEki0HvDPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114266; c=relaxed/simple;
	bh=sDXpopSO8OTBT44eDgHGiG7YygXpNJImxfELGAGEqBI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U8IPHfCEh/Xy9dzYFjSCbl2/GDFHg9NeTVbz8IEGfjWWenM9NrBrGNJUMIQkI3bDxuWLMdz3z8Es+G6e7nPxJny6jM77u31RCQO8k7heqObHfRaTue53BE+jFPXx+zWT0rRDxiey8e9KEBQ18TLsn9/8V58AIxtVg0X2JbTMzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f047jw5F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368380828d6so440430f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723114262; x=1723719062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4rFtwmjq+6gSRzGjHdsp3/4i675ak1VK4xDruVkNphg=;
        b=f047jw5FwYxAbxtVDkLiTSY0n5u3BMytMpPuQkPyJzLgOCZd4MAl9/nG5lWdInFA4M
         jvUuDiqCclDrjTUaeIO7aIyLKRf+fzmvtTtpa3SuViQmHEVHyqrjxZWdtLbUtafCFCjo
         uiEjoIWMqlm6QHu95VjqZx+Uq4aT4diLb1XAZWAtJWhEHvP9qauqWyV28bEwcZ7b4HBE
         //3AELE+bUld2ar4FxhGIc1FfxyfrXcoWy74lMQ43zLT6KKk32igGB1XciipiufA/9Ng
         D43eNaOjPVIug0AGN27wq7F0tSFNl5nTivC7vIzEcDIAVJw/u0fc0EsUIxw/l+BA05Hq
         Sspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723114262; x=1723719062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rFtwmjq+6gSRzGjHdsp3/4i675ak1VK4xDruVkNphg=;
        b=iap0GFV8vSfg34/Li1vj5ERoKi9cXUbJ0zt+e/zYOe1VmKFGPXsL0W1avo6+ah2Asw
         qK1vG3+QN6MFwzsCLQ7WdYbroBiV+AcXhh3wP0wuEUyhFtpob/SeoajNQ94p0EoEslSq
         0CtRtG79O5RUWEO2iAhc/8t0uBjZq8pCUw5hJLrugFNe/1QzSTiPFUVKCFR/VMBk7cAm
         jENfr58QB5O+83Gdvb486NbWMuXk/Rhs+Y2QUjBM/GekNX5pdU+lsoKtwaRETVqiMrfz
         tZcDO9LcHcAmKvvWiy3CIncC9iCCexb+hls4o6gYaiLcX2zySZK23y1FUfTgIrelM7Rz
         S1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOl3P1o1drNcCDTg8HwfuRkkgJu9qadT9VxdR8naR7t5sT6WwkzWZoS4YFEbY4RZ2pe5P2rl7CI87y7MeHZox6A1xm2hLPmTCqcQqm
X-Gm-Message-State: AOJu0YyEGRF2sfinxWSP5eIjUq/95cb9qit219LYxwVjwIUFs4vKOdNf
	1+KCMeRO6lVaRma7bJylTxK/n7o39QCnLBTFOw3yFHlTBlHNH771Zr8bg/qD7YU=
X-Google-Smtp-Source: AGHT+IHYODqKwPOkMQH3b0u677P1na0+txhJF5Z0f9RBhMkkYBGsORMwRzJ90PQBs6LpH+5KU3ZylA==
X-Received: by 2002:adf:f3c4:0:b0:369:e72c:875f with SMTP id ffacd0b85a97d-36d2756eeb3mr1100344f8f.48.1723114262310;
        Thu, 08 Aug 2024 03:51:02 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27180b97sm1497150f8f.46.2024.08.08.03.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 03:51:01 -0700 (PDT)
Message-ID: <16ea091e-0f3b-44cf-b3b4-b07efabe9c02@linaro.org>
Date: Thu, 8 Aug 2024 11:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
From: James Clark <james.clark@linaro.org>
To: Leo Yan <leo.yan@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
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
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com>
 <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
 <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com>
 <2c0cd5b7-1ca6-4088-817c-209026266d58@linaro.org>
Content-Language: en-US
In-Reply-To: <2c0cd5b7-1ca6-4088-817c-209026266d58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/08/2024 10:21 am, James Clark wrote:
> 
> 
> On 08/08/2024 8:42 am, Leo Yan wrote:
>> On 8/8/2024 5:36 AM, Ganapatrao Kulkarni wrote:
>>>
>>> On 08-08-2024 12:50 am, Leo Yan wrote:
>>>> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
>>>>
>>>>> Is below diff with force option looks good?
>>>>>
>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> index d973c2baed1c..efe34f308beb 100755
>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> @@ -36,7 +36,10 @@ option_list = [
>>>>>                       help="Set path to objdump executable file"),
>>>>>           make_option("-v", "--verbose", dest="verbose",
>>>>>                       action="store_true", default=False,
>>>>> -                   help="Enable debugging log")
>>>>> +                   help="Enable debugging log"),
>>>>> +       make_option("-f", "--force", dest="force",
>>>>> +                   action="store_true", default=False,
>>>>> +                   help="Force decoder to continue")
>>>>>    ]
>>>>>
>>>>>    parser = OptionParser(option_list=option_list)
>>>>> @@ -257,6 +260,12 @@ def process_event(param_dict):
>>>>>                   print("Stop address 0x%x is out of range [ 0x%x 
>>>>> .. 0x%x
>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>>>                   return
>>>>>
>>>>> +       if (stop_addr < start_addr):
>>>>> +               if (options.verbose == True or options.force):
>>>>> +                       print("Packet Discontinuity detected 
>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, 
>>>>> start_addr, dso))
> 
> The options.force for the print should be "options.verbose or not 
> options.force" I think? You want to print the error until the user adds 
> -f, then hide it. Unless verbose is on.
> 
>>>>> +               if (options.force):
>>>>> +                       return
> 
> Oops I had this one the wrong way around in my example. This way is 
> correct.
> 
>>>>
>>>> I struggled a bit for the code - it is confused that force mode 
>>>> bails out
>>>> and the non-force mode continues to run. I prefer to always bail out 
>>>> for
>>>> the discontinuity case, as it is pointless to continue in this case.
>>>
>>> Kept bail out with force option since I though it is not good to hide
>>> the error in normal use, otherwise we never able to notice this error in
>>> the future and it becomes default hidden. Eventually this error should
>>> be fixed.
>>
>> As James said, the issue should be fixed in OpenCSD or Perf decoding 
>> flow.
>>
>> Thus, perf tool should be tolerant errors - report warning and drop
>> discontinuous samples. This would be easier for developers later if face
>> the same issue, they don't need to spend time to locate issue and 
>> struggle
>> for overriding the error.
>>
>> If you prefer to use force option, it might be better to give 
>> reasoning and
>> *suggestion* in one go, something like:
>>
>>      if (stop_addr < start_addr):
>>         print("Packet Discontinuity detected [stop_add:0x%x 
>> start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
>>         print("Use option '-f' following the script for force mode"
>>         if (options.force)
>>             return
>>
>> Either way is fine for me. Thanks a lot for taking time on the issue.
>>
>> Leo
> 
> But your diff looks good Ganapat, I think send a patch with Leo's extra 
> help message added and the first force flipped.

One other small detail about Leo's suggestion print out. Can you add an 
instruction of how to keep the warnings as well:

   print("Use option '-f' following the script for force mode. Add '-v' \
     to continue printing decode warnings.")


