Return-Path: <linux-kernel+bounces-304461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF196206A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E82B21D28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BBF15957E;
	Wed, 28 Aug 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwOzehiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155F2CA6;
	Wed, 28 Aug 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829191; cv=none; b=RJMptbLeAhmVQhy/gC9aDdTC0vhJ4TLqZNhqCU8N7UFIczcSB/Z8Ny+yRMjnO5mbXJlBBV0QDjsHzka6hh00bxYTjXWqgoR0SmqHiGdf0kjog+KO8UMHYjajaHabhcM/DYFKwJQTJMgeg0KGLLTFTIbtHu7cdfzHgAlmkZV1WZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829191; c=relaxed/simple;
	bh=qamZVgTLzxmf+M2qHioyapuwePftf9clOU3H2jaNQ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFyhE/AEHmTVyJag7/ir+Mqo9K+ZuRGrrVwDTix+c1ZsWWlj1C7QC+v2tv0M77nRn9ewavnN/Ql4KLBAGZ57ATZUTtHiCAo2pa/ShEfGiIlH0itOK8fF/nL6Ft52uzybYkKJ+NSzOP6A5yO7j5LfTaTJG1DrgwEmL5XNdjLkf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwOzehiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A616DC4FE81;
	Wed, 28 Aug 2024 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724829191;
	bh=qamZVgTLzxmf+M2qHioyapuwePftf9clOU3H2jaNQ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwOzehiNNM9WfPV8BdMT0ysx/swiBHT/DwrbkeE6J+9nIPvQvMRlkxGpjO06QZR2A
	 7AZvSNZeNaPbhfpkhR8txsyOACm2ayebQ3VG0JoftPJ+VkWJwOFCQQ2fJXvo57y6gG
	 SU8/HnIl8dVWE9X7DWlhKshL9aPmMNxsIe8/LrBtMiRsi7S5MhbQOMn2SW87FGsLPE
	 8zL8PakTTcNMfy3V+iyzQchaoqgqw+8GSFZcNC8nzH5eSuQYhLMD4vAmw0UEaqCWUx
	 /xQJ+ivmUJdVL/tT2hI3HzawrqXsyNwJe3QpP3BJYiYeLN0sEWokc+5gpuMk6nqWXf
	 FFESLx39pY7bg==
Date: Wed, 28 Aug 2024 15:13:03 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: superm1@kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	mika.westerberg@linux.intel.com, stern@rowland.harvard.edu
Subject: Re: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at
 shutdown
Message-ID: <20240828071303.GA921051@nchen-desktop>
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-3-superm1@kernel.org>
 <20240827063206.GA879539@nchen-desktop>
 <4db33660-2720-471d-a017-1fca4c9b7268@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db33660-2720-471d-a017-1fca4c9b7268@amd.com>

On 24-08-27 13:44:02, Mario Limonciello wrote:
> On 8/27/2024 01:32, Peter Chen wrote:
> > On 24-07-12 13:54:18, superm1@kernel.org wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > A workaround was put in place for Haswell systems with spurious events
> > > to put XHCI controllers into D3hot at shutdown.  This solution actually
> > > makes sense for all XHCI controllers though because XHCI controllers
> > > left in D0 by the OS may remain in D0 when the SoC goes into S5.
> > > 
> > > Explicitly put all XHCI controllers into D3hot at shutdown and when
> > > module is unloaded.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/usb/host/xhci-pci.c | 8 ++------
> > >   1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index 4408d4caf66d2..dde5e4a210719 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
> > > @@ -667,9 +667,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
> > >   		xhci->shared_hcd = NULL;
> > >   	}
> > > -	/* Workaround for spurious wakeups at shutdown with HSW */
> > > -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> > > -		pci_set_power_state(dev, PCI_D3hot);
> > > +	pci_set_power_state(dev, PCI_D3hot);
> > >   	usb_hcd_pci_remove(dev);
> > >   }
> > > @@ -882,9 +880,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
> > >   	xhci_shutdown(hcd);
> > >   	xhci_cleanup_msix(xhci);
> > > -	/* Yet another workaround for spurious wakeups at shutdown with HSW */
> > > -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> > > -		pci_set_power_state(pdev, PCI_D3hot);
> > > +	pci_set_power_state(pdev, PCI_D3hot);
> > 
> > Hi Mario & Mathias,
> > 
> > According to xHCI spec v1.2: A.1.2 Power State Definitions:
> > 
> > 	Software shall place each downstream USB port with power
> > 	enabled into the Suspend or Disabled state before it
> > 	attempts to move the xHC out of the D0 power state.
> > 
> > But I have not found any USB core code does it, do you have any ideas
> > about it?
> > 
> > We have added the similar codes at non-PCI USB platform, but met above
> > concerns. In fact, we met kernel dump that the thread usb-storage try
> > to access the port status when the platform xHCI code has already put
> > the controller to D3.
> > 
> > Best regards,
> > Peter
> > 
> > 
> 
> This is pretty tangential to my patch.  But FWIW in case you missed we're
> going to discard this patch in favor of another approach in PCI core.
> 
> Regarding your point though If I'm not mistaken this should be handled by
> the Linux parent/child device model.  Each of the ports should be children
> of the hub they're connected to and the hub a child of the controller.  So
> when doing any actions that start runtime PM on the host controller the
> children need to first be in runtime PM.
> 

It seems there is no runtime PM suspend for xhci and USB core at
.shutdown currently. Alan & Mathias, please correct me if I was wrong.

Thanks,
Peter

