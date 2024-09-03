Return-Path: <linux-kernel+bounces-312939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1F969DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8542826CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370F1C986E;
	Tue,  3 Sep 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DhRiacVj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E961D0959
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367422; cv=none; b=gYWSC54OkxAql0cW/eXLK/r/lrfVDM5eX5sLiIVxHM1IwpbsRh1fM/3H5l2WccG+Tn5imJBRrmDy8LzkA8hKbEJN4UmRR2XrL1Pi+QHMd8hQni/pO/4D7HUzq69I7v6wPW/HxLPAiLK32Ae/LDuUkdg0EPNPDAM1Km6z2+V4zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367422; c=relaxed/simple;
	bh=+4RvRSY6eJ2L69c4gQXSEtj4At24Yvr3qWKdNagAWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEw+5AnxLGEfRr/SfjFkBfMryGCX0PsAboKdVQALbyj+AOfqvvfU0zLg7EU557dGS5ol2LQh52iw3D28lohANDP5bt6+33Y/K6F7M6LNu/Qt6IBFxSkyf2+eQYhlNcjYGIrIcv6F7NBORXYHrghf/OORqdWTKjKY3b2mvOCWa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DhRiacVj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso40271765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725367418; x=1725972218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF6cy6N9w8ivMUcSFrfFNh/Zm3jBGa8iln6oqRZO1nQ=;
        b=DhRiacVjxDHqn7hQnOQaXSeWMDXC1iGY/nttKvOg+OGcvCXIiq/M81PO1TvYYDYQMR
         EM++ih+IU5T1mfUVNfqGJizIRPXIHm6N/x9GEe6ndUaXRuPpiQ1wrbkTeb+rHoGSiOws
         lq/SA+CHbvPtZ+1BQIkG4lM+JvHF/niQw8boU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367418; x=1725972218;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF6cy6N9w8ivMUcSFrfFNh/Zm3jBGa8iln6oqRZO1nQ=;
        b=HhKFVgZvwBXHmnMCKKHYyxh65KLE6XUEhONjZwjbDN2MDRM5zGJhcUsX3OyBrBqbAy
         hvafEO7pjZCJDl66fM3m+i5eaKLMXwnxnscmU6qlqA9fbG0uqlZTlvuSHKDV/9xiVzly
         jrfjI/6P4OflkOleOPXGYuP06pTQZNrPBJiRNXTwq0qVWEK8On5wrtqwo5lk9yPaXyBW
         oh3nnNq0M+u46lyt3y7Xb8iR8R5izagdLLxuGiuZBaDNlf++5C4dd6Wbkyfq6qHeX1Vn
         wqQbthfuQwh7DM8CMxhmnP19EW7YfeeaUkANWMJyTDowIjwdE5IYhn03dJx7IPuJla0F
         fvAw==
X-Forwarded-Encrypted: i=1; AJvYcCWsYPSPlD0kmsxPoxaVLjtv77wtNqSNIBfE6e40Yt0yg2XfUB/hFsGHjW0YjM3+pi2IarIJSMXSgEV1zAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uwLUUEQbPMElUW9/0It9QrB5sXBnxe5G1m6g0lO8oCMw8vcA
	fY/d88R6b9VIJ+LpKBAGxikV/8JXXX/rraOoYPRqnbwd/gfbNivhD9nWP0vxvHU=
X-Google-Smtp-Source: AGHT+IEGg7l4IMzVDZgZkXIX0eYXYILCsR6zQ7gRtu7kMilf7ir1R3/YeUPcVUT/t0bPy0TUrJjh2w==
X-Received: by 2002:a05:600c:3ca9:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-42c82f67431mr48895155e9.25.1725367418175;
        Tue, 03 Sep 2024 05:43:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm163980525e9.12.2024.09.03.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:43:37 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:43:35 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Message-ID: <ZtcEd50uGRTROvUh@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240626-warping-nondescript-mustang-bfce27@houat>
 <b7cf71b8-76fd-4638-a7b6-cc8dbae635bf@ideasonboard.com>
 <20240702-bold-exotic-mamba-fdbba4@houat>
 <7293448e-e8cc-4522-b39c-5ad133e5f732@ideasonboard.com>
 <20240725-natural-giga-crane-d54067@houat>
 <4ed3791f-bc5a-46f1-88e1-2441c7f9c8d4@ideasonboard.com>
 <20240902-refined-smooth-mammoth-fbee81@houat>
 <ZtWYWuqhqvdWd0Q7@phenom.ffwll.local>
 <d411e79f-a22e-48e9-b135-5d7a0afa3cf3@ideasonboard.com>
 <20240903-encouraging-guillemot-of-warranty-aac44c@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-encouraging-guillemot-of-warranty-aac44c@houat>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Tue, Sep 03, 2024 at 01:56:45PM +0200, Maxime Ripard wrote:
> On Mon, Sep 02, 2024 at 03:31:28PM GMT, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On 02/09/2024 13:50, Daniel Vetter wrote:
> > > On Mon, Sep 02, 2024 at 11:26:11AM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Aug 07, 2024 at 03:19:23PM GMT, Tomi Valkeinen wrote:
> > > > > On 25/07/2024 14:28, Maxime Ripard wrote:
> > > > > > On Mon, Jul 15, 2024 at 11:32:34AM GMT, Tomi Valkeinen wrote:
> > > > > > > On 02/07/2024 14:43, Maxime Ripard wrote:
> > > > > > > > Hi Tomi,
> > > > > > > > 
> > > > > > > > On Wed, Jun 26, 2024 at 06:53:40PM GMT, Tomi Valkeinen wrote:
> > > > > > > > > On 26/06/2024 18:07, Maxime Ripard wrote:
> > > > > > > > > > On Wed, Jun 26, 2024 at 12:55:39PM GMT, Tomi Valkeinen wrote:
> > > > > > > > > > > On 26/06/2024 11:49, Maxime Ripard wrote:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > > 
> > > > > > > > > > > > On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrote:
> > > > > > > > > > > > > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > > > > > > > > > > 
> > > > > > > > > > > > > When a bridge driver uses devm_mipi_dsi_device_register_full() or
> > > > > > > > > > > > > devm_mipi_dsi_attach(), the resource management is moved to devres,
> > > > > > > > > > > > > which releases the resource automatically when the bridge driver is
> > > > > > > > > > > > > unbound.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > However, if the DSI host goes away first, the host unregistration code
> > > > > > > > > > > > > will automatically detach and unregister any DSI peripherals, without
> > > > > > > > > > > > > notifying the devres about it. So when the bridge driver later is
> > > > > > > > > > > > > unbound, the resources are released a second time, leading to crash.
> > > > > > > > > > > > 
> > > > > > > > > > > > That's super surprising. mipi_dsi_device_unregister calls
> > > > > > > > > > > > device_unregister, which calls device_del, which in turn calls
> > > > > > > > > > > > devres_release_all.
> > > > > > > > > > > 
> > > > > > > > > > > Hmm, right.
> > > > > > > > > > > 
> > > > > > > > > > > > If that doesn't work like that, then it's what needs to be fixed, and
> > > > > > > > > > > > not worked around in the MIPI-DSI bus.
> > > > > > > > > > > 
> > > > > > > > > > > Well, something causes a crash for both the device register/unregister case
> > > > > > > > > > > and the attach/detach case, and the call stacks and debug prints showed a
> > > > > > > > > > > double unregister/detach...
> > > > > > > > > > > 
> > > > > > > > > > > I need to dig up the board and check again why the devres_release_all() in
> > > > > > > > > > > device_del() doesn't solve this. But I can probably only get back to this in
> > > > > > > > > > > August, so it's perhaps best to ignore this patch for now.
> > > > > > > > > > > 
> > > > > > > > > > > However, the attach/detach case is still valid? I see no devres calls in the
> > > > > > > > > > > detach paths.
> > > > > > > > > > 
> > > > > > > > > > I'm not sure what you mean by the attach/detach case. Do you expect
> > > > > > > > > > device resources allocated in attach to be freed when detach run?
> > > > > > > > > 
> > > > > > > > > Ah, never mind, the devres_release_all() would of course deal with that too.
> > > > > > > > > 
> > > > > > > > > However, I just realized/remembered why it crashes.
> > > > > > > > > 
> > > > > > > > > devm_mipi_dsi_device_register_full() and devm_mipi_dsi_attach() are given a
> > > > > > > > > device which is used for the devres. This device is probably always the
> > > > > > > > > bridge device. So when the bridge device goes away, so do those resources.
> > > > > > > > > 
> > > > > > > > > The mipi_dsi_device_unregister() call deals with a DSI device, which was
> > > > > > > > > created in devm_mipi_dsi_device_register_full(). Unregistering that DSI
> > > > > > > > > device, which does happen when the DSI host is removed, does not affect the
> > > > > > > > > devres of the bridge.
> > > > > > > > > 
> > > > > > > > > So, unloading the DSI host driver causes mipi_dsi_device_unregister() and
> > > > > > > > > mipi_dsi_detach() to be called (as part of mipi_dsi_host_unregister()), and
> > > > > > > > > unloading the bridge driver causes them to be called again via devres.
> > > > > > > > 
> > > > > > > > Sorry, that's one of the things I don't quite get. Both functions are
> > > > > > > > exclusively(?) called from I2C bridges, so the device passed there
> > > > > > > > should be a i2c_client instance, and thus the MIPI-DSI host going away
> > > > > > > > will not remove those i2c devices, only the MIPI-DSI ones, right?
> > > > > > > 
> > > > > > > Yes.
> > > > > > > 
> > > > > > > > So if we remove the host, the MIPI-DSI device will be detached and
> > > > > > > > removed through the path you were explaing with the i2c client lingering
> > > > > > > > around. And if we remove the I2C device, then devm will kick in and will
> > > > > > > > detach and remove the MIPI-DSI device.
> > > > > > > 
> > > > > > > Right.
> > > > > > > 
> > > > > > > > Or is it the other way around? That if you remove the host, the device
> > > > > > > > is properly detached and removed, but there's still the devm actions
> > > > > > > > lingering around in the i2c device with pointers to the mipi_dsi_device
> > > > > > > > that was first created, but since destroyed?
> > > > > > > > 
> > > > > > > > And thus, if the i2c device ever goes away, we get a use-after-free?
> > > > > > > 
> > > > > > > Hmm, I'm not sure I understand what you mean here... Aren't you describing
> > > > > > > the same thing in both of these cases?
> > > > > > > 
> > > > > > > In any case, to expand the description a bit, module unloading is quite
> > > > > > > fragile. I do get a crash if I first unload the i2c bridge module, and only
> > > > > > > then go and unload the other ones in the DRM pipeline. But I think module
> > > > > > > unloading will very easily crash, whatever the DRM drivers being used are,
> > > > > > > so it's not related to this particular issue.
> > > > > > > 
> > > > > > > In my view, the unload sequence that should be supported (for development
> > > > > > > purposes, not for production) is to start the unload from the display
> > > > > > > controller module, which tears down the DRM pipeline, and going from there
> > > > > > > towards the panels/connectors.
> > > > > > > 
> > > > > > > Of course, it would be very nice if the module unloading worked perfectly,
> > > > > > > but afaics fixing all that's related to module unloading would be a
> > > > > > > multi-year project... So, I just want to keep the sequence I described above
> > > > > > > working, which allows using modules while doing driver development.
> > > > > > 
> > > > > > FTR, I'm all for supporting module unloading. The discussion above was
> > > > > > about what is broken exactly, so we can come up with a good solution.
> > > > > 
> > > > > Does that mean that you're ok with the patch, or that something should be
> > > > > improved?
> > > > 
> > > > No, I meant that at the very least the commit log needs to be updated to
> > > > reflect what is actually going on, because at least my understanding of
> > > > it doesn't match what actually happens.
> > > > 
> > > > We want a solution to the problem you're facing, but it's not clear to
> > > > me what the problem is exactly at this point, so it's hard to review a
> > > > solution.
> > > 
> > > So I haven't looked at the full thing, but I think the proper fix is to
> > > make both detach and unregister cope with being called multiple times. I
> > > think devm_ here is a red herring, the underlying issues is that we can
> > > unregister/detach from two sides:
> > > 
> > > - when the host dsi goes away
> > > - when individual dsi devices on a given host go away
> > > 
> > > So there needs to be book-keeping and locking to make sure no matter which
> > > order things disappear, we don't try to unregister/detach a dsi device
> > > twice.
> > 
> > I think that is what my patch does (for devm_).
> > 
> > Some vocabulary first:
> > 
> > dsi peripheral device - The device that represents the DSI peripheral. It is
> > a bridge or a panel, and (usually) an i2c or platform device.
> > 
> > dsi peripheral driver - The driver handling the dsi peripheral device.
> > 
> > dsi device - Runtime created device instance that represents the DSI
> > peripheral. So in my case we have the i2c bridge device, and a dsi device is
> > created for it in the setup code.
> > 
> > dsi controller device - A device that has a DSI bus (usually a platform or
> > i2c device, I would guess).
> > 
> > dsi controller driver - A driver for the dsi controller device. Creates the
> > dsi host.
> > 
> > dsi host - represents the DSI host side, owned by the dsi controller driver.
> > 
> > When a dsi peripheral driver uses devm_mipi_dsi_device_register_full() or
> > devm_mipi_dsi_attach(), the dsi device is created and attached to the dsi
> > host. When the dsi peripheral device-driver is unbound, devres will call
> > unregister and detach are called automatically. This works fine.
> > 
> > But when the device-driver for the dsi controller is unbound, the dsi
> > controller driver will unregister the dsi host,
> 
> I assume that you're talking about:
> https://elixir.bootlin.com/linux/v6.10.7/source/drivers/gpu/drm/drm_mipi_dsi.c#L357 ?
> 
> > and the unregistration will also unregister and detach the dsi device.
> 
> And https://elixir.bootlin.com/linux/v6.10.7/source/drivers/gpu/drm/drm_mipi_dsi.c#L346 ?
> 
> > But the devres is not told about that.
> 
> If my assumptions are correct, device_unregister() will definitely clean
> up the devres resources on that device:
> 
> https://elixir.bootlin.com/linux/v6.10.7/source/drivers/base/core.c#L3886
> 
> > So when the dsi peripheral is later unbound, its devres will again
> > unregister and detach.
> 
> I guess in this case, only the device resource tied to the i2c client
> device (so dsi device? in your nomenclature) will run.
> 
> Or is it that:
> https://elixir.bootlin.com/linux/v6.10.7/source/drivers/gpu/drm/drm_mipi_dsi.c#L250
> 
> Gets tied to the i2c client device, but the host being removed has
> free'd that device already?
> 
> > To fix that this patch uses devm_remove_action() to remove the devres
> > action when the host side goes away first.
> >
> > Now, after writing the above, I realized that all this won't help with the
> > non-devm versions: the host side has unregistered and detached the dsi
> > device, but if the dsi peripheral driver calls mipi_dsi_detach() or
> > mipi_dsi_device_unregister(), it will again crash.
> > 
> > Handling the attach/detach should be quite easy, and in fact the code
> > already handles it, but it uses WARN_ON() there so that has to go. But
> > attach/detach will crash anyway if the dsi device has already been freed,
> > which happens when the dsi controller driver calls
> > mipi_dsi_device_unregister().
> > 
> > So... The dsi peripheral driver should keep a reference to the dsi device,
> > with get_device()? And then do a put_device() after calling
> > mipi_dsi_device_unregister()?
> > 
> > But we don't free the dsi device, it has essentially been disabled without
> > telling the dsi peripheral driver about it, which might cause problems.
> 
> Yeah, and the host pointer would be lingering as well.
> 
> > I don't know... This doesn't sound correct to me. Probably my patch is just
> > new wrong on top of old wrong. Or maybe I don't quite grasp how this works.
> 
> I think we can fix some of them by storing the "parent" device of
> mipi_dsi_device (ie, the i2c client device) that the devm action is
> registered against, and removing the action in
> mipi_dsi_remove_device_fn.
> 
> And marking non-devm variants as deprecated in favor of the devm one.

I think focusing too much on the devm automatic cleanup is missing the
point. For the non-dsi drivers that don't go through a full
mipi_dsi_driver with probe/remove the lifetime is fundamentally busted. If
the host is independent of the dsi device, then that just blows up as Tomi
points out in another reply, because the non-dsi driver has no idea that
everything just disappeared and will happily continue to use it.

The only exception is if the same driver (e.g. pci driver) registers both
the dsi device and host, and then also unregisters them both (and
hopefully in the right order). Everywhere else I think we just need to
bite the bullet and use the full driver/device model, it has all these
issues sorted out.

And once we have that, there's also no confusion about automatic devm
cleanup of stuff I think.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

