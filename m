Return-Path: <linux-kernel+bounces-192551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C768D1F09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFA8B21398
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA16FF5B;
	Tue, 28 May 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+z3D6v5"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E316FF27
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907238; cv=none; b=GD6XauCWMoyCHpSj5WUUjT8wl0huEGvhYiF7lUc9hFUPvB7XtGjBkxE6r/+z+chS+bvGYkL8Bg0YpG/oeQFjP8+Wx8tbKR/k24tWDapQev+8S9qsgVAMkpKOpPl6ya6pm8DZp3u2N8GuCSyRz5NbUkJHMZtnNVT0HJ0ElSk44eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907238; c=relaxed/simple;
	bh=G/sEAwtqVDZaq/JZ6QDvKHohGloo0nUCVaVRBW7SJR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLzBQj30RQbVC4u31YsrAt++4//ok7LlW3tY+H0udSeeKnNrNQYQ9jV09qbMWGB63g4eDmO9VqPxgnXWzeEh12lplM4Q2YqXHM9ypGPqwfdsl5genqK6wRT79zOdAXHaQIvQtBpDnZ24c40pmd36sDwj5ERdsrXPVwry0YxSAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+z3D6v5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a883101so11001531fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716907234; x=1717512034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gGbq2+G0YRbMbOdBIQss5wZtbiI49aMbKPIubZFnKg=;
        b=Q+z3D6v50qLDx6wTy7qCEUwbqHp0FlKnVchfWEzrA54yLSHKyzu+ynZkh51WpaQT/k
         xkTpEo7psPn9t6wJZ0Uvb+s8+2eM5J224/T4KtWW6+6FpQcS10o4Xlbap4aNS/DyJBtw
         t9yixFRFdT9SE0NFnft1dkLiDLUecxElOqE75GiaY7vEaXdxxPGfX5aFbd8SsDhYPLb4
         PsIm55kLcNidN7koJas0iRvlU9ATExycJAUnTLIAiG7+gn+T7ovcS3QRbVJkxO/2SyOg
         0eIsFLA4l1eEOve0PXTJI5nIQ39B9qBQiq2bsMoXHqDtXzGb69x/x1yv/3/Dxyt6PSXh
         DEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907234; x=1717512034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gGbq2+G0YRbMbOdBIQss5wZtbiI49aMbKPIubZFnKg=;
        b=im6qPk2Bk9VA+Sb/scaYK+qNdDfQRsPX8S8ZuGYzw5ZlZH+RWo7CruNG3ybcTa5oqp
         i47nvuhGS1xWSTIQSLyzyfNvrJb3HUwaludTVCpM8Fj/jYAwVMvbIB8JATYb1uVBL7t2
         +M3QRQ499OQzzbXk4Q94M4cn+pvq5xwYpAkMWsVjCXQr5fj1G1/VHxyghntcJy+1hGmx
         zCF5axknIPdbgQJoH6NnhVBuGC3E7qRUj2OTXipK8S6ZRColNKU4Kfovms9PQmpB7oBo
         hHeQRlcfKIy+lRnizNh2P7cSi6BRzFjVBDw3+1Q731c7pW7bdNk2g8SJmQZkaCUthw9H
         Uo1A==
X-Forwarded-Encrypted: i=1; AJvYcCVvJmYTgAl/4pybyTT/o5QrUli+kgXTbOP8tKvgOXb+Pp8c/5MEG4WoX8JFEUruUseLgpzi1Ig5XBQIZ6GKNir3BEmhhA1v0uA1P8eI
X-Gm-Message-State: AOJu0YwHyom3JuZPpQK3tf+LrivhkNKoW2cat8d/pn91EpxNK3g2w4GM
	R81DLSGeNaNaCtroMj4naRwRFALK6tjEnFvVhSPT/YC+jImwoI1QYWvvhD+vrQY=
X-Google-Smtp-Source: AGHT+IFLOJBz/bELqSb+f+uM0s4cO1qSHnszdkdpYEfD8loMqI9OQBAGzZRt5U9/gt8IksZYdmpK1A==
X-Received: by 2002:a05:651c:a09:b0:2e9:841d:dacb with SMTP id 38308e7fff4ca-2e9841dddeamr31411951fa.40.1716907234225;
        Tue, 28 May 2024 07:40:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd7c20sm22927471fa.33.2024.05.28.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:40:33 -0700 (PDT)
Date: Tue, 28 May 2024 17:40:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ricard Wanderlof <ricardw@axis.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] drm: bridge: adv7511: Accept audio sample widths of 32
 bits via I2S
Message-ID: <m7sghjgqtm45yjkpzrekeab7doojagxjts7vmw23a3tqtjltdj@v2oencka3uer>
References: <91472c14-3aeb-766a-1716-8219af6e8782@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91472c14-3aeb-766a-1716-8219af6e8782@axis.com>

On Tue, May 28, 2024 at 12:04:49PM +0200, Ricard Wanderlof wrote:
> 
> Even though data is truncated to 24 bits, the I2S interface does
> accept 32 bit data (the slot widths according to the data sheet
> can be 16 or 32 bits) so let the hw_params callback reflect this,
> even if the lowest 8 bits are not used when 32 bits are specified.
> 
> This is normally how 24 bit audio data is handled (i.e. as 32 bit
> data, with the LSB:s unused) and this is also reflected in other
> bridge drivers which handle audio, for instance sii902x.c and
> synopsis/dw-hdmi-i2s-audio.c .
> 
> Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

What about:

Fixes: ae053fa234f4 ("drm: bridge: adv7511: Support I2S IEC958 encoded PCM format")

?


-- 
With best wishes
Dmitry

