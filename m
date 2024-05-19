Return-Path: <linux-kernel+bounces-183073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72BA8C942A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7231A28125A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582162A8CD;
	Sun, 19 May 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUqTMOpr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE94241E7
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716109760; cv=none; b=dlJ7u+KBJ9xgKyTBuXyf+elMEEnSfH1Ya/VF/NYbpBiRQ+xnoWkhmYPZE5SzqdS27pOyhKPFnfZ9Xw0D6KP4eBBx6UBxAmbpz3SxYwgIqv5m5cQpjswbFcujmRRaomiJusaaKKbhcEgOz1KiyLgZ+5ATeg/qI7+xazPL5qn+918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716109760; c=relaxed/simple;
	bh=A8/wcf79ss+r/cQ/bogO/6NQ5kpKoWduLqlNf/MN2Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJSCUqvgz9zOg/7ExK8VKf8L0fjlHj/c46/g0GdKdD1GKuVk0J1JxNeVh7cNT52T7rwYgi/FC2Ul+mQW5d5LrvT0CD5Kow19Hrt+1VU8o6e0pQ1cie4fKVr6LN8wbS2BIXIB1xGstCm8HoSTQL8rcBetY3mycue6+irtEfc3lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUqTMOpr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-523b20e2615so4001869e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716109757; x=1716714557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rui2ioBF/hbydLGK6+LX/Bpt5Bve2Qi/2ftvoYfb94E=;
        b=AUqTMOprYlkumpGwiEcv6xGGwYWgcdmxI/IWjhJiqLgShnPUq6xcLyE7Jz/hBaHz0B
         M4BjR9eWI3LRrkFrmJ+I/iKdR4bvWNqEf8HRgflM9UV1hvzDB1dVd5EOJyO0f4XhQqKp
         /iNPREf8+5z85zaiyP2C/leDK7UaGSqeXVU9H7PJpmayJub2fExgiBTk68EVSwvX3qOo
         RKvne75vdOQSqsb2bB0E3yVi3JGUmIVuZk9ivotoLuQdWWn0HrNreRvbMeK2afqBZCKd
         K7/ErW/2ogXq9wZ7vKEEnPevVzTMHhlEnK+KRBLit09RHPaZqr8yBx6vQkpMB+eQtJCl
         mcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716109757; x=1716714557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rui2ioBF/hbydLGK6+LX/Bpt5Bve2Qi/2ftvoYfb94E=;
        b=JxA1oPh/3C5/SuIp93aG2md1DDqipjenFyby2xa/rnY6Ij+QIFw0MTNaK19ywKf8MF
         PsQY429Q6Xt+8FLkedusomgQaG88BtB3UGMC/DqrRQG9XoZbcPCh6+/OqlMg4hxQS5Hq
         x946nNO+3gAVtCD3zO2+lCRaL+iJpQRuvQw8P4FVCachICJcVhpqKTbcN+L0Y1i/T/os
         /R9YBLc2OOJreyIXsp+bQBvnyyheBZ2a6TMWdakjCMHGvhmq3jdfovAVNYecgJH0qMqi
         t6NB/M85sdQSTdKpGWrHcOmtGdWZ41b0jwrT49uOMqcNb7Zoya+xVe6jStiRgm/q7Tqk
         E5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWKx4J/Uqw+AztCaa/PWpcr003Lt/1tVIrFGCTxTdcddd6zdhJY6X+t7W2v0rm8K396tzPY4ozoVYm9tT0xxbAkHhalE4K0gHHGshoX
X-Gm-Message-State: AOJu0YwuGhAfOvEGK4w2lU06UszNXFvd48p0KDv2YcF5R5ynQT2Flv3V
	DTO4klH5WfD7+t28Q1COSDIQnCiteS4cHWm7eXz3qGMcQ3mcLLx2CQ6iZtVgiUE=
X-Google-Smtp-Source: AGHT+IEeCPkOu5RpLfTq3OVpZwEmUGbUNKvVTEJ35UIr65PMPCTz28rrIvpzhmNPUy97SW8iYbSM6A==
X-Received: by 2002:a19:8c4d:0:b0:51f:2709:3641 with SMTP id 2adb3069b0e04-5220fb72e2fmr15611199e87.26.1716109757214;
        Sun, 19 May 2024 02:09:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8edbsm3836307e87.239.2024.05.19.02.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 02:09:16 -0700 (PDT)
Date: Sun, 19 May 2024 12:09:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: MarileneGarcia <marilene.agarcia@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Ripard <mripard@kernel.org>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>, 
	Imre Deak <imre.deak@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>, Douglas Anderson <dianders@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/dp: Fix documentation warning
Message-ID: <5e4fs3wjlnqjmbxsu5y5rksqcjvhzwyofhrahvnypbdrgjaf4t@bzm7z4oqvtz4>
References: <20240519031027.433751-1-marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519031027.433751-1-marilene.agarcia@gmail.com>

On Sun, May 19, 2024 at 12:10:27AM -0300, MarileneGarcia wrote:
> It fixes the following warnings when
> the kernel documentation is generated:
> 
> ./include/drm/display/drm_dp_helper.h:126:
> warning: Function parameter or struct member
> 'mode' not described in 'drm_dp_as_sdp'
> 
> ./include/drm/display/drm_dp_helper.h:126:
> warning: Excess struct member 'operation_mode'
> description in 'drm_dp_as_sdp'
> 
> Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> ---
> Changes:
> This documentation comment should refer to the name of the 
> variable to solve the warnings. As operation_mode is the 
> name of the enum, and the declared variable name is mode.
> 
> Thank you.
> 
>  include/drm/display/drm_dp_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Fixes: 0bbb8f594e33 ("drm/dp: Add Adaptive Sync SDP logging")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

