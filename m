Return-Path: <linux-kernel+bounces-259688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73066939B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9731F1C21CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2714B095;
	Tue, 23 Jul 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9zDqkDs"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F0A14B07C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719080; cv=none; b=tB75mRAn4/D9qO0WsouQ8OZWgPnZboW/H/ngxJBbGIIipnpfiTlgE55jmnjq6PT4Z/J9QHShYB8APrxvFaBv3G5iorttG5MhIXnhfHLiq2FxTQk0pGqIm51kvwhe0qIszVwg7sSDojRtq3fqM556s2DOfiBUrnXeTcj0jwsfq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719080; c=relaxed/simple;
	bh=kTXeFfb/kpOjHH/Yh3U+bGVd+QoijcSNKRg1r58l2fA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TW/mMgUZEbsZw/cT33yWsFhiLEy+Vd1a/wPU3F7nBJrPOcHQT/DvDf20W0zY/3dIW5tZlX/8kTEIjsr9MGhkqeflbUSs1HxhrCAel5oklpFlI2pmNcqExgHLidRM6lSJbYQaMueMAr5zRaLBwDisPB2yLpQDWL/sU+3SgVu9v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9zDqkDs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso37034025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721719077; x=1722323877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEzKhKkmBYXTdhjYaBlSuqId8UatDTOuzDSqNIi2wrM=;
        b=O9zDqkDsgkk2iZBQwh6AfclDEz39yqwSbqH8ToBvR+Gn7OBTpqOYEPaKvaJuIOa//w
         /Fnh0DdfzQeblsnwN4sXih9oDXNOGaBLr8ylGICjPpjZRHcyolTKZEwqJLLaGLkIhkdH
         Xo1zyx9axeNgQ1ivnPyNJ+zCOkGnziRHoYtzdQre7pbLPdJ+epH0wpZMZpp4FHBiM1jy
         td5oofh5elwBMsEOBU3x81GyCa326wzheI6Lu869CEhDDGzwHEMH78g0wLbjLgWDmKDx
         /wGH9s3SCeF7m9Fglnou0t6lUQPinmvW4aRotyE+3XJOfz5PFEJsHVIoU5ocS/Gp0XSp
         VnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721719077; x=1722323877;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SEzKhKkmBYXTdhjYaBlSuqId8UatDTOuzDSqNIi2wrM=;
        b=wQeWel7z8Thy5d56R9jAXKej1u9rb1pazsgGMVNKYxk6jxgxbAD6rPlPafoFWvHenn
         LKaaOCdEG6yOanflLr4HBgp5KCKmUUCUwsPBmx7MIhnBj/XqCanCLincQnLtQluXUTW0
         OHUUGlldHVxSa5ma4UVTEENDptL+ANbLctt4VOGBjGDd2cIOFJkVz0VbB7kyqbpid10V
         1D0b3ZmIFtT673NRZvIr4XttYM/eoZJDSbSBIex1IDfAaI8bHaQe7TIVh2xemibXwdsF
         wp4caPBtTbXoMgx6s91slPMVZ1thJxI7TU9pOnOhX1daLGU31iFn0nJZiifpYKvbp+QB
         4R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYQMVzZqm65Ow2ojYj4JxelMtkxGqaMjooa0rObprEzOPYROeduATEDk4V6HlYTip+bQNgTkZcmflSh8Q5sf9f04tSL8pbm5rXAkTi
X-Gm-Message-State: AOJu0YwaCAbF24Xahdvs6tYy3vMmeYgCh62VzFXn1fw3ZebgtyUeAfg6
	0mKux1ccz0J2XlxgG6iRt0nIWxk2s4JXz/tO5vmUmgSO+cBV+YIlV3amVrXPHr8=
X-Google-Smtp-Source: AGHT+IG5n+S9PIM/0u5fM2WVXGS+r2GwBeka2nKCjJ0cyEzqu/DQBNvtsgFCLCrhKI64ABkCE5H93A==
X-Received: by 2002:a05:600c:3547:b0:426:6c70:dd9c with SMTP id 5b1f17b1804b1-427dc58f1f3mr60943655e9.31.1721719077311;
        Tue, 23 Jul 2024 00:17:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c? ([2a01:e0a:982:cbb0:f9d3:b429:5f14:dc9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936e1esm158776455e9.44.2024.07.23.00.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:17:56 -0700 (PDT)
Message-ID: <e5dc20d1-3cd7-41ee-955d-f7ba4d80c607@linaro.org>
Date: Tue, 23 Jul 2024 09:17:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/6] arm64: dts: amlogic: c3: add ao secure node
To: xianwei.zhao@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
 <20240719-soc_info-v3-4-020a3b687c0c@amlogic.com>
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
In-Reply-To: <20240719-soc_info-v3-4-020a3b687c0c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 10:08, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add node for board info registers, which allows getting SoC family and
> board revision.
> 
> For example, with MESON_GX_SOCINFO config enabled we can get the
> following information for board with Amlogic C3 SoC:
> soc soc0: Amlogic C3 (C308L) Revision 3d:a (1:1) Detected
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index f8fb060c49ae..c913dd409e64 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -129,6 +129,13 @@ uart_b: serial@7a000 {
>   				clock-names = "xtal", "pclk", "baud";
>   			};
>   
> +			sec_ao: ao-secure@10220 {
> +				compatible = "amlogic,c3-ao-secure",
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

