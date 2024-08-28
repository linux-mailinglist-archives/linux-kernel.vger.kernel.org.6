Return-Path: <linux-kernel+bounces-304458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D551596205D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885201F25AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5C158A00;
	Wed, 28 Aug 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7tpSkQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4E156864;
	Wed, 28 Aug 2024 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829050; cv=none; b=biFayd1UunRnSF+pxb7LIr4yqU/wqOfNMykOEoiUjqfLYMq127RZtx5qQqloYXuRA17Lstb8LhZywO/JAMyvbhud7hcwt+3vZW1JO1K2vtL/ySvTpZr1IOB5qHpSSUAaQ4mznoIXCZ2E2DNABt/b7R09WiBFuOF+F1Op9x735+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829050; c=relaxed/simple;
	bh=D1LvT+0ZwgaS7/bKpyzMjT0ea/bY4C6HjXl2N37bG6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSVjP1GhyOzSL1sf79USj3iBT7z1RC7odc2Bs3zqa1NuRr77TnWRGhSk3S+vYbROqWsLC5fjowHAF+K4jccf82rRhYm40zEjymh8hY7H8b8Vmh0kbYwVg09zO2hPakcGXHmFWp3cdPdOgrD7UMsQxiMIh4Mi4hRO4P/lCnE3YUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D7tpSkQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB02C4AF54;
	Wed, 28 Aug 2024 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724829049;
	bh=D1LvT+0ZwgaS7/bKpyzMjT0ea/bY4C6HjXl2N37bG6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7tpSkQHyYzO6X6fKv/doxB2rRG3sj7dA7lNnds5qaWTXO/vPbPIzqwteYbDx6xXr
	 +rXAtuIx4HqgVMzxNumGZans6AMGdNxmB6K4fvA4e5egTZs/r1h4B54oz9OnZ0WLdG
	 zObLKmR1KBFfOMoatKUAmAElsCwfTMCAmCo/Cn2A=
Date: Wed, 28 Aug 2024 09:10:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Harry Austen <hpausten@protonmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
Message-ID: <2024082824-emphasis-thwarting-4ef4@gregkh>
References: <20240826123602.1872-1-hpausten@protonmail.com>
 <20240826123602.1872-8-hpausten@protonmail.com>
 <2024082655-cubicle-flashily-6ab3@gregkh>
 <D3QXIGN92QZ7.S2LY531JZ1L9@protonmail.com>
 <ced9ed863c4b648a65c80447a8482cb2.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced9ed863c4b648a65c80447a8482cb2.sboyd@kernel.org>

On Tue, Aug 27, 2024 at 04:40:52PM -0700, Stephen Boyd wrote:
> Quoting Harry Austen (2024-08-27 12:08:52)
> > On Mon Aug 26, 2024 at 2:11 PM BST, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 26, 2024 at 12:38:36PM +0000, Harry Austen wrote:
> > > > Xilinx clocking wizard IP core supports monitoring of up to four
> > > > optional user clock inputs, with a corresponding interrupt for
> > > > notification in change of clock state (stop, underrun, overrun or
> > > > glitch). Give userspace access to this monitor logic through use of the
> > > > UIO framework.
> > > >
> > > > Implemented as an auxiliary_driver to avoid introducing UIO dependency
> > > > to the main clock driver.
> > > >
> > > > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > > > ---
> > > >  drivers/uio/Kconfig            |  8 ++++
> > > >  drivers/uio/Makefile           |  1 +
> > > >  drivers/uio/uio_xlnx_clk_mon.c | 71 ++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 80 insertions(+)
> > > >  create mode 100644 drivers/uio/uio_xlnx_clk_mon.c
> > > >
> > > > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > > > index b060dcd7c6350..ca8a53de26a67 100644
> > > > --- a/drivers/uio/Kconfig
> > > > +++ b/drivers/uio/Kconfig
> > > > @@ -164,4 +164,12 @@ config UIO_DFL
> > > >         opae-sdk/tools/libopaeuio/
> > > >
> > > >       If you compile this as a module, it will be called uio_dfl.
> > > > +
> > > > +config UIO_XLNX_CLK_MON
> > > > +   tristate "Xilinx user clock monitor support"
> > > > +   depends on COMMON_CLK_XLNX_CLKWZRD
> > > > +   help
> > > > +     Userspace I/O interface to the user clock monitor logic within the
> > > > +     Xilinx Clocking Wizard IP core.
> > >
> > > Why do you want a UIO api for a clock device?  What userspace code is
> > > going to access the hardware this way?  Why not use the normal
> > > kernel/user apis instead?
> > 
> > I was just trying to provide userspace access to these _unexpected_ clock
> > status event indications (clock stopped, underrun, overrun or glitched) and UIO

That is going to be a brand-new user/kernel api that isn't documented
anywhere and will be unique to this one device.  Please don't do that.

> Maybe unexpected events can be indicated through the EDAC subsystem,
> except that is usually about memory or cache errors, not device driver
> issues.

If you all need a new way to report issues like this to userspace, then
let's create the correct api for it, don't require userspace to mmap a
random device and expect to poke around in it safely to get the
information.

Odds are that mmap will change with the next version of this device,
right?

thanks,

greg k-h

