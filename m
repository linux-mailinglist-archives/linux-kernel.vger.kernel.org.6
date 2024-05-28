Return-Path: <linux-kernel+bounces-191959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9B8D169B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AE01C22A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5D13C81B;
	Tue, 28 May 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlLyq18D"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9917579
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886011; cv=none; b=JSS1Q54fp+MzxEVyHMLLC51Hjly6me61bGc9JzQ463jDsGpA/oVaheOePpXk29UkRWt7RlUDaY0vz9R2qNHGeu4Y50vmcY+GQe0OqULsCHnSP8IH9qkoPb2swQNLHpW8YoziFnjcHTNwy3sf+TPmEC8zGYNbtxP1EueE1Oh6n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886011; c=relaxed/simple;
	bh=n9JXDO9d89lLOoX/3AcBwiNztvp10tx+ANINuhLeIvA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g8g9H1urlS3rrDhTYYwKWrBw/vU6x97xxW22EUOic95uBrrzOJkZc85qNpCUJogZJAsK6X/+StxMtkg6ZygfN0PBBeYLlxTKQYEgT5YuAMezvrZBx9aNeE1qyLvz0gSaVEthl5gH1IMguGmiFOgR4cgYwhc/WbmEeDFk7ZjCZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KlLyq18D; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35b6467754cso169142f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716886008; x=1717490808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoPTkSstfWYikQCW+JvBw9OJ4aACkIS7xPQ45I1/spU=;
        b=KlLyq18DPloVMghbfiA8n0g8MyCj9+FtcCu+h9+v+leaAPN9jBoqnGlETChQtVGHHE
         PgLdkEYg4amSdcnZ5jP5tbkJgK8FW/xjVAUMGzz8kwZvcxMYkTYT0LEs2ThXwC1ZIa8g
         K+0EJBQh8ITZBrpOgj7Z5ge3MmjPK+9DpHbGmH3yblqr2dzj1pjDbxi82kfctppdtrye
         3hcqVzU5Fr4r/L84HG96E6Qly1GXqDU8JdmMnR3UK7H4JSi7M2GNM2RXSUMdHNVsW79e
         ptEE1RXdDSTvCl7DfbbfZrFAtY0DuPxPC+tXNcAwlfHPIFDOW6y30qFc12fgb69Gjfoz
         3/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716886008; x=1717490808;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uoPTkSstfWYikQCW+JvBw9OJ4aACkIS7xPQ45I1/spU=;
        b=TRCyESzDhBslprTCJ86bnpzVz2Ue4bolFUkhlS4FRfvMc5Xq/XSPdaqsq8powwz6qH
         D6CjJ63IBBcNuQslxnilTodm6e05SSOul2aTHlCJ5w8lA/UmYVqAjTVC4G2nR3LqdXYj
         TMNUyYGQbomSYHTJ1cMLDtSPDooRCKl3a8+KuZABt7Muy8HvCvxg9AXcxQmOwE+hSZ8z
         bgrduoOQe9btphJbUH3yaFMOqNfpJS1DbD6B3aUGrEOlUSZuq1sfYkSM6nbtnB7MidWv
         SSLThMgMOmt472KjiC/cmrppBd3lzGOI/fPexWsAQx8N6Jziq3WbSRZwsBN7ft7EPbqg
         x92A==
X-Forwarded-Encrypted: i=1; AJvYcCW8BBF9X9n1Tkru+QpMobDGXvWQd/syVVeg0fdaQOi0yqDy9DG97VHYvYMp0wUmQy3jsK1HT294YAMjvl2zWF7aDrl8FxPNAC3dXcId
X-Gm-Message-State: AOJu0YzLFP0+y3JZRm2ruVPONt6ox++r7Q6kt+yVR0gO1r8SIgODM+n/
	LuxMKJw+hBfhnnbD3RXcArRI6RF/jEhsHygLKina2Y2uNxm94q3ZbxSO7dQF8E4=
X-Google-Smtp-Source: AGHT+IHeh7vF7KnRorjGCeQhv0h5uhIs1a7fiuao8jvp6p4jUUN7Bs3ltOy//i/SKrOI4IqXAveejQ==
X-Received: by 2002:adf:f909:0:b0:352:e4d5:5e12 with SMTP id ffacd0b85a97d-35526c2b7c6mr7551225f8f.20.1716886007402;
        Tue, 28 May 2024 01:46:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385? ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35607bcdf26sm10980087f8f.99.2024.05.28.01.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:46:47 -0700 (PDT)
Message-ID: <c97b12bb-8b56-4129-a292-588226a0ec42@linaro.org>
Date: Tue, 28 May 2024 10:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: a4: add power domain controller
 node
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
 <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
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
In-Reply-To: <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 10:39, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add power domain controller node for Amlogic A4 SoC
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 4 ++++
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 5 +++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> index b6106ad4a072..eebde77ae5b4 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> @@ -27,6 +27,10 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> index 73ca1d7eed81..917c05219b9c 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -37,4 +37,9 @@ cpu3: cpu@3 {
>   			enable-method = "psci";
>   		};
>   	};
> +
> +	pwrc: power-controller {
> +		compatible = "amlogic,a4-pwrc";
> +		#power-domain-cells = <1>;
> +	};

pwrc is supposed to be a child of secure-monitor.

Neil

>   };
> 


