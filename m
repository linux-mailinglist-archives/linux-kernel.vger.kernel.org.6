Return-Path: <linux-kernel+bounces-255979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780B93475E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E5E2838BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92940875;
	Thu, 18 Jul 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xxbr1oG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48C800
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279140; cv=none; b=K1lNfQPYNB691FLkAa6T9wGDwGJei1tRd1WJNfXIvg75Di1WaYLlbH1y+FQyerRwHiQUJ0T5v3cL5MLX03N4nzGkOm8YeEtbaELv5EkBOh9D6Cf6yKgXzAwLbf8nWRVt3XHruYth5jdgoV+3AtnsNRdgCIPJFjKbuoq0ndeMhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279140; c=relaxed/simple;
	bh=pxr8YSm6vANvnp8O93KiRtObE2cMSFhYsvtsEjTokDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3Vwt54lLpX9ki60jrnS7Z7xBgOAg0/dYUmyo4gI7dKA9xm2yeV7loIwFkrWKIk+fO9uJb2nKy7X0dFouCWBVZyyZslSDvKPyfGwLwoi8c8qmFIa5sSJJacOT+zGBx6Zh7qSiWxtwODWZE+8tSmSApGXppkeKoRKqqdcvKknhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xxbr1oG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E7C116B1;
	Thu, 18 Jul 2024 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721279140;
	bh=pxr8YSm6vANvnp8O93KiRtObE2cMSFhYsvtsEjTokDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xxbr1oG494wctUVtlGtKvoWfUgG6hQpSMnu2Y8Zk4Ce1S0R21/87PH2nueS5Xn8/4
	 20RJHizVnM1iVb/MOur6aFm2NJ8KLNRt1o1MkEZtQF11m8txEHGI6l3UrldmyWSydy
	 1NICXn30X6QtJFy4ecZEoKXa1+EH90r+SqCuqHGM=
Date: Thu, 18 Jul 2024 07:05:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Vamsi Attunuru <vattunuru@marvell.com>, arnd@arndb.de,
	linux-kernel@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH] misc: Kconfig: exclude mrvl-cn10k-dpi compilation for
 32-bit systems
Message-ID: <2024071839-boundless-wharf-5be0@gregkh>
References: <20240717163739.181236-1-vattunuru@marvell.com>
 <9c13b91e-9efe-4a4f-b0bb-ac148d4f1af2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c13b91e-9efe-4a4f-b0bb-ac148d4f1af2@quicinc.com>

On Wed, Jul 17, 2024 at 10:50:25AM -0700, Jeff Johnson wrote:
> On 7/17/24 09:37, Vamsi Attunuru wrote:
> > Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
> > compilation errors arise on 32-bit ARM with writeq() & readq() calls
> > which are used for accessing 64-bit values.
> > 
> > Since DPI hardware only works with 64-bit register accesses, using
> > CONFIG_64BIT dependency to skip compilation on 32-bit systems.
> > 
> > Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >   drivers/misc/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index f3bb75384627..41c3d2821a78 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -588,7 +588,7 @@ config NSM
> >   config MARVELL_CN10K_DPI
> >   	tristate "Octeon CN10K DPI driver"
> >   	depends on PCI
> > -	depends on ARCH_THUNDER || COMPILE_TEST
> > +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> >   	help
> >   	  Enables Octeon CN10K DMA packet interface (DPI) driver which
> >   	  intializes DPI hardware's physical function (PF) device's
> 
> 
> BTW it looks like you accidentally submitted Makefile.rej, can you submit a
> patch to remove it?

That was me, not Vamsi, and should now be gone from the tree, sorry
about that.

thanks,

greg k-h

