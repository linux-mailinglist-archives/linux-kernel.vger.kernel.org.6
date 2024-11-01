Return-Path: <linux-kernel+bounces-391759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092699B8B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862411F22F90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384A14EC4B;
	Fri,  1 Nov 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqXvCOO9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F214F10F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443811; cv=none; b=qUSsbwUtX/tdN+mTmOa+Z2FZrEcvF6Jc4qs/z3cAEDR3cnJjdvwNBVh1n/pPv3OPgaN3MXY+LyztZB7lJ+IOYQddnJpyoVY4iwWd7MR1V5RKYOyk3X0Wa/VWbIcXyqT3ujkEECNBCgKdzJj1TInsZ+tUkHbE1DQk/EY3ikGoou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443811; c=relaxed/simple;
	bh=ODJ1U56tKN/dg4KO8D11FzeojPk4P9LEzQa3wCw6N0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sstxyz30PbExfyFXsnEDk4FRCTQdLVKUBt4INgn/n99omn7VOZi1nTOeU03/uf6+4S8rvOZWXftP8Rmg3wOzRc6XATdSlQuguNwhDr+1MY20yn3mU9UbZPbCeCo1OYjlA9L5BF9ad3mnEiDqEvce2w/jvNiMTEMZFxTZDhwu9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqXvCOO9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a039511a7so25185666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730443807; x=1731048607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BoHoD7USV7MEAnZlU2UJzxgFTmdUTbHvC51Pi8erYfk=;
        b=vqXvCOO9PmuaTgLkDPEkIzZuuHnYKs2Y6KSafQ9z2I4LXgSRA4yaiomz2zWfSCrsTr
         hO0lADObW1nlJdBRidy9tVJ5TFaWo6Az73X8HiuTakIB2rZI8ntnTHkj50zWd8yRHLD4
         oEazAqaxcAYjwhHUm2pUJnn0l6roI2Quv60lvy+kmgKNqWZfbsY/EnNLt4kQBbau47wk
         vuJlxUJqnb60FCZW/oPW+AXI+YCDOGNCgT1nLm7sT6rwY0MD2OK2O/tL6lhkjaiEswD8
         g4jgBeJ1bOcqekyDZyXAsneJXQli68KWOFwEcU73y1qnd8ua6++Of/EnKRTCfzgK64ju
         drxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443807; x=1731048607;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoHoD7USV7MEAnZlU2UJzxgFTmdUTbHvC51Pi8erYfk=;
        b=gB90aMx9PVD36pBtwvwtn+0JO57T0e5ZnsoCfSZ4gOP8nXmgh0BFX6cU1W0D8REtck
         3xUHHSidcwbFtNhQWznV9CPf9UC+m0S/lQYkOHlMEt8sh6B8cTPsLw9XZQi7AvFU6l52
         EBtCY3BmqTHxzdX2N5tB7EJK0PdH5xpmPpJsPpFKiS5fNwcZZnTOwON/Wwp4Sye2n0DQ
         c7SKWcX0/H4UUuYoLA+/WxRpiphmS4fQrQCnZ7JoWMmEZT8LY3DEXoMH4sdXzH5vJVI5
         Qu+xDt2u7DZVPTGxGNU/WjoZcWwaz0F+vz+f95tzbPEJVN4GOdyTxdTIIcB42m2u2BI9
         9/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVxvJRNXgeHFnl8GiGuGwHOZpthdmuC3bytjQ3hz+rR+b0JVuBKz9EjDt1WH9i5cNG8l8zN1APLwS9xuts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitPNCqTfKcVYwH2Y6Qh2WDh2ad6AUd2WoMwaelN7GmUKmwcWY
	rRv5rMrxSfT/kidth+/Al9psTCKES2QvuCNcoQHcqKe5DDuZTDiznwapvFnoUeY=
X-Google-Smtp-Source: AGHT+IEAYHZTjJ6/KrgtwRF4vrEkWZBl/PoMNQCnKqHSKQ5lDc5aBqd9u5WLmF5kBRtx87lGmWqLNA==
X-Received: by 2002:a05:6402:5256:b0:5cb:b616:5ed5 with SMTP id 4fb4d7f45d1cf-5cbbf936330mr7700329a12.5.1730443806785;
        Thu, 31 Oct 2024 23:50:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74cba4sm1252114a12.6.2024.10.31.23.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 23:50:05 -0700 (PDT)
Message-ID: <aa6b6171-24ad-4dea-b0cc-28d7111416b7@linaro.org>
Date: Fri, 1 Nov 2024 07:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: rng: add binding for BCM74110 RNG
To: Markus Mayer <mmayer@broadcom.com>
Cc: Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20241030213400.802264-1-mmayer@broadcom.com>
 <20241030213400.802264-2-mmayer@broadcom.com>
 <db7b7745-404d-45f7-a429-c1c747de8e6b@linaro.org>
 <CAGt4E5ud=0rwSKBTOAsx0RMB3Pkjo+HHxZ_JLPBFbOSZUTCRVg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGt4E5ud=0rwSKBTOAsx0RMB3Pkjo+HHxZ_JLPBFbOSZUTCRVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 19:55, Markus Mayer wrote:
> On Thu, 31 Oct 2024 at 00:29, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/10/2024 22:33, Markus Mayer wrote:
>>> Add a binding for the random number generator used on the BCM74110.
>>>
>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>> ---
>>>  .../bindings/rng/brcm,bcm74110.yaml           | 35 +++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
>>> new file mode 100644
>>> index 000000000000..acd0856cee72
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
>>
>> Filename as compatible.
> 
> I am not sure what you mean by this. That the filename should match
> the compatible string? I did change the filename to

Yes.

Best regards,
Krzysztof


