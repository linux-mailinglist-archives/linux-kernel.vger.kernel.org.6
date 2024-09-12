Return-Path: <linux-kernel+bounces-327407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6994897758F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB41C24266
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03251C4601;
	Thu, 12 Sep 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpxfaHD6"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0F1C245A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183590; cv=none; b=NJMU0E0zN0etu+a8xuWG/MVW/+VhFHdvdcYV53IEZBfx0SVgdY2Rad8oCaZvM/I9fB3FK2KMtJ6+BlKvYk05DKjLoZMlx3f9amCRD7OTNWSkRKy9PitKW54F1Sy0+G5KFNnKvWeV5ZfeDIXrJYeJGsQzxswILRyK3mewGhyGlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183590; c=relaxed/simple;
	bh=AaV5BIZtfsOqmNhxqEnd/CUMPikNikqc4gb0i/esfeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkAC1HYLA5ibQ7H7xJOKvI7sdcKcFaRtWHN3glbFvcD6cfI5p95NVgbsnbXiLSWFx0VeRj/qPaZqQtvGhVS8KaGwv/p2eoDjQgO7QjsEWA3o83iQTD6PZcRh8A0k6MKdK3hDVb4unE9aLEhYnoKoFCoP5QLh8pU2uo7d1Di6Hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpxfaHD6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d87176316eso1961036a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726183589; x=1726788389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZdUE8Iodj8kUFxgn8s41HQN9QXU5H4aO1QpJ5Ef1es=;
        b=HpxfaHD6W4L5Y3wWceCwTWYEdAMurQx+kgQLWhsRX2pN9BDZhhpiiL4jmBi0ZTo5wp
         MdwE9GJTYQHssSkHXEHjcZoOcQYLjPRbrvEKzVoEr/QVCCogSj12PA292CbSep/ydpwR
         1dFV+EL233VpV6aQIqxRqFM1nZ5ebVVDlRc+5gmMOeHuRdU0IoZ5DsE9ucSFlte+wkCM
         k8HIpegNfgvyyMqQoEbPbI9rZlgECNbL34NeFMeBaPuQxKAVRDe+1AxggMdQMZycdyfV
         vauOBAZ0ma7V5Qbp9Gh4B+15xxqC0eN8LtOPeWsi3SkyfwMWCKvbnyeOuqsB7+NgLu4Q
         vF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183589; x=1726788389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZdUE8Iodj8kUFxgn8s41HQN9QXU5H4aO1QpJ5Ef1es=;
        b=i36C9bV3cv6u8URYNESlh0SzNAxbgXUzx+VpxWFiKw9J21ips32cd8iivOZfv2pBZu
         eVoE4szlrteRFr0b+Xia8PhNcIeHBqmLXivlrU9yb0DlwL2TxuhIDYvQapimBt3WDeKW
         AIAGfG9qC5YMduS224RKgUw6zLpbCFwTrco+eFNtSMdz0ILvt+fPy1pbWq3F2yb6cbq/
         qT6hoyAzXjhNkVb+dW/fjAk/KJIrOPFBEGUQu6B/5Lq7FODLP+wjfi+rFiC/M6XEQH/y
         sBlKgNgSB0LX10gNlRRw9eYBYyDZYHJTqledJEjtXu9uuwrsmFCwxRvfpk4nBvbeHwEv
         U9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FjfIezdI/6hcmgDHsmxlPTkL1N2D6W+C9ufmj8LXJA2q14DFIhqXVYJY3Xujb4ggbu9vcsDJuhigUME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBeu2ZWHIz3/l259IGWnCxC22CrJ0e1BZfcX8wJK4Cms7jHGs
	zCCTJMw7wvlcTjSPLnEiE3m16m4E8+FObX6XNs28V57oxoTn+kVvCTR32DDCTw==
X-Google-Smtp-Source: AGHT+IEFdGF7Q2YWcAplAlykHSQNMLpEEWqBpuC11ZSD7YT+1n5yivK+MLpI/ib8DE+YI2s+P2mm4g==
X-Received: by 2002:a17:90b:2285:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2db9fc1bf48mr6758422a91.3.1726183588056;
        Thu, 12 Sep 2024 16:26:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:ad3f:6937:2713:ef56? ([2600:1700:4570:89a0:ad3f:6937:2713:ef56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d157b4sm277831a91.47.2024.09.12.16.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 16:26:27 -0700 (PDT)
Message-ID: <dc323138-3bbb-4e23-91f1-d6b80cb7bb72@google.com>
Date: Thu, 12 Sep 2024 16:26:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kyletso@google.com, rdbabiera@google.com,
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
 <5iakowhmqc3hbstmwbs6ixabr27hf2dfz2m4do4qvsrtgrdn72@r7xqawwgebla>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <5iakowhmqc3hbstmwbs6ixabr27hf2dfz2m4do4qvsrtgrdn72@r7xqawwgebla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 9/12/24 3:05 AM, Dmitry Baryshkov wrote:
> On Tue, Sep 10, 2024 at 05:07:05PM GMT, Amit Sunil Dhamne wrote:
>> This commit adds a new property "pd-timers" to enable setting of
>> platform/board specific pd timer values for timers that have a range of
>> acceptable values.
>>
>> Cc: Badhri Jagan Sridharan <badhri@google.com>
>> Cc: linux-usb@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
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
>> +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
>> +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
>> +      value. The timers may need to be tuned based on the platform. This dt property allows the user
>> +      to assign specific values based on the platform. If these values are not explicitly defined,
>> +      TCPM will use a valid default value for such timers.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> Is it really necessary to use the array property? I think it's easier
> and more logical to define corresponding individual properties, one per
> the timer.

Thanks for the review. The reason I did it this way was for
convenience. If in the future someone else wants add a new timer,
it'd be convenient to just add it as a new macro definition in pd.h
rather than having to define a new property each time, especially
if folks want to add more timers (scales better).
There are 3 timers already and I am working to add a fourth in a
follow up patch if the current RFC gets accepted.

Please let me know what do you think?

Regards,

Amit

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
>> +#define PD_TIMER_SINK_WAIT_CAP		0
>> +/* tPSSourceOff (Table 6-68 Time Values, USB PD3.1 Spec) */
>> +#define PD_TIMER_PS_SOURCE_OFF		1
>> +/* tCCDebounce (Table 4-33 CC Timing, USB Type-C Cable & Connector Spec Rel2.2) */
>> +#define PD_TIMER_CC_DEBOUNCE		2
>> +
>>   #endif /* __DT_POWER_DELIVERY_H */
>> -- 
>> 2.46.0.598.g6f2099f65c-goog
>>

