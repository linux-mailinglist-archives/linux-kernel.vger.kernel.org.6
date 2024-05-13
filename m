Return-Path: <linux-kernel+bounces-177600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51508C414D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A99B1F212A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD215098F;
	Mon, 13 May 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsKui+75"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E14C5A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605209; cv=none; b=LPpNTZ74JLNToYWSKaY24mzmne7ycZYM3I/61p/+PR7G3jyWzQX3S3HPRqR2NP+1IrNEmYQaVX4MsiropqLUwuFrLP8Azr5zNkij+RoanavnAGIv9wPqQP+ZxELDGiPS5Sb2t4yAif6up48ldXVGNDywSFJsEo79mam6wiewhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605209; c=relaxed/simple;
	bh=3Gqo/UrG04D+y60/BxP37idzL+erkl38gPREiz3/7UM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=auBXu3iERl+KxKryI+J1xWsLkXe3v0JoqDOIdZsRtV+/63sk7AkwJ8vq5FgH1gaXm/vnI/FiCVAloN/AW5WD8Lo0xqAC31iCTlVNNgvIFa0hnyBaDsXc9HnrlIoNSmr0TCsL8vaC/XxBe49Rq50As2K+qzpMkawpFbaL0/4X8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsKui+75; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so13594695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715605206; x=1716210006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1epMBY+rBy1nGADNXsB5iUQZNjIZE2gCIm6O86Sn0Do=;
        b=xsKui+750+P5Y0sE+eIyhwXKFmcP+3CStCnT6JT1vhul5sK2rNfXXSwZluDx2fuCuy
         4f2cPJhNO4mv5v3o/CWlrRP91oLBv1UPAAUER6kPUlmTn5QDXtbbFf77T6dfXCYKHoJU
         11FBzXJig0TKzXpyTcdVz9EYNQBLkvFGLHUS4XTVm58FRbx6Zgc/VYDE87+kf1F8H+OV
         PhZeE8DlZx/c5/4oYBTif2L8jX7FcAc2oY+hg6EvurNMHCitfatGq0HhQd8fpnMz9Fmi
         wVti6HY9MyrDRBqjWSJbaoBcnTN8NNlol/AGXL5INMAhR0gvvyKS5HuEG8J8LmeIgONW
         e1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605206; x=1716210006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1epMBY+rBy1nGADNXsB5iUQZNjIZE2gCIm6O86Sn0Do=;
        b=dqSomvEgsm5KaV0788o+J4fPB21XKvq/Cr2RxKhouzvRff4vy3rgd/Uc8bNY+nGRZ0
         FzcTjztuf9gK9t2ynpwEBhY/u4LPIJLWklPVqSJNWeqTfkg1dN5j8IqbxzOfXUk/z0Ur
         WpUHBOhsvSEfCk7dSUInnoD8twDIwtz99+curiDqtv6blgAFDn0VUo6lVoAp08hDIBFp
         5PFn8kTcMwO70IZtN7Ayv48QjtHi23tih9Ekwsmf7FGouGWu4LMzJ4Vc+i3S1o3IXUNo
         GU9x3i9jR8fe/052AQ854EdbxChMOA+QaJgQEYty9Q634mrZvfNqnLIy7boGuskrhAtV
         Me6w==
X-Forwarded-Encrypted: i=1; AJvYcCWBIzj6Np63USvtSLMm19YRIp0G4SZx0Yi64HpMvwKEQ0SVOfEZeVbk/3xe5HZOyyj1GpNtES5eJ3vG8wwVk9NEoOPYfcxzJu7X8Si5
X-Gm-Message-State: AOJu0YwWOUsnIdZRqRKdTkOQgwV8XI3TGP1bOhF0CI743G0q5O+wAOJd
	1NPy8kqn4V2sE/D6AuvSEn1f8Xru8fQDMk96X7vMdGd9uUKU3cLjDxsQf6zh+Ok=
X-Google-Smtp-Source: AGHT+IEqW9Anfenf5bcS9e3PPYHI+ilneozDjNG8mVj5wBf68MzwXtH3l5r7qD+K+EgP0lKJhe4glQ==
X-Received: by 2002:a05:600c:3b97:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-41feac63341mr80907455e9.31.1715605205920;
        Mon, 13 May 2024 06:00:05 -0700 (PDT)
Received: from [10.91.0.73] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm161703265e9.34.2024.05.13.06.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 06:00:05 -0700 (PDT)
Message-ID: <5e6e52fb-a410-4c20-b181-b461added800@linaro.org>
Date: Mon, 13 May 2024 15:00:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/panel/lg-sw43408: mark sw43408_backlight_ops
 as static
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
 <20240510-panel-sw43408-fix-v2-2-d1ef91ee1b7d@linaro.org>
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
In-Reply-To: <20240510-panel-sw43408-fix-v2-2-d1ef91ee1b7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 23:20, Dmitry Baryshkov wrote:
> Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
> declared.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 115f4702d59f..2b3a73696dce 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
>   	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   }
>   
> -const struct backlight_ops sw43408_backlight_ops = {
> +static const struct backlight_ops sw43408_backlight_ops = {
>   	.update_status = sw43408_backlight_update_status,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

