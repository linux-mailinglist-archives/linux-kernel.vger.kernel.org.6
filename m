Return-Path: <linux-kernel+bounces-308490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E96965DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D241F2778E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19615689B;
	Fri, 30 Aug 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8o3c4Ro"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B413A261
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011905; cv=none; b=dTAqjiuRy6g2YFzt/FBHvctMuhkn1IPvEc1Kx66KT3kIFknVipIxhigOX5lTwJBJwb6f+ilE0rHGXf5wNf55FplrsJ0aNdq5PABCD2E37vi5ljpfIFOxlYzzjN4XstLMhm5v8pCShRYeSJPI2dgXcfQRkppg1rgMSJTtQBWYVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011905; c=relaxed/simple;
	bh=0mSmz5WpliiVjMmizDHsmRyqv1dRHJ9TTKc4+NrQ2g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxiaMBuJDvyqiA/6oHwWj86D8OWf/n/v9Jpl89zbFoNXgVwmsEVhNV9iBasLGO7nanXqYLCoOs/sWAbB3B/uE57yt8URQ0REVu3EQeMzX9KLoVFveL8ajRAOlaSnvBXYHBFlbLFflEiTOxn5WbO2TrixN/FyhCV2X953D9DBBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x8o3c4Ro; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42812945633so14329875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725011902; x=1725616702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK8Ziwx48ZLun9eMEMGl1IMQeFQSPXpJOVp3edXBndA=;
        b=x8o3c4Ro3u51FXy2NAHvmMj0WKe6ZXAhrY0f19YcMA44wgwObY73gJhmVh33pKwIOS
         V39uiijyimaXFycifrhM+CqSDrkh4dkbINu0/Fx3wF5ON73OE9A0XguaRSdCSJ4r/d/6
         wG/BQnKfuKzevxwVs44IkUxhqoMviPPIj6sGz1HANzXEMzM8fH/JjAcROwX3NQHht1sA
         xglHLuz3e/UHx3NvFDaAxTtmpEbMM7vABRgkNb1+2hLxKI5veTCZP3Dnmdvtv5vhJnKI
         mDm5V8kduzkUpFbWsc8YGIbbrb8h/UBvAg5SmzILWW3nrtC78Rs7toMKIEuKl+FhIgrv
         L6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725011902; x=1725616702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK8Ziwx48ZLun9eMEMGl1IMQeFQSPXpJOVp3edXBndA=;
        b=f7BVa6Lun90pvncTi8wQVsldYgYFCVK5OA8UqAaYjEilp635fdqYBXaoMHxf8lnrzL
         fppZgczWmhm6Qyw2zdT4ohDEnO4ADP6xSS/usa04MXTi6RDRwzMkDHGU1RK5N4L+FgDo
         xCxy9ukxvBFkg8Q6Kt2iwgID3sN0Emx8oR6w1vID9iqS1WJrUGq/9dVabRgeDZnPpK4j
         EGdrsrLcWB67gykw/Powww6v9L3NglGkmj5PELmQKbrKaIONMwFraz8ceAMtIRDkdB5O
         WgvWGtHibxbyFGNXeGy6hr6hdPBEPRjiTkKYm4UU7ApMzzynpWGds+V0uswJ0JXh99Jp
         k5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDs5Wbi3v/Lr0481GqMzNgI/zkizdF7gN+dFDmjqpDlir3X8auohRDECuxhmNB278GfCo9cFgk6IVMZMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3bhSZXQpe5aVpOq+SrPni83FOnnCQ0bpzcMZFBl5okQ2HeIA
	vHI7iSLqixYi4MVVzfY8wL82OkPpnDRPFv7c5oUmu8qpq+nCtNqWCR5TojkS9zQ=
X-Google-Smtp-Source: AGHT+IHXWFppzEMO2FQFtiexm/hflVeUc7nTy9Cnb3zVw2dmZw6g9Sd2w7f3/H3Ooqd+K8VqAuPnKg==
X-Received: by 2002:a05:600c:1c83:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42bb025bfebmr44911705e9.17.1725011901252;
        Fri, 30 Aug 2024 02:58:21 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbd1eee1bsm9060265e9.9.2024.08.30.02.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 02:58:20 -0700 (PDT)
Message-ID: <aa159649-4274-4bc4-94fe-f9d112b198df@linaro.org>
Date: Fri, 30 Aug 2024 10:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, scclevenger@os.amperecomputing.com,
 acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
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
 <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
 <51661f76-c02a-49fb-8d68-53a8549acd19@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <51661f76-c02a-49fb-8d68-53a8549acd19@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/08/2024 10:57 am, Ganapatrao Kulkarni wrote:
> 
> Hi James/Mike,
> 
> On 23-08-2024 02:33 pm, James Clark wrote:
>>
>>
>> On 19/08/2024 11:59 am, Mike Leach wrote:
>>> Hi,
>>>
>>> A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1
>>>
>>> Testing I managed to do confirms the N atom on unconditional branches
>>> appear to work. I do not have a test case for the range
>>> discontinuities.
>>>
>>> The checks are enabled using operation flags on decoder creation. See
>>> the docs for details.
>>>
>>> Mike
>>>
>>
>> Hi Mike,
>>
>> I tested the new OpenCSD and I don't see the error anymore in the
>> disassembly script. I'm not sure if we need to go any further and add
>> the backwards check, it looks like just a later symptom and the checks
>> that you've added already prevent it.
>>
>> If you release a new version I can send the perf patch. I was going to
>> use these flags if that looks right to you? As far as I know that's the
>> set that can be always on and won't fail on bad hardware?
>>
>> I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
>> for etmv3 and it's just a nop?
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c 
>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index e917985bbbe6..90967fd807e6 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct 
>> cs_etm_decoder_params *d_params,
>>                  return 0;
>>
>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | 
>> OCSD_OPFLG_CHK_RANGE_CONTINUE |
>> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
>> +#endif
>>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>>                                             decoder->decoder_name,
>> -                                          OCSD_CREATE_FLG_FULL_DECODER,
>> +                                          decode_flags,
>>                                             trace_config, &csid))
>>                          return -1;
>>
> 
> I tried Mike's branch with above James's patch and still the segfault is 
> happening to us.
> 

Looks like the Perf bug is only on the timestamped decode path, you can 
force timeless as a workaround. Timestamps aren't used by the 
disassembly script anyway:

   --itrace=Zb

Full command:

   perf script -i ./kcore -s python:tools/perf/scripts/python/arm-cs-\
      trace-disasm.py --itrace=Zb -- -k ./kcore/kcore_dir/kcore

You can also disable timestamps when recording then you don't need the 
itrace option. This will save you a lot of data anyway.

But I'm still working on the proper fix.

