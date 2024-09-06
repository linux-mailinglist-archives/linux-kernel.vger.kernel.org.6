Return-Path: <linux-kernel+bounces-319233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D7596F989
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF81C228EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A141CCB57;
	Fri,  6 Sep 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRnP9LRL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169F49620
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641241; cv=none; b=snSfys41IwxXNmgWAL12xJSGBntGToEazjpn0wCCPg4iW92E+7sI/WXl2MVI3wkFj7t6B/3akPniQWWjppdJ+SXuea6z5khY6VYWz+nMC941XOIcyvz+yTZnwkIugEOxV8/acRd5suxCXGWqYliQBOd0yRjAsp+5lnfUE8W/ToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641241; c=relaxed/simple;
	bh=ton7O+V1e26jOtDWr4Qfcok56EZ3DR+262yrKmyr9tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpcNaea7W8RC+bTwG30kTOuNxJJM3Fmr8t0wpfI2zP6gJhdnJVW7upnqMjIOiBGZymYjRqeqjVqVC6GMr6hJG2cyyTs2f2NsbSUbUc58D3cNstSanH/vZFKgVOJagKykp8A+klhBqnCep7sc18O7CI7y7tHdtVRupWbpGEjziBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRnP9LRL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so1613471a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725641239; x=1726246039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T3usHnu/v8e0Xg8M9ezvhS0wle7Ze5aY+c8lEWsAMY=;
        b=IRnP9LRLV8/k/lX56jVcmhCMx67seCZXcPt2lqKWuVnLWm4dJmsZ0xG/jol3Y4DjwG
         5gSI2KGq6DBNha26amHWdIkCo+92MQpj5PQZ5n1Ieg3OvPjxQZBtklwOPDyett+W9rJj
         WvwUz2a8aKfp2dx/Lu9LYAcPr6NbAIhqtKHrTPllZE6jRbdHjxlsmu0YHV7CNV5ybmRi
         NRzsm9DlPJydJsSdrMC1ZcZtiL3mUjjgQo2NAv78eyaxKO6gykyCoZy8dM8MDH+jUQcr
         uWcgic+gqNQ74cmJ9h6gGGeay7MEORSjgza17auqX7o1a3VOF6xnbylRtMh/TPUZmJ0c
         kUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641239; x=1726246039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T3usHnu/v8e0Xg8M9ezvhS0wle7Ze5aY+c8lEWsAMY=;
        b=LziTfhAZbcuZy0ujd7iHtG0qJTrg3ivCNCpTS3LDmxS8YZ9AcC5HHo1gqGgWObphfx
         izXX57ic6crTg53K/aMabJe/2wtFpsjyo3r1NNPJ5LKhXujy+HxBPusXCERAuAKzpqZF
         nDRPcvsIQD0TGaaRjNZ0GC26A44v2MjkWwpjFcQghBzcRqQ/D7cySzaBaUYlRzHj+zJM
         JHzN9uxSHEbTVZ3GaTsfcBr7/D3XuNONL/bFRb8iq74+d9ydANagvEvNVcxTAk4iw3gm
         z1RYeM3pFpwVS7GiblZL18604w/bZPxSBorEedyGZAxQ45SLoobR9TTk9s0iAI/JK8hl
         pJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4sieZS+qDUPbXP6ZYsJSeHtjfDsSqiWdwntHjwStlpuwECNA6GDIrZ7vdhlxRwYdp5zSyVJfdHinK5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OYF7E+Bd5eaNCZQ6gI39c/dnR73YgfdSrWm824vQfbWddN/B
	WNGsybdr9s4ti/QNwxiVWwM508ZVRtWnP7QwVk1OnjHGvUPgOaXsvcNs8oBu8tk=
X-Google-Smtp-Source: AGHT+IHA+K3A94H4s88gUuCzhChaP2HGs9QWaMHrgHbfRuAb7V63Uc8Pp8hUgieY7YmAglEcUtqytg==
X-Received: by 2002:a17:90b:3143:b0:2ca:7636:2217 with SMTP id 98e67ed59e1d1-2dad4de1151mr3795579a91.2.1725641239184;
        Fri, 06 Sep 2024 09:47:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:b394:c2cf:8799:232f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0837casm1804528a91.38.2024.09.06.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:47:18 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:47:15 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, s-anna@ti.com,
	u-kumar1@ti.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: k3-r5: Decouple firmware booting from probe
 routine
Message-ID: <ZtsyE2ibvJwuL7oH@p14s>
References: <20240906094045.2428977-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906094045.2428977-1-b-padhi@ti.com>

On Fri, Sep 06, 2024 at 03:10:45PM +0530, Beleswar Padhi wrote:
> The current implementation of the waiting mechanism in probe() waits for
> the 'released_from_reset' flag to be set which is done in
> k3_r5_rproc_prepare() as part of rproc_fw_boot(). This causes unexpected

If you are looking at rproc-next, @released_from_reset is set in
k3_r5_rproc_start().  Moreover, the waiting mechanic happens in
k3_r5_cluster_rproc_init(), which makes reading your changelog highly confusing.

> failures in cases where the firmware is unavailable at boot time,
> resulting in probe failure and removal of the remoteproc handles in the
> sysfs paths.
> 
> To address this, the waiting mechanism is refactored out of the probe
> routine into the appropriate k3_r5_rproc_prepare/unprepare() and
> k3_r5_rproc_start/stop() functions. This allows the probe routine to
> complete without depending on firmware booting, while still maintaining
> the required power-synchronization between cores.
> 
> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Posted this as a Fix as this was breaking usecases where we wanted to load a
> firmware by writing to sysfs handles in userspace.
> 
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 170 ++++++++++++++++-------
>  1 file changed, 118 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 747ee467da88..df8f124f4248 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -131,6 +131,7 @@ struct k3_r5_cluster {
>   * @btcm_enable: flag to control BTCM enablement
>   * @loczrama: flag to dictate which TCM is at device address 0x0
>   * @released_from_reset: flag to signal when core is out of reset
> + * @unhalted: flag to signal when core is unhalted
>   */
>  struct k3_r5_core {
>  	struct list_head elem;
> @@ -148,6 +149,7 @@ struct k3_r5_core {
>  	u32 btcm_enable;
>  	u32 loczrama;
>  	bool released_from_reset;
> +	bool unhalted;

Yet another flag?  @released_from_reset is not enough?  And why does it need to
be "unhalted" rather than something like "running"?  I will not move forward
with this patch until I get an R-B and a T-B from two other people at TI.

The above and the exchange with Jan Kiszka is furthering my belief that this
driver is up for a serious refactoring exercise.  From hereon I will only
consider bug fixes.

Thanks,
Mathieu

>  };
>  
>  /**
> @@ -448,13 +450,33 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  {
>  	struct k3_r5_rproc *kproc = rproc->priv;
>  	struct k3_r5_cluster *cluster = kproc->cluster;
> -	struct k3_r5_core *core = kproc->core;
> +	struct k3_r5_core *core0, *core1, *core = kproc->core;
>  	struct device *dev = kproc->dev;
>  	u32 ctrl = 0, cfg = 0, stat = 0;
>  	u64 boot_vec = 0;
>  	bool mem_init_dis;
>  	int ret;
>  
> +	/*
> +	 * R5 cores require to be powered on sequentially, core0 should be in
> +	 * higher power state than core1 in a cluster. So, wait for core0 to
> +	 * power up before proceeding to core1 and put timeout of 2sec. This
> +	 * waiting mechanism is necessary because rproc_auto_boot_callback() for
> +	 * core1 can be called before core0 due to thread execution order.
> +	 */
> +	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> +	core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
> +	if (cluster->mode == CLUSTER_MODE_SPLIT && core == core1 &&
> +	    core0->released_from_reset == false) {
> +		ret = wait_event_interruptible_timeout(cluster->core_transition,
> +						       core0->released_from_reset,
> +						       msecs_to_jiffies(2000));
> +		if (ret <= 0) {
> +			dev_err(dev, "can not power up core1 before core0");
> +			return -EPERM;
> +		}
> +	}
> +
>  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
>  	if (ret < 0)
>  		return ret;
> @@ -470,6 +492,12 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  		return ret;
>  	}
>  
> +	/* Notify all threads in the wait queue when core state has changed so
> +	 * that threads waiting for this condition can be executed.
> +	 */
> +	core->released_from_reset = true;
> +	wake_up_interruptible(&cluster->core_transition);
> +
>  	/*
>  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
>  	 * of TCMs, so there is no need to perform the s/w memzero. This bit is
> @@ -515,14 +543,46 @@ static int k3_r5_rproc_unprepare(struct rproc *rproc)
>  {
>  	struct k3_r5_rproc *kproc = rproc->priv;
>  	struct k3_r5_cluster *cluster = kproc->cluster;
> -	struct k3_r5_core *core = kproc->core;
> +	struct k3_r5_core *core0, *core1, *core = kproc->core;
>  	struct device *dev = kproc->dev;
>  	int ret;
>  
>  	/* Re-use LockStep-mode reset logic for Single-CPU mode */
> -	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
> -		k3_r5_lockstep_reset(cluster) : k3_r5_split_reset(core);
> +	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> +	    cluster->mode == CLUSTER_MODE_SINGLECPU)
> +		ret = k3_r5_lockstep_reset(cluster);
> +	else {
> +		/*
> +		 * R5 cores require to be powered off sequentially, core0 should
> +		 * be in higher power state than core1 in a cluster. So, wait
> +		 * for core1 to powered off before proceeding to core0 and put
> +		 * timeout of 2sec. This waiting mechanism is necessary to
> +		 * prevent stopping core0 before core1 from sysfs.
> +		 */
> +		core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> +		core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
> +
> +		if (core == core0 && core1->released_from_reset == true) {
> +			ret = wait_event_interruptible_timeout(cluster->core_transition,
> +							       !core1->released_from_reset,
> +							       msecs_to_jiffies(2000));
> +
> +			if (ret <= 0) {
> +				dev_err(dev, "can not power off core0 before core1");
> +				return -EPERM;
> +			}
> +		}
> +
> +		ret = k3_r5_split_reset(core);
> +
> +		/* Notify all threads in the wait queue when core state has
> +		 * changed so that threads waiting for this condition can be
> +		 * executed.
> +		 */
> +		core->released_from_reset = false;
> +		wake_up_interruptible(&cluster->core_transition);
> +	}
> +
>  	if (ret)
>  		dev_err(dev, "unable to disable cores, ret = %d\n", ret);
>  
> @@ -551,16 +611,34 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  	struct k3_r5_rproc *kproc = rproc->priv;
>  	struct k3_r5_cluster *cluster = kproc->cluster;
>  	struct device *dev = kproc->dev;
> -	struct k3_r5_core *core0, *core;
> +	struct k3_r5_core *core0, *core1, *core = kproc->core;
>  	u32 boot_addr;
>  	int ret;
>  
> +	/*
> +	 * R5 cores require to be powered on sequentially, core0 should be in
> +	 * higher power state than core1 in a cluster. So, wait for core0 to
> +	 * power up before proceeding to core1 and put timeout of 2sec. This
> +	 * waiting mechanism is necessary because rproc_auto_boot_callback() for
> +	 * core1 can be called before core0 due to thread execution order.
> +	 */
> +	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> +	core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
> +	if (cluster->mode == CLUSTER_MODE_SPLIT && core == core1 && core0->unhalted == false) {
> +		ret = wait_event_interruptible_timeout(cluster->core_transition,
> +						       core0->unhalted,
> +						       msecs_to_jiffies(2000));
> +		if (ret <= 0) {
> +			dev_err(dev, "can not power up core1 before core0");
> +			return -EPERM;
> +		}
> +	}
> +
>  	boot_addr = rproc->bootaddr;
>  	/* TODO: add boot_addr sanity checking */
>  	dev_dbg(dev, "booting R5F core using boot addr = 0x%x\n", boot_addr);
>  
>  	/* boot vector need not be programmed for Core1 in LockStep mode */
> -	core = kproc->core;
>  	ret = ti_sci_proc_set_config(core->tsp, boot_addr, 0, 0);
>  	if (ret)
>  		return ret;
> @@ -573,20 +651,15 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  				goto unroll_core_run;
>  		}
>  	} else {
> -		/* do not allow core 1 to start before core 0 */
> -		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
> -					 elem);
> -		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
> -			dev_err(dev, "%s: can not start core 1 before core 0\n",
> -				__func__);
> -			return -EPERM;
> -		}
> -
>  		ret = k3_r5_core_run(core);
>  		if (ret)
>  			return ret;
>  
> -		core->released_from_reset = true;
> +		/* Notify all threads in the wait queue when core state has
> +		 * changed so that threads waiting for this condition can be
> +		 * executed.
> +		 */
> +		core->unhalted = true;
>  		wake_up_interruptible(&cluster->core_transition);
>  	}
>  
> @@ -629,7 +702,7 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  	struct k3_r5_rproc *kproc = rproc->priv;
>  	struct k3_r5_cluster *cluster = kproc->cluster;
>  	struct device *dev = kproc->dev;
> -	struct k3_r5_core *core1, *core = kproc->core;
> +	struct k3_r5_core *core0, *core1, *core = kproc->core;
>  	int ret;
>  
>  	/* halt all applicable cores */
> @@ -642,19 +715,38 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  			}
>  		}
>  	} else {
> -		/* do not allow core 0 to stop before core 1 */
> -		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
> -					elem);
> -		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
> -			dev_err(dev, "%s: can not stop core 0 before core 1\n",
> -				__func__);
> -			ret = -EPERM;
> -			goto out;
> +		/*
> +		 * R5 cores require to be powered off sequentially, core0 should
> +		 * be in higher power state than core1 in a cluster. So, wait
> +		 * for core1 to powered off before proceeding to core0 and put
> +		 * timeout of 2sec. This waiting mechanism is necessary to
> +		 * prevent stopping core0 before core1 from sysfs.
> +		 */
> +		core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> +		core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
> +
> +		if (core == core0 && core1->unhalted == true) {
> +			ret = wait_event_interruptible_timeout(cluster->core_transition,
> +							       !core1->unhalted,
> +							       msecs_to_jiffies(2000));
> +
> +			if (ret <= 0) {
> +				dev_err(dev, "can not power off core0 before core1");
> +				ret = -EPERM;
> +				goto out;
> +			}
>  		}
>  
>  		ret = k3_r5_core_halt(core);
>  		if (ret)
>  			goto out;
> +
> +		/* Notify all threads in the wait queue when core state has
> +		 * changed so that threads waiting for this condition can be
> +		 * executed.
> +		 */
> +		core->unhalted = false;
> +		wake_up_interruptible(&cluster->core_transition);
>  	}
>  
>  	return 0;
> @@ -1145,12 +1237,6 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  		return reset_ctrl_status;
>  	}
>  
> -	/*
> -	 * Skip the waiting mechanism for sequential power-on of cores if the
> -	 * core has already been booted by another entity.
> -	 */
> -	core->released_from_reset = c_state;
> -
>  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
>  				     &stat);
>  	if (ret < 0) {
> @@ -1296,25 +1382,6 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>  			break;
>  
> -		/*
> -		 * R5 cores require to be powered on sequentially, core0
> -		 * should be in higher power state than core1 in a cluster
> -		 * So, wait for current core to power up before proceeding
> -		 * to next core and put timeout of 2sec for each core.
> -		 *
> -		 * This waiting mechanism is necessary because
> -		 * rproc_auto_boot_callback() for core1 can be called before
> -		 * core0 due to thread execution order.
> -		 */
> -		ret = wait_event_interruptible_timeout(cluster->core_transition,
> -						       core->released_from_reset,
> -						       msecs_to_jiffies(2000));
> -		if (ret <= 0) {
> -			dev_err(dev,
> -				"Timed out waiting for %s core to power up!\n",
> -				rproc->name);
> -			goto err_powerup;
> -		}
>  	}
>  
>  	return 0;
> @@ -1329,7 +1396,6 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		}
>  	}
>  
> -err_powerup:
>  	rproc_del(rproc);
>  err_add:
>  	k3_r5_reserved_mem_exit(kproc);
> -- 
> 2.34.1
> 

