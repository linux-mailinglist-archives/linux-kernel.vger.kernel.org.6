Return-Path: <linux-kernel+bounces-219220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A490CB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD308B242D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BED132492;
	Tue, 18 Jun 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydSJm7Cz"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2F2139BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713048; cv=none; b=UANON9BtUzWGRwfPSJXJsrr4U4JMbhL+d0pqKPkeuH4kh4P5QGn/+cam8oMvMPezeoWIr9MEk8geaVB3QFjBTs4kB3Ue2uOgQC/KtzuyHX/4+izRN5mV5Cy/CzupcrTZemIFNv0Etl73PLH1H5FjEtgc+Ndxq/j1GMx8PtYeMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713048; c=relaxed/simple;
	bh=d4JFeY/gA40zM/j7GuNcQSrxKk3T8uubDTRhZd8fssQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TsarpXTwC3nKSjZE8G5FQ2u7JMHoH4dqklDPxNDQHHOSVniDKXFUpeHunqvgnhFoZ4jTLvSZebEALTsNUDAg7XRukgOaoti2FW+tyPjjH4+3kkNVjTlHBnfya/cUyv2umHwYEtPXKq4Db3dzCwCrudABjGwbgFi2lgcqBIifr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydSJm7Cz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cc9b887f1so20867e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718713045; x=1719317845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uFuruYSxFTW8q0lhQ6SojdfqA2GboXl9MFEejjCSjI=;
        b=ydSJm7CzB/Zjf0CmpWft6Cc7NT/dchSy7xn7/raqjv079/q1ujDRlLG8am6NVsH3jQ
         U7ExmeedNRaInDjpXUXZFBWbXdKg9rDZpvR/+wCl/HeREf3SvvsW9xrESIumTyd56sG0
         7Rc0eADP8vIAH3R+guGhpXu0igfrcc/quhHLXKIJMworAFfuTNen9XITzc0VVELdJOi7
         dgP0EVIoqoUGKIto+pFlmKOeL24ig7WV8u8lRJr/FEYOlqROi5vlCekdSbQp7k4jQbXw
         VLZtdACpZy5pW8/4j3dMfu8ohRQijU6kabRle+b7KHUpPqSCLYYynOTY9s5/Cd/ST17z
         QRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713045; x=1719317845;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3uFuruYSxFTW8q0lhQ6SojdfqA2GboXl9MFEejjCSjI=;
        b=wLH4gwxzKhfdqquM6OOUBE/q9nMYX3QXZ+QO9aefYzZtQAZ1gtjUyYzm7wwdw+m+jr
         buhW2lHOqYHx+YG26yf81RBjZGhxmNzDXhicNAj7PT/yF1ktgssqGJ4cflys9qvq4BUN
         fdcaI66dEpQ89o7XXwmJx7sY2ejHzpjoe/16T9ZH8L+QbVETN7LftHvSDIWlKifdreKC
         N/+WCYniLhm98KzkmQ+uZRFGdPD8cyfZA1Kfm9w5PAT1skUMQzf2F+tGyQrM/ctQzxmk
         cIv53JeLT4TV1HSXxRSSHpalQ9X1g8LOB6d+0ZSIw6Hd9x1G1dUu3n8HC4K/3xJ0OagT
         LxYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJKuv1sZiXgBHyvwxyFfi7XYqPg8nxc0rumuBEcAGmoWv3lH5HFU2WroyC79maaLcw7DJ0Sqdh5VL/PssnyvmWCVJr4fhKUyrkXt3f
X-Gm-Message-State: AOJu0YxZlbsvqEah8/3E+4xNMIhNapJ4gnD8zM8dHd3/NKEhK608eoJc
	lVF5h+2Fk/czDCkQBQMONX0zbR8LwLQFqfhoryoYTNKfVHXsD8z62Rn1FSxapjk=
X-Google-Smtp-Source: AGHT+IG9F4nX/hc5VEqm9Ov35a3hlFo4u2Rn7L2eukLc4cCJr935zr5t2grirzOwhyxvoSgceLZ+fQ==
X-Received: by 2002:ac2:4daf:0:b0:52b:c33a:3959 with SMTP id 2adb3069b0e04-52ca6e65845mr8078122e87.28.1718713044727;
        Tue, 18 Jun 2024 05:17:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f31:be49:5b98:50cd? ([2a01:e0a:982:cbb0:7f31:be49:5b98:50cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f9e2b306sm185956505e9.16.2024.06.18.05.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 05:17:24 -0700 (PDT)
Message-ID: <3ad2d00f-6b5f-46c5-b95c-c8d68e8be736@linaro.org>
Date: Tue, 18 Jun 2024 14:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V4 8/8] arm64: dts: qcom: sm8650: Add video and camera
 clock controllers
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>
References: <20240602114439.1611-1-quic_jkona@quicinc.com>
 <20240602114439.1611-9-quic_jkona@quicinc.com>
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
In-Reply-To: <20240602114439.1611-9-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2024 13:44, Jagadeesh Kona wrote:
> Add device nodes for video and camera clock controllers on Qualcomm
> SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 336c54242778..d964762b0532 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4,10 +4,12 @@
>    */
>   
>   #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm8650-camcc.h>
>   #include <dt-bindings/clock/qcom,sm8650-dispcc.h>
>   #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>   #include <dt-bindings/clock/qcom,sm8650-gpucc.h>
>   #include <dt-bindings/clock/qcom,sm8650-tcsr.h>
> +#include <dt-bindings/clock/qcom,sm8650-videocc.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
>   #include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
> @@ -3315,6 +3317,30 @@ opp-202000000 {
>   			};
>   		};
>   
> +		videocc: clock-controller@aaf0000 {
> +			compatible = "qcom,sm8650-videocc";
> +			reg = <0 0x0aaf0000 0 0x10000>;
> +			clocks = <&bi_tcxo_div2>,
> +				 <&gcc GCC_VIDEO_AHB_CLK>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		camcc: clock-controller@ade0000 {
> +			compatible = "qcom,sm8650-camcc";
> +			reg = <0 0x0ade0000 0 0x20000>;
> +			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
> +				 <&bi_tcxo_div2>,
> +				 <&bi_tcxo_ao_div2>,
> +				 <&sleep_clk>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};

If you resend, please respect the style of the SM8650 DT
with blank lines to separate different properties groups:

+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8650-videocc";
+			reg = <0 0x0aaf0000 0 0x10000>;

+			clocks = <&bi_tcxo_div2>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;

+			power-domains = <&rpmhpd RPMHPD_MMCX>;

+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		camcc: clock-controller@ade0000 {
+			compatible = "qcom,sm8650-camcc";
+			reg = <0 0x0ade0000 0 0x20000>;

+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&bi_tcxo_div2>,
+				 <&bi_tcxo_ao_div2>,
+				 <&sleep_clk>;

+			power-domains = <&rpmhpd RPMHPD_MMCX>;

+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};

And add the missing required-opps for the clock controllers like
dispcc.

Thanks,
Neil


> +
>   		mdss: display-subsystem@ae00000 {
>   			compatible = "qcom,sm8650-mdss";
>   			reg = <0 0x0ae00000 0 0x1000>;


