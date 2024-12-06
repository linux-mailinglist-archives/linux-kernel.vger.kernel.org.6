Return-Path: <linux-kernel+bounces-435225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59339E74B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D677D163B4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EA20DD5A;
	Fri,  6 Dec 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A++dUIM3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC020D518
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499768; cv=none; b=hefRdtnqF2fRgJn5FhHnMW8Fl5w+T5dPgQNHKX0JIdutsAPgmYtSWD3TfAhXaJdD7vdo2HamThjzHwy/1mmXT6tnjo8tSLk3diUNxYV1U7dDw0VYBaIlPu9//0pWo3mUFBoGLn00T+atl2HZyzgNjrXJ6SdffmDklPW4uQHaAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499768; c=relaxed/simple;
	bh=Lp/WLqyHI85hefKr6vqNpVxbwbpD0/dwWhvoiTGBU5w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PKhEAP2zHY8RIS9L4pA8owk5Z7E83QlRMhXV6PvjHth8jjcSIQJBBSRg/A2cW4ioqny+3CwrZMJ8ACCv40v8W6xohnrHwwrl1BWXiIziOkXCDHqLRC/E/ZdcjmNIbkMJIvAR/JRFUmIK016wlZUGmHXO9tLLsaW7T/YcwYcOCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A++dUIM3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a1639637so23050055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499765; x=1734104565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J40wjpIN+kccdvCOUsmHtSyidGl50IhD4zqfU556AGc=;
        b=A++dUIM3uD/5ObWdgqKSUJWdAZgxOWgaxXmeXgym4ur1GNVM9RFJzim8MS8udwBSWf
         QaKHBso1sZLriOjnFmB2MzNIKmYm5GsMA0tFkE3JfXUR1C4Gk2vCNSvX7K/h0aTdG6zE
         cUldGOUbQ4KI0LeWPPxu54wc017+vyT0ImqCJhRqkaJ3DwJ8cXTwjAMeK8Nao5lnjOvO
         H5iwocOsVKdz9WVPNGYzjHOB7AIPokBL7k+Ny4CGBhUUsiRtKXlo8lfqQKE92ntwgGs/
         BQbPyLnt6SXwIn65w1dkCtW+U9eUi5WS/onY5p49ZPuWNZbNdqInE8ySPu+2CoFVssWn
         2GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499765; x=1734104565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J40wjpIN+kccdvCOUsmHtSyidGl50IhD4zqfU556AGc=;
        b=C1PVnXBzbPFtMbzF4G5dfHyNzXgxzovXA3i+BI0bmjNZIM7sM52i9aK7LUuVf317he
         7QwgptD/fhAWJlywKlxhJmlNJS0il86Tnba8qZMY3W376cWwmAA3D8wqBHauKYpLT8Eq
         jHOebbY671WEBHxmYGKHP9f0fyJxU5HJaayRn7HDGUJmFQ0anr780WfF5RAVUeqTgQhY
         mf2+Y1ohOZUaJjW6MJHbITp1riT1SD4qwthYD6JOjsZIH/+kUBljYWm3dKwxE6VT/tjR
         /8XblcAU2V4Rv1gm8bnZ5QYb9GVBl5CWrqDr8FIZlZVdwUXVaNg95H43AG18nKKgR5dO
         liLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp0JdXn6b0mCyMwNIhJnQht2CRdKEPU8s0r76HdyDMvNHikOMztKMQfrCkuYwbcxDibEHFD4uIYDPJqKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYqAdEEw18MHu//X72prTi8yJT4IJ8vpK2oweWilKambOs6mS
	UpKZYxXfu9S0Bcnq3uWZw/9zhsblp6Z2S4hYNSnX7R/aM78bw2r7nBNXTL50Cl0=
X-Gm-Gg: ASbGncsGJ4h0pjUmicv8PP3555M1EqB62gLxpjU+PRyD6QernHaDJh4yF9VYi+y9KVC
	sruKFV4gkIzex2DQKjSqTl3SPt8RXqK/ZWQl2qUtD8BRpiR72looL/u314uppjtpqv6EXIER2uE
	nrml8khlgOF2efCRGc3/uu8wrfCwN6ukhZkrYZkm7wz6bgjKQuIquV7+e7ss+OWmlrOtjdQ0cHy
	wbXPRwD42VAsXLOsglTPW5aq0quwMOKCeBmZiT6yTQzTt6Ep54+6FChaS8uwDwK3wzCsFFR3hvp
	AQ/OX38ZB3q9cR9zRVYhF5uBDY8=
X-Google-Smtp-Source: AGHT+IE7+N0mH7gh+RtSvIgEAbHPfASgd8nNfPFIHP6IRdlovljpgwBVYWE/AebEynSAE6mgJ9kE9g==
X-Received: by 2002:a05:600c:4e49:b0:434:a4fe:cd6d with SMTP id 5b1f17b1804b1-434ddeb49d2mr31087085e9.12.1733499765191;
        Fri, 06 Dec 2024 07:42:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889? ([2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6961sm59186825e9.12.2024.12.06.07.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:42:44 -0800 (PST)
Message-ID: <194870b7-3016-4004-8b4d-f362dc561ab4@linaro.org>
Date: Fri, 6 Dec 2024 16:42:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH PATCH RFT 12/19] arm64: dts: qcom: sm8650: Fix MPSS memory
 length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
 <20241206-dts-qcom-cdsp-mpss-base-address-v1-12-2f349e4d5a63@linaro.org>
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
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-12-2f349e4d5a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2024 16:32, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 1d935bcdcb2eee7b56e0a1f71c303a54d870e672..6ae81c191fae8f1788adb399a364886d3fc2dfdb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2853,7 +2853,7 @@ ipa: ipa@3f40000 {
>   
>   		remoteproc_mpss: remoteproc@4080000 {
>   			compatible = "qcom,sm8650-mpss-pas";
> -			reg = <0 0x04080000 0 0x4040>;
> +			reg = <0x0 0x04080000 0x0 0x10000>;

Same as previous for the 0x0/0

>   
>   			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
>   					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

