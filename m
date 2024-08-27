Return-Path: <linux-kernel+bounces-302681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF49601C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7B1C22B79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6F1494CF;
	Tue, 27 Aug 2024 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHQ4K1JH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5C13DB99;
	Tue, 27 Aug 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740335; cv=none; b=PvgMAApSfDBojdpFf592WHY6a33SDveRf18mqD5w1/MKPoyFc4J9cvYdRjVa6GUYCW+QcL6lLYLpBXPlZL5jxYaCXdGz+uyIBoh2qF/mFlTaI3p7JMQFDZP5fSd9GHiSWlSsKRitMC4bt25PBx+Uf39PqiPkHjMpk2JyYKLbRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740335; c=relaxed/simple;
	bh=ifBkb4l5BhM2XKPPUFoMMHnfY0rA9sgsJx3aUbGwWiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkcs3VvWly+rXJ7PfTUSyP5dzoKhuGXkvNrocD2bZ6QkNJX76alDNKCeec9+YcLInd7W8pErIDS02F7RsGADQcVbV2SWKVDMbbYz60B2evLBaUgju/mghtdZHvm/DA2E+GgbXa8+xAWjhKtg319/SbO5EKFi545oKkJ4DE4036k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHQ4K1JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01303C58315;
	Tue, 27 Aug 2024 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724740334;
	bh=ifBkb4l5BhM2XKPPUFoMMHnfY0rA9sgsJx3aUbGwWiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHQ4K1JHf5n9/o1brIGLa4WJTmOr9cR8oiAWeFhcMhyacaZ1hi6L3KO23deZIVqI4
	 hvzkDOiml3URIfvL7PQSYUzZcZP+NOmDspXm+9ZYkq796NX7MEVrd9gcC8QdsuQO4W
	 5wGdzQmzvBrf0RQt9gxppim5LE6a1lsm3tKKY/SqJsMhoc4Myh48NEo2PWbwBhSvDA
	 EGwTUKdVGutX/Q4Fs1mtFXHMelIfxCcfxGpdnPkckPqD7Lo+LU0LthyB64R3VDGChU
	 Ck8z1/IrnhCucP77lfxK7d5bvIAk4qCw7PLwH3frH0ipm3OsBz3ukUMVA8Pju02cRT
	 eI0MHaNJ+Q3JQ==
Date: Tue, 27 Aug 2024 14:32:06 +0800
From: Peter Chen <peter.chen@kernel.org>
To: superm1@kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	mika.westerberg@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at
 shutdown
Message-ID: <20240827063206.GA879539@nchen-desktop>
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712185418.937087-3-superm1@kernel.org>

On 24-07-12 13:54:18, superm1@kernel.org wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A workaround was put in place for Haswell systems with spurious events
> to put XHCI controllers into D3hot at shutdown.  This solution actually
> makes sense for all XHCI controllers though because XHCI controllers
> left in D0 by the OS may remain in D0 when the SoC goes into S5.
> 
> Explicitly put all XHCI controllers into D3hot at shutdown and when
> module is unloaded.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/usb/host/xhci-pci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 4408d4caf66d2..dde5e4a210719 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -667,9 +667,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
>  		xhci->shared_hcd = NULL;
>  	}
>  
> -	/* Workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(dev, PCI_D3hot);
> +	pci_set_power_state(dev, PCI_D3hot);
>  
>  	usb_hcd_pci_remove(dev);
>  }
> @@ -882,9 +880,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>  	xhci_shutdown(hcd);
>  	xhci_cleanup_msix(xhci);
>  
> -	/* Yet another workaround for spurious wakeups at shutdown with HSW */
> -	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
> -		pci_set_power_state(pdev, PCI_D3hot);
> +	pci_set_power_state(pdev, PCI_D3hot);

Hi Mario & Mathias,

According to xHCI spec v1.2: A.1.2 Power State Definitions:

	Software shall place each downstream USB port with power
	enabled into the Suspend or Disabled state before it
	attempts to move the xHC out of the D0 power state.

But I have not found any USB core code does it, do you have any ideas
about it?

We have added the similar codes at non-PCI USB platform, but met above
concerns. In fact, we met kernel dump that the thread usb-storage try
to access the port status when the platform xHCI code has already put
the controller to D3.

Best regards,
Peter



