Return-Path: <linux-kernel+bounces-365364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98199E133
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B691F22AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5EF1CACCF;
	Tue, 15 Oct 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Srp4aN+o"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B81AB525
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981292; cv=none; b=WciyxOWcjmToqkNFjpTM6W8b5XpahOWrNYu6dLohFiaDhRbrxfZ5tmHbNp0sF6PMmKnbNbU5N316KZMrA4Asrz5A8OA/O2xlyO28itKILmSXlKZB/5koySmFUZxlwMNDU5XAG3Wsx7ZfnU7r09QmpKzA5mg3XCBhaZPqyDX8SRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981292; c=relaxed/simple;
	bh=vfA3cFKeX79RXE2IbVW0LNxACXUY0WHdztmLtARPTk8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CePwq0pRH0gxe5QIR/mZE+p4Fmwn7/iN2M3TMxxVzL2lxMx/wghQ0olWuYL0LLRlE7ERFAS6JdRegFsuJK1W6ZaoUR1gAX2xvd+KfY+RX4CiBuKcbZbTD65ECbMhBNKzhQWeSPdMz7bzpHP3Tnn/7Pve7341oORdQ/4qOoEXZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Srp4aN+o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d5aedd177so2502727f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728981289; x=1729586089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUF7jv5c/y05IM3ShRlS4OQ3zoxaQbhTTM2rs8WpeVc=;
        b=Srp4aN+oZIBIA+ASBPx9u3mfD34SW+lW7+sOnJoBdaRruEemkZxCqly7vT76S1CEmk
         BqJV0OJVTEY3w5v9QRiR+dzwd/1QI66Qd+BJ3SVPo7g3yUIMp7LAG+7qZdn7mdz3k8PI
         TCNy+fqQVZx5k8jW5h/VyRLu6Rel8/6UlLLGqIyssGpMFCZYNrN+tfppmyiK0QD5U71f
         WHDSyT5R6QnztTjzf6BE9mMFH68ni0GWnIi+hfZP6HcQ26rcrWu+ORO4f/vzKR2ZI7yX
         P35OK2+vue/GWMGCQgXn9gZN+nxd2dn4vTIhAxzhGsxE84bf5VJeei2E2I0QcqBzrYCs
         2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981289; x=1729586089;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oUF7jv5c/y05IM3ShRlS4OQ3zoxaQbhTTM2rs8WpeVc=;
        b=EoQqpBobKXHgCxAWUQ2AYWUjT4g6utU8xZHIAf/pwqGTgKQeIkRHUYYbi46AnPVU1b
         DRBUfUwP/Vbr8BEew20yL0QRQb79jcpHTbCtW5UxYxvoco0NQc6iCevhAFGOmzcpggyt
         gzjn/CvHX6fPTTwUt811XIb8KMbRjkKodvL8eOWBMslJ3X99X1OmSENDVAVBasOgr3zf
         sPerOuhRmCz+Hcn0AywGc/4hj/mrNu57QSg0HZo936w2KmAQdSwuIPYwyzK4t9g3mOmv
         Nrtx1EyGlBXB3fY/H9BxF0YfzKQeb28iJ3dZRRePi5zRWJRbkOHvUv1oS6NrvowSU1rQ
         kcfg==
X-Forwarded-Encrypted: i=1; AJvYcCUJdmbSZ9k+jN6SmOgehkAUIS59lJGgR49kKfRmpLDLqje2tRt6Q0OK6W3AhVZmE7ic19PhBEf86e/LahM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8oacqPv8yEzhhLxMfuWpFw+I5QBqQCgaR7Jbb+ybOEHoVa7j
	8j+ErNxG7kUPyDkx21Jnxf3sP/Ay9SCORCNbIKVGdZ366/0l82VYWFO3O5OKYBM=
X-Google-Smtp-Source: AGHT+IEE9Bf4HgHbwmOabZF6YFKnn15l5Ozto9RbXwA5IBzSiR97gav6hVgamHDCguQUrt9TO/528Q==
X-Received: by 2002:a5d:43c6:0:b0:37c:cf73:4bf7 with SMTP id ffacd0b85a97d-37d551fca59mr9456233f8f.34.1728981289440;
        Tue, 15 Oct 2024 01:34:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e686:73e1:36a8:3467? ([2a01:e0a:982:cbb0:e686:73e1:36a8:3467])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a06dsm974468f8f.5.2024.10.15.01.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:34:48 -0700 (PDT)
Message-ID: <43bb5d15-b045-4621-8795-15e7522bc884@linaro.org>
Date: Tue, 15 Oct 2024 10:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
 <20241007200230.GA2301832-robh@kernel.org>
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
In-Reply-To: <20241007200230.GA2301832-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

On 07/10/2024 22:02, Rob Herring wrote:
> On Mon, Oct 07, 2024 at 04:03:37PM +0200, Neil Armstrong wrote:
>> Move the common MMC "slot" properties because they are shared by the
>> single-slot or multi-slot controllers, and will help defining a simple
>> mmc-slot bindings document with proper slot properties and nodename.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>>   .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
>>   2 files changed, 360 insertions(+), 341 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> new file mode 100644
>> index 000000000000..e02d3cbcc271
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> @@ -0,0 +1,357 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MMC Controller & Slots Common Properties
>> +
>> +maintainers:
>> +  - Ulf Hansson <ulf.hansson@linaro.org>
>> +
>> +description: |
>> +  These properties are common to multiple MMC host controllers and the
>> +  possible slots or ports for multi-slot controllers.
>> +
>> +properties:
>> +  "#address-cells":
>> +    const: 1
>> +    description: |
>> +      The cell is the slot ID if a function subnode is used.
> 
> Actually, this comment is wrong. When slot is used, this is still the
> cell size for the mmc bus.

I don't understand, the comment is still valid, MMC slots can have function subnodes
aswell, perhaps the "slot ID" is confusing here ? here it stands for the MMC protocol
slot ID, not the physical slot of the multi-slot MMC controller.

Neil

