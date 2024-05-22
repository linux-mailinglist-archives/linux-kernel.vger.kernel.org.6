Return-Path: <linux-kernel+bounces-186713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DC8CC7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187091C20EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFB146D5D;
	Wed, 22 May 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba5Q/g+/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A741420BC;
	Wed, 22 May 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411870; cv=none; b=NJKpHNI8MWl1bCPGzUEOyxuPvfSZappXHlaDHbxzK+f8JqjzCMbMEEotGS/w8BfUNyQRfZM+/4pBTkJbTwNUJI2VY07tf2X7V0JkRkH8g6qET1oP6ZeGtUaUzbduimagG6inWGbjLmE1QY0RMQYZS/qxgMAiv5po6rwVQmzq9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411870; c=relaxed/simple;
	bh=qHjnq+q1rDFyIJsTYH3KxBmEa98h8Xrh2Lzj6tZlWpo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+nQU8uft48bRQe2DKqWI46e23xAcyI1dcNNI0RF9k566jjQEPn7mdu0ec5YIU1IkC+L5AgSV/Op/lUlWunVrDyg40B6UYednJj4C9Egcv3ONwNAD2wRTEzs5mvkUPKUxSDt4GDSljN42WZK1YKh8JNX/tu67XUvol1GiayZrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba5Q/g+/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so1755307b3a.3;
        Wed, 22 May 2024 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716411868; x=1717016668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iT1AOadXKdkeYb8c0TgcpuQB1WGmLOhZwg6j5OThiw8=;
        b=ba5Q/g+/VGcbHQj5RHIRgCFg/V/Z+umH2dMrpBpxor2PyJplJkTcHkPMuX/DDg56kD
         92E5tRPpQif0C8PomHZDT0VZrHiJlqSEvqfH/8LQGabPYWphmMv3OUbFphbzhamf81XT
         oj59rq+qwkXmDaCc2fB398uP5107r9ds7DFOjuxmM0BkLxJSvF1+e0NVh8z7GVBK8en5
         6GgENAU76+0x2wusWSkhDDF8pe0E91GOwdz6JuO6KsY5Qh/Eo+lOBgwMI3c+7Qnhr3D8
         N48ftcOfwzsx1jXgXA00UTQ8IKFb2lYsbKCqHmNSKbMLmO/aaQoLLS1LasqmwMMmChdh
         /+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716411868; x=1717016668;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT1AOadXKdkeYb8c0TgcpuQB1WGmLOhZwg6j5OThiw8=;
        b=XWYP6iim4E6o1/tgnigu1RZWniLkG+bUGZ7lgnMfTD7WxP/MRY5Rjlvq2zLB7NGZ/7
         HVPkeLT4LjJR7cOcprUu7fy8QwPiECFqOUVoDBPcAeqLjPWTZYBohtpjjDbGzfP6cyq1
         Zq0gquqOFCOl47mDPc8CvXdgya4lAA3pOrsqBYwpCI6GRRn2fVQFhTS7b7eN6TdM4L2w
         1g88WYpNBY9gkoPyGomHOgryXGRjTE+beJUDgrviTSS8XorV9HNYMaAZMP0Zjh0M5+vL
         DoOskuRuVgK4tbaDYB64sYJR2V5eFGRMTt1vduaxsBmUZaCuBFwzHTM+lBFtvsXOTfwT
         K1ww==
X-Forwarded-Encrypted: i=1; AJvYcCU96BmA24a60u7KDBoc9qRhMRU9mpATR9ioW65GqeDIfBG0GWBlcjdcihTeQ82/39ggUsmY0TSLaB998DXtb4vINCjvToXgCLGiHd6nu8jNEp2NZ9Zb+UM/7FwTTxEXZPqG3o3htsSPgw==
X-Gm-Message-State: AOJu0Ywe9xdoZWjQcetWaSKovy/h4lvb0TU3cP4S27yRPI798r7NKdt9
	90ggCC5cfnlU/TcbLTzislWPiDzqIF2Rv/kMAZMjl6rN7pRbPhf7
X-Google-Smtp-Source: AGHT+IHyvIyJqabzGn2pk+6jufjKdtxxS7JXm8ZDJHA57VzobiooDn0JOUAk0HMf2Nxvd5Pxfsf4dg==
X-Received: by 2002:a05:6a21:3483:b0:1af:cfca:e515 with SMTP id adf61e73a8af0-1b1f87386a9mr4758616637.12.1716411868131;
        Wed, 22 May 2024 14:04:28 -0700 (PDT)
Received: from [10.5.5.43] ([103.139.191.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a663bbsm23606465b3a.17.2024.05.22.14.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 14:04:27 -0700 (PDT)
Message-ID: <dc8a05ee-ed84-4517-baad-a220d8702f07@gmail.com>
Date: Thu, 23 May 2024 02:34:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: mt6358: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240518081621.63386-1-agarwala.kartik@gmail.com>
 <c05f91f5-a878-4f36-b325-0ac8e038a7e5@linaro.org>
Content-Language: en-US, ar-LB
In-Reply-To: <c05f91f5-a878-4f36-b325-0ac8e038a7e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 12:39 PM, Krzysztof Kozlowski wrote:
> On 18/05/2024 10:16, Kartik Agarwala wrote:
>> Convert Mediatek MT6358 Audio Codec bindings from text to dtschema.
>>
>> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
>> ---
>>  .../bindings/sound/mediatek,mt6358.yaml       | 47 +++++++++++++++++++
>>  .../devicetree/bindings/sound/mt6358.txt      | 26 ----------
>>  2 files changed, 47 insertions(+), 26 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>> new file mode 100644
>> index 000000000..f57ef2aa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/mediatek,mt6358.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek MT6358 Audio Codec
>> +
>> +maintainers:
>> +  - Kartik Agarwala <agarwala.kartik@gmail.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

Noted

> 
>> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
>> +  For more detail, please visit Mediatek PMIC wrapper documentation.
>> +  Must be a child node of PMIC wrapper.
> 
> Did you update the PMIC wrapper binding with ref to this?

I am sorry but if I understand this comment, you are asking me to update this
file [1], correct?

1. https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6358-sound
>> +      - mediatek,mt6366-sound
> 
> You did not test the DTS.
> 
> I think I raised the issue already: please make necessary fixes to the
> binding (with explanation) or to the DTS, when converting the binding.
>

Apologies again. Just to be sure, am I correct to assume that you want 
me to fix the dts file [1] as it has both these compatibles 
mentioned instead of only one and I should fix that by dropping one of 
the two compatibles?

[1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi#L1246

>> +
>> +  Avdd-supply:
>> +    description: power source of AVDD
>> +
>> +  mediatek,dmic-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Indicates how many data pins are used to transmit two channels of PDM
>> +      signal. 0 means two wires, 1 means one wire. Default value is 0.
>> +    enum:
>> +      - 0 # one wire
>> +      - 1 # two wires
>> +
>> +required:
>> +  - compatible
>> +  - Avdd-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    mt6358_snd {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Definitely no underscores. Probably this is "codec" or "audio-codec".

Noted

> 
> Best regards,
> Krzysztof
> 

Thanks for the review!

Regards,
Kartik Agarwala

