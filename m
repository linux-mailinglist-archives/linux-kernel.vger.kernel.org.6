Return-Path: <linux-kernel+bounces-331245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0A97AA53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3341C27309
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51418C22;
	Tue, 17 Sep 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31hvlrO6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590513FF5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726538393; cv=none; b=f2luIrGfIXJB1KyNyfuIwQZAARx7r7upgfMGiEh/a0zKW6e3Pe5sV5tQDSwSmo04PkGMxGjxfnjLPIS1BAJ+qg1tjAFD0AHnuH/WEQIoHQTbTwLp4N0USUcAEr30k9I+iex7FA/Mg4WRJ2Mx/fX1SJil2wOOCCtmJqUGnPDCH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726538393; c=relaxed/simple;
	bh=a4cyz9C2TYpaQTgEf3VqxHDqbgfDNEPLnRIQAzrWS04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7yn8GyeAT6L6xcMEcKzgDYkbIsYNXyyTdB9IwPA0aKomcMoDgpjaur7lynoglfWyEfwYToW/dz0XKkQy/YizY+l9bR7NQ2PDCU9jnRZ4/q4hXF4inzo1GH5GBVA3reLd75PG+A/7TKAS9ziEFIQLFau4fq7Axpv//qsHEx8BjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31hvlrO6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d87a1f0791so2668470a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726538391; x=1727143191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eogsbTlEU/20KpLpv0UCHv4GA8kVLu0/JxFWXQRsSU=;
        b=31hvlrO6rdJozOlIHN8V/MFfiqUMCHNaTQbbxg4hQngMTQFDi8pR0M1jAYF9KJtpM5
         2x8et6c7cNZF206CBdmzic6GLb+kS5pCMLHy78frB2dqoBb/Kl8AlEPiGV3CGyFUsNf+
         CHL9zNIGapnTcNbZ9BLuakv/qb/QPTSr/6H62SuW/gD4mD+YpiPqmbFgNddu2xZY94OF
         djFLvxP611pabv/hKwwH8UXbAdksHVfGm+Tp2hn5xCo4LS3u8uaZgTWbAiic/Ulxsk/K
         etL4XIwK+LVy2aW94LzSBF1MNwOP5mccKAqqXNgAtcM7dzDMFY3uHX7HOdLWsFZjKkwM
         j8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726538391; x=1727143191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eogsbTlEU/20KpLpv0UCHv4GA8kVLu0/JxFWXQRsSU=;
        b=P4a3tCAnNS1Q3yG0wHZpp1rMUwakicuhvhmdYhZQr1Kdj24DbYwHrXY4izO7NO115X
         iQND1gAn/nOY7qaWSnPq0BtZOYXCGV78qiNhjA9YGByP5ieLs0jWwoGN8pBhAkVtbZU6
         qMB7JSKj9JFu5JKHGS7RdFNvIQDaT/VB0wGb3mCy06P2Qtz643LPjjfCusdApCOH1G+5
         jmyWYSXXg09uH4ZQQI0KgX71T//D+x25ajj4y67X79vEMmpIeKCeq4Ah3zCgn0x7w5sB
         SOho2xDKbrqagrBSNwlCDMA78XqSL1a/CqoSpVAi9CBwaadnCEPz/nhHTdwo/4v7b630
         xDPw==
X-Gm-Message-State: AOJu0YzDsFLFqhDDYQNwfEAvRX8jqCqGqQR7ah4ci+tz/PzlAL0XC0gZ
	XzJtAFGMtuDttrMNVozcpLAQoTK9Yqpy9wkk6wq1vDibXJgAZFkG6dKX82KNxA==
X-Google-Smtp-Source: AGHT+IEiSrWG76oGSMdtgJ8W8NNxk2NCB1dVYWJNPMFzgRZn9A2zFmCZkc+rVecNPMaHzfQokThRFQ==
X-Received: by 2002:a17:90a:4924:b0:2d8:8d61:8a50 with SMTP id 98e67ed59e1d1-2dbb9f31abcmr15360207a91.32.1726538390300;
        Mon, 16 Sep 2024 18:59:50 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:e1f6:9f31:2c3f:1500? ([2a00:79e0:2e14:7:e1f6:9f31:2c3f:1500])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d972fcsm8174933a91.57.2024.09.16.18.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 18:59:49 -0700 (PDT)
Message-ID: <2dab1111-49fd-43b7-8624-2d61b3d546b1@google.com>
Date: Mon, 16 Sep 2024 18:59:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kyletso@google.com, rdbabiera@google.com,
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
 <ae520641-38a4-405e-89d0-e0921dfc7cff@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <ae520641-38a4-405e-89d0-e0921dfc7cff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thanks for the review!

On 9/16/24 9:05 AM, Krzysztof Kozlowski wrote:
> On 11/09/2024 02:07, Amit Sunil Dhamne wrote:
>> This commit adds a new property "pd-timers" to enable setting of
>> platform/board specific pd timer values for timers that have a range of
>> acceptable values.
>>
>> Cc: Badhri Jagan Sridharan <badhri@google.com>
>> Cc: linux-usb@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Please work on mainline, not ancient tree. You cannot get my CC address
> like that from mainline.
I was working off gregkh's tree on usb-next branch as that's suggested 
for USB development.


> It's not possible. So either you don't develop
> on mainline or you don't use get_maintainers.pl/b4/patman.
>
The above branch and even the tree on Linus' master branch has you
listed as a maintainer
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n17181).
I guess that's why the get_maintainers script probably returned your
email id when I ran it. Please let me know if I missed something :).


>> ---
>>   .../bindings/connector/usb-connector.yaml     | 23 +++++++++++++++++++
>>   include/dt-bindings/usb/pd.h                  |  8 +++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index fb216ce68bb3..9be4ed12f13c 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -253,6 +253,16 @@ properties:
>>   
>>       additionalProperties: false
>>   
>> +  pd-timers:
>> +    description: An array of u32 integers, where an even index (i) is the timer (referenced in
>> +      dt-bindings/usb/pd.h) and the odd index (i+1) is the timer value in ms (refer
> timer of what? OS behavior?
In the context of USB Type C Power Delivery (PD), timers are run on the 
typec protocol driver
(usb/typec/tcpm/tcpm.c).
These are used to keep track of min/max or range of time required to 
enter a PD state with the
goal of a successful USB typec capabilities negotiation.  Eg., the timer 
PD_TIMER_SINK_WAIT_CAP (referred to as SinkWaitCapTimer in spec)would be 
responsible to keep track of whether a power source sent us (as sink) PD 
source capabilities pkts within 600ms (say), if yes, then we would 
transition to the next state or do a state machine reset. USB PD 3.1 
spec refers to these elements as timers and therefore referred to as 
such here.


>> +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
>> +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
>> +      value. The timers may need to be tuned based on the platform. This dt property allows the user
> Do not describe what DT is. We all know what DT properties allow.
> Instead describe how this relates to hardware or boards.
>
> All this is wrongly wrapped. See Coding style (and I am not telling you
> the value on purpose, so you will read the coding style) .


Ack. Thanks for pointing it out, I will fix both the above in the next 
revision.


>
>> +      to assign specific values based on the platform. If these values are not explicitly defined,
>> +      TCPM will use a valid default value for such timers.
> And what is the default?

Defaults are given in (include/linux/usb/pd.h). But I guess I should 
have probably mentioned
that here.


>
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> I guess you want matrix here.

Yes, I should have. Though, I will be re-implementing this such that 
each timer is represented
as a separate property based on Rob and Dmitry's suggestion in
https://lore.kernel.org/lkml/20240916163328.GA394032-robh@kernel.org/ .

>> +
>>   dependencies:
>>     sink-vdos-v1: [ sink-vdos ]
>>     sink-vdos: [ sink-vdos-v1 ]
>> @@ -478,3 +488,16 @@ examples:
>>               };
>>           };
>>       };
>> +
>> +  # USB-C connector with PD timers
>> +  - |
>> +    #include <dt-bindings/usb/pd.h>
>> +    usb {
>> +        connector {
>> +            compatible = "usb-c-connector";
>> +            label = "USB-C";
>> +            pd-timers =
>> +                <PD_TIMER_SINK_WAIT_CAP 600>,
>> +                <PD_TIMER_CC_DEBOUNCE 170>;
> Incorporate it into existing example.
>
Ack.


>> +        };
>> +    };
>> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
>> index e6526b138174..6c58c30f3f39 100644
>> --- a/include/dt-bindings/usb/pd.h
>> +++ b/include/dt-bindings/usb/pd.h
>> @@ -465,4 +465,12 @@
>>   	 | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7	\
>>   	 | ((gi) & 0x3f) << 1 | (ct))
>>   
>> +/* PD Timer definitions */
>> +/* tTypeCSinkWaitCap (Table 6-68 Time Values, USB PD3.1 Spec) */
> Please expand this a bit, so we won't have to reach to external sources.

Ack.

I will incorporate all of your review comments.

Since you are no longer maintaining the
"OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" component, please let 
me know
if you'd still like to be CC'ed in the subsequent revisions.


Thanks,

Amit


>> +#define PD_TIMER_SINK_WAIT_CAP		0
>> +/* tPSSourceOff (Table 6-68 Time Values, USB PD3.1 Spec) */
>> +#define PD_TIMER_PS_SOURCE_OFF		1
>> +/* tCCDebounce (Table 4-33 CC Timing, USB Type-C Cable & Connector Spec Rel2.2) */
>> +#define PD_TIMER_CC_DEBOUNCE		2
>
> Best regards,
> Krzysztof
>

