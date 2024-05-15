Return-Path: <linux-kernel+bounces-180375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37938C6DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C3282953
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69F15B14D;
	Wed, 15 May 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd1D5djc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1015B134
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807764; cv=none; b=PKFqP0orzthVMP2KM0szpro0Qj5H74/pW0l54ci7sauOrmXJ8F9tXgDkzNkl+ny3B4bp5wjd6ZznyBuM+XIGHC22jEeK23H/hW07YJrGEs1gz/g02liAYmz9sSdkEW/3FmDNmHkk5ENdw1SZJEAo2IcCqpq/pnmSw7JW0ElYRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807764; c=relaxed/simple;
	bh=RC4DoAj+zRcOiumG0vEuz7g6nQu/R4r/eyjzhbegJEs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y81e+Z1ROj37vjLr6CdOBO4usIOtxqItJku/t9FSg7zK5UcICHiuAVvxZi7JEdmoJxvkRO/4VByQxomWxZgX+IIEkB43bHJuU5r1Ygk37opYERnzjdjJr2rUrijhrvrOaB81viM7KKlyYRlWfo/Rw7pjxfrEASCMsdoyAGxccKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dd1D5djc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34ef66c0178so4956853f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715807761; x=1716412561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypQ5i7zn3O21lrbNCHNY91mwYYndLzCRxfIgm5nCfGQ=;
        b=dd1D5djcLEPNE8Xau0SyyrZSkytcDp8tMtECkSJTuI7Fcd8gM/WaI+SmdCda2o8bL8
         hXLnL8wkdWafrlCy+/qhhp1plSiFpWg5ZtG7co0UTC5ySpUkewXUlf5hTsDtXM/6v1L7
         CXrk4Dp/nTKQDzq0V6hCKKTV1wcUaRglclMSEGx7BQZUVwvy+LjXDoi0BWo9g9Nc1Wm9
         UvH4ok7rPw9vfOgcyHRprgbYMY3VK6QOLa8oQ8kvGmJRM1Fl3CtBabl2GeCvMvG01DAX
         CHHNICeYtfKOGagcQlCizUiBtcMKEWu/uJmnxsUQQ6VHNY0IBut1gEI0vn6VuysGm//g
         /4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807761; x=1716412561;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ypQ5i7zn3O21lrbNCHNY91mwYYndLzCRxfIgm5nCfGQ=;
        b=mJDUuOT/WyYt/MLjcgICwgZWqi3T6iKL4mQ9GcU/mJtkhhL59pxFL4Kt2JeXPi7Kqc
         J5RE7MSvgYhkMawN1Ii/fZUQpHsQnzPoIYYHCqTBR5JugOhKm7d/357c6DYevFqrMlk+
         yYwn/lISudjSzG1CDt3txOvHCoYIGTPHaIhKbFMavsEfkz3ookNcEG+djt6DkmLKsiNf
         AbizKK75J7TmG9tfLRR3sGndF32IezHxezA9CI3txUHbb0D7j1w/NfChX4GcHVVmqi2U
         8Wvf2HMifvRZJmgxC3Qq2hDUWfwRULz0nC3nqmE8PrY3wgxc/A7QTUgZvpYORVr0XsY5
         mN/g==
X-Forwarded-Encrypted: i=1; AJvYcCVsPVdNhVvmWEsc4BIotjPjITWo+xXIXP/cTPRy2B7QctCEG38FnZnN88/SJR9siuPqjpT1pPHUHl0pgrdYqGXuqKi0CV2/Cq2G1MNE
X-Gm-Message-State: AOJu0YxMdivYN9RtwwrOMnL9N+fiYXs8yWn9cXuFrzGfAO48ScFPxndV
	S9fxHnGSz+DY9RQTQgVrzH9vZAO8t2MQdY6tkKvnAT2ZcJ0eWiC2t/CF99kGpkA=
X-Google-Smtp-Source: AGHT+IGgcTqIf5m/0zVxc5RASNVotZp2IA/3mSrwEWRVdJbbedxdDEmum4mS9MjHSIt3r+bMIZ6N1A==
X-Received: by 2002:adf:e586:0:b0:34f:3293:85c6 with SMTP id ffacd0b85a97d-3504a96b7c9mr18524413f8f.64.1715807761057;
        Wed, 15 May 2024 14:16:01 -0700 (PDT)
Received: from [10.1.2.176] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be1dsm17462785f8f.10.2024.05.15.14.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:16:00 -0700 (PDT)
Message-ID: <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org>
Date: Wed, 15 May 2024 23:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org,
 daniel@ffwll.ch, dianders@chromium.org, linus.walleij@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 airlied@gmail.com
Cc: dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuxinxiong@huaqin.corp-partner.google.com
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
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
In-Reply-To: <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/05/2024 03:46, Cong Yang wrote:
> DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL6.
> Since the arm64 defconfig had the BOE panel driver enabled, let's also
> enable the himax driver.
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2c30d617e180..687c86ddaece 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
>   CONFIG_DRM_PANEL_LVDS=m
>   CONFIG_DRM_PANEL_SIMPLE=m
>   CONFIG_DRM_PANEL_EDP=m
> +CONFIG_DRM_PANEL_HIMAX_HX83102=m
>   CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
>   CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
>   CONFIG_DRM_PANEL_RAYDIUM_RM67191=m

You should probably sent this one separately since only an ARM SoC maintainer
can apply this, probably via the qcom tree.

Thanks,
Neil

