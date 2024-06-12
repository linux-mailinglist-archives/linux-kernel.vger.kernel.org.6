Return-Path: <linux-kernel+bounces-211201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A55904E64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D6EB277C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C116D33A;
	Wed, 12 Jun 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Kp5EAU7x"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD737757F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181959; cv=none; b=nISBsZ6tSHVrWepv4wfPOBKaSUpjeGB9wh9JYGj+LuXTk3o9XEc2/uaAOQinS8BIxD6Q4sHpyT6WRCFUAIEWvkW58p+boV6YPv5zC77y9hmDNAtJfYrO5LmAqIAF5tTVFWHljHcsshtlEshi8svLPquUp+3lhMQnxNYDvjZ9VsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181959; c=relaxed/simple;
	bh=+Kc/AhCmJZDN+z1v5B5jpkDqHq+Ce7zdIcHo4V7c5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcXsVhu+IdvRyIwk1OKJB37gkOhUAyomvAw5ZDvJm0Q6nYMhDU8GmrdLrJXNnXmmybg/vqfHGZ0wMtCvNn8IG1G5AVHtxygIB6GdMvg/yJLcnMWyl1KBWjjnuGKpNBLLkC9ia1C8yn01QwfQyCWrGMh+0MxUFG3oul7VL0F+Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Kp5EAU7x; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc88fb243so447489e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718181956; x=1718786756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmdle60OyXYzHnY4uAc3ZIp5lh6qnfcxEmNuLz4sZH8=;
        b=Kp5EAU7xiwHVfGM4ZYoDdody7GnYJ02CYvguGJ3xAWGF1YGZplT0Ic83N69sL8p8hE
         CzVa0Hd5f9+924r1hdVWf0v/hG1BW0Q9QYLSD+ffWvtG5vgVmne4INFSyxP4EF8HqbUa
         EycvSqh/iaYseD0xBQg64GwDc/eFYUzsUpHh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181956; x=1718786756;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmdle60OyXYzHnY4uAc3ZIp5lh6qnfcxEmNuLz4sZH8=;
        b=XvSMlERm941Ld0Gq/rykShzTvwRFFmkK6bqrKDG/Orpb4+UqZ/1FYiSGxFTLaNa2AY
         3CtueQ/kS6C7hrmLlk4b4eN1YoCIzzVN6pCL+Co8i8Pgra02ra02aDXlDwLJ3lgXdudo
         MtEW5AEYXutdOPsHzVDPS646apFlxMPvXBeipRxUXEt8SnSV91MkMtoLqJZ3206q+Thr
         mxfDPwpKCEmlGMyfvLXedBVp6mpOs8AESwS/RsTnlvOR+AvVZ0GGfD5cX7m7daO5vq/i
         jCUtNfC6uib7ZLAOkRJbdbOHxnIpExO2gFyAVvGFOUXFAlKG7JND/eDcBqWngBW1snDt
         gj0g==
X-Forwarded-Encrypted: i=1; AJvYcCXaAG/qa04ipTlwTZ2j1XX2Qw3oIHXstqDr7P6171Z4S42/ogrc2a3U+OH9IR0hocyOsmAWyPv5oN9aK0+pszGWvUh/aSmvQ/raZEx/
X-Gm-Message-State: AOJu0YzPlekKYkFppyRX89rb80eaaCGvUHOjY67GfJuraD4LuHqJ5ad4
	dvx7FHLaez8HJHp5G21PqBf6iKJm8U8ygfe6vacbKxKseAphSUw/ggfudtnoFM4=
X-Google-Smtp-Source: AGHT+IEN2iOgvU4IG9+VZppwFPKb+iyuVD3RBsFuaPvkQqAd7b8Sg7CAQLH7LpQ/LkJ8NrbWNpd/gQ==
X-Received: by 2002:a2e:2281:0:b0:2ea:eac6:6872 with SMTP id 38308e7fff4ca-2ebfc815c37mr7977921fa.0.1718181955802;
        Wed, 12 Jun 2024 01:45:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871f9068sm16507935e9.43.2024.06.12.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:45:55 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:45:53 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
Message-ID: <ZmlgQV4Eov0xv5bc@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
	Peng Fan <peng.fan@nxp.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
 <8f4a6d80-dd3e-422f-88af-d26f50c973ff@suse.de>
 <AM6PR04MB59415B3F01D02024A255BFB988C72@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <766908de-922c-4d71-bb04-29dbe4d1d64d@suse.de>
 <AM6PR04MB5941216A69AE325A79689C5888C72@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <6c01bee4-c3f5-496e-8b4f-a29c97954808@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c01bee4-c3f5-496e-8b4f-a29c97954808@suse.de>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 11, 2024 at 11:29:58AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.06.24 um 10:23 schrieb Peng Fan:
> > > Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
> > > 
> > > Hi
> > > 
> > > Am 11.06.24 um 03:00 schrieb Peng Fan:
> > > > > Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
> > > > > 
> > > > > Hi
> > > > > 
> > > > > Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > 
> > > > > > If 'info->screen_buffer' locates in vmalloc address space,
> > > > > > virt_to_page will not be able to get correct results. With
> > > > > > CONFIG_DEBUG_VM and CONFIG_DEBUG_VIRTUAL enabled on ARM64,
> > > > > there is dump below:
> > > > > 
> > > > > Which graphics driver triggers this bug?
> > > > It is NXP i.MX95 DPU driver which is still in NXP downstream repo.
> > > Which DRM memory manager does that driver use?
> > DRM_GEM_DMA_DRIVER_OPS
> 
> So fbdev-dma would be correct. But with the gem-dma allocator, wouldn't you
> allocate from one of these dma_alloc_() calls at [1] ? How does the drivers
> end up with vmalloc'd fbdev memory? Specifically in the light of the docs at
> [2].

I think when you have an iommu dma_alloc just allocates pages, and uses
the iommu to make it all contiguous for the device, and vmalloc for the
kernel. So it's not allocated with vmalloc(), just ends up getting mapped
into the vmalloc range.
-Sima


> 
> [1] https://elixir.bootlin.com/linux/v6.9/source/drivers/gpu/drm/drm_gem_dma_helper.c#L146
> [2] https://elixir.bootlin.com/linux/v6.9/source/Documentation/core-api/dma-api-howto.rst#L124
> 
> Best regards
> Thomas
> 
> > 
> > > I'm asking because if the driver allocates BOs via vmalloc(), should it really
> > > use fbdev-dma?
> > We use it for fbdev emulation. If drm_kms_helper.fbdev_emulation is 0,
> > fbdev emulation could be disabled.
> > 
> > Thanks
> > Peng
> > > Best regards
> > > Thomas
> > > 
> > > > Thanks,
> > > > Peng.
> > > --
> > > --
> > > Thomas Zimmermann
> > > Graphics Driver Developer
> > > SUSE Software Solutions Germany GmbH
> > > Frankenstrasse 146, 90461 Nuernberg, Germany
> > > GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman HRB
> > > 36809 (AG Nuernberg)
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

