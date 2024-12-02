Return-Path: <linux-kernel+bounces-427532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A589E0562
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E87B2805C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A201FECB0;
	Mon,  2 Dec 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjlbe3C4"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317CA95C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143837; cv=none; b=u+a3ISFAUAPCNFwD3jXakQDxGDcZ6Ccze/rzn/VIMxBF9j5tJk4vbN5VjpVQZs8trKOzWQIqIOND3i9i9B2rMvDvok0yBTbpnzufUFuRycrU9vxva8i++GvOJ+Eb/OV6TW1QOFEz3jXUMSLYEohaIt6GMmWTdqEGir+gHJESufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143837; c=relaxed/simple;
	bh=wsJArcHrKn3NAjHwxEzIbysmo4J0M73PAxzu+AMIs2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjSXbWJRwiH/49Z6r7TZh198u7V036jx/e1ZGxoJW7IGW62Eue+4/9T4W/NIpFnoKiphtlWdJurFOBTx0u+cwvAVr0Z/UHZFBJ7XhauOXrHvYtLeK0uu/L5TLUpKtAEbof77Km6MjAXoiIugG5IuHcJvA+IJoBIXfDTQZoXitfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjlbe3C4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de556ecdaso4156668e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733143833; x=1733748633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gR00Y7aC6qABGWf6TSpdF1xwTEZztd/zYEK2dEs/vb4=;
        b=jjlbe3C49hfdDp3X+zlqYaEakNiO2rZh6osM0CNY00GpvXC+mFRK386nrJQUdpgpFe
         tE3FJN0c/jmIkI6bXZU35EQ7mu2L+HzXNRLUZ/a33s8672XSzzCxc6bNovuvip1Hl509
         g2yZAeo0XtoygmPsWuxm831bxH3MfPznm0HwZsYnvS6rvKG7K8WGAJwJpy9Hl9m6pMWn
         HKvpYu58TMKR8UEy/3MDepPwvt3LWonqUBHRglTzqFqiNSdT2ys8vnA1Sg/wWTkmmYx8
         ALkN0QHlbDnbqckVMcrJGxDLcl66TbUHpWxSlualc2B5/kMPbzSUyUnjBZZ5rDz6QFYg
         VhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733143833; x=1733748633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR00Y7aC6qABGWf6TSpdF1xwTEZztd/zYEK2dEs/vb4=;
        b=p3jrPwX3uI+dgvQDFdBuOUH9eDCoejJ37esLXCZuskLdeqhLukX7v27HWYTrVDuxEB
         pTxkOXfBM/Ne+3y3pPTlnn8ahuOFkz1pDD4kQs7ZlSd99hsXwDB3wKAuUijoNwpW2qxV
         CaLScMV2ZrKCl+2VUqk3yfwL3aPUWMFPK5Ua1z2s46BEI1a+cIoC0iV9FSvoOuHgKbFU
         f8bfSfcRHeCExBcpr3iKMggltQcyThsU0CcnZQSO0Rexj05aL6La5iXrLtn2sjXsgcW9
         Hiq4ICt5+FNM/G8P2RW5F38lofBMrNl2yPcRPalejxL83EihggCbgL3bwgBF0+e4LL9A
         fJHw==
X-Forwarded-Encrypted: i=1; AJvYcCVXXiDj7WE6wAIA+u/Eh3uIkW575jaZ4FChwTR2dFrjrAbmXxX20SGaMk5TV8Dtjyz8YDeh91pPvDRHffk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPiZ049mEfEaLb/nZZPGevsnpzJpe5HPjMjCi2Wckz43kAOCg
	FBG66QPpTjyN4kKPu2fHh8Yr7wZH0PSI4P+8NqWIhPsFUfD9fMALDgXOoUwTXDs=
X-Gm-Gg: ASbGncv/AJqRcrrIj0Qabv6t0/sfdbqCWD/dsi0SYqA1DXb2compNt0Tg6ycS/XLQyw
	+uk2l02Dv6jBn+awBsJqMGphKNH7ph7/+74A6iq5OKKvwzXWUsF2bHyS3wwt3ljGFqdhSzt5fyL
	1XGp9XpB5Q8GVFxWxbIqR4cvLVY1KVHGsXhpwwlj+kMT8cqlENjZYnDL5KtnJcmfEEV658BNmW+
	9pJL0CQng+sox1crt6VkJ2EPHVDarQyBLo/cpQrebmVdnuX+HS1g5emJFMKEtkQc6p0JaBrJ0GY
	et37SeV6OeKbHoz2ede9Y6hzjkq6Lg==
X-Google-Smtp-Source: AGHT+IFOtbglEGI/q4pXr3wFhFC9dW1ANV1WehPk21HBJswjUAeAzRtsTqIj50RgnqdvfxR/wi+cIw==
X-Received: by 2002:a05:6512:220d:b0:539:e65a:8a71 with SMTP id 2adb3069b0e04-53df00dd2cemr12320514e87.34.1733143833517;
        Mon, 02 Dec 2024 04:50:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f62dsm1472540e87.245.2024.12.02.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:50:32 -0800 (PST)
Date: Mon, 2 Dec 2024 14:50:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Remove redundant
 assignments of panel fields
Message-ID: <h4nkbvwohp2izu4mzyv6nih42nqb4yspyxxqwyhojcgxvn5mj2@frar3tof42ds>
References: <20241202062449.65593-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202062449.65593-1-wenst@chromium.org>

On Mon, Dec 02, 2024 at 02:24:48PM +0800, Chen-Yu Tsai wrote:
> drm_panel_init() was made to initialize the fields in |struct drm_panel|.
> There is no need to separately initialize them again.
> 
> Drop the separate assignments that are redundant.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index 272490b9565b..1df5303eb57c 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -193,7 +193,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>  
>  	mipi_dsi_set_drvdata(dsi, ctx);
>  
> -	ctx->panel.dev = dev;

No, this will break one of the following function calls. Please refactor
them too.

>  	ctx->dsi = dsi;
>  
>  	ctx->supplies[0].supply = "vdda";
> @@ -215,8 +214,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>  
>  	drm_panel_init(&ctx->panel, dev, &visionox_rm69299_drm_funcs,
>  		       DRM_MODE_CONNECTOR_DSI);
> -	ctx->panel.dev = dev;
> -	ctx->panel.funcs = &visionox_rm69299_drm_funcs;
>  	drm_panel_add(&ctx->panel);
>  
>  	dsi->lanes = 4;
> -- 
> 2.47.0.338.g60cca15819-goog
> 

-- 
With best wishes
Dmitry

