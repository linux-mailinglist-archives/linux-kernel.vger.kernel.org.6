Return-Path: <linux-kernel+bounces-291772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCF9566AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA25B28395F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8E15ECEA;
	Mon, 19 Aug 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtWpKnkS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098D15D5BE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059066; cv=none; b=sQGBd8Cru1PqZ4TVJu1fCjszuu0BwOXNNac2+mCIRnPPGVzH2z0uwKM44afq6eR39u0cHAQcngDxUSQk5IpQmdHEK7Bf3lBCQ9WBofPfMq4WubLybeEhwivDJn+mKgRHoT7m1Bod1OKE3aHoXNTauzIor0WdP/epbXnfK4jgQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059066; c=relaxed/simple;
	bh=DeAh7OCINJlaVMH/2MJ/n7OJVs6+3KRocWQLIJZn7NY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eLgMQN8HzX29Rs+2Dn3S/yrbs20dWeiZN7AGjqPI36xMq4nIq5Kgb8M/MjCTOnF/RGqPyajSb7ktn3A8FjOx3sW3+2DzfYBn05yf6qQzGjmox98HTcvPBzCrewLsEpl/qIjynDUx8t64zkNac3Y1LMC0StbzAhganRvkNH+KjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtWpKnkS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so32436245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724059063; x=1724663863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW5htLOExcm7TmNKkHH5JrpafKHBGU3xH9gtLbh6Kuc=;
        b=NtWpKnkSACj4C18GLXAsrPSNTFKq0ZLWlRj/TZQNNIu9h4OQwtPPDaQ4rtQXJPnL4y
         k379MViAidVQFcaKFjVpMrBtKBa5FZ+dpIyXsAjHdF9/k1WC9BBvInuw0Qjuw7po/Kzf
         WwwOpSJ/EyXnF6bk+REO3mZ3IAu715v9xP7MyylQuPU7hWDs8iK4Qw3UqZvAffx6g+WT
         kfXxNKjyS/Fz/gm6l5i+faVJOAiyDXTuzjmo+0Zfid9rhm0P0I36MasPXVe25/pKQMWP
         NulDSI9XC6/tuDU5YAVcLSaZH9f2lVsazH7WM52G0IHAoE1V3YhW5i+VkjQSqRJRI7J4
         xBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059063; x=1724663863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW5htLOExcm7TmNKkHH5JrpafKHBGU3xH9gtLbh6Kuc=;
        b=vxM4VfgZcoCcNQl8RJZR1XAWDh/NnzxJMfm6wxG46ubUP/C6806LgoiSfCC+VlLn7e
         CGYpLsBtC0YEc6v4wV0g+aObAO5u2Q55hJ45gyOPqbaEoag/mpp+JthvFT3jGc2Qh6FO
         U4q2An2hcSv/MiJs4KSvQcahbUjrFkNaMwleiSmgw4Jk9/v68pTbcl1yyITnTd7Z+w7B
         rt7fc+1xd1+9bIfkAcY27YMh+z4JVFXu8zJlHY+aQjpUxR4eA+GXQcj3ioDFay3Q1DLU
         Xj8LC6OesczFsls9MICkhdKt9qCvV7RHiSWdXsiZr0oxEZ58PJMR12S59FADDmcgzN4W
         WGYg==
X-Forwarded-Encrypted: i=1; AJvYcCVpMElG8ds9RQQFTbGhtEsRGbZi0kggl+X0Xx5hNIG1YWpAKNvaqgwc4lyisBtJcP0sWG+4ha+AIyyeAfQMu9mbcOWCjE43v394EceX
X-Gm-Message-State: AOJu0YyCiTow3Fssyz9Chy4Pk5ugxj/JnudbCm64av041WTgue3I3yri
	sKPW9on145lQKZMe2XJvRqyfkJWP0njwcQ4qMTRJcH0QUzRf9DrwRg1Lkacltbo=
X-Google-Smtp-Source: AGHT+IEAH3Kw9cWP0lRWspZIIbJnS+xNyPa9dFVtb1/yX70W1/SVJnGw2FZ8bD+/7UjVDQogk1CDVw==
X-Received: by 2002:adf:ee8f:0:b0:371:869e:d24e with SMTP id ffacd0b85a97d-37194688e87mr7226712f8f.49.1724059062973;
        Mon, 19 Aug 2024 02:17:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a05sm9935848f8f.26.2024.08.19.02.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:17:42 -0700 (PDT)
Message-ID: <c6494803-fff7-4348-b797-8bde5ed57fcd@linaro.org>
Date: Mon, 19 Aug 2024 11:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] usb: typec: fsa4480: Relax CHIP_ID check
To: Luca Weiss <luca.weiss@fairphone.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20240818-fsa4480-chipid-fix-v1-1-17c239435cf7@fairphone.com>
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
In-Reply-To: <20240818-fsa4480-chipid-fix-v1-1-17c239435cf7@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2024 22:21, Luca Weiss wrote:
> Some FSA4480-compatible chips like the OCP96011 used on Fairphone 5
> return 0x00 from the CHIP_ID register. Handle that gracefully and only
> fail probe when the I2C read has failed.
> 
> With this the dev_dbg will print 0 but otherwise continue working.
> 
>    [    0.251581] fsa4480 1-0042: Found FSA4480 v0.0 (Vendor ID = 0)
> 
> Cc: stable@vger.kernel.org
> Fixes: e885f5f1f2b4 ("usb: typec: fsa4480: Check if the chip is really there")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/usb/typec/mux/fsa4480.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index cd235339834b..f71dba8bf07c 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -274,7 +274,7 @@ static int fsa4480_probe(struct i2c_client *client)
>   		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
>   
>   	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
> -	if (ret || !val)
> +	if (ret)
>   		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
>   
>   	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",
> 
> ---
> base-commit: ccdbf91fdf5a71881ef32b41797382c4edd6f670
> change-id: 20240818-fsa4480-chipid-fix-2c7cf5810135
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

