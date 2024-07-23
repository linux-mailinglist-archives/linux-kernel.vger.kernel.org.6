Return-Path: <linux-kernel+bounces-259689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC616939BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC08B20F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA014B965;
	Tue, 23 Jul 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6cE2iac"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9E14B07C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719086; cv=none; b=jA/Qj23/ESpewVr+jFmbwhwiKGh/yfnNTrkUHVeF7VvG8IWiD3CvDSB36fSt6KFgVtUCO9K2l+WuFJzCLTrDINCX9t6nm7Frn19yftFDMuuukFZqoxDIaLDIz+DkNweX9/qcu30dQclHpl0BGyhXsYSilfdULyWdH1+pUtBmY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719086; c=relaxed/simple;
	bh=puA3RiQHX641v3xuZp5S6TK0XFy/Mp+LyP2PdsWokW8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s4hSxrpFkLHdnz4unsD1EpUFANg/mKlOw56xa84kk70zNP2jh4mTcNv7/vxStM2FQkE1D59QEG/4q4t6kFc20U+99gWKGNavpBDiu5F+aTgQdFDEstmvw4Op5Rqx+LsuWyiqDADyruT6AwndJpe/U1O+jZPnZf0TJLKnj8RTJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6cE2iac; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so44567725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721719083; x=1722323883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcxIzNk1NcysMQw3Lkhzk9zPofUtDz/QMRqmXV8AkAM=;
        b=m6cE2iacXJUs3nqPXPpbN97e0UscPJAtz45bU9fiBHK6YjvrymtYQ5KDc3PSx8+Hc3
         1zwrtognDScv3VlMWSRwEBv5fCrAf3/YvupCKvyr+0ShalPef/wJCAXVYtMVfPNu6SUv
         nCcTyTE4UvRKN2cd9ZKMGIz0DyuymMGf/RBhWRf1YdxaeZAl4ze7cT0EE6BT3cplWV8W
         h9oZuZYPX3DNZ+dKyf6WIi5ILmZmSldefn4S+FYpHde+O5los6gWaPUUaOpzp1sUxMIZ
         YRuJQzlbpi3ywAyPW+15HN2IaeStuyExsckf7At/58BH80KVEtpEy4HntloomBfjLLSg
         Sv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719083; x=1722323883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcxIzNk1NcysMQw3Lkhzk9zPofUtDz/QMRqmXV8AkAM=;
        b=rlEqhATEzJzU2rzKI/bpu2fUY1wG/UMzJOc2Jb11lQY9xYxz2WQBiebKCRR30IzX+L
         PksDd+ixUx9C2zeF7bbxqiVtbLsoQbBly7acSkk7BmYorwL6FooRv53MJn4zPOqIvMw6
         7m+MWb5wZN1OjCNvXHs5GXJzwJ9gRfd49xYqfzjmiDYviW9Hbqz6Q1Y07nkOHnyAoqRA
         9mfzD2WIvAhbTn8pleMkTsiWjq2VS5/3KaETUiBPqNFsV5RqigTyv7qwVksSdqzxoLxq
         gJouFxnd3yugmyNIZ+JoQTg4eRodlZJ5o67viGyXmsnoLYJyxRjvWWhds33VsUd3v9DE
         t8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWKOdTvwO+0/rnFqSeQVN5ZL8IE05/NyBTORA3HWa/fCVuFKADjn4YdfJDwgmE/N2FYiFXfKcez0tiIohL0EULhlkS8esjysE/IQtJb
X-Gm-Message-State: AOJu0YzVPvSTu5gYACnPj72fSmjuzDeVA/PHPts3AGlJbywtx3JlWcqB
	/+lWC2C8vPgPmbC0htVAc/jQCq7UNMyFN27OzkF3LNj9ihMiYv4uu/ZZYNiAVRc=
X-Google-Smtp-Source: AGHT+IFFdTHuWg+LUsVr7z6qMgnlrrvqaYVs4iJtYB5jKxSr1QnXFxYn2sbe1HLkfWcOBQKhAJQEVg==
X-Received: by 2002:a05:600c:4509:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-427dc56b84fmr68985125e9.35.1721719083049;
        Tue, 23 Jul 2024 00:18:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c? ([2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936e1esm158776455e9.44.2024.07.23.00.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:18:02 -0700 (PDT)
Message-ID: <615b5cbf-48bd-464b-9d75-a3d9c5566819@linaro.org>
Date: Tue, 23 Jul 2024 09:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/6] arm64: dts: amlogic: t7: add ao secure node
To: xianwei.zhao@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
 <20240719-soc_info-v3-5-020a3b687c0c@amlogic.com>
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
In-Reply-To: <20240719-soc_info-v3-5-020a3b687c0c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 10:08, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add node for board info registers, which allows getting SoC family and
> board revision.
> 
> For example, with MESON_GX_SOCINFO config enabled we can get the
> following information for board with Amlogic T7 SoC:
> soc soc0: Amlogic T7 (A311D2) Revision 36:c (1:1) Detected.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index c23efc6c7ac0..ec743cad57db 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -194,6 +194,14 @@ uart_a: serial@78000 {
>   				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>   				status = "disabled";
>   			};
> +
> +			sec_ao: ao-secure@10220 {
> +				compatible = "amlogic,t7-ao-secure",
> +					     "amlogic,meson-gx-ao-secure",
> +					     "syscon";
> +				reg = <0x0 0x10220 0x0 0x140>;
> +				amlogic,has-chip-id;
> +			};
>   		};
>   
>   	};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

