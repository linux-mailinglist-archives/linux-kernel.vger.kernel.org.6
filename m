Return-Path: <linux-kernel+bounces-542354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E17A4C8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72ED3B59D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113AD25333B;
	Mon,  3 Mar 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdc1U5ZS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531122AE7A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020520; cv=none; b=L55cqcBVB4oCsmhu+Z18cyHqaMXHqbJtlndqI6gV5a3RBiC34cJzyo43zmpw6HXMJWHPhBcNLoY100wzXw7xJOu/H0bkrZQDqCXLyJMB+yHkm+3Pge8kIgBhejEb+70i8jjOMd4bMlsb/SPgcJTOhLEoz4K+0LxyBOGvQE3rgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020520; c=relaxed/simple;
	bh=aJqMJAxbF5oakbn+RwBrstMcyYPv8ZkAf+3b41SHUfs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HYz3mKJc2GNPNWAbSNeIbd7pkY/wQUpaKhE1V34v4vHMJH/Hm4pCHXgPG/e03gzk8rp4Vt++SOM3fd8gBu3Etf2tTRGgQTz2VBkqUezrx96GC7h44RcRmbnW66BR432eUvkzTTHUFZTXg8N70epu2RHDYfOjxD4+SuA2IJqLCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdc1U5ZS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso7943165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741020517; x=1741625317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6twUH0//ksDRm2f064XsJv+UZF+J+plN/dZHzNZ8hs=;
        b=rdc1U5ZSQ5SO9bZs9gu2dKKq5HehYPi8S1lG47QPxqoqunxQZDXMyDh9dO99JLmQmr
         s+jl2OGc/4RsNGa5eAi1ZxSr0TFP7dDmnchMGOeiOBVlum8PlIisMWMN5u/bxLjxNuuO
         bldq7cZZx+HgajudaVh7GjcYubpFdeWjrav4RYLGVGmMvOovrSkQya133CTdztJzGWKy
         zrqUaq6mVpElINsAkyl1WzLoQ6TZfaktweqD334NY2dYLO2L7K5+JGVtqzU0LJ+E178R
         GjziynW2EinZ4gDe069ayVtcDRV0EXK6j785wv3EKEisosf4kedUvFxa4cM5kI2Auksa
         IEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020517; x=1741625317;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f6twUH0//ksDRm2f064XsJv+UZF+J+plN/dZHzNZ8hs=;
        b=hUk2bI9jP+rHZ1CiVM2RCQsS3jITHhX2r5cPd05GnvkaYeP+y6+lXd+/SpcbvIIbxs
         awbff5OeB/ykF/UZsWCk6flBlSntU0NtOI8b7XDmIiYaVzvNC2bKhOTPZhjJVbNeNIxy
         MvcGI86V9HUix9CpSQKLNz81ftrHYVmOPUN4dSN0qltM31aa+x6SoWr6rMxbosYlyMoF
         qADOmOxE3kfra3Q9PXJ9Wkbh0JyCushr0oQ0sGr82qlDKHRKo9hSI+RTwMMPEvwtAb0d
         38dTngMeWN1uSlptOI3Htan23IFuIybkPgHIRWymetSo63rRZszW32eWa6ypVgmvLj5K
         D0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXU070LTxuwInshDYUPDup6d6HXt3SEmc2yh27ivN4zkE3ym02xDK+VplEzKi8ez7n1JCr3Wy9a72ta7+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzprh41yg/I/Nr8DhpAy6dYMZ+RnKlIqIpB8tdENkBArc15veXL
	8KDKD42KfKXLdny7O8SlAehWbGrzr0ymzDS7aIgbC8LiQPrBeylG2D0yFvimwV01WyPcjN/csGl
	l
X-Gm-Gg: ASbGnctQrK0AhjyYLRyo/ZWfQK3VIpmBnwr7pWK+SThkXl6G5iDFfZBA2vbQJLLQphO
	W0/mWQAeXUdPX4FXwcTJHBtdwE8Fu5aTXeWzEFkuae5MEIGo9w6qvI0C+p0uTc+GrYruZb0Jurv
	tDnmEcdieP4xR7GKS9h2nY9dhpeFQl2hSOUrY/XbCKqKVNSXW/5mvgarKAtaGV+4vEpWgY/ylIb
	GYmkpyFKygjQHvWUEdvB4uc0Szy46bGIsdNqV8IPk1I2/KFcqlnA7T7RDuWDVcHkoGf63tZOAXc
	pKE6UegqW0touw0/m/qmZdvuSukihd8MHRvXgYlu6lHFn8wQFxNCjug5KCz0YnDceRedqBLCQY6
	efM3gpAW4nvqPKA5ui55wGg==
X-Google-Smtp-Source: AGHT+IHuX0Dyyj2drftfOnysc3kce8KOWtX0dSt1AKvY/DMf+bm0V8XjPV4RbCnMrW3lKy8qr5E0yQ==
X-Received: by 2002:a05:600c:1387:b0:439:a138:20 with SMTP id 5b1f17b1804b1-43ba675d737mr105069055e9.20.1741020516721;
        Mon, 03 Mar 2025 08:48:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015? ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2edf84sm52318185e9.40.2025.03.03.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:48:36 -0800 (PST)
Message-ID: <7a84f5fa-7128-4b51-8b05-e557e21663d8@linaro.org>
Date: Mon, 3 Mar 2025 17:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Maxime Ripard <mripard@kernel.org>, fnkl.kernel@gmail.com,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alyssa Ross <hi@alyssa.is>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nick Chan <towinchenmi@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
 <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org> <Z8XcH7xoDC7TA7ZC@blossom>
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
In-Reply-To: <Z8XcH7xoDC7TA7ZC@blossom>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 17:43, Alyssa Rosenzweig wrote:
>>> Sasha Finkelstein (5):
>>>         dt-bindings: display: Add Apple pre-DCP display controller
>>>         drm: adp: Add Apple Display Pipe driver
>>>         drm: panel: Add a panel driver for the Summit display
>>>         arm64: dts: apple: Add touchbar screen nodes
>>>         MAINTAINERS: Add entries for touchbar display driver
>>>
>>>    .../display/apple,h7-display-pipe-mipi.yaml        |  83 +++
>>>    .../bindings/display/apple,h7-display-pipe.yaml    |  88 +++
>>>    .../bindings/display/panel/apple,summit.yaml       |  58 ++
>>>    MAINTAINERS                                        |  16 +
>>>    arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
>>>    arch/arm64/boot/dts/apple/t8103.dtsi               |  61 ++
>>>    arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
>>>    arch/arm64/boot/dts/apple/t8112.dtsi               |  61 ++
>>>    drivers/gpu/drm/Kconfig                            |   2 +
>>>    drivers/gpu/drm/Makefile                           |   1 +
>>>    drivers/gpu/drm/adp/Kconfig                        |  17 +
>>>    drivers/gpu/drm/adp/Makefile                       |   5 +
>>>    drivers/gpu/drm/adp/adp-mipi.c                     | 276 +++++++++
>>>    drivers/gpu/drm/adp/adp_drv.c                      | 617 +++++++++++++++++++++
>>>    drivers/gpu/drm/panel/Kconfig                      |   9 +
>>>    drivers/gpu/drm/panel/Makefile                     |   1 +
>>>    drivers/gpu/drm/panel/panel-summit.c               | 132 +++++
>>>    17 files changed, 1489 insertions(+)
>>> ---
>>> base-commit: b62cef9a5c673f1b8083159f5dc03c1c5daced2f
>>> change-id: 20241124-adpdrm-25fce3dd8a71
>>>
>>>
>>
>> All patches are reviewed, can we funnel patches 1, 2 & 5 via drm-misc-next now ?
> 
> I'm planning to do so today, just need to get dim setup first :)

Nice, go ahead then !

Neil

