Return-Path: <linux-kernel+bounces-298716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BCC95CA90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF621C2347B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA5183CD8;
	Fri, 23 Aug 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnwRkyxo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D217E01A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409370; cv=none; b=EAaXovtpETrAh+oeLVH92OUwzRz+Qb4b47UsIcK4wq0tMpzf8TePtNl7R5O3bZhJG+NTeEnLhnrqrp6DFW0NvJZBfQ9Rwfq1UdAZxUZJaBJHt8kcva9qQDYcJ2AER0EIkqnSEIWZHKCGGVQ6vl55vETNaNBAGrzpn2Sc6x3Lem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409370; c=relaxed/simple;
	bh=fKHJ/8ZFP9JuplHGSqtUNTEdc9dx2YfKD7x8Q3jZAEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnCMTxqvZfcg+3hG8r1Ufi0JuflbYu2P346XrH+V381ICm+MQa+B2DgxTY9yv9n2zk+cN7ia4wPIL+ctTrmkk6ugdHkDhbHd8uMf7DZhBTWTerqeGn631IMoe9qhLdJOmXUvQq4k23/yyZGHAZCv/8MPYqXY/vKA3T1ErwCnFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnwRkyxo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso18217885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724409367; x=1725014167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUm55HmBdVUnY7b9nUrFMCCp2nXDS0fD0wUC/TvFhmQ=;
        b=jnwRkyxoiJOClZBLSnwPzlxnJ3eKaK/5a1jJewVnDDtZHkDbppc3DmXzAvQd97DFoD
         E7Adym4Ka+lFnNANbicR7713TPly+vcuZenwxQGyKYJnNSprLbjD+TFzSbcAkvpCpbGl
         fa/ypsFL9YL6GW9ES99hdz0rFwZaMx24Nh3V4UjHlxEbg/DHfOlwme7tgmI7S20AOd2j
         WnHBOKbCBLp1OuyaIPC05ehorEg5S7TA+SDxMKw3SUG8Y/xGe39AMa2FyeKOUOTX6l1m
         d22OV65TFHcI30eI+LKlc4z01P9tdRCEEV1YYy81KdzAcDBWf2TZbPI6YlSKdIlYIdha
         Re2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409367; x=1725014167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUm55HmBdVUnY7b9nUrFMCCp2nXDS0fD0wUC/TvFhmQ=;
        b=VaScly6Izr5V2TE7mM0a19Ul7mhLEC9oPOJgGgjqnjfx/Vyigw7xgpipRUO7Bq6Bfh
         fiKjytPSd6sOiKkrtry2cCMVBheU0d4I9IUoMmsjZTm6itsuSTDgGN4djuKw0vhyT/Lm
         4YPaOKeYUSr1tl1BktihYfpJfFN7K1rhKhtMhuz+1Fnl7gQUm0bjTw+Y8/7TTXIq9/Yr
         Z+f7ddXxqPx75xRQfzFxeacWVaQskz3P9BeQaE9BjssZFzKbPAmsk+rvTD8hV0lO8Kct
         n19AnHHJrXriOa5IpotDSkkMmHL4x0AMd+QxboWjCUEPQIOBP5EB24IEF2mHZGuyFeyz
         ybxA==
X-Forwarded-Encrypted: i=1; AJvYcCUPkZ5gZD0ZqcNBXnEgGS6gqzC5gH5OduS90gIYeK4dRfPOtXPVb4wyjLHp4Xg4il1TLuZMCiBXh1ge5DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+Ljhet88wot/E5KUN66kJE7MWzsh1YKfdZpF8agwWK7QNdHo
	ezJ+b4Qp0P/Lawn88nr4WR2xVoKSIDpKbykz4pfTMErPEkKGDmwgxTPHnX0Gl3U=
X-Google-Smtp-Source: AGHT+IHpGlL/vZl9Dn7OIltdnzyiefDa8zo2GYYa+LdqkDj+I6KNwURS7lUt3mMhSS4BKRkBmLrU6Q==
X-Received: by 2002:a5d:4a0b:0:b0:371:890c:891a with SMTP id ffacd0b85a97d-37311840111mr1379574f8f.8.1724409366981;
        Fri, 23 Aug 2024 03:36:06 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e74bbsm242549366b.95.2024.08.23.03.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 03:36:06 -0700 (PDT)
Message-ID: <279c7fae-efff-477e-8649-ff7f6d42dd87@linaro.org>
Date: Fri, 23 Aug 2024 11:36:05 +0100
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
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index e917985bbbe6..90967fd807e6 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>>                  return 0;
>>
>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
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
> I tried Mike's branch with above James's patch and still the segfault is happening to us.
> 

Did you update OpenCSD as well?


