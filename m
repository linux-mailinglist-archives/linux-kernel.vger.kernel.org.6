Return-Path: <linux-kernel+bounces-217136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C551B90AC14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BA0B27E97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E2195976;
	Mon, 17 Jun 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jozZN3I2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEA19596B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621098; cv=none; b=tL/L154FPgcn/FSx5soa2Ax1K7h1NDhCkI2L8DsluAGm5GXKuhjvdhp3c94B/WRML6E28RyGjtWhoF+9NfkTMvAo9t53+kpib8WqDpDdwm6FPTkmEuAjiqbHi9FcDUvY8SB4SaGKcuG9+f39U9g7UbPCzdiLEpMeavif/GcNhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621098; c=relaxed/simple;
	bh=1UyyMphKgqq8wTA1WbImtRMWjf3TSr/cBcv9RuxJrCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1dvYxrNLd4RJWaRxCh5Pd0gixY71s7tTGesj/3+ua+kpGHJ8GTmeeXUsAc9lMzl0isd/UjtCjrK4a3GdGDcEN8csNniwJctKlM1dfkXvqe3I0/3fbYzzXEPBJjQJ10YUAHfNXF7yohHQXGc+jspmLCq/Na1Tt4xzNqfWcMUMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jozZN3I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF874C2BD10;
	Mon, 17 Jun 2024 10:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718621098;
	bh=1UyyMphKgqq8wTA1WbImtRMWjf3TSr/cBcv9RuxJrCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jozZN3I2VQUeWNUxr2JusU6bbFIkE4jQHYpB0WsJWnim8hSiJSttyBwS1rUw8EV4/
	 n8hYDnyUicYU8XnrxnTFZH8aXtiZXVwc1pHNRfxkMBSX9GzSQGoDMFeIj56wn4ASSS
	 W6kEp74q9a4q/e9ZokdMUE7Sclgs1E2GXtOpnan0=
Date: Mon, 17 Jun 2024 12:44:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <2024061702-vexingly-hypocrisy-d93d@gregkh>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>

On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> There is a warning in kerneldoc documentation of container_of() that
> constness of @ptr is lost. While this is a suggestion container_of_const()
> should be used instead, the vast majority of new code still uses
> container_of():
> 
> $ git diff v6.8 v6.9|grep container_of\(|wc -l
> 788
> $ git diff v6.8 v6.9|grep container_of_const|wc -l
> 11

That is because container_of_const is new, and you don't normally go
back and change things unless you have to.  Which is what I am starting
to do for some cases now in the driver core interactions, but generally
it's rare to need this.

Also note that container_of_const does not work in an inline function,
which is another reason people might not want to use it.

> Make an explicit recommendation to use container_of_const(), unless @ptr
> is const but its container isn't.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/container_of.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 713890c867be..7563015ff165 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -13,7 +13,9 @@
>   * @type:	the type of the container struct this is embedded in.
>   * @member:	the name of the member within the struct.
>   *
> - * WARNING: any const qualifier of @ptr is lost.
> + * WARNING: any const qualifier of @ptr is lost. container_of() should only be
> + * used in cases where @ptr is const and its container is not and you know what
> + * you're doing. Otherwise always use container_of_const().

I know of no cases where a @ptr would be const yet the container would
not be, do you?  So why say that here?  That implies that it is a valid
thing to actually do.

I don't understand the goal here, do you want to just not have new
usages use container_of() at all?  Or are you trying to warn people of a
common problem that they make?  Having a const @ptr is not normal in the
kernel, so this should be ok.  If not, send patches to fix up those
users please.

thanks,

greg k-h

