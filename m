Return-Path: <linux-kernel+bounces-331581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5E97AE84
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A65D288EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DA165EF5;
	Tue, 17 Sep 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYKAiCGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80425158D8F;
	Tue, 17 Sep 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567889; cv=none; b=aixtgSPa+qS3H+JIhA5x+ntL1qHwnRj6tKlgLiUYAbGh55DSsJ10TX0hE7VkMbmLlPTAe/Qdl97EbWNYsaXKb7VCuzipaGUFI6DGMzcKmjEhWtkA7lYqSDuUnOBE+fxtsLrBXkZzMysl2NX3BXUMJJ72k1+fwswSIvsC2zjBvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567889; c=relaxed/simple;
	bh=l/t8WJfxLZSD5aZRSlHi28JBF5MloZP8QoclryrVsmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvfcYnJukT5Gy0KTcbXlWaS3+wjAI6IXnZdpbNFLALhEE6MG7Kqrj9on8hM6ivOuPqvqduDCstP2yA6ivyxLlS4xnqXlc8YEF+vKaZQaxddhoPniFU/C94dQ+IEvYAojj25j00nY1MDHSm4LMqrpFH5ZaLDyyXwsk5KYiEjvu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYKAiCGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7302C4CEC5;
	Tue, 17 Sep 2024 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726567889;
	bh=l/t8WJfxLZSD5aZRSlHi28JBF5MloZP8QoclryrVsmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYKAiCGoVDDaF+XLmGB+V+zqyDLzkMjOetyLn42TPsoSFlwwSK2vUSUcOGHhmnnRn
	 a27L+CXlKe1+Pr3cfrtTOmqBMD2Pveega7lG1UhVQgOy5z2y6btsFusard42/M0j5y
	 5Bckp61CogVjRVmvWXWghOPvkiD2pt3kvnBurwCs=
Date: Tue, 17 Sep 2024 12:11:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, yoshihiro.toyama@sony.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <2024091743-germinate-fructose-3ded@gregkh>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>

On Tue, Sep 17, 2024 at 02:36:55PM +0530, Nayeemahmed Badebade wrote:
> Hi Greg,
> 
> Thank you for taking the time to check our patch and provide
> valuable feedback. We appreciate your comments/suggestions.
> 
> Please find our reply to your comments.
> 
> On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
> > On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
> > > Hi,
> > 
> > If Rob hadn't responded, I wouldn't have noticed these as they ended up
> > in spam for some reason.  You might want to check your email settings...
> > 
> 
> I have ensured standard settings which we have been using are used this
> time, let me know if this email is received properly.

I got it this time, thanks.

> > > This patch series introduces a new framework in the form of a driver
> > > probe-control, aimed at addressing the need for deferring the probes
> > > from built-in drivers in kernels where modules are not used.
> > 
> > Wait, why?
> >
> 
> We have a scenario where a driver cannot be built as a module and ends up
> as a built-in driver. We don't want to probe this driver during boot as its
> not required at the time of booting.
> Example: drivers/pci/controller/dwc/pci-imx6.c
> So the intention is to only postpone some driver probes similar to:
> https://elinux.org/Deferred_Initcalls
> But instead of delaying initcall execution(which requires initmem to be kept
> and not freed during boot) we are trying to delay driver probes as this is
> much simpler.
> The proposed driver is a generic solution for managing such driver
> probes.

Again, please fix the drivers that are having problems with this, and
build them as a module and load them when you need/want them and can be
probed correctly.

> > > In such scenario, delaying the initialization of certain devices such
> > > as pcie based devices not needed during boot and giving user the control
> > > on probing these devices post boot, can help reduce overall boot time.
> > > This is achieved without modifying the driver code, simply by configuring
> > > the platform device tree.
> > 
> > PCI devices should not be on the platform device tree.
> >
> 
> You are right, we are referring to the pci host controller that will be
> listed in device tree and skipping its probe during boot as an example
> here.

pci host controllers should really be availble at boot time, wow your
hardware is b0rked, sorry.  Just make it a module and load it when you
want/need it.

> > And what's wrong with async probing?  That was written for this very
> > issue.
> >
> 
> We have explored async probe as an option, but we noticed below:
> 1) Probe initiated via async
> 2) Boot continues with other setup.
> 3) Boot reaches stage where ip configuration is to be done via
>    ip_auto_config() and 1) is still in progress, then boot waits for all
>    async calls to be completed before proceeding with network setup.
>    ip_auto_config()
>     -> wait_for_devices()
>       -> wait_for_device_probe()
>          -> async_synchronize_full()
> 4) Similar thing happens with rootfs mount step in prepare_namespace()
>    initcall

Again, if you make the problem driver as a module you should be ok,
right?

> So to avoid getting blocked on these probes which are not required
> during boot, we proposed this driver for managing such built-in driver
> probes execution.

Fix the broken drivers please :)

thanks,

greg k-h

