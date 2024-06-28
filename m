Return-Path: <linux-kernel+bounces-234511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B226691C782
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A73FB27231
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C079B9D;
	Fri, 28 Jun 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xl1CP78Q"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F78BA53
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607741; cv=none; b=rck9ngQoUNgCm0eF2ldgMNZXxH8I0UiWGhztK33RcGhdu4eWONqUWFChpe3HgV5uqenofx0v+soVbaNLhZTGAK85YgLHm+cc+OAUBbP3+SwKZUecqNRFJOesMGZPMxppEPxr9LpR1njjkynwuEXc2r5qmNq5/ZZrd/LT2acIJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607741; c=relaxed/simple;
	bh=EAorGCg7r6Wr2iAgszF2xV+g4guLTY246hL8eXnlKRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqVgGFreQVaoCChccJ5F+FkZHTk7gNKtB34ZpCnBfLoG+qUIvucM2o+MKRttfgz/GwaeUKxqFNmVWg3Vy81sANluotY5HmRqkogxnrKYD3KdLHC1reDli6l1bnx7KJLzFF1BOkyN3+5MDs24nXxl9WxQpKL0ztdIazK5cAb7FPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xl1CP78Q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066f68e22cso853765b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719607738; x=1720212538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bw1rfSo1C4qRY3HRMB+pO6r6mbChHtcPy6u6MEj5Nr4=;
        b=xl1CP78QfCu1EB2hxgGnsDYp/chUcG6fjsk1xhv7JyBHxthAv2DeTYcZB2oBS1IUWs
         pVeFmzXGSTk+5I9rhmSNeUkDCrEyD452HW8Br3YExf9tIN0pCGz+oTLEKh3akSLeBpEk
         UiIsGxMJ+MkkicN/Nn1tNx7B+uNb2QIt8oZTy6DoRwWqzpqx07+HDB+e6xA2ogYV6oHq
         tW2iYHfNAYJyLqkolEobeBNa4kAUBI9lao7I1CelMKrTj3mDjh+Yy1EqIbNyRyX/rFFk
         C6oIS+h5stluy18/fv4iwYIUO7hlA4gI2TTy5C5Kk3e3FP2tp/tVAVns0pIDkW/7WgnX
         JP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607738; x=1720212538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw1rfSo1C4qRY3HRMB+pO6r6mbChHtcPy6u6MEj5Nr4=;
        b=CAGl38r7vqSaeRWPGkx4DClbkcpoxY9KqBQ60GuM28RzRS6ahEIpRgzeD2Bjstg+BY
         OwMOnSuOi3ulEmyvX5ycdstp/YgXTgYPexyAWPYvchFE6KrozqyJfzpCpWTJ68SteRgc
         Ui6NbyLdOKqBDRCSLyXkVXKPy1YDKvNwiT5DJK54GBbYDICpn5b7dxPTPKv/Kt8JZtjb
         n38Md2mUCsWYcbc+MWHWhE4H+9+ZgNqovMoVSmRf4dhRfaHstN7UG3EAfy2PackZCO7y
         Ob4IwOclulKMJDntqEYbB3NNY7bEdhAqeYrXGLwU8IrasBAiv3gQs0u23c2M9dNyR4X9
         VUQA==
X-Forwarded-Encrypted: i=1; AJvYcCXjACczMzT3g3BtLLFxUPOcSZcpYKoqc5HjmKEGzAPSWYqpWuAnMJYVNoPzH0G5tlgu/x03ubC9w+zYtss+7/e3OmS0stJwkSOmzegu
X-Gm-Message-State: AOJu0YzA2bwmuLKPiMm+pMErH0Q95t/C1Jl2ZeYdhtWqJiZWQG2tb/fj
	vZz8+Wcis+dGI8sxjtxiJfsyvAhVXFgw3Zr25VpChIkbIPi0RK20FRhY9SoZRjI=
X-Google-Smtp-Source: AGHT+IGX4Fw9+VwQkv9g3qTdfbkQFctJIrZrvzzpGsPigGshTmpgjBQfbNZmxivMYcsvp/ye0ENynQ==
X-Received: by 2002:a05:6a20:c428:b0:1be:9068:aa61 with SMTP id adf61e73a8af0-1be9068acbamr9129734637.36.1719607737803;
        Fri, 28 Jun 2024 13:48:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e53e:a53d:f473:181e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8df0e3sm1678587a12.36.2024.06.28.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:48:57 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:48:53 -0600
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
Subject: Re: [PATCH 2/4] remoteproc: k3-r5: Introduce PM suspend/resume
 handlers
Message-ID: <Zn8htULTLxyfMiWk@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621150058.319524-3-richard.genoud@bootlin.com>

On Fri, Jun 21, 2024 at 05:00:56PM +0200, Richard Genoud wrote:
> This patch adds the support for system suspend/resume to the ti_k3_R5
> remoteproc driver.
> 
> In order to save maximum power, the approach here is to shutdown
> completely the cores that were started by the kernel (i.e. those in
> RUNNING state).
> Those which were started before the kernel (in attached mode) will be
> detached.
> 
> The pm_notifier mechanism is used here because the remote procs firmwares
> have to be reloaded at resume, and thus the driver must have access to
> the file system were the firmware is stored.
> 
> On suspend, the running remote procs are stopped, the attached remote
> procs are detached and processor control released.
> 
> On resume, the reverse operation is done.
> 
> Based on work from: Hari Nagalla <hnagalla@ti.com>
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 123 ++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 39a47540c590..1f18b08618c8 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/remoteproc.h>
> +#include <linux/suspend.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  
> @@ -112,6 +113,7 @@ struct k3_r5_cluster {
>  	struct list_head cores;
>  	wait_queue_head_t core_transition;
>  	const struct k3_r5_soc_data *soc_data;
> +	struct notifier_block pm_notifier;
>  };
>  
>  /**
> @@ -577,7 +579,8 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  		/* do not allow core 1 to start before core 0 */
>  		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
>  					 elem);
> -		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
> +		if (core != core0 && (core0->rproc->state == RPROC_OFFLINE ||
> +				      core0->rproc->state == RPROC_SUSPENDED)) {

If I understand correctly, this is to address a possible race condition between
user space wanting to start core1 via sysfs while the system is being suspended.
Is this correct?  If so, please add a comment to explain what is going on.
Otherwise a comment is obviously needed.

>  			dev_err(dev, "%s: can not start core 1 before core 0\n",
>  				__func__);
>  			ret = -EPERM;
> @@ -646,7 +649,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  		/* do not allow core 0 to stop before core 1 */
>  		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
>  					elem);
> -		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
> +		if (core != core1 && core1->rproc->state != RPROC_OFFLINE &&
> +		    core1->rproc->state != RPROC_SUSPENDED) {
>  			dev_err(dev, "%s: can not stop core 0 before core 1\n",
>  				__func__);
>  			ret = -EPERM;
> @@ -1238,6 +1242,117 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	return ret;
>  }
>  
> +static int k3_r5_rproc_suspend(struct k3_r5_rproc *kproc)
> +{
> +	unsigned int rproc_state = kproc->rproc->state;
> +	int ret;
> +
> +	if (rproc_state != RPROC_RUNNING && rproc_state != RPROC_ATTACHED)
> +		return 0;
> +
> +	if (rproc_state == RPROC_RUNNING)
> +		ret = rproc_shutdown(kproc->rproc);
> +	else
> +		ret = rproc_detach(kproc->rproc);
> +
> +	if (ret) {
> +		dev_err(kproc->dev, "Failed to %s rproc (%d)\n",
> +			(rproc_state == RPROC_RUNNING) ? "shutdown" : "detach",
> +			ret);
> +		return ret;
> +	}
> +
> +	kproc->rproc->state = RPROC_SUSPENDED;
> +
> +	return ret;
> +}
> +
> +static int k3_r5_rproc_resume(struct k3_r5_rproc *kproc)
> +{
> +	int ret;
> +
> +	if (kproc->rproc->state != RPROC_SUSPENDED)
> +		return 0;
> +
> +	ret = k3_r5_rproc_configure_mode(kproc);
> +	if (ret < 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * ret > 0 for IPC-only mode
> +	 * ret == 0 for remote proc mode
> +	 */
> +	if (ret == 0) {
> +		/*
> +		 * remote proc looses its configuration when powered off.
> +		 * So, we have to configure it again on resume.
> +		 */
> +		ret = k3_r5_rproc_configure(kproc);
> +		if (ret < 0) {
> +			dev_err(kproc->dev, "k3_r5_rproc_configure failed (%d)\n", ret);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return rproc_boot(kproc->rproc);
> +}
> +
> +static int k3_r5_cluster_pm_notifier_call(struct notifier_block *bl,
> +					  unsigned long state, void *unused)
> +{
> +	struct k3_r5_cluster *cluster = container_of(bl, struct k3_r5_cluster,
> +						     pm_notifier);
> +	struct k3_r5_core *core;
> +	int ret;
> +
> +	switch (state) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		/* core1 should be suspended before core0 */
> +		list_for_each_entry_reverse(core, &cluster->cores, elem) {
> +			/*
> +			 * In LOCKSTEP mode, rproc is allocated only for
> +			 * core0
> +			 */
> +			if (core->rproc) {
> +				ret = k3_r5_rproc_suspend(core->rproc->priv);
> +				if (ret)
> +					dev_warn(core->dev,
> +						 "k3_r5_rproc_suspend failed (%d)\n", ret);
> +			}
> +
> +			ret = ti_sci_proc_release(core->tsp);
> +			if (ret)
> +				dev_warn(core->dev, "ti_sci_proc_release failed (%d)\n", ret);
> +		}
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +	case PM_POST_SUSPEND:
> +		/* core0 should be started before core1 */
> +		list_for_each_entry(core, &cluster->cores, elem) {
> +			ret = ti_sci_proc_request(core->tsp);
> +			if (ret)
> +				dev_warn(core->dev, "ti_sci_proc_request failed (%d)\n", ret);
> +
> +			/*
> +			 * In LOCKSTEP mode, rproc is allocated only for
> +			 * core0
> +			 */
> +			if (core->rproc) {
> +				ret = k3_r5_rproc_resume(core->rproc->priv);
> +				if (ret)
> +					dev_warn(core->dev,
> +						 "k3_r5_rproc_resume failed (%d)\n", ret);
> +			}
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  {
>  	struct k3_r5_cluster *cluster = platform_get_drvdata(pdev);
> @@ -1336,6 +1451,9 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		}
>  	}
>  
> +	cluster->pm_notifier.notifier_call = k3_r5_cluster_pm_notifier_call;
> +	register_pm_notifier(&cluster->pm_notifier);
> +
>  	return 0;
>  
>  err_split:
> @@ -1402,6 +1520,7 @@ static void k3_r5_cluster_rproc_exit(void *data)
>  		rproc_free(rproc);
>  		core->rproc = NULL;
>  	}
> +	unregister_pm_notifier(&cluster->pm_notifier);
>  }
>  
>  static int k3_r5_core_of_get_internal_memories(struct platform_device *pdev,

