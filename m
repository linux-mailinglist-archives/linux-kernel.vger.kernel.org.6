Return-Path: <linux-kernel+bounces-372006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DE9A4330
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2078D286716
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61284202640;
	Fri, 18 Oct 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgoz4ba2"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479281FF5F7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267560; cv=none; b=WY3zDojG+HHAhv2hGPDdYevZYToTkyTTq/i3WuZfEJoETI4h22fNwtWAHOKWZxo2VYlkp4M9JU6RdjccOdFbOnTnRiV/DgdqSDzpM6PyZOxwbfa7d/d+W3wTr7s0fLkfeTje2mA2MnGPKFTZrAnhaA4+QX2B2o6S0zL/eALm3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267560; c=relaxed/simple;
	bh=QCypCPA1T95iwk3UdXBpT27F7o85oRluEEm4OPgylck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ6QSncSYGyFVaMt4pBHLACxatE5w7y4AucHYUsQ4uauFFH+FK0es6Cz1e8q6D/eK7NlItigQyXxO4wACHR/eqp92+aFRSecojalWg+zv1nHW8DFo8zU+4cP54DJrNHT47d+Z2Ki9epr/pi1Mgq25GC2Jm7W00/p5gLofd0t3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgoz4ba2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8586b53so2807761e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729267555; x=1729872355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wYEvLE5AoTVEsvqBPjLtagcoJbMeHJO2qbYoBljMjc=;
        b=vgoz4ba2TXvTUbQymrmwZMnClGRTRMw4hL1bKgjeSECYnAZd88syKnq6nQBANkCdS8
         th2K+ZaRYEHevExtipdm2hhhr/5GDY0vbiBY62h5UQ5GN5HhAgo0Cb7W7zs4uXYxvnQ3
         yZ0AK+sVVUQFB17QXYx+MH8/BKDTn+9XnxT8t/T0lIaBRV4nk0QPZCdMy8FbZkPIF6yJ
         Hyb88BRYJeQGJAe51xjnKj89xmmjBx2s16QQvDNJQpLWP4d/7OIrR8IFtPIrunMxNfnJ
         4fiMfwP/KcV8W43m2y07nvLf8h3nIaiyqF/OI+ksTV7wxCbKMyRA5nHSgFo6jXE6N/sU
         nsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267555; x=1729872355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wYEvLE5AoTVEsvqBPjLtagcoJbMeHJO2qbYoBljMjc=;
        b=aIUSw5+BDYvDtnGekcQCdHDz2hG+QsafCzSvL9hgkULsn3LLsOVttQ1fvHHElE1iEn
         fjvyqgcESfjzJC6jYBSZ/kmM2gnWXXCs51wQHGtgdlMaLR6Ei2VhvjQybZ/8qHS7Tzgv
         2+ZLe+d8UbqzwLcGqLEcEs6BSzUrFN2w9GQh0zoA07xX6li+oTDNh0sgZbz2L40HLFtt
         9w0s+ew8gUiLkeoGYt0QepjRQ4pxJCem3FG7ZqDRKR+i2mOIds1pP5ec1xUToiadOrvN
         6IC6RjJj7vGljDXrWRkET12rbxtHsyvKuXD4s5UxFjgvhR8HQENQhgDoq4dOv8iYAsCa
         AbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXUPUbeCIVoMs4csRRUmMggoAsUGL74u5kz+rRGwnNY/b2Qd4mVj15q4XYIf+JMoex9worcNJUMgA8HW7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwY+ev7N1f+wk4rtadAwUvXVJarUh6h40O/nhF2IrbJLbBjsL3
	63oQi6Zh++AYAzK5m4vNDfTiN1YdwU2oDlDnpesDumd1CgNOKc880aVhTM+ABxs=
X-Google-Smtp-Source: AGHT+IFjhdbJ7YZZcyfL2UU7JQ9UyXrDu19ycBJ6CNiQ0dGXU9v10DHjdks2qgl0GgCmrtOLG2ajIA==
X-Received: by 2002:a05:6512:33cb:b0:52f:1b08:d2d8 with SMTP id 2adb3069b0e04-53a15844da5mr947314e87.7.1729267555106;
        Fri, 18 Oct 2024 09:05:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152044b8sm251517e87.221.2024.10.18.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:05:53 -0700 (PDT)
Date: Fri, 18 Oct 2024 19:05:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/imx: legacy-bridge: add MODULE_DESCRIPTION
Message-ID: <7ppx4rpyxrsr7spzopocv2hojwzxivojfpc2ze4leippuvvrj5@drhmfqmajzrp>
References: <20241015073004.4066457-1-arnd@kernel.org>
 <20241015073004.4066457-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015073004.4066457-2-arnd@kernel.org>

On Tue, Oct 15, 2024 at 07:29:58AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Every module should have a description, without this we get a
> build time warning.
> 
> Fixes: cc3e8a216d6b ("drm/imx: add internal bridge handling display-timings DT node")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

