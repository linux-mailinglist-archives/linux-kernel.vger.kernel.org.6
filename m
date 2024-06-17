Return-Path: <linux-kernel+bounces-217706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87290B32F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EA71F21670
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C913B798;
	Mon, 17 Jun 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BynpzMVn"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF613B789
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633365; cv=none; b=MGH0gG9a7ijz3EzWB1nBymQPGMk8s0+sCpoozcQMV6ulO07JjPHJRgHaObf4vyiyBE+driv2Mq6iwfTybRB+WAAU5iVUNPKdmyR8ZdOicDvL30jzMx28e9/dRC0oG3XyVYAvMQIuSgeIVOEzgEhFY/uII2ikAhHA9bGUMkPtl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633365; c=relaxed/simple;
	bh=FvPTTxF0erOx8Zx++j0OPV5uC3LiiROOi5pF3C7gOYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhaUywi/lVdcovyXnYp6d9ecZ06ASQ8pEI7gATMOYg3/Fh1YXMtWhGH6N10YlgX4tkmm/fEnqfwPOwLRCzpWVGS+/3tAbOVVOuPYb9jDjuvZqfxC6LM27/+D3M9DIZeqPkN/fROAwe004Hxd5VIxFhv2zzKUClyqcHR9oKyXrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BynpzMVn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebd6ae2f56so4970681fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718633362; x=1719238162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5n6unhG89aEhQNtetOcAr9RgdHuXzyN1J8LzFmwaso=;
        b=BynpzMVnGGSESnNF0Qz/j8NJ2HFdUuEBynSV7ljSBBi+YkileqBP5Yk/Nk/3zeJcGa
         hO2JCGOufuuobsMwnjUC7xYGM7ENoJBP3mT3WUPBFRucJvKCEaBSmBuM+N5SW7lLxKuX
         s49GRD4lm3Az64iTuUnHfE71ifcTdgcBVA8x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633362; x=1719238162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5n6unhG89aEhQNtetOcAr9RgdHuXzyN1J8LzFmwaso=;
        b=bTlPzJPV4hBlki44Mry8zOb/HkoqHoheFOu4YKhkJSaStDt+h9ce3ESRRsJnl5tX44
         7sNMLU5jeeMS8lj6a7Sb+moOtpb/r3K9I0LUnTD7LOtLpA8+wia8cGw1J2CqRXAaN6EH
         cCitsbzMT+fCfBVtqUgMXKcdQvpIoBwtuZ0F5YGhzWowxKWHtBKQz4amuMW+valh+43R
         XjG2zAeuFoUykR1XnfzH1Enjax/jNRB5zbcqSw7a8UjLD05amBvDzQG0G9ymXVyb4qda
         0siZs0F5rSUdgelSR8Xf+5DPto+opYHiKUKN9kFOf+miQR6T0mV0KiyuhDZbvCQkSKTH
         XZuw==
X-Forwarded-Encrypted: i=1; AJvYcCXd9AMLUhd+YEQYwUb7h3H2HY3Jl7kVhCZiOafhAzfxSUIZD5GBAEF+P2rc7UIBCK2KxoRqigki+Yvzvn+eXGtiGeMHsE9g11zcUS3a
X-Gm-Message-State: AOJu0Yy3DWdaFTFEuHFw1cBEW60VOGpIeOwVGoBz9CddvghV1mKdah2c
	ZImqAU+HownYuCbd18jXQhh81LPSQsRDkn2z83lU6ykLiTV+qBdxelJXae58B8s=
X-Google-Smtp-Source: AGHT+IHb1LmHZoCdyR9BvmFgsEhfcdrU3ejbVsbNyhiIbOxnK8ExuzSQZLQ5pMgs5z4coXE3SFcELw==
X-Received: by 2002:a2e:9345:0:b0:2ec:16c4:ead5 with SMTP id 38308e7fff4ca-2ec16c4effcmr50743691fa.2.1718633362433;
        Mon, 17 Jun 2024 07:09:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e95eesm197740135e9.25.2024.06.17.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:09:22 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:09:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Doug Anderson <dianders@chromium.org>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <ZnBDjxwdyomF0B6I@phenom.ffwll.local>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <20240612-garnet-condor-from-saturn-1c51bb@houat>
 <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
 <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
 <CAD=FV=XpJtCU+8aSaT0e5Ob5Owcn8b0gcdZzUrQoSdE5f9CerA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XpJtCU+8aSaT0e5Ob5Owcn8b0gcdZzUrQoSdE5f9CerA@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 12, 2024 at 09:52:40AM -0700, Doug Anderson wrote:
> Sima,
> 
> On Wed, Jun 12, 2024 at 8:13 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > > I ran the coccinelle script we started with, and here are the results:
> > > >
> > > > ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver vmw_pci_driver is missing shutdown implementation
> > > > ./drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_platform_driver is missing shutdown implementation
> > > > ./drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_platform_driver is missing shutdown implementation
> > >
> > > Sure, although I think we agreed even back when we talked about this
> > > last that your coccinelle script wasn't guaranteed to catch every
> > > driver. ...so I guess the question is: are we willing to accept that
> > > we'll stop disabling panels at shutdown for any drivers that might
> > > were missed. For instance, looking at it by hand (which also could
> > > miss things), I previously thought that we also might need:
> > >
> > > * nouveau
> > > * tegra
> > > * amdgpu
> > > * sprd
> > > * gma500
> > > * radeon
> > >
> > > I sent patches for those drivers but they don't go through drm-misc
> > > and some of the drivers had a lot of abstraction layers and were hard
> > > to reason about. I'm also not 100% confident that all of those drivers
> > > really are affected--they'd have to be used with panel-simple or
> > > panel-edp...
> >
> > Aside from amdgpu and radeon they're all in -misc now, and Alex is
> > generally fairly responsive.
> 
> Sorry for not keeping up with things, but can you point to where this
> was documented or what patch changed things so that these drivers went
> through drm-misc? From the MAINTAINERS file I see commit 5a44d50f0072
> ("MAINTAINERS: Update drm-misc entry to match all drivers") and that
> shows several of these drivers as "X:". As far as I can tell that
> means that they _aren't_ handled by drm-misc, right? Maybe the
> decision was made elsewhere and MAINTAINERS was just not updated, or
> I'm not looking at the right place? I checked drm-misc-next and
> drm/next and, for instance, "tegra" and "kmb" still show as excluded.

Hm tegra moved meanwhile, but I guess it's not yet update in MAINTAINERS
(or not everywhere), at least for bugfixes. I think nouveau also has
partially moved?

Anyway past a certain point of unresponsiveness, drm-misc serves as the
catch-all for everything and you can land with an ack from drm or drm-misc
maintainers.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

