Return-Path: <linux-kernel+bounces-199688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866E8D8AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008D0B25C33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25213B586;
	Mon,  3 Jun 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVhz6YkU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1913791B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446669; cv=none; b=VH0HqsJSvlh5/6rBed1P0ZQbEUm+wE8DGvJBasxyJuRGYJV8TTvUUJ7p04/KNLCplP1LrYD1hUbYx7P1QQ+Nux86UISnsypSyhr2dj8MYsVSp9xx4+dZgYWbBeThGXg3aX8p+5Bih58K5gX7vdPi4edqgufzNWcFoTsdE8eZbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446669; c=relaxed/simple;
	bh=nVnxKR7e2LvFvgz7TLxMtm7sqT9P3GmKPQLTkHgszzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYus48vZNKJDZ8Bynfx8CIGv15QUyNa6yyikDQcD9O//UGDjWIUYmCQuq46WNLlnWV9rMJt1cWO4gUm2Gx3T00dekpwrys14QUpWqULuXO4AHepRVOyL9Z30mWYwXKjs3yMNwiGOpaa0ErVn0iBbf4HL6Yr/JQ5217b79zoc1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVhz6YkU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso4776773e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717446666; x=1718051466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q2AjR4uuxoyAwAOvk4z2camqVDTU+eBYs24+HoHi/i8=;
        b=fVhz6YkUYzTyzXGDXPc4s08/nBSMsELHFLjDlSizf38o2fnmWTaXYXZy0HrHD4R15o
         W/pdFNHj/7uk4olKpOW/E8oxT8/RzUzDGlXzYdYXNHruDcDXRlT2Kf/eCfE8vWyqdB+5
         fENfNrmdju9Y6zSkN8IQr+p4bAuI6oXT0XA742EJw9Y2ljLI3pByXnMeHchoBL6awowW
         KsIwP11NDBoKvsg9C3XKRJHVU2ADIWv07XjlrXOwy/dyrnGmoUlkCrLdulgQ4k/mj/pY
         IaCU3BIqYkU2yeEIg1uk+iY3MqIcN8ndoWmkVAVeKRBqwAfFQ1QDSEa6eliwk5ik4ILe
         CEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446666; x=1718051466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2AjR4uuxoyAwAOvk4z2camqVDTU+eBYs24+HoHi/i8=;
        b=JUTwtRddpF4swmrQXORfHjoiToQ8EJKJr4U2SU18tsWfMqSg27eR6dw9BrDy1DRn17
         9nDrR/AjK8h5VeT+IegrEqI3zTtirPfgP4c3DG28f6G9gnz6fLxgHVFEAolKLwnkQ7cd
         SAWx2xEDSuBqMRmc5z3LzYQHx+ZqW66/6Yu/c+BDx23ixffJNu6iOOzSR98iYN6ZqaGC
         iL0ZsyANJbeoPH9akChj5Bz2sqVzAYhZY4t+zoRnLtgH5j7k6wIrlfk/tEcUlrs60YM+
         DkXjKW8kobkrfLo5qyL6G8DEwgBc3fDiIyJQv3m+WWeJIucEdY2sKXtNi7Fs+jx+Fq2X
         HK4A==
X-Forwarded-Encrypted: i=1; AJvYcCUMm8SsMtnVpr5q6JMSoKy1I5CEOGJnWYqDDrPenBh9OQ+schdncDCDHdDvNrv1age6AwrsQktOGIsRk+8w8L2Lp4oqHb7YbVxbfJ/d
X-Gm-Message-State: AOJu0Yz8dZv5Ube9//tbtQnbGUgwwb/lAbzJPbLxN353pf62bH/WqXdR
	HbYENLDOeZez1t21XQGLMDutAENudanzz0lK6FxcwDlvmm4qUjOknFUYa0bBIIU=
X-Google-Smtp-Source: AGHT+IGGtZNy8Pr7JqVQMa2c6+HXJKdsAyzhhZ8mAe/EzUG9NQsyho1u3hZr/yzrsncDGv6TInJ/rg==
X-Received: by 2002:a05:6512:3e24:b0:52b:8455:fb1f with SMTP id 2adb3069b0e04-52b895609e6mr10600378e87.10.1717446666056;
        Mon, 03 Jun 2024 13:31:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8a661sm1316210e87.271.2024.06.03.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:31:05 -0700 (PDT)
Date: Mon, 3 Jun 2024 23:31:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: noralf@tronnes.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
	Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v3 2/5] drm/mipi-dbi: Remove
 mipi_dbi_machine_little_endian()
Message-ID: <l2j2bhyw6uttkqbx7o7hpb2yxzawh7f5r3eggefyvhlxc4mdik@vta7x4akfw3y>
References: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
 <20240603-panel-mipi-dbi-rgb666-v3-2-59ed53ca73da@tronnes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603-panel-mipi-dbi-rgb666-v3-2-59ed53ca73da@tronnes.org>

On Mon, Jun 03, 2024 at 01:21:33PM +0200, Noralf Trønnes via B4 Relay wrote:
> From: Noralf Trønnes <noralf@tronnes.org>
> 
> mipi_dbi_machine_little_endian() should really have been called
> mipi_dbi_framebuffer_little_endian() because that's the function it
> performs. When I added support for these SPI displays I thought that the
> framebuffers on big endian machines were also big endian, but I have
> later learned that this is not the case. There's a bit in the fourcc code
> that controls this: DRM_FORMAT_BIG_ENDIAN.
> 
> Just remove the function to avoid confusion. We can add big endian support
> later should the need arise and we have hardware to test on.
> 
> Instead of just amending the docs, expand it to explain the endianness
> handling.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/drm_mipi_dbi.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

