Return-Path: <linux-kernel+bounces-298555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3F95C8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F2D1C23D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB714A4EF;
	Fri, 23 Aug 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWPpcUXw"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F114A098
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403803; cv=none; b=mrHPm8HRyz86tnxqP1zzIJnKQuxPXMeIM+8SpQkAbM8b73tIDYA/p2u2adGwwjKKFkMmVRB8EvnqEUWbhARlXay+sB0y743rYc235bQILLembE7exBeg+wfO5wqDvZ+er+4pFqQsJiEaqLyWZ3lYxo54IfjCbSD2uXN9vfvBg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403803; c=relaxed/simple;
	bh=5uynC1o6CBudWqUq+nwjfieg3rayqOSXLVHeS+alx7Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZnlnI+Wx1I+kCirAfH+FvwjNeUpLhkFnlZMNkW/c0G9JJobm5Iwv+yfx+QcIsmwdLkaJtvQc7i6sgPsxw3ZfIiQTWUIfbA0ivxEg2u3uoVHFVSidOopXrXyeACun2SA3hhmAsFSiXG1Swxu/hhzVVd/1TmXLIMI/RNfjz8cRNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWPpcUXw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec7ee6f44so2362073a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724403800; x=1725008600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8m43D4uT9zIH+wZ/BoeJ1hhBAWSwjbPxojp1J3Ixwu0=;
        b=eWPpcUXw/AH0cCJ5XwcJriWlsWSV2RjNebL8FR+cAzNIBOvsuMgDiT4WfxTZrW0Li5
         OnY0MZNWGoI7PC3yfdOGvjwVmkvHyesfkXj9PRaEdfqmVGOHautsdninEiQl40aY1LmA
         mWr47p6Efj5RXVY0368H10qhg/0THm3mfrobJagzzUDh6oOZKpmqVtrPXJ3N3XM0B8IU
         EdPzV3AkGjuxH3zbjVsWTh2E8RTAnM/XcSqsgsmsmiUFIlKAYrxxV+ogfdDC3xCHeYF8
         e+AzAmPFprK0B0k3dM8D9ETqdtZaCeg/qKpBbAxt/jKFx0qDJ29RAV2oWE8coVOA6rV5
         BEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403800; x=1725008600;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8m43D4uT9zIH+wZ/BoeJ1hhBAWSwjbPxojp1J3Ixwu0=;
        b=RfdrdW0dLXYThZYfrj3ppxsKVVDY/+3b3558+kwNFcYfQ0pBvKgN/ARc+4pJKjYYmz
         8TwxCa/ZH+AtHOPqf5lP/KppyrggluI0wLpBWlxWXaVTkwNH5XMJ7daMb+s0eyBHlRgO
         8iF+4OxJJllqLXeSsKigYJ/wrj2s4gDlx6j4RLqlXfSkNfgpaEQauxQ6UIEJliOtY0fc
         YzKIdH311AvQqqJI5GYNEM/ZE7eU/YcXkwhBGM3XsaO4sS5JJslhOtA2/u8fcUG9AfAr
         /6zmoLjfsH6C+47DeEOJZleN6dIlQN9/TD42tyULiIZgsUOrnw0wwdi3dmgpA3oR+lwB
         5eNw==
X-Forwarded-Encrypted: i=1; AJvYcCUJN+fBtGYZaT/e8PwDbkQdBCT/oenxAnqBTGXS2B+xlbRBG9GjApVGkL8RRYYSioO47eMn2Ejm70w2vrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dJwTv5vlaGRwLhY+yvbxzkpFAP5kE3v+MY3z9eDGVKy/99OF
	rB92a7ImmgUTojG1QbyOIFuaEiaaBfkMk0MqJKm+IGR+RFlaPvcIC6ucxjCeP94=
X-Google-Smtp-Source: AGHT+IFZruP658JpiEgPY1GV3mcjGC7HeJosewIo/OOWaKejaU9SrrDg1x5anHyv7WySO7R+d4NX/w==
X-Received: by 2002:a05:6402:430f:b0:5bf:7dc:bbae with SMTP id 4fb4d7f45d1cf-5c08915bac4mr1003435a12.6.1724403799671;
        Fri, 23 Aug 2024 02:03:19 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c439asm1849955a12.76.2024.08.23.02.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 02:03:19 -0700 (PDT)
Message-ID: <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
Date: Fri, 23 Aug 2024 10:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Mike Leach <mike.leach@linaro.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: Leo Yan <leo.yan@arm.com>, scclevenger@os.amperecomputing.com,
 acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com
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
 <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
 <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
 <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
 <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/08/2024 11:59 am, Mike Leach wrote:
> Hi,
> 
> A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1
> 
> Testing I managed to do confirms the N atom on unconditional branches
> appear to work. I do not have a test case for the range
> discontinuities.
> 
> The checks are enabled using operation flags on decoder creation. See
> the docs for details.
> 
> Mike
> 

Hi Mike,

I tested the new OpenCSD and I don't see the error anymore in the
disassembly script. I'm not sure if we need to go any further and add
the backwards check, it looks like just a later symptom and the checks
that you've added already prevent it.

If you release a new version I can send the perf patch. I was going to
use these flags if that looks right to you? As far as I know that's the
set that can be always on and won't fail on bad hardware?

I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
for etmv3 and it's just a nop?

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e917985bbbe6..90967fd807e6 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
                 return 0;
  
         if (d_params->operation == CS_ETM_OPERATION_DECODE) {
+               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
+#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
+               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
+                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
+#endif
                 if (ocsd_dt_create_decoder(decoder->dcd_tree,
                                            decoder->decoder_name,
-                                          OCSD_CREATE_FLG_FULL_DECODER,
+                                          decode_flags,
                                            trace_config, &csid))
                         return -1;

> On Fri, 9 Aug 2024 at 16:20, James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 09/08/2024 3:13 pm, Mike Leach wrote:
>>> Hi James
>>>
>>> On Thu, 8 Aug 2024 at 10:32, James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 07/08/2024 5:48 pm, Leo Yan wrote:
>>>>> Hi all,
>>>>>
>>>>> On 8/7/2024 3:53 PM, James Clark wrote:
>>>>>
>>>>> A minor suggestion: if the discussion is too long, please delete the
>>>>> irrelevant message ;)
>>>>>
>>>>> [...]
>>>>>
>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>> @@ -257,6 +257,11 @@ def process_event(param_dict):
>>>>>>>                     print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>>>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>>>>>                     return
>>>>>>>
>>>>>>> +       if (stop_addr < start_addr):
>>>>>>> +               if (options.verbose == True):
>>>>>>> +                       print("Packet Dropped, Discontinuity detected
>>>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>>>>>>> dso))
>>>>>>> +               return
>>>>>>> +
>>>>>>
>>>>>> I suppose my only concern with this is that it hides real errors and
>>>>>> Perf shouldn't be outputting samples that go backwards. Considering that
>>>>>> fixing this in OpenCSD and Perf has a much wider benefit I think that
>>>>>> should be the ultimate goal. I'm putting this on my todo list for now
>>>>>> (including Steve's merging idea).
>>>>>
>>>>> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
>>>>>
>>>>>       case CS_ETM_DISCONTINUITY:
>>>>>            /*
>>>>>             * The trace is discontinuous, if the previous packet is
>>>>>             * instruction packet, set flag PERF_IP_FLAG_TRACE_END
>>>>>             * for previous packet.
>>>>>             */
>>>>>            if (prev_packet->sample_type == CS_ETM_RANGE)
>>>>>                    prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>>>>>                                          PERF_IP_FLAG_TRACE_END;
>>>>>
>>>>> I am wandering if OpenCSD has passed the correct info so Perf decoder can
>>>>> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
>>>>> be set (it is a general flag in branch sample), then we can consider use it in
>>>>> the python script to handle discontinuous data.
>>>>
>>>> No OpenCSD isn't passing the correct info here. Higher up in the thread
>>>> I suggested an OpenCSD patch that makes it detect the error earlier and
>>>> fixes the issue. It also needs to output a discontinuity when the
>>>> address goes backwards. So two fixes and then the script works without
>>>> modifications.
>>>>
>>>
>>> Which address is going backwards here? - OpenCSD generates trace
>>> ranges only by walking forwards from the last known address till it
>>> hits a branch. Unless this wraps round 0x000000 this will never result
>>> in a backwards address as far as I can see.
>>> Do you have an example dump with OpenCSD outputting a range packet
>>> with backwards addresses?
>>>
>>> Mike
>>>
>> The example I have I think is something like this:
>>
>> 1.  Start address / trace on
>> 2.  E
>> 3.  Output range
>>       ...
>> 4.  Periodic address update
>>       ...
>> 5.  E
>> 6.  Output range
>>
>> If decode has gone wrong (but undetectably) between steps 1 and 3. Then
>> the next steps still output a second range based on the last periodic
>> address received. (I think it might not necessarily have to be a
>> periodic address but could also be indirect address packet?). Perf
>> converts the ranges into branch samples by taking the end of the first
>> range and beginning of the second range. Then the disassembly script
>> converts those samples into ranges again by taking the source and
>> destination of the last two branch samples.
>>
>> The original issue that Ganapat saw was that the periodic address causes
>> OpenCSD to put the source address of the second range somewhere before
>> the first one, even though it didn't output a branch or discontinuity
>> that would explain how it got there.
>>
>> But yes you're right the ranges themselves always go forwards from the
>> point of view of their own start and end addresses.
>>
>> I thought it might be possible for OpenCSD to check against the last
>> range output? Although I wasn't sure if maybe it's actually valid to do
>> a backwards jump like that without the trace on/off packets with address
>> filtering or something?
>>
>> The root cause is still the incorrect image, but I think this check
>> along with the other direct branch check should make it pretty difficult
>> for people to make the mistake.
> 
> 
> 

