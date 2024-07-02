Return-Path: <linux-kernel+bounces-237652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E9923C23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA82B28349B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9F15A849;
	Tue,  2 Jul 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2DDBNAq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2426FC3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918719; cv=none; b=HuIaLbIyOw+tBGtK/ixBfE87iukzpa0iOcdpr38Dc6YfCnh3td+OmDlXREiaLza1xJgBr6ws3oBs2D4Cglw3e8IKoMk+q4pS9JrRXSS01DnOOy4LHcqsQagb9i4L+vuX+OOVtToYQcqhef9843zx2w1XlnuWj/S5/CpizupbTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918719; c=relaxed/simple;
	bh=APhj0Lngoh6N/WA4qzO0b9V2q8Q/cBp6IAXd09b4LJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltEih9bVB682WrRaUWPWTm8IQ1b5sKfbtA6CKlC4t2AVasR0Rh95vj/Ep0dnIyCsHY4lSMoyxwRLGP2GOWj9OCpSrQZlDzt9aZk48HMniNlOI+AomciHlght7Jiij4N4G+gDr7+vkjiTQi+FqiSLPrBQMGIRiUIC7lGo4u7+R+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2DDBNAq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so3797859e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719918715; x=1720523515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39Mp1fX4bfFSYhWZekjIyzAibpFreRyoWMi71O4QMSk=;
        b=f2DDBNAqhzpahIEd1jb8v/1A4ayNcJ4t3iHj57xyMd2IQd3wKQEJfeL8rzZ62bk1xG
         d1AwlO0y4/iuNox15kjSNuwK6NGB2azHJ5kEPxqrbS3WPHyZdjZYGRFt6ToAuIRnl7TC
         qEXijhMEspibCQAGV5YcQUlczcygmX5OuGBaTZ3ivRdDaeLU5+mIAKHUm08ElgKxP0rZ
         5fw6V386BqpbdhBjkRaAKEYubk5X4gx6dWIacxYYG7iqAB5C+xV16/ocA4evqh9VZthF
         /9KV+4NRu0fQSpvvOslU54NuCtn6gEShgRAvfr8q8EpOpTJ9r4tV/mp2P+W/pA4xSXDD
         tOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918715; x=1720523515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Mp1fX4bfFSYhWZekjIyzAibpFreRyoWMi71O4QMSk=;
        b=EPV+K43sEv3vfbkmWHj0N/8XpU7l+7BIz0nTwctzQMdVgXomgXvS+L9Ho0VhDsfiz3
         HRWPRwIRkkKnd3D9cldbvmgUjurARCHInIf2YqizPgbTWtAt6X+i0CwAvR/5RcSvO/GC
         uMH4ytQqlt0SnegOzStVxNtCerkto2AYSXHpsVX64dofed9GePhbXz+S7/YWbe+bxuHm
         /QkULTxY2PBQ/D6ePOrSAoIeuERaK6iNdMK+L+A2lC7BlbSwFvkcXOB0NczzCR89DtxJ
         9WIEZqO/iUkyQHvT4JAv55aZHG8BxVcWSj8pS2RsBdTiyEYiCAbhWpl1LltW7PKxWsuB
         nmsA==
X-Forwarded-Encrypted: i=1; AJvYcCWjFhgHbd0a6uKl+OSgu3k0+wvt/SwpPxF14yKkS2IEdpfGt9MF/DlTE0C54pfYoXVhRs7ikFawSFpqVSeaKX9Mp2YH+j5PlWuw2ibl
X-Gm-Message-State: AOJu0YyBvrp0zlOEgw3Y2y7e0Zm5OSF5gCYB1tJDJcJ57sTco+yJWQFY
	CLeBcNaCFLM/AILSlnJomtO5bgP6rr78LlYlJ9g8wp1EQZAiQQgFLsWaLMTQiaItKz7zm0vg9t6
	jc6w=
X-Google-Smtp-Source: AGHT+IG//o7HCzqnXn/QKLpL1+zg6aywFOERJd4RlmKy4pR4tJypdj3qSvh2LbaUUXC+dc9z8yeoOQ==
X-Received: by 2002:a05:6512:2386:b0:52c:dacf:e5ac with SMTP id 2adb3069b0e04-52e827091b6mr5799901e87.54.1719918715385;
        Tue, 02 Jul 2024 04:11:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b1dbsm1761242e87.253.2024.07.02.04.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:11:55 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:11:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/managed: Simplify if condition
Message-ID: <pre5tmzcfv4zwrbuksiacsm56qhmn76wa6xyni7piwivokogp7@nbo5zsnxwsut>
References: <20240701195607.228852-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195607.228852-1-thorsten.blum@toblux.com>

On Mon, Jul 01, 2024 at 09:56:08PM GMT, Thorsten Blum wrote:
> The if condition !A || A && B can be simplified to !A || B.
> 
> Fixes the following Coccinelle/coccicheck warning reported by
> excluded_middle.cocci:
> 
> 	WARNING !A || A && B is equivalent to !A || B
> 
> Compile-tested only.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/gpu/drm/drm_managed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

