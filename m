Return-Path: <linux-kernel+bounces-359559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE79998D53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C00E1C22316
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C21CDFD1;
	Thu, 10 Oct 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEFaeSdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48677DA62
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577553; cv=none; b=IPtyVQAOph0tIiKhTJ4IuRSUNMY8+rY3ObENe4ibnf9PvFDb67cmf/1f/YzIRqqsC+vu/S3KVJqmttIKY7YnSV2nOf2h+cDm1vGXMxd2t8gHgl08tk/yN9Q77sTsQMh3WdTHnEi0ETpFZCfGypja8RpVS9xO/qSrBicXNZWz4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577553; c=relaxed/simple;
	bh=dvlME7cIGafoPlXr0vrZLAnMPMxd5hylDvxsIK90mBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLNgvivDGMX9R6dEV1FkBNPm2IiAON75UlFDpeUZAqyR75WnyxsD22jKHXXztPnWGwhrVKvXlugQ/S9TkSPeNCe89llxMjtsaVup8GyPpMccYJCSH+gMBol1xjjvzhd3UPSrY1fJ5JBuzG5FPREE2VTKzP5aFJXVJcdEHMj9cGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEFaeSdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E75C4CEC5;
	Thu, 10 Oct 2024 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577553;
	bh=dvlME7cIGafoPlXr0vrZLAnMPMxd5hylDvxsIK90mBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEFaeSdYbaJNRDBzMzt5gJDKMbtLJZS07gnhmIHJoS4Q8dpJA6mdXqdEzvRbKnebR
	 3PPRJ0h4OosI45rxXD4Vfq/7YOH8H2k+KxTDnEJJoytdpiWWbteZ6pdGidxMFSLAiG
	 teGVlM0BzRssrV9DfwvtVt9C+D1ABgFGQY5rhugpGtDf+xgTRZHZRxvd/vhBo2oMfy
	 VwVZUEHabjN84pA66Wd8Y1DYaqR2sbJnK8JjK7CqZNHWRNthh1YJRz3vR/Hp4P370d
	 xwIhFw2vXyyKVVqE0vJuRiojWLA1QX1nV3L+eb+aEhBi6SYtnZDxqQGGmY2ktKAo0i
	 yrq/ClO/qL7uQ==
Date: Thu, 10 Oct 2024 17:25:47 +0100
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: atmel-hlcdc: bypass LCDC pixel clock divider when
 using LCDC Generic Clock
Message-ID: <20241010162547.GK661995@google.com>
References: <20241010093132.235177-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010093132.235177-1-manikandan.m@microchip.com>

On Thu, 10 Oct 2024, Manikandan Muralidharan wrote:

> In sam9x7 SoC where XLCDC IP is used,add support to bypass the LCDC pixel
> clock divider when LCDC Generic clock is enabled.Used to match
> and drive the panel requested Pixel clock.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 8 +++++++-
>  include/linux/mfd/atmel-hlcdc.h                | 1 +

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 0f7ffb3ced20..c54770cecaa8 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -146,13 +146,19 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  
>  		if (div_low >= 2 &&
>  		    (10 * (prate / div_low - mode_rate) <
> -		     (mode_rate - prate / div)))
> +		     (mode_rate - prate / div))) {
>  			/*
>  			 * At least 10 times better when using a higher
>  			 * frequency than requested, instead of a lower.
>  			 * So, go with that.
>  			 */
>  			div = div_low;
> +		} else {
> +			if (crtc->dc->desc->is_xlcdc) {
> +				cfg |= ATMEL_XLCDC_CLKBYP;
> +				mask |= ATMEL_XLCDC_CLKBYP;
> +			}
> +		}
>  	}
>  
>  	cfg |= ATMEL_HLCDC_CLKDIV(div);
> diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
> index 80d675a03b39..982f494e6307 100644
> --- a/include/linux/mfd/atmel-hlcdc.h
> +++ b/include/linux/mfd/atmel-hlcdc.h
> @@ -44,6 +44,7 @@
>  #define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
>  
>  #define ATMEL_HLCDC_CLKPOL		BIT(0)
> +#define ATMEL_XLCDC_CLKBYP		BIT(1)
>  #define ATMEL_HLCDC_CLKSEL		BIT(2)
>  #define ATMEL_HLCDC_CLKPWMSEL		BIT(3)
>  #define ATMEL_HLCDC_CGDIS(i)		BIT(8 + (i))
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

