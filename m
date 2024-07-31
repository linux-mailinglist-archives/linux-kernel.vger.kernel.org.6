Return-Path: <linux-kernel+bounces-268834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DB942A08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58734284DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E781AAE1D;
	Wed, 31 Jul 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TiAOzygM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FA208A4;
	Wed, 31 Jul 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417364; cv=none; b=GqA827/lnCEl+9BsFejgMi5lh3lm0pgbQRpJZ/0d0d5T0WBcgU6+nVzjooohM0qN/LXc+13I92PuMoeSZTQTDr5SgPWYyVS21E+ABASnpXEHuWBf+leVLW06rjQJHerERQubrX1E93xfYqmOmtvSPuhZa3fpHmqtkz0E2M+mpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417364; c=relaxed/simple;
	bh=1wXm1tgv630aV3t24QKYlgh3plzTR57ziQAjqnef2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9zZdpvCf/Dl3XC98F4mm4XUSBm13nZvfCwb0j4PIe2nF+ch0n7fUOs0yS1ohk7hkdkfo8UdoXrUeW6TmLpVv5BI3TDW2k3d1kAGxMOFiZ9YUguy4X5OTHXa50j3wBkrLwrWnnTXkZyUSiQtUq/Dq72DE5Y5WudsRpH8+wLy6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TiAOzygM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDF6C116B1;
	Wed, 31 Jul 2024 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722417363;
	bh=1wXm1tgv630aV3t24QKYlgh3plzTR57ziQAjqnef2rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiAOzygMFPJcREx6wkfkFlQRb36HOOjSH+Yh4ODJiWxOf+UPszzcU8KnHFSrf+p+3
	 WLG6DVYlcWhSkxCyvgKEFS3KoZfgOBswgiq/E3/ISqNzGIlcWOpHejfjUkpBhxE1dO
	 bdD0UH0HTrfZWbCGiSmFBqclnd3aZyLJrtCVERGA=
Date: Wed, 31 Jul 2024 11:16:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_acm: make bInterfaceProtocol configurable
Message-ID: <2024073145-treat-winnings-3bb4@gregkh>
References: <20240730194337.2583784-1-mwalle@kernel.org>
 <2024073151-violator-unskilled-6866@gregkh>
 <D33LLE6K8QGH.1BCZM42INRVEX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D33LLE6K8QGH.1BCZM42INRVEX@kernel.org>

On Wed, Jul 31, 2024 at 10:57:04AM +0200, Michael Walle wrote:
> Hi Greg,
> 
> On Wed Jul 31, 2024 at 10:32 AM CEST, Greg Kroah-Hartman wrote:
> > On Tue, Jul 30, 2024 at 09:43:37PM +0200, Michael Walle wrote:
> > >  struct f_serial_opts {
> > >  	struct usb_function_instance func_inst;
> > >  	u8 port_num;
> > > +	u8 protocol;
> > > +
> > > +	struct mutex lock;
> > > +	int refcnt;
> >
> > Attempting to "roll your own" reference count is almost never a good
> > idea.  If you really need one, please use the proper in-kernel apis for
> > this.  But you need to justify it as well, I didn't see why this was
> > needed at all.
> 
> Honestly, I couldn't grok all that usb gadget magic, so I've looked
> at similar gadgets and took that from there:
>   grep refcnt drivers/usb/gadget/function/ -r
> 
> They are all doing the same, so maybe that code is old or didn't use
> the proper APIs back then.

It's old code, please do things properly.

thanks,

greg k-h

