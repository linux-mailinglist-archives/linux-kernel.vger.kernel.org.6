Return-Path: <linux-kernel+bounces-308248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFB96594A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F175B22D16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E316B39F;
	Fri, 30 Aug 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ay5bcyV1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99D165EEB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004844; cv=none; b=akmueMMey4nc2fP/w+s3RkBoB88BYbyXiyW8KUf2lX2z+Z6gidd89+PnE/vAEquhj6IDdi/vQeZnubE5ikE/jayW9MGCJITrFAJBLEDLVngdoqiC/J9U8UEA4q4smG+3wFJ6f4aV9m0yT3lA1bS8AcHP+O2TBcYg3/pIJYjUBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004844; c=relaxed/simple;
	bh=gboOF2Ngvof1aldUL4B+Q59b3IgS/1OCd2faPSoBHKQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J9WHO+99Bp7ayO+ZaE4q+LRKvp4AtgOr3wut/luqlNrczVfulaVSP66+mvhCLjltoM/oqK30VGQz67lrWHB3byV/Ha3/dqz701D0R5XswX9o21nPINdol1a5K/mDcUaxwRlphNsjc03qYKhoKq4AQGKBBoHyTnWka+Rm1rB4KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ay5bcyV1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371941bbfb0so897681f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725004841; x=1725609641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aT+FymHOGJ4ZjNsGMyV1jzCm+wux1VTZ963iwlhoYNw=;
        b=Ay5bcyV10XAbyHvyCJ40T3gJKpfPgI20pkgBEz6qknqqYKDJcAs9jac/M4IFB/Hrye
         ypvWwcbd93cI6peqficEzFd33MPQz7SWDUhAZpNvD8xO6EMYaIYoHufJTAFlgCNzYqEs
         tsBCJywPTg3LkFoVRrOP3mWHb7w6M+UZJW+dW98ijI5PmXKlSMSRnOT5WyTI+YfTseKK
         FUBFkcHkat83k6Si3Vk/vZDuGFnXxm8/i3lMg5tS1fUV6869KvrF5byjPDq10aJ6gkYc
         sEfztG0jNJeYbFZUUbtOCRvrigDTSQ6DZlWgIcC9AcahBL8WWF0Qi62FzRBgsBzmyLCX
         1G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725004841; x=1725609641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aT+FymHOGJ4ZjNsGMyV1jzCm+wux1VTZ963iwlhoYNw=;
        b=DHGPydzJDhVgxNHUHv3trpMIFeWMRWgTrhzQv3sy0/aoKQs7z1Brnl6IjBTTgzVd1U
         xkA8RMDhcOqL+JO3hmql7wSOJdKstqVAjFW2TUhyRmL7Ze3T+rcomQbhuhj+VT8wWkqs
         dzGDggFqDuagEBYUdf/FuzSTcUtiVdhddd1xQWb4yuPjgLX0CUdutN7R3qsHytgYPu1Q
         IWcmimnlDjXwmilLWdM9kQFn2l8aUro46b+Mbzk4wADy5qhWWbtzG9SBXYM13izDCe15
         qg22kmpO++kw3xmk4VO+MyG9BRYhWJCXhDXds5r9B+yiUyepZdNxmY/ZviaIhWLSWBJc
         biQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLGAXCqF4rgBWFJmtyI5d4oQ1lR0Vdzm88kQyhj+PqVF+oZdfJZIl2zmf+mqUjQ/2eYuVWrbj7FqSfGPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUurVPNVuatqoUrQu9rBF2vqa9S13bFnkK6LRvcivflujQpPH
	2VgBK+Zs2k+ATFdHEnThbKwkSIqfpfZrUkKKTQ6P1su34azuGstxVyOoBBL9FTA=
X-Google-Smtp-Source: AGHT+IGaS+aWpJsYuGRyJ2thiJRtaJgzM7top3t36Ppo8teV74FQka/MoeeTgTC2ZthBBwQRrYjM7Q==
X-Received: by 2002:a05:6000:ac9:b0:368:504d:c3a4 with SMTP id ffacd0b85a97d-3749b54950emr3987898f8f.17.1725004840209;
        Fri, 30 Aug 2024 01:00:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3? ([2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a57bsm3300078f8f.20.2024.08.30.01.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:00:39 -0700 (PDT)
Message-ID: <0e74dbc8-88ed-43db-95ef-0fe55d92091d@linaro.org>
Date: Fri, 30 Aug 2024 10:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: fix C3 PLL input parameter
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: xianwei.zhao@amlogic.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
 <20240830-c3_add_node-v4-1-b56c0511e9dc@amlogic.com>
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
In-Reply-To: <20240830-c3_add_node-v4-1-b56c0511e9dc@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jerome,

On 30/08/2024 07:26, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add C3 PLL controller input clock parameters "fix".
> 
> The clock named "fix" was initially implemented in PLL clock controller
> driver. However, some registers required secure zone access, so we moved
> it to the secure zone (BL31) and accessed it through SCMI. Since the PLL
> clock driver needs to use this clock, the "fix" clock is used as an input
> source. We updated the driver but forgot to modify the binding accordingly,
> so we are adding it here.
> 
> It is an ABI break but on a new and immature platform. Noboby could really
> use that platform at this stage, so nothing is going to break on anyone
> really.
> 
> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--

So you mind if I take this one via my arm64-dt tree ?

Neil

<snip>


