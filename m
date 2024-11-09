Return-Path: <linux-kernel+bounces-402744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4CA9C2B65
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0271F219D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19521487F6;
	Sat,  9 Nov 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dqh+k6j+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D058C07;
	Sat,  9 Nov 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144689; cv=none; b=rluVaz1vASsuPK/xyjsWR/2rnL8JzAXZwOmxhkxElenXWzY3eL5TuVrH8C4U9tCn3KPHlWIUTu+gCNxkRjko5xVZ99lF4564Y6LF04iZFghP44G9uapcgMDM+cMe/nBrsALTvKdzDhjKTlNSYXV7LIep7RAOeJQjBT+LZx0KbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144689; c=relaxed/simple;
	bh=Hl4soNYNkoJoO8s2LrDmBcSuJ+qYTprtpvDjVX0t7zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJSPDH/diqAR/dXcduOKcrjuypapEBFwJ6EqnQleRuDa4LzJrI1KbZF1bc/7hXuf+bgkR9An/G/xWm46Du+wbQy0Tc+0t/vTafbmJbXoTtoVmKvRRWcbJssFLQ7XNKZjutNk7lw6YT9raoG9yewpHZcOb0PZ+5CpMs8F/BqXfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dqh+k6j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E75C4CECE;
	Sat,  9 Nov 2024 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731144688;
	bh=Hl4soNYNkoJoO8s2LrDmBcSuJ+qYTprtpvDjVX0t7zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dqh+k6j+BGpTnpGqlB4KIFRz7bk9LnwsPveSlAeiOQ2vUHX6l4x9nWm4SaqmEBJsc
	 lNPaNkUHX2gAVvgA+A4mxzgn+9kOkXCyAXbBEm0lZXQf9hW7dLz0fWSlo/9kbo6RK3
	 H2cAMNPNSk2afKaDHVB3d9lj10OfxrDYS6IjYiAU=
Date: Sat, 9 Nov 2024 10:31:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangheng <zhangheng@kylinos.cn>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: octeon: Use DEV_STAT_INC()
Message-ID: <2024110910-playroom-oppressed-6a7c@gregkh>
References: <20241109091909.4038571-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109091909.4038571-1-zhangheng@kylinos.cn>

On Sat, Nov 09, 2024 at 05:19:09PM +0800, zhangheng wrote:
> syzbot/KCSAN reported that races happen when multiple CPUs updating
> dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
> update the dev->stats fields.
> ---
>  drivers/staging/octeon/ethernet-tx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> index bbf33b88bb7c..f9c38bf25851 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -442,7 +442,7 @@ netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
>  	case QUEUE_DROP:
>  		skb->next = to_free_list;
>  		to_free_list = skb;
> -		dev->stats.tx_dropped++;
> +		DEV_STATS_INC(dev, tx_dropped);
>  		break;
>  	case QUEUE_HW:
>  		cvmx_fau_atomic_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, -1);
> @@ -516,7 +516,7 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
>  	if (unlikely(!work)) {
>  		printk_ratelimited("%s: Failed to allocate a work queue entry\n",
>  				   dev->name);
> -		dev->stats.tx_dropped++;
> +		DEV_STATS_INC(dev, tx_dropped);
>  		dev_kfree_skb_any(skb);
>  		return 0;
>  	}
> @@ -527,7 +527,7 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
>  		printk_ratelimited("%s: Failed to allocate a packet buffer\n",
>  				   dev->name);
>  		cvmx_fpa_free(work, CVMX_FPA_WQE_POOL, 1);
> -		dev->stats.tx_dropped++;
> +		DEV_STATS_INC(dev, tx_dropped);
>  		dev_kfree_skb_any(skb);
>  		return 0;
>  	}
> @@ -644,8 +644,8 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
>  	/* Submit the packet to the POW */
>  	cvmx_pow_work_submit(work, work->word1.tag, work->word1.tag_type,
>  			     cvmx_wqe_get_qos(work), cvmx_wqe_get_grp(work));
> -	dev->stats.tx_packets++;
> -	dev->stats.tx_bytes += skb->len;
> +	DEV_STATS_INC(dev, tx_packets);
> +	DEV_STATS_ADD(dev, tx_bytes, skb->len);
>  	dev_consume_skb_any(skb);
>  	return 0;
>  }
> -- 
> 2.45.2
> 
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

