Return-Path: <linux-kernel+bounces-384408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7689B29C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC861C21AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921191917ED;
	Mon, 28 Oct 2024 08:00:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37527130A54
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102454; cv=none; b=kvtaUqPqIMFir6dS+xUNAC71CKM/bSxTbgZ7zEWfLMzEWBDKAapOon4N98UOfyjgrtRi4kEIIbYsIF1ebF1PjI+9kf+DpH2Yvv8tjm58Z1eIDNrWehQuDX+ZkQbJY9ngo3ZAfm7fGZatkFSMSuPMfOdbCJ97vrJk17QBbQKBTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102454; c=relaxed/simple;
	bh=x8Bfu5vWFv3Fc/QMiuL5iCTvie6UywJd6xUpt++IT3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sFSb6l7uBLk/1SllgfEv5SL2j06eer9ovZpmiuLETfQSww7MeC2ZZnWufOX8fhIy1UdzCxdtaMKr+XSvXyKifbDMbUMsPfSuSOk/TDmJLuNrBP2ar+kb8RyP8NScLBGDfOE4WvncZ9u0W/MR1KfhOUOYIsBCWxvi2IfIQ5Pn01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06890C4CEC3;
	Mon, 28 Oct 2024 08:00:51 +0000 (UTC)
Message-ID: <d036ebf5-2596-4d76-8b5c-df6b508bb3f6@xs4all.nl>
Date: Mon, 28 Oct 2024 09:00:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/44] media: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1729865485.git.namcao@linutronix.de>
 <2290f8a566605247d9842575dc3e6a630a1c1a72.1729865485.git.namcao@linutronix.de>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <2290f8a566605247d9842575dc3e6a630a1c1a72.1729865485.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2024 08:34, Nam Cao wrote:
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that it
> also sanity-checks and initializes the timer's callback function.
> 
> Switch to use this new function.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  drivers/media/cec/core/cec-pin.c                     | 3 +--
>  drivers/media/pci/cx88/cx88-input.c                  | 3 +--
>  drivers/media/platform/chips-media/wave5/wave5-vpu.c | 4 ++--
>  drivers/media/rc/pwm-ir-tx.c                         | 3 +--
>  4 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
> index 330d5d5d86ab..fe1cf365a25c 100644
> --- a/drivers/media/cec/core/cec-pin.c
> +++ b/drivers/media/cec/core/cec-pin.c
> @@ -1345,9 +1345,8 @@ struct cec_adapter *cec_pin_allocate_adapter(const struct cec_pin_ops *pin_ops,
>  	if (pin == NULL)
>  		return ERR_PTR(-ENOMEM);
>  	pin->ops = pin_ops;
> -	hrtimer_init(&pin->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	atomic_set(&pin->work_pin_num_events, 0);
> -	pin->timer.function = cec_pin_timer;
> +	hrtimer_setup(&pin->timer, cec_pin_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	init_waitqueue_head(&pin->kthread_waitq);
>  	pin->tx_custom_low_usecs = CEC_TIM_CUSTOM_DEFAULT;
>  	pin->tx_custom_high_usecs = CEC_TIM_CUSTOM_DEFAULT;
> diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
> index a04a1d33fadb..b9f2c14d62b4 100644
> --- a/drivers/media/pci/cx88/cx88-input.c
> +++ b/drivers/media/pci/cx88/cx88-input.c
> @@ -190,8 +190,7 @@ static int __cx88_ir_start(void *priv)
>  	ir = core->ir;
>  
>  	if (ir->polling) {
> -		hrtimer_init(&ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -		ir->timer.function = cx88_ir_work;
> +		hrtimer_setup(&ir->timer, cx88_ir_work, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  		hrtimer_start(&ir->timer,
>  			      ktime_set(0, ir->polling * 1000000),
>  			      HRTIMER_MODE_REL);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index 7273254ecb03..d7795d7f8a35 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -229,8 +229,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>  	dev->irq = platform_get_irq(pdev, 0);
>  	if (dev->irq < 0) {
>  		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
> -		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> -		dev->hrtimer.function = &wave5_vpu_timer_callback;
> +		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
> +			      HRTIMER_MODE_REL_PINNED);
>  		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
>  		if (IS_ERR(dev->worker)) {
>  			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index fe368aebbc13..84533fdd61aa 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -172,8 +172,7 @@ static int pwm_ir_probe(struct platform_device *pdev)
>  		rcdev->tx_ir = pwm_ir_tx_sleep;
>  	} else {
>  		init_completion(&pwm_ir->tx_done);
> -		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -		pwm_ir->timer.function = pwm_ir_timer;
> +		hrtimer_setup(&pwm_ir->timer, pwm_ir_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  		rcdev->tx_ir = pwm_ir_tx_atomic;
>  	}
>  


