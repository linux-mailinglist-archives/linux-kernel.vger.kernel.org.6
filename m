Return-Path: <linux-kernel+bounces-231297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FB918A57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F3F1F22812
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE118FDDC;
	Wed, 26 Jun 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E6q+vW9r"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC5DF4D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424165; cv=none; b=C3mHvwhXxSd2W5s65LUIALHCOldYUWup/CBOHWu/v3EDzV1GiVHEmkkXQP6qA/cyOWHwQRwQKBBrJNJ9m9or8uU0wl7U0q0b1uk0Is9hlR3KO40AyfWDh/GAKu7TozwlnpcXYK5e95Mspnl7RySx8sLWXznybdAGLQTqsqN0xXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424165; c=relaxed/simple;
	bh=11XUoTD2Hu///11ckZyja/9S06mcVvMDAbp4g6XcidI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtRtECqHoNnZ6gUil3QpVYSfE/p83rbl673+FpqsoAmDeYGBZRvVFggAPNxi17tDQOhcQ9W7TxOJlRrsdseW+T0Yq1GwS9L+V52kfhajuXpOQfEi/tOUweVZK7vuUtEoCD6JP2YothGzrWezBDs60MxAYHoMjzRWYC1kXfJy8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=E6q+vW9r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42556143aacso838755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719424161; x=1720028961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX7Zj9l5V8x3qQly+roBBZUclWmvPtx7Y0rt4ZV8Wcw=;
        b=E6q+vW9rkmNAo9cjowQYWnz48PejIRnx5GP+8XVftnCHqcbNVLqGPUQLTEbBl60urz
         RxvxRsRL4qqRLTs2TxvfmOgqq+PuGv4iExh77UypAT3PdmiTydZO2uIfhCTiit0tXXbB
         ILoH/58FodiFXEa2+5y5fcxAwXbQf8u5gisLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424161; x=1720028961;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX7Zj9l5V8x3qQly+roBBZUclWmvPtx7Y0rt4ZV8Wcw=;
        b=P7ojp1sYqed7Nzo7L78a8svG2DtScabaDayHLtB6Zflov8uPJS6E4EvePD9Roj5J3P
         VNnU9Qhvcg1l/fhrE3Y9r+XoyW6C+8eEal3amjkaG1rqA+aFR7GSUfL43ZXN0Ugbqf3j
         Qat/urSzgb975xiVp3Lfe7kygcxGN0EBwrzWA0LdCH3mtN1LD4FpqVvfSI+xRkxRtNhj
         PbRdDug+3z4IKa70QCdX7BzCH0MupLodt1o/kTyEN9oTcKF0eXBIY+/AON/nm2Rt8GpZ
         eFXpAAL62u4GMeafA8Vfa8OISxbYi6xT89yN+U3arcWv4kccTWPWHXrQa5ItT4VgctMS
         PpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZBcZj7mN0uYaucQirDPUWM0JKWo2gJU4Q0yVcgG8hzCJ1V9PGTVGhZSlEetXbcBh4ToVOkYe5Fj+i+RpJRI3+nQmwk/96oKSy8uh
X-Gm-Message-State: AOJu0YzmV6H6b0U712sThndUFouBeJhez4dtB/rdVO+xnRoBlz4mw8/3
	ODcqsjjKpy9YJxwOTaPxdXqCKGR1o6wY+HmhbGYdbJN56w3utOPwgiyjaAyzl4o=
X-Google-Smtp-Source: AGHT+IFr3ZABZiy03lqUeRPhYzyS7ggrE9v3MW97jwVlfg/GFjNRcktMFhWpPbw+eCxkNBqIbjZUYA==
X-Received: by 2002:a5d:457a:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-366e4961e22mr6278822f8f.5.1719424161485;
        Wed, 26 Jun 2024 10:49:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f8268sm16355746f8f.79.2024.06.26.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:49:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:49:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <ZnxUn312E5c79jKh@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Oded Gabbay <ogabbay@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
 <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
 <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
 <20240509144118.baib2pftmpk5nikr@GABBAY.>
 <ZnvCsJfdZdLvw1ZN@phenom.ffwll.local>
 <kzk46s2hqrbipehnqhcx47q5mtkdjc3oeeobr2jwinw2ch3pra@37xuwtyakeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kzk46s2hqrbipehnqhcx47q5mtkdjc3oeeobr2jwinw2ch3pra@37xuwtyakeus>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 26, 2024 at 11:42:24AM +0300, Dmitry Baryshkov wrote:
> On Wed, Jun 26, 2024 at 09:26:40AM GMT, Daniel Vetter wrote:
> > On Thu, May 09, 2024 at 05:41:18PM +0300, Oded Gabbay wrote:
> > > On Thu, May 09, 2024 at 03:53:01PM +0200, Tomeu Vizoso wrote:
> > > > Oded, Dave,
> > > > 
> > > > Do you have an opinion on this?
> > > > 
> > > > Thanks,
> > > > 
> > > > Tomeu
> > > Hi Tomeu,
> > > 
> > > Sorry for not replying earlier, I was down with Covid (again...).
> > > 
> > > To your question, I don't have an objection to what you are
> > > suggesting. My personal view of accel is that it is an integral part of 
> > > DRM and therefore, if there is an *existing* drm driver that wants to 
> > > create an accel node, I'm not against it. 
> > 
> > Yeah, there's a continum from "clearly 3d gpu" to "compute AI
> > accelerator", with everything possible in-between shipping somewhere.
> > Collaboration is the important part, hair-splitting on where exactly the
> > driver should be is kinda secondary. I mean beyond "don't put a pure 3d
> > driver into accel or vice versa" of course :-)
> > 
> > > There is the question of why you want to expose an accel node, and
> > > here I would like to hear Dave's and Sima's opinion on your suggested
> > > solution as it may affect the direction of other drm drivers.
> > 
> > So existing userspace that blindly assumes that any render node will give
> > it useful 3d acceleration, then that's broken already.
> > 
> > - kernel with new driver support but old mesa without that driver already
> >   gives you that, even for a pure 3d chip.
> > 
> > - intel (and I think also amd) have pure compute chips without 3d, so this
> >   issue already exists
> > 
> > Same for the other directions, 3d gpus have variable amounts of compute
> > chips nowadays.
> > 
> > That leaves imo just the pragmatic choice, and if we need to complicate
> > the init flow of the kernel driver just for a different charnode major,
> > then I don't really see the point.
> > 
> > And if we do see the point in this, I think the right approach would be if
> > we split the init flow further into allocating the drm_device, and then in
> > a 2nd step either allocate the accel or render uapi stuff as needed. The
> > DRIVER_FOO flags just aren't super flexible for this kinda of stuff and
> > have a bit a midlayer taste to them.
> 
> Being able to defer render allocation would be extremely useful for MSM
> too as it's not currently possible to mask the driver_features during
> drm_dev_init()

Eh I think less driver_features and more explicit (like
drm_mode_config_init() instead of also having to set DRIVER_MODESET) stuff
would be better in general. But they keep popping up, because it's an easy
hack to get things going. Over the years I've managed to remove a lot of
them tough.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

