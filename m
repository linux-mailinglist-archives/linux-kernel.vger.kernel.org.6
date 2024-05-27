Return-Path: <linux-kernel+bounces-190206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388C8CFB31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B404E1F211D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46497537F2;
	Mon, 27 May 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqvZ0TIf"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B248CFC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798105; cv=none; b=K9X3Ezg3/9CCEDNqaIldmIH82wlLxuk/h32v5gzkdn5AyloG0spDhZEWLHvzEuH0BZ8IMDHB2EnUrZ2Hhfo/vT4V2AIMUPlWqOiiL+ScPSZTVSuFB3ATOWtNIoh1ZnqQHnrBulyw40hm9Gz3/sWTYM3ydHNKaPmow2dNpKz275s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798105; c=relaxed/simple;
	bh=cceYAsgDiCHGaSpS6IW9ly8dHBzSfQSYZLsDTFcDAFo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g31woCXaWKZXJxsiL5KlZz+3Fd0JD9OFF7i4Ex61irwWIyXPSwOiqEShPuR5qA+GFF65ZO0Mc8L2JO6lyWADqaG3tLO5PeZb6chrdpuhG09ds7bxFCo9yZzwSY021zq7hBTXDMZrgGc5YNhMtt/b78RafoCqmqRHJBiu/pBPfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqvZ0TIf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52962423ed8so3190747e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716798102; x=1717402902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4h0xVgmp6O95ltnSyYIN+xgAjoH5av4iO+f2Be+lX8=;
        b=uqvZ0TIfoGWss7jFXKpaNO9/SLBtvCoi+lh5obdpL+PArkETjjstfQUUOoIJ3otxNl
         EtmdVWVeG71CEcNtJIVlWy8QxmEmYbcZsd5t/TlbsfDT8sDha/xeFSC8EXE5IofWp4NT
         VgNm8GcizDFiNmz4h5GAEDMTFTI8dJREmbQprfTXwMXczwZ9nB9pnHRbLRLaepuQ8+VN
         ENfa3Aijfu+Yj+HwBcSStvxeSuclka1IRiFXZ1JP562YuEdwk/pz2GZ4zCMaWQRIBqUa
         9ku+wwgD2mvsgH0DFhlDr3bNdLCwNcKEA54e3Secsul971CS0IzvfrSBUe9LrrhMK9j5
         PPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716798102; x=1717402902;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w4h0xVgmp6O95ltnSyYIN+xgAjoH5av4iO+f2Be+lX8=;
        b=WbuIaEBD2bnQoG4Iedcndc5FjfUkIyFGyTXly8m4OgTOvGdos+jrjWqoKaAWRwG8Dk
         34Zap3KqcLmiCtcxX/a/j58WnuT+lRqWIZFtpIW//b0Wrtl0G9C1/MLajmBU4nHDQIcK
         tjRiwY3CWjTGYA601BDj5Hm5lqgj0ZxsT1L2nIBDUKjvg861TLlR4D6M71vThzGFVhU2
         VcU0rx/aJvJKLyeXB1jz+OyIxN6nefb0aj/DtL4uiJk0gfIYcIncuIyFtZOfvCoJc9+W
         Xo+vmpwYPJbwCDWuB8eu4fbAjRC7QTj0W+kggGnk0F/UJ1g30JntalWwwpyTNyjBqJLV
         +wpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6CGE2GNieSj8Ur26cymN2450kDVpysONKIPfvWaZnCGwFXC2z2S+yl/iJXlAniFnPnbH0j3lF51CnXlfloelieVsLgMcZ1yPyE8+N
X-Gm-Message-State: AOJu0YxEIWm7rQKUOTMFjpI3pUf8kF0SyCRR6cCgZn0ifL7XB5bo8BxZ
	3CsBQJcOO7DYn8Lje2eJaYxw8fvDjZmZrJcnM8UZwEkMYGKIfTXAK86uChmQhe/MEk6++yuQPxR
	G1uc=
X-Google-Smtp-Source: AGHT+IG1q5gpqM3RDLiKyRzMzni1Iffzn0AIEcEQwVhmUps93eC5uO7dv5XOzOLKB7s4TiS5dts2XQ==
X-Received: by 2002:a19:2d56:0:b0:51f:452f:927b with SMTP id 2adb3069b0e04-52966ca6423mr4780973e87.45.1716798101877;
        Mon, 27 May 2024 01:21:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:371c:b423:6c2b:61bb? ([2a01:e0a:982:cbb0:371c:b423:6c2b:61bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eeca80sm133840705e9.2.2024.05.27.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:21:41 -0700 (PDT)
Message-ID: <129649cf-214b-4493-bc1b-d8ea3ce978a0@linaro.org>
Date: Mon, 27 May 2024 10:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: Increase max ports to 3
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>
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
In-Reply-To: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 10:16, Abel Vesa wrote:
> Up until now, all Qualcomm platforms only had maximum 2 ports. The X Elite
> (x1e80100) adds a third one. Increase the maximum allowed to 3.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index b3808fc24c69..1e0808b3cb93 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -20,7 +20,7 @@
>   
>   #include <linux/soc/qcom/pmic_glink.h>
>   
> -#define PMIC_GLINK_MAX_PORTS	2
> +#define PMIC_GLINK_MAX_PORTS	3
>   
>   #define USBC_SC8180X_NOTIFY_IND	0x13
>   #define USBC_CMD_WRITE_REQ      0x15
> 
> ---
> base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
> change-id: 20240522-x1e80100-soc-qcom-pmic-glink-f3b715fe5f90
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

