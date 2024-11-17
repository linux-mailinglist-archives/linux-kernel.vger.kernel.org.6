Return-Path: <linux-kernel+bounces-412109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775829D03FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB31F2281B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F33190499;
	Sun, 17 Nov 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yC74CMLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDA322E;
	Sun, 17 Nov 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731849191; cv=none; b=YE2Fg9ldYlNX0CHFzR/hOCPHyNQBzmKPFAu9c9zoD5Hhxc17orAWVJfAf0/pWq4Zo05NnuXtEF8M70c5cEukgJ3Gcx0EZPOii0Ou7EpS8TBsnyoo7kiYsCRu7ATDgQ6CbX9xHsPClGXDgCJmZm+3kBUto1eYKdjHrRoG57O9cL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731849191; c=relaxed/simple;
	bh=krPJN/i7lgpkSrhazY804Fe9VJqM4MsMPUHqbu9+Q/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfREsSi0CYTkKXZRYDPPGsF7bMsBgSvdmMaqZjqy8kW1F/kNPJKOjYu7NHmG+2NWw2wSubHVE6gz6HAv/TIBUgsOvXPHq9HZ+dVcbDB0CLJUkUHaggH0XlgLN390IRqIytHtYQBoXACr7/xHN2Ji1F96zDOC7j2mklBXAUtAoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yC74CMLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6454CC4CECD;
	Sun, 17 Nov 2024 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731849190;
	bh=krPJN/i7lgpkSrhazY804Fe9VJqM4MsMPUHqbu9+Q/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yC74CMLX6VUShyJx9Ocqk0OqYOdMpU2vjCh8hfxEcYlKeSSF/rfA1fg4OdpES0I+t
	 1RyJkLDTtcjaS0kBoB1CfKBkcHYamYBiihdXrpW4I+zbjSn5oOCZ6oJhAX8Ztb+mP1
	 bSfhSx+d5rRbv4zOQbrxzo1fu9TEZVyr4zIpYZAY=
Date: Sun, 17 Nov 2024 14:12:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Rechberger <linuxusb.ml@sundtek.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <2024111731-neuter-customer-0230@gregkh>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
 <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>

On Sun, Nov 17, 2024 at 08:44:16PM +0800, Markus Rechberger wrote:
> Basically the issue comes from hub_port_connect.
> 
> drivers/usb/core/hub.c
> 
> hub_port_init returns -71 -EPROTO and jumps to loop
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5450
> 
> I'd question if usb_ep0_reinit is really required in loop which is
> running following functions:
>     usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
>     usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
>     usb_enable_endpoint(udev, &udev->ep0, true);
> 
> this is something only experience over the past decades can tell?
> 
> usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't do
> much, but crashes the entire system with the upstream kernel when it
> triggers xhci_check_bw_table).
> 
> I removed usb_ep0_reinit here and devices are still workable under
> various conditions (again I shorted and pulled D+/D- to ground for
> testing).
> The NULL PTR check in xhci_check_bw_table would be a second line of
> defense but as indicated in the first mail it shouldn't even get there.
> 
> 
> 
> As a second issue I found in usb_reset_and_verify device 
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6131
> 
>         ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
>         if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV) {
>             break;
>         }
> 
> hub_port_init can also return -71 / -EPROTO, the cases should be very
> rare when usb_reset_and_verify_device is triggered and that happens.
> 
> 
> I'm just waiting for comments now since this is some critical piece of
> infrastructure code before proceeding with a patch.

Send us a patch and we will be glad to review it.

thanks!

greg k-h

