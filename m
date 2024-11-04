Return-Path: <linux-kernel+bounces-395295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266179BBBD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCCA282172
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26D1C4A27;
	Mon,  4 Nov 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvZBfCpr"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C11CD15
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740974; cv=none; b=iUB7t7ZZpaQr6JgmRyR6CBJ0YWpHBTxwTHRjCerwqPjq9gXLFdyUAGBmBjXLqkTfEwWGNW1WcU6tUzubon7r9Fq160W7MuUcIZ9CXaPuIqf8wEn/BXSjvBxGW/mSAScdNIsHsZ2VkTWIdsmNTb7zBLNC/ReHpG719Yq+mmiVrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740974; c=relaxed/simple;
	bh=Gfo5O/hkO5WeEo3sSGHAAx4siLFoKSZSwF3Y2eSfynU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhdB/aTip897SAOpaIqDOS63ujJaMgiU7Yl8v2I4JGkiqd5STf3Gxf0l/V9Ee0YmALwP5CoPgnl0SqBxPzuQAH+1dFxNwL2CoBA/NfBh38WxF8ihRYzIA7PGLg94so0yPRc8N4VOLjRCSBX+KTPkNDnT5/heXFwNIxQE4RJ/hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pvZBfCpr; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 09:22:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730740969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3wxUuDOVSIoY/BkE2V5T71bvB6+CrYMcZO4kyw5Jg8=;
	b=pvZBfCprI5gX516necTP57cWzU1x8+NBkGeyap3VvevulahNoM6/mi79tvq1o3ALhlec+j
	hfSp+CR+JVP6AtPo7BM/oSsJ7mt/54PXsWMxKjHIKFvcEOOUlbUhxvyFopx75lZ5U3V6sQ
	HESNkiSWwOt1/hrYOWEnWwedgCr7h4k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Dionna Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Michael Roth <michael.roth@amd.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <20241104172231.mp3kjegezjgtmft5@4VRSMR2-DT.corp.robot.car>
References: <20241101181533.1976040-1-dionnaglaze@google.com>
 <20241101181533.1976040-3-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101181533.1976040-3-dionnaglaze@google.com>
X-Migadu-Flow: FLOW_OUT


On Fri, Nov 01, 2024 at 06:15:27PM +0000, Dionna Glaze wrote:
> If a kernel module registers a firmware upload API ops set, then it's
> unable to be moved due to effectively a cyclic reference that the module
> depends on the upload which depends on the module.
> 
> Instead, only require the try_module_get when an upload is requested to
> disallow unloading a module only while the upload is in progress.
> 
> Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
> 
> CC: Sean Christopherson <seanjc@google.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: Ashish Kalra <ashish.kalra@amd.com>
> CC: Tom Lendacky <thomas.lendacky@amd.com>
> CC: John Allen <john.allen@amd.com>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Michael Roth <michael.roth@amd.com>
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> CC: Danilo Krummrich <dakr@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Tianfei zhang <tianfei.zhang@intel.com>
> 
> Tested-by: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 829270067d163..7d9c6aef7720a 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -204,6 +204,7 @@ static void fw_upload_main(struct work_struct *work)
>  		fwlp->ops->cleanup(fwl);
>  
>  putdev_exit:
> +	module_put(fwlp->module);
>  	put_device(fw_dev->parent);
>  
>  	/*
> @@ -239,6 +240,9 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
>  	}
>  
>  	fwlp = fw_sysfs->fw_upload_priv;
> +	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */
> +		return -EFAULT;
> +
>  	mutex_lock(&fwlp->lock);
>  
>  	/* Do not interfere with an on-going fw_upload */
> @@ -310,13 +314,10 @@ firmware_upload_register(struct module *module, struct device *parent,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (!try_module_get(module))
> -		return ERR_PTR(-EFAULT);
> -
>  	fw_upload = kzalloc(sizeof(*fw_upload), GFP_KERNEL);
>  	if (!fw_upload) {
>  		ret = -ENOMEM;
> -		goto exit_module_put;
> +		goto exit_err;
>  	}
>  
>  	fw_upload_priv = kzalloc(sizeof(*fw_upload_priv), GFP_KERNEL);
> @@ -358,7 +359,7 @@ firmware_upload_register(struct module *module, struct device *parent,
>  	if (ret) {
>  		dev_err(fw_dev, "%s: device_register failed\n", __func__);
>  		put_device(fw_dev);
> -		goto exit_module_put;
> +		goto exit_err;
>  	}
>  
>  	return fw_upload;
> @@ -372,8 +373,7 @@ firmware_upload_register(struct module *module, struct device *parent,
>  free_fw_upload:
>  	kfree(fw_upload);
>  
> -exit_module_put:
> -	module_put(module);
> +exit_err:
>  
>  	return ERR_PTR(ret);
>  }
> @@ -387,7 +387,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>  {
>  	struct fw_sysfs *fw_sysfs = fw_upload->priv;
>  	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
> -	struct module *module = fw_upload_priv->module;
>  
>  	mutex_lock(&fw_upload_priv->lock);
>  	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
> @@ -403,6 +402,5 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>  
>  unregister:
>  	device_unregister(&fw_sysfs->dev);
> -	module_put(module);
>  }
>  EXPORT_SYMBOL_GPL(firmware_upload_unregister);
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

