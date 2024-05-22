Return-Path: <linux-kernel+bounces-186173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C498CC0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A051F23AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BD13D529;
	Wed, 22 May 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQ9neFzZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301413D526
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378673; cv=none; b=eHcbV6tWW4bbo/ReqJ4Tkenz7Z87OEt/viMVP8mQJuXTJ/WcBCTUx3ibjZEYKp2ZiBHjId58q3Q1B1w/BBqzS1Jhkz7gMewTObo7Qn3oFwVpxV0rvC4FFoKa1roggHNXheaLDm+5Pln0jlbnhPUBEC4eOqnk3Am4x/XT2omKGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378673; c=relaxed/simple;
	bh=a7HbsaGo4mOmiiYKbcq9Cy8SMYt7s7x49P1rK6RBFFo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VDKtPYdDX+DUGQIFlZyiEBymDJ5nNP9EuK8CzwvyP+PEwO6SBQ+dwJJGMwAHPLnh5TDMFEbO5qlEdXo1qMtvIarSoWlnyOYOpa5WxpRm6yVefO21Z1eREnYKKdtfutxk56ShlFNJ6YTD3b1mTJ41aSGunI8GpFLfwvZ+nBfXiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sQ9neFzZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59e4136010so1031634566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716378671; x=1716983471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRBy76jWiwOjrHuYKLdt1gCriWsCPRZJnOSXuDJQRjQ=;
        b=sQ9neFzZTja4UHSHzs9N4Fki2rBA/BLbSo/pL2je+9kWf2SZMsv+3bfq04iAf5em+h
         TW1w/BXQ8DN94jH0yAaVsrF1GdRWLXJ4fuTGL0FvI+SeIISm7yqswPLo1L1P4r/Nlte5
         y3zyGn0CAradpYCqXrNpLzQmLeCwWyCzsrsGzBm7bomUFnEZ11GdjbUOPuUO5Y3f94YK
         99u4TRJVdEuYO8z5+aCRu7LsLvk9U/mDKhS7hBqppCZk6WIfKGjNu/iAutIl3tAVjwEH
         acUrWV7HTJGkYYvyi7pnMORxqAgr3wDMSS5XBHrP/fVWT7iGQ8qrEardJejDLIUwbUCz
         7UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378671; x=1716983471;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eRBy76jWiwOjrHuYKLdt1gCriWsCPRZJnOSXuDJQRjQ=;
        b=VBB//Xk0Y5Dr6/xVjRC4fEuA+5A9nq8vK4pkCgL6X4z9STJV4n+oDpkkruWjdEQxPS
         JympdxB+Kft7IGgwkof8wxSLZqjKSvL9hQtXPsDP/OYTEXo3c2VHsLd7/nwldkD9u4zz
         f2OPG0u5RynQ0rXRDr4xhOCPN0Gy3DHAN6mLJGv+7r+f6HQpQ+nWD0Qbg3taroInXbql
         ncs8vZ0cXCaeLLkngNF5KJ8/lPl3K9oM8VUT3nzaQEJ1LyalTe09KLsoYwyvKWt94zIv
         NvUMZv6hYFVL24z5rDOQJ6s5P8j6ntj9BszDxRmDcNT2IT3bWN/e82Gfd2cMdqay3Orj
         yMtw==
X-Forwarded-Encrypted: i=1; AJvYcCUIRS9rT0EeQ3sSiitZMdDaGEYBwYq1BX5of9Ufn8N8lvhYvvKqHSJWLzW/0dncMWy94zIHOiZYPAGoQ0c316Tj4Pl/LW1AVUvbdMD7
X-Gm-Message-State: AOJu0YxmRKetD/OP48TSyZjKumSH7OovprvV0eO2V15IubUyYnhaCSGN
	EY4licd3FPuzlsqT0NT/YG5JFB7QPIj74j92OELKjj7KKFcnpyDGamBHbHBCK6Y=
X-Google-Smtp-Source: AGHT+IHWTq1+7a88RzzW93woluqpDnjnBcFC/6apHrRRWa9WLIh970+yDw0jNvUnJrQ3mM+UZ5fL1w==
X-Received: by 2002:a17:906:3585:b0:a62:2eca:4f12 with SMTP id a640c23a62f3a-a622eca50c1mr78912266b.59.1716378670550;
        Wed, 22 May 2024 04:51:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892450sm1779214266b.63.2024.05.22.04.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:51:10 -0700 (PDT)
Message-ID: <8879d9c0-6e22-4335-af0e-0774721fe2c4@linaro.org>
Date: Wed, 22 May 2024 13:51:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: qcom: socinfo: Update X1E PMICs
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522-topic-x1e_pmics_socinfo-v1-1-da8a097e5134@linaro.org>
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
In-Reply-To: <20240522-topic-x1e_pmics_socinfo-v1-1-da8a097e5134@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 13:33, Konrad Dybcio wrote:
> Assign the correct name to ID 82 and fix the ID of SMB2360.
> 
> Fixes: e025171d1ab1 ("soc: qcom: socinfo: Add SMB2360 PMIC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/soc/qcom/socinfo.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 277c07a6603d..41342c37916a 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -133,7 +133,8 @@ static const char *const pmic_models[] = {
>   	[72] = "PMR735D",
>   	[73] = "PM8550",
>   	[74] = "PMK8550",
> -	[82] = "SMB2360",
> +	[82] = "PMC8380",
> +	[83] = "SMB2360",
>   };
>   
>   struct socinfo_params {
> 
> ---
> base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> change-id: 20240522-topic-x1e_pmics_socinfo-30462d186a86
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

