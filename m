Return-Path: <linux-kernel+bounces-214853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF88908B20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B90B26573
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A34195FE1;
	Fri, 14 Jun 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nt3BQkga"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A0195B16
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366114; cv=none; b=dJTfLN7BFzSY9armRiCQcd0X29l83lO6s84IJ8BAjtT75B/LV5gwfYxMS55t2q7PTMV3kpvbZ388brL+hWEmCe2GCGtPc3Utwco7oC4GW67z2FnRBNEqMBnKzILDFhXExkPpOw5QISgx7RTNNpQthQDI863POIA5pVtEOnz2FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366114; c=relaxed/simple;
	bh=loyo4OfDGg55+pfKNVS2gYo7AMsPRDMIEmt5JODLFIw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=co/RyonsBbz92nx8kRT5pfDS3b1ZIcpaA2bzsW5ffWG9Q6LT2MgBjAXqOIJ7GkcOTExYCoOqL6/AY/X78lfhU4gU61A3r3vH634uDtANZmshfSencAPsPTc1QsXLjqrjJjricifmFbizxN7dGI5Xg5PJIu3OgHRmaR2w4BvQZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nt3BQkga; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217990f8baso19987565e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718366111; x=1718970911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3dtZU2KLEpU5tzc4kE1SRGR2o6VMlxAQm2p/h33llY=;
        b=Nt3BQkgaOyImfvinnS3zbfpmS1ISJvwyhqZqizb9ePTN0rJ/REiikALf29cHWg4Rrg
         awgcusfpMYnW1cjCwKsAFM0SABfWyUkNrjVW3yqOBLxgIr/sxPu4QHBPSs/13PcT1KPx
         //1BEfdC/FP/yWKw14ELyfgkXWbn7FYMRPGx2OTsi5F08j7Ll8c0DJ0nnRV8YwQOq9sT
         tDs4aX0NzbUj79LPq7p+NdJpCP0uBprfpEjcu4TZNUWCrKq/RA6vydpfS9VHnleQQSuW
         lBVoFAPCIYLamkZBhCoL6NdSERRhMDNdfKy8/JpnuUj7lnzX48lRAv1xXBk61OmHhdDq
         XlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366111; x=1718970911;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3dtZU2KLEpU5tzc4kE1SRGR2o6VMlxAQm2p/h33llY=;
        b=jJjwHZPbN/9o6Nz4i/JgqJhCjYi4n9oEZFOVHVB31coZFXXO7NzzKcOwl6lNx2EkRI
         e0YCaEfWYILIu7/5/6mQy12Ux65HanivqgjiaTMc46PQeNQOWXAcROEzjgMp6tJlmJ0I
         uoWqmCooKlmC3BFXDZqZ7or19MhnkMDIg2ApD5nNTE4Yf2mfWiZwCsxZdZ+d0sEZXzq+
         qofskCV6Ut4sRcygDbthPbS+zwi8OKdW1ZD54v2S1VUaO2X3qZHJHgiScpvXVe95c2HB
         VBugLA8gRUkSLnGxjfJkjNe6+gQR9UH8xAohJMC56hg+p+1+CtPqU8VixwAybij8GLfk
         5Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ktCejtuVgMwIy2SBLbGPYJjZjvC5HvXOVudlWtuvC66D/6CCX0VSlOKJxBDRyPcxnNv0kmW56gW+OUPCy7MXqStx32yuS0wfvIBx
X-Gm-Message-State: AOJu0YzhHlvLizwOb9LPJGumxYwPqLuI4UXnSeWylEp/pRcAIPhKHids
	dXSXO4/Is1f7U5OV2zk3OVK85Nfv2dHpd5wslau1BYTY6ToQVcplvZkVSMKA6Vg=
X-Google-Smtp-Source: AGHT+IHe7ilkhLn6brP4Brukvc2iYhEp7yHhu6WJozyi0LPc6EI2rwtIOjbx/c9coBw72bY/68m+jg==
X-Received: by 2002:a05:600c:3055:b0:421:7e0c:f876 with SMTP id 5b1f17b1804b1-423048607a8mr21288945e9.41.1718366111308;
        Fri, 14 Jun 2024 04:55:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:261a:269e:a3a8:a2cc? ([2a01:e0a:982:cbb0:261a:269e:a3a8:a2cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e6b63sm96853685e9.39.2024.06.14.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 04:55:10 -0700 (PDT)
Message-ID: <dde0f627-e486-4ee0-9bd9-950c5a968bc7@linaro.org>
Date: Fri, 14 Jun 2024 13:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm8650: drop second clock name
 from clock-output-names
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 devicetree@vger.kernel.org
References: <20240614-fix-pcie-phy-compat-v3-0-730d1811acf4@linaro.org>
 <20240614-fix-pcie-phy-compat-v3-5-730d1811acf4@linaro.org>
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
In-Reply-To: <20240614-fix-pcie-phy-compat-v3-5-730d1811acf4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/06/2024 12:18, Dmitry Baryshkov wrote:
> There is no need to specify exact name for the second (AUX) output
> clock. It has never been used for the lookups based on the system
> clock name. The driver generates it on its own, in order to remain
> compatible with the older DT. Drop the clock name.
> 
> Fixes: d00b42f170df ("arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 5b8b1d581a13..5df2e00fdb5b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2474,7 +2474,7 @@ pcie1_phy: phy@1c0e000 {
>   			power-domains = <&gcc PCIE_1_PHY_GDSC>;
>   
>   			#clock-cells = <1>;
> -			clock-output-names = "pcie1_pipe_clk", "pcie1_phy_aux_clk";
> +			clock-output-names = "pcie1_pipe_clk";
>   
>   			#phy-cells = <0>;
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

