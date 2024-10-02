Return-Path: <linux-kernel+bounces-347394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8398D21A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BB21F20FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E81E767D;
	Wed,  2 Oct 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1kGF+I3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2C1E7646
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867965; cv=none; b=UgR/Cb1O6UZjVENVCUuU1gqIVC4M11s55LGulQkHGsShSRDc4bupfTJDASvsQAHAnzGRPUs2TAP3zx7wdfz2XqJkFA2B6IJESKLxmDn32e/tsAjrRZeZHGv1yZ25btJNroWuxeyvH/Z51MxdEdqc8V7+IciZSNbiXh8ijeiGf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867965; c=relaxed/simple;
	bh=OrAZ1lWPi+MNrIsKsawNVu6c4AFjpaXYoTkxPw3htK4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cAIrxCklMKOlQh9ft4lsh4XggpsCBax807O60YH6HRtRkNpLb9mqhZCY5yMGQXYL2e3JgIet7WDI2o6Jd1PY3rsxqKz4BBQ83rJFIT66PJB/RIrGPtogMAH9V+tyQF1xJbjZWiiQmFCPN+wApWmlumlB5sc79yGcYqkUvl+lf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1kGF+I3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so51908135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727867962; x=1728472762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i54V2W+uXkFgB9Ou9jQMsgfLBOlkoO/smYJXTkkpl4=;
        b=L1kGF+I3HBVcvOj5YoEpX2QrgoQYWhcSEDozs8sfKsA6svvDL92Hd5dm0HWopk6pFv
         elyySYWLyJjsMxkE67UjFIvTAlGV6rPvBgKe22JWZa1O9H96SagbFQ79toOCLc/OKM6L
         OZJKuE81kZAxySZlzwpDarIZVgUlYUxRQ7LndKFy5cM8RSiDyefC+lL+qjmuDu+Ck7S8
         ih0Juv3q1gnzmJeX/aIUf8WiT4tun8ugLxe60NbZ5nboOR+aJFovXZ9TElVf7FOlL6Em
         3Hm3wQFIcmTmrMVUEZxTiSZK560RKbxHL3UAF9F06005tB1mfu7FeqfJ8K1GQIneTCSd
         BILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867962; x=1728472762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3i54V2W+uXkFgB9Ou9jQMsgfLBOlkoO/smYJXTkkpl4=;
        b=L8btl9pcsVRkm3sJGrJr2E6qiS+WGNfHPT0548er6Pd9I++LyKrJK43aE93vciD5oW
         joluJvmK9Avwzy606H4TEP5RMfaYSCf8OAKw0eqsNQOoZQWGVQ/OJOdoS02e3brWMeGP
         w/Lv8lYigsXB+iKGlD9YumaTVa2+v7rq5Z09YkvLw8POyxaMmK8bxpK2fX0SjbVNXnpP
         tuNWeIhYz8XvVFTyGaWPbuhl6ZUGAZaRZbwDCy6dmcPePBjkN4S+s+iY3REoD6DN4rtp
         LTAw19tW3vsyR9o8HE5d5GTz7PXWkwLK714o4LrueTvbjSVGf124Ny8iZZdyoqYnXmqP
         D0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3BKncb8h1svCCNdXDbY+ZXt9qnKnt/tyPuBrHDAcyBUjm5XBQGF9tmOeG5WOZcEX5xDygv7HPQNKiIRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4fZoo9CIxcswOA7NuxHPEaCdpnTObiGCEAEj5krDQfwcWU2D
	eYdl9rNqLTBI0VeTun56JbpHMQpptoj1s5qN+u5h7bYu1ah9Ulaa7B6WTv63deM=
X-Google-Smtp-Source: AGHT+IFwLX5vDjib7l0jy9dr5jnloJXwSQLCI8cwlDoF7zBepF5qscW8k9L2WjCUqPM3IGJNEoAqmg==
X-Received: by 2002:a05:600c:5123:b0:42c:b22e:fc23 with SMTP id 5b1f17b1804b1-42f777c1a4emr17884125e9.15.1727867961754;
        Wed, 02 Oct 2024 04:19:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce64:813c:ca8:36b5? ([2a01:e0a:982:cbb0:ce64:813c:ca8:36b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cfe30a3b4sm1134982f8f.13.2024.10.02.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 04:19:21 -0700 (PDT)
Message-ID: <7a12280a-a7a8-4b5a-b085-90b7fe1728fe@linaro.org>
Date: Wed, 2 Oct 2024 13:19:20 +0200
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
To: Maxime Ripard <mripard@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>
Cc: Yao Zi <ziyao@disroot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001210403.43535-2-ziyao@disroot.org>
 <20241001210403.43535-3-ziyao@disroot.org>
 <28bd30a6-127d-48f0-8e32-703ebd8f69b6@linaro.org>
 <20241002-vengeful-vivacious-salamander-cdc9f7@houat>
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
In-Reply-To: <20241002-vengeful-vivacious-salamander-cdc9f7@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 02/10/2024 13:02, Maxime Ripard wrote:
> + Jocelyn
> 
> On Wed, Oct 02, 2024 at 09:59:57AM GMT, Neil Armstrong wrote:
>>> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
>>> index b43ac61201f3..b2def784c00d 100644
>>> --- a/drivers/gpu/drm/meson/meson_plane.c
>>> +++ b/drivers/gpu/drm/meson/meson_plane.c
>>> @@ -20,6 +20,8 @@
>>>    #include <drm/drm_framebuffer.h>
>>>    #include <drm/drm_gem_atomic_helper.h>
>>>    #include <drm/drm_gem_dma_helper.h>
>>> +#include <drm/drm_gem_framebuffer_helper.h>
>>> +#include <drm/drm_panic.h>
>>>    #include "meson_plane.h"
>>>    #include "meson_registers.h"
>>> @@ -419,10 +421,49 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
>>>    	priv->viu.osd1_enabled = false;
>>>    }
>>> +static int meson_plane_get_scanout_buffer(struct drm_plane *plane,
>>> +					  struct drm_scanout_buffer *sb)
>>> +{
>>> +	struct meson_plane *meson_plane = to_meson_plane(plane);
>>> +	struct meson_drm *priv = meson_plane->priv;
>>> +	struct drm_framebuffer *fb;
>>> +
>>> +	if (!meson_plane->enabled)
>>> +		return -ENODEV;
>>> +
>>> +	if (priv->viu.osd1_afbcd) {
>>> +		if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
>>
>> This should be meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)
>>
>> You should call:
>>
>> 			if (priv->afbcd.ops) {
>> 				priv->afbcd.ops->reset(priv);
>> 				priv->afbcd.ops->disable(priv);
>> 			}
> 
> I'm not sure it's a good idea. This code is run in the panic path, and
> it comes with strict requirements that these functions don't have.
> 
> It'll be incredibly easy to add a sleeping call or a lock in there.
> 
> On a more fundamental level, I'm not sure we should be disableing AFBC
> at all. Do we even have the guarantee that the buffer is large enough to
> hold XRGB8888 pixels?

Yes it does, "compressed" is in he way pixels are ordered in memory, meaning
it will be faster to scanout when the image is simple, but with a fully random
image the buffer will be larger.

But per my comment, AFBC is really only used on Android producst since it requires
DRM_FORMAT_XBGR8888, so the best is to bail out when AFBC is enabled.

Neil

> 
> Maxime


