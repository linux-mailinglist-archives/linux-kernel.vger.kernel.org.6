Return-Path: <linux-kernel+bounces-186775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADF8CC909
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569081F21C24
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C071487CB;
	Wed, 22 May 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB5xT2zG"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BA148304
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416726; cv=none; b=fVfCyrWB4B6jc8sqOGdc7OqaL0X62xdGqcdy2JjVC+qJpwJVAZ6pbRrL9ojI5Jv9CLH/7Rc/5e+PatUIsDQ3b7NyK2UrO0YVEYeIbsQG72jaipab1xH2gTNDhHf2JtRSzHWGRyClul6GhXY/kIaJJpx+jhqH2vS1YMYm8l8Sqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416726; c=relaxed/simple;
	bh=S9gk0oHEgZRttCqVbj1YGaYY20MAg99heofbtYJxY8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJtWvjWUX89pZNDrEITWEvMIko1Tjsbr+B/hN9SmzQenfnSDbD99l8uvAly7a/mO/Y3C5wHlbbSHUlQmVM5zBfwKloeXoxiluQ8xq23YCt7rBlvtSGrtwa52ySx7LOy00EkwuO3hp1q4+PbTEdR83Kx0ufdNbliWcLnIXZxGFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UB5xT2zG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f72a29f13so7470432e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716416723; x=1717021523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0B2JbRhNTxBGKVMHTsItxZYaFytK7xf2SG3yQV20MJg=;
        b=UB5xT2zG9YRKYdY1euNfslwTxG1U0h++5NknSzdaeMmmZAeWpv0EzpLFfo40wwsYAz
         JQgpWX50/EhiT3rcSMtptzHjeK7EnA2SCCxcwbZ9pXHg8O9mvMeTGhCQ68bq/9eF0IoW
         xYLhwMcBzZQ0YTo/QK9tBzWJ42JmKZIpcKfglU8MrGWi8J0S5//zsUT79/mhoHOxNpYo
         d1wvyk10z1/mN2yz8SO97UI1xsg0XgFPiABlEdo2Iy/JtyAvpTa47NpA27Gs8HfNQyLA
         aMnz5vx1tCBYA7Oq11IGuufdJE7jyBiTfEW100IGv5EN2XagejHodxaD4nZfyfQOmFHE
         G0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716416723; x=1717021523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B2JbRhNTxBGKVMHTsItxZYaFytK7xf2SG3yQV20MJg=;
        b=HX81YnBhTR9Vq9XcdX5fhGKcJ3q30XMNZnEARNgPVfdHgKF8yIkovajU86uiKwmo4z
         7rr4BFXrus2rZceVk/AGlolJugETcxhJLmobirtrOhcH0eR0qGZWLTT+5UiYKnm3Saa0
         0NiZ3nzTeBVFCMGVHCRcCprqrVEOIIs9GPvQ4nGhiasZjgaCRaWeyCRTLfYbFbyuxLF9
         G+Pex+dTPfHzSrN/UlbAeu80BeIA4vtvTzfgjt6Prty5+wYfMcihThm2FD94HK5ZG4pM
         +VxzTGn0GNm9PCXz1yeKsxYnU+E7P0bFfOiXBvpDYmwTbRBzmERNgjNOdXDHL+6cpgQX
         heWw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ABBZDk4+1Oy947wjy9IFfEh1p1mI2l/0ZXzVtlKkv+tfhG/ZdWpcFhFYFH6X+4NqmWXlf9PwLhYLQk7XhOdL1XqsnL8GZI9vHEGs
X-Gm-Message-State: AOJu0YzhYaXAifoFAG8PaWxhxTPY0KIKosLOWcLF4s5JPECDx0P6SlTq
	Mwaode2fgk/E2x0WMCGNYqHoIzv4YK07DS5NMR/GgWxXGEJqXX7xrhXE1/2dLU4=
X-Google-Smtp-Source: AGHT+IEdRcdYbBoQQzpqYVDzxkuMPcPMqGC5L1AwkkRW2Odahvetj8UXht61AaeWnM+5cMkq4/v0ww==
X-Received: by 2002:ac2:5ded:0:b0:519:6a93:ed3a with SMTP id 2adb3069b0e04-526bd6935bfmr2114964e87.23.1716416722617;
        Wed, 22 May 2024 15:25:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad499sm5106336e87.20.2024.05.22.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:25:22 -0700 (PDT)
Date: Thu, 23 May 2024 01:25:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v14 05/28] drm/connector: hdmi: Add output BPC to the
 connector state
Message-ID: <ikljb6koxeg6urdzjyg4nbqtl6pzxs2vakavjkxjudsjhsklyp@3ib3inb2oq4s>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-5-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-5-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:38PM +0200, Maxime Ripard wrote:
> We'll add automatic selection of the output BPC in a following patch,
> but let's add it to the HDMI connector state already.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 20 ++++++++++++++++++++
>  drivers/gpu/drm/drm_atomic.c                    |  5 +++++
>  drivers/gpu/drm/drm_connector.c                 | 20 +++++++++++++++++++-
>  drivers/gpu/drm/tests/drm_connector_test.c      | 12 ++++++++----
>  include/drm/drm_connector.h                     | 12 +++++++++++-
>  5 files changed, 63 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

