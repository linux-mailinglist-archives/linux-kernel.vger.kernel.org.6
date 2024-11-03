Return-Path: <linux-kernel+bounces-394231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7E9BAC2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED0A1F22FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020818C003;
	Mon,  4 Nov 2024 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBeyVOCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810218BB82;
	Mon,  4 Nov 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699213; cv=none; b=UjsSppt22odME5jsgszS3VZ5TnpNAX2H84s2CG80opwfr3kjynDksEsEeiNMd29xNgvbciUeJVKdScEiSTgyfOriiZ/Boo/kqbAK7C1liKA04ClNZMZXVcLUodpHB0TmTBotocS0nGCIW05NUfcY6lMEIzKRAujy+cl7N7XgC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699213; c=relaxed/simple;
	bh=6gW/lfMQuKvkTV8++YB2N4jXGelmIQ/KnTFrV2w/9yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUWQF9F/lDqc8OfvQFY3LJE0SWt/SgLRGi1w69bI2QcpczwK0GGae8LDvMYAlftoe4buupxWGRS7g8V9Zt2iwXqkT5qLexBbV4iCfWrUseDvTnnktztl8ek3yO0gzoDrsMUywVsrQSXi8bF3qY0maReycg1d6T6aEGSXWrqXGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBeyVOCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2FEC4CECE;
	Mon,  4 Nov 2024 05:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730699212;
	bh=6gW/lfMQuKvkTV8++YB2N4jXGelmIQ/KnTFrV2w/9yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBeyVOCA9f+381dh3MzoaTSQmIHktzJ01N2xc8v1S4uuXOulaedrFqghAeWP3uEvq
	 HqRDbvC+hDEinzvmey2Sc4Qee4X9Og1T5OCpqa77pfEztoAjWK8v8wbvs9nnviVyXs
	 fQq2P6JywkRVrSEsAey9RJOxrxRbnd6cXO/ZNPl4=
Date: Mon, 4 Nov 2024 00:45:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Cc: dpenkler@gmail.com, arnd@arndb.de, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gpib/common/gpib_os.c - Remove unnecessary OOM
 message
Message-ID: <2024110458-tank-very-49c4@gregkh>
References: <20241022180620.12429-1-m.omerfarukbulut@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022180620.12429-1-m.omerfarukbulut@gmail.com>

On Tue, Oct 22, 2024 at 09:06:20PM +0300, Omer Faruk BULUT wrote:
> It duplicate the MM subsystem generic OOM message. This patch fixes the following checkpatch warning.

Please wrap your changelog text at 72 columns.

> 
>     WARNING: Possible unnecessary 'out of memory' message
> 
> Also, this patch itself might teach to module writers or readers that they have to give attention to MM subsystem
> even they interest another one.

I do not understand this comment at all, sorry, what does it have to do
with the change happening in this proposal?

> 
> Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
> ---
>  drivers/staging/gpib/common/gpib_os.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
> index 6b12404efe7d..27654b2180a5 100644
> --- a/drivers/staging/gpib/common/gpib_os.c
> +++ b/drivers/staging/gpib/common/gpib_os.c
> @@ -2093,10 +2093,9 @@ void gpib_register_driver(gpib_interface_t *interface, struct module *provider_m
>  	struct gpib_interface_list_struct *entry;
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> -	if (!entry) {
> -		pr_err("gpib: failed register %s interface, out of memory\n", interface->name);
> +	if (!entry) 
>  		return;
> -	}
> +	

You added trailing whitespace, ALWAYS run scripts/checkpatch.pl on
changes you are submitting to the kernel, you don't want to add a new
problem when trying to fix a different one :)

thanks,

greg k-h

