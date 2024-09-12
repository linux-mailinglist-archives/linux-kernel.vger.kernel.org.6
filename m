Return-Path: <linux-kernel+bounces-327049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56752977030
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D501E1F22153
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E71BF80F;
	Thu, 12 Sep 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="NNIOdk3X"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0014B092
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164892; cv=none; b=Luge5WDR4nRsbvReiJEx/+qndOdRzhybd8aU78sRnL2WVJ6YfCXDsTfnwLfI6zf+Lma2pmk02XPX8odfV5sddnaZ3CeMKIgA5/72Yk6r4hDhbCQ25SsE8G9cYovHXzwjKh7ZfqmaG0BNO/fVWFUrO6GxtbriTbPRcWWqsw1fkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164892; c=relaxed/simple;
	bh=+HQggDTb48nv1DwLQkLD9foewQLXw8Aiux/jD0hoWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2rOdpdiH4j7WkX6QTdfmqa3X5QjymGdT862YqFwjZRj6IQReAAfpzJpZR5lO6AQq5l47CQsO9g7/lSLAwe3ebRuGPh3qcNjLWpYJWOIUpbP6Snjdogwa4FTUAXIBUA0IXXNx1XFTAgXQiuJdM38+omJ3vpTAtaXhbqYali1H8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=NNIOdk3X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20551e2f1f8so646785ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1726164890; x=1726769690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTCkHRx5H0GrdZx2B8J8filp0hwbHeVUcL14p+eoS5U=;
        b=NNIOdk3XGHIRZ/uGfeAaErxoBkL8hWgg2rlopx3J+lSEXmPd1cjwrJfnVVfNs7w/0E
         ignASzNBQX8jx6LTqwxC7RrXiGEYBUGMCzgONvyBJEvZC7PRRn5Sa1gUIh0MU3ZZKqbY
         3XBqdeo9Ue/crR/MnDw8+QDeR/15TQ5aFvIHrUBv4+076YYL5PwFOKdMMF/gXbyUXtZI
         dsu98cIn358J49/9p8iyjXqQyr/3EslwCVFNTwVhd3yiCFY6tNWAoNCqSHiUkFPy5g3Q
         Kr1ei023dMioUJdUuAiGdZq6lfJqRtBKR23+5G2Vg0aE+XrSh3VIu/RUSx3adTpT7HHq
         BLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164890; x=1726769690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTCkHRx5H0GrdZx2B8J8filp0hwbHeVUcL14p+eoS5U=;
        b=jeh5K3LfNE8NlLP2KwSfZjnxcLZY8gHtEIXAxAlAhbpNrQ+14pCs/spBV0tK7y35HX
         /IBT4QTNXFroZNrEPH4sB3Ukr1mZrdjBN2jMSAsixBVeKY0td66Y7ABWiqLNm1HDeCbM
         qGsJgK5cXYK5AZm8ccU8VNu8DBh/iuNL9lwoZB30HVRPyhJXEcBbstNPSPrSfpWBbyfd
         8qbw2tQ0LhjhG3cOO4l+ynN2NCf/gJA8ba2PGXAQm0APsfcfKPt7qZ8rvQlGAGrpCZwU
         wnbRBY0gU5YFvaUnDyTivz0wFuS26gjTFPi90MY8jSQPxb40A/XWDn7oyptgE3D6BoRB
         U4EQ==
X-Gm-Message-State: AOJu0YzwskRUePTwMn1sAg+E7/2cBXG8jE3ENmwH35WWv8KOupSMkqFu
	pFa6h+CZrX4Zfa9EPutRSquF/Nfas1Lk5Aa2QOdqr30RkAUIP9ULH/mG7NICzE/VjMW4c+4ldOO
	h
X-Google-Smtp-Source: AGHT+IES6gxuzcgg38L1u8IaYwH13AjsFYXVLL2K2XpxJOIIVLvcDUdr/tR8bWgTUZx4m4aPRTPv0w==
X-Received: by 2002:a17:902:da91:b0:202:3432:230c with SMTP id d9443c01a7336-20781d62ac4mr707945ad.18.1726164889775;
        Thu, 12 Sep 2024 11:14:49 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:4680:a100:1c4a:720d:c0fa:efac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd503sm16920875ad.180.2024.09.12.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:14:49 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:14:49 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>
Subject: Re: [PATCH] pps: Remove embedded cdev to fix a use-after-free
Message-ID: <ZuMvmbf6Ru_pxhWn@mozart.vkv.me>
References: <ed73319e062495a56f5c8fd95c1674f891871882.1725820970.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed73319e062495a56f5c8fd95c1674f891871882.1725820970.git.calvin@wbinvd.org>

On Sunday 09/08 at 12:04 -0700, Calvin Owens wrote:
> On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
> in sys_exit() from gpsd when rebooting:
> 
>     pps pps1: removed
>     ------------[ cut here ]------------
>     kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
>     WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
>     CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
>     Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : kobject_put+0x120/0x150
>     lr : kobject_put+0x120/0x150
>     sp : ffffffc0803d3ae0
>     x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
>     x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
>     x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
>     x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
>     x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
>     x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
>     x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>     x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>     Call trace:
>      kobject_put+0x120/0x150
>      cdev_put+0x20/0x3c
>      __fput+0x2c4/0x2d8
>      ____fput+0x1c/0x38
>      task_work_run+0x70/0xfc
>      do_exit+0x2a0/0x924
>      do_group_exit+0x34/0x90
>      get_signal+0x7fc/0x8c0
>      do_signal+0x128/0x13b4
>      do_notify_resume+0xdc/0x160
>      el0_svc+0xd4/0xf8
>      el0t_64_sync_handler+0x140/0x14c
>      el0t_64_sync+0x190/0x194
>     ---[ end trace 0000000000000000 ]---
> 
> ...followed by more symptoms of corruption, with similar stacks:
> 
>     refcount_t: underflow; use-after-free.
>     kernel BUG at lib/list_debug.c:62!
>     Kernel panic - not syncing: Oops - BUG: Fatal exception
> 
> This happens because pps_device_destruct() frees the pps_device with the
> embedded cdev immediately after calling cdev_del(), but, as the comment
> above cdev_del() notes, fops for previously opened cdevs are still
> callable even after cdev_del() returns. I think this bug has always
> been there: I can't explain why it suddenly started happening every time
> I reboot this particular board.
> 
> In commit d953e0e837e6 ("pps: Fix a use-after free bug when
> unregistering a source."), George Spelvin suggested removing the
> embedded cdev. That seems like the simplest way to fix this, so I've
> implemented his suggestion, with pps_idr becoming the source of truth
> for which minor corresponds to which device.
> 
> But now that pps_idr defines userspace visibility instead of cdev_add(),
> we need to be sure the pps->dev kobject refcount can't reach zero while
> userspace can still find it again. So, the idr_remove() call moves to
> pps_unregister_cdev(), and pps_idr now holds a reference to the pps->dev
> kobject.
> 
> Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/pps/pps.c          | 85 ++++++++++++++++++++------------------
>  include/linux/pps_kernel.h |  1 -
>  2 files changed, 45 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 5d19baae6a38..72606d10f5f5 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -25,7 +25,7 @@
>   * Local variables
>   */
>  
> -static dev_t pps_devt;
> +static int pps_major;
>  static struct class *pps_class;
>  
>  static DEFINE_MUTEX(pps_idr_lock);
> @@ -296,19 +296,35 @@ static long pps_cdev_compat_ioctl(struct file *file,
>  #define pps_cdev_compat_ioctl	NULL
>  #endif
>  
> +static struct pps_device *pps_idr_get(unsigned long id)
> +{
> +	struct pps_device *pps;
> +
> +	mutex_lock(&pps_idr_lock);
> +	pps = idr_find(&pps_idr, id);
> +	if (pps)
> +		kobject_get(&pps->dev->kobj);
> +
> +	mutex_unlock(&pps_idr_lock);
> +	return pps;
> +}
> +
>  static int pps_cdev_open(struct inode *inode, struct file *file)
>  {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = pps_idr_get(iminor(inode));
> +
> +	if (!pps)
> +		return -ENODEV;
> +
>  	file->private_data = pps;
> -	kobject_get(&pps->dev->kobj);
>  	return 0;
>  }
>  
>  static int pps_cdev_release(struct inode *inode, struct file *file)
>  {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = file->private_data;
> +
> +	WARN_ON(pps->id != iminor(inode));
>  	kobject_put(&pps->dev->kobj);
>  	return 0;
>  }
> @@ -332,14 +348,6 @@ static void pps_device_destruct(struct device *dev)
>  {
>  	struct pps_device *pps = dev_get_drvdata(dev);
>  
> -	cdev_del(&pps->cdev);
> -
> -	/* Now we can release the ID for re-use */
> -	pr_debug("deallocating pps%d\n", pps->id);

Moving this pr_debug() to pps_unregister_cdev() was an oversight on my
part: it's better here, since that makes it easy to prove the object
isn't being leaked.

I'll wait a few more days in case there's more feedback, then I'll send
a v2 with that change.

Thanks,
Calvin

> -	mutex_lock(&pps_idr_lock);
> -	idr_remove(&pps_idr, pps->id);
> -	mutex_unlock(&pps_idr_lock);
> -
>  	kfree(dev);
>  	kfree(pps);
>  }
> @@ -364,39 +372,26 @@ int pps_register_cdev(struct pps_device *pps)
>  		goto out_unlock;
>  	}
>  	pps->id = err;
> -	mutex_unlock(&pps_idr_lock);
>  
> -	devt = MKDEV(MAJOR(pps_devt), pps->id);
> -
> -	cdev_init(&pps->cdev, &pps_cdev_fops);
> -	pps->cdev.owner = pps->info.owner;
> -
> -	err = cdev_add(&pps->cdev, devt, 1);
> -	if (err) {
> -		pr_err("%s: failed to add char device %d:%d\n",
> -				pps->info.name, MAJOR(pps_devt), pps->id);
> -		goto free_idr;
> -	}
> +	devt = MKDEV(pps_major, pps->id);
>  	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
>  							"pps%d", pps->id);
>  	if (IS_ERR(pps->dev)) {
>  		err = PTR_ERR(pps->dev);
> -		goto del_cdev;
> +		goto free_idr;
>  	}
>  
>  	/* Override the release function with our own */
>  	pps->dev->release = pps_device_destruct;
>  
> -	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
> -			MAJOR(pps_devt), pps->id);
> +	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
> +		 pps->id);
>  
> +	kobject_get(&pps->dev->kobj);
> +	mutex_unlock(&pps_idr_lock);
>  	return 0;
>  
> -del_cdev:
> -	cdev_del(&pps->cdev);
> -
>  free_idr:
> -	mutex_lock(&pps_idr_lock);
>  	idr_remove(&pps_idr, pps->id);
>  out_unlock:
>  	mutex_unlock(&pps_idr_lock);
> @@ -408,6 +403,13 @@ void pps_unregister_cdev(struct pps_device *pps)
>  	pr_debug("unregistering pps%d\n", pps->id);
>  	pps->lookup_cookie = NULL;
>  	device_destroy(pps_class, pps->dev->devt);
> +
> +	/* Now we can release the ID for re-use */
> +	pr_debug("deallocating pps%d\n", pps->id);
> +	mutex_lock(&pps_idr_lock);
> +	idr_remove(&pps_idr, pps->id);
> +	kobject_put(&pps->dev->kobj);
> +	mutex_unlock(&pps_idr_lock);
>  }
>  
>  /*
> @@ -427,6 +429,11 @@ void pps_unregister_cdev(struct pps_device *pps)
>   * so that it will not be used again, even if the pps device cannot
>   * be removed from the idr due to pending references holding the minor
>   * number in use.
> + *
> + * Since pps_idr holds a reference to the kobject, the returned
> + * pps_device is guaranteed to be valid until pps_unregister_cdev() is
> + * called on it. But after calling pps_unregister_cdev(), it may be
> + * freed at any time.
>   */
>  struct pps_device *pps_lookup_dev(void const *cookie)
>  {
> @@ -449,13 +456,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
>  static void __exit pps_exit(void)
>  {
>  	class_destroy(pps_class);
> -	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
> +	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
>  }
>  
>  static int __init pps_init(void)
>  {
> -	int err;
> -
>  	pps_class = class_create("pps");
>  	if (IS_ERR(pps_class)) {
>  		pr_err("failed to allocate class\n");
> @@ -463,8 +468,9 @@ static int __init pps_init(void)
>  	}
>  	pps_class->dev_groups = pps_groups;
>  
> -	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
> -	if (err < 0) {
> +	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
> +				      &pps_cdev_fops);
> +	if (pps_major < 0) {
>  		pr_err("failed to allocate char device region\n");
>  		goto remove_class;
>  	}
> @@ -477,8 +483,7 @@ static int __init pps_init(void)
>  
>  remove_class:
>  	class_destroy(pps_class);
> -
> -	return err;
> +	return pps_major;
>  }
>  
>  subsys_initcall(pps_init);
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index 78c8ac4951b5..8ee312788118 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -56,7 +56,6 @@ struct pps_device {
>  
>  	unsigned int id;			/* PPS source unique ID */
>  	void const *lookup_cookie;		/* For pps_lookup_dev() only */
> -	struct cdev cdev;
>  	struct device *dev;
>  	struct fasync_struct *async_queue;	/* fasync method */
>  	spinlock_t lock;
> -- 
> 2.45.2
> 

