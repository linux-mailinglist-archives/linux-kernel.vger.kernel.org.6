Return-Path: <linux-kernel+bounces-184718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FEA8CAAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24B11C2191D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E460DD3;
	Tue, 21 May 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUV6ff5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4F60EC4;
	Tue, 21 May 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284315; cv=none; b=r5I+S9qISSbd54xRsA1BLbx8Pi0Omuzwn5vVV8j4abqkbgaoarmrxz2+vnXnT/bdmkc3e3aTfBrc7pfPosiqrlH7nR5cLn6nCIsKCHcN0SSGMXiv+Lb+SjjTeRorUKOUhpjy/4p3xMKn2I9QT93COkqj+mbfw8kjdF23oKWudQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284315; c=relaxed/simple;
	bh=HYX86FHAkEjyQacZji9kwYtlxqabkEfQ+IIHQtpgWCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/S5197MygnwVmeWZBIFwJ5ZVQiW3TSaLJ5ioGHvU/XyxgvpvrdxfQZ4unVPjzz+BQat2SgmF5/N5QdLhAhSsGeYiZyBRwpiGFt7DNR4/9esmmSyf7rl4xCkP53F00zL+fY7j0cob/s5DespBpUXxl2Rj2HObrb5f8X/h1y4sYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUV6ff5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C0C2BD11;
	Tue, 21 May 2024 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716284314;
	bh=HYX86FHAkEjyQacZji9kwYtlxqabkEfQ+IIHQtpgWCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUV6ff5YIIDq1YRYRhrxLThMxVmFeWrvQYNB0+t9gHKGkclZkGu1NkAr+wdI4X7J4
	 146NGDkZEEl5br9+H4R5wpyrOTF5vCnIxLo+iLpuXPnkyaM037rnR3Tf3KKLL7fCwF
	 Zy/KuxIWXNL1mBcfiWG6ff/k+eZT11dDfbOohqP8=
Date: Tue, 21 May 2024 11:38:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: AKASH KUMAR <quic_akakum@quicinc.com>
Cc: Felipe Balbi <balbi@kernel.org>,
	Pratham Pratap <quic_ppratap@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI
 USB
Message-ID: <2024052102-glorified-strung-80a4@gregkh>
References: <20240521074635.17938-1-quic_akakum@quicinc.com>
 <2024052134-roundness-foyer-7bfa@gregkh>
 <1ceae2a4-0715-4cea-9351-fd98a0017b85@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ceae2a4-0715-4cea-9351-fd98a0017b85@quicinc.com>

On Tue, May 21, 2024 at 02:55:13PM +0530, AKASH KUMAR wrote:
> Hi Greg,
> 
> On 5/21/2024 1:35 PM, Greg Kroah-Hartman wrote:
> > On Tue, May 21, 2024 at 01:16:35PM +0530, Akash Kumar wrote:
> > > Skip usb_early_handoff for the Renesas PCI USB controller due to
> > > the firmware not being loaded beforehand, which impacts the bootup
> > > time.
> > > 
> > > Signed-off-by: Akash Kumar<quic_akakum@quicinc.com>
> > What commit id does this fix?  Should it go to stable kernels?
> > yes it can go to stable kernels, issue is seen on every target with usb
> > over pcie support.
> > > ---
> > >   drivers/usb/host/pci-quirks.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > > index 0b949acfa258..a0770ecc0861 100644
> > > --- a/drivers/usb/host/pci-quirks.c
> > > +++ b/drivers/usb/host/pci-quirks.c
> > > @@ -1264,6 +1264,11 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
> > >   		}
> > >   	}
> > > +	/* Skip handoff for Renesas PCI USB controller on QCOM SOC */
> > > +	if ((pdev->vendor == PCI_VENDOR_ID_RENESAS) &&
> > > +			(pcie_find_root_port(pdev)->vendor == PCI_VENDOR_ID_QCOM))
> > Why are all Renesas PCI devices on a QCOM host to be marked this way?
> > That's a very big hammer for potentially lots of devices.  Have you
> > tested them all?
> 
> firmware loading is being done in HLOS, not UEFI, if firmware loading is
> done in UEFI, then calling early_handoff() API makes sense, else it is
> checking for controller ready without firmware loaded which is impacting
> boot up time by 5 sec roughly. We are seeing problem in all targets having
> usb over pcie support.

But the bootloader has nothing to do with the device type of the devices
here, right?  Why not properly trigger this off of the needed firmware
location instead of here?  What happens when you have a system using
UEFI that matches these two devices and the change causes them to break?

In other words, test the proper thing, and only for the specific devices
you need to have the change for, don't be overly broad like you are
doing here, as you might break other systems that you do not have in
front of you at the moment.

thanks,

greg k-h

