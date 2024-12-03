Return-Path: <linux-kernel+bounces-429415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCD9E1BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED6B1668F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1B1E5708;
	Tue,  3 Dec 2024 12:14:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D351EBFEB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228046; cv=none; b=rrH/WtGZcRtbUwkrZCYbRZl2XLqjcTveXpAw3dGdcycwFQtdkGidBqX1qSW6RSwV865it3Cn7An3TjDQytW5EN3pjoOBdF0L0py4UlGfYvdIMyce0pSbcwYqpRO9IJBO+og3DEXfsBZbZKRuROr0ddMPzgHUR2wCuFzEvmoF+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228046; c=relaxed/simple;
	bh=GqWO3fq4RQjDgaJzIdhE1lh8jWnl1zp60bvD9QgRXlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWFvWZFWDpitxbuYQ18HpbagYQ2xaa+2Q75jQOFXZ/B1FDVbAoQVICyDGXuQyskFWjgT6wfHQP6yPRfBYzb7O1vSLeKTglQXzQMZv7aB1YOpgOMFh2qhDADguVopa73NB5AN1laWHjslZXs0ksVZdUajItAhk8PxW3z++pWZgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5B3FEC;
	Tue,  3 Dec 2024 04:14:31 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21493F58B;
	Tue,  3 Dec 2024 04:14:02 -0800 (PST)
Date: Tue, 3 Dec 2024 12:14:00 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] firmware/arm_ffa: change ffa_device_register()'s
 parameters and return
Message-ID: <Z072CGn6fhnT0hED@bogus>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
 <20241125095251.366866-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125095251.366866-2-yeoreum.yun@arm.com>

On Mon, Nov 25, 2024 at 09:52:49AM +0000, Yeoreum Yun wrote:
> From: Levi Yun <yeoreum.yun@arm.com>
> 
> Currently, ffa_dev->properties is set after ffa_device_register() in
> ffa_setup_partitions().
> This means it couldn't validate partition's properties
> while probing ffa_device.
> 
> Change parameter of ffa_device_register() to receive ffa_partition_info
> so that before device_register(), ffa_device->properties can be setup
> and any other data.
> 
> Also, change return value of ffa_device_register() from NULL to ERR_PTR
> so that it passes error code.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/firmware/arm_ffa/bus.c    | 22 +++++++++++++++-------
>  drivers/firmware/arm_ffa/driver.c | 12 ++++--------
>  include/linux/arm_ffa.h           | 12 ++++++++----
>  3 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
> index eb17d03b66fe..95c0e9518556 100644
> --- a/drivers/firmware/arm_ffa/bus.c
> +++ b/drivers/firmware/arm_ffa/bus.c
> @@ -38,6 +38,7 @@ static int ffa_device_match(struct device *dev, const struct device_driver *drv)
>  
>  		if (uuid_equal(&ffa_dev->uuid, &id_table->uuid))
>  			return 1;
> +

Spurious, don't add formatting or style changes in functional change. We
can take it up later when there are other formatting issues.

>  		id_table++;
>  	}
>  
> @@ -187,21 +188,26 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
>  	return valid;
>  }
>  
> -struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
> -				       const struct ffa_ops *ops)
> +struct ffa_device *ffa_device_register(
> +		const struct ffa_partition_info *part_info,
> +		const struct ffa_ops *ops)
>  {
>  	int id, ret;
> +	uuid_t uuid;
>  	struct device *dev;
>  	struct ffa_device *ffa_dev;
>  
> +	if (!part_info)
> +		return ERR_PTR(-EINVAL);
> +
>  	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
>  	if (id < 0)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
>  	if (!ffa_dev) {
>  		ida_free(&ffa_bus_id, id);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);

I am not keen on changing the error from NULL here. -ENOMEM has its own
logging. ida_alloc failing is very unlikely unless you have so many
partitions in the system.

>  	}
>  
>  	dev = &ffa_dev->dev;
> @@ -210,16 +216,18 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
>  	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
>  
>  	ffa_dev->id = id;
> -	ffa_dev->vm_id = vm_id;
> +	ffa_dev->vm_id = part_info->id;
> +	ffa_dev->properties = part_info->properties;
>  	ffa_dev->ops = ops;
> -	uuid_copy(&ffa_dev->uuid, uuid);
> +	import_uuid(&uuid, (u8 *)part_info->uuid);
> +	uuid_copy(&ffa_dev->uuid, &uuid);
>  
>  	ret = device_register(&ffa_dev->dev);
>  	if (ret) {
>  		dev_err(dev, "unable to register device %s err=%d\n",
>  			dev_name(dev), ret);

This error log will give the information you are adding in driver.c, so
it is again not needed to change that.

>  		put_device(dev);
> -		return NULL;
> +		return ERR_PTR(ret);
>  	}
>  
>  	return ffa_dev;
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index b14cbdae94e8..a3a9cdec7389 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -1406,23 +1406,19 @@ static int ffa_setup_partitions(void)
>  
>  	xa_init(&drv_info->partition_info);
>  	for (idx = 0, tpbuf = pbuf; idx < count; idx++, tpbuf++) {
> -		import_uuid(&uuid, (u8 *)tpbuf->uuid);
> -
>  		/* Note that if the UUID will be uuid_null, that will require
>  		 * ffa_bus_notifier() to find the UUID of this partition id
>  		 * with help of ffa_device_match_uuid(). FF-A v1.1 and above
>  		 * provides UUID here for each partition as part of the
>  		 * discovery API and the same is passed.
>  		 */
> -		ffa_dev = ffa_device_register(&uuid, tpbuf->id, &ffa_drv_ops);
> -		if (!ffa_dev) {
> -			pr_err("%s: failed to register partition ID 0x%x\n",
> -			       __func__, tpbuf->id);
> +		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
> +		if (IS_ERR_OR_NULL(ffa_dev)) {
> +			pr_err("%s: failed to register partition ID 0x%x, error %ld\n",
> +			       __func__, tpbuf->id, PTR_ERR(ffa_dev));

Drop this additional error info you are adding as bus.c will provide it.

-- 
Regards,
Sudeep

