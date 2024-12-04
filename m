Return-Path: <linux-kernel+bounces-431646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C39E404F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCB7B434D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00020CCCC;
	Wed,  4 Dec 2024 16:40:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1420CCDE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330428; cv=none; b=sLMIgnRt256bJn8SxY80uCmDItUSipPb3CfWy4W4dyidU3lHwLP2OdRPeFj7yZIdXpM+ZqIyeELVLqDKwEBG8Rbw8Lro2a+tKa6spT9aPk63DowFnK5YkPNq7d3d4hNbVzn7Xgh+8U8/dppuakpaHkv2sP2EZ8s5naTF4mIWdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330428; c=relaxed/simple;
	bh=u8ATg5MXGm01y3AGVlQ/z/ajWMKu2Tnro09yw8flXa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPdvQrETryme0xSXDULheuDCgujoEKYswo1LIgAce+3XAolgORJL4ZIB5A+Z3GgOm/o0JtQYXJudKVEL7H+OUty/zh4ci6qX74CFWmoKvAH8QLtqVXs2LS25CVSb5bPjEAYLQD4as7fTiZ+qlHr2h6p/T/HpWrUybPx/vY6IX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43381063;
	Wed,  4 Dec 2024 08:40:51 -0800 (PST)
Received: from [10.57.90.162] (unknown [10.57.90.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7053F5A1;
	Wed,  4 Dec 2024 08:40:21 -0800 (PST)
Message-ID: <e36019f8-a4e5-4327-91b3-b21a869d0660@arm.com>
Date: Wed, 4 Dec 2024 16:40:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] drm/panfrost: Make re-enabling job interrupts at
 device reset optional
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
 <20241128211223.1805830-7-adrian.larumbe@collabora.com>
 <20241202122039.273f0e9f@collabora.com>
 <em3uug2hv5lzzvujqvc34cv3jmoex5kw6q2q2pf3djpaumaxuz@4y47e2fag6ug>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <em3uug2hv5lzzvujqvc34cv3jmoex5kw6q2q2pf3djpaumaxuz@4y47e2fag6ug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2024 15:34, Adrián Larumbe wrote:
> Hi Boris,
> 
> On 02.12.2024 12:20, Boris Brezillon wrote:
>> On Thu, 28 Nov 2024 21:06:21 +0000
>> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
>>
>>> Rather than remasking interrupts after a device reset in the main reset
>>> path, allow selecting whether to do this with an additional bool parameter.
>>>
>>> To this end, split reenabling job interrupts into two functions, one that
>>> clears the interrupts and another one which unmasks them conditionally.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_device.c | 11 +++++--
>>>  drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
>>>  drivers/gpu/drm/panfrost/panfrost_job.c    | 34 ++++++++++++----------
>>>  drivers/gpu/drm/panfrost/panfrost_job.h    |  3 +-
>>>  4 files changed, 29 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> index 4fe29286bbe3..7e5d39699982 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> @@ -395,20 +395,25 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
>>>  	return false;
>>>  }
>>>  
>>> -void panfrost_device_reset(struct panfrost_device *pfdev)
>>> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>>>  {
>>> +	u32 irq_mask;
>>> +
>>>  	panfrost_gpu_soft_reset(pfdev);
>>>  
>>>  	panfrost_gpu_power_on(pfdev);
>>>  	panfrost_mmu_reset(pfdev);
>>> -	panfrost_job_enable_interrupts(pfdev);
>>> +
>>> +	irq_mask = panfrost_job_reset_interrupts(pfdev);
>>> +	if (enable_job_int)
>>> +		panfrost_enable_interrupts(pfdev, irq_mask);
>>>  }
>>>  
>>>  static int panfrost_device_runtime_resume(struct device *dev)
>>>  {
>>>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>>>  
>>> -	panfrost_device_reset(pfdev);
>>> +	panfrost_device_reset(pfdev, true);
>>>  	panfrost_devfreq_resume(pfdev);
>>>  
>>>  	return 0;
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>>> index d9aea2c2cbe5..fc83d5e104a3 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>>> @@ -205,7 +205,7 @@ int panfrost_unstable_ioctl_check(void);
>>>  
>>>  int panfrost_device_init(struct panfrost_device *pfdev);
>>>  void panfrost_device_fini(struct panfrost_device *pfdev);
>>> -void panfrost_device_reset(struct panfrost_device *pfdev);
>>> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
>>>  
>>>  extern const struct dev_pm_ops panfrost_pm_ops;
>>>  
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> index fba1a376f593..79d2ee3625b2 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> @@ -27,6 +27,10 @@
>>>  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
>>>  #define job_read(dev, reg) readl(dev->iomem + (reg))
>>>  
>>> +#define JOB_INT_ENABLE_MASK			\
>>> +	(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |	\
>>> +	 GENMASK(NUM_JOB_SLOTS - 1, 0))
>>> +
>>>  struct panfrost_queue_state {
>>>  	struct drm_gpu_scheduler sched;
>>>  	u64 fence_context;
>>> @@ -421,18 +425,23 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
>>>  	return fence;
>>>  }
>>>  
>>> -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
>>> +u32 panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
>>>  {
>>>  	int j;
>>>  	u32 irq_mask = 0;
>>>  
>>> -	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
>>> -
>>>  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
>>>  		irq_mask |= MK_JS_MASK(j);
>>>  	}
>>>  
>>>  	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
>>> +
>>> +	return irq_mask;
>>> +}
>>
>> Let's define an ALL_JS_INT_MASK so we can get rid of the for loop and
>> can avoid returning a value that's constant.
> 
> Because ALL_JS_INT_MASK would be defined as an OR of MK_JS_MASK() applications,
> and this macro is defined in panfrost_regs.h, I can't think of a nice location
> for it that would be suitable for all the files where it would be called.

I can't speak for Boris, but I'd be quite happy with a:

#define ALL_JS_INT_MASK 0x70007

We know NUM_JOB_SLOTS is a (hardware) constant so we can compute the
value once. That or MK_JS_MASK(0)|MK_JS_MASK(1)|MK_JS_MASK(2) if you
prefer, or of course the GENMASK() variant below.

> Maybe I could implement the same loop inside panfrost_job_init() where it would be
> called only once, and store the result in a const struct panfrost_job_slot field?

It seems silly wasting memory on a compile time constant...

>>> +
>>> +void panfrost_enable_interrupts(struct panfrost_device *pfdev, u32 irq_mask)
>>
>> Let's drop the irq_mask mask (use ALL_JS_INT_MASK), and call the
>> function panfrost_job_enable_interrupts() instead.
> 
> I made a mistake here naming this function, it should've been panfrost_job_enable_interrupts().
> 
> Other than that, I decided to keep the irq_mask argument because I'm also calling it from
> the very end of panfrost_reset() with JOB_INT_ENABLE_MASK, where I defined it to be
> 
> (GENMASK(16 + NUM_JOB_SLOTS - 1, 16) | GENMASK(NUM_JOB_SLOTS - 1, 0))
> 
> That raises the question, what is the functional difference between writing either
> this or MK_JS_MASK(0) | MK_JS_MASK(1) | MK_JS_MASK(2) into the JOB_INT_MASK register?

Hopefully none - the two values should be the same. Indeed the GENMASK
variant is possibly best because it encodes using NUM_JOB_SLOTS.
Although I have to admit I have to think harder to decode the GENMASK()
version than either of the other alternatives above.

Steve

> It's also being done in panfrost_job_irq_handler_thread() so I'm not quite sure of this.
> 
>>> +{
>>> +	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
>>>  	job_write(pfdev, JOB_INT_MASK, irq_mask);
>>>  }
>>>  
>>> @@ -725,12 +734,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>>>  	spin_unlock(&pfdev->js->job_lock);
>>>  
>>>  	/* Proceed with reset now. */
>>> -	panfrost_device_reset(pfdev);
>>> -
>>> -	/* panfrost_device_reset() unmasks job interrupts, but we want to
>>> -	 * keep them masked a bit longer.
>>> -	 */
>>> -	job_write(pfdev, JOB_INT_MASK, 0);
>>> +	panfrost_device_reset(pfdev, false);
>>>  
>>>  	/* GPU has been reset, we can clear the reset pending bit. */
>>>  	atomic_set(&pfdev->reset.pending, 0);
>>> @@ -752,9 +756,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>>>  		drm_sched_start(&pfdev->js->queue[i].sched, 0);
>>>  
>>>  	/* Re-enable job interrupts now that everything has been restarted. */
>>> -	job_write(pfdev, JOB_INT_MASK,
>>> -		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
>>> -		  GENMASK(NUM_JOB_SLOTS - 1, 0));
>>> +	panfrost_enable_interrupts(pfdev, JOB_INT_ENABLE_MASK);
>>>  
>>>  	dma_fence_end_signalling(cookie);
>>>  }
>>> @@ -827,9 +829,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
>>>  
>>>  	/* Enable interrupts only if we're not about to get suspended */
>>>  	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
>>> -		job_write(pfdev, JOB_INT_MASK,
>>> -			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
>>> -			  GENMASK(NUM_JOB_SLOTS - 1, 0));
>>> +		job_write(pfdev, JOB_INT_MASK, JOB_INT_ENABLE_MASK);
>>>  
>>>  	return IRQ_HANDLED;
>>>  }
>>> @@ -854,6 +854,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>>>  {
>>>  	struct panfrost_job_slot *js;
>>>  	unsigned int nentries = 2;
>>> +	u32 irq_mask;
>>>  	int ret, j;
>>>  
>>>  	/* All GPUs have two entries per queue, but without jobchain
>>> @@ -905,7 +906,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>>>  		}
>>>  	}
>>>  
>>> -	panfrost_job_enable_interrupts(pfdev);
>>> +	irq_mask = panfrost_job_reset_interrupts(pfdev);
>>> +	panfrost_enable_interrupts(pfdev, irq_mask);
>>>  
>>>  	return 0;
>>>  
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
>>> index ec581b97852b..c09d42ee5039 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
>>> @@ -46,7 +46,8 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
>>>  int panfrost_job_get_slot(struct panfrost_job *job);
>>>  int panfrost_job_push(struct panfrost_job *job);
>>>  void panfrost_job_put(struct panfrost_job *job);
>>> -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
>>> +u32 panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
>>> +void panfrost_enable_interrupts(struct panfrost_device *pfdev, u32 irq_mask);
>>>  void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>>>  int panfrost_job_is_idle(struct panfrost_device *pfdev);
>>>  


