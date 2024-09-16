Return-Path: <linux-kernel+bounces-330278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A991979BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE311F228A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BAF1369BC;
	Mon, 16 Sep 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtdlcAGL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC344F5FB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471356; cv=none; b=apPqvzcV7lmkluQG2DyYLgblll52suaXKhJiF4+P6u3nAY85h68TBYjduf6Mi7LncjqGCjZhmXdcL6kw9Gg7TzKargTMJeungqUxe00LE24dJg3G6MJWfyEWkEy21oMk0+WhfxF6dbmBqqYM0lNi6yXJH3n4CTvpdZC5+6fJ7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471356; c=relaxed/simple;
	bh=493j1d3LXGwgFLtSTfhEAYwnQGK3YmDQKE1/T6CCMuA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oaUgIUI3ab+dEqGkm5NhswECenNfKM1ufgyPtBTJ4/cJdD2zZez5rq4eaz3Rxnt3Hikdh34dhIwOzU8QHnEID80vHZaWadwEvhQhRuYlK7SdC4QFtmxtxhHawo2Akm7ff5PrjbodFqE4dUbv+wtFl5ue8QZiYzsRo/90DIZtaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtdlcAGL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374ca65cafdso1899788f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726471353; x=1727076153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLjW0/5ZDl0ouUZFFt8vfRFxA6ScieB6Wo2BPonGqig=;
        b=rtdlcAGLmAqJ6/F6PkANxa6s3Zlivo7ERz9GxyXr/36lf8rggcqIp9dzO1gSPkbvwB
         h1PWSU5WiVnQogg+4Zvrj4l0cI+8enBoZ9h8qFvBuXPnWGex6uThDRSlFb76xmzMpG3D
         xrblZYb858Y7kLT80xJSTv9h+ixhPSbgi2hsk4b3kWov6M38DUh2orox+pCo1bc/sB9r
         Jt+8SBifHqqI3CHUMZ/XPzERZc3FzaXvEmR4ogFos0LyJ6wDqqL9gccEaHF5xUmISKA5
         893Y34Wb1DUqX5qrVjHuYtxqOkKGGMxrNd/t1CC8rT7eo/hild3uao4fcst772+vIF3c
         47ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726471353; x=1727076153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLjW0/5ZDl0ouUZFFt8vfRFxA6ScieB6Wo2BPonGqig=;
        b=kT8olxsQ3XN8ke6HxWHPGO4PpnKuB0DcddWlaF3+R8B4Vb5F5vSOdQyJyhoSrJTs2n
         WrIY5hLHJA3U6Sg6nQ4NVCKylm00mDT+MM21Q2F4mBmHiAQ79JZL83EQC9QYpOdj0W+r
         k7vOAeXb+1W2g5//mnPbQhg1x2sRT94iX8WSti++8DrKKMmkDH8Fafpr47oOPql/ZI3P
         AQ/hv/LmVcmTDIigFOrcvx2/BONIrq1imOBOBGphkOwy2UmGMsJo8Q0iy3HpqSYQIsfc
         W3EbSxk83h7+pV0NzpNeemUaZIw8TgZ7gXRgdKLm2lfGQlU4Gajzh4KwXAuQbWKrZq3A
         e2zw==
X-Forwarded-Encrypted: i=1; AJvYcCUMWvO5XxTjdvcxfobcqHbVQRILQYCj3X5KH8jJANHjNQGgvf8AJLaWZQ4L4nV356fP16kCBX4CusYpyIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC7ddx+wImCaSE+faNoCAM1rIAk8pgiSHXcdOKSI2qAPK0MX/
	PtRBjUKUMMu78lWR+U01iPwBHSP4Lwn+mYrHGef2MjrKISx5SSGdgk+BiNqNanY=
X-Google-Smtp-Source: AGHT+IF8mNG9Q2MKAbQKPDAtK9i1wqbgQMI068oTtpXfSdCmEYXClrggOaykUylFIescX0LCueSBjg==
X-Received: by 2002:a5d:5f49:0:b0:378:8205:58ac with SMTP id ffacd0b85a97d-378d61f1608mr7614486f8f.34.1726471352338;
        Mon, 16 Sep 2024 00:22:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:46e0:9b1e:8680:c41c? ([2a01:e0a:982:cbb0:46e0:9b1e:8680:c41c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm6307487f8f.30.2024.09.16.00.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:22:31 -0700 (PDT)
Message-ID: <7df4b349-7126-434a-8ae7-ea2db535e8c2@linaro.org>
Date: Mon, 16 Sep 2024 09:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/7] ARM: dts: amlogic: meson6: delete undocumented nodes
To: Christian Hewitt <christianshewitt@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, devicetree
 <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-4-feaabb45916b@linaro.org>
 <CAFBinCD+txhz0x20LXhydZpLk=u4d9FT4=1sOX1bKuDeQqsMjQ@mail.gmail.com>
 <DAFA9AA0-F51E-438E-A486-389164C043CE@gmail.com>
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
In-Reply-To: <DAFA9AA0-F51E-438E-A486-389164C043CE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/09/2024 07:57, Christian Hewitt wrote:
>> On 15 Sep 2024, at 11:12 PM, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Neil,
>>
>> On Wed, Sep 11, 2024 at 12:19 PM Neil Armstrong
>> <neil.armstrong@linaro.org> wrote:
>>>
>>> Delete nodes in meson6.dtsi that are clearly undocumented & unused for meson6,
>>> fixing the following check errors:
>>> audio-controller@5400: compatible:0: 'amlogic,aiu' is not one of ['amlogic,aiu-gxbb', 'amlogic,aiu-gxl', 'amlogic,aiu-meson8', 'amlogic,aiu-meson8b']
>>>         from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
>>> audio-controller@5400: compatible: ['amlogic,aiu'] is too short
>>>         from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
>>> /soc/bus@c1100000/pwm@8550: failed to match any schema with compatible: ['amlogic,meson-pwm']
>>> /soc/bus@c1100000/pwm@8650: failed to match any schema with compatible: ['amlogic,meson-pwm']
>>> phy@8800: compatible: 'oneOf' conditional failed, one must be fixed:
>>>         ['amlogic,meson-mx-usb2-phy'] is too short
>>>         'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
>>>         'amlogic,meson-gxbb-usb2-phy' was expected
>>>         from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
>>> phy@8820: compatible: 'oneOf' conditional failed, one must be fixed:
>>>         ['amlogic,meson-mx-usb2-phy'] is too short
>>>         'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
>>>         'amlogic,meson-gxbb-usb2-phy' was expected
>>>         from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
>>> /soc/bus@c1100000/mmc@8c20: failed to match any schema with compatible: ['amlogic,meson-mx-sdio']
>>> mmc@8e00: compatible:0: 'amlogic,meson-mx-sdhc' is not one of ['amlogic,meson8-sdhc', 'amlogic,meson8b-sdhc', 'amlogic,meson8m2-sdhc']
>>>         from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
>>> mmc@8e00: compatible: ['amlogic,meson-mx-sdhc'] is too short
>>>         from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
>>> remoteproc@1c: compatible:0: 'amlogic,meson-mx-ao-arc' is not one of ['amlogic,meson8-ao-arc', 'amlogic,meson8b-ao-arc']
>>>         from schema $id: http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
>>> remoteproc@1c: compatible: ['amlogic,meson-mx-ao-arc'] is too short
>>>         from schema $id: http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Generally I'm fine with this. I'm wondering if we should go one step
>> further by decommissioning Meson6 support?
>> To be specific here, I'm thinking of removing MACH_MESON6 from
>> arch/arm/mach-meson/Kconfig and deleting meson6{.dtsi,-atv1200.dts}
>>
>> I don't have any boards with Meson6 SoC, there's no upstream GPIO,
>> pinctrl, clock, MMC, <you name it> driver for that SoC either.
>> So all we have upstream is the ability to boot to initramfs and use
>> serial console(s).
>> If someone is interested in Meson6 support they should bring it back
>> along with a few more patches for upstream support of further
>> peripherals.
> 
> I think that’s a sensible move. LibreELEC was one of the few distros
> that supported Meson6 hardware in the past (via the vendor kernel)
> but we ended support in 2018. Meson6 devices are mostly/all? cheap
> Android boxes dating from 2011-2013 and these have either been been
> discarded by users through upgrades or the boxes died long ago. There
> is still community interest in supporting Meson8 boards (the 8x core
> devices are used for retro-gaming) but not the earlier Meson6 ones.

Yeah let's remove meson6 dtsi for v6.13, I'll respin this serie but with
the meson6 removal and some more dts fixes.

Neil

> 
> Christian


