Return-Path: <linux-kernel+bounces-394833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C709BB4A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD2C1C21EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FE1B4F3E;
	Mon,  4 Nov 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGw16stV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4A1B394D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723092; cv=none; b=cRcov7iFCU0J38y3vV8OVviCwGk27hqSEEbHGOAnfFYcXLFbSERSiEHX75D8GQ6L+Ch+v+PESrf3NtZ1UdMP4yWYzBXboTFIZ6Y3Dcgz5QbRCt6sIbxjcpBe0V6/djMNMagT4c1bZvYfikIf43NYLQjPkSqxTmJHogNukm8r/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723092; c=relaxed/simple;
	bh=LaY31D8K7Uu9gLsVDS9MJ9I0MMD6loTYipnIxJrHwSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsP60GQrLnrjynGOShe82ySsDdg3Bd/F2YbJVzCtlI8I0+uZvQ8vDHQ0w1Ca8bhawJIJyn+gRRbqu6BRJdKRAmDwR9tTNNrxQA+5EzmO3z/B11i49+OxFN6IKQeJsahKUNMs2GXRtnzQoGU7Lws3JVLg/xXhMxUzgeKE2KG0wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGw16stV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f7606199so1696323e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730723088; x=1731327888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WamoS/BgPz7m8LVkuxxtzepst1v3gBVxNsdSxv3r2v8=;
        b=GGw16stVE878oDD16sOMPGF2ERlEoQRcNEMVWIhevHnhu7eOVmDOWwqzAa/36mfQ+o
         IpJAFvOjyjdxdwmlqKONVx0wntFTuHyWeRBO6SNDbx3nkCeWO5GM5+xckSfu8g14qlJT
         k3lhDG/nKd1bSD9Sw02gSRU7HiRopvPWHPW472xBqCc4i8cn8A0yuanK3/HeBlBydplE
         8PKSP8ez+BnpxGCBIuLrZBwgEU+HeuaNwiiEYhPgcYBqG+6SQViFaUs/l8s1HJEA25uq
         rUGyFjiZ9urbReS1e0e/eEmdEnji2q128DZaYKWuac3xTpt4yURj9mciCgV3EskZkuO8
         RvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723088; x=1731327888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WamoS/BgPz7m8LVkuxxtzepst1v3gBVxNsdSxv3r2v8=;
        b=RNZQMfCRsTqD2H5FBvCFzGD7S9Us35LLmwH/qoNLZ1WLWjqOWoT9SEPkxc+Cb3iN6L
         NfUU6+u8BXp9gxDkqBLwj7r/TqZVnNBtrApxCkEZedzCItRfGSg+TQhRqi5saUpzJLOY
         nON/r9Z6ZZKZWpSYjwc2KLDSpAgSTBvE175iztoCnpK2BiLHXGXOTNrztoy2a0BChAyN
         +oMfcGlL1pyDlIkhBE1H0ojxKxK4iTX+uUTLR9lhtEyXjvxTg8c4sl2op5pMzzZqOqZ0
         3z5yn+zn0ROnvjhuc/Rciv7HqLsdpBGSAUqm0XxeOyjAi8UUOBO6sCbJUwjIS/2zPY/y
         c2ww==
X-Forwarded-Encrypted: i=1; AJvYcCVRJJScLrshs9hsy3n9LGWAHEat3PHuwAsJlY8PQfEVyQip+7DWcopUhJIQJ+hz+vDkZvkKFSNQK43qVYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+5ltDMoQFzZcgPvuCnftsK/CwyqdHnSchHM005c4wZvmgYAX
	T7+qQs3/9YybLB8HlkM8ZD4cKa5Dr28wZZpqKuGSdmLSXPTwujKs682DM7CYa5A=
X-Google-Smtp-Source: AGHT+IEtBPydnkTY9XAl3wpUMUwj+iBOUPGy5O30ju0acWB7SwvbYZVi+55EBXKr6UE4cG8VsD+3aw==
X-Received: by 2002:a05:6512:350e:b0:53c:74dc:2252 with SMTP id 2adb3069b0e04-53c74dc2378mr6549281e87.49.1730723087398;
        Mon, 04 Nov 2024 04:24:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc95a6csm1666091e87.4.2024.11.04.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:24:46 -0800 (PST)
Date: Mon, 4 Nov 2024 14:24:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/dcss: include drm/drm_bridge.h header
Message-ID: <ix34xln3tl6l2h3jt7t4bhrydxfmh2m53dkl5rugxj335p7hgb@kfauvwrusipr>
References: <20241028163527.2425783-1-arnd@kernel.org>
 <2byo7263izup45hcdyoxr57sh2dzdasnwotpfqnayqe6znvzjt@adou6qmyhq6y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2byo7263izup45hcdyoxr57sh2dzdasnwotpfqnayqe6znvzjt@adou6qmyhq6y>

On Mon, Nov 04, 2024 at 02:10:54PM +0200, Laurentiu Palcu wrote:
> Hi Arnd,
> 
> On Mon, Oct 28, 2024 at 04:35:07PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Compile-testing random configurations leads to failures in
> > dcss-kms.c from a missing declaration:
> > 
> > drivers/gpu/drm/imx/dcss/dcss-kms.c:95:8: error: use of undeclared identifier 'drm_bridge_attach'
> >    95 |         ret = drm_bridge_attach(encoder, bridge, NULL,
> >       |               ^
> > drivers/gpu/drm/imx/dcss/dcss-kms.c:96:5: error: use of undeclared identifier 'DRM_BRIDGE_ATTACH_NO_CONNECTOR'
> >    96 |                                 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >       |                                 ^
> > 
> > Include the header directly.
> > 
> > Fixes: 004555a18d57 ("drm/imx/dcss: Allow build with COMPILE_TEST=y")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> Unfortunately, it appears I lost drm-misc push rights. Maxime, Thomas or
> Ville, can you help push this?

I can pick it up.

However I think it is:

Fixes: e7033bdfd43b ("drm/imx/dcss: use drm_bridge_connector API")

With that

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Thanks,
> Laurentiu
> 
> > ---
> >  drivers/gpu/drm/imx/dcss/dcss-kms.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> > index 3ec721afc30c..63a335c62296 100644
> > --- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
> > +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> > @@ -5,6 +5,7 @@
> >  
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> >  #include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_client_setup.h>
> >  #include <drm/drm_drv.h>
> > -- 
> > 2.39.5
> > 

-- 
With best wishes
Dmitry

