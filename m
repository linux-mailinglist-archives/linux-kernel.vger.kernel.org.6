Return-Path: <linux-kernel+bounces-234560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1867191C80A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BFC1F22DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FDB7E103;
	Fri, 28 Jun 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghwI27hp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F17D075
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609625; cv=none; b=Pr2XY+w9pHhlLQIPJI75hP2llYXobj+YB+zXD+DSDPCaf+amJxWJ0zQ1h0cyBKD/KauJt1p5GNwNp9bEkAr3pRVI6S5UqIxKLQFhg0E6kZznls3CEmNrddnP9O5a1W8gO2mxc2rwvn2W/rX+bSMmmFrbPPMS1zk9y/4oKpMMgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609625; c=relaxed/simple;
	bh=v/0AHSicyouv6qevyMPHLaE9/MVi6bREV8txGNYsKeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6jYwz0zOmWxl7yxKWuENI6JcSo/zNwX6ZFarBBFYj04Q8QQ8B5JbnU3DmiRYe5aF0nSqh7Z24IXrYA1IU2N2nNeHVdhCRMlQP29QEOP89OFvueJxETMOekV6UuNzPQ3Dljp0Wrh12ijdbImJ/eS8bShDCrppQwy9DtQo7mTyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ghwI27hp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d0dso7830415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719609623; x=1720214423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TF1FH7Gcp9B1quTwQ+T41aksA7N+3aJeG/13qxR1G3E=;
        b=ghwI27hpwMA0lh406FtxZXcyDONOaqAKK322oXoNx5bwOWDcMcKU1cBVVQX8L4Hnmk
         PTJqne22fs25pjOY8J6maQKWc81GUFSC9jli7atIjuqqVjDkjyTUGoF/8l8sGSH8pFKq
         nEocEv2//CO32Ptm0JwYS+Kl/rrwNuEgM+moXuoqC2emJuIbWl0Xys7qXGvutng2PYwg
         lbUBxlwEDDKS+AmYpySaheeWzHpKqlwuxcc4ObW4GsRgBiUTFwD403B6oNbJlxz3OHab
         I1I9+Eqc+clTUyUTYyt1QqV/P4JUhZvPcILIveXy1nS09b3jps/7u1aMSxMJy4NvXTXY
         bgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609623; x=1720214423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF1FH7Gcp9B1quTwQ+T41aksA7N+3aJeG/13qxR1G3E=;
        b=heV7FpRaM8Smc7OkIGMsd2OKFJ9rOoKH8ZjmejUm/zTfkswgM9LNeLSeF7pZERaWn0
         lBD6tdYuH0nCvK/TWXYb9YPdMU38zp72dudhqwtoG+AeRYrbzCO5SHB91fhLhdiXQtyc
         YpY7ClgGgP9gj3iEuCKyUlXbn2CU63HQL22H+ijcjzhzDlzDPI1kk2mO4+Q7IiiuJMmk
         CYBc+0XjnKJSq2XcBDeQg3Qq9VRCIyzuXzoAiguPYw6o+3cjdHre2q0oWVK9GlyKSl4t
         xmTmmeUtiR5vMBJ0dz5seCXg1sU4K9DfT4Wv1IeqwgR+cU5ILV4nsG/78g0tcVXb3tI7
         UBbg==
X-Forwarded-Encrypted: i=1; AJvYcCVYF5SFT1mYvhMy5DxfW6Kz73FeH6UnZ0id1iklrE/nd0CuPXTwFoTKcDP7nyrTICstpf/t8lBDFSt9SyG6Y7FjO7CsSXYA1p1VI1Yt
X-Gm-Message-State: AOJu0YxMsk6wiv9APsFx22DDoE+oHWFrxb6n7krHvvC78kHiV0FVBqx7
	r101KYyO/R/HZrnr6lMFP0GtlsY73pBfeAblm+k3BAUk9bOBZ40t4zTqupJMH1c=
X-Google-Smtp-Source: AGHT+IEW8LmpyboHrxM65yt9BTDQh9+rBexihuXlCcxzMSMhI/wWpcRW/gnHLCvR375ksd3Hej9WQA==
X-Received: by 2002:a17:902:f604:b0:1f7:174d:3309 with SMTP id d9443c01a7336-1fa23edabb6mr222775315ad.30.1719609623535;
        Fri, 28 Jun 2024 14:20:23 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e53e:a53d:f473:181e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159919asm19950155ad.248.2024.06.28.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:20:23 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:20:20 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hari Nagalla <hnagalla@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] remoteproc: k3-r5: support for graceful stop of
 remote cores
Message-ID: <Zn8pFIGu2mYNP8vO@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-5-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621150058.319524-5-richard.genoud@bootlin.com>

On Fri, Jun 21, 2024 at 05:00:58PM +0200, Richard Genoud wrote:
> Introduce software IPC handshake between the K3-R5 remote proc driver
> and the R5 MCU to gracefully stop/reset the remote core.
> 
> Upon a stop request, K3-R5 remote proc driver sends a RP_MBOX_SHUTDOWN
> mailbox message to the remote R5 core.
> The remote core is expected to:
> - relinquish all the resources acquired through Device Manager (DM)
> - disable its interrupts
> - send back a mailbox acknowledgment RP_MBOX_SHUDOWN_ACK
> - enter WFI state.
> 
> Meanwhile, the K3-R5 remote proc driver does:
> - wait for the RP_MBOX_SHUTDOWN_ACK from the remote core
> - wait for the remote proc to enter WFI state
> - reset the remote core through device manager
> 
> Based on work from: Hari Nagalla <hnagalla@ti.com>
>

Why is this needed now and what happens to system with a new kernel driver and
an older K3R5 firmware?

Thanks,
Mathieu

> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/remoteproc/omap_remoteproc.h     |  9 +++++-
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 40 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
> index 828e13256c02..c008f11fa2a4 100644
> --- a/drivers/remoteproc/omap_remoteproc.h
> +++ b/drivers/remoteproc/omap_remoteproc.h
> @@ -42,6 +42,11 @@
>   * @RP_MBOX_SUSPEND_CANCEL: a cancel suspend response from a remote processor
>   * on a suspend request
>   *
> + * @RP_MBOX_SHUTDOWN: shutdown request for the remote processor
> + *
> + * @RP_MBOX_SHUTDOWN_ACK: successful response from remote processor for a
> + * shutdown request. The remote processor should be in WFI state short after.
> + *
>   * Introduce new message definitions if any here.
>   *
>   * @RP_MBOX_END_MSG: Indicates end of known/defined messages from remote core
> @@ -59,7 +64,9 @@ enum omap_rp_mbox_messages {
>  	RP_MBOX_SUSPEND_SYSTEM	= 0xFFFFFF11,
>  	RP_MBOX_SUSPEND_ACK	= 0xFFFFFF12,
>  	RP_MBOX_SUSPEND_CANCEL	= 0xFFFFFF13,
> -	RP_MBOX_END_MSG		= 0xFFFFFF14,
> +	RP_MBOX_SHUTDOWN	= 0xFFFFFF14,
> +	RP_MBOX_SHUTDOWN_ACK	= 0xFFFFFF15,
> +	RP_MBOX_END_MSG		= 0xFFFFFF16,
>  };
>  
>  #endif /* _OMAP_RPMSG_H */
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index a2ead87952c7..918a15e1dd9a 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -21,6 +21,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/remoteproc.h>
>  #include <linux/suspend.h>
> +#include <linux/iopoll.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  
> @@ -172,8 +173,23 @@ struct k3_r5_rproc {
>  	struct k3_r5_core *core;
>  	struct k3_r5_mem *rmem;
>  	int num_rmems;
> +	struct completion shutdown_complete;
>  };
>  
> +/*
> + * This will return true if the remote core is in Wait For Interrupt state.
> + */
> +static bool k3_r5_is_core_in_wfi(struct k3_r5_core *core)
> +{
> +	int ret;
> +	u64 boot_vec;
> +	u32 cfg, ctrl, stat;
> +
> +	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
> +
> +	return !ret ? !!(stat & PROC_BOOT_STATUS_FLAG_R5_WFI) : false;
> +}
> +
>  /**
>   * k3_r5_rproc_mbox_callback() - inbound mailbox message handler
>   * @client: mailbox client pointer used for requesting the mailbox channel
> @@ -209,6 +225,10 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
>  	case RP_MBOX_ECHO_REPLY:
>  		dev_info(dev, "received echo reply from %s\n", name);
>  		break;
> +	case RP_MBOX_SHUTDOWN_ACK:
> +		dev_dbg(dev, "received shutdown_ack from %s\n", name);
> +		complete(&kproc->shutdown_complete);
> +		break;
>  	default:
>  		/* silently handle all other valid messages */
>  		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> @@ -634,6 +654,7 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  	struct k3_r5_cluster *cluster = kproc->cluster;
>  	struct device *dev = kproc->dev;
>  	struct k3_r5_core *core1, *core = kproc->core;
> +	bool wfi;
>  	int ret;
>  
>  
> @@ -650,6 +671,24 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  		}
>  	}
>  
> +	/* Send SHUTDOWN message to remote proc */
> +	reinit_completion(&kproc->shutdown_complete);
> +	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_SHUTDOWN);
> +	if (ret < 0) {
> +		dev_err(dev, "Sending SHUTDOWN message failed: %d. Halting core anyway.\n", ret);
> +	} else {
> +		ret = wait_for_completion_timeout(&kproc->shutdown_complete,
> +						  msecs_to_jiffies(1000));
> +		if (ret == 0) {
> +			dev_err(dev, "Timeout waiting SHUTDOWN_ACK message. Halting core anyway.\n");
> +		} else {
> +			ret = readx_poll_timeout(k3_r5_is_core_in_wfi, core,
> +						 wfi, wfi, 200, 2000);
> +			if (ret)
> +				dev_err(dev, "Timeout waiting for remote proc to be in WFI state. Halting core anyway.\n");
> +		}
> +	}
> +
>  	/* halt all applicable cores */
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
>  		list_for_each_entry(core, &cluster->cores, elem) {
> @@ -1410,6 +1449,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  			goto err_config;
>  		}
>  
> +		init_completion(&kproc->shutdown_complete);
>  init_rmem:
>  		k3_r5_adjust_tcm_sizes(kproc);
>  

