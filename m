Return-Path: <linux-kernel+bounces-255980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D193475F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A901C2170D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470540875;
	Thu, 18 Jul 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKHnLRVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20161800
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279224; cv=none; b=WVh776mA4Im1RZhSHV8vXeQG66OReWJQoD4RIt/HNMYntJbsTzsmU5LoZtK0a7KlCPPQnHClB7xyXCbGFY5ZMnu/5+9ojV7RIuA2RUuzXCvEG0RNeRG6Z5fMQfdjuulxtg7mVa7MWKSTa6xB8OBDDLIDbYfs5XqRDJNvRPEXcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279224; c=relaxed/simple;
	bh=BEpoHF8IxI0jAVBUvwjDy9C4q8KDR4TN29qGE3imzOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+BjJeVjYuhVTPIys0Pjb2opRIF5r0LDy/Loe0EXFxvdEOgYxSAVQT3bM29qtzZ1v8oTrfIrjhGCkR2xeGAKIvfliIs9Zph+Y8GtQ/seSs9RSq3TECM8Y/+875mQmVaDMRrmAeW1ubWmMUX+ESb6gmapAN9En6bb8SnIf2+0Rmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKHnLRVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33439C116B1;
	Thu, 18 Jul 2024 05:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721279223;
	bh=BEpoHF8IxI0jAVBUvwjDy9C4q8KDR4TN29qGE3imzOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKHnLRVgx75a7bWknJTRu5BziBuQDlCplRD+yJigeyRvJtyDWiObjI8OciujnZ8qk
	 KoXzgaQjFqmlsfDIuDUGkkxwGcPfHn4Sz4Vy0hSXivstYDIW2sHw4AQkDmVYFKbnLT
	 BCzTXLa4KbUBh4+cn4bdxBfuulsmnjqJ8TNJdOfg=
Date: Thu, 18 Jul 2024 07:07:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Vamsi Attunuru <vattunuru@marvell.com>, arnd@arndb.de,
	linux-kernel@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH] misc: Kconfig: exclude mrvl-cn10k-dpi compilation for
 32-bit systems
Message-ID: <2024071845-grumble-borough-13b4@gregkh>
References: <20240717163739.181236-1-vattunuru@marvell.com>
 <9c13b91e-9efe-4a4f-b0bb-ac148d4f1af2@quicinc.com>
 <2024071839-boundless-wharf-5be0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071839-boundless-wharf-5be0@gregkh>

On Thu, Jul 18, 2024 at 07:05:37AM +0200, Greg KH wrote:
> On Wed, Jul 17, 2024 at 10:50:25AM -0700, Jeff Johnson wrote:
> > On 7/17/24 09:37, Vamsi Attunuru wrote:
> > > Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
> > > compilation errors arise on 32-bit ARM with writeq() & readq() calls
> > > which are used for accessing 64-bit values.
> > > 
> > > Since DPI hardware only works with 64-bit register accesses, using
> > > CONFIG_64BIT dependency to skip compilation on 32-bit systems.
> > > 
> > > Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
> > > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > > Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > >   drivers/misc/Kconfig | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index f3bb75384627..41c3d2821a78 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -588,7 +588,7 @@ config NSM
> > >   config MARVELL_CN10K_DPI
> > >   	tristate "Octeon CN10K DPI driver"
> > >   	depends on PCI
> > > -	depends on ARCH_THUNDER || COMPILE_TEST
> > > +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> > >   	help
> > >   	  Enables Octeon CN10K DMA packet interface (DPI) driver which
> > >   	  intializes DPI hardware's physical function (PF) device's
> > 
> > 
> > BTW it looks like you accidentally submitted Makefile.rej, can you submit a
> > patch to remove it?
> 
> That was me, not Vamsi, and should now be gone from the tree, sorry
> about that.

Oops, forgot to push out my local tree, should show up now, sorry about
that.

greg k-h

