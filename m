Return-Path: <linux-kernel+bounces-213969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02241907D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C10AB22825
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95E139587;
	Thu, 13 Jun 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oodZH8Ea"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA9132126
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309385; cv=none; b=uuEWXzqWF+Qm7V59zONWJZRYNT3UVv+USftvdahEPJutS054auRMp3bHcb/BmZsHe4ObEIOtAHQlprEByiACp4Kb2DeRE9dW0M/T3uunypE6zBboRfYHoEd25rco1zF/KhWBB+3PYOeBI1OocfC+1SmshJQYJ/m+T2XuJ5RsVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309385; c=relaxed/simple;
	bh=CQCINiE2/SPyBRH9toUFSdV5cDH7STqVNMm0tdglsaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kswjnmcDT6fl1OvhUjZNKn2npb/xAwzYgp3vYJx4HEukF5pC0Uootfkzf9LQSzll1/hquxpU4Ur6z/b6VcnwnABRtAjgnhOyc0GL9goMQGYe3NwF4GY+hhdaL3zgT71E+ZL6ZgIx/w6I3101w8djoWsognfi80xX71kH0jeSNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oodZH8Ea; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6fa0d077694so695658a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718309382; x=1718914182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEE6fzHqJzPFB2U2GIl5Oq8QAfX+VHQ2WudkcEUyjg8=;
        b=oodZH8EaznhgJU+taFtJUpWVTOWf62xn77gxqT1p1i2HEY6AobclSh2fdSl9UPSuDt
         B6FY5lmp8eSjLet6Y5vHpdBue1BIkErncuHQfbKB2TCaIhMiceMidxRICEL/Gime5OxY
         wWTj6nLPf4WX0vgim7AvlT5TMDpZ2shTw8OtIFrDOLAVNfh/N5Hb3sY2GsQmBef3YYkE
         6N4ZJVjeNjIaGSbEt8W+8TT1/hs0LpLZDnps7iqg8lWiulYX372ggp+vB2AJb70gj/qU
         WvaWyucy35AaFo8gTY0ec/eHZWM/g57ncwBDN2rZ1I1Bs390ObgbFopDAZeyIRdHns0M
         /vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309382; x=1718914182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEE6fzHqJzPFB2U2GIl5Oq8QAfX+VHQ2WudkcEUyjg8=;
        b=Ld1vI5HEzWS2n0iq3zxOuuoom08zZ01tkaOhzVV6CzSdV5uo5lTseaHAWy6OX/VraU
         gCveOiPqiEBplYMaWL6bZ7g0A8EBEw3lT4u/f027yKIJptwrJsHFgJAcC9WIQamhZrJB
         SXe2bJNE+oAI7w0moIOiMrYD+6+irW+wm7L098iIrAjU2eY4HGJkRRmcOkEugA9e81H0
         9QBSyrkAAvu5JvqeOb8J94XFKU+JbJ37HvClTTkvtgFiMYlAAn0YawBI6mmAgoltgO6A
         JDXz3CSLLVgo2kd/1imKk5A8gL3AsKTZcWtET/YiDST1Td81DdsnlrTDAjpeikUiIhWO
         3v4w==
X-Forwarded-Encrypted: i=1; AJvYcCWtdFocPEKHAgw4XmcBgzdUe5tyfNTa9M3gC8LMVBM90XVcsq8uHziaZpnX5XasnUBW2/EcNsk+yevuCUJqcD0g/tjSKEB8JN41vZl+
X-Gm-Message-State: AOJu0Yx5tYFcl0q5t9JmpW6t40F2zj+fffaCeOZaSTDp3744HU36ceq/
	ckI0W3+bGi1Ev5hJl/UFoya/dlYMZfNse/hy4+kj4W7sysilsfLqyDlT3IP4j/s=
X-Google-Smtp-Source: AGHT+IFGkggbiqnsGkdan1l/N3qvoef5ze4sKeyGgn0KjH8muXLq4zXGJLt9W5TX4Hq2vgylEtE2IQ==
X-Received: by 2002:a05:6808:220b:b0:3d2:1f3f:a3fd with SMTP id 5614622812f47-3d24e983ebbmr836877b6e.40.1718309382325;
        Thu, 13 Jun 2024 13:09:42 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e31d8sm306427b6e.53.2024.06.13.13.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 13:09:41 -0700 (PDT)
Message-ID: <d802086d-5f88-49c3-996c-ada251043187@baylibre.com>
Date: Thu, 13 Jun 2024 15:09:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: Rob Herring <robh@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
 <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
 <94448c2c-e7b2-4191-858c-529b254994f1@kernel.org>
 <f765ef30-a777-4dfc-8f93-0f15b46f91ae@baylibre.com>
 <e09fecf4-bde2-4feb-8312-22c530c6a960@kernel.org>
 <b6b52b1e-847b-44ca-87f9-095a78164771@baylibre.com>
 <5f0776ba5163578453e26352763ff1b4687bcf87.camel@gmail.com>
 <20240613194324.GA2352022-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240613194324.GA2352022-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/13/24 2:43 PM, Rob Herring wrote:
> On Thu, Jun 13, 2024 at 05:11:48PM +0200, Nuno Sá wrote:
>> On Thu, 2024-06-13 at 09:39 -0500, David Lechner wrote:
>>> On 6/13/24 9:18 AM, Krzysztof Kozlowski wrote:
>>>> On 13/06/2024 15:57, David Lechner wrote:
>>>>>
>>>>>>
>>>>>>> +          - const: adi,ad4695
>>>>>>> +      - items:
>>>>>>> +          - const: adi,ad4697-wlcsp
>>>>>>> +          - const: adi,ad4697
>>>>>>> +      # same chips with higher max sample rate
>>>>>
>>>>> I suppose one could make the argument that the programming model is
>>>>> the same on these too, but the maximum sampling frequency does seem
>>>>> like an important bit of information so that you don't try to set
>>>>> the conversion trigger rate too high.
>>>>>
>>>>
>>>> which property is that? I don't see differences in the driver, so I
>>>> don't get how these wlcsp compatibles allow you to control value of
>>>> conversion trigger.
>>>
>>> This comment is unrelated to the package type (WLCSP or LFCSP).
>>>
>>> What I mean is that e.g. AD4695 and AD4696 are virtually identical
>>> other than the maximum allowable sample rate (500 kSPS or 1 MSPS).
>>>
>>> So my thinking was that it would make sense to have:
>>>
>>> 	compatible = "ad4695";
>>>
>>> for the lower sample rate chip and
>>>
>>> 	compatible = "ad4696", "ad4695";
>>>
>>> for the higher sample rate chip since ad4696 can do everything
>>> that ad4695 does plus a bit more.
>>>
>>
>> IMO, that would make sense yes. If the higher sample rate chip fallsback, it will
>> still work but not at full speed. The other way around is the one that we can't allow
>> naturally.
>>
>> But possibly dumb question now... since both devices will be supported at the same
>> time, do we actually care about having the fallback compatible? My understanding of
>> the fallback story is that we may load a DTS in an older kernel where chip A is
>> supported but chip B is not and it is ok for chip B to fallback to chip A. Since
>> these devices will be supported at the same time, do we need to care? Unless out of
>> tree stuff enters the equation?
> 
> Yeah, it doesn't really matter much in that case.
> 
>> Or is there another usecase that I'm not aware about (or maybe it just makes sense to
>> document properly...)?
> 
> Somewhat I guess. Perhaps if there's a 3rd chip with higher rate, then 
> it will be more obvious what to do and we don't have to have this 
> discussion again for it. :)
> 
> Rob

It sounds like maybe the best thing to do here then is just keep it simple?

Like this:

  compatible:
    enum:
      - adi,ad4695
      - adi,ad4696
      - adi,ad4697
      - adi,ad4698


