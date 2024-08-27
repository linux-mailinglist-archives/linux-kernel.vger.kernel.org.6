Return-Path: <linux-kernel+bounces-303172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D696088E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2929128459F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901721A00CE;
	Tue, 27 Aug 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gO9yZ4h7"
Received: from smtp109.ord1d.emailsrvr.com (smtp109.ord1d.emailsrvr.com [184.106.54.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9C4414
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758006; cv=none; b=P/wACQyhzsQ1W0rxk/0mHj7S4jdc6h+eqW5F8hXybaH9S/woKaGUa7gmdNI09ZE1+aieeWiUQHIQ2Nn4/Z6FJNXvICPLccvUwgYCABi4j9k2SLoHprKfQ/bH+xX0eAB7EUK77eVQQSRSfOwIXX45mn5DAdsQg3HlJk3WmizxD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758006; c=relaxed/simple;
	bh=CIhd73ZfmBrTJhBbFMjOTI758wLEV643QvHo1TMTCtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if14aogVNrq2FWmifE6qgXrD6+qwoUbT75PNbNqBLmEBSJpZ+hfJRnsLVJV4Wwwz9bCxN47wB/8Lj4aPmQ4e+IrSGs0at7mgIMcSIdfpUQZp28ODpVyJBe9gTU4Nd/Uy33RcQeiWO3JYUJK95+uOZNkS12jA0lT8+ixy0mmA1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gO9yZ4h7; arc=none smtp.client-ip=184.106.54.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1724754694;
	bh=CIhd73ZfmBrTJhBbFMjOTI758wLEV643QvHo1TMTCtQ=;
	h=Date:Subject:To:From:From;
	b=gO9yZ4h79XxKfpszz3R0KlG4L+w2+IP7KNVI3jLS4FnBEDzCxpimUu6uUBZlac70l
	 /yomhs1M3tYSGDszDlMjXCRcDhj7fsXPDqOTHy8xyeyEdDhEFXqhl0sKD+SYEwd+S1
	 kL5wycGp7G+vySssw//u6c19o5sLKWKgfqxPbtd4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9E95AE01E6;
	Tue, 27 Aug 2024 06:31:33 -0400 (EDT)
Message-ID: <c0654488-17b0-4ad2-bb0a-d6006d8198d6@mev.co.uk>
Date: Tue, 27 Aug 2024 11:31:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: comedi: Add driver register error handling in
 c6xdigio_attach()
To: Aleksandr Mishin <amishin@t-argos.ru>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240827074654.14131-1-amishin@t-argos.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240827074654.14131-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: c08bb0df-6035-43fd-a378-8ffacfdd8e00-1-1

On 27/08/2024 08:46, Aleksandr Mishin wrote:
> In c6xdigio_attach() there is a pnp_register_driver() call without return
> value check. But pnp_register_driver() can return error in some case
> (e.q. kzalloc() error in bus_add_driver() etc.).
> 
> Add return value check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2c89e159cd2f ("Staging: comedi: add c6xdigio driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/comedi/drivers/c6xdigio.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
> index 14b90d1c64dc..3f507f53518d 100644
> --- a/drivers/comedi/drivers/c6xdigio.c
> +++ b/drivers/comedi/drivers/c6xdigio.c
> @@ -250,7 +250,9 @@ static int c6xdigio_attach(struct comedi_device *dev,
>   		return ret;
>   
>   	/*  Make sure that PnP ports get activated */
> -	pnp_register_driver(&c6xdigio_pnp_driver);
> +	ret = pnp_register_driver(&c6xdigio_pnp_driver);
> +	if (ret)
> +		return ret;
>   
>   	s = &dev->subdevices[0];
>   	/* pwm output subdevice */

I think the problem is worse than that.  The c6xdigio_attach() function 
could be called more than once to attach multiple devices, which would 
register c6xdioio_pnp_driver more than once.  Also, if c6xdigio_attach() 
returns an error, c6xdigio_detach() will be called to clean up and 
attempt to unregister c6xdioio_pnp_driver.

What the driver is trying to do is to ensure that PNP parallel ports 
have been activated before it writes to the registers of a parallel 
port.  (Actually, all it has is a base address, but it assumes that 
belongs to one of the PNP parallel ports.)

To be honest, the driver should probably be rewritten to be a "parallel 
port device driver", but I doubt there would be many people with the 
hardware or the inclination to do this for what is really an obsolete 
bit of hardware.

Some possible ways to handle the situation:

1. Move the pnp_driver_register() / pnp_driver_unregister() stuff to be 
done at module load / unload time.

2. Remove all the PNP stuff.  The comedi_parport driver doesn't have any 
PNP stuff.  The user may have to activate the parallel port manually 
before attaching the Comedi device.

3. Remove the driver altogether.

I'd tend to favour option 2.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


