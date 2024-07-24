Return-Path: <linux-kernel+bounces-261022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C493B1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D01C219C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BA1591E2;
	Wed, 24 Jul 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQOmzKqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E1158DA0;
	Wed, 24 Jul 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828171; cv=none; b=IyBpufx7U9LXIvZ1jg/1aa4ki7kyn/k2PfGVfDcFcHnUSYsrlIA2Lathqp1Q8sb6Xw/PyDUAvEJdAknNtyihcDvbllnofm1vB9jzpm3w+cVWU1LCoTvxWaNrqAOmg4Qaaz15N4aVszDwdyeWJnRM6dSgT5LqWc5oZqABmykwS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828171; c=relaxed/simple;
	bh=qDPJZ27dnCT+ZblWUcm8KrCxgsFNh1NJtoEY0poztWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnDAtjPisoXm8fIdidCkI7WisOQw55jgj9dlm+xVG5lXrarRvm9NoSzpxdhsyJvxfZMgT9X1j8S9q51D74AE+hMOFYYBhqHjPaHbhw498AaVVV8iNuQgY3mghYpQiktodyMd2f584uA9aNmXmH4RTm0lOICVC3WFedChbtK/kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQOmzKqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE208C4AF0C;
	Wed, 24 Jul 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721828171;
	bh=qDPJZ27dnCT+ZblWUcm8KrCxgsFNh1NJtoEY0poztWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQOmzKqOZvSYxe7B79yn2ryRFXJ1z92lFjnTiP1I1NK6RT4DESK3MA2O1L5wMnGtO
	 HzvvOrrJSy/68NLjaDNG41gGDcq4KDRiKIWOsem9au9gGukt7vQIDdd5vHJezOj0p7
	 puLYtCRXrT7ocyAheQPQgy6wZpKXAKD96QtdmzlQ=
Date: Wed, 24 Jul 2024 15:36:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <2024072430-scorn-pushover-7d8a@gregkh>
References: <20240724102349.430078-1-jtornosm@redhat.com>
 <8a85af94-8911-44b8-9516-2f532cee607d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a85af94-8911-44b8-9516-2f532cee607d@lunn.ch>

On Wed, Jul 24, 2024 at 01:49:14PM +0200, Andrew Lunn wrote:
> On Wed, Jul 24, 2024 at 12:23:44PM +0200, Jose Ignacio Tornos Martinez wrote:
> > The related module for the phy is loaded dynamically depending on the
> > current hardware. In order to keep this behavior and have the phy modules
> > available from initramfs, add a 'weak' dependency with the phy modules to
> > allow user tools, like dracut, get this information.
> > 
> > Include micrel phy module because it is the hardware that I have. Other
> > possible phy modules can be added later.
> > 
> > Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> > ---
> >  drivers/net/usb/lan78xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 8adf77e3557e..c3945aebf94e 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > @@ -5074,3 +5074,4 @@ module_usb_driver(lan78xx_driver);
> >  MODULE_AUTHOR(DRIVER_AUTHOR);
> >  MODULE_DESCRIPTION(DRIVER_DESC);
> >  MODULE_LICENSE("GPL");
> > +MODULE_WEAKDEP("micrel");
> 
> ~/linux$ grep -r MODULE_WEAKDEP *
> ~/linux$ 
> 
> Is MODULE_WEAKDEP new?
> 
> It seems like a "Wack a Mole" solution, which is not going to
> scale. Does dracut not have a set of configuration files indicating
> what modules should be included, using wildcards? If you want to have
> NFS root, you need all the network drivers, and so you need all the
> PHY drivers?

Agree, this isn't ok, if you have a real dependancy, then show it as a
real one please with the tools that we have to show that.

thanks,

greg k-h

