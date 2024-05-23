Return-Path: <linux-kernel+bounces-187091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC88CCD05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A551C2116D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809B13CA92;
	Thu, 23 May 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVaU+ovX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FC3CF51;
	Thu, 23 May 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449332; cv=none; b=fiBtw2qGAa/GDjqjjIuE6kWowgVH1/vT3Vl9LgKNRaSqfPPDuFvLfwnJmLNRCdw8Y0RAv5tfmtxKirm4WcYoF7pcGc+iexnqk1dEDfwx7k2AOmIk2lpJ5D0WGi1dtMv5n9ul0AM+PzD4lzolTgHBh4gYX4SL75Umg3tew1cYfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449332; c=relaxed/simple;
	bh=dp2disMkVn+GSJVa1FknjWPEYIB6cpdRNJHPTy3SuwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCOA0b+0mrLF5ibekzpaPaIHhWQr1aEi7vTmPn7OXHakCINT0Und+hKsBFKCSMI++Vd5e72OhI+9aVv6OFxFpY/udTIeN3WGAj81FZ6OPm4FtT5nWTEOhlzAK1RnDYFe/AKNDBD8egCeUZxHBE7ZaubE/KfYVbFCRd27m9Ph0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVaU+ovX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC41C2BD10;
	Thu, 23 May 2024 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716449332;
	bh=dp2disMkVn+GSJVa1FknjWPEYIB6cpdRNJHPTy3SuwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVaU+ovXYyfm+EhmRtlxJiOViBdiseMKrwHIQ0hLBEpLqKGUvKy1fu4QCAn1PDJvd
	 RdqKasCqGSnkx26m3nXCw9MokXsx/eeQ2K9BgdskmOx0P5zT4ZNAlHNwiTF93pa6AH
	 whUYEMDKfogRyuqH1KOccZO1hQsloBBDGOBn6Pzs=
Date: Thu, 23 May 2024 09:28:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?6JSj5YWJ55uK?= <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI
 host
Message-ID: <2024052304-gurgle-ice-eab9@gregkh>
References: <20240522023918.7613-1-ki.chiang65@gmail.com>
 <20240522023918.7613-2-ki.chiang65@gmail.com>
 <2024052204-freehand-say-198c@gregkh>
 <CAHN5xi30GpA8Kco4+EFpvOU2wdgW8dpeBjE=Bs1ffbFVbjo-EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHN5xi30GpA8Kco4+EFpvOU2wdgW8dpeBjE=Bs1ffbFVbjo-EA@mail.gmail.com>

On Thu, May 23, 2024 at 01:33:00PM +0800, 蔣光益 wrote:
> Hi Greg,
> 
> Greg KH <gregkh@linuxfoundation.org> 於 2024年5月22日 週三 下午12:36寫道：
> >
> > On Wed, May 22, 2024 at 10:39:18AM +0800, Kuangyi Chiang wrote:
> > > As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
> > > asrock p67 host"), EJ188 have the same issue as EJ168, where completely
> > > dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.
> > >
> > > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> > > ---
> > >  drivers/usb/host/xhci-pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index ef513c2..a0beb41 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
> > > @@ -31,6 +31,7 @@
> > >
> > >  #define PCI_VENDOR_ID_ETRON          0x1b6f
> > >  #define PCI_DEVICE_ID_EJ168          0x7023
> > > +#define PCI_DEVICE_ID_EJ188          0x7052
> > >
> > >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI   0x8c31
> > >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI        0x9c31
> > > @@ -238,6 +239,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
> > >               xhci->quirks |= XHCI_TRUST_TX_LENGTH;
> > >               xhci->quirks |= XHCI_BROKEN_STREAMS;
> > >       }
> > > +     if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> > > +                     pdev->device == PCI_DEVICE_ID_EJ188) {
> > > +             xhci->quirks |= XHCI_RESET_ON_RESUME;
> > > +     }
> >
> > Same question as on other patch, should this be backported to older
> > kernels too?
> >
> > thanks,
> >
> > greg k-h
> 
> Sorry, I'm new to this.
> These patches have been tested in the stable 4.19 kernel, so they
> should be backported to stable kernels as old as 4.19, right?

Great, please put the proper Fixes: and Cc: stable tags on the commit
when resending these.  Also, they need to be made against the latest
release, not an old 4.19 kernel, as we can't go back in time to only
apply it to there.

thanks,

greg k-h

