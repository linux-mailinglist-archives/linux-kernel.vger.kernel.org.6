Return-Path: <linux-kernel+bounces-441173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3079ECA94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474001694EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707B1A8417;
	Wed, 11 Dec 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3aB/A/y"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580C239BCD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914102; cv=none; b=fBKnFNb3VAB3cqpWMRVovzxQNa4QsHKJ2IAZCdNezcLZO51nVV4zGwULJTMTl9C4kppNLY7r7g8RCUMUwRw/NAobLdxXBYjdC4VkW/rQbQ+zisoti2spI/Vw0jEooqqj0hGmM+Xe2+Qi6U9lTGZjMu5YMxMmgMVaI9s4RsDvOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914102; c=relaxed/simple;
	bh=rk8eMLbw4z4cpvAfU99wGO3ubUjRqtAd6ro6hn4RfQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mmb+zqxObY95r7kSlwrn51C9QSyb17QYKvom4dfJVHXPO8JtpLKxl7/HsEUzvb+IrwM+0Lkm5E0BjQ8ZVXqwA/xmGWGS0Toe0KA0xQNPQUvJpp+VhO9X50b2+7JKRLsGlTiR5l5bq94Yyh4XY6aqEFD13SLNUK6yffkQG2U3FcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u3aB/A/y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso3106825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733914099; x=1734518899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AHk96CveMFpne4Qg2DAeC1kDrIWAj+flZ6oP/v+Q6s=;
        b=u3aB/A/yti2Z8ofJ3sZ5I/SeI/Od7hHhp4jN6G3qo6eCZyIRHwxulJkVcLY8l/BnNL
         EQBX7XkEcQUfscnryv34F4Lfyn+igCrKWYQ852eSr04/dJZsu9rWoc9xQuM/HgaiHZ8p
         6lTAoFIwYR3CoG1gIf4jtKJI3EMCbVLP4k93eS21xOu8m5YeQsm/sG4imG9cXilSa5HM
         F2qgVn+JtywCV6hBXEY+7UpYnxPLVIFUOA3eHTwOq8yXSQff1GlVboJFXg8uTXQ+6E86
         l5JmAXVwFaw30neF5Wc9pNk2+a6L+qspiA7r+EF8Buf8uofU8TVqlS9EVssTUHJMc0ds
         DB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914099; x=1734518899;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5AHk96CveMFpne4Qg2DAeC1kDrIWAj+flZ6oP/v+Q6s=;
        b=hnCYxjuEhXmh4dOZWMu35tcrSe+Cqv/ZIMgFDrEBa4DnZ5pNYYWtJ8QXens59mII0E
         KQLqlmCowpupgSHrm5hfjBreevJtseYR2s3mWjwJT7G35L0n2WBGGknfyF84MIx9zrIz
         CRCBzIN30TAdN1bTIyR3pNMNn+rfj7uyt+4K8ZN+mBsNZ0YIBOjWS1p4KNb8yZt0zfRA
         3nCAM/YJzFwiyWV9/Im24vVZEEprNlhD/s0rn7bPDFJUhNZwVqHADOHBZOzCHRRBkvFK
         ZdEu1xeMv4SAzLSftKX9/cM6f9o/IlTH/c4o7mb65u/Nr9iVX5YN+aMTv+x4p5yMkTJ9
         +gcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcdZU3tXbOTzQsInbYZLz+67A0u3RYeDGO8rQJrWljZYkIxhBwT5wGTplHYulpn21/H2Oj0qCec2b75N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2x6UZuti4Lm7pmqYrOlr4vjvOHsHUylnqEtl0aWy7iJTb7PZm
	dR1aCz/pSFXM7/dlqBqcbPwBhGmW3z/UmYBjSClAO7ESrBGd8M9qVyXCTlUOI+Q9IF644GbPO1/
	Lk0Y=
X-Gm-Gg: ASbGnctcNfgwr0EQHANqHtyTSFFVYA3olK75lVNNpeu2aIhdubTKv0K8X8Dnqs0uB1o
	jFqVeKo91tqi1XTqvlX2FpodRvEWl/pKKsZNZDoIhVD/xteco+587Fp2M0HzZowRW9sfoS3Z9ua
	xfJwc7vE4udeJhkfK8B8rZbl0539m2NvRMnvEF5ytYVXTsNdOCy7Sv4NKPZqra7SfleZX246sn5
	ckDU/IKdGb/ypPi5o7rPNwZGsKFXv7izTQJ4WH/ujEFNB5SCxRjIj/eT34Ac9zCEilPd4vxHqmw
	cViWDIvyV5mrIU77k/8btb1ANf6AExg=
X-Google-Smtp-Source: AGHT+IHJEQvPPbIu2Zq9huncyi9Mdv7rLLdSvVfodKnE7kxfl6ooLaQF/VSOcNgCqJmvphQCDVGipw==
X-Received: by 2002:a05:600c:1616:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-4361c5a3918mr15626125e9.6.1733914099360;
        Wed, 11 Dec 2024 02:48:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d426:8f10:1673:5657? ([2a01:e0a:982:cbb0:d426:8f10:1673:5657])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435ff2f46d3sm44071955e9.19.2024.12.11.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:48:17 -0800 (PST)
Message-ID: <89bbf7cc-db04-4e1d-a1bb-570898eb3449@linaro.org>
Date: Wed, 11 Dec 2024 11:48:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add coresight node for SM8650
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210-sm8650-cs-dt-v2-1-cf24c6c9bddc@quicinc.com>
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
In-Reply-To: <20241210-sm8650-cs-dt-v2-1-cf24c6c9bddc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/12/2024 09:23, Yuanfang Zhang wrote:
> Add coresight components: Funnel, ETE and ETF for SM8650.

Is there a way to validate those are working fine ?

Thanks,
Neil

> 
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
> Changes in v2:
> - Update compatible for funnel and etf.
> - remove unnecessary property: reg-names and arm,primecell-periphid.
> - Link to v1: https://lore.kernel.org/r/20241210-sm8650-cs-dt-v1-1-269693451584@quicinc.com
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 165 +++++++++++++++++++++++++++++++++++
>   1 file changed, 165 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 25e47505adcb790d09f1d2726386438487255824..76620d478e872a2b725693dc32364e2a183572b7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -5654,6 +5654,171 @@ compute-cb@12 {
>   				};
>   			};
>   		};
> +
> +		ete0 {
> +			compatible = "arm,embedded-trace-extension";
> +
> +			cpu = <&cpu0>;
> +			qcom,skip-power-up;
> +
> +			out-ports {
> +				port {
> +					ete0_out_funnel_ete: endpoint {
> +						remote-endpoint = <&funnel_ete_in_ete0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel_ete {
> +			compatible = "arm,coresight-static-funnel";
> +
> +			in-ports {
> +				port@0 {
> +					reg = <0>;
> +
> +					funnel_ete_in_ete0: endpoint {
> +						remote-endpoint = <&ete0_out_funnel_ete>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					funnel_ete_out_funnel_apss: endpoint {
> +						remote-endpoint = <&funnel_apss_in_funnel_ete>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@13810000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0x0 0x13810000 0x0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port@0 {
> +					reg = <0>;
> +
> +					funnel_apss_in_funnel_ete: endpoint {
> +						remote-endpoint = <&funnel_ete_out_funnel_apss>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					funnel_apss_out_funnel_in1: endpoint {
> +						remote-endpoint = <&funnel_in1_in_funnel_apss>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@10042000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0x0 0x10042000 0x0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port@4 {
> +					reg = <4>;
> +
> +					funnel_in1_in_funnel_apss: endpoint {
> +						remote-endpoint = <&funnel_apss_out_funnel_in1>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					funnel_in1_out_funnel_qdss: endpoint {
> +						remote-endpoint = <&funnel_qdss_in_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@10045000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0x0 0x10045000 0x0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					funnel_qdss_in_funnel_in1: endpoint {
> +						remote-endpoint = <&funnel_in1_out_funnel_qdss>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					funnel_qdss_out_funnel_aoss: endpoint {
> +						remote-endpoint = <&funnel_aoss_in_funnel_qdss>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@10b04000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0x0 0x10b04000 0x0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port@7 {
> +					reg = <7>;
> +
> +					funnel_aoss_in_funnel_qdss: endpoint {
> +						remote-endpoint = <&funnel_qdss_out_funnel_aoss>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					funnel_aoss_out_tmc_etf: endpoint {
> +						remote-endpoint = <&tmc_etf_in_funnel_aoss>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tmc@10b05000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +
> +			reg = <0x0 0x10b05000 0x0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			in-ports {
> +				port {
> +					tmc_etf_in_funnel_aoss: endpoint {
> +						remote-endpoint = <&funnel_aoss_out_tmc_etf>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   
>   	thermal-zones {
> 
> ---
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> change-id: 20241209-sm8650-cs-dt-ad649dcfa5e8
> 
> Best regards,


