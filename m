Return-Path: <linux-kernel+bounces-183297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62808C974E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6560BB20C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153773175;
	Sun, 19 May 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH0nkz2O"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373A11185
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157696; cv=none; b=XcRMNX2ujzZ7AevVNeaMj+scHx0+NhZvsKSNp8NyfD4e9ZHeEK3uscLIEUJa0ZiASa0do32SJ1Gn4yjbIh8jxDuL3hgEMr2vT/nfXSaLWYyALSkeImop+STcpspY6tOIjd2BsGxFDXwkZJKZvl+gZeKNfxAs0eZf6n0n41OK6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157696; c=relaxed/simple;
	bh=yTERaMGbPZ7glNoV7ljHsy0JhuUE8g7kx6v462TcXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q63BpNM/WBDBS6ULC1JALhX8G5NfIxb4p4ZypCsc+N5r3XR2aMIPS+WRV59ou6o+GdJEXd4CLRcTJyKhzgsLB3r74+yri348bvFBAiy5UswSA8/ZCvz1U6NODcRR67OpTL9cYHJcYk+Qzml7+xAQERr9HCfaFTTbPS8VpqfhLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jH0nkz2O; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5238b5c080cso4584849e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157693; x=1716762493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBa09DmBy2jqIF3DZr0Bwzme9COeLXE6oZ83JxnH2Ws=;
        b=jH0nkz2OOV34u3//f998bPcavovH9VYPMiEWgzJZhxAueR8eYxfVTC2rJtfkieUj99
         XhmQhGqWdilUZePs7bsuCmPxcqJieVGHRH+pqo036ITaDINTcfJ2pT87E1//+3b3UaAv
         q4LW0mDbRG82LRJ6B62J+aGQ30hInfe0R9S0vzMaKkGio2c59AVz6vRNMkUX6TcBBCjo
         UdIgqukYiaHOSXds6UTgOR2IdR/XXHT1CrpGuOOODBBpVHDHW95/eFr6cVTzH+l0QdAv
         rgZMYtu81vMmCGISaAv1/B3pA1b2pCa9R+y8pozktowjHpA7CGxwCvIeZPquiDJcoYF7
         eoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157693; x=1716762493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBa09DmBy2jqIF3DZr0Bwzme9COeLXE6oZ83JxnH2Ws=;
        b=LntJuZIrPHKymRCK5S/vJh3gJI3YkvRaO4OG4fiN/nkbV1hG9ywqSb4qdzV0stmHYT
         bfSMIXKSk+csPnWqUsMY1URLe/fHeFvHIkV0eITK9AyEGb8gMqISQJSOyCC/+oaaL+KP
         L0+Ajj5R4pXLdnDOCNc+HGS8z6WVgD/XUL6WnMqSY1YcMH/fGz/htcvc6VtTo+Kiep5T
         4PYw406oQzaEjUnwJTjSIl54N+5v8B0l06YfGulo5pjFBEDXOgVn3w/rxtdBUj/NUJl4
         oQraCOBJmbIj1VFHASKh31a23BGdEfjehzPIbddnSQbhtzThkKlqh3dx7ggRmaYphtMV
         N6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVgcvR8/6itjA9kuskQot3fk12E33m8f9cM3j/1udZRxeVZ5wqJh82fq22lBB4Iz6dw1YESZXp8LGY0bQbkkRg8CvfL6tGaWwdWJMaQ
X-Gm-Message-State: AOJu0Yz6Cuz8whUmUs/b4Eq1ET4YtdN71aczDn3fVMg4SvukGGdfU4fX
	zWlR6U96IHCYg3tN0dmalDpZoYwY7Z+P7HTLl0gT4T7fW5W2iAXaI2kX18uRsKg=
X-Google-Smtp-Source: AGHT+IHPw1Hd6p5weeCqyIthj4Yo78FUof006uG8oBvotqfwPaBsoFD/W3ipq2kE+BlGH2dDU+qpyg==
X-Received: by 2002:a05:6512:39d1:b0:523:99a4:a187 with SMTP id 2adb3069b0e04-52399a4a231mr11424053e87.26.1716157692887;
        Sun, 19 May 2024 15:28:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba76esm4068463e87.89.2024.05.19.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:28:12 -0700 (PDT)
Date: Mon, 20 May 2024 01:28:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] drm/panel: himax-hx83102: use wrapped MIPI DCS
 functions
Message-ID: <2ltjatqcq5bewekkt6lfg56vhx5mxfebghr3sd56cmjkkgamve@7jfsft35r6k3>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.8.If761d37b5d511867ac8207fe8220ae48d444a04f@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.8.If761d37b5d511867ac8207fe8220ae48d444a04f@changeid>

On Fri, May 17, 2024 at 02:36:43PM -0700, Douglas Anderson wrote:
> Take advantage of some of the new wrapped routines introduced by
> commit f79d6d28d8fe ("drm/mipi-dsi: wrap more functions for streamline
> handling") to simplify the himax-hx83102 driver a bit more. This gets
> rid of some extra error prints (since the _multi functions all print
> errors for you) and simplifies the code a bit.
> 
> One thing here that isn't just refactoring is that in a few places we
> now check with errors with "if (err)" instead of "if (err < 0)". All
> errors are expected to be negative so this is not expected to have any
> impact. The _multi code internally considers anything non-zero to be
> an error so this just makes things consistent.
> 
> It can also be noted that hx83102_prepare() has a mix of things that
> can take advantage of _multi calls and things that can't. The cleanest
> seemed to be to use the multi_ctx still but consistently use the
> "accum_err" variable for error returns, though that's definitely a
> style decision with pros and cons.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 92 +++++++--------------
>  1 file changed, 28 insertions(+), 64 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

