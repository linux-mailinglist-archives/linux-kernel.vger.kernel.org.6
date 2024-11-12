Return-Path: <linux-kernel+bounces-405183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D729C4E02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092932822C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C27208208;
	Tue, 12 Nov 2024 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmc0KpAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60981990AB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387790; cv=none; b=KvYXSi2W53UdvCDheh+YIWTDZbE8+C2ZCbkEliLaj0YlnHnBAgzZm1ah0msO+TQC+IlfvjKMkAxEKzZCHaG/zHdEcMsgOg9a+cl/A9OUzTjTwNHKQ6Y3lGtk1B8+TW+CJfMdE9Is4bCfu3LB1FH7xlTiv1lGy/X4B1Zd00/zW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387790; c=relaxed/simple;
	bh=KtMNQQA+wJ0wtPfKZdiZSAlUAcv9vLCCaSdyUy7O0Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKcN2lGW6aRFwbuQeXkMZWWUTVNlLXNvhkmjGymRe8exSsJkqCw0j/Rh8TgIT2Fveq3Zy9GbEBYdUCbPb1DGO90tzrUvouzePiWmtwOCO07CWQf5Hb0+5EwkwW5kC3cHRnUysblIphQ+1xvZbtsPb/ogfBoTU50uU8bCSab6Syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmc0KpAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB29C4CECD;
	Tue, 12 Nov 2024 05:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731387790;
	bh=KtMNQQA+wJ0wtPfKZdiZSAlUAcv9vLCCaSdyUy7O0Gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bmc0KpAKEbx/qy0tpHhM4OzekGEf+cYoew7WelU3Tq8tHm9hXfyB0n94NrQ1P8B5B
	 F9KYO356wRtWu6dMyd+laX5DfpE9+fdRSBv5c9SaSqOcrJIRT1NmPcAfbDIIsrJErK
	 UU/ygxwSuIn9J7Wi3ml78TNQ71L0N+ExiY/KfznuOO1Yz5o1LthoV20cBSm+OO3b91
	 4fiehTYJvke7MMW9g+2LHfZgFSb/hLB6Wy5Txk3tNpG6QCAAFWW8n038+6Zw+fvDQg
	 XgbzN/iBCzSUpTF0svLgj2jpYHY0AGsQo1BCOBwl4EvqIX1dMPIWs3jAr0ogo/0HdK
	 VdkRcqmH6PtxQ==
Message-ID: <39c7413a-aa51-4fb2-b949-3f4e3a53839f@kernel.org>
Date: Tue, 12 Nov 2024 14:03:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] parport: use standard kernel printing functions
To: 412574090@163.com, sudipm.mukherjee@gmail.com, mpe@ellerman.id.au,
 davem@davemloft.net, andreas@gaisler.com,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, cassel@kernel.org,
 ojeda@kernel.org, edumazet@google.com, martin.petersen@oracle.co,
 perex@perex.cz, t.sailer@alumni.ethz.ch, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, xiongxin@kylinos.cn,
 weiyufeng <weiyufeng@kylinos.cn>
References: <20241112021153.18146-1-412574090@163.com>
 <20241112021153.18146-2-412574090@163.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241112021153.18146-2-412574090@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 11:11, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> change printk to standard kernel printing functions.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  drivers/net/hamradio/baycom_epp.c |  8 ++++----
>  drivers/net/hamradio/baycom_par.c |  6 +++---
>  drivers/parport/parport_pc.c      | 12 ++++++------
>  drivers/parport/procfs.c          |  2 +-

This is mixing changes for different drivers. Please split the net and ata part
into different patches and send the net ones to the correct list and maintainers.

>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
> index 9e366f275406..1b7fd6d49a96 100644
> --- a/drivers/net/hamradio/baycom_epp.c
> +++ b/drivers/net/hamradio/baycom_epp.c
> @@ -828,13 +828,13 @@ static int epp_open(struct net_device *dev)
>          }
>  #if 0
>          if (pp->irq < 0) {
> -                printk(KERN_ERR "%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
> +		pr_err("%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
>  		parport_put_port(pp);
>                  return -ENXIO;
>          }
>  #endif
>  	if ((~pp->modes) & (PARPORT_MODE_TRISTATE | PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
> -                printk(KERN_ERR "%s: parport at 0x%lx cannot be used\n",
> +		pr_err("%s: parport at 0x%lx cannot be used\n",
>  		       bc_drvname, pp->base);
>  		parport_put_port(pp);
>                  return -EIO;
> @@ -857,11 +857,11 @@ static int epp_open(struct net_device *dev)
>  	bc->pdev = parport_register_dev_model(pp, dev->name, &par_cb, i);
>  	parport_put_port(pp);
>          if (!bc->pdev) {
> -                printk(KERN_ERR "%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
> +		pr_err("%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
>                  return -ENXIO;
>          }
>          if (parport_claim(bc->pdev)) {
> -                printk(KERN_ERR "%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
> +		pr_err("%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
>                  parport_unregister_device(bc->pdev);
>                  return -EBUSY;
>          }
> diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
> index 00ebc25d0b22..4b57874c2463 100644
> --- a/drivers/net/hamradio/baycom_par.c
> +++ b/drivers/net/hamradio/baycom_par.c
> @@ -307,12 +307,12 @@ static int par96_open(struct net_device *dev)
>  		return -ENXIO;
>  	}
>  	if (pp->irq < 0) {
> -		printk(KERN_ERR "baycom_par: parport at 0x%lx has no irq\n", pp->base);
> +		pr_err("baycom_par: parport at 0x%lx has no irq\n", pp->base);
>  		parport_put_port(pp);
>  		return -ENXIO;
>  	}
>  	if ((~pp->modes) & (PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
> -		printk(KERN_ERR "baycom_par: parport at 0x%lx cannot be used\n", pp->base);
> +		pr_err("baycom_par: parport at 0x%lx cannot be used\n", pp->base);
>  		parport_put_port(pp);
>  		return -ENXIO;
>  	}
> @@ -339,7 +339,7 @@ static int par96_open(struct net_device *dev)
>  		return -ENXIO;
>  	}
>  	if (parport_claim(bc->pdev)) {
> -		printk(KERN_ERR "baycom_par: parport at 0x%lx busy\n", pp->base);
> +		pr_err("baycom_par: parport at 0x%lx busy\n", pp->base);
>  		parport_unregister_device(bc->pdev);
>  		return -EBUSY;
>  	}
> diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
> index f33b5d1ddfc1..609c10d4bc31 100644
> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -1609,7 +1609,7 @@ static int parport_ECP_supported(struct parport *pb)
>  
>  	priv->fifo_depth = i;
>  	if (verbose_probing)
> -		printk(KERN_DEBUG "0x%lx: FIFO is %d bytes\n", pb->base, i);
> +		pr_debug("0x%lx: FIFO is %d bytes\n", pb->base, i);
>  
>  	/* Find out writeIntrThreshold */
>  	frob_econtrol(pb, 1<<2, 1<<2);
> @@ -1623,7 +1623,7 @@ static int parport_ECP_supported(struct parport *pb)
>  
>  	if (i <= priv->fifo_depth) {
>  		if (verbose_probing)
> -			printk(KERN_DEBUG "0x%lx: writeIntrThreshold is %d\n",
> +			pr_debug("0x%lx: writeIntrThreshold is %d\n",
>  			       pb->base, i);
>  	} else
>  		/* Number of bytes we know we can write if we get an
> @@ -1676,16 +1676,16 @@ static int parport_ECP_supported(struct parport *pb)
>  	priv->pword = pword;
>  
>  	if (verbose_probing) {
> -		printk(KERN_DEBUG "0x%lx: PWord is %d bits\n",
> +		pr_debug("0x%lx: PWord is %d bits\n",
>  		       pb->base, 8 * pword);
>  
> -		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n",
> +		pr_debug("0x%lx: Interrupts are ISA-%s\n",
>  		       pb->base, config & 0x80 ? "Level" : "Pulses");
>  
>  		configb = inb(CONFIGB(pb));
> -		printk(KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
> +		pr_debug("0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
>  		       pb->base, config, configb);
> -		printk(KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
> +		pr_debug("0x%lx: ECP settings irq=", pb->base);
>  		if ((configb >> 3) & 0x07)
>  			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
>  		else
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 3880460e67f2..3f809fff317b 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -128,7 +128,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
>  	if (write) /* permissions prevent this anyway */
>  		return -EACCES;
>  
> -	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
> +	len += scnprintf(buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
>  
>  	if (len > *lenp)
>  		len = *lenp;


-- 
Damien Le Moal
Western Digital Research

