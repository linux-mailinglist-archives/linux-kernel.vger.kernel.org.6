Return-Path: <linux-kernel+bounces-424611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D89DB6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C60EB215D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75119AD86;
	Thu, 28 Nov 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZrJCL5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0519ABAB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794553; cv=none; b=jAF3ynsdV+ZvM9P8mW2BZwKyC8v8/g+EXSr71COJHZXf8k2o9Gf2SUKM+OHoAFeTYL+n964NusNjhcmFnbw86U1uQOC53wHqG7QW4ExL2s0BfjDFnxWZkuace8wJX+9UP2oa+eWW34ONkpwaqOeJPZVYPbjj+461iwTR4gnC7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794553; c=relaxed/simple;
	bh=xFTGAQNd2QNHX1aT0+0FLZUVjbxhqrzUoeXxqONmRA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrFtOL0BufUs56+f+y0n6xXhqFlHID5vDc/XgbXRAv1rXiqr1dxzW/h7I9triWkODpCyBiCxHuYEjdK7d9JR7JwMnmXwb6o9pHOY6K7176c4FdnZSOSU5/5akzsOfa7URoXPYcPBBxjFQ9dEt4znIFW0UQm4pkk7JHXvBLO4xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZrJCL5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38691C4CECE;
	Thu, 28 Nov 2024 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732794552;
	bh=xFTGAQNd2QNHX1aT0+0FLZUVjbxhqrzUoeXxqONmRA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZrJCL5F/gIfZIjaCdEt5/0qx7RDOxHtqjCpJUZd5SjjHnwE7+ulXTUkYvjG51mQf
	 dno5NMnSf10NfRvzv/7eiTQwaVtMT60jRIiKayLje0FmBI8KLUPuXrdCpSoZ3hkb/F
	 r9wTyGzmPQKnGykU4LZ393VfMzhsNcCQOCZxtrQA=
Date: Thu, 28 Nov 2024 12:48:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: detach regmap from dev on regmap_exit
Message-ID: <2024112820-freeway-uncorrupt-8291@gregkh>
References: <20241127212233.330983-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127212233.330983-1-demonsingur@gmail.com>

On Wed, Nov 27, 2024 at 11:22:31PM +0200, Cosmin Tanislav wrote:
> At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
> is called, which adds a devres reference to the regmap, to be able to
> retrieve a dev's regmap by name using dev_get_regmap().
> 
> When calling regmap_exit, the opposite does not happen, and the
> reference is kept until the dev is detached.
> 
> Add a regmap_detach_dev() function, export it and call it in
> regmap_exit(), to make sure that the devres reference is not kept.
> 
> V2:
>  * switch to static function
> 
> Fixes: 72b39f6f2b5a ("regmap: Implement dev_get_regmap()")
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---
>  drivers/base/regmap/regmap.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 53131a7ede0a6..e3e2afc2c83c6 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -598,6 +598,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
>  }
>  EXPORT_SYMBOL_GPL(regmap_attach_dev);
>  
> +static int dev_get_regmap_match(struct device *dev, void *res, void *data);
> +
> +static int regmap_detach_dev(struct device *dev, struct regmap *map)
> +{
> +	if (!dev)
> +		return 0;
> +
> +	return devres_release(dev, dev_get_regmap_release,
> +			      dev_get_regmap_match, (void *)map->name);
> +}
> +
>  static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
>  					const struct regmap_config *config)
>  {
> @@ -1445,6 +1456,7 @@ void regmap_exit(struct regmap *map)
>  {
>  	struct regmap_async *async;
>  
> +	regmap_detach_dev(map->dev, map);
>  	regcache_exit(map);
>  
>  	regmap_debugfs_exit(map);
> -- 
> 2.47.0
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

