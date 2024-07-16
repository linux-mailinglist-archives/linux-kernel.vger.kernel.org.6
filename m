Return-Path: <linux-kernel+bounces-253655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A044C932463
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7AB23796
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479A198E75;
	Tue, 16 Jul 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCRTNPMB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900713D630
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127237; cv=none; b=f74gDjwBYhe49yz0q4o/yNnS28hZZteMjOaInCkv9T6xoZ6vf8Ro2YPFY1qktAKedW2C5WVEg1S4qTPUxHQbexvIzxS2XHyyi+DaK3Fb5+toGwWAH0gEMvCKGvcl4taDXGy78Qz/qdp43DCSp9KPM5juMIswj+OLhs/6nUFKYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127237; c=relaxed/simple;
	bh=OxYUo3dMEPdGobtzyErxpqUUU6F1LF/gvlaNAT7uPJ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qJ5QJuq0CfDyEKhAO8/AInBzmt3pZ7hslCSdT5HYpKWaRXNeylUjA0woHbG3nuQDCU0IidRLwgTFiqqJnyzyqrGz3caMJCkgbgb9hxREpUjSWPHi18FqS0laNujgfTBw9+6h2+m6RsA+QmyUJ5QDZCQa2VUT/N9yxEHuS15g6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCRTNPMB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367a081d1cdso2855066f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127233; x=1721732033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXzIcAqpxHG7tPPh/elMPV6grh+ccM9HxfPCceHHxTA=;
        b=JCRTNPMBG0l3s0VDQhluZ20TIiRc+2tMKD0M29iGUgATHaAPJZnolA+1SQPMkUgPmQ
         EykPjQGlCMAbSSVcuwWgqJm+oufxSE8Cf9VNob2ih8gXsrbluDhA3mcLGgbRRzRyJ/N3
         c0R4cSkKzEeoOOzfF7D5LeF244O+spJ1x/PWt7IZNvSmnNzn2/vFcYoswmCXMzlLmtYm
         YfnbDfOwDd+lhugun+Zs/q+iX7K0zsHxP+Dp8q3+ZqSdrf+vpE4ph12gcYKS5yG6aTPO
         vEtMN7S2hEVkHbvmVIhP3rvK67nAPexk9jc4xtNdI/xw8rJNWjXocahREzTpQWaYzQcq
         qabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127233; x=1721732033;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nXzIcAqpxHG7tPPh/elMPV6grh+ccM9HxfPCceHHxTA=;
        b=acjjczPtqTPQvKtrVLWxCCiam1Tr83XkoH3vP9AGlOwRfff5BbxECCbEIcH1+QK+G4
         TiVQk46KyoqvaFfZS7jUZq5TJNLCAqaCtKB0DKB72ZH6ZHEf8BCoFKyUzj3RXFUut2bm
         Q/3hj/hkIRFbm80L2MRHFwYMgZXC4/AuEPikqjNn6X+IWxQ3lbpQGe1yISSVh/X8O1Df
         JPudAveOVP230fHiZBytf3vqj3t1Ha0iCWlR1K8aBNY4oj9aQjXPDEpHbJFRynDb3qKL
         wAGpS+6cP2ul/H0S1RskMMTjO8hII8Q10HcqqTbcKrCHqP7KOrassELdqAHzXN/g/MsR
         1U4g==
X-Forwarded-Encrypted: i=1; AJvYcCV8k06nd6ThnSlwQviPIye9aq7q6nO/QaNGMcJKZ5s2VT22xN86qeaKbGO9TwL+Zm5SClqC/dOgJTwXkijk9G6XxrBKJ5ScCOLlEKNm
X-Gm-Message-State: AOJu0YwOP6D0PqMSQpQ9xA0VgzPrjR62uvs1hbblGRm5G6j58pwr3Llr
	yhSjyolYHPVF9Y09sj3Y0in5IqJpxtI1XXAaNDgkNMUSkEn7uAJ7is0j+pbE97Y=
X-Google-Smtp-Source: AGHT+IF/XfpK3F6pBtU8SrWLC0nhPop0clUEctwox321fqXnnzwSGm7+wIyzDM/lhazbOaJDVhnWBg==
X-Received: by 2002:a5d:6646:0:b0:367:8a9e:6bed with SMTP id ffacd0b85a97d-3682635b6e4mr874072f8f.61.1721127232379;
        Tue, 16 Jul 2024 03:53:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197? ([2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm8614509f8f.68.2024.07.16.03.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 03:53:52 -0700 (PDT)
Message-ID: <b35eb84d-5ed4-469c-8df3-d7e895bb910c@linaro.org>
Date: Tue, 16 Jul 2024 12:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
To: Douglas Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621134427.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
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
In-Reply-To: <20240621134427.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2024 22:44, Douglas Anderson wrote:
> At shutdown if you've got a _properly_ coded DRM modeset driver then
> you'll get these two warnings at shutdown time:
> 
>    Skipping disable of already disabled panel
>    Skipping unprepare of already unprepared panel
> 
> These warnings are ugly and sound concerning, but they're actually a
> sign of a properly working system. That's not great.
> 
> We're not ready to get rid of the calls to drm_panel_disable() and
> drm_panel_unprepare() because we're not 100% convinced that all DRM
> modeset drivers are properly calling drm_atomic_helper_shutdown() or
> drm_helper_force_disable_all() at the right times. However, having the
> warning show up for correctly working systems is bad.
> 
> As a bit of a workaround, add some "if" tests to try to avoid the
> warning on correctly working systems. Also add some comments and
> update the TODO items in the hopes that future developers won't be too
> confused by what's going on here.
> 
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch came out of discussion on dri-devel on 2024-06-21
> [1]. NOTE: I have put all changes into one patch since it didn't seem
> to add anything to break up the updating of the TODO or the comments
> in the core into separate patches since the patch is all about one
> topic and all code is expected to land in the same tree.
> 
> Previous versions:
> v0: https://lore.kernel.org/r/20240604172305.v3.24.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid/
> v1: https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid
> 
> [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2024-06-21
> 
>   Documentation/gpu/todo.rst           | 35 +++++++++++++---------------
>   drivers/gpu/drm/drm_panel.c          | 18 ++++++++++++++
>   drivers/gpu/drm/panel/panel-edp.c    | 26 ++++++++++++++-------
>   drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++-------
>   4 files changed, 68 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 2ea6ffc9b22b..96c453980ab6 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -475,25 +475,22 @@ Remove disable/unprepare in remove/shutdown in panel-simple and panel-edp
>   As of commit d2aacaf07395 ("drm/panel: Check for already prepared/enabled in
>   drm_panel"), we have a check in the drm_panel core to make sure nobody
>   double-calls prepare/enable/disable/unprepare. Eventually that should probably
> -be turned into a WARN_ON() or somehow made louder, but right now we actually
> -expect it to trigger and so we don't want it to be too loud.
> -
> -Specifically, that warning will trigger for panel-edp and panel-simple at
> -shutdown time because those panels hardcode a call to drm_panel_disable()
> -and drm_panel_unprepare() at shutdown and remove time that they call regardless
> -of panel state. On systems with a properly coded DRM modeset driver that
> -calls drm_atomic_helper_shutdown() this is pretty much guaranteed to cause
> -the warning to fire.
> -
> -Unfortunately we can't safely remove the calls in panel-edp and panel-simple
> -until we're sure that all DRM modeset drivers that are used with those panels
> -properly call drm_atomic_helper_shutdown(). This TODO item is to validate
> -that all DRM modeset drivers used with panel-edp and panel-simple properly
> -call drm_atomic_helper_shutdown() and then remove the calls to
> -disable/unprepare from those panels. Alternatively, this TODO item could be
> -removed by convincing stakeholders that those calls are fine and downgrading
> -the error message in drm_panel_disable() / drm_panel_unprepare() to a
> -debug-level message.
> +be turned into a WARN_ON() or somehow made louder.
> +
> +At the moment, we expect that we may still encounter the warnings in the
> +drm_panel core when using panel-simple and panel-edp. Since those panel
> +drivers are used with a lot of different DRM modeset drivers they still
> +make an extra effort to disable/unprepare the panel themsevles at shutdown
> +time. Specifically we could still encounter those warnings if the panel
> +driver gets shutdown() _before_ the DRM modeset driver and the DRM modeset
> +driver properly calls drm_atomic_helper_shutdown() in its own shutdown()
> +callback. Warnings could be avoided in such a case by using something like
> +device links to ensure that the panel gets shutdown() after the DRM modeset
> +driver.
> +
> +Once all DRM modeset drivers are known to shutdown properly, the extra
> +calls to disable/unprepare in remove/shutdown in panel-simple and panel-edp
> +should be removed and this TODO item marked complete.
>   
>   Contact: Douglas Anderson <dianders@chromium.org>
>   
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index cfbe020de54e..19ab0a794add 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -161,6 +161,15 @@ int drm_panel_unprepare(struct drm_panel *panel)
>   	if (!panel)
>   		return -EINVAL;
>   
> +	/*
> +	 * If you are seeing the warning below it likely means one of two things:
> +	 * - Your panel driver incorrectly calls drm_panel_unprepare() in its
> +	 *   shutdown routine. You should delete this.
> +	 * - You are using panel-edp or panel-simple and your DRM modeset
> +	 *   driver's shutdown() callback happened after the panel's shutdown().
> +	 *   In this case the warning is harmless though ideally you should
> +	 *   figure out how to reverse the order of the shutdown() callbacks.
> +	 */
>   	if (!panel->prepared) {
>   		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
>   		return 0;
> @@ -245,6 +254,15 @@ int drm_panel_disable(struct drm_panel *panel)
>   	if (!panel)
>   		return -EINVAL;
>   
> +	/*
> +	 * If you are seeing the warning below it likely means one of two things:
> +	 * - Your panel driver incorrectly calls drm_panel_disable() in its
> +	 *   shutdown routine. You should delete this.
> +	 * - You are using panel-edp or panel-simple and your DRM modeset
> +	 *   driver's shutdown() callback happened after the panel's shutdown().
> +	 *   In this case the warning is harmless though ideally you should
> +	 *   figure out how to reverse the order of the shutdown() callbacks.
> +	 */
>   	if (!panel->enabled) {
>   		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
>   		return 0;
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 3a574a9b46e7..8723cd190913 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -954,16 +954,24 @@ static void panel_edp_shutdown(struct device *dev)
>   	 * drm_atomic_helper_shutdown() at shutdown time and that should
>   	 * cause the panel to be disabled / unprepared if needed. For now,
>   	 * however, we'll keep these calls due to the sheer number of
> -	 * different DRM modeset drivers used with panel-edp. The fact that
> -	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
> -	 * will try to disable/unprepare means that we can get a warning about
> -	 * trying to disable/unprepare an already disabled/unprepared panel,
> -	 * but that's something we'll have to live with until we've confirmed
> -	 * that all DRM modeset drivers are properly calling
> -	 * drm_atomic_helper_shutdown().
> +	 * different DRM modeset drivers used with panel-edp. Once we've
> +	 * confirmed that all DRM modeset drivers using this panel properly
> +	 * call drm_atomic_helper_shutdown() we can simply delete the two
> +	 * calls below.
> +	 *
> +	 * TO BE EXPLICIT: THE CALLS BELOW SHOULDN'T BE COPIED TO ANY NEW
> +	 * PANEL DRIVERS.
> +	 *
> +	 * FIXME: If we're still haven't figured out if all DRM modeset
> +	 * drivers properly call drm_atomic_helper_shutdown() but we _have_
> +	 * managed to make sure that DRM modeset drivers get their shutdown()
> +	 * callback before the panel's shutdown() callback (perhaps using
> +	 * device link), we could add a WARN_ON here to help move forward.
>   	 */
> -	drm_panel_disable(&panel->base);
> -	drm_panel_unprepare(&panel->base);
> +	if (panel->base.enabled)
> +		drm_panel_disable(&panel->base);
> +	if (panel->base.prepared)
> +		drm_panel_unprepare(&panel->base);
>   }
>   
>   static void panel_edp_remove(struct device *dev)
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 8345ed891f5a..022ffab2324a 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -726,16 +726,24 @@ static void panel_simple_shutdown(struct device *dev)
>   	 * drm_atomic_helper_shutdown() at shutdown time and that should
>   	 * cause the panel to be disabled / unprepared if needed. For now,
>   	 * however, we'll keep these calls due to the sheer number of
> -	 * different DRM modeset drivers used with panel-simple. The fact that
> -	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
> -	 * will try to disable/unprepare means that we can get a warning about
> -	 * trying to disable/unprepare an already disabled/unprepared panel,
> -	 * but that's something we'll have to live with until we've confirmed
> -	 * that all DRM modeset drivers are properly calling
> -	 * drm_atomic_helper_shutdown().
> +	 * different DRM modeset drivers used with panel-simple. Once we've
> +	 * confirmed that all DRM modeset drivers using this panel properly
> +	 * call drm_atomic_helper_shutdown() we can simply delete the two
> +	 * calls below.
> +	 *
> +	 * TO BE EXPLICIT: THE CALLS BELOW SHOULDN'T BE COPIED TO ANY NEW
> +	 * PANEL DRIVERS.
> +	 *
> +	 * FIXME: If we're still haven't figured out if all DRM modeset
> +	 * drivers properly call drm_atomic_helper_shutdown() but we _have_
> +	 * managed to make sure that DRM modeset drivers get their shutdown()
> +	 * callback before the panel's shutdown() callback (perhaps using
> +	 * device link), we could add a WARN_ON here to help move forward.
>   	 */
> -	drm_panel_disable(&panel->base);
> -	drm_panel_unprepare(&panel->base);
> +	if (panel->base.enabled)
> +		drm_panel_disable(&panel->base);
> +	if (panel->base.prepared)
> +		drm_panel_unprepare(&panel->base);
>   }
>   
>   static void panel_simple_remove(struct device *dev)

LGTM and see if we have negative feedback

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

