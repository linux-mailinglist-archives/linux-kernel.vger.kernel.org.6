Return-Path: <linux-kernel+bounces-259691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD34939BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33C81C21BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B814C583;
	Tue, 23 Jul 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYKe3CCZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9A14C581
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719092; cv=none; b=tSEoxzZQI/Ao7Kvu5GKKuPyhvdXwrzH6Aysy/qKHhUsCgykZvgvLzQLSVy0nUwm1VeHxz7wbPkRDJkc973AcY/5xs26vdPcLsF5IUBrpWbLUBg5ZoPG5phBHPTZunA4afyq4YpbcKZf7crmvKtLZFEPQJKlYtLHOowUDyY05zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719092; c=relaxed/simple;
	bh=/LE2UCByvaNfmC1k6jGWgCT2XG/4QfPshPkY6ea4FwA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tFPldWSZyCYQ6Mihj92lf+gzErlrCPwqSctkhVQjo1MSX/Wo0juBR0uU8zH+eKoRYGtqJIJpMricx11Rk5jNwzNEn6V9klhU1lu+BSrJ/KEMesztHWD4LimB3yoQWmuG/HD5PB+q3v+Op5Zo5MBdv1D1N31jubDgyDt9oCgn1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uYKe3CCZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so44503865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721719089; x=1722323889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydCuwPfj0pEnlU6AaFBIoa0ru0Br3Df785ipYUCvBEY=;
        b=uYKe3CCZQFq5/tb5KtUfjLEB6xLmgWmxIqF+RHh3X63ZKCeyDutflx1/z8Vy7KhY/U
         jCzrVnXMYN2wezZA5Q/2xtuIBk8Z1o/lYacbwyUlLT0Pp/Q7sUftmNSSgz9qfScmv7GY
         IOrhlD6cB+S+cPBg2hLY123lnX1ni7Si2IZR2eYcbWEndi7OPIJx9daXAZetd+GvzKmk
         wVpqAZWCifq9sp939xDNifs4ETV/jpkBqTabOWkld/FxOV71hO7204bYnxFVOWO0XlV4
         jKdUzg23ezsDUrBA3mKN96Gt4RsPDhE2xnoKz8nSY0wrzGS7V1P46GOg+pXH7dZw4vVr
         d8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719089; x=1722323889;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydCuwPfj0pEnlU6AaFBIoa0ru0Br3Df785ipYUCvBEY=;
        b=p5p1sqaLoXR7m30CIzWfg0nyqrqclrC5nNxUsgqsfiM4uMpXJMCHDKgJkgbfXNYzTy
         RTfQOFSLMslVQRW/GwblP4rEdw2GT1yJg0/d8zjM84jz0YYdI6n8c2+2NuzLvCyV3Qyz
         YeUAUBR8Lpppgo0nVSSaHK30Av6Ipta/pK2XsX0/vmgqBsUhd86zZlTi9LF42ejRNB2T
         duTLLkoRA/I6BrRJlpGoSVr/eAMLj8KwQvQuIjrz3I7h406ZbudeOWKduMlkltOA0b8o
         EMKFJdUoj6UOi531a2LjuNHL2Qbu2FZsboyO5ZsPm7voObL/y1oxqsGBjTK80INQPr14
         WcVg==
X-Forwarded-Encrypted: i=1; AJvYcCV4kuDnKNMUiu0xll+JILaJjmZfRODRzXpehFA7Wb39wXPQkHGDn2/+qcNgpVJ95oFy7I+Zg3Z8CjtLYu9+ONpwCBFEc6a62qqqdy8g
X-Gm-Message-State: AOJu0Ywkan3FKYFUfEQoiXhvKVgcLKaEMK8+G8mUP55W8YHxqgSrbuZw
	nSjA95q6ESYodWTJvgUiH3dQBJo7HFFO0B79ahDqIN0wggmDppL41sQSaoP0gng=
X-Google-Smtp-Source: AGHT+IELyNJ5MhVuAdHi2FQf/t2l5VCVjB4hpHHZgvCgFFNLWcDsIdKM0hpiiWJhF8fTDE9KCN0JPw==
X-Received: by 2002:a05:600c:1c92:b0:426:5d4d:d759 with SMTP id 5b1f17b1804b1-427dc55ba36mr76696805e9.24.1721719088523;
        Tue, 23 Jul 2024 00:18:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c? ([2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936e1esm158776455e9.44.2024.07.23.00.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:18:08 -0700 (PDT)
Message-ID: <4c4f2d4a-c748-4158-bb30-a1c22d5a2a34@linaro.org>
Date: Tue, 23 Jul 2024 09:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 6/6] arm64: dts: amlogic: a4: add ao secure node
To: xianwei.zhao@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
 <20240719-soc_info-v3-6-020a3b687c0c@amlogic.com>
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
In-Reply-To: <20240719-soc_info-v3-6-020a3b687c0c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 10:08, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add node for board info registers, which allows getting SoC family and
> board revision.
> 
> For example, with MESON_GX_SOCINFO config enabled we can get the
> following information for board with Amlogic A4 SoC:
> soc soc0: Amlogic A4 (A113L2) Revision 40:b (1:1) Detected.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> index 496c3a2bcf25..54d7a2d56ef6 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> @@ -67,6 +67,14 @@ uart_b: serial@7a000 {
>   				clock-names = "xtal", "pclk", "baud";
>   				status = "disabled";
>   			};
> +
> +			sec_ao: ao-secure@10220 {
> +				compatible = "amlogic,a4-ao-secure",
> +					     "amlogic,meson-gx-ao-secure",
> +					     "syscon";
> +				reg = <0x0 0x10220 0x0 0x140>;
> +				amlogic,has-chip-id;
> +			};
>   		};
>   	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

