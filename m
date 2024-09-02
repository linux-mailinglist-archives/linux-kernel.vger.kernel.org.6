Return-Path: <linux-kernel+bounces-311135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE941968548
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44AF280BE5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518B185B4B;
	Mon,  2 Sep 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ISq2s8wB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C11185922
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274209; cv=none; b=ietKB+e8odgd2j0BnXMZgRzS+ChOMm96hDuFlS5UCx1QEUrVNNDRO1qAZRX44ReqyR70VdtpeBDEH9BOcPL/YDU0PJfMtxwgxUC7zRxFXWGC3NBTZlkRnGRx+pTuaQ+0Dn4bAZ9s6/tKh/84bDi9OUgRHQj8eRs4q060VNadaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274209; c=relaxed/simple;
	bh=Yn+5R10Thtx9lnI43eUXTgL1nINg0rvYpOAZLPzShfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atAE8VcfOIHRF5wHktyghcKBcPJ6l3HezBddBi378uqpdXEsg4bS1mCeERvN5BP/wrUySKYmsHOG6wbdY4UnVyjCba6921WHtE/IEMC4yNpSU5e+3yd2OZrx2yLdGUTBFqazbMJVeMpF+oKpCgDxXctbHrZF0qVdFevm6uMSEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ISq2s8wB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so451571566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725274206; x=1725879006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr9YCSspbcSij3+b7hb0dq3GP5E8jc6fk1x9iA3r84Q=;
        b=ISq2s8wBmiHX1rgOrcGqjiS5+VHR7oVt7Se88esYfT/LHkmQgAd/d4PkDx3/UcWJ2n
         w+beBeX6Ee/lrdi9MxlbQE+UnuKEz/rFIVtbZj3XERtttS36INAEF2msfXOFQeDBYcVl
         zSN2mRl4uJNer0jarCZcgkx1U9CDzS70XBU2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274206; x=1725879006;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr9YCSspbcSij3+b7hb0dq3GP5E8jc6fk1x9iA3r84Q=;
        b=MvPAaA5FjsnUbJv1Eq/6pfcqEvLxtCHznr1TeVetQFtyDhdnWSdTpD315ZAZzGXxp6
         krKoGlmot9JiHkokyc4G/q1crz9I5yCWlSKV342r+ecU2GDQgAHbaIBInpIKdyqnnTaB
         WlASNbxSgQ8e5b6vbvuYA3g6CktIX8K/dNTgZOkxm6k25fpoYmSgIuac2MktqMwnlDMW
         65UNB9dPO6w2QXk8rLaW2XaayiYoMaNVYyLP7Vj9z1evySq88MwV1nBso5Kt5FNSsDHY
         4pxG3XNOQacd5G7GUBMC4NDbiYnJsp/1LIWmf+3STHCR+L+yeJ9PgDWQn5VM9ARG7jxt
         lGPw==
X-Forwarded-Encrypted: i=1; AJvYcCUx5NTas0FV7hAvwHnjaQju45GKwLLGDjvtfuX3Bs5VJgfb3OLLg40/wVuVBTwPOmAbehVY/ADmvFUBb20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWldWumuE34f/nmRgiW5mvXF5hdKhbR5UXHlUmGVlS2hboZ5d
	KUhKv58J5i8Uk/Z70hDwZnrH6RPPN34AUCdTSnI+AhhaGit31Kg0fFf1Lx+Izdo=
X-Google-Smtp-Source: AGHT+IFVtjO3rxEJoxZ8Ol8wRxyxMhjd5TS0M8YB9xrAr1FFmFAKJqbtjMM+vvz2K07lZkjFS1ZrDA==
X-Received: by 2002:a17:907:1c22:b0:a86:963f:ea8d with SMTP id a640c23a62f3a-a89fafad957mr248551066b.64.1725274205682;
        Mon, 02 Sep 2024 03:50:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196773sm544308066b.109.2024.09.02.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:50:05 -0700 (PDT)
Date: Mon, 2 Sep 2024 12:50:02 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Message-ID: <ZtWYWuqhqvdWd0Q7@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
 <20240626-gabby-ladybug-of-freedom-08e6eb@houat>
 <66ab4206-d1c8-4aad-99a7-c4c316e343a9@ideasonboard.com>
 <20240626-warping-nondescript-mustang-bfce27@houat>
 <b7cf71b8-76fd-4638-a7b6-cc8dbae635bf@ideasonboard.com>
 <20240702-bold-exotic-mamba-fdbba4@houat>
 <7293448e-e8cc-4522-b39c-5ad133e5f732@ideasonboard.com>
 <20240725-natural-giga-crane-d54067@houat>
 <4ed3791f-bc5a-46f1-88e1-2441c7f9c8d4@ideasonboard.com>
 <20240902-refined-smooth-mammoth-fbee81@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-refined-smooth-mammoth-fbee81@houat>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Mon, Sep 02, 2024 at 11:26:11AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Aug 07, 2024 at 03:19:23PM GMT, Tomi Valkeinen wrote:
> > On 25/07/2024 14:28, Maxime Ripard wrote:
> > > On Mon, Jul 15, 2024 at 11:32:34AM GMT, Tomi Valkeinen wrote:
> > > > On 02/07/2024 14:43, Maxime Ripard wrote:
> > > > > Hi Tomi,
> > > > > 
> > > > > On Wed, Jun 26, 2024 at 06:53:40PM GMT, Tomi Valkeinen wrote:
> > > > > > On 26/06/2024 18:07, Maxime Ripard wrote:
> > > > > > > On Wed, Jun 26, 2024 at 12:55:39PM GMT, Tomi Valkeinen wrote:
> > > > > > > > On 26/06/2024 11:49, Maxime Ripard wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrote:
> > > > > > > > > > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > > > > > > > 
> > > > > > > > > > When a bridge driver uses devm_mipi_dsi_device_register_full() or
> > > > > > > > > > devm_mipi_dsi_attach(), the resource management is moved to devres,
> > > > > > > > > > which releases the resource automatically when the bridge driver is
> > > > > > > > > > unbound.
> > > > > > > > > > 
> > > > > > > > > > However, if the DSI host goes away first, the host unregistration code
> > > > > > > > > > will automatically detach and unregister any DSI peripherals, without
> > > > > > > > > > notifying the devres about it. So when the bridge driver later is
> > > > > > > > > > unbound, the resources are released a second time, leading to crash.
> > > > > > > > > 
> > > > > > > > > That's super surprising. mipi_dsi_device_unregister calls
> > > > > > > > > device_unregister, which calls device_del, which in turn calls
> > > > > > > > > devres_release_all.
> > > > > > > > 
> > > > > > > > Hmm, right.
> > > > > > > > 
> > > > > > > > > If that doesn't work like that, then it's what needs to be fixed, and
> > > > > > > > > not worked around in the MIPI-DSI bus.
> > > > > > > > 
> > > > > > > > Well, something causes a crash for both the device register/unregister case
> > > > > > > > and the attach/detach case, and the call stacks and debug prints showed a
> > > > > > > > double unregister/detach...
> > > > > > > > 
> > > > > > > > I need to dig up the board and check again why the devres_release_all() in
> > > > > > > > device_del() doesn't solve this. But I can probably only get back to this in
> > > > > > > > August, so it's perhaps best to ignore this patch for now.
> > > > > > > > 
> > > > > > > > However, the attach/detach case is still valid? I see no devres calls in the
> > > > > > > > detach paths.
> > > > > > > 
> > > > > > > I'm not sure what you mean by the attach/detach case. Do you expect
> > > > > > > device resources allocated in attach to be freed when detach run?
> > > > > > 
> > > > > > Ah, never mind, the devres_release_all() would of course deal with that too.
> > > > > > 
> > > > > > However, I just realized/remembered why it crashes.
> > > > > > 
> > > > > > devm_mipi_dsi_device_register_full() and devm_mipi_dsi_attach() are given a
> > > > > > device which is used for the devres. This device is probably always the
> > > > > > bridge device. So when the bridge device goes away, so do those resources.
> > > > > > 
> > > > > > The mipi_dsi_device_unregister() call deals with a DSI device, which was
> > > > > > created in devm_mipi_dsi_device_register_full(). Unregistering that DSI
> > > > > > device, which does happen when the DSI host is removed, does not affect the
> > > > > > devres of the bridge.
> > > > > > 
> > > > > > So, unloading the DSI host driver causes mipi_dsi_device_unregister() and
> > > > > > mipi_dsi_detach() to be called (as part of mipi_dsi_host_unregister()), and
> > > > > > unloading the bridge driver causes them to be called again via devres.
> > > > > 
> > > > > Sorry, that's one of the things I don't quite get. Both functions are
> > > > > exclusively(?) called from I2C bridges, so the device passed there
> > > > > should be a i2c_client instance, and thus the MIPI-DSI host going away
> > > > > will not remove those i2c devices, only the MIPI-DSI ones, right?
> > > > 
> > > > Yes.
> > > > 
> > > > > So if we remove the host, the MIPI-DSI device will be detached and
> > > > > removed through the path you were explaing with the i2c client lingering
> > > > > around. And if we remove the I2C device, then devm will kick in and will
> > > > > detach and remove the MIPI-DSI device.
> > > > 
> > > > Right.
> > > > 
> > > > > Or is it the other way around? That if you remove the host, the device
> > > > > is properly detached and removed, but there's still the devm actions
> > > > > lingering around in the i2c device with pointers to the mipi_dsi_device
> > > > > that was first created, but since destroyed?
> > > > > 
> > > > > And thus, if the i2c device ever goes away, we get a use-after-free?
> > > > 
> > > > Hmm, I'm not sure I understand what you mean here... Aren't you describing
> > > > the same thing in both of these cases?
> > > > 
> > > > In any case, to expand the description a bit, module unloading is quite
> > > > fragile. I do get a crash if I first unload the i2c bridge module, and only
> > > > then go and unload the other ones in the DRM pipeline. But I think module
> > > > unloading will very easily crash, whatever the DRM drivers being used are,
> > > > so it's not related to this particular issue.
> > > > 
> > > > In my view, the unload sequence that should be supported (for development
> > > > purposes, not for production) is to start the unload from the display
> > > > controller module, which tears down the DRM pipeline, and going from there
> > > > towards the panels/connectors.
> > > > 
> > > > Of course, it would be very nice if the module unloading worked perfectly,
> > > > but afaics fixing all that's related to module unloading would be a
> > > > multi-year project... So, I just want to keep the sequence I described above
> > > > working, which allows using modules while doing driver development.
> > > 
> > > FTR, I'm all for supporting module unloading. The discussion above was
> > > about what is broken exactly, so we can come up with a good solution.
> > 
> > Does that mean that you're ok with the patch, or that something should be
> > improved?
> 
> No, I meant that at the very least the commit log needs to be updated to
> reflect what is actually going on, because at least my understanding of
> it doesn't match what actually happens.
> 
> We want a solution to the problem you're facing, but it's not clear to
> me what the problem is exactly at this point, so it's hard to review a
> solution.

So I haven't looked at the full thing, but I think the proper fix is to
make both detach and unregister cope with being called multiple times. I
think devm_ here is a red herring, the underlying issues is that we can
unregister/detach from two sides:

- when the host dsi goes away
- when individual dsi devices on a given host go away

So there needs to be book-keeping and locking to make sure no matter which
order things disappear, we don't try to unregister/detach a dsi device
twice.

Now whether that device model is correct is maybe a different question,
but I think it's entirely orthogonal issue too.

Or maybe I'm just wrong ...

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

