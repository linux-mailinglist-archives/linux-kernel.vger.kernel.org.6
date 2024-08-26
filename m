Return-Path: <linux-kernel+bounces-301161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C6F95ED28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BD28130C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B114430E;
	Mon, 26 Aug 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sj+qabaA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02929A2;
	Mon, 26 Aug 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664617; cv=none; b=ir4M2B5TphtD0vs1CayM6ww50lWWNZrB6UK7XQjj59JbxIs3zp4Od3XuLkcPyF7n7M08zwYUlYd9VHtkswL3r/ASUWBcIRC++hCoiInIi4COHYSCSsr6nNtLVbtu31L1V4+DwQHgrMtu0hf+Hb4iZcsY66mDLuH3sPf7L5OzGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664617; c=relaxed/simple;
	bh=AzKOmmYCYDiPvUMVeA6PO+2K0vfVzN1yaPtjZCfT+8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQStJXZT3WYBKHOC4Z644dNOTP43BBo0uEjQQrrcSkGI4Reuiwf4aF53E79DgfeK0giKcEsWL/Fad6Gp+u24NVzZPmmazXPOXNX8vBgy1VEjeS6nPZaTw5ehz5FnW8DMP9GWlyC0OB1wsXo1lf2TPiPlcm0LB9rcSjd/0e119aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sj+qabaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156F9C8B4E8;
	Mon, 26 Aug 2024 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724664616;
	bh=AzKOmmYCYDiPvUMVeA6PO+2K0vfVzN1yaPtjZCfT+8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sj+qabaAeuSWZSKBAS6wzi7JExk+b753ReocbXaPPFGYWhWzGXGvKtnkitWHah+2K
	 CXcOg7+UYp01N6mwTUo8MhPAejYM43ZK3uRhPZqF8XCtlXKyCGDv2UH79mWbbWU1KL
	 g5dZax/Hg7CZ0xZ26ZSR1MBRUj8rMsfgv5zDjhwk=
Date: Mon, 26 Aug 2024 11:30:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: leoliu-oc@zhaoxin.com, dlemoal@kernel.org, arnd@kernel.org,
	schnelle@linux.ibm.com, WeitaoWang-oc@zhaoxin.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	mathias.nyman@linux.intel.com, ulf.hansson@linaro.org,
	vkoul@kernel.org, hslester96@gmail.com, Carsten_Schmid@mentor.com,
	efremov@linux.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, wwt8723@163.com,
	stern@rowland.harvard.edu, alex.williamson@redhat.com,
	guanwentao@uniontech.com, xuerpeng@uniontech.com
Subject: Re: [PATCH v2] USB: Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Message-ID: <2024082631-resort-stays-b065@gregkh>
References: <42A38D045199FD79+20240826085455.1525536-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A38D045199FD79+20240826085455.1525536-1-wangyuli@uniontech.com>

On Mon, Aug 26, 2024 at 04:54:55PM +0800, WangYuli wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> This bug is found in Zhaoxin platform, but it's a commom code bug.

To be fair, this is not a normal "common" code path at all :)

> 
> Fail sequence:
> step1: Unbind UHCI controller from native driver;

First off, you all know this is really an "unsupported" thing to do.  I
love it how the vfio people abuse this interface for their main code
path, but remember that is NEVER what it was designed for at all.  The
fact that it could possibly work at all is a miracle and everyone gets
lucky if nothing dies when they attempt to manually do the gyrations you
are doing here.

> step2: Bind UHCI controller to vfio-pci, which will put UHCI controller in
> 	   one vfio group's device list and set UHCI's dev->driver_data to
> 	   struct vfio-pci(for UHCI)

Who sets the driver_data here?

> step3: Unbind EHCI controller from native driver, will try to tell UHCI
> 	   native driver that "I'm removed by set
> 	   companion_hcd->self.hs_companion to NULL. However, companion_hcd
> 	   get from UHCI's dev->driver_data that has modified by vfio-pci
> 	   already. So, the vfio-pci structure will be damaged!

Damaged how?  Attempting to assign random PCI drivers to the vfio-pci
driver is again, really really not supported (despite what the vfio
authors think), so again, it's amazing this works, as you are finding
out.

> step4: Bind EHCI controller to vfio-pci driver, which will put EHCI
> 	   controller in the same vfio group as UHCI controller;
>        ... ...
> step5: Unbind UHCI controller from vfio-pci, which will delete UHCI from
> 	   vfio group device list that has been damaged in step 3. So, delete
> 	   operation can random result into a NULL pointer dereference with
> 	   the below stack dump.
> step6: Bind UHCI controller to native driver;
> step7: Unbind EHCI controller from vfio-pci, which will try to remove EHCI
> 	   controller from the vfio group;
> step8: Bind EHCI controller to native driver;

That's crazy, why would you be doing all of that in the first place?  Is
it common to add host controller drivers to virtual machines like this?
Why not just use usbip instead?

> [  929.114641] uhci_hcd 0000:00:10.0: remove, state 1
> [  929.114652] usb usb1: USB disconnect, device number 1
> [  929.114655] usb 1-1: USB disconnect, device number 2
> [  929.270313] usb 1-2: USB disconnect, device number 3
> [  929.318404] uhci_hcd 0000:00:10.0: USB bus 1 deregistered
> [  929.343029] uhci_hcd 0000:00:10.1: remove, state 4
> [  929.343045] usb usb3: USB disconnect, device number 1
> [  929.343685] uhci_hcd 0000:00:10.1: USB bus 3 deregistered
> [  929.369087] ehci-pci 0000:00:10.7: remove, state 4
> [  929.369102] usb usb4: USB disconnect, device number 1
> [  929.370325] ehci-pci 0000:00:10.7: USB bus 4 deregistered
> [  932.398494] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  932.398496] PGD 42a67d067 P4D 42a67d067 PUD 42a65f067 PMD 0
> [  932.398502] Oops: 0002 [#2] SMP NOPTI
> [  932.398505] CPU: 2 PID: 7824 Comm: vfio_unbind.sh Tainted: P   D  4.19.65-2020051917-rainos #1

Note, this is a very old kernel, and one that has closed source in it
making it such that none of us can debug it at all.

And are you sure this happens on 6.10?

> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index a08f3f228e6d..5a63d7a772ae 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -48,6 +48,7 @@ static void for_each_companion(struct pci_dev *pdev, struct usb_hcd *hcd,
>  	struct pci_dev		*companion;
>  	struct usb_hcd		*companion_hcd;
>  	unsigned int		slot = PCI_SLOT(pdev->devfn);
> +	struct pci_driver	*drv;
>  
>  	/*
>  	 * Iterate through other PCI functions in the same slot.
> @@ -60,6 +61,13 @@ static void for_each_companion(struct pci_dev *pdev, struct usb_hcd *hcd,
>  				PCI_SLOT(companion->devfn) != slot)
>  			continue;
>  
> +		drv = companion->driver;
> +		if (drv &&
> +		    strncmp(drv->name, "uhci_hcd", sizeof("uhci_hcd") - 1) &&
> +		    strncmp(drv->name, "ohci-pci", sizeof("ohci-pci") - 1) &&
> +		    strncmp(drv->name, "ehci-pci", sizeof("ehci-pci") - 1))

Attempting to rely on kernel module names within kernel code just is not
going to work, sorry.

What exactly are you trying to do here?  Please at least comment it.

> +			continue;

Do you just want to fail the binding?  If so, why?  And what is
precenting a driver to be bound after you do the check?

> +
>  		/*
>  		 * Companion device should be either UHCI,OHCI or EHCI host
>  		 * controller, otherwise skip.

Why doesn't this check suffice?

thanks,

greg k-h

