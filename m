Return-Path: <linux-kernel+bounces-373746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6365C9A5C02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3011C2153D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B01D0F52;
	Mon, 21 Oct 2024 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3IEq7g5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED51D0E3B;
	Mon, 21 Oct 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494011; cv=none; b=eqg90rDWyQeuvMY3mi6sMgsXFzC02+j34C1Dd3fDD3RFUX9V1LblS6rLCzIpTxDiB5+5oA49PqPZZ2fVt1Nyk4ovTLdAgR9fycSW4B/W2024gaXg1t8yBueI6Wi8ieTKAtxCHgY4XXToBTpSAa2QoZe15ZWPtXBnAEwrg41MljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494011; c=relaxed/simple;
	bh=uZiC1BvATmqQezpBAZ1SGsO/gzmmBPKTJ3tla1IXToc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exeQiKnOp0GvoKwZZ6RAAV5crrkTkvvE0AT8Np4cZz/S/5GYb7c5dJ984XOdraK1tJ8ifKVW86+dLY94xuPUzlLzTqekXDVHm9TM1WAfKJrzqXWrDmo9TRSnGvDTIZB7lpz2LngeFBK5MyeHDb7YC/3PukyNvMHMa4/VHeMX0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3IEq7g5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729494010; x=1761030010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZiC1BvATmqQezpBAZ1SGsO/gzmmBPKTJ3tla1IXToc=;
  b=X3IEq7g5xfKjk2JXCJmHTJRQybtRly9sgMqhJh0lyZvN70uHBtvn+ZsL
   JzQdmwGEI2IzUQjg6YMaOn2A3G9eOVoe73+2InGdyouYOHH3AbHQzLbte
   cksi2CR8ouypl55ZrNZ2AyLiRH2uxSU+++k2qDQK5MyPkJqrCeeEPO9J7
   ZaPrQMXycd+LNVckaOy8xsj3WzUlLSUDMkWhXi6Yy+vpCpQ3jWFTZ7sUl
   1ybLZiwALLb0wo69j3C3WmVKdWeqOzdV5fUusmMpP1qw9+dT5bpcJ/xu/
   ximCXrHKgNHvA2lMarkT/X4yx9jtQHQNRjpzE5HsOVh7iiMcvNRvQsSyD
   w==;
X-CSE-ConnectionGUID: okWU2jmCR8KTf5VEcoloDg==
X-CSE-MsgGUID: s8GsETKzQQyEVoS4rSOA5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29082046"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29082046"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:00:09 -0700
X-CSE-ConnectionGUID: QUtKDTlTSOeMftKFZPwaXw==
X-CSE-MsgGUID: mmzkR5jKRMK2mrvukQ9WIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79397480"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Oct 2024 00:00:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 857E612B; Mon, 21 Oct 2024 10:00:05 +0300 (EEST)
Date: Mon, 21 Oct 2024 10:00:05 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
Message-ID: <20241021070005.GW275077@black.fi.intel.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
 <20241016115033.858574-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016115033.858574-3-andriy.shevchenko@linux.intel.com>

On Wed, Oct 16, 2024 at 02:48:25PM +0300, Andy Shevchenko wrote:
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 102 ++++++++++++---------------
>  1 file changed, 44 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 290b38627542..ffb0a2524388 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -13,6 +13,7 @@
>   * along with other APIs.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> @@ -99,23 +100,22 @@ static struct class intel_scu_ipc_class = {
>   */
>  struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
>  {
> -	struct intel_scu_ipc_dev *scu = NULL;
> +	guard(mutex)(&ipclock);
>  
> -	mutex_lock(&ipclock);
>  	if (ipcdev) {
>  		get_device(&ipcdev->dev);
> +

unintended whitespace change?

>  		/*
>  		 * Prevent the IPC provider from being unloaded while it
>  		 * is being used.
>  		 */
> -		if (!try_module_get(ipcdev->owner))
> -			put_device(&ipcdev->dev);
> -		else
> -			scu = ipcdev;
> +		if (try_module_get(ipcdev->owner))
> +			return ipcdev;
> +
> +		put_device(&ipcdev->dev);
>  	}
>  
> -	mutex_unlock(&ipclock);
> -	return scu;
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_get);
>  
> @@ -289,12 +289,11 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  
>  	memset(cbuf, 0, sizeof(cbuf));
>  
> -	mutex_lock(&ipclock);
> +	guard(mutex)(&ipclock);
> +
>  	scu = intel_scu_ipc_get(scu);
> -	if (IS_ERR(scu)) {
> -		mutex_unlock(&ipclock);
> +	if (IS_ERR(scu))
>  		return PTR_ERR(scu);
> -	}
>  
>  	for (nc = 0; nc < count; nc++, offset += 2) {
>  		cbuf[offset] = addr[nc];
> @@ -319,13 +318,14 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  	}
>  
>  	err = intel_scu_ipc_check_status(scu);
> -	if (!err) { /* Read rbuf */
> -		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> -			wbuf[nc] = ipc_data_readl(scu, offset);
> -		memcpy(data, wbuf, count);
> -	}

Here you changed also the check to be for if (err) instead of (!err) so
at least mention why you did these at the same time you did the cleanup
change. It is fine by me but good to mention in the commit message.

> -	mutex_unlock(&ipclock);
> -	return err;
> +	if (err)
> +		return err;
> +
> +	for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> +		wbuf[nc] = ipc_data_readl(scu, offset);
> +	memcpy(data, wbuf, count);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -446,17 +446,15 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
>  	u32 cmdval;
>  	int err;
>  
> -	mutex_lock(&ipclock);
> +	guard(mutex)(&ipclock);
> +
>  	scu = intel_scu_ipc_get(scu);
> -	if (IS_ERR(scu)) {
> -		mutex_unlock(&ipclock);
> +	if (IS_ERR(scu))
>  		return PTR_ERR(scu);
> -	}
>  
>  	cmdval = sub << 12 | cmd;
>  	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
> -	mutex_unlock(&ipclock);
>  	if (err)
>  		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
>  	return err;
> @@ -485,18 +483,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
>  {
>  	size_t outbuflen = DIV_ROUND_UP(outlen, sizeof(u32));
>  	size_t inbuflen = DIV_ROUND_UP(inlen, sizeof(u32));
> -	u32 cmdval, inbuf[4] = {};
> +	u32 cmdval, inbuf[4] = {}, outbuf[4] = {};
>  	int i, err;
>  
>  	if (inbuflen > 4 || outbuflen > 4)
>  		return -EINVAL;
>  
> -	mutex_lock(&ipclock);
> +	guard(mutex)(&ipclock);
> +
>  	scu = intel_scu_ipc_get(scu);
> -	if (IS_ERR(scu)) {
> -		mutex_unlock(&ipclock);
> +	if (IS_ERR(scu))
>  		return PTR_ERR(scu);
> -	}
>  
>  	memcpy(inbuf, in, inlen);
>  	for (i = 0; i < inbuflen; i++)
> @@ -505,20 +502,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
>  	cmdval = (size << 16) | (sub << 12) | cmd;
>  	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
> -
> -	if (!err) {
> -		u32 outbuf[4] = {};
> -
> -		for (i = 0; i < outbuflen; i++)
> -			outbuf[i] = ipc_data_readl(scu, 4 * i);
> -
> -		memcpy(out, outbuf, outlen);

Same here.

> +	if (err) {
> +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
> +		return err;
>  	}
>  
> -	mutex_unlock(&ipclock);
> -	if (err)
> -		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
> -	return err;
> +	for (i = 0; i < outbuflen; i++)
> +		outbuf[i] = ipc_data_readl(scu, 4 * i);
> +
> +	memcpy(out, outbuf, outlen);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(intel_scu_ipc_dev_command_with_size);
>  
> @@ -572,18 +566,15 @@ __intel_scu_ipc_register(struct device *parent,
>  	struct intel_scu_ipc_dev *scu;
>  	void __iomem *ipc_base;
>  
> -	mutex_lock(&ipclock);
> +	guard(mutex)(&ipclock);
> +
>  	/* We support only one IPC */
> -	if (ipcdev) {
> -		err = -EBUSY;
> -		goto err_unlock;
> -	}
> +	if (ipcdev)
> +		return ERR_PTR(-EBUSY);
>  
>  	scu = kzalloc(sizeof(*scu), GFP_KERNEL);
> -	if (!scu) {
> -		err = -ENOMEM;
> -		goto err_unlock;
> -	}
> +	if (!scu)
> +		return ERR_PTR(-ENOMEM);
>  
>  	scu->owner = owner;
>  	scu->dev.parent = parent;
> @@ -621,13 +612,11 @@ __intel_scu_ipc_register(struct device *parent,
>  	err = device_register(&scu->dev);
>  	if (err) {
>  		put_device(&scu->dev);
> -		goto err_unlock;
> +		return ERR_PTR(err);
>  	}
>  
>  	/* Assign device at last */
>  	ipcdev = scu;
> -	mutex_unlock(&ipclock);
> -
>  	return scu;
>  
>  err_unmap:
> @@ -636,9 +625,6 @@ __intel_scu_ipc_register(struct device *parent,
>  	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
>  err_free:
>  	kfree(scu);
> -err_unlock:
> -	mutex_unlock(&ipclock);
> -
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
> @@ -652,12 +638,12 @@ EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
>   */
>  void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu)
>  {
> -	mutex_lock(&ipclock);
> +	guard(mutex)(&ipclock);
> +
>  	if (!WARN_ON(!ipcdev)) {
>  		ipcdev = NULL;
>  		device_unregister(&scu->dev);
>  	}
> -	mutex_unlock(&ipclock);
>  }
>  EXPORT_SYMBOL_GPL(intel_scu_ipc_unregister);
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac

