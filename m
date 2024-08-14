Return-Path: <linux-kernel+bounces-286797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8030951F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF991C225BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B481B4C3F;
	Wed, 14 Aug 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAXavuX9"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35241B3F1E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650762; cv=none; b=muNyBSqJp6yg8+n08Xnl7u8+nooKSIkTVmhBiNZU4y5ZoU+QH0LkKfwnTciDc59OsfD7ivW8RzyUbrvSfCAVI2d2x5BjtGEG9Wkb7c1NEXAXnnCk1tBYzYF1OZlLRXm5wpsSfNmanE4/4pald0wNj1YhopJruHTwmqIdcz7xAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650762; c=relaxed/simple;
	bh=kFJ/0flN14tAjBNKB8uLFY53F4y57WQAWCA5nszbP6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZRCyo/5C86W7nnk58lRvIkjdH3wq+dB0HoQ1i1hTU7WH0jiiMvVpRbJ5D1WYgWXQOdp6eu05cEVzAC6agYd80r5xOJU0ZJ2iMHw6TNteAbdT9hifn12JDZA4ox0MLEddn7mmyQMlqSpKDtF/GhulgdMQWNkrP7lZ+NqL/N1z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAXavuX9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70b2421471aso64332a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723650760; x=1724255560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcCdbI/FUUc+6rc9hEkn91YnRqL7K06FCdBgQ0Hf0J8=;
        b=ZAXavuX975cPS6MpPSnzA7nL2teaB/aZ03JYPrW2NZQ3lJVr9p4whtT6SYkyO9jTPO
         ZIHCpsbM2BM6WfNNAcfntN0CqRvL/Pz42Y6ZrmRw2nM73SqCPkInsjKPCeH/Ma67YtSV
         7wqFRhbVD28KLke4hQDwXZaDtMeoWnOUFuuoqdYSq4KgAxrSfs1J5Gr6q4AaDBYb4Vvu
         NJaeYY5GyiqTF2/jxAX0tMb6bVPmB3X6NDgkNqbewE+EaTzrzcopF5cO3xYT1pntdEM+
         lq6feGOHE+zMnWHdyNmE9ry73i/0XYl83SEEL1oPD7c4SAWIYbaOshEmDJcf6r4bhmQ9
         PG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650760; x=1724255560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcCdbI/FUUc+6rc9hEkn91YnRqL7K06FCdBgQ0Hf0J8=;
        b=hVPhcQZO/y3yHM7uheF9VhpPMynYuCQag4uCiAC3wNgYghK3QB6h4FR/CIDpbDFXaX
         TYiN4pkcrB5Wux1zZyXhr/jRjZua0M44NRVXKGjrdcbQNuTByMAWJPuo4UKTnMLy+EGq
         fk/gVWHbyAecr+/wgeOhxUCz1pjpJ0aEeYyhBPdCCFL4RRJuTccnPv23NPsMEikjNKGc
         rP45le2+PPQInWNLlWPm0A4ORA/o1yqi5SnidHGp56mf+b5htfCmh+y+f+5UYqFHiznC
         p5TeJtJHEoo5otGZnhqDc/zGoLJP3GWW3hvMasHH3HW3lY7BgG+DcaBjV6LZ/3V71NkI
         Ntog==
X-Forwarded-Encrypted: i=1; AJvYcCUgQzArn0v8ANKLb+Oacs0pR3N5ZnrwY2NywOLK2sx7WmVTY1ayjG93Nf/+6oMJvjT5g2FGJFAJJb4jB2zPROq1NlJ3JAtkBQlBt7re
X-Gm-Message-State: AOJu0YyES/nBO+mHQ4OcTtToZtqmvAs9qAhTeSuoRPW3JlH8rhptdnfa
	HUPSRtwN0TRqWiJHnpppAYGDzoQ87pILQ2ELSck2MxqI4nSZsrT/eLagMq//h3g=
X-Google-Smtp-Source: AGHT+IGTnK+od+WC3f2iNRHMgb89W2Yd+T+czWyaFTrNfvgFGlorx8l0R1Gzp8lOpG7q69sKMoRmpg==
X-Received: by 2002:a05:6a21:1584:b0:1c8:b65b:3db8 with SMTP id adf61e73a8af0-1c8eae4edf7mr4150745637.9.1723650759974;
        Wed, 14 Aug 2024 08:52:39 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:58b0:43ab:ed9f:f0e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d843bsm3258801a12.17.2024.08.14.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:52:39 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:52:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com,
	s-anna@ti.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] remoteproc: k3-r5: Acquire mailbox handle during
 probe routine
Message-ID: <ZrzSxdxt64UkgVS3@p14s>
References: <20240808074127.2688131-1-b-padhi@ti.com>
 <20240808074127.2688131-3-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808074127.2688131-3-b-padhi@ti.com>

Hi Beleswar,

On Thu, Aug 08, 2024 at 01:11:26PM +0530, Beleswar Padhi wrote:
> Acquire the mailbox handle during device probe and do not release handle
> in stop/detach routine or error paths. This removes the redundant
> requests for mbox handle later during rproc start/attach. This also
> allows to defer remoteproc driver's probe if mailbox is not probed yet.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 78 +++++++++---------------
>  1 file changed, 30 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 57067308b3c0..8a63a9360c0f 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -194,6 +194,10 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
>  	const char *name = kproc->rproc->name;
>  	u32 msg = omap_mbox_message(data);
>  
> +	/* Do not forward message from a detached core */
> +	if (kproc->rproc->state == RPROC_DETACHED)
> +		return;
> +
>  	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
>  
>  	switch (msg) {
> @@ -229,6 +233,10 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
>  	mbox_msg_t msg = (mbox_msg_t)vqid;
>  	int ret;
>  
> +	/* Do not forward message to a detached core */
> +	if (kproc->rproc->state == RPROC_DETACHED)
> +		return;
> +
>  	/* send the index of the triggered virtqueue in the mailbox payload */
>  	ret = mbox_send_message(kproc->mbox, (void *)msg);
>  	if (ret < 0)
> @@ -399,12 +407,9 @@ static int k3_r5_rproc_request_mbox(struct rproc *rproc)
>  	client->knows_txdone = false;
>  
>  	kproc->mbox = mbox_request_channel(client, 0);
> -	if (IS_ERR(kproc->mbox)) {
> -		ret = -EBUSY;
> -		dev_err(dev, "mbox_request_channel failed: %ld\n",
> -			PTR_ERR(kproc->mbox));
> -		return ret;
> -	}
> +	if (IS_ERR(kproc->mbox))
> +		return dev_err_probe(dev, PTR_ERR(kproc->mbox),
> +				     "mbox_request_channel failed\n");
>  
>  	/*
>  	 * Ping the remote processor, this is only for sanity-sake for now;
> @@ -552,10 +557,6 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  	u32 boot_addr;
>  	int ret;
>  
> -	ret = k3_r5_rproc_request_mbox(rproc);
> -	if (ret)
> -		return ret;
> -
>  	boot_addr = rproc->bootaddr;
>  	/* TODO: add boot_addr sanity checking */
>  	dev_dbg(dev, "booting R5F core using boot addr = 0x%x\n", boot_addr);
> @@ -564,7 +565,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  	core = kproc->core;
>  	ret = ti_sci_proc_set_config(core->tsp, boot_addr, 0, 0);
>  	if (ret)
> -		goto put_mbox;
> +		return ret;
>  
>  	/* unhalt/run all applicable cores */
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
> @@ -580,13 +581,12 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
>  			dev_err(dev, "%s: can not start core 1 before core 0\n",
>  				__func__);
> -			ret = -EPERM;
> -			goto put_mbox;
> +			return -EPERM;
>  		}
>  
>  		ret = k3_r5_core_run(core);
>  		if (ret)
> -			goto put_mbox;
> +			return ret;
>  	}
>  
>  	return 0;
> @@ -596,8 +596,6 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  		if (k3_r5_core_halt(core))
>  			dev_warn(core->dev, "core halt back failed\n");
>  	}
> -put_mbox:
> -	mbox_free_channel(kproc->mbox);
>  	return ret;
>  }
>  
> @@ -658,8 +656,6 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  			goto out;
>  	}
>  
> -	mbox_free_channel(kproc->mbox);
> -
>  	return 0;
>  
>  unroll_core_halt:
> @@ -674,42 +670,22 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  /*
>   * Attach to a running R5F remote processor (IPC-only mode)
>   *
> - * The R5F attach callback only needs to request the mailbox, the remote
> - * processor is already booted, so there is no need to issue any TI-SCI
> - * commands to boot the R5F cores in IPC-only mode. This callback is invoked
> - * only in IPC-only mode.
> + * The R5F attach callback is a NOP. The remote processor is already booted, and
> + * all required resources have been acquired during probe routine, so there is
> + * no need to issue any TI-SCI commands to boot the R5F cores in IPC-only mode.
> + * This callback is invoked only in IPC-only mode and exists because
> + * rproc_validate() checks for its existence.

Excellent documentation.

>   */
> -static int k3_r5_rproc_attach(struct rproc *rproc)
> -{
> -	struct k3_r5_rproc *kproc = rproc->priv;
> -	struct device *dev = kproc->dev;
> -	int ret;
> -
> -	ret = k3_r5_rproc_request_mbox(rproc);
> -	if (ret)
> -		return ret;
> -
> -	dev_info(dev, "R5F core initialized in IPC-only mode\n");
> -	return 0;
> -}
> +static int k3_r5_rproc_attach(struct rproc *rproc) { return 0; }
>  
>  /*
>   * Detach from a running R5F remote processor (IPC-only mode)
>   *
> - * The R5F detach callback performs the opposite operation to attach callback
> - * and only needs to release the mailbox, the R5F cores are not stopped and
> - * will be left in booted state in IPC-only mode. This callback is invoked
> - * only in IPC-only mode.
> + * The R5F detach callback is a NOP. The R5F cores are not stopped and will be
> + * left in booted state in IPC-only mode. This callback is invoked only in
> + * IPC-only mode and exists for sanity sake.

I would add the part about detach() being a NOP to attach() above...

>   */
> -static int k3_r5_rproc_detach(struct rproc *rproc)
> -{
> -	struct k3_r5_rproc *kproc = rproc->priv;
> -	struct device *dev = kproc->dev;
> -
> -	mbox_free_channel(kproc->mbox);
> -	dev_info(dev, "R5F core deinitialized in IPC-only mode\n");
> -	return 0;
> -}
> +static int k3_r5_rproc_detach(struct rproc *rproc) { return 0; }

... and just remove this.

Otherwise this patch looks good.

>  
>  /*
>   * This function implements the .get_loaded_rsc_table() callback and is used
> @@ -1278,6 +1254,10 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		kproc->rproc = rproc;
>  		core->rproc = rproc;
>  
> +		ret = k3_r5_rproc_request_mbox(rproc);
> +		if (ret)
> +			return ret;
> +
>  		ret = k3_r5_rproc_configure_mode(kproc);
>  		if (ret < 0)
>  			goto out;
> @@ -1392,6 +1372,8 @@ static void k3_r5_cluster_rproc_exit(void *data)
>  			}
>  		}
>  
> +		mbox_free_channel(kproc->mbox);
> +
>  		rproc_del(rproc);
>  
>  		k3_r5_reserved_mem_exit(kproc);
> -- 
> 2.34.1
> 

