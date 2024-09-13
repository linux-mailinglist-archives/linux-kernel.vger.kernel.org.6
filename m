Return-Path: <linux-kernel+bounces-327850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D5977BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95DF1F277E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5981BD4EA;
	Fri, 13 Sep 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUGmf3yQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F01BFE12
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218565; cv=none; b=t33ei0lQxk1EkYcoM445vfLykg+N4qft+eGv1FG5DlPRmJfdRr4Hk0CaPw/lUNTdIR8m21UYjJaPxGDu/1KHw86HaaOhNM912cpMane6o1VSJjdmj+5TqaBTyyx8J13ZO+PSSxOc9gDmfXehdAHcMfzWhtuJ8JRI/O8fwfNaMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218565; c=relaxed/simple;
	bh=VR77kTkSj9mtdPER9rfxtV81rr43X9QpLa8jlgRjBCw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z8l3YoicV3S7ayDDynIg06SYVawGrEjHB2+fS9uA0PzPLWOCkke07riFYAB0LJ1fDDWN7k1Ov/L6m/mgqnG1HJC+hybV1pM7wGVgFTz1BSx45ZVrzIaL0C/Y+h/3zxkgXeNNZCg0zQ+MtWUCtXLE2Bz2fBQA2Tst9Y+x1V18N7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUGmf3yQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so18189855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726218562; x=1726823362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Px7P8vUhtcnumZBZibQpbbgvjXBl3y0kO8YYM/2s24=;
        b=yUGmf3yQ8M6ILX9AJdsG5SyFOqAjjy2ICS+gKubVl2kf+2G/sWfj/BIblGt1BgQFZM
         Rp0i3X50dVhT7TbIsAeZpYUIptqsmRBlR5pjbR6Bg5Tmfv/Wo/uS1dPDMwT+7EWHPoqW
         ++c8JlndyvWTLpULRqrR/uXWuOLQcZaZNxVTLbLAXnRd40xkDuD+6VYwSQZpdJxQ1A4U
         o+ekITT9C//i4YI4Gw1VqiILyx/crH+B00QfYuOGkAQ8JgAtTViTi/YpeOTOmux0X1O1
         cB/fFRL6QGCWCKsIijtJwDUndUY5/+SFjhq3EmAEmOIjumS9AqKawIIzBMTuN+rBCAZn
         riHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218562; x=1726823362;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Px7P8vUhtcnumZBZibQpbbgvjXBl3y0kO8YYM/2s24=;
        b=ZQNchFnvR1walvXmfEJj6R3ZhefNKKkQaNBH21cv/npCyMubMdnpTdCri1p/hx/rbK
         ltZJsNBwfEAtjMzxFkbuHBWZ1MjU1Wn+uaAMGiHcLD//OtJ2V1iQVaTSfZgBefEgOAOq
         B3YsilolK+De1/cUzP65MOJlIXMvkIpJ9+ewMyXAWDbEzVoaJrtnrWHR955SMSYYG3yj
         7odG3FyYM3n9dP3dWs/UCOobKecyEVHWCDN/4JMctjs3IhdaNKEOhA3FX5RqaEhhJZEg
         0sP+4zPRlVFyzxvxFRZ9Lzw9HgQer+P/ePXZmfh3uZEcvSR0st6je5iiKyQBQ7Ii36Uv
         KSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/JN89gIAW9+NghcAsSLNUJPBKOsSJ/oMGeC69BX4SnDzd9mDdcGSFJJZ8+ohQlQs6gr3KR8wtbxue7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvYtyn/D259DezLd1qWAdgRC91jn6JYQlxlP44b8bedHv7BSU
	cQTjd7TWZ6liArCSFawzjFa+ukRLjZvPI/jG3NcdRVpWmctCK1KYow9VWxdgcTY=
X-Google-Smtp-Source: AGHT+IH7SyOewl5IXKTi3cewOPHM7wrZGefNZMT6Npms0fzQJ1acd3Jey9j4PucxqZTn0IAqCKo78g==
X-Received: by 2002:a7b:c386:0:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-42cdb67b16bmr40882295e9.12.1726218561024;
        Fri, 13 Sep 2024 02:09:21 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b18202fsm17354465e9.42.2024.09.13.02.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:09:20 -0700 (PDT)
Message-ID: <e6d37d13-a150-468f-93c8-f8109996b974@linaro.org>
Date: Fri, 13 Sep 2024 11:09:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: panel: nt36523: use devm_mipi_dsi_* function to
 register and attach dsi
To: Jianhua Lu <lujianhua000@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240904142907.367786-1-lujianhua000@gmail.com>
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
In-Reply-To: <20240904142907.367786-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 16:29, Jianhua Lu wrote:
> Switch to devm_mipi_dsi_* function, we don't need to detach and
> unregister dsi manually any more.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index 18bd2ee71201..04f1d2676c78 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -1095,18 +1095,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
>   static void nt36523_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret = mipi_dsi_detach(pinfo->dsi[0]);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "failed to detach from DSI0 host: %d\n", ret);
> -
> -	if (pinfo->desc->is_dual_dsi) {
> -		ret = mipi_dsi_detach(pinfo->dsi[1]);
> -		if (ret < 0)
> -			dev_err(&pinfo->dsi[1]->dev, "failed to detach from DSI1 host: %d\n", ret);
> -		mipi_dsi_device_unregister(pinfo->dsi[1]);
> -	}
>   
>   	drm_panel_remove(&pinfo->panel);
>   }
> @@ -1251,7 +1239,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>   		if (!dsi1_host)
>   			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
>   
> -		pinfo->dsi[1] = mipi_dsi_device_register_full(dsi1_host, info);
> +		pinfo->dsi[1] = devm_mipi_dsi_device_register_full(dev, dsi1_host, info);
>   		if (IS_ERR(pinfo->dsi[1])) {
>   			dev_err(dev, "cannot get secondary DSI device\n");
>   			return PTR_ERR(pinfo->dsi[1]);
> @@ -1288,7 +1276,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>   		pinfo->dsi[i]->format = pinfo->desc->format;
>   		pinfo->dsi[i]->mode_flags = pinfo->desc->mode_flags;
>   
> -		ret = mipi_dsi_attach(pinfo->dsi[i]);
> +		ret = devm_mipi_dsi_attach(dev, pinfo->dsi[i]);
>   		if (ret < 0)
>   			return dev_err_probe(dev, ret, "cannot attach to DSI%d host.\n", i);
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

