Return-Path: <linux-kernel+bounces-217093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868590AADD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B420BB28E33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC898194154;
	Mon, 17 Jun 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpvvFJYc"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525D19047F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618275; cv=none; b=EBheMShacVN3w++aNBZQ5WqRDmL9lupIxpwwYDpiM2023r5+sSecmSRbB53dI2kcXW5LLZPEoNniOMwELg2jVf/iGxQZc1QVAZ9DqRac2VbU2/kVwCFyWyrOULzeusXvzarQUr3GQtYdjgtSwrGk82E7vNfYRqahWppJRhf/OUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618275; c=relaxed/simple;
	bh=PrV4VEI30qeYGma2/K3q4eVmI6pg3wGw1kNQ5ChwWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COclTI0WxK+U+K6MPaZcHmF6pjbS2zOGQrGj7rFNeY6l30kryx3Ylkj0vRHfw8dwTDKfvrVBY/DO8mCs3bcs85T5UjvMmjAuExxH1+CWIF5EYq9u8gaoMl0h5YZP/YGn6oXj3ptlHoY8AMbqCgpQsWPhKAx8XDusRIJUAaXcKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpvvFJYc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec2f4966a2so5894611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718618271; x=1719223071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpoL09JxB35FJ5ImuHuqaZBN/f8BI3/8KeXWtW7kk7I=;
        b=DpvvFJYc6JeFd5K9e8HseeHLJOTSxJ9FWRpSIb9iRH6QcP/9zfIr4vdxDc7c2WubO9
         /0RK4N75s8DuKbSKxbNbqXJELE5S5WRpQAWRADvco6ajdCqhERCE986OBeMsUX7BOb0K
         fOGWD0TMFIKm/2ZMBrCyNIRIFq4IY7lBULoPtUbTNF+N9Pc0evd1v09uJIW3K7S7wWIx
         q3VISWXRnuTTMqdaUimZ8x+vnl+56vHj3Ukk9n8gsy7ghrpzODp0CKnpIz1TTLYaSrYN
         8+IEujH2NOh+Zuh0tF55sL04fLm04R+B+slOEOi8SLWBcaDd3eEKZiUeoJo674Z1nYUO
         9Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618271; x=1719223071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpoL09JxB35FJ5ImuHuqaZBN/f8BI3/8KeXWtW7kk7I=;
        b=bEj4vY9yhZwXknzqexNSnn8VgzoIAxYuDYaddV2HAwsUuBr+WEdCOVzZRayK81aDyt
         mXbUXyeukUTrw/I5eo3hOgXS76Hjoc+sS0EyNzbTzy2gBfrxzDv7VROlTlc4XEnBqSo1
         ZUb1UmxSIcTGyIbw8Ty3KkPx0S9AkQWdpRvqM2uz480/D+hKSOHymJ1BCVx+puz0Jge1
         9heXmt1B0cn3nTnYB2IrJ2zmHfWhWmiTvzCq6onI4kqUIdFXtnfdRHG5sgXf7ZVCJIGg
         aUwZ4V6T6sS8cBkJQk3KhxiCNXwiklNQV/grKQhDUXuIIVzB/5BvWT2znst2TP1SnYsA
         Ocqg==
X-Forwarded-Encrypted: i=1; AJvYcCV7ea+sKvjE8t8lwcecFb/9tE8O7JMCrH9yFn76ic6lCqtIyiRCFoxlvTm4YL24OA7ITMOzOyeXVERjBjor/b8t0Cd+wAdDNaebTz7R
X-Gm-Message-State: AOJu0YzLG2fZzsvpjAU5H8Z0tvdv0tb1Cq0espvql1oFfxSPsz1PlKxI
	H9N+AmGaWR/rVS+T3taxCXM3HSCExbIiE4dilD+658hOxXjsl1XGah5Qd5DJZXE=
X-Google-Smtp-Source: AGHT+IHzleOF863+St6gLFWi26LpebCOh4j1P2exxdVoLWaAvyxh87B5slPANvXBUl2QDK0yoYiihw==
X-Received: by 2002:a2e:7a0d:0:b0:2ec:2c65:2dfa with SMTP id 38308e7fff4ca-2ec2c652f76mr22644241fa.6.1718618271445;
        Mon, 17 Jun 2024 02:57:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c78400sm13171961fa.84.2024.06.17.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:57:51 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:57:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH RESEND] drm/logicvc: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <uegtnit6luloxwqbfbwirnt4wytgwfjg5nn52uen6fkhemqukk@4b26w7agpbqu>
References: <20240617103336.7fddb08d@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617103336.7fddb08d@endymion.delvare>

On Mon, Jun 17, 2024 at 10:33:36AM GMT, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
> Already sent on: 2022-11-21, 2023-01-27, 2023-12-02
> 
> This is one of the only 3 remaining occurrences of this deprecated
> construct.

The same comment as the one for your drm/display patch.

> 
> Who can pick this patch and get it upstream?
> 
>  drivers/gpu/drm/logicvc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.6.orig/drivers/gpu/drm/logicvc/Kconfig
> +++ linux-6.6/drivers/gpu/drm/logicvc/Kconfig
> @@ -1,7 +1,7 @@
>  config DRM_LOGICVC
>  	tristate "LogiCVC DRM"
>  	depends on DRM
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_DMA_HELPER
>  	select DRM_GEM_DMA_HELPER
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
With best wishes
Dmitry

