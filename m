Return-Path: <linux-kernel+bounces-196033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8148D564A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376491C23067
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CC184124;
	Thu, 30 May 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsZwkpy+"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8417D346
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111859; cv=none; b=fqxBfuoakkc1MrbUFHDbt8Z5wskjVaWDS177WGHELUEAW/72zkku5TEKNkbAh/zY3cHuYqH5EkMyHmqkY+nxDwKBdZBpV8t7DQpHXpTaE/cm+Ngb6DdwobkaaLlwQuHdzxAU5KknaUI5rDqGaq2Qhqw6Y+Jse3hu7WcZcyW91NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111859; c=relaxed/simple;
	bh=KSRSDmHQyX2bSI500aqnRNknWla/y1id5hPtxj9FCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv6ghu8KjWsqnzo6LKKwUDvPaUGBtsYxRZbTM0Z5E+3OE+kvRWN2JztdArTnTIPx/wxQqrIUDqfajn6ePWLFF99pAx3Qeq2sgkEo0XPnavI6jE4s1cAexXP1ZCNwmGfiR0Sd6k1aYYk60y+6QbAMtS564kZmkGQLE5OrNbxrkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsZwkpy+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1491365e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717111856; x=1717716656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy768pJR9cLFIdd6Yx5kMuhYcotmFOIkzIsvZV+Yils=;
        b=xsZwkpy+ww+Ulb4TucEZ/+rvFxPJ7Fo4aCxgjUJTEs3/N6dWfBsTYSCGtApbKJtTUs
         q1gP1eIBXEJmDzMrWsqMM0cxfaLbU8AREBVkCkthPoD8Mpd3mPB/qdWr/Fmzayt1U9HC
         Lk0VlV3EGplzOgXo2Zs6FJCOQj0DH/KomFvefCNnjFs07E8S3CGeqqX4DqpwhBQRkbCl
         OEwIaygI3hRL8Eea+d1JZYdDa0PCMt7zlXetM6OJ0b3abZLMuWlx3CwCsXsTPX1Pa6RT
         fXmmLLK8IGlWNSrR2DuA5XFAZhI2jJJm4rvin+QE3afH02Ey+d4f8fWXZi2zRp4I9N6q
         Obuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717111856; x=1717716656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy768pJR9cLFIdd6Yx5kMuhYcotmFOIkzIsvZV+Yils=;
        b=FGPkEVV8uLgQe3Chy6vovqdOB565zpskU5ikK6tLVHPUl/rbpx10Ch7DWzjUDk6pzE
         sX/2zvPpfLLa34CzAsSV90CW8PhFHMFEsxmU4T4Ritu3ykbnrAUnK++BEABTc4qL1EGr
         IfXXqCZRsekzbn98Mh+nrHJpdTYFuuvpDguctEoUtLU9U/5y6aM12LCA5iQrMuhLxjFr
         NnM4s25kWGGrOfZhEtOTYyoClvQbY/rwp7A8YswqwpmGatjWmHGZdVCc2UI+3wVjRrcS
         Rcq0NPoPtMf2zJJtosCFtOZV4GMZBZKnt2CJ3ohv5GOdQecbevWwg51dmdd2fdjLUSln
         vsEg==
X-Gm-Message-State: AOJu0YwpcWeMD66yXfxt5kTh6zLsDqbLg8rSC6W09xcd6J8Ag61O8rtX
	IqBEVgn1+vromay3w3GvKeDOSBxiH5rtWeSSeVuJ5vvJN/KLvvw291rhkGPlln8=
X-Google-Smtp-Source: AGHT+IGsB/ugPpgy96+NIEx08Z2+CgvenCRumuYN/yJDk0qMmI250mrqJk9/efH0D//O6Mmos4Qqaw==
X-Received: by 2002:a19:5504:0:b0:52b:6a18:5b00 with SMTP id 2adb3069b0e04-52b8878cc6bmr104632e87.34.1717111855617;
        Thu, 30 May 2024 16:30:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75fa0sm123961e87.143.2024.05.30.16.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:30:55 -0700 (PDT)
Date: Fri, 31 May 2024 02:30:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>, Chris Healy <cphealy@gmail.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	mripard@kernel.org, sam@ravnborg.org, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	a-bhatia1@ti.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <qiu6rar4ebaxceufmy6rppxetjqi7goajc46c63aadd5o2uwjw@ctsfmqk5fdvb>
References: <20240530092930.434026-1-j-choudhary@ti.com>
 <20240530092930.434026-2-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530092930.434026-2-j-choudhary@ti.com>

On Thu, May 30, 2024 at 02:59:29PM +0530, Jayesh Choudhary wrote:
> Currently, mode_valid hook returns all mode as valid and it is
> defined only in drm_connector_helper_funcs. With the introduction of
> 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
> bridge_attach call for cases when the encoder has this flag enabled.
> So move the mode_valid hook to drm_bridge_funcs with proper clock
> checks for maximum and minimum pixel clock supported by the bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Chris, you might be interested in testing this series.

-- 
With best wishes
Dmitry

