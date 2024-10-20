Return-Path: <linux-kernel+bounces-373263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD39A546B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15841C20A19
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B5192D69;
	Sun, 20 Oct 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFyxrqh1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB101714DF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432392; cv=none; b=mNxhWRn6HHIoildKIzQGp2mfm7ik1Ycjc/ZWzl9IYULI4QxXh8PaRYQNTdusYE8w957RkIxYjjo005c1W9yvAaCMpShfVhZgphqm0ALd+R3oeqHhUu4B79/gkph0TX2uiFpu6RD0X4OrhieaJL9eV6uQAgEtFQOGBiHGqq505mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432392; c=relaxed/simple;
	bh=GFp7zW2i3oBiN3HGsQ+XM9wS8osbR69MxAgkiGDHWGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diA4cA1CKvS/FvodwnxUnpNO9JgGGyxQz/YQjGb7tFiF414SOMDoXB5mQ+8uucY1hx4Po+ckyAEl4bmuFnOA1drjzR/aGdelumkhsF/5T6FeRTyuOu2nUlH3lnGMN1Hpua0doTywav3WJ3Jzt2KFYUpLX/K6NvoRrjl1xkqHNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFyxrqh1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so40439961fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432389; x=1730037189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gg1MDIPC7ZdKtGx4DSPHs00Leu3qoibohsRe4EHzNM=;
        b=WFyxrqh1oIvsSv6tQgTJAUK9J9Q0SDmgOiIDUyhiwcyoVx2BChgFXsDtJpqyHqGbdt
         JV1edVOmys3l00ZVnwMt/yl6TCNyqkLDgZJlKTe8Q0YsS5uQgKON9pBDyOSv3knqnGFR
         F2FHD2xPbliXNg21zWpI+Ppol5m+94dCFr6ZD+bkXWVtGzFkMtQL+sg3LRLHmMysuAkl
         34MW0Y6I2sSg54RF/J7FGkVduXGZXuJpo4BvJ9XSByw3Sp8nz1OPRil5bYc2CBWsgYoO
         BviR1nQef6mtSjBAWDVLN7mb81RPIjGQFAbGF9PkMN+LkMX36CT5DKco1BFGZlxACqy6
         s/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432389; x=1730037189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gg1MDIPC7ZdKtGx4DSPHs00Leu3qoibohsRe4EHzNM=;
        b=wP5x85fAV4vCLWXHbepvYrvkidTBet5dWpeqx5+S+u/EFcQ+Kgx88kZU5n4aZ1tL2Z
         J5+NzZ/OpqbiOttCZK4uZzKi/NeNNmyRw1b4iYPxiRntazASelfGH+bevOIW8r3sPrem
         s8FjrzRW+dGWT9BYppMLe0O+KDj9IRoZOahl3M1YqLly8qrMr+tDEBLv2BrkDsAle7xI
         U1MRxb+/Q1V/tbBdQQOT+KZHVDcu6YHBiIj++uE3DG38IaL1i6sbULDycWsamsicyDAv
         Zed/LZtRcTFdpvqolzbm0z//tIJTW6UA9FZeDJNWHf69+P9zb+7k7+/wKhm8DZ219yiN
         Dtlw==
X-Forwarded-Encrypted: i=1; AJvYcCXWTB3QOoyIYdsXidveEtsro/7oMhA1C+m//LjymE9/1wp/tISbBH+j+2AFoUcGgv9/ho3qxlolLD0+6LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys55rtnX7BMGb5IVyO8hzZbDg40R9Gi3hr7LTGukolBsHYtY4k
	e1KpctMqXyItmegfmpvduQGrSoPKJE5w3DQuHSOYrUcTvyNNlorO79Q1zjh+Hs8=
X-Google-Smtp-Source: AGHT+IHhzOLb5I3egLSSwZjc9BNKis8amHkTwLwjkwvSdniL6EjlNHXASdEegJ8U+tOsgB5Ha2S3CA==
X-Received: by 2002:a2e:e12:0:b0:2f6:57b1:98b0 with SMTP id 38308e7fff4ca-2fb8320dd55mr29466571fa.42.1729432388467;
        Sun, 20 Oct 2024 06:53:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad60775sm2387881fa.36.2024.10.20.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:53:06 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:53:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Pin-yen Lin <treapking@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>
Subject: Re: [PATCH v6 03/10] drm/bridge: it6505: add AUX operation for HDCP
 KSV list read
Message-ID: <ojy6n4hphcohozcqnkbmmiwtyjspbklu5ozmnkkgawzyaz66zk@pozfn4kn3rcs>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-3-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-3-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:15PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> HDCP KSV list readback can choose to use AUX FIFO or
> general data register.
> For some DisplayPort devices, the KSV list must be read
> in 5 byte boundaries.
> The original AUX read command does not support these devices.
> 
> The AUX command operation control register "REG_AUX_CMD_REQ" uses b[3:0]
> as AUX operacion control, and b[7:4] are status bits and read only.
> To change KSV read operation uses "CMD_AUX_NATIVE_READ" from using
> the data registers to using AUX FIFO.
> The extended command "CMD_AUX_GET_KSV_LIST" is added as
> "CMD_AUX_NATIVE_READ" with the 0x10 flag which selects AUX FIFO mode.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

> @@ -996,7 +1001,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  				  size);
>  
>  	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, FIELD_GET(M_AUX_REQ_CMD, cmd));

This needs #include <linux/bitfield.h>

Other than that

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  
>  	ret = it6505_aux_wait(it6505);
>  	if (ret < 0)

-- 
With best wishes
Dmitry

