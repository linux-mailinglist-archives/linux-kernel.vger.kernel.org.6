Return-Path: <linux-kernel+bounces-435226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9429E74B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F7C169B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91720DD6C;
	Fri,  6 Dec 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdOXmhWO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA220C01A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499779; cv=none; b=muPvWbKKKRIf3JpAZIKo6kUp5VyLlPtsrJ8G+och4jbfG6z+IJT9ULAS+uTlr/O+//csqsDZoSeUiOWLIdySf6yf/MOYc4xR548SxF8an5saTnFPdiwRX4WjyAUjx3UrOFPcHLtRKo7nG58saCEqISJ8qd8CexQeG0jnzbiLyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499779; c=relaxed/simple;
	bh=syfxhDQfNDHXKWv6k6y49CYCDDgj1E/YNQio6LF/nA0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0dvt3k5+LQ80QMKHigVoDWMSEIa09//xz3TpUHuURf2tG5K8EZSJVYNFWo7B/tbuau3EYsRHwkvwymaHDayzB95DCDxFmwL8midcSAl4fMvYkKLQXeoU60KXrE7NOIzhepT+ICJaHQdMljNcpFcOqasi65EKDxglJya1BLAtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdOXmhWO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385df53e559so1622879f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499774; x=1734104574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LetIXdCw0Dzh0qaidKM8cDem89jyKUKZ16VrHvzJbAg=;
        b=IdOXmhWOWkoWCliHrC5Fb22qoROH0EUH2y1H77a3nI4yqqvdVlW7IRgIYGDAP5dvu5
         Exyrojgnj0TYBgV6lxicnOgMK38SSGFpu3dxOw28rOFWE2uvImbIlkjmjqS8VMMJP6R+
         adbXBS99pj/ge4msQcfL6Sg9rxxTts8CydBOBLRaRY2ARlihbTB2QMY7R4Hqkkvyz6JK
         C1Jxu/59ajm2i2U8dGRhLX3W2iOzjf7OPQGn1I1yCBHXp9n6TCQju5UxCbCTiHleWr35
         1Nf6dAnlOeAGOHUNVgOnZY3r5lx7zi5nC+/6E4VnkADqV6vHSNi0s43zcpG1AXF8yW+o
         Chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499775; x=1734104575;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LetIXdCw0Dzh0qaidKM8cDem89jyKUKZ16VrHvzJbAg=;
        b=qcR8gmn8rrvsr49QN3spjS2X3cenSb75Dvihi+ZBSbsqPlbauvAWicL54GDLikzdym
         IGdARXuPFo0c93Tj05GVRmYC9WRa8b7So8I3flSLCzAw74k5RsW1kfpNs9l/kMW9VQFX
         oUioDbt4kulSrWsjGb7oWYEIYLyFB6/6o4aurJyxaqvtW3gP/KV1gt6/BKO75zVDt1DF
         6/+M5877hGZ+YlLzrzLv1Wi9+m8AIzQ9jsRgpfddZW8+W/Wa4/xpl+rBaHk/XE+b+JGZ
         qls7Dc8A8V7i3kmLKLzxbKfMhyyIEnLFknRpDEmvgd0G4SEd9UuujEfdTwkmUP0jtOIP
         LnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD+eFb6ExCFci32ZwnflI7B8DJJnNLaiPp+uyQRLziXN4T7p1uB/tgsEuN6rfdSuXBVlND5ACJNpM/m9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1N1lCZycb5BMgjPQxPePFYV7JwpK8PyV6C1JylHXzfqJJIQv
	3jrGNm++vylMJwujMaN5PNGiisqaQMhQdI79+7Mv0+D5F7I6f3lX2DUin+oS/7c=
X-Gm-Gg: ASbGncuMYYyFfYaT8eH0TI7xe+XyZtctpBBwJtfb7fYcf8CiIDug39/g+1ak0wIgOwr
	/F7ZXHqUhqGdp2WtLc3Rzzk46IXJ/lRyuImrvWHJANGfH1QPpQBlB8U7c57RBEn5inBM83/rl62
	8RfRjX7+1j3X1dGFOqFCtfIYXDmmLMfod0em9lxIP1rhBzdtWkXMgJI/OtXKbMWeJQ21vKBiHuR
	uYzjud8P33t1Uzcat4ZOkPS7ZiP9lS57d/ZTyT2n4RYcSsnIkjQHE0AH+PPcT0HemEXgmoGarwk
	E/3n4SwPH6iHV6JkpM4DsewksQI=
X-Google-Smtp-Source: AGHT+IGHU+Cg7ScvfeF98Q98CaeTZnMq/QouFPMJCl25EYuBfNoN+SEv4561BvuAiTkuoI1LiSwDQg==
X-Received: by 2002:a05:6000:4007:b0:385:f1d6:7b6a with SMTP id ffacd0b85a97d-3862b3cf82fmr2702628f8f.55.1733499774645;
        Fri, 06 Dec 2024 07:42:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889? ([2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098c8sm4936536f8f.77.2024.12.06.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:42:54 -0800 (PST)
Message-ID: <e586147e-e107-4207-b105-46a26e33c56e@linaro.org>
Date: Fri, 6 Dec 2024 16:42:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 09/19] arm64: dts: qcom: sm8550: Fix MPSS memory length
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
 <20241206-dts-qcom-cdsp-mpss-base-address-v1-9-2f349e4d5a63@linaro.org>
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
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-9-2f349e4d5a63@linaro.org>
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
> Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 541b88eb5f5300ef9e20220305ff638db9b2e46b..71ff15695d396a68720a785435e692d3bbb38888 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2314,7 +2314,7 @@ ipa: ipa@3f40000 {
>   
>   		remoteproc_mpss: remoteproc@4080000 {
>   			compatible = "qcom,sm8550-mpss-pas";
> -			reg = <0x0 0x04080000 0x0 0x4040>;
> +			reg = <0x0 0x04080000 0x0 0x10000>;
>   
>   			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
>   					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

