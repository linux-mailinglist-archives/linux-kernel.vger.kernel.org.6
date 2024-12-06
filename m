Return-Path: <linux-kernel+bounces-435227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B49E74B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6E228588E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7020E305;
	Fri,  6 Dec 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7/GyszV"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2220E038
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499783; cv=none; b=BE0EfgcD50NDEvq6KN/cPWJCsxkzzbGilDb+cz9qxCvVvBkky91yN3F6AYkSRSttwDkJRmdplk/MSmeBsBIxzrzCvk/dw/NuOguLZdD5eTObcb/W7UEYc2lg6qr5Bx/a5rpDBKMjwoPL9Ambgwp1eNHZJDiwBRMQoqa0mcgE318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499783; c=relaxed/simple;
	bh=7NlftJRasVAObJvHPP/WpEJDi0l5ohe48qjEpQcP6cQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJ+evXvodtLYxmQNk4+KuWrgkkdOMPyTB1lNnCfZw+wKUsIgQLa3bAns4w4L8RnGmAocLVEcB99L1vUED4ir1DHIvzNYWTGbbqTgZfYDzaIN4J4Snzj+YWi+nhv7ZNyRGJJRRbfIEdA4xgLXh9wCnld0X1toTblcU8xAS/FEQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7/GyszV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1696330f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499779; x=1734104579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYV5P1ZJISdq13OzkYXkbJislzC14sD62DMBLiJjapo=;
        b=l7/GyszVjYfJoX1m9thOuaUN3XtUjybYkz6vKxCuLsta+UI8kKkc91fjv/IzptdGzD
         Ingc2z0xAGIiOyz/ztB+Io52JsTNdhpUdq37Pqv/ZfmM6081fjMF+ABJ9hKa3oaqQqz+
         8rCImuO/FMgHTHVFfNjhuQiGZninF0kk5i+12U4apt9JQBDlKhDc67EXxLNTjLWz4xK+
         vid+LD09OwUZ7cG/2z7//XxafsbF9/ikjWs6imLOxlpH+2atLR9GX9UiXyiAMqFXI3m+
         Oc7UsxpdJvKKjAGDhLNz8132r6ye2oECguyRb60wEVE4c/wdgyOjapcQUhnnStEond6u
         XEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499779; x=1734104579;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYV5P1ZJISdq13OzkYXkbJislzC14sD62DMBLiJjapo=;
        b=H9eZMywE7oVPh+D4ZTFOsENmBxJOuZ13+JZxacz4o9omev4nbBUpYWw21GwF+5tSKJ
         tirjE+6KZ9+9Z2sBJjw0/EXjHizCmGadfnAyG0z84RvIWQa19l1OIng8OPoUchFhz9a2
         Q8Tpv8J8FyrB9hkH/YbT0WdNfX3cuCmVUqg7sbDQnDhkUYbsKQGjS0p4KzsTnEeutRcr
         EoDq2pvOsihF7urCbwwQOVa38dffg2D+9UBas8WKDlWVtMHVl+j+FgrxliC/QCC2zjzq
         n8dfGVEIgyDs7hVwuQWpf0RGjGa+7amA3eJCLY8L8MQHxVNJoarZacVAUQfKl6/9kYOd
         6hGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzLewHIDgV8FLZBJumWJz2Njn44EQy98eTFJAhcprJz852x4aQaqT7vWnriS+/TCL7Ldz5EaAXNtHDWEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0alhqLvjrFOQlivRbZv+WvQlqgzSgAcwhKfygppP1EWWEXYAh
	8h3fQ1XwHUtlAGdfZGkUNke2rvAB+yBQa0ZHfq+sMOuKLEhL9JJ3noH9avkqwD8=
X-Gm-Gg: ASbGncvJC6omp3aB2fIBohaXK1mzlCUGley1Udu+RPc23da2OYKem4p1GQjmK5i5Dyt
	iDI2GHpSnEUk3VwnPuyG/IPcDOzhfr2NtejSnYhemLb9/1yqQwbfLHyElJW7EvpjO9Se8WWiwAf
	PSWn8G0TZEXxbnI3mk2Ys74+bVtBXeH/hwlMHJcnviqqn9dGJpiHblPTRjIyzxERg4cxnxr9hct
	Il1SPXVSRnNyEP41tn6tTv6F8oaq54cqg4FeX2jxe1RWmOFl8eq8oM6vMBD7WNNS6605Yww9KdU
	ydPMQTfCVrw+tiMlarEC+swCEYY=
X-Google-Smtp-Source: AGHT+IF2MszW+R6WQx8jK8eOIRjM+8EACHmUN+Ecl27G6iOCJJXgb9J+BBHlHUmJa9pkMvBTlx5TBw==
X-Received: by 2002:a05:6000:4007:b0:385:f1d6:7b6a with SMTP id ffacd0b85a97d-3862b3cf82fmr2702803f8f.55.1733499779648;
        Fri, 06 Dec 2024 07:42:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889? ([2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098c8sm4936536f8f.77.2024.12.06.07.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:42:59 -0800 (PST)
Message-ID: <2417fc42-4874-4e73-9a87-384d239ede7e@linaro.org>
Date: Fri, 6 Dec 2024 16:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 08/19] arm64: dts: qcom: sm8550: Fix CDSP memory length
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
 <20241206-dts-qcom-cdsp-mpss-base-address-v1-8-2f349e4d5a63@linaro.org>
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
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-8-2f349e4d5a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2024 16:32, Krzysztof Kozlowski wrote:
> The address space in CDSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
> copied from older DTS, but it does not look accurate at all.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index f454015c5b90c7d792c01bf85256812857d79c64..541b88eb5f5300ef9e20220305ff638db9b2e46b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -4716,7 +4716,7 @@ nsp_noc: interconnect@320c0000 {
>   
>   		remoteproc_cdsp: remoteproc@32300000 {
>   			compatible = "qcom,sm8550-cdsp-pas";
> -			reg = <0x0 0x32300000 0x0 0x1400000>;
> +			reg = <0x0 0x32300000 0x0 0x10000>;
>   
>   			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
>   					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

