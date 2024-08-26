Return-Path: <linux-kernel+bounces-301554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871E95F274
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BF1C21A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5217C987;
	Mon, 26 Aug 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBNA5jyA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145414A617;
	Mon, 26 Aug 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677869; cv=none; b=tfqz6PIKVtRNNMNUIOWgGHTdrXoPkZfLLKEoszZqYMNpaCQk6SiWpwzKGJhSvUCuVQlVt27P87LgeJT98DmmluqS7IWQ+ck/mea9gAyn1pBDwVH/Pzf/pbivbnItM+IwRhh/EnaNpHrXkZxUMSa+N6OjUFbGXre8ikcLg8Hz6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677869; c=relaxed/simple;
	bh=0ppJbQ1K1Yzftc2Bz5hjnDOj8PGFXrJ4oVr1tSmFbdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4fwR3gMHTu3mHdgu0mqlBXGVQe92UyRC1I6iG9aImdGDuhit5s3R798G5BYGi7RrgMfkZnU9/DRqAhPLB4iREGplGvOzUeDmUPrmYIsefA9fKGsJrVxP8uVWQvmrPdkeQDYl6YuEUTwzmyJEge8XZocpxxzcDWwJJtW9Sa3KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBNA5jyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099FC5829B;
	Mon, 26 Aug 2024 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724677868;
	bh=0ppJbQ1K1Yzftc2Bz5hjnDOj8PGFXrJ4oVr1tSmFbdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBNA5jyAmqsMXesEJ/Jh3EpPV+JzcdC0kcca7j2q62fd1uzq94IftMuLFOk+oC0B2
	 W5+Sma+TJhKIwPof6m0DL3zc8x9LFW8j4QhdvNWsvZVidANj92hVN03Y5fpsfz5J9a
	 ksE6zvb1rfAtnXeEcnM3oeBdCEsANtmLOGbh0UEw=
Date: Mon, 26 Aug 2024 15:11:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
Message-ID: <2024082655-cubicle-flashily-6ab3@gregkh>
References: <20240826123602.1872-1-hpausten@protonmail.com>
 <20240826123602.1872-8-hpausten@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826123602.1872-8-hpausten@protonmail.com>

On Mon, Aug 26, 2024 at 12:38:36PM +0000, Harry Austen wrote:
> Xilinx clocking wizard IP core supports monitoring of up to four
> optional user clock inputs, with a corresponding interrupt for
> notification in change of clock state (stop, underrun, overrun or
> glitch). Give userspace access to this monitor logic through use of the
> UIO framework.
> 
> Implemented as an auxiliary_driver to avoid introducing UIO dependency
> to the main clock driver.
> 
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>  drivers/uio/Kconfig            |  8 ++++
>  drivers/uio/Makefile           |  1 +
>  drivers/uio/uio_xlnx_clk_mon.c | 71 ++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 drivers/uio/uio_xlnx_clk_mon.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index b060dcd7c6350..ca8a53de26a67 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -164,4 +164,12 @@ config UIO_DFL
>  	    opae-sdk/tools/libopaeuio/
>  
>  	  If you compile this as a module, it will be called uio_dfl.
> +
> +config UIO_XLNX_CLK_MON
> +	tristate "Xilinx user clock monitor support"
> +	depends on COMMON_CLK_XLNX_CLKWZRD
> +	help
> +	  Userspace I/O interface to the user clock monitor logic within the
> +	  Xilinx Clocking Wizard IP core.

Why do you want a UIO api for a clock device?  What userspace code is
going to access the hardware this way?  Why not use the normal
kernel/user apis instead?

thanks,

greg k-h

