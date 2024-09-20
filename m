Return-Path: <linux-kernel+bounces-334042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B670597D1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77705284A35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73F5339F;
	Fri, 20 Sep 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgrpmSlG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1F433CF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817754; cv=none; b=T48UKlsASXlyxDs4CwAPRvTSn4Hj0JGrydZ8nY1Svrk9hsTyJQp14LrT0ijwI71Nv+ojdXNDmEDh8SVGnHQ99Z9e1tfLQtESu7fNzYOHzRVsCPD5RrqRdtDNZPpJYvcEYpWhHKGVwW1mUkE+379EonmRIwA51I/KnaqWNIHcEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817754; c=relaxed/simple;
	bh=smBV8eDq527DInVKPWkD+q/LD1hdhAgWHrUc0rErhWw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gc3Uw+m9mI5b+q47jJujXSy1yxhGh5giQZgRMnZFpMli2xroLVWtIM+cNFbVPo9dwiU+HyjttX5AowUYOdBUHxOiljUCaIMYI58oYTKkk7YF+/l/VDQC8eE/bnFQdqvdrL/VRnpK3aOSQQwEJU1Ric51AKHXRLnCNkSfs4GOjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BgrpmSlG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso20524515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726817750; x=1727422550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWDLHbpDA+T9asRqzHgcobMlyNDMDPto9Y4sVMhHc78=;
        b=BgrpmSlGs1ngkJXdwB9dRSCG+dr3pjA4ZmI/qb0nrNzReN9KVQvoCpBnMAhThT8tr2
         mNCGGkSv4ZaiKli2cArPpnWOBGJxm+Xw1d1UB6CMEUlqS52swV/FMYDqiAhpMmM9rhFP
         3neJY9p+ILgO+My2tvKxnR/73ezWrKpjfDc7Lv2ZQcBvuL+RREW1pvZDo6wfeK14SjOC
         qYkWEEYHTogyx5saEnNuVYRp9QDlTj7bVgac84gUcnPL4v4iWTH+DtDz4WgDoN74Pfa/
         XJvybXjwTZ31V+3Uan1w1HC2dehfdrQ9t9v78Ts8MxaLkJYe5iY7iJghCoNJ3ozhWIj5
         h4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726817750; x=1727422550;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZWDLHbpDA+T9asRqzHgcobMlyNDMDPto9Y4sVMhHc78=;
        b=Gz6GOT4gbr1CE/9X5TsFWqnjVoaduetF/3V/5L+JI88rxEumSnVim0T0D98f5uj6SI
         bKwLxs8XkGavQuLd/kbKdgYEBSaIoz0xHeyRTsGHlHXWibuqjNVkI768DsuNyoOY9X5t
         8jYXN6Kdfjewcj4Du6rvhcZdF2+tCZdH0W09QCLbqj8NxgHZdnY9u8LHEHc6HecObrxN
         WIZIDrPkGXbSaI3EpTs+93EOp2xFVSdIZfMkcaCViJgkhLzOv/ldZ8y+zN2Qq5KmD79u
         Dbp2kRxwJiPp6KK0EwdwS/2KvWbosp9QfHSzMhdg6MWKU1dFRH1zw9fk9V71+RL71eoW
         TdLw==
X-Forwarded-Encrypted: i=1; AJvYcCUJbIyO0d6o2T3adsUtOk144lDcBeCmHOz851ZTAT94IwnMD23C/uDLFFHyyju2jjJMvSYPA7GPnRo96uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshyvPFt3gbHgS6Je/6K+hEmZPwRLtOgaznHbceIhjiRr/zVlo
	tw4jbrxcwsWJ98zq0tebdRD817c4/kSJMjyJmq72ZODKN/AfkGRFsvzFzsY1y80=
X-Google-Smtp-Source: AGHT+IHQzhHu8GYRJFVIRogFVKeZ0/9xEyx9HnB23t7uOTHOyq/srz/VGVOzki5ofyBlvURybjNGBA==
X-Received: by 2002:a05:600c:4ecb:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42e7ac32403mr16517215e9.15.1726817750213;
        Fri, 20 Sep 2024 00:35:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f? ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ac7d315sm15420005e9.0.2024.09.20.00.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 00:35:49 -0700 (PDT)
Message-ID: <491d06a6-1a82-4199-8eb3-79909a128458@linaro.org>
Date: Fri, 20 Sep 2024 09:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 00/11] Affirm SMMU coherent pagetable walker
 capability on RPMh SoCs
To: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com>
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
In-Reply-To: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 00:57, Konrad Dybcio wrote:
> I only read back the SMMU config on X1E & 7280, but I have it on good
> authority that this concerns all RPMh SoCs. Sending as RFC just in case.
> 
> Lacking coherency can hurt performance, but claiming coherency where it's
> absent would lead to a kaboom.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
> Konrad Dybcio (11):
>        arm64: dts: qcom: qdu1000: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sc7180: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sc8180x: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sc8280xp: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sdm670: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sm6350: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sm8150: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sm8350: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: sm8450: Affirm IDR0.CCTW on apps_smmu
>        arm64: dts: qcom: x1e80100: Affirm IDR0.CCTW on apps_smmu
> 
>   arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 1 +
>   arch/arm64/boot/dts/qcom/sc7180.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sc8180x.dtsi  | 2 +-
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>   arch/arm64/boot/dts/qcom/sdm670.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sm6350.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sm8350.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/sm8450.dtsi   | 1 +
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 ++
>   11 files changed, 12 insertions(+), 1 deletion(-)
> ---
> base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
> change-id: 20240919-topic-apps_smmu_coherent-070f38a2c207
> 
> Best regards,

Ran this serie in our CI, here's the pipeline: https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/pipelines/104656
For some lab reasons, x1e80100 & onneplus-enchilada didn't boot, ignore them.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on sdm845-rb3
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on sm8150-hdk
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on sm8350-hdk
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on sm8450-hdk

Neil

