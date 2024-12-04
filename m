Return-Path: <linux-kernel+bounces-431517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BA9E3E69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C669F167229
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780D20C468;
	Wed,  4 Dec 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CY6yzd10"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA020C00E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326525; cv=pass; b=fnR4+HhH+UOXHbNcev8159Jlgo5d5UFH5ZYMgfSVWCDwDrmunEFnbKwDf5CoBjKuXvJCXtV0K5MyVcaRmHfc5Jqyw/0UpjcUh7W1HSXZ3resUfDwvdST+g9JHQCvxBRVIi5s+7281vl8PPPKAxqsbHyRY9CE+rbJKzf5wOAvA4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326525; c=relaxed/simple;
	bh=Nbwo6P/uPRE67HPJ566qFcdfmFRXCxUNpSVcBk+G6rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr2HSIQeZoXGnkgOnLUQ6U5y3YFauQFC5nmnvXLSsBCZYPPb9786L/3adGqYK/qIMA7o5OubMuMtg3k25oaPzY4ujnGAzreZ1UzbRNu89kovDVWz+g9KwYCNm3lvNYZqaRqTtJRErTluIzzkdIYrOABHBohHDig/KeomcrE3VQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=CY6yzd10; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733326497; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AIehJ9fEbhhm4kJwkGWgSEJh8czsOsL3QPurO4kBAHslwz46Z8m2obN2VSNV3Q7Tw3bgT6bgbAiH0xn1ub6Sl5y4MbmK80BJ4XVagxo4CZxUPDgP4JFNXOjSJ2Iki/7tx+yZa4xRY1QRuEcWe49dyjA4cOluhUR4XL+d7r2SBRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733326497; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZmWhxALGEwNNIpNs+NHmz3ldac02c9QiqU+UbgXG3/8=; 
	b=V/pSqO/a2J4LkvI5y6NYmHIMnwMID+NXo1M5cyszOMzmh+NawyYAW5qPr+/GZck4Y8cBJ+VmJ8Vog6dt2HM2IVOSSda0OH40T7wTiZnDrY0xW0Y3WWu2MwByRmZ6gFvLKmcwpvVB4D3R5y1MnIy8pQm4QlgNWH2pxToqnLUi1BY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733326497;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=ZmWhxALGEwNNIpNs+NHmz3ldac02c9QiqU+UbgXG3/8=;
	b=CY6yzd10YcUQKUCYm7FWBuWnHdR3yLjI3UNdkgITGerABYwerNurZp0rQoApTDUI
	S4jlQ+hRCCWCczzSl5+96L54jx4uGnSJqkUZV6BiKdgEq+orSlzG+AHVhEmVipGuD2P
	3mFnXGO/lNJzEmZvrsA5Il0oFqW4D/v4S/wPCP9k=
Received: by mx.zohomail.com with SMTPS id 1733326494458739.7174182116206;
	Wed, 4 Dec 2024 07:34:54 -0800 (PST)
Date: Wed, 4 Dec 2024 15:34:50 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/panfrost: Make re-enabling job interrupts at
 device reset optional
Message-ID: <em3uug2hv5lzzvujqvc34cv3jmoex5kw6q2q2pf3djpaumaxuz@4y47e2fag6ug>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
 <20241128211223.1805830-7-adrian.larumbe@collabora.com>
 <20241202122039.273f0e9f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202122039.273f0e9f@collabora.com>

Hi Boris,

On 02.12.2024 12:20, Boris Brezillon wrote:
> On Thu, 28 Nov 2024 21:06:21 +0000
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Rather than remasking interrupts after a device reset in the main reset
> > path, allow selecting whether to do this with an additional bool parameter.
> > 
> > To this end, split reenabling job interrupts into two functions, one that
> > clears the interrupts and another one which unmasks them conditionally.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 11 +++++--
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
> >  drivers/gpu/drm/panfrost/panfrost_job.c    | 34 ++++++++++++----------
> >  drivers/gpu/drm/panfrost/panfrost_job.h    |  3 +-
> >  4 files changed, 29 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 4fe29286bbe3..7e5d39699982 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -395,20 +395,25 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
> >  	return false;
> >  }
> >  
> > -void panfrost_device_reset(struct panfrost_device *pfdev)
> > +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  {
> > +	u32 irq_mask;
> > +
> >  	panfrost_gpu_soft_reset(pfdev);
> >  
> >  	panfrost_gpu_power_on(pfdev);
> >  	panfrost_mmu_reset(pfdev);
> > -	panfrost_job_enable_interrupts(pfdev);
> > +
> > +	irq_mask = panfrost_job_reset_interrupts(pfdev);
> > +	if (enable_job_int)
> > +		panfrost_enable_interrupts(pfdev, irq_mask);
> >  }
> >  
> >  static int panfrost_device_runtime_resume(struct device *dev)
> >  {
> >  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> >  
> > -	panfrost_device_reset(pfdev);
> > +	panfrost_device_reset(pfdev, true);
> >  	panfrost_devfreq_resume(pfdev);
> >  
> >  	return 0;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index d9aea2c2cbe5..fc83d5e104a3 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -205,7 +205,7 @@ int panfrost_unstable_ioctl_check(void);
> >  
> >  int panfrost_device_init(struct panfrost_device *pfdev);
> >  void panfrost_device_fini(struct panfrost_device *pfdev);
> > -void panfrost_device_reset(struct panfrost_device *pfdev);
> > +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
> >  
> >  extern const struct dev_pm_ops panfrost_pm_ops;
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index fba1a376f593..79d2ee3625b2 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -27,6 +27,10 @@
> >  #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
> >  #define job_read(dev, reg) readl(dev->iomem + (reg))
> >  
> > +#define JOB_INT_ENABLE_MASK			\
> > +	(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |	\
> > +	 GENMASK(NUM_JOB_SLOTS - 1, 0))
> > +
> >  struct panfrost_queue_state {
> >  	struct drm_gpu_scheduler sched;
> >  	u64 fence_context;
> > @@ -421,18 +425,23 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
> >  	return fence;
> >  }
> >  
> > -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
> > +u32 panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
> >  {
> >  	int j;
> >  	u32 irq_mask = 0;
> >  
> > -	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> > -
> >  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
> >  		irq_mask |= MK_JS_MASK(j);
> >  	}
> >  
> >  	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
> > +
> > +	return irq_mask;
> > +}
> 
> Let's define an ALL_JS_INT_MASK so we can get rid of the for loop and
> can avoid returning a value that's constant.

Because ALL_JS_INT_MASK would be defined as an OR of MK_JS_MASK() applications,
and this macro is defined in panfrost_regs.h, I can't think of a nice location
for it that would be suitable for all the files where it would be called.

Maybe I could implement the same loop inside panfrost_job_init() where it would be
called only once, and store the result in a const struct panfrost_job_slot field?

> > +
> > +void panfrost_enable_interrupts(struct panfrost_device *pfdev, u32 irq_mask)
> 
> Let's drop the irq_mask mask (use ALL_JS_INT_MASK), and call the
> function panfrost_job_enable_interrupts() instead.

I made a mistake here naming this function, it should've been panfrost_job_enable_interrupts().

Other than that, I decided to keep the irq_mask argument because I'm also calling it from
the very end of panfrost_reset() with JOB_INT_ENABLE_MASK, where I defined it to be

(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) | GENMASK(NUM_JOB_SLOTS - 1, 0))

That raises the question, what is the functional difference between writing either
this or MK_JS_MASK(0) | MK_JS_MASK(1) | MK_JS_MASK(2) into the JOB_INT_MASK register?

It's also being done in panfrost_job_irq_handler_thread() so I'm not quite sure of this.

> > +{
> > +	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> >  	job_write(pfdev, JOB_INT_MASK, irq_mask);
> >  }
> >  
> > @@ -725,12 +734,7 @@ panfrost_reset(struct panfrost_device *pfdev,
> >  	spin_unlock(&pfdev->js->job_lock);
> >  
> >  	/* Proceed with reset now. */
> > -	panfrost_device_reset(pfdev);
> > -
> > -	/* panfrost_device_reset() unmasks job interrupts, but we want to
> > -	 * keep them masked a bit longer.
> > -	 */
> > -	job_write(pfdev, JOB_INT_MASK, 0);
> > +	panfrost_device_reset(pfdev, false);
> >  
> >  	/* GPU has been reset, we can clear the reset pending bit. */
> >  	atomic_set(&pfdev->reset.pending, 0);
> > @@ -752,9 +756,7 @@ panfrost_reset(struct panfrost_device *pfdev,
> >  		drm_sched_start(&pfdev->js->queue[i].sched, 0);
> >  
> >  	/* Re-enable job interrupts now that everything has been restarted. */
> > -	job_write(pfdev, JOB_INT_MASK,
> > -		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> > -		  GENMASK(NUM_JOB_SLOTS - 1, 0));
> > +	panfrost_enable_interrupts(pfdev, JOB_INT_ENABLE_MASK);
> >  
> >  	dma_fence_end_signalling(cookie);
> >  }
> > @@ -827,9 +829,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
> >  
> >  	/* Enable interrupts only if we're not about to get suspended */
> >  	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
> > -		job_write(pfdev, JOB_INT_MASK,
> > -			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
> > -			  GENMASK(NUM_JOB_SLOTS - 1, 0));
> > +		job_write(pfdev, JOB_INT_MASK, JOB_INT_ENABLE_MASK);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -854,6 +854,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> >  {
> >  	struct panfrost_job_slot *js;
> >  	unsigned int nentries = 2;
> > +	u32 irq_mask;
> >  	int ret, j;
> >  
> >  	/* All GPUs have two entries per queue, but without jobchain
> > @@ -905,7 +906,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
> >  		}
> >  	}
> >  
> > -	panfrost_job_enable_interrupts(pfdev);
> > +	irq_mask = panfrost_job_reset_interrupts(pfdev);
> > +	panfrost_enable_interrupts(pfdev, irq_mask);
> >  
> >  	return 0;
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> > index ec581b97852b..c09d42ee5039 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> > @@ -46,7 +46,8 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
> >  int panfrost_job_get_slot(struct panfrost_job *job);
> >  int panfrost_job_push(struct panfrost_job *job);
> >  void panfrost_job_put(struct panfrost_job *job);
> > -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
> > +u32 panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
> > +void panfrost_enable_interrupts(struct panfrost_device *pfdev, u32 irq_mask);
> >  void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
> >  int panfrost_job_is_idle(struct panfrost_device *pfdev);
> >  

