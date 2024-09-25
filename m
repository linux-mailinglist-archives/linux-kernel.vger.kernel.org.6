Return-Path: <linux-kernel+bounces-339451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD3986543
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64384286A18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6F61FD8;
	Wed, 25 Sep 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4rqDgnq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954834CC4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283809; cv=none; b=Se3NsCGUy14vwYMcBjAfyoBGiKRKANyZ9E7uwWzFX0EHMw0yXVWYJ5wTnjeHroHK91TlGFQmVcF2/kS2f9lKsxI7otMQnIsMFwpxigNGOGejfhPHUgAzEM44OHnaL+ifMUhB4zCMbZWLgGFDXcu6NH8XJEkesKMVl3aUemnIWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283809; c=relaxed/simple;
	bh=8+CiQ3ct7rP8E1uUkFTQatMNfRnyfIR+m5/LlxoWnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX80Zc3bqjUytCZ+k6aRqSLpvnjemp0nP+Bs3KwdMsU1Zu+om6Iy1A4vcsSncl3e4RLh1RRMc/y9L51cNEqBmnVCwnphVVcuUJK6t24RgrUTOSBE5z37C3B3v55wJOpGDBkPGdAxMSet3D8eKqZeJGrlCctExBT3jEjpE1rjlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R4rqDgnq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so632131fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727283805; x=1727888605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Fg6bmoR8ixQy+AhumLhzrwdCnArsHCxqvb2WDz5gM=;
        b=R4rqDgnqI/WXe9O4A0UlPLovLq8bhtsUZpYPGrNtekyRUSOfdZ40GJAWDH9qmLpVep
         dxHJSDVK8hmIjwMpFRnT2yU/4tPIasDgifPs6i5L01Z/Z+VYoN59shrLrC4wAvX9Fx1z
         jP9N4zUoZRZHgc4YXvpeVGw9U5+aDTiofJF0CVIfuTVk1Gxq++DSmClYUH7A2bgf2KHu
         8V48i+FXPSh5UJ5yjeRG9xhEKsKZ78dzhmdjLVHpPwuOB+iESoF99O4zzU7uyhDFBIbt
         z7R/DNOTia2EQhg8/QLswtcq9qpd5oTl8bq1NrTA0rVJXHqI2PRikDBqGFN7TnDCT+3r
         goqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727283805; x=1727888605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6Fg6bmoR8ixQy+AhumLhzrwdCnArsHCxqvb2WDz5gM=;
        b=OZZuFQc797qE/5SJ8uGMS7yiuPuw47Ga2Dp54XFwYYnRHCPkF25fQPtXaigedg/vVz
         oYUnEv0pXJWUs6iCg0ydYr2UIpb0p7EW/TfbIkbSzvWRtLbcxbcx05taLZsFozNA7V4z
         3rHnE6El7ELnWWZ8LGJWcshfYdW7OwvTeJiTg2XY9Vh6gVpYwc8gYCXgSuZtzYD4DsIY
         Byz7Ry0CLXtyVdtRatJFMVfC8kJDAmauznUq7cB61JE4uyiVTB2g74YB/UqlKD7nj9Ev
         PPzNyXqYo1rdNspld0srER3xQOMs/cPorVFoDrWdWDiMnT0Lpnp6bTptXHdTCNvEq+em
         r4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUBShuM+7gA0aPpQMwOn/31AQzh9lBKvjRGS5ktRwBzb9VBrxcaRhQMg5dIE7K0tEBQOsWeN7Yk0BW+74g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfo8STWNeJ3o7IBwW6iXWZarOrDHHmQBBPO4EKfGr3ciCLsvjp
	TISbUVRA6/gPz0QTiPmKp52MnJmdQohBkRE5Qhrz5ZJtB1Z9iAPMT9L+mN+XXd8=
X-Google-Smtp-Source: AGHT+IHxEVAWh+SqVB2ZgG9Rr+GdG84Kf38DE8exr5lCzUK2QGxCZsyQeBBosbZOMBl1IwFN7iL+xw==
X-Received: by 2002:a05:651c:2126:b0:2f7:94d9:426a with SMTP id 38308e7fff4ca-2f91507e2fdmr37353561fa.5.1727283804796;
        Wed, 25 Sep 2024 10:03:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283b661sm5555621fa.33.2024.09.25.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:03:22 -0700 (PDT)
Date: Wed, 25 Sep 2024 20:03:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] platform/chrome: cros_ec_typec: Disable auto_enter
Message-ID: <vnemjw6uo3sydriabdrzwinbnam2xitrezrw3ztcymi63zakep@2rruplyjzuol>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>

On Wed, Sep 25, 2024 at 09:25:09AM GMT, Abhishek Pandit-Subedi wrote:
> Altmodes with cros_ec are either automatically entered by the EC or
> entered by typecd in userspace so we should not auto enter from the
> kernel.

This makes policy decision for the whole platform. Consider somebody
running normal Linux distro on chromebooks. Can this be configured by
the userspace itself?

> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_typec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ec13d84d11b8..e06a0f2712ce 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -294,6 +294,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  	desc.svid = USB_TYPEC_DP_SID;
>  	desc.mode = USB_TYPEC_DP_MODE;
>  	desc.vdo = DP_PORT_VDO;
> +	desc.no_auto_enter = true;
>  	amode = cros_typec_register_displayport(port, &desc,
>  						typec->ap_driven_altmode);
>  	if (IS_ERR(amode))
> @@ -314,6 +315,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  		memset(&desc, 0, sizeof(desc));
>  		desc.svid = USB_TYPEC_TBT_SID;
>  		desc.mode = TYPEC_ANY_MODE;
> +		desc.no_auto_enter = true;
>  		amode = cros_typec_register_thunderbolt(port, &desc);
>  		if (IS_ERR(amode))
>  			return PTR_ERR(amode);
> -- 
> 2.46.0.792.g87dc391469-goog
> 

-- 
With best wishes
Dmitry

