Return-Path: <linux-kernel+bounces-373978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8679A6022
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2CAB291C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E31E3DDB;
	Mon, 21 Oct 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGBmgR2c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF31E3779;
	Mon, 21 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503173; cv=none; b=Sv1M7pXkIu2hpQAqCYOzPbVn76NR/2kF8lBpmsSeTrRWpD5O8xoMoZxOevgMoLuMixI7Fc0DzR3Q+mGj8jV0SBRkO9IqqW3BGfDbKCsIo5aYKQUVqer4Ilb9+woP0l5tzDhALLu7D3b4kUl4FBWZxL84zJZgAlVxZId8WEdg6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503173; c=relaxed/simple;
	bh=95fm0ioAH0F56m3GzykbVlsa5Kix+AkbST5VAFgN8Hg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EFpDXEbwZFlEg92oNd6xbIS5hFhx9B2FxD2hXDMcrxpvruQx9Q3OwxATpOCUGIvCcrNKT5mu+6O3Af0ggOavQWFBgDZ16aIuOtxVyrApGDfWkSBCCC5WHnDzluOJrcQNXz+17xwmYxjGZqQBgALXaOGF1A+xY8rhiralzq2hOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGBmgR2c; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729503172; x=1761039172;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=95fm0ioAH0F56m3GzykbVlsa5Kix+AkbST5VAFgN8Hg=;
  b=NGBmgR2cwX9CJGDvFYzTqGKnzwnVqS59YwEocF94WD1MfkQVErpCBhjz
   le1LgQ+zlMIQgPsKox5il3/7xodP7fi/bwGB2/C3x5vIl1atWKqA14Kks
   6lYOs+oW1gsXC5H4Q3vOlrteZ5NXCm3xnYKQIxvRIfeemGvIMbfC/Z2ys
   CdbpSyMjAAVC4ng2JzUngS8PS7etqnURHQ0M56QHDR2sOLergfGwBFhLb
   3fL8ZxSF6mZQKlAZuRfAERIacggByBriXlnV21xLkbsolGhm9EmFPBKTi
   j9TxmfQWX1FVmmF3VX/gKVEy0/BzuUm+AgF89symswXn2zgY3/D4f5stu
   A==;
X-CSE-ConnectionGUID: xvh0rzfDQyivTLjhnATWbA==
X-CSE-MsgGUID: F4I2oIp0T86nn5gXKTnbDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29096208"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29096208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:32:51 -0700
X-CSE-ConnectionGUID: WlU0b4CGTZCoHnGXPQUx+w==
X-CSE-MsgGUID: gVWQPkMWSxiLl/i7/9nDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79544903"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:32:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 12:32:45 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Andy Shevchenko <andy@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
In-Reply-To: <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com>
Message-ID: <28078013-a643-af8e-22be-f36c75790ba5@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com> <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Andy Shevchenko wrote:

> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver. The byproduct of this change is that the
> negative conditionals are swapped by positive ones that are being
> attached to the respective calls, hence the code uses the regular
> pattern, i.e. checking for the error first.
> 
> Tested-by: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 101 ++++++++++++---------------
>  1 file changed, 43 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 290b38627542..3a1584ed7db8 100644
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
> @@ -99,23 +100,21 @@ static struct class intel_scu_ipc_class = {
>   */
>  struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
>  {
> -	struct intel_scu_ipc_dev *scu = NULL;
> +	guard(mutex)(&ipclock);
>  
> -	mutex_lock(&ipclock);
>  	if (ipcdev) {
>  		get_device(&ipcdev->dev);
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
> @@ -289,12 +288,11 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
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
> @@ -319,13 +317,14 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  	}
>  
>  	err = intel_scu_ipc_check_status(scu);
> -	if (!err) { /* Read rbuf */
> -		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> -			wbuf[nc] = ipc_data_readl(scu, offset);
> -		memcpy(data, wbuf, count);
> -	}
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
> @@ -446,17 +445,15 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
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
> @@ -485,18 +482,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
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
> @@ -505,20 +501,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
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
> @@ -572,18 +565,15 @@ __intel_scu_ipc_register(struct device *parent,
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
> @@ -621,13 +611,11 @@ __intel_scu_ipc_register(struct device *parent,
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
> @@ -636,9 +624,6 @@ __intel_scu_ipc_register(struct device *parent,
>  	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
>  err_free:
>  	kfree(scu);
> -err_unlock:
> -	mutex_unlock(&ipclock);
> -
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
> @@ -652,12 +637,12 @@ EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
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

IMO, this change is doing too many things at once and it's hard to justify 
why those changes must be kept in the same patch. If the guard() change 
is done first and only then the logic reversions, both patches would 
probably be near trivial to review for correctness.

-- 
 i.


