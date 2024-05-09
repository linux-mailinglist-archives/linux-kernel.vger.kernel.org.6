Return-Path: <linux-kernel+bounces-174600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5D8C1167
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67CDB210D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD623D3BC;
	Thu,  9 May 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8tfpZT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4122BCFF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265684; cv=none; b=CKvGgZqLp8FbhC8IvFO4PRbPPL3zGs87cAzg3px6qcuwMgxCO6bMrmrr0mtzINm5QXhR48xYgLbE3NlTkOqYB+DfrCC/aO1l2aqgSJ46Vqqc75NLa2ipOOQU2giLKInrdVn6qTTk8IC/l7A2tuoM9ElWLYZ+BK95aJwEtH8kspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265684; c=relaxed/simple;
	bh=Qx8UYCxiWdEZ4Kjn0bUpA+c+/Rsek35U2CMylJmgrrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMEWiO3qervbP9NByXtRvmEw2vmPuniERunL/o7G8hkKt7SebTPRb8/9aSPGERWLb5XkGDU5l5SXwspjftORAWpaQ0T69+IzAMpW+bFqYnxLcLHBBEd++2LVgt3n8yKhcJSyAkn5ObEzkHijn2+qyvptwJxjCxzEMCJRVDk97Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8tfpZT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062D0C116B1;
	Thu,  9 May 2024 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715265683;
	bh=Qx8UYCxiWdEZ4Kjn0bUpA+c+/Rsek35U2CMylJmgrrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8tfpZT3MWBxDBJqqm6VJ9H6mDt7SyXsxncWrj7mlqxx9K6SKXftE2lsPfpWyDnUt
	 YJ98PkOTjLF3RcqkhhNsgwE41ejUH5gwRzbPjO4H+IrgFegvjdhwa7krBROfufNu+S
	 CX11b8ZPxO2mqwZY6pIQZDrPXaY/SIHC7UZ5/WodIuE4AiaMvKqvVL/qIR+ohI6H8+
	 XlOzV/2gjdB0AzS603AtgbTWywvyHSNC5QTx1nhxuVGFqsmFRlhn1ypYUGjT9+hXZ3
	 TM25Qb8Bl0assu0kY4Eh6mES+WXCvM+0FkslNNe2sQZxMiiV8RPi4wED9+0zpKpGaL
	 WjPS3E2SylA1Q==
Date: Thu, 9 May 2024 17:41:18 +0300
From: Oded Gabbay <ogabbay@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <20240509144118.baib2pftmpk5nikr@GABBAY.>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
 <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
 <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>

On Thu, May 09, 2024 at 03:53:01PM +0200, Tomeu Vizoso wrote:
> Oded, Dave,
> 
> Do you have an opinion on this?
> 
> Thanks,
> 
> Tomeu
Hi Tomeu,

Sorry for not replying earlier, I was down with Covid (again...).

To your question, I don't have an objection to what you are
suggesting. My personal view of accel is that it is an integral part of 
DRM and therefore, if there is an *existing* drm driver that wants to 
create an accel node, I'm not against it. 

There is the question of why you want to expose an accel node, and
here I would like to hear Dave's and Sima's opinion on your suggested
solution as it may affect the direction of other drm drivers.

Thanks,
Oded.

p.s.
Please only use bottom-posting when replying, thanks :)

> 
> On Fri, Apr 26, 2024 at 8:10 AM Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> >
> > On Thu, Apr 25, 2024 at 8:59 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
> > >
> > > On 4/24/2024 12:37 AM, Tomeu Vizoso wrote:
> > > > If we expose a render node for NPUs without rendering capabilities, the
> > > > userspace stack will offer it to compositors and applications for
> > > > rendering, which of course won't work.
> > > >
> > > > Userspace is probably right in not questioning whether a render node
> > > > might not be capable of supporting rendering, so change it in the kernel
> > > > instead by exposing a /dev/accel node.
> > > >
> > > > Before we bring the device up we don't know whether it is capable of
> > > > rendering or not (depends on the features of its blocks), so first try
> > > > to probe a rendering node, and if we find out that there is no rendering
> > > > hardware, abort and retry with an accel node.
> > > >
> > > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > > Cc: Oded Gabbay <ogabbay@kernel.org>
> > >
> > > I hope Oded chimes in as Accel maintainer.  I think Airlie/Vetter had
> > > also previously mentioned they'd have opinions on what is Accel vs DRM.
> > >
> > > This gets a nack from me in its current state.  This is not a strong
> > > nack, and I don't want to discourage you.  I think there is a path forward.
> > >
> > > The Accel subsystem documentation says that accel drivers will reside in
> > > drivers/accel/ but this does not.
> >
> > Indeed, there is that code organization aspect.
> >
> > > Also, the commit text for "accel: add dedicated minor for accelerator
> > > devices" mentions -
> > >
> > > "for drivers that
> > > declare they handle compute accelerator, using a new driver feature
> > > flag called DRIVER_COMPUTE_ACCEL. It is important to note that this
> > > driver feature is mutually exclusive with DRIVER_RENDER. Devices that
> > > want to expose both graphics and compute device char files should be
> > > handled by two drivers that are connected using the auxiliary bus
> > > framework."
> > >
> > > I don't see any of that happening here (two drivers connected by aux
> > > bus, one in drivers/accel).
> >
> > Well, the text refers to devices, not drivers. The case we are talking
> > about is a driver that wants to sometimes expose an accel node, and
> > sometimes a render node, depending on the hardware it is dealing with.
> > So there would either be a device exposing a single render node, or a
> > device exposing a single accel node.
> >
> > Though by using the auxiliary bus we could in theory solve the code
> > organization problem mentioned above, I'm not quite seeing how to do
> > this in a clean way. The driver in /drivers/gpu/drm would have to be a
> > DRM driver that doesn't register a DRM device, but registers a device
> > in the auxiliary bus for the driver in /drivers/accel to bind to? Or
> > are you seeing some possibility that would fit better in the current
> > DRM framework?
> >
> > > I think this is the first case we've had of a combo DRM/Accel usecase,
> > > and so there isn't an existing example to refer you to on how to
> > > structure things.  I think you are going to be the first example where
> > > we figure all of this out.
> >
> > Yep, I will be grateful for any ideas on how to structure this.
> >
> > > On a more implementation note, ioctls for Accel devices should not be
> > > marked DRM_RENDER_ALLOW.  Seems like your attempt to reuse as much of
> > > the code as possible trips over this.
> >
> > Indeed, thanks.
> >
> > Cheers,
> >
> > Tomeu
> >
> > > -Jeff

