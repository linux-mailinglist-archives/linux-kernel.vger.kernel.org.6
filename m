Return-Path: <linux-kernel+bounces-354671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA99940C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E320E1F21B09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A2B178372;
	Tue,  8 Oct 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpzl1cI6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BD7603F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372730; cv=none; b=tA4pDl1prqgS0m4SvkmCKGofCdvLcrPJqzd8uBnNN+ExQbMEJjvyDgZ2ZFPSEUjluth5yb0uKP7+pGpWwp7S1fsMZ006adbs9jo01NLd4fAJ7cbPs/gPWdUgXVRnsvAyff6nAqxKG80P5rbCS0XSZ0JPYRzjqFPn/PtOJxiUtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372730; c=relaxed/simple;
	bh=taT2GnH8mvuDeg7IRInmxni6+Y04ymstiVvMzK9X3vw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oCfYCxNNUuQpJ/KJG8dR6xDqpOmdyBk8MeaMJNl58C6AFUYQ99z1wudgoFsu9GaKz1EWl1VGpCbktdgPF8dpavP9Hf1VhcbVWTfeqkAMaWF+NQ/9IicNyC59IhGBOhCGkWXy4jwlTWZmHZZDg1JHYdd9m1yeQqTg+LtvCc0KGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpzl1cI6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cce5b140bso3640258f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372726; x=1728977526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ3e9GN5oT4dEQ5C0dmBdYvJDkmnHPy8M4gnBpGOCuk=;
        b=xpzl1cI6GRSDqXKB1QsonGZGElqv6x0ENQjxlp9xGRKoMaoUJnOWAaVm1lNhMX1rh4
         DwG/aVENxSY+eXFg7/VrrojkUP4j2NszUEBxcjRvaIO9bN/ZDyS6FXHPslYqOC5bxGJ1
         HYkcO9HVmp8D4Wj2UytYAK5EzAOWHKosrSV33UDDAwdZWRMsT/yb/poycLeYekbsFmRe
         9pfshomRVtQU2hymOtw04JNBBjkoN+EAmJuJTOUU344WyNFIHBDNC7ZpIIXo7mrW07wZ
         Ml42sJsAl1vKyWfLkE6niSzxtBp3qXfhMTXAj6BgFou+cqoir07vKER7sti5volXsPOO
         5G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372726; x=1728977526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQ3e9GN5oT4dEQ5C0dmBdYvJDkmnHPy8M4gnBpGOCuk=;
        b=ITthZngsNMIAypq4wq6lonGz/FMht/1cQZyjdA6Ioydhx36KJIqgcNMDm9AUuBtgPv
         w3XIYZ3JWZmmQZZwxk1Pqqy9d6FzFR0zckCiSpAC45yfohHafdfXGkWOPNSHtnx3rBPe
         LienEUo1Wn8AtTXlq9GDho0J/qDYL0l4ccUT1LjSU6CRonrR4MJS6nJc5Fx4hQw64ZlF
         aMPld037oONd4EoI1O5gDr8Z6SLdkI6P6zTw0HzRie6EUTu8nJmJLAheXnsFKaI55X1m
         uk/cMDJsvYK6V2k02EQRkvZGQ/zQF6o/PxdEvUHJOuqWaVaXWrmhopaxxJLFf38I/E1u
         Smxg==
X-Forwarded-Encrypted: i=1; AJvYcCXSo8G+mONxU8EsRaIpGo42RT3P8ZxjVY8LuU4MaQ9fdi2v4GYMTSmxOdDrNHy00/rMh7+SNld+32DuDWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqmRZJTIvGnS8nIzP1Qmx7S1HmSLOv6t9Sh+Qy0FNApM0pnJH
	LPA1XdE/nd7k/6a8IZN3iydwVEEyNt8yxCdtYgn282nv+Jo+cnFD3FwExvlXW+Q=
X-Google-Smtp-Source: AGHT+IFw4OU9sE129MTmVQZwtzejQ0K8o1Icfq6ZclA5XHOehCJfST7Ts2N4ivxajAWQ0s1XGFzZrg==
X-Received: by 2002:a05:6000:186f:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-37d0e77a468mr11072487f8f.27.1728372726453;
        Tue, 08 Oct 2024 00:32:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169733c5sm7380859f8f.110.2024.10.08.00.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:32:06 -0700 (PDT)
Message-ID: <de6fda94-c8f3-473f-a3e7-f6d7f4192cdc@linaro.org>
Date: Tue, 8 Oct 2024 09:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: amlogic,meson8-pinctrl-aobus:
 add reg for aobus pinctrl nodes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Jerome Brunet
 <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-gpio@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-meson8-pinctrl-v1-0-d3d838540033@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-meson8-pinctrl-v1-1-d3d838540033@linaro.org>
 <172831694232.937294.6889037408108312834.robh@kernel.org>
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
In-Reply-To: <172831694232.937294.6889037408108312834.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 18:02, Rob Herring (Arm) wrote:
> 
> On Mon, 07 Oct 2024 16:16:25 +0200, Neil Armstrong wrote:
>> While converting the Amlogic Meson pinctrl binding to dt-schema, the mandatory
>> reg property for Meson8/b aobus pinctrl node was ommited, fix this to finally
>> pass all bindings checks.
>>
>> Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../pinctrl/amlogic,meson8-pinctrl-aobus.yaml      | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.example.dtb: pinctrl: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007-topic-amlogic-arm32-upstream-bindings-fixes-meson8-pinctrl-v1-1-d3d838540033@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Right, I thought I tested those bindings, but seems I missed something...

Thanks,
Neil

