Return-Path: <linux-kernel+bounces-203770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD78FE048
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B08B2456C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9213C807;
	Thu,  6 Jun 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTMZTjTG"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAE13C695
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660646; cv=none; b=G2G5Y/gaypQzjaCycO9rQ47j7aDzriVFdkbla/B5Bx6qE6SiJc310ChsaJhyvE+Kx2U8fK5vxNhYMe5k0gNFOCcuvlQAdeNss/Mhu6yFbqKzyklfR36NPkF+PGXi4VaicbTe0SCM92+4ZkWU7EeUWG2uHUkL6FWlIRiExCICvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660646; c=relaxed/simple;
	bh=n0zFL/hKs4u8O5/+08+Z+hRtcKMUCKI8n1GYa4WzNIY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nMqDE0rOdQqKh5/nhBCEyJf8hqAGVpHYYVJLuhJKOXAce1KeKBLsS9VQ+BObWmTuwjTVhjQKOr+KQoiO70CINDbBcJ6tYU5y3EWcBsMCtAg9528Knf9Q5Wegq/aPJNIPi7S+KnuHjgL5/wIFqkF3IbcMThyyOFOR+YJGlbeK+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTMZTjTG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso8558171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717660643; x=1718265443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+7voCuL0AH5jCZ1l630xQ06ZEcQjIwkbAF5IbOgHUE=;
        b=JTMZTjTG+Ea+fkXuhP63ZfUke1weoYEHoBFDfOHW54xVuqHcYBdgiNRU01VBvpjLbB
         GLCfgzeWwfyH2OFZ4RiyLdsroqS8OSgmy9uarYwpg5T/keul6PWW9XS0jPlEzOi1+mik
         DBhAQvlK3OuD/uePWFipOjCUbgoD8bSMxsdPxpZ9d6r8iedMJVOGPGvRNtAizGIiQVKP
         phHUtCWy60YyNp4PxxZfhV+SGeOrmk9z0dQlGZObUJWJTo6mIGaX54BYzo3hKiyfGeOS
         p7o9F/lGP5uiXujJrJjJBdGeppY9KgqHDGCYTHA3dJ884OSZGXEv4kLS5Oa6KcMA3wBB
         dD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660643; x=1718265443;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+7voCuL0AH5jCZ1l630xQ06ZEcQjIwkbAF5IbOgHUE=;
        b=NKJ80G19lfPbjHdV8/6SEx72zGWUwF6FaqVDArHX1VvskePppVrcj+uLKIOSYRpdJ8
         TWgvC0tMzCB+ejqaSZ2tkIs0VpqMjcC2uFNKu7SkhdBlFna6wRj3wNfgYv0Gx79wekB8
         wI0WVDAniAAbXtyrzzuhfXmyr+b7qqh9h81kL7UoRYaW6wCjUcv2NH8FifeNa6o5BWPV
         XsOCXUCrdExYlcjwvhuuoq9k2uijhVAA3Grh+hSOpHXu30fq91oZgtj2ZjxKz3Old29c
         sBfrcqmVB1eWj/pTlONFLtVUMn67zN1KbjobeCkp72TA0uXtTvgoXnWyRTDMrKFnflYF
         lLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfpHhlGE0LwV3cRNeU/QEcET/blhwF16Ze1LSGZbEj0x5OrYbMRRFP8Zwy6W2uhj5JVpe9g2sF2Q3h2ZXA6ry5DtIsRd06HaYGLlRA
X-Gm-Message-State: AOJu0Ywac4xE+42390MO/2n68kIa7QLFeD2W3e7dL9Dur7ZaZbiZFgvy
	2daoE+31l12YZmKk9vdFx848o48knO73auN+4N+hZDkI45LGsw01D8pi0dDTKOo=
X-Google-Smtp-Source: AGHT+IHQTlXCaes2WPs1tS4SO/ZeAXtqzWbLEzAFaTEeJVA/bQtoNUFUtqIAg2EYkzJMWCFSPexC9Q==
X-Received: by 2002:a2e:a378:0:b0:2e9:845a:8f1c with SMTP id 38308e7fff4ca-2eac7a92009mr30708851fa.51.1717660642753;
        Thu, 06 Jun 2024 00:57:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2? ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc6d75sm839939f8f.110.2024.06.06.00.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:57:22 -0700 (PDT)
Message-ID: <b41a781f-33bb-434c-adcf-97f494c689e5@linaro.org>
Date: Thu, 6 Jun 2024 09:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ASoC: dt-bindings: linux,spdif-dir: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>,
 Rob Herring <robh@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240605112301.8171-1-animeshagarwal28@gmail.com>
 <20240606005332.GA3526959-robh@kernel.org>
 <CAE3Oz82TsuDq5wAW4TSNeUuR0DTixAQPtJnCc3-5J7MnBYtuRw@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAE3Oz82TsuDq5wAW4TSNeUuR0DTixAQPtJnCc3-5J7MnBYtuRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 04:19, Animesh Agarwal wrote:
> On Thu, Jun 6, 2024 at 6:23 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Jun 05, 2024 at 04:52:55PM +0530, Animesh Agarwal wrote:
>>> Convert the dummy SPDIF receiver bindings to DT schema. Make bindings
>>> complete by adding property "#sound-dai-cells"
>>
>> 2 conversions of the same thing in one day:
>>
>> https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org/
>>
>> As I said there, I would just add the compatible to
>> linux,spdif-dit.yaml. But this is fine too.
>>
>>>
>>> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>>> ---
>>>   .../bindings/sound/linux,spdif-dir.yaml       | 34 +++++++++++++++++++
>>>   .../bindings/sound/spdif-receiver.txt         | 10 ------
>>>   2 files changed, 34 insertions(+), 10 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
>>> new file mode 100644
>>> index 000000000000..61767873200f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
>>> @@ -0,0 +1,34 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/linux,spdif-dir.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Dummy SPDIF receiver
>>> +
>>> +maintainers:
>>> +  - Liam Girdwood <lgirdwood@gmail.com>
>>> +  - Mark Brown <broonie@kernel.org>
>>> +
>>> +allOf:
>>> +  - $ref: dai-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: linux,spdif-dir
>>> +
>>> +  "#sound-dai-cells":
>>> +    const: 0
>>
>> It wasn't in the txt binding, but users also use 'sound-name-prefix'
>> property, so that should be added here.
> linux,spdif-dir.yaml
> 
> If this is the case, I'll add the linux,spdif-dir compatible in
> linux,spdif-dit.yaml instead of creating a new file in v2 of this
> patch.

OK but perhaps rename into dummy-spdif.yaml, no ?


Thanks,
Neil

> 
> Regards,
> Animesh Agarwal


