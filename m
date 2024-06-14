Return-Path: <linux-kernel+bounces-214883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83E908B85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45ADF1C21664
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64795196D9A;
	Fri, 14 Jun 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HfKcuYZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDD187560;
	Fri, 14 Jun 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367567; cv=none; b=OF/F87qR1owdpldkMvJEoLIncY0NoLG09OnH2vWXyUNaZOMVpZ1GTxMC5/Bxb7C/Ctf30se3PAuuQcaPdN6KJDnud5MeRhVwZyc0T9n7Dpf4xlddXOEsxZQt+RSdSBpqbNYD6wgFEXgBhYDbtQGRBxKLI7aI83QygucD7rYDpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367567; c=relaxed/simple;
	bh=hk2wJWKdWSr6yMdrtnHXWxXOgLKEOsBAss/qBR+wnSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZa+di0RJ+yIyRY5FeB+QlG+An6BbC9FOULcRMpn5cDKNrHgsib1rCWggRs3C9NSs7wwFX5DwhbX3Z1ujPMPjZPXSiDLuRsa/w68lkUcftVP9PL7AkThc0DqIDw7um2M+yZGvbs5VZp0dFBiEFyphYl+3zYleJvNZld8kFReGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfKcuYZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9398C2BD10;
	Fri, 14 Jun 2024 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718367567;
	bh=hk2wJWKdWSr6yMdrtnHXWxXOgLKEOsBAss/qBR+wnSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfKcuYZBn5eYIDevNfYrlyJgBJq4po+7lmaIB5gVMh7EKJQ1yhOJhgL6IPidCps0q
	 NrikKCzLyWYop/VlnstmcdHGTGuFRDzPuj3ew9hgzVrxpCHY2DUN7J0LyJ8mSPLRf9
	 nyWkqZEg3EMdK52YqelrgFQ2ruXmKEa286B5M830=
Date: Fri, 14 Jun 2024 14:19:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>, Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/4] USB: make to_usb_driver() use container_of_const()
Message-ID: <2024061444-open-denote-804b@gregkh>
References: <2024061448-manly-universal-00ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061448-manly-universal-00ad@gregkh>

On Fri, Jun 14, 2024 at 02:11:49PM +0200, Greg Kroah-Hartman wrote:
> Turns out that we have some const pointers being passed to
> to_usb_driver() but were not catching this.  Change the macro to
> properly propagate the const-ness of the pointer so that we will notice
> when we try to write to memory that we shouldn't be writing to.
> 
> This requires fixing up the usb_match_dynamic_id() function as well,
> because it can handle a const * to struct usb_driver.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: Yajun Deng <yajun.deng@linux.dev>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/core/driver.c | 4 ++--
>  include/linux/usb.h       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 8e9bafcd62c6..c985a272e552 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -229,7 +229,7 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
>  }
>  
>  static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
> -							struct usb_driver *drv)
> +							const struct usb_driver *drv)

Oops, this requires a patch that I have not sent out yet that changes
the signature of all match() callbacks for busses, that is still winding
it's way through the build systems.  So I'll hold off on applying any of
this until that is accepted, but at least it's good to get this out for
review now to see if anyone objects to this series.

Also, I've tested this locally and all seems to work properly, but
finding good "unit tests" for adding new device ids is hard...

thanks,

greg k-h

