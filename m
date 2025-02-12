Return-Path: <linux-kernel+bounces-510922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A2A3239E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7577A18C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89812080FE;
	Wed, 12 Feb 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqGom4mL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123032080D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356823; cv=none; b=UffPyoI/pdtgAINQJkNnVY96zco5FECJfogypiVjWXWYBPY/VBAL8fPO0OMOdgmweau6Iz4XUB4mB6+B2s5n33fQCE87evd6r6Td/rrYXoFHu8jN+kOxMicvgidJvoQfGBkUh2vZJGD7BYNltIX1wXv1El+WeboY2fHOwV/ejJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356823; c=relaxed/simple;
	bh=RStwyhBeUuokUbLwfjlmc4KbeEZhTJS4RymPFLvpCvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRRqeXVI8Za/pSot5BrmGlGoFlqoWWvGupQ1L5HpHqx+zVO+Tm5RF9MA+4SAwRk9O6iOSFhldzcxkinc78rhAnXTjNABREhKAubk6JVAIU89p9qyN0mvSSuVP+f78Q8DTefulcfcFmq5k5krLj3FGqKiwNMJ5hoJz3VKNzhl1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqGom4mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8E4C4CEDF;
	Wed, 12 Feb 2025 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739356822;
	bh=RStwyhBeUuokUbLwfjlmc4KbeEZhTJS4RymPFLvpCvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqGom4mLCtlrUGEtzHk1y/37iWRPVjfm4ebjzrUNwFFFFVtYfLSpbDsQy8HEFWdG5
	 jEILvg2wia6D/CloeM1PiTHOSxgOWD4i8zeN8e9TMhC8QMoDRIqNkXB5HMXLr3vmbC
	 3/a+x9L6c0TnC/jnDD+otkfJdd/dv8yS3ci34dtQ=
Date: Wed, 12 Feb 2025 11:39:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Message-ID: <2025021206-reliable-bucked-148c@gregkh>
References: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>

On Wed, Feb 12, 2025 at 11:31:34AM +0100, Luca Ceresoli wrote:
> Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> cycle detection logic") introduced a new struct device *con_dev and a
> get_dev_from_fwnode() call to get it, but without adding a corresponding
> put_device().
> 
> Link: https://lore.kernel.org/all/20241204124826.2e055091@booty/
> Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/base/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5a1f051981149dc5b5eee4fb69c0ab748a85956d..2fde698430dff98b5e30f7be7d43d310289c4217 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
>  out:
>  	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
>  	put_device(sup_dev);
> +	put_device(con_dev);
>  	put_device(par_dev);
>  	return ret;
>  }
> 
> ---
> base-commit: 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
> change-id: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae5f4aac0
> 
> Best regards,
> -- 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
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

