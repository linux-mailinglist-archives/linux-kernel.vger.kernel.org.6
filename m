Return-Path: <linux-kernel+bounces-347130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F9298CE49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2192828FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C01946B3;
	Wed,  2 Oct 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WScy/tAV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7041946B1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856002; cv=none; b=EGvmX4AWB135kDUPgof9Q+O4yt33k/kEtN/f4SMSdGZhVEf9Nsrc25+JFiNMpYlWjXYVmDJwxzd5Cn2bi+hyY4HJSEtmDfRgeI9NZ8CyR4qjG0SWJ8qyU4YdUgw57JR1GX1rOiBJV+draEwKjXEOxKBw2ftDoqS6iE7JqGHh3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856002; c=relaxed/simple;
	bh=MKTE1BRkUWSVF8zAQUwq5NGl1RfglMFBapTDM4Cy8KY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZccAJN/rRJnaUnt5gRxUI43xqM6SQIMLeNX/0gPmytt7N+8UB4gmGeKHVkUAkBZpzZFtFTKHr7ziVBnlagjiA09u2yPlzG6/+Xf/AjH7LoInmel6vB/ZTxPvDCGJFWQkvtoBKNh0tB/e9WX+l1tRaizQ6+349x+g18Y9oh4mAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WScy/tAV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so52413085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727855999; x=1728460799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk36fzw0YT52nfRYTy2hTk/tDp/muE/KVbNF37jTxxU=;
        b=WScy/tAVq1XlHXDIF3lK5iz5UbGi7OZdgnhQx0ZEA1U1JDtmy93TEwQkpKHJhLA8hh
         31sI5oSHU0cbm09WiDjXm0Ccbut3GDTfxXakfN3+UgAiH1IiOs1MFaawt59emDQhdpZ2
         Ykddh5Ql/j2/jww84JUBlsNMiZtRUqNmKkCipTsfDWTGNiQSb0CIxygI5uujhiIjxvP4
         qcVKKfKUbR3ZA06YU/9iPWjgSemp2t3IAwsiz/TlqeLkbGhN06H98Rk8cxpTsHIX3tnO
         nYYa2yQT3TAQK7Uk8Qr/PbuCpTHgZ8VJX1C94X2I98zVVrK5rN9NyPHRXJnRR8IY+lYy
         lK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855999; x=1728460799;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xk36fzw0YT52nfRYTy2hTk/tDp/muE/KVbNF37jTxxU=;
        b=dZv+va/69lDU7u9+NKUoHMW83G28o8HrbFfQj3tKmbA43DyWKJYEsHnzy5dxgAFVdW
         tTJCeEelLTd7swskdIKIBjtpOpOgvMEJW3Pk5+zP8KPbXE4stGH9blxW/HAYNCcLPBwF
         6sBMbUW8OvhYlPvZfceItMz+AcUQpxl38P5L0m1FduDybFB7hjTgFW57DuwB4B7/H9uW
         /WWfnlPhAa/SEl1Blk6S7dPzCb9azn0TVl81jP+LnDV70gkHn/BN8vpJ3euwH9GEC8kM
         F6ukdrwUhDnbueXi/fI6fnAihrR7LUaaGHQiFVI0zTJxcCThqJgbLq/zKmcon4UMb2X9
         MWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkRcoTjxB+IH8ESgw+S5pG8TN/30OYOTaJ9i3i9KP46ri81v8XNX4fB3DuvGJma4b+66TxVjFWHYxV+tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1LzTBOZWvPg0Nn/7kYwfVn+7Dueuf6On+7c/Om2aj9cz8JZO
	BKDVVl+knewlFD9n615j5jcGfNdUnc/3JC9JaoPnx7CxRelRZIgYaZPIc2vGYtU=
X-Google-Smtp-Source: AGHT+IGKDKFtK+6fH5XIgbOvtCDoASExF6yro64LLD9/n6AiA+9+PdHbwnZGFcD5lVYNEj7sJ1M04Q==
X-Received: by 2002:a05:600c:1c04:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42f778f13d3mr16004595e9.32.1727855999245;
        Wed, 02 Oct 2024 00:59:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce64:813c:ca8:36b5? ([2a01:e0a:982:cbb0:ce64:813c:ca8:36b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79db1de9sm11469325e9.5.2024.10.02.00.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:59:58 -0700 (PDT)
Message-ID: <28bd30a6-127d-48f0-8e32-703ebd8f69b6@linaro.org>
Date: Wed, 2 Oct 2024 09:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 1/1] drm/meson: Support drm_panic
To: Yao Zi <ziyao@disroot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001210403.43535-2-ziyao@disroot.org>
 <20241001210403.43535-3-ziyao@disroot.org>
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
In-Reply-To: <20241001210403.43535-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi !

On 01/10/2024 23:04, Yao Zi wrote:
> This patch implements drm_plane_helper_funcs.get_scanout_buffer for
> primary plane, enabling meson-drm to work with drm_panic.
> 
> This implementation tries to use current framebuffer as scanout buffer.
> In case of AFBC enabled, we disable the decoder path and adjust OSD1
> parameters in get_scanout_buffer to make the buffer linear.
> 
> Tested on TTY and Wayland session (Sway).

Thanks for enabling this!

> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   drivers/gpu/drm/meson/meson_plane.c | 47 +++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index b43ac61201f3..b2def784c00d 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -20,6 +20,8 @@
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_panic.h>
>   
>   #include "meson_plane.h"
>   #include "meson_registers.h"
> @@ -419,10 +421,49 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
>   	priv->viu.osd1_enabled = false;
>   }
>   
> +static int meson_plane_get_scanout_buffer(struct drm_plane *plane,
> +					  struct drm_scanout_buffer *sb)
> +{
> +	struct meson_plane *meson_plane = to_meson_plane(plane);
> +	struct meson_drm *priv = meson_plane->priv;
> +	struct drm_framebuffer *fb;
> +
> +	if (!meson_plane->enabled)
> +		return -ENODEV;
> +
> +	if (priv->viu.osd1_afbcd) {
> +		if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {

This should be meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)

You should call:

			if (priv->afbcd.ops) {
				priv->afbcd.ops->reset(priv);
				priv->afbcd.ops->disable(priv);
			}

> +			writel_relaxed(0, priv->io_base +
> +					  _REG(VIU_OSD1_BLK1_CFG_W4));
> +			writel_relaxed(0, priv->io_base +
> +					  _REG(VIU_OSD1_BLK2_CFG_W4));
> +			writel_bits_relaxed(OSD_ENDIANNESS_LE, OSD_ENDIANNESS_LE,
> +					    priv->io_base +
> +					    _REG(VIU_OSD1_BLK0_CFG_W0));

This won't work, drop it, the canvas isn't correctly configured, you should instead call:
			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
					    priv->viu.osd1_addr,
					    priv->viu.osd1_stride,
					    priv->viu.osd1_height,
					    MESON_CANVAS_WRAP_NONE,
					    MESON_CANVAS_BLKMODE_LINEAR, 0);

> +			meson_viu_g12a_disable_osd1_afbc(priv);
> +		} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {

And here meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)

> +			writel_bits_relaxed(OSD_DPATH_MALI_AFBCD, 0,
> +					    priv->io_base +
> +					    _REG(VIU_OSD1_CTRL_STAT2));

Ok, you should also call meson_canvas_config()

You should call:

			if (priv->afbcd.ops) {
				priv->afbcd.ops->reset(priv);
				priv->afbcd.ops->disable(priv);
			}

> +			meson_viu_gxm_disable_osd1_afbc(priv);
> +		}
> +	}

I thing the code should look like:

if (priv->viu.osd1_afbcd) {
	meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
			    priv->viu.osd1_addr,
			    priv->viu.osd1_stride,
			    priv->viu.osd1_height,
			    MESON_CANVAS_WRAP_NONE,
			    MESON_CANVAS_BLKMODE_LINEAR, 0);

	if (priv->afbcd.ops) {
		priv->afbcd.ops->reset(priv);
		priv->afbcd.ops->disable(priv);
	}

	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
		writel_bits_relaxed(OSD_ENDIANNESS_LE, OSD_ENDIANNESS_LE,
				    priv->io_base +
				    _REG(VIU_OSD1_BLK0_CFG_W0));
		meson_viu_g12a_disable_osd1_afbc(priv);
	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
		writel_bits_relaxed(OSD_DPATH_MALI_AFBCD, 0,
				    priv->io_base +
				    _REG(VIU_OSD1_CTRL_STAT2));
		meson_viu_gxm_disable_osd1_afbc(priv);
	}
}

AFBC is quite hard to test since it requires DRM_FORMAT_XBGR8888, but
I think sway should perhaps support it, Mesa should also support AFBC.

At some point I made some memory dumps of AFBC buffers, perhaps they could
be useful here.

Another way would be to simply ignore the AFBC case, and bail out since
it would be a very rare case.

> +
> +	fb = plane->state->fb;
> +	sb->format	= fb->format;
> +	sb->width	= fb->width;
> +	sb->height	= fb->height;
> +	sb->pitch[0]	= fb->pitches[0];
> +	drm_gem_fb_vmap(fb, sb->map, NULL);
> +
> +	return 0;
> +}
> +
>   static const struct drm_plane_helper_funcs meson_plane_helper_funcs = {
> -	.atomic_check	= meson_plane_atomic_check,
> -	.atomic_disable	= meson_plane_atomic_disable,
> -	.atomic_update	= meson_plane_atomic_update,
> +	.atomic_check		= meson_plane_atomic_check,
> +	.atomic_disable		= meson_plane_atomic_disable,
> +	.atomic_update		= meson_plane_atomic_update,
> +	.get_scanout_buffer	= meson_plane_get_scanout_buffer,
>   };
>   
>   static bool meson_plane_format_mod_supported(struct drm_plane *plane,

Thanks,
Neil

