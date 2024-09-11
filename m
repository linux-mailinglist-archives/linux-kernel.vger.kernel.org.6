Return-Path: <linux-kernel+bounces-324882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10D97520F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CA81F2311B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523631885B8;
	Wed, 11 Sep 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWZxIbrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774862AF1D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057653; cv=none; b=uQQ0cT81Z8E2Il8ASAKD6AKE7T6iIng356ECoWaJbOVXOW8l/mIH4tS4j2QlVZ9thrpCR4dggfMCg3ckOQRnCFyP7m9X5ZI9K8MqDAEe13YSTwCzXoABlbURZXoWTGf3KrZbvKG75UlM5fKESAFX6DL0cdk35DiDonTx2prE7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057653; c=relaxed/simple;
	bh=8NLLCGSBnceQhKCav3F/Ak9GrSUgCZL4tL2OY9LXMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsRcGPGtIpi/pnb9PdMAt9E4zG147NIoFST2oHlbxWOPZxh7I/OJKGe7EZ7tw9WpZ1b3ThX/kasXGmfxpEMJKCUa+CZ5xNtUcuhlLmzGRVFaXaYKBD1VuPUg9JoTWN9o+fvuwc4uAF2cQGGYkDPVFHkv80XWXltpPugMz1zwK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWZxIbrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAA0C4CEC5;
	Wed, 11 Sep 2024 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726057653;
	bh=8NLLCGSBnceQhKCav3F/Ak9GrSUgCZL4tL2OY9LXMSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWZxIbrHlgWxoGV9Ao2MKKl1+//0xVNjVIYzrZ1WlCa6stxLbM1h/imcvgxUWbWy5
	 /sxmG+g3oPxJHXlRwLuV+Gulm2wK4f2LNUVNzs7nOLnY92L56DdWtFUXBSbmuK8u8H
	 S2gXPoMpWzfxHBV182nGWU1OGe708bs3qu6oypZQ=
Date: Wed, 11 Sep 2024 14:27:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ruihai Zhou <zhou.ruihai@qq.com>
Cc: srinivas.kandagatla@linaro.org, msp@baylibre.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: Fix memleak in nvmem_add_cells_from_dt
 error path
Message-ID: <2024091117-undecided-scotch-c8f2@gregkh>
References: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>

On Wed, Sep 11, 2024 at 08:06:55PM +0800, Ruihai Zhou wrote:
> In the nvmem_add_cells_from_dt(), if the devicetree 'bits' property
> is outside of the valid range, the info.name alloc by kasprintf will
> cause memleak. Just free before return from nvmem_add_cells_from_dt
> in the error path.
> 
> Fixes: def3173d4f17 ("nvmem: core: Print error on wrong bits DT property")
> Signed-off-by: Ruihai Zhou <zhou.ruihai@qq.com>
> ---
>  drivers/nvmem/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 516dfd861b9f..ce71bee5e1a9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -826,6 +826,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
>  			info.nbits = be32_to_cpup(addr);
>  			if (info.bit_offset >= BITS_PER_BYTE || info.nbits < 1) {
>  				dev_err(dev, "nvmem: invalid bits on %pOF\n", child);
> +				kfree(info.name);
>  				of_node_put(child);
>  				return -EINVAL;
>  			}
> -- 
> 2.31.1
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

