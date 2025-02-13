Return-Path: <linux-kernel+bounces-513918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1AA35039
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB51C188A9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD84266B47;
	Thu, 13 Feb 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dugJ2J9p"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E32266B73
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480864; cv=none; b=jLVt0BG3+sTB7VNy4DDtOUCxVsuchboXBYXR4wxX+wI8uzP7/oJtyEZ5RRueC8Ikb0JaQ4oYOSrmZmCYNyvEmbkHo/Y/T5GFEoFzxqvKL3/xqUXgNvz1rLmcj8BWUstJv4N/YxHEbiO6Mq9+kL0xpTau+ku/142Sh2ZB95sCTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480864; c=relaxed/simple;
	bh=jtQY/WICwi4MD5lyg5esWz4m+CvOcfvFhUYEjimR3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRSkdM8ej+762O/185DoXdxBV5NRf5W67JfyDIY0wwrDkiOD9vuM9GX7uXwzbcn6ayRAlK0j4B0vfefnMJJuaAXwqmbMsf8WxQHCkIHfB6STOt3xerBpNolH0Dr8bl82q3xZhxW8EpKPZkMpUtL1NI/XW51PhnpgS7uSfmW9B1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dugJ2J9p; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54504a6955aso1082593e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739480860; x=1740085660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54daZ/2ISEYXfmkw2a/4DC97bZAaTJdOPQ/lBbTtt/c=;
        b=dugJ2J9pdGId57AULVOylg//7IIH8Wisr4Jx9Zll8s0mUaiU2N32FpuSfYTmpbUAMA
         4iLajidtuYAz4Fm2+EdDJTQF+Oh2Z4Fv5a2SNakFTkOgkzpTg011jpkSm4iyiB63HeHk
         ZpDAC6I/UgeXZT6sWuLA/vwPoZ8lR3PX7Mziip+lA++rW7MPDGfwww0iQAusNwNUnSRJ
         sRmmvPMOKXUT9fgVQb3ipdtQTHJCB3IcEOm1m9nyWd+dc7/3Xrp2vRm8LWuav5gzBAsR
         rZol0jaYaS6auCCy3ssU7YBOv+NNZE1/Tig8/0r+9XhIYbfR1XXFKI1rk/Q2sqhvk5kr
         5Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480860; x=1740085660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54daZ/2ISEYXfmkw2a/4DC97bZAaTJdOPQ/lBbTtt/c=;
        b=Lj379roVuET3+SwZlsXBWXT2TtpFnO9RBkPPJ2tqHwwk47Ct+n4dpJI2WDru4xfXHK
         kfOOZi2qxPEfMnVi7G4Q4w2Oqr23DSIuF+82YMZFh0x559EcFP44IZJdqh2l13ltNirx
         OfCZPhP3oN2lsRevddq6WpwqXQBSGlNC5pdn6rei0AYlrKXv5/IfmnhJpuhj3BJntWaO
         sgR14BJ5+f6+5mxdxN6CyNmxqO4Zmy8IqKAoiS+A7r8hEU+Yw+W8uTkUchMaxvpnpHoe
         K0eIn+m3zUq5y+Jk1/H0YUwsCSIi5oVlKUklNBH5pZWhMLZUv72u/Zml+rRUXXGdAlxe
         1gHw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZT/5/pdBR+dSkIMJrKQpEQLInU434FDKF5DM7XZjzRCDj7/jJ4suPelKbQcDPduW0MX6FZsVu0cmI08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fCu8aeyUxQMfbmrzPdRPa85QhNd36vSV87T+bjBLIuG8w5q2
	KCua1IGlmIK/BzyABDchEzU5FDB1frYeHPBzy5hpWIeIFjVFMOa9340wVgT1Tqc=
X-Gm-Gg: ASbGncvW10HkVP8bM0DGKOoOM9y7ShF9bD6KTidAo6dq5hrzVn3cFmo/VIL4+l9snPp
	qCiaUk6nZKbRM6ebU2PW35vQ0OH/+FpJ7erSi5acO+BZeObW7tTWJ9PulxVo5PG27Bv8BRF7iWl
	aFBkNzxgkHM+l7T6LpurE4MvU2a05yiRg4u4ayoqRAAWIAhIPBkeSLGk/NeV1UvvBocN6Al4k5f
	pebeRnr8pen5bbE9zXWYiPnZ9nEv7C69MjRTgWota12IASLFaOhv/T/cccMkLQbjk/GWuCyO53Y
	4Hctos6MgKzDE7V919Gb1ZsWyW99Vx8bRpW2vKyUDM/xO+PVvlQ3Xr5tGAam24tiG4/8H+I=
X-Google-Smtp-Source: AGHT+IHdy6RCQWr/V5lQjpv7FHztk/zWiNciuZA02FPFndi2Sxl9F3c+cbIai8wKbgKpiRSu2MhCyA==
X-Received: by 2002:a05:6512:1381:b0:545:c7d:1784 with SMTP id 2adb3069b0e04-5451dde7f2bmr1577449e87.43.1739480860282;
        Thu, 13 Feb 2025 13:07:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011ed69sm3147421fa.49.2025.02.13.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:07:38 -0800 (PST)
Date: Thu, 13 Feb 2025 23:07:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, 
	Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
	Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 02/20] drm/panel/visionox-r66451: Move to using
 mipi_dsi_*_multi() variants
Message-ID: <4xtwrhvoahnbd7do55n6a5dxsbceowuzqvc72bukxmt4dqfiuy@3lz4cy4xyhk7>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <20250213-mipi_cocci_multi-v1-2-67d94ff319cc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-mipi_cocci_multi-v1-2-67d94ff319cc@redhat.com>

On Thu, Feb 13, 2025 at 03:44:19PM -0500, Anusha Srivatsa wrote:
> Stop using deprecated API.
> Used Coccinelle to make the change.
> 
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-visionox-r66451.c | 156 +++++++++++++-------------
>  1 file changed, 75 insertions(+), 81 deletions(-)
> 

commit f4dd4cb79f9ec3294e5100223ed90d8ae371f168
Author:     Tejas Vipin <tejasvipin76@gmail.com>
AuthorDate: Mon Feb 10 14:53:42 2025 +0530
Commit:     Douglas Anderson <dianders@chromium.org>
CommitDate: Wed Feb 12 08:44:34 2025 -0800

    drm/panel: visionox-r66451: transition to mipi_dsi wrapped functions


-- 
With best wishes
Dmitry

