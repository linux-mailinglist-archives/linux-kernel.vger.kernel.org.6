Return-Path: <linux-kernel+bounces-292390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E63956EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE561F21E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4661FD8;
	Mon, 19 Aug 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxhA9Cai"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4863130A47
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081678; cv=none; b=MMwbNXiIK0tzYRnyle8BmjE735xFvwjs5s/MeXyCgK7cWSO3gWERBbMKYBLphLL0MZUAnEq9YI9yYrjmqGy6fr5Z7uhjASxxqX+12pnPIy94lM12eF1mV8PHZjhT0lvxBHz9POkAJrq4UguuOa5kna3HkCUk1hbLIac1r6K0ahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081678; c=relaxed/simple;
	bh=vFK6mS+nLXf2sGh7/qlObNntnQ4WrsEQazNrAdt1yNs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Yj3Hus6NIFd7olCJKO+YzAZ2Hj9FwzfyNZfg247yiGGdxl7PejWnCSD+qfLB+CvkDH0Ga/hEA5hznDsxpq2KJZhluYS7idr1cH/3jQxbFgLa3smxUbxViKqp5t9a4K4/l6ScFGgQQn+1e8QTwO6QqwQyXlChp1Hroe9J27ueCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxhA9Cai; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37195f88a17so2188639f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724081675; x=1724686475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gELSb0mONNzrVXHjZTppbBGkLEu9pviFKrK4IGH6TKs=;
        b=xxhA9CaiOfwJTM2RKP87SMIH/TDSkfX9PC0D4n/s93o9p3u7jEEDvISQ14S+oAi8xH
         C19O3re5oHP6NOb4Shwy4Ng6qv7tth9gpB/hmPrnr/u06HSCAyGRZWvjveJoYSuAIfTW
         bDkrcEM9IGIrpY1Vi60a3F2VEdDUuT7BLbrAzsKn64gToz2h7tX3XrKL8NG+znkNA4FA
         cKslM3bMjx3h/fsrOEEV1/8bTXtQSV0FZEpbplRBTHaO036yijkJB2nezasXMMt4/1u/
         aC4uMAiR8KsR9Vyib0Gs9qiRtmV0SLcWs/dgvPjD2G0ALS9FhkFxbdoYcbZ7karx7kLn
         kbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724081675; x=1724686475;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gELSb0mONNzrVXHjZTppbBGkLEu9pviFKrK4IGH6TKs=;
        b=JUrJMj/37L87wjo9rS1QPuwnHcBdkR9iy5KeME2/DbywMlLl5kId52K90MPLdFcYjx
         r2/Ow780X2/v3O6rn1AzmP8FGvDZ888cAIOgQXuowJ1fgfRCgULBO+0KmRvSS+nwbGmW
         VEPQzcQ2pGmmgWz8c/mTrZ8vFTfJgLRrbvErMVrZdJJH8g5QaQQ6ps42803TfTpLVgpl
         OzTTiC8Hv6NhTNQ7ti7tfZFLWFRg3YJis0bnuJ01PkRlJpK+v5ERV7DE1nGpVRNx2eMn
         Vky8mnaTVgNyLatMXm0HBjxckhGp3vXmuh1lenyLhHLy5+IO2sDqkCEvDS9wzibh+Pni
         F6tA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOW4mkIo1cxnrX46RQ4suYqg49Y5SP1GoVASiMyFBllZAhtqTKd6AN6eQH/QpC71jTMXD5/PvQgOylppbqhxwFtJB4kZdU8ZNxfXX
X-Gm-Message-State: AOJu0YwZnRdHrY1+XZFPa5z8kH80tj5KOlX7LYf/3VykOA2ORBL3x42V
	qkJqfDgpDTV3TptG0GATwGZwUstpgAoG5zkoSGFAetjoJk7KeRzcI9AQqBoJk0I=
X-Google-Smtp-Source: AGHT+IHMaUUYq+Edi91ZeQKQp/ozhDLsN2BfvaefQx6mMZkbY2NlgErzK4DrnNKPD89uUTge96ByFw==
X-Received: by 2002:a05:6000:1112:b0:371:728e:d000 with SMTP id ffacd0b85a97d-3719431768fmr6655547f8f.1.1724081674040;
        Mon, 19 Aug 2024 08:34:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945b8sm114207095e9.44.2024.08.19.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:34:33 -0700 (PDT)
Message-ID: <cd53b240-0db6-4d27-85d6-e2004086fd29@linaro.org>
Date: Mon, 19 Aug 2024 17:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH -next 6/8] drm/panel: khadas-ts050: Make ts050_panel_data
 and ts050v2_panel_data static
To: Jinjie Ruan <ruanjinjie@huawei.com>, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240819120043.3884933-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20240819120043.3884933-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 14:00, Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/gpu/drm/panel/panel-khadas-ts050.c:620:32: warning:
> 	symbol 'ts050_panel_data' was not declared. Should it be static?
> 
> drivers/gpu/drm/panel/panel-khadas-ts050.c:625:32: warning:
> 	symbol 'ts050v2_panel_data' was not declared. Should it be static?
> 
> These symbols are not used outside panel-khadas-ts050.c, so marks them static.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/gpu/drm/panel/panel-khadas-ts050.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> index 14932cb3defc..0e5e8e57bd1e 100644
> --- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> @@ -617,12 +617,12 @@ static const struct khadas_ts050_panel_cmd ts050_init_code[] = {
>   	{0xd4, {0x04}, 0x01}, /* RGBMIPICTRL: VSYNC front porch = 4 */
>   };
>   
> -struct khadas_ts050_panel_data ts050_panel_data = {
> +static struct khadas_ts050_panel_data ts050_panel_data = {
>   	.init_code = (struct khadas_ts050_panel_cmd *)ts050_init_code,
>   	.len = ARRAY_SIZE(ts050_init_code)
>   };
>   
> -struct khadas_ts050_panel_data ts050v2_panel_data = {
> +static struct khadas_ts050_panel_data ts050v2_panel_data = {
>   	.init_code = (struct khadas_ts050_panel_cmd *)ts050v2_init_code,
>   	.len = ARRAY_SIZE(ts050v2_init_code)
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

