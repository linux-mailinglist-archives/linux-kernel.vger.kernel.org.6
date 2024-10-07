Return-Path: <linux-kernel+bounces-352891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F69925BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A862A1C22220
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB018B48F;
	Mon,  7 Oct 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCydAS/X"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38616132E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285104; cv=none; b=B0GASjz8SN6ortDSrDpvTJBvW7542YEspOO8Fn64s2ludixIePIO9MRXcpMqcFfwjqhX3wkoSq81NMgolWik1j5kV4SwYD/EXvYOfWrVCzi8A/VdKOPaNQiCP8bGv7DABdrMrQzKa1yCQqlPU+RnZny7aVkhzwCtjV9SSFakHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285104; c=relaxed/simple;
	bh=enGkxcbLHOdgAeivRCHbMnChr2GTtrsDDnxdLG3bC7E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O25dCU67xW34xUHiLTy1gpnrlqJgYSzc4YyfbHDN87N8KoCyLc491XNWGasWaNP2feSVSVmzF96amIjWsPZOPDaLDA/LLjriXJaPzIpL3uEy2zedLvOX0LtuRd4sqPxIMqsL99YInwhZBuCjrl0bXJ2HQh6KMJbVgg7JkmbrMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCydAS/X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso2297753f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728285102; x=1728889902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCK80+Zdo5NigUQbZJ/SoQaC/Axw1PHGJT5E+88+pC4=;
        b=gCydAS/X0g3R1VU0Byf2+yQXbbCB2/71geYstqC5OrPGbikFjm/TPxHzSk/Cgaf26M
         5ZTO7YIICt6BE82Fla3Smpi4S/uOYrwtpNUzOJji7THmqb/MxltS7UTgs2Y+YoltmFD2
         3vyRB81BD7BKaBytdaXP3La0AxcwamwVks03YWw6WWZrJqSvPQ5ufWSMi1xd3RjG0QfU
         SACyfWOIYh2rhs4vwRgf3HBK66WUPwsuuxn9hgPq1WxpUl5IB+1PuRuei5Ucqj7usSFM
         NJh4gxEQLDqrvZdwCtbq5Rv5GaHHlouXeuVpGHJuJtiZXbzjqyCpaDaQEosh35dCMIY+
         usWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285102; x=1728889902;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gCK80+Zdo5NigUQbZJ/SoQaC/Axw1PHGJT5E+88+pC4=;
        b=N80cDjN+MDHoM7dfqMRZ5sPrdnRkVwHkXgVwBu3VmxRRemEu3KtNldjw8q1lXdfUvv
         Guyuvaag5Zj6jGyzv0KER3mQ3GXbiDJhr7AeCGOaYHIvKvlNFwgJmO7Xz/7bum7uMty5
         YX/XDvfVpYD3GKVfYilBGwgjM1infzQMRF6y2ueF+ugcoACddTlkxyYsEB0cLeE1PEqF
         ieLfDt6pGs5F8WuHRAxUGTZ8j8mGEkfDEbT8pF6q8duy0uXrHuJKQLgdWYPMA7tE988z
         8bNoRjLJPmCxJ5AIOtk1/vwDglu9ZeGpKEldvyQhXXPfB5VM7XQlEQKZp0EXk0WUppCa
         379g==
X-Forwarded-Encrypted: i=1; AJvYcCVPd+QHWTxKZlTZna3Cp86ss1mOfa797Zui/hrtU98Ei7aqxbOyqG9ut+yRZ+pXJm8wlK6AAad1D5xDsCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJFEaIgekde0D0NIYxhX0ODVw4sLxTyXBRiygl+zvBYiOLBrI
	N9SlmbAaWGvyYDY5OWULvH5Iz+vGQoOhHy6jD/xPb3+7Qrvgq1DrEjFO9RFO9vA=
X-Google-Smtp-Source: AGHT+IH8tfiHMYgj/TgOBx4ZUIl+xf+sgHiscl6mr6ZInKvVsP/MuD8J42nJA572uZUsXwcr+JPkkQ==
X-Received: by 2002:a5d:4d52:0:b0:37c:cd0c:1539 with SMTP id ffacd0b85a97d-37d0e766a74mr5740542f8f.24.1728285101581;
        Mon, 07 Oct 2024 00:11:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7? ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f0b2sm5035226f8f.9.2024.10.07.00.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:11:41 -0700 (PDT)
Message-ID: <c32226a8-43ac-4dc7-b2ce-8ce9464c6eba@linaro.org>
Date: Mon, 7 Oct 2024 09:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: qcom: videocc-sm8550: depend on either gcc-sm8550 or
 gcc-sm8650
To: Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241005144047.2226-1-jonathan@marek.ca>
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
In-Reply-To: <20241005144047.2226-1-jonathan@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2024 16:40, Jonathan Marek wrote:
> This driver is compatible with both sm8550 and sm8650, fix the Kconfig
> entry to reflect that.
> 
> Fixes: da1f361c887c ("clk: qcom: videocc-sm8550: Add SM8650 video clock controller")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/clk/qcom/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index a3e2a09e2105b..4444dafa4e3df 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1230,11 +1230,11 @@ config SM_VIDEOCC_8350
>   config SM_VIDEOCC_8550
>   	tristate "SM8550 Video Clock Controller"
>   	depends on ARM64 || COMPILE_TEST
> -	select SM_GCC_8550
> +	depends on SM_GCC_8550 || SM_GCC_8650
>   	select QCOM_GDSC
>   	help
>   	  Support for the video clock controller on Qualcomm Technologies, Inc.
> -	  SM8550 devices.
> +	  SM8550 or SM8650 devices.
>   	  Say Y if you want to support video devices and functionality such as
>   	  video encode/decode.
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

