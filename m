Return-Path: <linux-kernel+bounces-330886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FF97A5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CD1C26B49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0101598EE;
	Mon, 16 Sep 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lp7vlN7K"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B8155A3C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502750; cv=none; b=KqsBbcALPrP3YkSLAhnym/u8mEBMDfpxPiQHfqzQo/cY+RX7I0yMpd+9pxLqpT52cGTaa789gpDCHdMIVNlIxr2GliyznMv7+x0E7Xc07Tqy2xQ4cNyATbvM/HIOfWtY1ltWLUy7NfP/S6Tvnuqd4QIcsMnWveUj5khhkg6FJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502750; c=relaxed/simple;
	bh=+hulRIncmZYwX6AbjLI7q+5ZTyeCTbMLFoW0OYJzYbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQNTby98Yy91CMYUNwv1oW7IlrDjxqb/AMVuZ4ar9jYUvpD3Euf0MxSCQqU8cy+Ofi6PQI1cBs5WO02yHXHerkg6kdxlGLmtWDgqV8JfsYeX3OTmNfqNlhoYzNmrQ1UDoL1GwgcloLKIR96MbnsFNJx+CqO3RN47UPa1rPwpYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lp7vlN7K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cae563348so7882205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726502746; x=1727107546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RFt9a3w/ePwIdDqIIrubu40TRnzaXtPMT/2pFLElACw=;
        b=lp7vlN7KKN3So2FVGTWnPWHxxa6JfYNY1+GrtXttcb4yOy+KQckwa5katfYIRM9osr
         WvjehQDZP/BDkwcXgZ8A93Otr5fGWUcOJrFu6ojt6JBPcoKAHPd7inuoloJ4lAFPkBTe
         NzNFA4Dya9nIQ5K6eh20flhKzChYASSHMD8Tjoq+nhlC89LBjp2STbOO5D+wOPXr5MYQ
         rRNEddv0LkYBX8+ff0sCIW/+K0n7AXt7XmCzsgPmR4MU411Aaa0bB889BWegmw53GrXj
         XhWOTOgXN9cz6Y1V8Oya0AWg8xeeAZhoRs9uQeV5v8dV7BkXWFotV4FkX7Pnny/gdi9G
         Rfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502746; x=1727107546;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFt9a3w/ePwIdDqIIrubu40TRnzaXtPMT/2pFLElACw=;
        b=HXL91QhSD1eX6pv4db1XVb6Zj7n4y6X62ERDIW3GJPlvLXMZP0wOrt20Ee3EEE21Gh
         krS2XL/C/aUtnZ0Fb6juYUj8Kk8HfUda2HbhiMbQlKKN5c+2Ew6J1NzVBn3Yw/aJI0t9
         qfYc54OivDw2xx90D03c3kX0I2kfHhd5n4EILNahL69W93EMQl40XAy7YpEasxTScMUL
         rZ/p7idV2NbofBDWDvrXIe5KYCODGsqpQuIsVawP/6P4zHkNoA1/XHcbr93AshJE2Y5P
         MBWHjFBiqZ7Z+nBdcsg3nZTMiEpt6zHoVUyYLSz+o8gLOEv7aAPT1jTPQrQsn6Ii5VcP
         H2HA==
X-Forwarded-Encrypted: i=1; AJvYcCVEa0FXQFE1GyEwryOK5F90MooxLgY1kiZCpF95Fd5asICuy80UKj7WQmHWf20UZrj96Imqf1bNu6EoHwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNE2q8Lj/Do9w6OzrQbpHl3YH6Ol0X5SggXWhYdLezGwauQfx
	S/8xby62U1/5Q5Dnd8rbdWsrK3uvauqPuyhCGIV3u4LtJot9EagbkRbcxghSoXU=
X-Google-Smtp-Source: AGHT+IFMbsPuBPKcyYlNFQnL82lKpSnFEz+gTmak+bL0oHIs7OuvsUlzJL5rM6bwOAsGgusTrHcxpA==
X-Received: by 2002:a05:600c:600a:b0:42c:aeee:da87 with SMTP id 5b1f17b1804b1-42cdb66c943mr52095185e9.9.1726502745851;
        Mon, 16 Sep 2024 09:05:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da2427227sm80656885e9.44.2024.09.16.09.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:05:45 -0700 (PDT)
Message-ID: <c858c534-98d6-4603-819e-9134dbed94cf@linaro.org>
Date: Mon, 16 Sep 2024 18:05:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
To: Amit Sunil Dhamne <amitsd@google.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kyletso@google.com, rdbabiera@google.com,
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
 <5iakowhmqc3hbstmwbs6ixabr27hf2dfz2m4do4qvsrtgrdn72@r7xqawwgebla>
 <dc323138-3bbb-4e23-91f1-d6b80cb7bb72@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <dc323138-3bbb-4e23-91f1-d6b80cb7bb72@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2024 01:26, Amit Sunil Dhamne wrote:
> Hi Dmitry,
> 
> On 9/12/24 3:05 AM, Dmitry Baryshkov wrote:
>> On Tue, Sep 10, 2024 at 05:07:05PM GMT, Amit Sunil Dhamne wrote:
>>> This commit adds a new property "pd-timers" to enable setting of
>>> platform/board specific pd timer values for timers that have a range of
>>> acceptable values.
>>>
>>> Cc: Badhri Jagan Sridharan <badhri@google.com>
>>> Cc: linux-usb@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>> ---
>>>   .../bindings/connector/usb-connector.yaml     | 23 +++++++++++++++++++
>>>   include/dt-bindings/usb/pd.h                  |  8 +++++++
>>>   2 files changed, 31 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> index fb216ce68bb3..9be4ed12f13c 100644
>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> @@ -253,6 +253,16 @@ properties:
>>>   
>>>       additionalProperties: false
>>>   
>>> +  pd-timers:
>>> +    description: An array of u32 integers, where an even index (i) is the timer (referenced in
>>> +      dt-bindings/usb/pd.h) and the odd index (i+1) is the timer value in ms (refer
>>> +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
>>> +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
>>> +      value. The timers may need to be tuned based on the platform. This dt property allows the user
>>> +      to assign specific values based on the platform. If these values are not explicitly defined,
>>> +      TCPM will use a valid default value for such timers.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> Is it really necessary to use the array property? I think it's easier
>> and more logical to define corresponding individual properties, one per
>> the timer.
> 
> Thanks for the review. The reason I did it this way was for
> convenience. If in the future someone else wants add a new timer,
> it'd be convenient to just add it as a new macro definition in pd.h
> rather than having to define a new property each time, especially
> if folks want to add more timers (scales better).
> There are 3 timers already and I am working to add a fourth in a
> follow up patch if the current RFC gets accepted.
> 
> Please let me know what do you think?

Binding is supposed to be complete. You already know this is not complete...

Best regards,
Krzysztof


