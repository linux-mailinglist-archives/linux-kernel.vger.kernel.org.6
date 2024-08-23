Return-Path: <linux-kernel+bounces-298717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEC95CA92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D942D1C21444
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CAE17E01E;
	Fri, 23 Aug 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtonqjwy"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC037144
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409478; cv=none; b=hghdhf1OM/a33LrGMeCTk9KdatyEUqzbc5+kMjtY/CGAleQKy5v7nzSg9qzUMPOPzuy44GqKGrO9EbilbDeqC6Iqu0sLBIA/YVvz2oRlbGCRgd7W/TGfzzM+twbwKMZ4NLYlMX/TMF6XWq3t2O5fw7ZaYRH7KjXHy2Yly2gddWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409478; c=relaxed/simple;
	bh=GczNKmYhcbK7dLFgQ1vr2Rk1xOHgHuB4b39eu72Db7I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d76C3/IQw8AdIGs8LFA4LEygCWvMkeoEkpAxk5P/mAJBXkBmnYcz4saEMS2rjZeOSIecoVGx+UrdpERzQLqHyvTW2WI8bf6iRKNqb3baTA1CMLTivUfj863Av3MnPwxeAWTGHc0pM7bIqUlf1MFTg6pn3JuUT+pyU76hTK8dSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtonqjwy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so19116711fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724409475; x=1725014275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v0LeMgJRYBg8K7wbk7ooT8pgvMH0myISlFP95cB3MbM=;
        b=gtonqjwygDfObz9/t19qes5vNEj31SYKqikWJHe0cjb92uiJYkfjPaZqsk9HpO3dvZ
         QeqcMrR1VUDvrx7YB+4u1Mex5XmcUgUWG0FHHS18GpMQudhQ6OBZLi6aJlq+ki5aUW0P
         3TCaX8W1KeQUQhzsVDfizXI2AxZNuoonrvf7vC9sir+oW0PhiEEcS68gtK63q/NhR2YB
         IZC+7WkSPe2aOxjTfOkiKd1rtQowepTEwehajMyAXiLqyxwoWMxlkdlsaAXzTTgkrQ3Z
         o0cAYOj73F86W7U+6QbY8G50HtPwU09trE1V86iHWpJv/xMRd2hwKwMwSM1oq4GKQ81F
         4RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409475; x=1725014275;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0LeMgJRYBg8K7wbk7ooT8pgvMH0myISlFP95cB3MbM=;
        b=umVGtJ8m/XZ+LGfl7+D8rdhRp+XzHwhvCtEebpRtp5sa5ppmqFaf4jN7Fd2JDf7V0O
         BnOuFbDjf8M1+mUE/7RnDLffEvl9K8CDnRNOmhR5ZL89QA4UCGf686B23OLvSkNZtI1a
         MPTrvYH/+v8r94wr0VVTntRvaJf+lU5gGEpjXafhkoA3ZDgQW7CT0ofMXxMNp17VbdTf
         IJswujI2aQuDyyymivyFPzOv8GwAuE8XD8N5rutaS5FGiecDty4g/cg1wymRZAstXeVh
         uDxO5NBXup61GaMaanJkK+fPjplF6U2keBCRb7jkvpbti8cRaSR8PNBQGwMf4NxWAJSK
         LZxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuj53qh+B4hFa7V6FpHUevzltlmtnwWZzpz95Cc/4acC9wHeFrPjq9SeWjW7BR7oBUmq2PJHtoafnaHds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtxqW2O81QRzBCkeYKKBgWhxdry+dlQ0fkROY3rlyBqjwM8/D
	1UIifmB+Fabl0vvjWW3srZ9sj51ROLSgTNND9m+ds3m7mDMZAJ8pW4d8Mcd0DOs=
X-Google-Smtp-Source: AGHT+IF67NWm5TQe0DotXe7LF2ieoS8iTeGL3Ai5V+Wj2UNvOtbNb0R/zaIf1oJOBecKsnnVv4h0JQ==
X-Received: by 2002:a2e:bc08:0:b0:2ee:7a54:3b08 with SMTP id 38308e7fff4ca-2f4f48ec7d5mr14564141fa.3.1724409474311;
        Fri, 23 Aug 2024 03:37:54 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a945dsm1909462a12.94.2024.08.23.03.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 03:37:53 -0700 (PDT)
Message-ID: <2654fbf8-0f1d-46c1-bfd4-936ef8982e19@linaro.org>
Date: Fri, 23 Aug 2024 11:37:52 +0100
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
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, scclevenger@os.amperecomputing.com,
 acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
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
 <279c7fae-efff-477e-8649-ff7f6d42dd87@linaro.org>
Content-Language: en-US
In-Reply-To: <279c7fae-efff-477e-8649-ff7f6d42dd87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/08/2024 11:36 am, James Clark wrote:
> 
> 
> On 23/08/2024 10:57 am, Ganapatrao Kulkarni wrote:
>>
>> Hi James/Mike,
>>
>> On 23-08-2024 02:33 pm, James Clark wrote:
>>>
>>>
>>> On 19/08/2024 11:59 am, Mike Leach wrote:
>>>> Hi,
>>>>
>>>> A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1
>>>>
>>>> Testing I managed to do confirms the N atom on unconditional branches
>>>> appear to work. I do not have a test case for the range
>>>> discontinuities.
>>>>
>>>> The checks are enabled using operation flags on decoder creation. See
>>>> the docs for details.
>>>>
>>>> Mike
>>>>
>>>
>>> Hi Mike,
>>>
>>> I tested the new OpenCSD and I don't see the error anymore in the
>>> disassembly script. I'm not sure if we need to go any further and add
>>> the backwards check, it looks like just a later symptom and the checks
>>> that you've added already prevent it.
>>>
>>> If you release a new version I can send the perf patch. I was going to
>>> use these flags if that looks right to you? As far as I know that's the
>>> set that can be always on and won't fail on bad hardware?
>>>
>>> I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
>>> for etmv3 and it's just a nop?
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index e917985bbbe6..90967fd807e6 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>>>                  return 0;
>>>
>>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
>>> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
>>> +#endif
>>>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>>>                                             decoder->decoder_name,
>>> -                                          OCSD_CREATE_FLG_FULL_DECODER,
>>> +                                          decode_flags,
>>>                                             trace_config, &csid))
>>>                          return -1;
>>>
>>
>> I tried Mike's branch with above James's patch and still the segfault is happening to us.
>>
> 
> Did you update OpenCSD as well?
> 

Oh sorry I only read the second part I see you did.

Can you share your perf.data file? And do you see any of the new warnings:

   DCD_ETMV4_0018 : 0x002e (OCSD_ERR_BAD_DECODE_IMAGE) [Mismatch between trace packets and decode image.]; TrcIdx=3059; CS ID=12; Bad program image - N Atom on unconditional direct BR.



