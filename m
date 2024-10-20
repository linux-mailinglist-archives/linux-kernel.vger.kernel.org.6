Return-Path: <linux-kernel+bounces-373266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDF9A5471
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01671C20E00
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F50192D69;
	Sun, 20 Oct 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5d0Gf+D"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0FB1714DF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432474; cv=none; b=WBYYnJOWQ56yGGPe+vgq9c0kHCqLofhE70aNj4Z+D3KZPlMKQUUWDx2GrQpDqdF96nm1XAZhi5aa0f7+lMkBgYNOGWUT7OZ91C6eSm9NWKKmMy6I2IwTMcqZHRVYoXDo3N+HcugZ//+08tXd3qMeHIffgb9YPcKKl+JJ2LURZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432474; c=relaxed/simple;
	bh=jLFTq7VI5z/68scHbYI0HxZ6ojreXKO0A3IUx3Fm+qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+GCa75L2HRpyAoB4WZK2vnekkO1U2CGxsAh0BlZEd28rITqlkaHZesEhPxH2KE1kEQqfAMQZJF5StYIp8IC0FiPdA8e7N5wfc0m8cPS02mj7LWEMaJBjQUmZ1wBSnuIIpaaOd5hk1VP3dEG59P4oOwYY94S320U1TYGZP8zypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5d0Gf+D; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fb49c64aso4937595e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432470; x=1730037270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2ud3Xhjl5fnEqrQN0vvlzXUx4fvt14whOgTup2v4IU=;
        b=u5d0Gf+DjeuRTB7sNDpjjVG2Ou7mGO2VK+uqPt4j7kydwN0E8SDJyQGzsobJgaOnKA
         +BSYQmC7xYsAgjqB9o7R/rb+OQ+kpCCLSksmeWpOfRcR5cklUUUp/JIZd8VtCxeef96j
         b1cnEB/L/G1RkXoKlbBKpuezFOHtmO7tE3fwF7T2SIwboxYX6uR0dmGH9DyJqh/VNF67
         JARkWw4W/f0bZoiSqRGFYfMIuTVh2BIn0IMoNf3h2RY4TbnH/CIyBhk49kB++nJ0gK9p
         vYxyf3BZL2iwOTUV9tBpKU4xXgZ1rPPxtcenvz59ETRk91L5dXq8dbZZdxM0+M7fk/7P
         4znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432470; x=1730037270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ud3Xhjl5fnEqrQN0vvlzXUx4fvt14whOgTup2v4IU=;
        b=G+kr2LdI6thc/V1AeRsc3sJgzp1af+MCKvDn7kmO1zPVqqlEl+Wmkqx/9UhYF93Wf5
         9oZD+Sv4eCKNjgXRoGxl/b2Acpfwxj1hL9DHuftastpccRllDZF2gFQnPzd6pPuEAZft
         rZ9uT7w/VAzDEcUa1zOEQWq56QJfhHg/IFlOnGgGSVP5fG3udp2JfyyvTSKjRZN23JBb
         3U41nm2VVMkkLbRzvOa3oxBMoT3YZe0iQusKYidwt9fj2HZLn45SoNbDsO8TqwTuR8VG
         XSYcFVTVFPv2zGiTce87ybAbwP3yNC71aGXJa0UA3JIk2JcI4Y02VVeSDtG6EuCxVkHh
         VSLw==
X-Forwarded-Encrypted: i=1; AJvYcCUONuGzEEfF8qT4bjYmtcRnz8irDGqh3SyN6JAQWEtSaBAN2SkwpsA5NNYopx/VZ4bL/S5pplQwam4FDP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybygn6Hiosefc8kTPJxEFX6PlPJ0r3ZRh9eyOGujgT9sZOrhJS
	aBPAgf3KxC1wffau5LNedp4/vw/fnkF6I5N/5YL6he4Elag6PZTlIWOfhOT2mIs=
X-Google-Smtp-Source: AGHT+IEMOmDVyMAzEoNKb9e2GjY6AM6Q5pTGCmHde/YADctLUIXVQq8EXUAxv2quI9Z4hskp29KnjQ==
X-Received: by 2002:a05:6512:3d8f:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53a154ca09dmr6502669e87.38.1729432470290;
        Sun, 20 Oct 2024 06:54:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e590esm234750e87.42.2024.10.20.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:54:29 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:54:27 +0300
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
Subject: Re: [PATCH v6 07/10] drm/bridge: it6505: fix HDCP CTS KSV list read
 with UNIGRAF DPR-100.
Message-ID: <rjkks6fqcjxf66rfokz4cawptviotxdcixhqkzalasfph2dno6@iqz2577gkrtb>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-7-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-7-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:19PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When running the HDCP CTS test with UNIGRAF DPR-100.
> KSV list must be read from DP_AUX_HDCP_KSV_FIFO in an AUX request,
> and can not separate with multiple read requests.
> 
> The AUX operation command "CMD_AUX_GET_KSV_LIST" reads the KSV list
> with AUX FIFO and is able to read DP_AUX_HDCP_KSV_FIFO in an AUX request.
> 
> Add it6505_get_ksvlist() which uses CMD_AUX_GET_KSV_LIST operation
> to read the KSV list.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 48 +++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

