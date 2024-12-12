Return-Path: <linux-kernel+bounces-442905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211D9EE3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE82861D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4CB2101AB;
	Thu, 12 Dec 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nnz1cB6k"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E720FA8A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998059; cv=none; b=VeyASgM4VwPC1jxx5gAYt7uokxf0uQ94XuBpzmVk6s1IUAk0ZJj0TsAl2n201WQBvv7Z9moUWpjuijdLtF5qgqEfe2o9GC/qswaL5YpUv89GpRRuWtKRI7S/hsm/6lK1lwOtjOTsjiL246HSWqHjWFjX+KlSCUXnDs9Bm3t/YEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998059; c=relaxed/simple;
	bh=N2xIszlRuTHq2iiX2PeMNN/HeTo37QqH7l47H+phyfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koWTA4JtgC/z3pKsrHua2RqQVmGmd7LSQqGyIOP/euel5lNTiIN/DF2xMILjQqv9evA8vOZdXa68ywAnXVdPWrBIA1Pc6kwFTALWXfKMDUcLE/UibTo/LPF/bUKwtuyt2BS6bbgFEireKKbDi5MoEqPVADGc8rSNJo2hiHJXzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Nnz1cB6k; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385dece873cso164191f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733998056; x=1734602856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEw5QvGI1WEIxHNEr9vU1a+TILusw+KpjvW/CzlXblE=;
        b=Nnz1cB6kUOhURjUKWar6E1fZRyXhTn4R5xd7EEjbEsOBHqwjt3Y+cxE3hmxiKg3cBb
         ucBo2Ftmltr8bzBh6zViXyAbAo+KJTquI8pxZdooL/AW4RXeRMtIOUYY0N8ie7ucYOjs
         xg95kkyf3FOfB1MNARBRITmbFcmXy7Z75WIQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998056; x=1734602856;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEw5QvGI1WEIxHNEr9vU1a+TILusw+KpjvW/CzlXblE=;
        b=YkEFsabYOY3rvZbckZpXggYUoG6BdQY+11I2anEqu6aG7ibV9Fc5dEibxR0A91vNj2
         T03DBt79BmOKxMdXY0D9mHwPYPw8zkZc+mCg8Vt88Sqg9Y9NTCR3dykelFNroJKTt1Z+
         aMbKA12r39NhZKWthr6bJV9ATcM0vzDoOxX+zID+it2mKIIrAVTCM//3pR0tedw2QErU
         JEAvS7XLfnOgq4xehUkyuk0amSqeSi//LojsDR1wdZyoz4nEkLKgK+fVolmFk8y4DsHa
         PV70eY4YIzWFD//rYcAP9wK1zvRi8rWFMPtFbf3zyAsXsA+Xijr9rYgJzIPtmQuyWkE1
         jq1g==
X-Forwarded-Encrypted: i=1; AJvYcCX85hrIHMEzUtIw9h4N/oRtoJ2ZzGlSUC29sUr38sCoaaHe0ZUigd/AU/FkbuAc9hG3tcZwxUJPSl25IdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9davYBZo/jF5FRZrJZM+zpPcZ/iWHTmU16cSPkwuz3GoujT8P
	YWgyhF05EoTvY3FOq1aw+PoHOkAGJGAy2wHSyNMaoqeHD5C4MBTU4CPXkDhf5/4=
X-Gm-Gg: ASbGnctOhfD86bNMd7BITu8AggnPE9ufOb3W2nWGcYNgFStGZVsFJJMXEzm0umS9N2G
	WVHXAONDZhGjUSRzQk6aICgaSxI9SDdk41okFeCPF2W+I2JqDG7FdvjWpgol8ixx7LMfDuHI1fZ
	Wg3y4dPvPs4UZ2XxA6Iblx5SAhE7/CLsAlsu0OXrrbASAq8M+/fDnAuxqDvSov70snkL7+Y7zPp
	qX/JWvlmtQMKcqYax5iCReHhTa9SfEb4P7rTNQ1KYjFM7af08SIk/Ae5J0JyweWJMbS
X-Google-Smtp-Source: AGHT+IFhrUafHSoCPipxJ+pOGdcv3zgRkpLxSi7qx/4D/LIpqG52Ti0k2fRfVEDYPkq41Q+d7tvSMA==
X-Received: by 2002:a5d:5887:0:b0:382:5010:c8de with SMTP id ffacd0b85a97d-3864cec5ba6mr3875098f8f.46.1733998055984;
        Thu, 12 Dec 2024 02:07:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bd634sm3614976f8f.45.2024.12.12.02.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:07:35 -0800 (PST)
Date: Thu, 12 Dec 2024 11:07:33 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <Z1q15aOiTTozQMmE@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241204160014.1171469-1-jfalempe@redhat.com>
 <20241204160014.1171469-3-jfalempe@redhat.com>
 <816f862e-762d-4880-9285-5a803e657e66@stanley.mountain>
 <88abb273-13e3-4969-96c3-c7d677a082d4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88abb273-13e3-4969-96c3-c7d677a082d4@redhat.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Thu, Dec 12, 2024 at 09:49:19AM +0100, Jocelyn Falempe wrote:
> On 12/12/2024 08:41, Dan Carpenter wrote:
> > This patch breaks "make oldconfig" for me.  It just gets into an endless
> > loop of:
> > 
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    ...
> > 
> > I don't have to type anything, it just spams that forever.  It's weird
> > that it's 1-0 instead of 0-1.  Does that means something?  I don't know
> > much about Kconfig.
> 
> I can reproduce it with your provided config.
> 
> It looks like it happens if DRM_CLIENT_SELECTION is enabled, but none of the
> client is.
> The attached patch should fix it, can you try it ?
> 
> I will submit that shortly.
> 
> Thanks for reporting it.
> 
> Best regards,
> 
> -- 
> 
> Jocelyn
> 
> 
> > 
> > I'm using this arm64 randconfig as a base.  I type "make oldconfig" and
> > press enter until it gets to "Default DRM Client" and then it starts
> > scrolling endlessly.
> > https://download.01.org/0day-ci/archive/20241212/202412121555.Fp663tyH-lkp@intel.com/config
> > 
> > regards,
> > dan carpenter
> > 

> From e4d197debd2c199c9f2d8e35e41e36c2836926b9 Mon Sep 17 00:00:00 2001
> From: Jocelyn Falempe <jfalempe@redhat.com>
> Date: Thu, 12 Dec 2024 09:43:50 +0100
> Subject: [PATCH] Fix endless Kconfig loop
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Since I haven't seen the patch anywhere else I'll drop my ack here.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Please push directly to drm-misc-next so the breakage doesn't linger.
-Sima
> ---
>  drivers/gpu/drm/clients/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
> index c18decc90200..82a7d4e584dd 100644
> --- a/drivers/gpu/drm/clients/Kconfig
> +++ b/drivers/gpu/drm/clients/Kconfig
> @@ -87,6 +87,7 @@ config DRM_CLIENT_LOG
>  choice
>  	prompt "Default DRM Client"
>  	depends on DRM_CLIENT_SELECTION
> +	depends on DRM_FBDEV_EMULATION || DRM_CLIENT_LOG
>  	default DRM_CLIENT_DEFAULT_FBDEV
>  	help
>  	  Selects the default drm client.
> -- 
> 2.47.1
> 


-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

