Return-Path: <linux-kernel+bounces-259685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B812B939B96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E727282F21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C114A4D6;
	Tue, 23 Jul 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvx98APM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75F13C3D6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718998; cv=none; b=j8m+zrPTL503P4VF5mtjaMEe7rCdaL581rRQulMkfbZOjTL+S4SCDA9XJVk574c07BfM33MG1Vz+bU52Ud1AVIDIKJOF8U9JeOCeXHeqL+Aj8jVAqm4Dj/aa8hG8uevjKlLZs49Pbs8sLi3kAUpUogl0SnHyLjoqJreuScT7tFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718998; c=relaxed/simple;
	bh=55f9gzZ3xg3DLxoDmzBHAgc6dkit/Wge8rACVtjoBF8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RzsHG/u4jSEy4ru5JfFfPYzX0uFaJdkYgWRMMDuTI4dTqCtthdW7tdhyu+WXP/Y15hnQkmKBbDz+JLcZlWKWAm96UvFQH0w/raPMWh16KbqYCO9PWHiHKHFFH32TAkpmkobSoRLIt0+p8ml5NN3ZBUpMH7ph3t4vfptVLNzJxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cvx98APM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so38445665e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721718995; x=1722323795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8+z1hzRqPPRvxreD5f+LLq696wigaoWrNTEWZo7r6M=;
        b=cvx98APMFQkmtA0W60Qgn2dJId3mcQdeweelGPPvqNOm/Oqf8Dp2tBltXDsZSTIFP1
         LYi+2kR0WcuPtxE8Q39JI5rAJSEWBvrOqSZVL6CPgbGWkfz3AzjPtKKChKUjr1/Sy/sN
         Wiz8I/wNTtPojarAhwsHHPek0EUuG3j40jxmI7CfSJVRukCf3RjDKNaQSA7JseuIg7kN
         +CIPgilCUAQffQgl4rEvNaBcpZJ/mMjqJC+nBIptFosj/HzKWvZpddkjupVigEFC9EOv
         UVQm0h516ETva5Uz4gsxSa4qz3cxMDP5LEY/iZJ+gEs//9bBLbN6mp34v+FAkwQuH1RH
         3ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718995; x=1722323795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8+z1hzRqPPRvxreD5f+LLq696wigaoWrNTEWZo7r6M=;
        b=YrzxJxzGE8Ry93K3CNBi6LvJQo8VZh0Orovry5Jk75s9kWvmameF59E8fG9XD6K49J
         fH/6nzFe/QG8CPIbe25uE/z//N5qVLwP/2Iqvu8TQibUw1xeej5zMEU8C/lXD7+s3vtE
         77nPWyWQrvnajJQIDTxmlzO2nJ2Dqsk5ntlS/0xqqDp16ncFJRhLv6mDHsklr27S/IO4
         298hkuh/GsxLqNzJE7j0MntqIS+5Z4xiVWZ0JTDgl7EUi+3yaIKLH7lnST2D+imKt4UG
         QUAx0nctu5S5Nx2qNqUvkC+T5An5AnSjI7b/JNymM/JzAhSVoUmqnPA+jzDrwiR2BtGD
         3I4w==
X-Forwarded-Encrypted: i=1; AJvYcCU2mq6zkJGhB8QCLAI5y98D3F8TzuwUHsuprTRquMqTrRTs0W+YrNTxUmk3mHmgaFBT24xfTnoiC10/2ltX+PxPn+M8fiSiELugPy/B
X-Gm-Message-State: AOJu0Yyive+69IHFwSPjfMuD7/szu2dv3bK58eZ7bZzy2fstCAQTTjyy
	ubceTNNG6Tkq2JEjTa0xkRiLJSk9rQY6LtHQ8yNwGJJHa9PiCrlYPXl8hfevEwA=
X-Google-Smtp-Source: AGHT+IG5VufI8pqRrLSqh+8rndOpIB3ocF60gG2oVIkHsjs5kqH3um83dyn6qiiPjAfzqwGfRkOfzw==
X-Received: by 2002:a05:600c:384d:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-427dc522895mr67647995e9.10.1721718995075;
        Tue, 23 Jul 2024 00:16:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c? ([2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a5c564sm183341265e9.14.2024.07.23.00.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:16:34 -0700 (PDT)
Message-ID: <4f48f5ea-4247-401f-8d4c-0ddffe696bf8@linaro.org>
Date: Tue, 23 Jul 2024 09:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
 <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
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
In-Reply-To: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jessica, Doug,

On 09/07/2024 15:05, Neil Armstrong wrote:
> Add support for the 1200x1920 BOE TV101WUM-LL2 DSI Display Panel found
> in the Lenovo Smart Tab M10 tablet. The controller is unknown.

Could you review this patch ?

Thanks !
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                  |   9 +
>   drivers/gpu/drm/panel/Makefile                 |   1 +
>   drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c | 240 +++++++++++++++++++++++++
>   3 files changed, 250 insertions(+)
>

<snip>

