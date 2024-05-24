Return-Path: <linux-kernel+bounces-188306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B68CE055
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A56728276E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8C374C3;
	Fri, 24 May 2024 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HqC2GcJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B88320B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524302; cv=none; b=cQ724NSERZzG4O4B91/YompL7Wh+GPY/7dvxZAJ7uxP893xw6rmQqvXMsYc3LkjrMM+E2lQZhVwHTy6Nx5wXswai2YSAt/vqfSxaL4mCStZvvvPeZZqpbd8rRRsxNbYaDQf+clnOOKOSMoLjJOzUYo3gGxXpKkYqsOKCog4R0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524302; c=relaxed/simple;
	bh=KruS2Bl/vxKNntVzAFhbKX5JUnSdGUtDqW423lr7tUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpugpvjcyqXmM995nsOI9Ygfq/9MwNlNM84QDlfa5PTYJvTBNx82f7/iJ7Hu0zjIj1P3Dv2riPGnBXLQYL+/6FcVgLLBPfJSvIaKzFGbhTo/bmgK6dfqn03tzmfOuh2ZCMUdqyOKLvK5A0p1tLCEr+/2LxEnvcVp+VRUw6oIATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HqC2GcJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A71BC2BBFC;
	Fri, 24 May 2024 04:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716524301;
	bh=KruS2Bl/vxKNntVzAFhbKX5JUnSdGUtDqW423lr7tUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqC2GcJi6pnbXNO+SThPeKjZRe3baaE1rnyCmJktkbWENrrtVfA/HhfO+t8sTP84b
	 3xfwsaIAppoLXNw33kABs8js+n1TvN2VwCoQv19qHoeDX8TSwQkgvfP+Hixbi/FRLY
	 sYoffpXPL61uyCH+awmzcPO+/k7iGkJ6+hyFa6uQ=
Date: Fri, 24 May 2024 06:18:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jim Wylder <jwylder@google.com>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
Message-ID: <2024052404-decrease-upbeat-0456@gregkh>
References: <20240523211437.2839942-1-jwylder@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523211437.2839942-1-jwylder@google.com>

On Thu, May 23, 2024 at 04:14:36PM -0500, Jim Wylder wrote:
> Currently, when an adapter defines a max_write_len quirk,
> the data will be chunked into data sizes equal to the
> max_write_len quirk value.  But the payload will be increased by
> the size of the register address before transmission.  The
> resulting value always ends up larger than the limit set
> by the quirk.
> 
> Avoid this error by setting regmap's max_write to the quirk's
> max_write_len minus the number of bytes for the register and
> padding.  This allows the chunking to work correctly for this
> limited case without impacting other use-cases.
> 
> Signed-off-by: Jim Wylder <jwylder@google.com>
> ---
>  drivers/base/regmap/regmap-i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
> index 3ec611dc0c09..a905e955bbfc 100644
> --- a/drivers/base/regmap/regmap-i2c.c
> +++ b/drivers/base/regmap/regmap-i2c.c
> @@ -350,7 +350,8 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
>  
>  		if (quirks->max_write_len &&
>  		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
> -			max_write = quirks->max_write_len;
> +			max_write = quirks->max_write_len -
> +				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
>  
>  		if (max_read || max_write) {
>  			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

