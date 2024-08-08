Return-Path: <linux-kernel+bounces-279149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C531794B994
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243ECB21B54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC0146A93;
	Thu,  8 Aug 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gub6+wDu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2801465BF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108892; cv=none; b=D5ci9vPxssx0ukXsXMUPDIa9IAessTg1ND48Dq3ELjB81pMsN3nmeoh0EYwdZADQrm7QcaWWpAqFFvscRCaU64rotgTgTdRKsrMmiJSSEGn8sOesOva/4iPAu7xJgifpSxEPSj9qEyobfOLbabOhSv14JV6G6nHer5ANrT4jyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108892; c=relaxed/simple;
	bh=BwonHGSolsRFlCSyM7RVkFLTVCnTVq58YDvGYjt2Yp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4ynBln7a5CPy/ufwE9pkZU6404INWrAwasa7wiZDUbrVA/3IyBGOUDBebxeoFJ+43CWG0FfLCqPavlCx6UPbZIi37h0eUrNFJSR693d4oa21c3NMhGWn2yLXU4EbjfFwOPe5eXOXRuS4hmbIDk8m30RitRPesY4Wy7Emu2HqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gub6+wDu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42809d6e719so5297875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723108888; x=1723713688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9Aj0hImGedN0r8XBp+EEG6ozZaXiN1c6ZDFb+vzCUs=;
        b=Gub6+wDuylC23EZsCG6xbHM4LoDrMbUL6Vq7UntLH8MXUSuvax6irTW+pZ09QFiY0v
         e9hhBRGr7Jn9UOzZjePRIPheXV9A2v5JTA0jcRQzNIUNSx/aVzIqastiHyIqkGH6t3y5
         oNkXLk3nVmQFOWmO8rXWbJV3rcWCFSCjfAzQYnCUJQY5cQDNHFF57buYqINX0nwguPEJ
         bqHt/VghtEB5mETWJ8TDnOoluHK72+xWXYgdXTH4tnx5Ec9AUJ/xcbQYepbg2EBw1E2s
         e1tAK1Rs45qkOCsp2tpqmraP5lMVhV79bGopKsldNQT76vxwth7bvxyUZOEMnqEbQwMf
         2bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723108888; x=1723713688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9Aj0hImGedN0r8XBp+EEG6ozZaXiN1c6ZDFb+vzCUs=;
        b=pye4uTm3sS+gEZ8zk2RRgX4TOjOJirnRCMfFsEFhlto8dntuQXQBU+R8PkdaAad0Sb
         9LN7bMAQQCZSJa6SaEJ2338T4DF38bHNHjtbVqIOb6hZrc8WVtRrogPgkBrlkX5NeYU0
         VLBu1x188rw8wqS/zYEVJGfy+PWb5H8fNSs8WqBd9alxPeA662MQjKkZ7DIz2FGuaB31
         AWA4QzJd4XHNF323R5tDP3J8OGOtBKUlsNJT46eqlkp/jBI8wqXmjfvH2BiB9TgS/25t
         rZJ7AAUNm0J0akVCj5IHNZyrvRMuNB5FR8H7AI1wHyNOLgypii6XgmIW2P5HnhfT9N5M
         GIzg==
X-Forwarded-Encrypted: i=1; AJvYcCW88YAdFPojnP8ZcjIhb8kpHwm3rCkr7EaapF915sp9psZlRq26zVzCFriw71/3MMVYzOWE/VUrx026p1AIQEB43scp0JbI7DgAlEns
X-Gm-Message-State: AOJu0Yzog++vrTUAtbr8DPsZkWolwtqDz67XfTRl6oCxnwhj0+Ri3ek8
	fiknBrsYBAJMzqSVs19f6cZ6f9QAxYIDTCaYem8hy8Ajl34eS+vgRgv0m+iLfjA=
X-Google-Smtp-Source: AGHT+IEiA4CDXCv8OTzI+UG0NobqYhcCCUan0vO2KXfbL7Xq1am0SRp8jHGYihoFGGgtmvDpYoz01A==
X-Received: by 2002:a05:600c:5117:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-4290af0b1f2mr8901255e9.25.1723108888458;
        Thu, 08 Aug 2024 02:21:28 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718d680sm1246882f8f.60.2024.08.08.02.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 02:21:28 -0700 (PDT)
Message-ID: <2c0cd5b7-1ca6-4088-817c-209026266d58@linaro.org>
Date: Thu, 8 Aug 2024 10:21:24 +0100
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
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com>
 <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
 <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/08/2024 8:42 am, Leo Yan wrote:
> On 8/8/2024 5:36 AM, Ganapatrao Kulkarni wrote:
>>
>> On 08-08-2024 12:50 am, Leo Yan wrote:
>>> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
>>>
>>>> Is below diff with force option looks good?
>>>>
>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> index d973c2baed1c..efe34f308beb 100755
>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> @@ -36,7 +36,10 @@ option_list = [
>>>>                       help="Set path to objdump executable file"),
>>>>           make_option("-v", "--verbose", dest="verbose",
>>>>                       action="store_true", default=False,
>>>> -                   help="Enable debugging log")
>>>> +                   help="Enable debugging log"),
>>>> +       make_option("-f", "--force", dest="force",
>>>> +                   action="store_true", default=False,
>>>> +                   help="Force decoder to continue")
>>>>    ]
>>>>
>>>>    parser = OptionParser(option_list=option_list)
>>>> @@ -257,6 +260,12 @@ def process_event(param_dict):
>>>>                   print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>>                   return
>>>>
>>>> +       if (stop_addr < start_addr):
>>>> +               if (options.verbose == True or options.force):
>>>> +                       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))

The options.force for the print should be "options.verbose or not 
options.force" I think? You want to print the error until the user adds 
-f, then hide it. Unless verbose is on.

>>>> +               if (options.force):
>>>> +                       return

Oops I had this one the wrong way around in my example. This way is correct.

>>>
>>> I struggled a bit for the code - it is confused that force mode bails out
>>> and the non-force mode continues to run. I prefer to always bail out for
>>> the discontinuity case, as it is pointless to continue in this case.
>>
>> Kept bail out with force option since I though it is not good to hide
>> the error in normal use, otherwise we never able to notice this error in
>> the future and it becomes default hidden. Eventually this error should
>> be fixed.
> 
> As James said, the issue should be fixed in OpenCSD or Perf decoding flow.
> 
> Thus, perf tool should be tolerant errors - report warning and drop
> discontinuous samples. This would be easier for developers later if face
> the same issue, they don't need to spend time to locate issue and struggle
> for overriding the error.
> 
> If you prefer to use force option, it might be better to give reasoning and
> *suggestion* in one go, something like:
> 
>      if (stop_addr < start_addr):
>         print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
>         print("Use option '-f' following the script for force mode"
>         if (options.force)
>             return
> 
> Either way is fine for me. Thanks a lot for taking time on the issue.
> 
> Leo
>   

But your diff looks good Ganapat, I think send a patch with Leo's extra 
help message added and the first force flipped.

