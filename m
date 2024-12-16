Return-Path: <linux-kernel+bounces-446961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365949F2B67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C12188A681
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE421FF7AC;
	Mon, 16 Dec 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qPP1Jvt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6C1FFC64;
	Mon, 16 Dec 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335965; cv=none; b=BMZxW2WrclYLy32iZcg5UOVLi52Ree1x7nNvG3h6caqdXoLBT5BvB+ZWA2BsjynTwAkbyrT9j9YB4lTP3830BUFR1WMbJYAgzEBqx1zXPfz4YerRwEzLiGcqXiqTaam9b6DWDrc8d3ucjVp4z67KsnzUxYqArsD7RP9DO6Ffh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335965; c=relaxed/simple;
	bh=ZJxNjYJAcQD7xS3URzocfolx7l6/wY5FbnRznSfHSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2GczZo8OiOUQ/H1VhbhrmeWDWYGHFWuW8r3lABOmQXFZd+AkYgPBpNdm+nEIaYuNrA8Xtl7ZNnFlaciQ9a+ZvcO6xmDzeUTtlJcIwv1uBrcDLBluj3AflsqYKmfdibhq6ZS+PuwI0ytKyClTvrkDM2xYsSC466NJsiOm7N+c8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qPP1Jvt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA9C4CED0;
	Mon, 16 Dec 2024 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734335964;
	bh=ZJxNjYJAcQD7xS3URzocfolx7l6/wY5FbnRznSfHSbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPP1Jvt2P2WRPO9pHj6MaXW6ne68Z26NLkPJlqbgit6WZGxlJ5ub3iDqGGKgmDILz
	 kV/YpocLyjHX/pQoXSTN+3UCIgtigrooTcLTN1x4JVwDfSLmoH+LYv3qDii/91/LYJ
	 1PD3g3w95iq0VV/O8tHZmn3sYW0j8y0YKztRsEk0=
Date: Mon, 16 Dec 2024 08:58:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] staging: gpib: Workaround for ppc build failure
Message-ID: <2024121622-sensitive-curtain-7d45@gregkh>
References: <20241204134736.6660-1-dpenkler@gmail.com>
 <b6102c6b-693f-4237-8c0c-83c5936aab3c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6102c6b-693f-4237-8c0c-83c5936aab3c@roeck-us.net>

On Sun, Dec 15, 2024 at 03:23:55PM -0800, Guenter Roeck wrote:
> On Wed, Dec 04, 2024 at 02:47:36PM +0100, Dave Penkler wrote:
> > Make GPIB_FMH depend on !PPC
> > 
> > Reported_by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Link: https://lore.kernel.org/all/20241015165538.634707e5@canb.auug.org.au/
> > 
> > Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> 
> This patch just exposes other build failures, for example
> i386:allyesconfig or x86_64:allyesconfig.
> 
> Error log:
> x86_64-linux-ld: vmlinux.o: in function `fmh_gpib_t1_delay':
> fmh_gpib.c:(.text+0xfd49dbd): undefined reference to `nec7210_t1_delay'
> 
> There are many more missing functions. FWIW, I don't know how this is
> supposed to work in the first place, since pretty much all gpib Makefiles
> say
> 
> obj-m += <object file>
> 
> meaning they won't be built with allyesconfig. fmh_gpib is the only
> exception with
> 
> obj-$(CONFIG_GPIB_FMH) += fmh_gpib.o
> 
> which means it _will_ be built with allyesconfig. So it is not surprising
> that it fails to link allyesconfig builds. Actually, it will fail all builds
> with CONFIG_GPIB_FMH=y.

Arnd has a patch for this that I'll be queueing up this week and getting
to Linus also this week.

thanks,

greg k-h

