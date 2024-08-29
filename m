Return-Path: <linux-kernel+bounces-306908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2808964549
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8A28B5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22F1B6559;
	Thu, 29 Aug 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEEGPofK"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A51B6553
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935477; cv=none; b=k21WxG4BH9RjvOVSdybEiaKPkqVpCzsA31dPOVEWpF/mBZC62UIGzTdUKVF1ksy/AW8IEctK1AiGp2rz7BfqLgfVpjgZbzI8s2oSNl2OiO61M6/6JqYDdzyNUie+jpR53W9w2Ly8JDAD6RcTeO8DRYMZj8eo0x0ozQFVoKWB348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935477; c=relaxed/simple;
	bh=IjdnJ21YcC23tpIqtc+l68m0Msm4X219WADbkEb0DZ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EZlTEkykVOH60onwNYOVGq/WXneSRP3b0S63vOG/YFp3rIgKHx8SVJjVavYxCpj+SfScOiFKxqoaO0GKy8YurQdzEE0gPjUqUoxRsVpQfOQGr06nYfvB4a81atvA6jyvuEKWXYoTVzoS9g9nvvAJs80f2xElpTDd86v0R0ucr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEEGPofK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso390997f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724935474; x=1725540274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUB0KAEsaSVp1DF3WUgcTpC/KIQwp2ZunAP6bJx8MUE=;
        b=MEEGPofK47hg46b4flaHp7MojWJQw0oPfFGBh2jLU6EWwNYnsOl2dCE7Bfz2QGh/w3
         VsOJZ8nRn+GA9r5+YgX5YKwhSk8dGLbctykIxrW75XGOPLLupDYm6mJKc4sjjZNJze7v
         KRLxD4mJTAZvyYR1wvbVdW6EyN9pld4HMxGszz9NFEIwcbWL/ds4FRQTlDH83JG74XzT
         Y3F2sWODT8fafPXhDfeMSa7+zgJbhjQr6l5BEh0Dl0zKpw/gNLq7d1RtQ7nJ4kYHJSH5
         4J6iXM/9Kj6Xq9I2mfF2vk1Vl31wG0F73RHTwj1kQxprjWPmvYPLxNgWmTRBjZvkGx2O
         wjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935474; x=1725540274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUB0KAEsaSVp1DF3WUgcTpC/KIQwp2ZunAP6bJx8MUE=;
        b=WmVlZSigCPhrHN+MpuZeB0/lWK2k2bz8mVx1JkA4CU4Meb8Kp5VLGA7/nIUFa8oivZ
         K6a+q50WYNea+lGobbwta1j9+k/kNw+yDyQyOrtGq3JPnkg5aWE1TEPzr9bZD4mAkSfE
         QBK0LqqNulHDsEBu3bL1Xu0jlWD7ClQf+3IORXkUinNClUs4RXUlR3ay8J+4l5lCBcaj
         5qLiTaq+T41uegrjIFvTW/DtnnvU9Oth87OExNo8nILd7jCWUGTA2FGwrju8qAkDAleN
         WNpyckf8naawVSPjEWnkwxQgqzA8/ZDBWAFBYVJBwzDdLZjIQI7H3fyEFfLIodwzg6hU
         6k9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgE7IHhu0TI2VEo44/x1Hqu00APEyaH6L8SArAP1JsHWDSuAiPTQBf2J3inF0RYD7FkgOPLPTzSr2YuYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFi1rsDNrCa7I1mbfcNguQtsD+MYdCo3Ow7+5ZazHgYsz3T5Ss
	U0LWXq+D0FNPml6XVCh1rQOwUGpGh/4rKpIiR+FB+L1VyBvCkOLT60oEErhNtrg=
X-Google-Smtp-Source: AGHT+IFgk2Fm6SZZfHoAuJCCfdJkL/vz9sJGVVunpyVAw7VXlizRzuVzB+ANfrM23LkU7cQyqdYSXQ==
X-Received: by 2002:a5d:40cd:0:b0:367:905c:823e with SMTP id ffacd0b85a97d-3749b5448dbmr1722346f8f.24.1724935473883;
        Thu, 29 Aug 2024 05:44:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915? ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee72ec6sm1336392f8f.42.2024.08.29.05.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:44:33 -0700 (PDT)
Message-ID: <55968253-b490-49b7-91b2-cd5f18a056d4@linaro.org>
Date: Thu, 29 Aug 2024 14:44:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 14/17] arm64: dts: qcom: sm8650: change labels to
 lower-case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240829-dts-qcom-label-v2-0-5deaada3e6b2@linaro.org>
 <20240829-dts-qcom-label-v2-14-5deaada3e6b2@linaro.org>
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
In-Reply-To: <20240829-dts-qcom-label-v2-14-5deaada3e6b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2024 14:34, Krzysztof Kozlowski wrote:
> DTS coding style expects labels to be lowercase.  No functional impact.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 156 +++++++++++++++++------------------
>   1 file changed, 78 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 01ac3769ffa6..d0392a3f56d3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -68,18 +68,18 @@ cpus {
<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

