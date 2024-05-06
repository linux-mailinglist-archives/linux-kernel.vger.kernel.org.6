Return-Path: <linux-kernel+bounces-169872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C48BCEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FF11F2478D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614176410;
	Mon,  6 May 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Wqx8Dz/m"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285531DA5F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001275; cv=none; b=S24RCmxAmrCYYkgZO1paCl45+lHiPelJi3JHQgP/nRIT7ZZrMvJ6MQRiSLGYTTgxZOFcd73iMNa1QJ3DGyUUdhlvH00ofUTD3Hx6SIaeU4xiUedif5LHfVwXMqR3IQ9KI7e32mNn6YpFmdYHn6Jrpn1qCZzwehLr25Yul86Xv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001275; c=relaxed/simple;
	bh=gQDbGwiGhGoP1FOYKZMRGyg3IPE71RSmNCxYCNoPegI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7vdJK6spXFj0Ew3K8Hh7ntYxziodZT5LBYO7AFOnVVqED2MeI7KfrvnKDdMURkpVOITkZp246jlVN1jNfTnZLT1qs7mFiIpFTChDQzdBBF+wePFkuWepre6Gl7d09njKR17HztFRMXR51G+FNpD+7J3hWKkdbxzQkq+ba/j4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Wqx8Dz/m; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e2da49e86bso3862481fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715001271; x=1715606071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcGOVp9unOUJdofB/8SfIMCkzzBFqbYaTzZjCQ22Ceo=;
        b=Wqx8Dz/mwAjHGehNZjDnhN7qsDlU2olQu2jVflmbgm5ZpcQwNhD7HEM4GQCuQD6YhV
         9+ZTxidPDFEXmlmNA+TLWQRqrDsfEUzccZqVVQ0TXIp4WP963+cYs2HBqdmvRgPItc/T
         ORACGmdSTeK1leltDcZFnK6nta9yf+B6+Olpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001271; x=1715606071;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcGOVp9unOUJdofB/8SfIMCkzzBFqbYaTzZjCQ22Ceo=;
        b=t+baaPaN513eeI7k3rQxG0Q9ND38QLARttx4+rR4eqNH0x6Re2YzBYOHUx+AF1DZIx
         ZmuqmYHY7LuADL584NV4HnE2mlpQLlE0eqObaPt44lWYwMOGU0UfKOIFYMx+ONHIbQjo
         VOBWA/mnKaL4yASP8Y0brtxciphJJ6MStLBmh99dB8wXwzWC+jQOGVF49HfqBMBjUtNE
         OU+f6IHBwb73lSPzdRi8SrZAkSM7l+ZVPg9KNjg2y1V+J5VEgFsJkeaDjSBHDSAUTn3X
         xQ3iHfdf4nUIDG28DjasICKNv4oqzXUJizSqonn8q1Kxcp4DlQ+4KiNOwPzQDyF92ZwT
         /JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQv26QxFZHPO4QgjJj1QZA1Ts2nsGpg+uyzzWeqJPUEYVnkXZdgfS8sC65t1tVEZ1l7Okf/BOjuLI+Bpzx/XpJgcgvmKcjvBmyt0A
X-Gm-Message-State: AOJu0YxHq/23FI8duEX11eusSUgwh4ZJpW4t6V2FtX/2ninEkBVl3U1Y
	1eHIEiH9GyIWJt4dpIl2j0QFfLXArpHmLZBiakr8c3GSQYirusIJAHQJL2Tiq2A=
X-Google-Smtp-Source: AGHT+IGi/la6Qcz7XisPeA2mbmqeuLa+J0eHqdFBkqiw++9QIWvkPyhu9oI7nfBs0pbXiB2cPZJTyA==
X-Received: by 2002:a2e:97c5:0:b0:2e3:ba0e:de02 with SMTP id m5-20020a2e97c5000000b002e3ba0ede02mr494955ljj.5.1715001271237;
        Mon, 06 May 2024 06:14:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b0041b083e16e2sm19958456wmo.2.2024.05.06.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 06:14:30 -0700 (PDT)
Date: Mon, 6 May 2024 15:14:28 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Message-ID: <ZjjXtEwWWZX43c6l@phenom.ffwll.local>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
 <8e1867fc-34da-457c-b95a-2d51ea97336a@app.fastmail.com>
 <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Fri, May 03, 2024 at 01:22:10PM -0700, Florian Fainelli wrote:
> On 5/3/24 12:45, Arnd Bergmann wrote:
> > On Fri, May 3, 2024, at 21:28, Florian Fainelli wrote:
> > > Android devices in recovery mode make use of a framebuffer device to
> > > provide an user interface. In a GKI configuration that has CONFIG_FB=m,
> > > but CONFIG_FB_NOTIFY=y, loading the fb.ko module will fail with:
> > > 
> > > fb: Unknown symbol fb_notifier_call_chain (err -2)
> > > 
> > > Have CONFIG_FB_NOTIFY be tristate, just like CONFIG_FB such that both
> > > can be loaded as module with fb_notify.ko first, and fb.ko second.
> > > 
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > I see two problems here, so I don't think this is the right
> > approach:
> > 
> >   1. I don't understand your description: Since fb_notifier_call_chain()
> >      is an exported symbol, it should work for both FB_NOTIFY=y and
> >      FB_NOTIFY=m, unless something in Android drops the exported
> >      symbols for some reason.
> 
> The symbol is still exported in the Android tree. The issue is that the GKI
> defconfig does not enable any CONFIG_FB options at all. This is left for SoC
> vendors to do in their own "fragment" which would add CONFIG_FB=m. That
> implies CONFIG_FB_NOTIFY=y which was not part of the original kernel image
> we build/run against, and so we cannot resolve the symbol.
> 
> This could be resolved by having the GKI kernel have CONFIG_FB_NOTIFY=y but
> this is a bit wasteful (not by much since the code is very slim anyway) and
> it does require making changes specifically to the Android tree which could
> be beneficial upstream, hence my attempt at going upstream first.

Making fbdev (the driver subsystem, not the uapi, we'll still happily
merge patches for that) more useful is really not the upstream direction :-)

> IMHO it makes sense for all subsystem supporting code to be completely
> modular or completely built-in, or at least allowed to be.
> 
> > 
> >   2. This breaks if any of the four callers of fb_register_client()
> >      are built-in while CONFIG_FB_NOTIFY is set to =m:
> 
> Ah good point, I missed that part, thanks, adding "select FB_NOTIFY" ought
> to be enough for those.
> 
> > 
> > $ git grep -w fb_register_client
> > arch/arm/mach-pxa/am200epd.c:   fb_register_client(&am200_fb_notif);
> > drivers/leds/trigger/ledtrig-backlight.c:       ret = fb_register_client(&n->notifier);
> > drivers/video/backlight/backlight.c:    return fb_register_client(&bd->fb_notif);
> > drivers/video/backlight/lcd.c:  return fb_register_client(&ld->fb_notif);
> > 
> > Somewhat related but not directly addressing your patch, I wonder
> > if Android itself could migrate to using FB_CORE=m FB=n FB_NOTIFY=n
> > instead and use simpledrm for the console in place of the legacy
> > fbdev layer.
> 
> That is beyond my reach :)

This one is. And it doesn't need to be simpledrm, just a drm kms driver
with fbdev emulation. Heck even if you have an fbdev driver you should
control the corresponding backlight explicitly, and not rely on the fb
notifier to magical enable/disable some random backlights somewhere.

So please do not encourage using this in any modern code.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

