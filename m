Return-Path: <linux-kernel+bounces-447482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F079F332D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB361883B46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A6205E1A;
	Mon, 16 Dec 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cr5Y3nHO"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDE202C2A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359161; cv=none; b=jnL9hrTq9DM8Pcydbli7TyWIc5qD9aro+Q5ZyHLnMZayk0ux3N5tlVcd5xjE63Fnqvg4WUXhUoxfvqDTp4YwTxKyG+s2txEqyYNIABpCpIubOTkP3JnyOPSGqrE11IyAr7TLfcl+3/QBz9khVBQJF4FhsxE9E20HVA2qpb9HRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359161; c=relaxed/simple;
	bh=0jChCK2hgfnrOR9Fv94tmqgCE4HGBx/UL9ZRoq5VKvg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R/0aHbk1O0g+kSCDQNAB6+vWSuVAICM0YVmO3zOmgB2E5MeJRw4EzgvkbOYQCZSWdxT8NYVktFJomb0KMzrSIpCrW9upv7uUMAHvZ4YiT2TIQ/xJkdTNBS6yTFGd8vMSLtZHUx+LmNUJRIt9VPhyngF/p6tAP25fX2mYiJGdN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cr5Y3nHO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso1983690f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734359158; x=1734963958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uwMQ5mbp5Vrk2ULZzXAw8C9yBa8vGhTvRK+y8BuBwU=;
        b=Cr5Y3nHO4d9gvSoW40/muKPUZSodqOpNp8WPB1JFITZ9dvUQvQfvFDPi6yubJSvJ65
         nt5d4Bjg+9b1/ON38E/ckE7dE5/08wpPYZBX2FFOVIfX2NB0w4WawHwFY18lA+wbggg4
         b7RlITbN2k7IHOYHjcQSE5UqHgZdo+kXyL5+eYTBGD0nuywNDrg72bR34HjWag6FC3I7
         K3TPYfmWYg//yxR7j9U9ofZKXdSZnOHUOq259EAhXADqKM07iLIBT+s3x+3je59jm4yf
         NM4zflbes0FifYbyplU+oYAj+pkMX2uIs4J/aDH0wQwDz3Jl6v45pLbeBe3IYg6kfCgW
         jxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359158; x=1734963958;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+uwMQ5mbp5Vrk2ULZzXAw8C9yBa8vGhTvRK+y8BuBwU=;
        b=uxjp+DKXXn+m/RMK9lvqIkNY1Bumu12gcjtsTQ4G4X8uzadlb4ER5kuzOL5TbGMRLU
         5Zb6WatTuhYIFm5BfqvWau/R2lTxHgj3cZzzUqKra/fcs4h5maznXu4eREtfo15EqY15
         f4Pwuszr4wM7uod9GnaLqgW0TLozauSg7GoSj26mEohdW9Q7klmBP+lpmTk2c+qAF7XD
         PWjHmXsZjrVLZDUXFmE+UJDcLT1Wn9AjdWJF84nfjICnqsTcjN6y7byMQj0Dqo4OFtN6
         iY9HmwhyTnEJ9e6WyuXu70e5hKvL45BQBpLjjAdxWp2afFsgRtGD1tN+8C8qkAJr1iec
         t6Og==
X-Forwarded-Encrypted: i=1; AJvYcCWFPwh7VtJ+JrO5FOz7ApnyhNyiuXoHzySSNa9+HCJe8YCVWw2d/9+WY6eCgztnZSgfAhpAQOubJC03vWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxmhhytj3MlR98TiWXb8swa7b4l+2mAWX2tj+CTnge+TV6fWUS
	KSnqlVZTdZCiER05rPzKNA6dcbul1rQlEzm8xbQKIZaGcqWrY+H7+v3My0W3Lantiedgw4TAAZw
	EX7U=
X-Gm-Gg: ASbGncsmFztBKyi7wBWkkJpCYa1Syfw62Q+tk3ZtxhJppe2KhpTrO7d431+hq3+nDGb
	s+YgxjQfvoGmjYC61B8PcCgw/yYoFSdT8/IXPk1GBAZXN5OEKephlXBr0MIPjMzuzLzwFO6n/Ln
	rmnx2MlMy35+oX9sshORlvuHvSvLzBIoATyxpgGlOHiMx+/Xf81sn2HJoNWywj5Dt/98l/cRMMF
	KwnvIfxFl68udx4bqu1IF0Gl3ugWBeN6wLzxWSfstt7nd6evrzI36Qhy03s39bL8y9/kI/Zaj0k
	wkfWQS/oINRX6P6lu2Hw8HJhLrJNJrbACA==
X-Google-Smtp-Source: AGHT+IHncGpnEBPdWrRT8m/ctY4+LOKeYS4Qn3fkd057u76waPa7jto9zmZUD9m0rc1xQzsMNlU6Ww==
X-Received: by 2002:a5d:4ccf:0:b0:388:c790:1dff with SMTP id ffacd0b85a97d-388c7901e0cmr6992301f8f.47.1734359156703;
        Mon, 16 Dec 2024 06:25:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b75:a430:7bc1:919b? ([2a01:e0a:982:cbb0:8b75:a430:7bc1:919b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806086dsm8227296f8f.91.2024.12.16.06.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 06:25:56 -0800 (PST)
Message-ID: <ee8d65db-5f17-4a6a-bb5d-46784edde3e6@linaro.org>
Date: Mon, 16 Dec 2024 15:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/bridge: synopsys: Fix Copyright Writing Style of
 dw-hdmi-qp
To: Andy Yan <andyshrk@163.com>, mripard@kernel.org,
 cristian.ciocaltea@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
References: <20241216101015.3726517-1-andyshrk@163.com>
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
In-Reply-To: <20241216101015.3726517-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2024 11:10, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The standard writing style should be: Co., Ltd.
> This fix the mail server warning:
> DBL_SPAM(6.50)[co.ltd:url];
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Use uppercase (C) part for consistency.
> 
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
> index 2115b8ef0bd6..72987e6c4689 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (C) Rockchip Electronics Co.Ltd
> + * Copyright (C) Rockchip Electronics Co., Ltd.
>    * Author:
>    *      Algea Cao <algea.cao@rock-chips.com>
>    */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

