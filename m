Return-Path: <linux-kernel+bounces-423718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88FC9DABD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C4D28239E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDDB200BB2;
	Wed, 27 Nov 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGw+A3qz"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010328370
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725030; cv=none; b=jGYkdiYOgv/V3Dg34FdJVro1Gxf3LeJ7lfsrhEfxaW/qE7kUoRy6AZv7f0n+70/DeD9JtDeSZ1V7I7KEw6cd47kGf7DvxbHE3RAyUk3pHvyiiIl5pBp7sa+YAe/dFkFkjkSHQcF5D5H8bY5QO4jaAnPmpLpsRI42pqtJXcSXn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725030; c=relaxed/simple;
	bh=55nVRWP/TFY67UqOwFIpAQVe1+HTP/Wql0MPVJLGYWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOjGBSgD5JqGxvwbceTOrwn/afUxqzhh7l3UC1/UFR3Q9Bjeu9scdo/kNpC+YcRIiWy+8HvnXF8N1z6c3I8jF0VEpFwgvAt4QA3nD08JM6+ZD2xi5bpjC3NvRTVQq3LwfpCbHs3ntgLGlW6bLSeKj2chrafG6ipeS/A/sdWHMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGw+A3qz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso2467910e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732725025; x=1733329825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy2xlTbgPnYX5SFsXNs+vGxKtjPPkFsz8owHPBZ67wE=;
        b=HGw+A3qzn02qf3udNxom4RR8wCZX3mOK6HOtjDhIkEjfg68AYqpIsPiWcY0ZODqk/l
         AFmGbeIj3xKAVAufcrStmqJ4K7sP7bjftuK9okUPbIl4k9nk4+33GO6ztnbp2OxhpN6H
         2p5XhOMOwiKORKBsz1DFGdzN7lahyloUY+ON+R1MxHhMbv71E9MJE0PpRx0bPImuUTzt
         +21BerJoY9s3TTnaKMIfPyz0IYpusfkZMuBpFi+TKDkPz99gD3fDfZo9mp+8XtxwYwHS
         I+jvM8x1AGwXWOclMchJdtg72HQc+iUF6wGu+jt6VbU8nK/1bKIkx3/VMZcrR34JG0sq
         WfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732725025; x=1733329825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy2xlTbgPnYX5SFsXNs+vGxKtjPPkFsz8owHPBZ67wE=;
        b=JAfesmX3g3wi9/7CssNEoea+csRPNg29wBiL4jeYZ440y6l+INQoOp+Zw4sGyCm9Xu
         yr6ai86L6MTqqsW1AFfYJLMLSmWWcAHFqLtyd+lT0o2kuVWdLZfNW9485tNV5/bTbiMK
         UZpNmWevW8Af/hdcLV0IsbH3i1f5fRrRfrSOt0k5t/uIMqmPgC8hlkOdKBzZNSh+bbyu
         Y8YBKJLnKot6rljlhJzCpqeg8VZM2885KeCrLhv6/BcrDo1XPIKLq4lxejrMz+TUIPUT
         WLsx7T0iL6rYJJdVnaQprAzwD9xo7uGGrTg7OXNddkYlb47DiqmIa4Xb9zS7tK5ma/fn
         bHfA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9vPQ67l2iXtYv7teKZPAW526gWeIzywBe2sBYu/s+K9Uxl1BG0aCY8JSAxy9YH3Q2BaoLa203nLzNbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBmwlWmLazFoaoe5fIqwUxi6cGHazMqzJ/wpJD7hHEAgDgJP7
	qIGS1DHnS3eDhLRS6XWlCtuDoUUDF+TN8Mja3OgNPVIxtJsN0aasMJwBSopxC9M=
X-Gm-Gg: ASbGnctV6zeKiCAwlx5DraYCz8lKQG9BSeO1tfW0R7QFL8hw4NQmfGLom2WtHt+zerw
	cjPzyVOWUTwRmhOtoiUvyIRauAzEx1aDZKwEfEDL1kvhLwICdxwSFFVSKwoAYt5K8T99WWTwLyj
	Ep9lMUwSdTy5U9+qthCRCLGvUZk1RZwnvv/9NxTN9pKIpupfCaNKbZqwNFvF5/mtHv/P92nkkoB
	CHb6DBREvY2cjeEO2bwEy2Loyu8/RuoBdn85yVLqtyjHfz5epIOBjEgllx0
X-Google-Smtp-Source: AGHT+IHF0JIBFwJk4rP7zdQcbAHf6fXibvYGSKmQAXl1iioCcHPIlj4/oQChnGQ0j5nwZ2Yh87b58A==
X-Received: by 2002:a05:6512:3d04:b0:53d:de69:debd with SMTP id 2adb3069b0e04-53df00d05ecmr2373496e87.17.1732725024853;
        Wed, 27 Nov 2024 08:30:24 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02a0fc5b5sm5712623a12.56.2024.11.27.08.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:30:23 -0800 (PST)
Message-ID: <ec11e7f4-ed82-44eb-8e72-5a5094b67cda@linaro.org>
Date: Wed, 27 Nov 2024 16:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] coresight-etm4x: change etmv4_drvdata spinlock type
 to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>, suzuki.poulose@arm.com,
 mike.leach@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, nd@arm.com,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <20241125094816.365472-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241125094816.365472-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/11/2024 9:48 am, Yeoreum Yun wrote:
> From: Levi Yun <yeoreum.yun@arm.com>
> 
> In coresight-etm4x drivers, etmv4_drvdata->spinlock can be held during
> __schedule() by perf_event_task_sched_out()/in().
> 
> Since etmv4_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> 
> To address this, change type etmv4_drvdata->spinlock
> in coresight-etm4x drivers, which can be called
> by perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

[...]

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a9f19629f3f8..2e6b79c37f87 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -174,99 +174,99 @@ static ssize_t reset_store(struct device *dev,
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
>   
> -	spin_lock(&drvdata->spinlock);
> -	if (val)
> -		config->mode = 0x0;
> +	scoped_guard(raw_spinlock, &drvdata->spinlock) {
> +		if (val)
> +			config->mode = 0x0;
>   
> -	/* Disable data tracing: do not trace load and store data transfers */
> -	config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
> -	config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
> +		/* Disable data tracing: do not trace load and store data transfers */
> +		config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
> +		config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
>   
> -	/* Disable data value and data address tracing */
> -	config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
> -			   ETM_MODE_DATA_TRACE_VAL);
> -	config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
> +		/* Disable data value and data address tracing */
> +		config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
> +				   ETM_MODE_DATA_TRACE_VAL);
> +		config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
>   
> -	/* Disable all events tracing */
> -	config->eventctrl0 = 0x0;
> -	config->eventctrl1 = 0x0;
> +		/* Disable all events tracing */
> +		config->eventctrl0 = 0x0;
> +		config->eventctrl1 = 0x0;
>   
> -	/* Disable timestamp event */
> -	config->ts_ctrl = 0x0;
> +		/* Disable timestamp event */
> +		config->ts_ctrl = 0x0;
>   
> -	/* Disable stalling */
> -	config->stall_ctrl = 0x0;
> +		/* Disable stalling */
> +		config->stall_ctrl = 0x0;
>   
> -	/* Reset trace synchronization period  to 2^8 = 256 bytes*/
> -	if (drvdata->syncpr == false)
> -		config->syncfreq = 0x8;
> +		/* Reset trace synchronization period  to 2^8 = 256 bytes*/
> +		if (drvdata->syncpr == false)
> +			config->syncfreq = 0x8;
>   
> -	/*
> -	 * Enable ViewInst to trace everything with start-stop logic in
> -	 * started state. ARM recommends start-stop logic is set before
> -	 * each trace run.
> -	 */
> -	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
> -	if (drvdata->nr_addr_cmp > 0) {
> -		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
> -		/* SSSTATUS, bit[9] */
> -		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
> -	}
> +		/*
> +		 * Enable ViewInst to trace everything with start-stop logic in
> +		 * started state. ARM recommends start-stop logic is set before
> +		 * each trace run.
> +		 */
> +		config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
> +		if (drvdata->nr_addr_cmp > 0) {
> +			config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
> +			/* SSSTATUS, bit[9] */
> +			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
> +		}
>   
> -	/* No address range filtering for ViewInst */
> -	config->viiectlr = 0x0;
> +		/* No address range filtering for ViewInst */
> +		config->viiectlr = 0x0;
>   
> -	/* No start-stop filtering for ViewInst */
> -	config->vissctlr = 0x0;
> -	config->vipcssctlr = 0x0;
> +		/* No start-stop filtering for ViewInst */
> +		config->vissctlr = 0x0;
> +		config->vipcssctlr = 0x0;
>   
> -	/* Disable seq events */
> -	for (i = 0; i < drvdata->nrseqstate-1; i++)
> -		config->seq_ctrl[i] = 0x0;
> -	config->seq_rst = 0x0;
> -	config->seq_state = 0x0;
> +		/* Disable seq events */
> +		for (i = 0; i < drvdata->nrseqstate-1; i++)
> +			config->seq_ctrl[i] = 0x0;
> +		config->seq_rst = 0x0;
> +		config->seq_state = 0x0;
>   
> -	/* Disable external input events */
> -	config->ext_inp = 0x0;
> +		/* Disable external input events */
> +		config->ext_inp = 0x0;
>   
> -	config->cntr_idx = 0x0;
> -	for (i = 0; i < drvdata->nr_cntr; i++) {
> -		config->cntrldvr[i] = 0x0;
> -		config->cntr_ctrl[i] = 0x0;
> -		config->cntr_val[i] = 0x0;
> -	}
> +		config->cntr_idx = 0x0;
> +		for (i = 0; i < drvdata->nr_cntr; i++) {
> +			config->cntrldvr[i] = 0x0;
> +			config->cntr_ctrl[i] = 0x0;
> +			config->cntr_val[i] = 0x0;
> +		}
>   
> -	config->res_idx = 0x0;
> -	for (i = 2; i < 2 * drvdata->nr_resource; i++)
> -		config->res_ctrl[i] = 0x0;
> +		config->res_idx = 0x0;
> +		for (i = 2; i < 2 * drvdata->nr_resource; i++)
> +			config->res_ctrl[i] = 0x0;
>   
> -	config->ss_idx = 0x0;
> -	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> -		config->ss_ctrl[i] = 0x0;
> -		config->ss_pe_cmp[i] = 0x0;
> -	}
> +		config->ss_idx = 0x0;
> +		for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> +			config->ss_ctrl[i] = 0x0;
> +			config->ss_pe_cmp[i] = 0x0;
> +		}
>   
> -	config->addr_idx = 0x0;
> -	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
> -		config->addr_val[i] = 0x0;
> -		config->addr_acc[i] = 0x0;
> -		config->addr_type[i] = ETM_ADDR_TYPE_NONE;
> -	}
> +		config->addr_idx = 0x0;
> +		for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
> +			config->addr_val[i] = 0x0;
> +			config->addr_acc[i] = 0x0;
> +			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
> +		}
>   
> -	config->ctxid_idx = 0x0;
> -	for (i = 0; i < drvdata->numcidc; i++)
> -		config->ctxid_pid[i] = 0x0;
> +		config->ctxid_idx = 0x0;
> +		for (i = 0; i < drvdata->numcidc; i++)
> +			config->ctxid_pid[i] = 0x0;
>   
> -	config->ctxid_mask0 = 0x0;
> -	config->ctxid_mask1 = 0x0;
> +		config->ctxid_mask0 = 0x0;
> +		config->ctxid_mask1 = 0x0;
>   
> -	config->vmid_idx = 0x0;
> -	for (i = 0; i < drvdata->numvmidc; i++)
> -		config->vmid_val[i] = 0x0;
> -	config->vmid_mask0 = 0x0;
> -	config->vmid_mask1 = 0x0;
> +		config->vmid_idx = 0x0;
> +		for (i = 0; i < drvdata->numvmidc; i++)
> +			config->vmid_val[i] = 0x0;
>   
> -	spin_unlock(&drvdata->spinlock);
> +		config->vmid_mask0 = 0x0;
> +		config->vmid_mask1 = 0x0;
> +	}

There's a lot of churn in this function just to use the new scoped 
guard, but there was only one lock and unlock anyway. There are a few 
other cases of this in the whole set.

The scoped guards make it easier to write correct code, but I'm not sure 
we gain anything here other than a bigger diff and more to review by 
changing already working code. Having said that I did review all the 
changes and I'm pretty sure they're all ok, so I'm on the fence about 
whether it's worth going back and undoing all of them.

Surely updating to raw spinlocks is a search and replace to fix a 
specific problem, and the scoped guard stuff can be done on a case by 
case basis when anything is re-written in the future?

I don't know if we're considering a fixes tag, if PREEMPT_RT is 6.12? 
It's probably not necessary but if so we definitely want to minimise the 
change.


