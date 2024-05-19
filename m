Return-Path: <linux-kernel+bounces-183284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1A8C972F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF541F21193
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345E6E605;
	Sun, 19 May 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUveik2i"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FC12E6A
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716156674; cv=none; b=DwnE4cWeskTqJyzy4Q65n7RYBm4nAQhvAWIeSwc/ycufUFALfDicfSaYeKT0zXqkAXmxIcxNjPTjZ9n78Nd5qyQ0X6ZhKxAodDKoGK0uGQP3DrfzYnn4NaiQ99wcD+7VBnVYs2UYYTObOJSHB9WYuQ7SDR4lhi6YFgvxiVtJNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716156674; c=relaxed/simple;
	bh=cuNWaWioxQi1Xv8Pp9i+PgfovACt5mGV+R9zr6jl0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ7kKqDN3jyrhvslJLFFo6VcPbNEi6BfV9knWeL1dsTIx6G0ufDyP3sOIhsmU9p5vsL4Ak9TCS4Vw4LSc+TNG8nC/Q+L2Opv7OLpLvncDuwgTMG2ana45IfVOb2Jkz6W+oPlGfs5OxqldPa3haM/8sodnz3PPTiHz3SVDS/Chcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUveik2i; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e4939c5323so48770441fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716156671; x=1716761471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1yu0CLdWydH2A7Dq3K6QV2l9Q/wS/S04PP8RXlFT9Y=;
        b=bUveik2i6bmN/y+Ue4c5UwToVrjezN3KnghGg7TZffgE3l4tT+4PK2X2XDPad28Kix
         dDIB9kevlAJwdcW28epmq8t4DLuZxI2LzJDijg0BsjsYeVIbMS37DxfGB0DJSfQ47XPU
         rZGPsVhrc64pZkjxPyrIRgtsVZcVgJOr0WbyaMvTy1L90igHGEiEyz9yGC/lJwp3F6aT
         aJsdNJWhD/PjlLDghkVBzXsek6kpoDD7UMMyFiF7knBP6bcHEqdnIq3hW+Xb0+fmqaY/
         5b0wCmMW7bVhQrJejEKG3uNmMq0wLxESLRGnRZNKCCucejh0UTggvw2Lhcm/50isUpi/
         sB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716156671; x=1716761471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1yu0CLdWydH2A7Dq3K6QV2l9Q/wS/S04PP8RXlFT9Y=;
        b=uRc1HEY3oQLvgzIQGKEBFGjRjLXKFfRcTvAahY/Ah/yIrl9a8LRy6VfDfHQJIbe0Ik
         9TT5STGpQPqCKZOfiTbCI00YENe6bo67xVZqkZSiIsp2wMDp75+wr5tSR2fosepD8R8f
         WF+HHTx4DjD6NPP4BYvR50bGwFUOqZroNjMYwRnnVadIki243yDu8e7NfP2fUqQ+w96F
         /6gdmE6papwsPl5NckA7m2EKaKD4kQ723hr1JxzsIPVPjWP7UYEcwR1ACURMiW02Bxp0
         w64d3MD9oqaa2Y8kHBDndf6QukuynOfUMYi8ZLk2agneqKKj0KVTY5HmJsl9rtBxmi/F
         iHgg==
X-Forwarded-Encrypted: i=1; AJvYcCVdx2KpBJXLkciQ7UPw5Y8yvVw1VIsqbPdAHeEKdkxR2Dd2lT47999748Kue9YkBsNqKyJz4MVykk08+/zJoGH5aCH55xokezEv4Z3E
X-Gm-Message-State: AOJu0YzHUSR1MuVAzo3EJgo5sfMkqiuLRQ7CVDB71hLfr7y3NMiWldgZ
	XQG0udUbeoA/k9xHn2uq0sB7jhNj7hXIcH7VcAcH2oNErzrFMkkZAb/xqVfyMmk=
X-Google-Smtp-Source: AGHT+IEUbS+A8dZA0RYQkSPF3yyQr0Ufa6nb98ekU4D8rsUrV4xMgsFpoeSh1+2u1ldrRhMjT0c2+w==
X-Received: by 2002:a2e:9497:0:b0:2e5:59a:591b with SMTP id 38308e7fff4ca-2e56ea3aeb1mr220998471fa.0.1716156670718;
        Sun, 19 May 2024 15:11:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6fdd1089csm11801621fa.110.2024.05.19.15.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:11:10 -0700 (PDT)
Date: Mon, 20 May 2024 01:11:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, biju.das.jz@bp.renesas.com, u.kleine-koenig@pengutronix.de, 
	aford173@gmail.com, jani.nikula@intel.com, bli@bang-olufsen.dk, 
	sui.jingfeng@linux.dev
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when
 necessary
Message-ID: <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
References: <20240516101006.2388767-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516101006.2388767-1-victor.liu@nxp.com>

On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> no interrupt requested at all.
> 
> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> a few times, but adv7511_irq_process() happens to refuse to handle
> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
> 
> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> handling from adv7511_irq_process().
> 
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 6089b0bb9321..2074fa3c1b7b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>  		return ret;
>  
>  	/* If there is no IRQ to handle, exit indicating no IRQ data */
> -	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> +	if (adv7511->i2c_main->irq &&
> +	    !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>  	    !(irq1 & ADV7511_INT1_DDC_ERROR))
>  		return -ENODATA;

I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
instead. WDYT?

-- 
With best wishes
Dmitry

