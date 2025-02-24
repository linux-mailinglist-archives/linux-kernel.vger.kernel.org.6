Return-Path: <linux-kernel+bounces-528424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51581A41792
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54073AC355
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41921A7045;
	Mon, 24 Feb 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RolAwdSA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AEE1991BB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386347; cv=none; b=DYN+of2muwtjjOIVqxq6oBVYvqNp4B9l8oYfXiakF8//vnFEShGuwUrODL2IsMFw910AmPz3opA3IC3fAFSpvvzn5QV+oA43bzhDe2GPfFeADBoSN8ya4EYAKup4x1TujUaDfDOpzgZOhgHoSj9iiDiHUBiCLW68e3IZpk8nb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386347; c=relaxed/simple;
	bh=DgXuInIetqyl3CHQ2oL3QcDvsgktAaByQyVi+3OmYIA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=FaAx/pgugyByWMqsx4f7YnnXdMs75ooqX8vw0Vs/bQKQOsFZrLkvzxWpC4bWu68ZEJ5S8LJOcRKzgn0M0Jo7r2QrxuB52z4lw43koDYD+bIHDDZ83JI4EfcZ8vUCXMIV6G9dAH6qpgLS0kjpZi2/Cr6SM4f11oHA6L8UKphcbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RolAwdSA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so23588865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740386344; x=1740991144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sK3C+y9SW9Coh39Uk8y+GEOLM7p3ebzwSbAot9WE95s=;
        b=RolAwdSAIKLdowIIg5ftr63yKG4eHxljmeTNusR/FqFfD3COAzYu3OekaAupHvzroM
         yKqTzbO8oKf6JiR+DpnU/EKfDWh0cflnmemhOnXOyXumGzEC+AP/mOLGwjNXVMH4rdt0
         Rkr33LcwthNEZvWCtCm1NxuXIjWxlKu0nPdfjxkF6QTuz2UdrTjStvUt2uFPIHPpUT68
         Kh3gzAmllBwYk9S5RFI0XjdypAWoMEOwVnJqLCYzrVSDtsQsMwSmcwz8zvuuh7gAOU8j
         24mvLMV+8AwFIfn8uSTyXa/2yU05vjTKko27gi5kW7lSn5BcYr0nEmCgJ8G3GSftW4Df
         9Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386344; x=1740991144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sK3C+y9SW9Coh39Uk8y+GEOLM7p3ebzwSbAot9WE95s=;
        b=CUCEmX3wND5k3FyhQIGcDBhfDQO/b7zPY7w0F2AuzBX+Ldm0Q6Nnbzkcvj0i+BUJIM
         +Ywz4rjPcfUuJeAyAe/6nbdeyAQYwe4bODHZr0t5TWXvU+0jEV4WRR0DjnnWChdenxwc
         YIFKUPGiRuQ5pnbuqBaKQAZJJJf08dnLNZSlSkl9ETsyUFOEUrTFvXEXDxTk+Jnqb2UG
         ECSv8R5aq8KtLjHr2lns1isZubvheMX2Ht2Q5O4rv5I/N8M71U7Pgly3PvckivsfJl2D
         dGHAbyt4MO1xEqDE13ycwXycz8MEaR/e9Hw33rCPuX0Wy5LBl4kx0OALh2tE1g/s8I2c
         yS5g==
X-Forwarded-Encrypted: i=1; AJvYcCV/LjQ6ZjltvuUmDCmBWRXaavaSyPJGFvYdV9U1l/MbloUaTjZlUlWnFee1GBzIn9zXntgH2yDAVuy2smM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhVGWuP9zdWx3bl7q+C/zw8lnAWaMwxx0gBgizpVilHngbvi/
	GJ+U1GsUSAzRlWeS163v0b847mZ1A0mwFSNMyfiyLrn54KuHaKKxbhBxk+xryv8=
X-Gm-Gg: ASbGnctppKL3q08dmDe9HcwrjTqmoeoNtfd8I24ZBla7DYEONAQv0jwVFYZl0YRvMeV
	70g0/ejTD4bDiwrbkPtJYwzyJFTBFW9k6tf+J7dgfrFoXzunsedGuzYVSTlV1KhcnKSWrHME93o
	S0mgyg9if2vvNYaxVKkm4zKET/Q/Hz9upTsS4yXoaYp8yApOLkryhO+mVa8W1M1u9khSbtKEY7X
	Xm/QTkWQIR3ydXLZd5TuUz7V9L2h1CFUR+WJR/ghGxEZz9KzQIBmW4n4d6bwVfsgQtmSmLy5UG5
	t6tmH6wgnmppr3Af1y+j8Vm9PTid9urmqfAF7L5PO0LII78/uDkMJ9T25iV2mCFxdKfn9fZqHXm
	PJSI=
X-Google-Smtp-Source: AGHT+IEEJX6T6GgItatrLUOO4eq1TE6WCfNa/DqbWsLOIOCWLzZKyFG0bwOQ4opt5Ug5hrQOAM7F1w==
X-Received: by 2002:a05:600c:54ea:b0:439:871d:d4c0 with SMTP id 5b1f17b1804b1-439a2eb09f6mr130885245e9.3.1740386344324;
        Mon, 24 Feb 2025 00:39:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b? ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce4e9sm100644875e9.4.2025.02.24.00.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:39:03 -0800 (PST)
Message-ID: <92321fed-28b3-454e-b187-7ecfe4ce27ae@linaro.org>
Date: Mon, 24 Feb 2025 09:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] drm/meson: vclk: revert and re-fix vclk calculations
To: Christian Hewitt <christianshewitt@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250110074458.3624094-1-christianshewitt@gmail.com>
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
In-Reply-To: <20250110074458.3624094-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2025 08:44, Christian Hewitt wrote:
> Patch 1 reverts a previous fix for loss of HDMI sync when playing YUV420
> @ 59.94 media. The patch does resolve a calculation issue. It also makes
> all fractional rates invalid which is a bigger problem.
> 
> Patch 2 provides a proper fix after I figured out the actual root cause
> of the original problem. This time the maths checks out.
> 
> Apologies to the stable team as the original patch has been applied to
> a wide range of older and LTS kernels (as far as 5.10). Please let me
> know if combining the two patches into a single 'fix the previous fix'
> patch would be preferred?
> 
> Christian
> 
> Christian Hewitt (2):
>    Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"
>    drm/meson: vclk: fix precision in vclk calculations
> 
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 42 +++++++++++-----------
>   drivers/gpu/drm/meson/meson_vclk.c         |  7 ++--
>   2 files changed, 25 insertions(+), 24 deletions(-)
> 

LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

