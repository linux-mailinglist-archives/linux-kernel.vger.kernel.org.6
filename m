Return-Path: <linux-kernel+bounces-373265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0E9A546F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1042C1C20F26
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB21925B8;
	Sun, 20 Oct 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiLO6oBm"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D54192B9E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432421; cv=none; b=ZnPYKPqjPYTFWllhYjGO5dfN8XutAiwZUVk0acuWOsflg5pwGzjyImkCaw/tJYlK/ajx+588hxevw2M5M8zxUbKkfb9pmHHQwhjJZVXcIWxLy4dtTmXr7R+N4gB9RJ8g+pKV0T1MKfw3FktGZF/Aq/SHSbpNQOdZAAwwjz4YhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432421; c=relaxed/simple;
	bh=/DDjE83B3n4FWeqOnjSinBbYUR8DGcFkPdBAwZ8qEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBLYyjPTkBXdDl8R2k1k9DYImimU5L69XPWRi4MS1Z1/py9F8bN6to7pyAen9h83bBmIxC5oVa4PwFhDWkqLU1LG7flSQEVAj69mDamuEuRJo6pjnyv0dXLIQkQ9bE334vQJbge6UZ0Ye7iiD0pY0nEoGoQQLhMCKmO29gCVoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KiLO6oBm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1472748e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432417; x=1730037217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOuFO1XApK7lWi0ocIJGVQpcUmSA5iEtXQj95TkVeaQ=;
        b=KiLO6oBmjpnpl4JUpphq9cjspPvwL5LwY7WqmbV/WLvlMA60d/XTb4sMaT2e7Abjl9
         +pd/xXfmAZoa9kEkI+aOmH1fneU+7amE245pp+1drK21DSUSFGisNlcsfw0aaodHFdTh
         Gsnc69TS4uTQXOsjjLrzgXGdkaCPTzkggBS+3ed5SaJfSlKz5pHRvsMVN1by/uVoO6yZ
         S1X0aRTtkMQr57vE/UwFfdZ+c1AkAFYHxRfStIoVtoFcMkLr4j7T/MERLf4wK3Z41NbH
         ZJL2Vmx2rIgZ8PeuMV3tPJg2tFhMrG5vnAGRClhTKBhv/9cy8o3IQvmNwS7bUygkixYO
         YDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432417; x=1730037217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOuFO1XApK7lWi0ocIJGVQpcUmSA5iEtXQj95TkVeaQ=;
        b=X8vLdPQo7DrZYCl77ngOOd0s8FnQfotpoI/XI5bNUfCrEQ13A8TdQ1xhj0ZliBrg4W
         fTj1PmEkQvKn825EM60/scAGQLS8gffcUPMmW0m+2R5yNrmDzJN/veJ6mysIdrNr7ezg
         TOqzSm4+eS5xQmNLTnMQUgdZ0v4SnXyPHB7siWCRdmv6Yyvq09z8DqiSBWANd8Pozj0/
         E0H4YbWuRyH4rPDARCMV7y7VbZZYswi2YhGP0ZcQaCcoy/wH5GV+lDoou8CHHlBc7pK1
         cd+HV6BONzS4tRDVGtpvlanDez8OyO+UntciVk/f7E6b3jal4y5/Zp1ipXGQRt7vjXH9
         yOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDGENQbDiSIOlVG/yn9D8bPqV0tUD2ja9qyX32+/gPeAXFApXQA0HLtDRPKGlddUCZQAi9/g3xYYbsF/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRx0tlS6tOhE+mnh0vtH6TvRugwcemPB1oRG5bYYiUTUOD89Uv
	zsyWaK4mdozoip1RE9B9lkP9W6f0+fYtKTNjalInT6NT6zFvPBMbC05T3l0pD6s=
X-Google-Smtp-Source: AGHT+IG1ECX7k0ZRy9wiVfYsGu4/HiF9PAp9DXVVa91IJVug3PAhPrdZylY14mOGVojrS7cxiyPHZw==
X-Received: by 2002:a05:6512:4017:b0:539:a924:74ba with SMTP id 2adb3069b0e04-53a154a2c0bmr3834476e87.56.1729432416836;
        Sun, 20 Oct 2024 06:53:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223effa5sm230074e87.88.2024.10.20.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:53:35 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:53:34 +0300
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
Subject: Re: [PATCH v6 04/10] drm/bridge: it6505: Change definition
 MAX_HDCP_DOWN_STREAM_COUNT
Message-ID: <itqfr42yvg5n322uhjgvydxtffcsgbngvvg6or2xghah3xyjse@lsdftsvl4zdf>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-4-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-4-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:16PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> A HDCP source device shall support max downstream to 127 devices.
> Change definition MAX_HDCP_DOWN_STREAM_COUNT to 127
> 
> KSVs shall save for DRM blocked devices check.
> This results in struct it6505 growth by ~0.5 KiB.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

