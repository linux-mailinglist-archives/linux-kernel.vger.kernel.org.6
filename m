Return-Path: <linux-kernel+bounces-365777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70899E9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3FA1C21178
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669982101A8;
	Tue, 15 Oct 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avdzBpdt"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168620FA9E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995230; cv=none; b=gOiFv9Rs0H8xO9Zrw5VwBk2KYDehMmF7J0nHm80XEfQDfwTZ0x2d53lPxxL+iYCnHrjuLvM5SuMDw0RU0cztWoheLn40jJXYcqCejuNRmRPQdaWmRCYdiJH3wmXyHw+JFTxeJ9irnikE7oVShSAAiKKlm9/TTjc9r+/x17xwRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995230; c=relaxed/simple;
	bh=MOv5FWpO/CjdyeVYuruElEec1lWVycWSaJ29ldPnHI0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M+Uoa4cxTgYREx3H85YadwxDe5qrEWGLlzkTPkAsWpIIE0uegirVurZEEOJhUzvwpXqsqK+ukM8wYCbXWbFM3RSRJcjNzqOFOHWX9dXVHKk4BKiWsZftfEwTc5mcRNZ2Nmd9PcJKcTrR8xdJNQqSHnphqaYZnaF4aJINj44uwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avdzBpdt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso41989725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728995224; x=1729600024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9njlOBMQc/dhVBHMm2KkKA3jMdO4Wx6jwbEj5y6QnBs=;
        b=avdzBpdtow1qMktKZhdkGe8Nn0qxfx/hszjhu1h5jynGNXFGm2bT75pSC8tOximer4
         mvI26FKWk+M9asCO/jipp0a+2lu44G1SzXOePQdraR8uS3rGXkh6XDuefGd+J5s68Oxi
         R4caNBYp+3sJpmtQqkZkh0uFhqZPOLAwqkBUkdl5v1PnzhL97pol5n4OIWHWgVPfsCkv
         8nkWXexcQm5zAd641O6Ul5FmtWiAqqDmOwRfiHzQIJuCovae+ZplMc6HpuOnHutoEkLY
         VGMf1V7QAzuGLDp880l9CkPFROhewUzVw9kLH9BK5pO7r/WjGXT64P3fRnHa3IDp/cIS
         kXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995224; x=1729600024;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9njlOBMQc/dhVBHMm2KkKA3jMdO4Wx6jwbEj5y6QnBs=;
        b=v5d4W0P/2i0jvMdoe51oX5VthZbP271xzE4XHshQlwQEqFeFB19l/5wr9Lhw93YKof
         UVDD1+bCt/gJUDiMlSozDUlhbdFw7w6Gt/hT5Fnywawq+dwxPDfgx2aj0LZWteBodkki
         G+Hu/iuYtcktCUQGYS/W6ZtCpwDpnHZYSkiFyG5uh+h3InO5bfkwNLAlHOsVjEv7cHky
         mY45OeJtl5YGga+4ZYh4n/pxYWF4QfmBOtVAWTuVdky/Wj1SOe6FrX8/D8C5Fhmd5MuJ
         9vp8WMDl3BtTGH218z9AK/QQqDhco7UeeQCYGpCfzjuYdhNDdxeCFsGUzkUyMSRNPMAT
         FLog==
X-Forwarded-Encrypted: i=1; AJvYcCVHhksuYRQGnKRN39Hi032f/aVUzBYY+eH6r5WDaBKIg+fKqANLf8ygEWeac8/eM8csxi3msJrJW1x7CVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+T96Ee3VIHS55z+QevbnJy2GidjNVx8e2RYcAfI2kszTGOQ3
	Ln/cS0WXuh/4srillccjfa6R4/yEFwyKn2+fiedDYIcwYD098KJeb/6D6od5eCc=
X-Google-Smtp-Source: AGHT+IFK8Sxq5O2daKZCX0NG4dA9HLXlgGDGO7JTuKN7++PD8SDAcw/9xgHSlPGmehhf8aWWBmFzYw==
X-Received: by 2002:a05:600c:1f0e:b0:42f:8515:e47d with SMTP id 5b1f17b1804b1-4311ded2340mr126219565e9.11.1728995222663;
        Tue, 15 Oct 2024 05:27:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e686:73e1:36a8:3467? ([2a01:e0a:982:cbb0:e686:73e1:36a8:3467])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b3266sm16662515e9.37.2024.10.15.05.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 05:27:02 -0700 (PDT)
Message-ID: <2287a783-d00b-4175-8ac0-a6e86dc9245d@linaro.org>
Date: Tue, 15 Oct 2024 14:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: rename vph-pwr regulator
 nodes
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015122601.16127-1-johan+linaro@kernel.org>
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
In-Reply-To: <20241015122601.16127-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2024 14:26, Johan Hovold wrote:
> Rename the x1e80100 vph-pwr regulator nodes to use "regulator" as a
> prefix for consistency with the other fixed regulators.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   .../dts/qcom/x1e80100-asus-vivobook-s15.dts   | 22 +++++++++----------
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts     | 22 +++++++++----------
>   .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 22 +++++++++----------
>   .../dts/qcom/x1e80100-microsoft-romulus.dtsi  | 22 +++++++++----------
>   4 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> index 20616bd4aa6c..b1f190a9686f 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> @@ -94,17 +94,6 @@ linux,cma {
>   		};
>   	};
>   
> -	vph_pwr: vph-pwr-regulator {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "vph_pwr";
> -		regulator-min-microvolt = <3700000>;
> -		regulator-max-microvolt = <3700000>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
>   	vreg_edp_3p3: regulator-edp-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -135,6 +124,17 @@ vreg_nvme: regulator-nvme {
>   		pinctrl-0 = <&nvme_reg_en>;
>   		pinctrl-names = "default";
>   	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &apps_rsc {
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 4ab7078f76e0..4ab9e0ca4591 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -261,17 +261,6 @@ platform {
>   		};
>   	};
>   
> -	vph_pwr: vph-pwr-regulator {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "vph_pwr";
> -		regulator-min-microvolt = <3700000>;
> -		regulator-max-microvolt = <3700000>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
>   	vreg_edp_3p3: regulator-edp-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -319,6 +308,17 @@ vreg_nvme: regulator-nvme {
>   		pinctrl-0 = <&nvme_reg_en>;
>   	};
>   
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>   	vreg_wwan: regulator-wwan {
>   		compatible = "regulator-fixed";
>   
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index 3c13331a9ef4..10ba934652c3 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -166,17 +166,6 @@ platform {
>   		};
>   	};
>   
> -	vph_pwr: vph-pwr-regulator {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "vph_pwr";
> -		regulator-min-microvolt = <3700000>;
> -		regulator-max-microvolt = <3700000>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
>   	vreg_edp_3p3: regulator-edp-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -206,6 +195,17 @@ vreg_nvme: regulator-nvme {
>   		pinctrl-0 = <&nvme_reg_en>;
>   		pinctrl-names = "default";
>   	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &apps_rsc {
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> index 42e02ad6a9c3..c47a63b5c85b 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> @@ -125,17 +125,6 @@ linux,cma {
>   		};
>   	};
>   
> -	vph_pwr: vph-pwr-regulator {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "vph_pwr";
> -		regulator-min-microvolt = <3700000>;
> -		regulator-max-microvolt = <3700000>;
> -
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
>   	vreg_edp_3p3: regulator-edp-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -165,6 +154,17 @@ vreg_nvme: regulator-nvme {
>   		pinctrl-0 = <&nvme_reg_en>;
>   		pinctrl-names = "default";
>   	};
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &apps_rsc {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

