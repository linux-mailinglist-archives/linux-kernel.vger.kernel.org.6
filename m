Return-Path: <linux-kernel+bounces-378781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3809AD56B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04411F256E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD61A08C1;
	Wed, 23 Oct 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUdx9ZTi"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BC154BE0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714633; cv=none; b=YLofvtU8lZOjI50TcqAiZlMGkW8CezWoLv8yyKxl+WgBA17wchg7frEWpdMQBaj+SFqHNt1EtJQ1WYh6jtNRHmevU9i5lflNnU3k8pHcla+2yLAruKxQpiRGFbF9GvN8qbkZyBVzqtiKJHFNwPyiNP+w/WDnLmn9zOCFioOOnAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714633; c=relaxed/simple;
	bh=HH4dVD4hK3WNz0Zgs1s/rEgK+idb7phMVaRYQz1mbws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlyIR1Kud2PkvNEouUgEahZKNu203r41bCMl8i+VPhPrWnJ8eIYdZX8ZP6myxyNNbY4goHQhr2jTWwdCahofr4q4K0oBVP++49/klCmHffT8PtXZadjpcr9UdXbj59D9QmQXxc6lVoE1q3li9jvZ/zPdFB54iRwHkEIkT5PhZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUdx9ZTi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 13:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729714627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DW8fBnaGue+kAzhhKRPZJybgD/BGzJQqpRCS6FFqXbE=;
	b=oUdx9ZTikg6PibyDydnkBtn3pKf+5m0hEslGA+xh7m3YR1JWIq4KNGzJWqMuWo843zHDxE
	hjEwD0wYPGTxLyParMrBFSvU8zJRvUU7Ji5LmdyLd/1xHejuTzgrpsUu6NdC6pX3zO+vRL
	J1x7bQ/qheVZeecgKZ9NSi+NYVmfnQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Dionna Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, Ashish.Kalra@amd.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <20241023201654.pjz67e5cv7kbki5t@4VRSMR2-DT.corp.robot.car>
References: <20241015201424.2914652-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015201424.2914652-1-dionnaglaze@google.com>
X-Migadu-Flow: FLOW_OUT


On Tue, Oct 15, 2024 at 08:14:24PM +0000, Dionna Glaze wrote:
> If a kernel module registers a firmware upload API ops set, then it's
> unable to be moved due to effectively a cyclic reference that the module
> depends on the upload which depends on the module.
> 
> Instead, only require the try_module_get when an upload is requested to
> disallow unloading a module only while the upload is in progress.

Generally, the parent driver that registers for firmware_upload would
want the module to be present until it unregisters.

Is there a case where this change is needed?

> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> CC: Danilo Krummrich <dakr@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 28 ++++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 829270067d16..97b0ae855b5f 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -103,6 +103,10 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>  	if (fwlp->progress == FW_UPLOAD_PROG_IDLE)
>  		ret = -ENODEV;
>  
> +	/*
> +	 * Not idle, so fw_upload_start already called try_module_get.
> +	 * No need to get/put around cancel.
> +	 */

This comment isn't necessary. Cancel is intended to signal the
parent driver to abort the upload by returning an error condition
from other ops in progress. It shouldn't attempt to unload the
module.

>  	fwlp->ops->cancel(fwlp->fw_upload);
>  	mutex_unlock(&fwlp->lock);
>  
> @@ -164,11 +168,13 @@ static void fw_upload_main(struct work_struct *work)
>  	enum fw_upload_err ret;
>  	struct device *fw_dev;
>  	struct fw_upload *fwl;
> +	struct module *module;
>  
>  	fwlp = container_of(work, struct fw_upload_priv, work);
>  	fwl = fwlp->fw_upload;
>  	fw_sysfs = (struct fw_sysfs *)fwl->priv;
>  	fw_dev = &fw_sysfs->dev;
> +	module = fwlp->module;
>  
>  	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PREPARING);
>  	ret = fwlp->ops->prepare(fwl, fwlp->data, fwlp->remaining_size);
> @@ -204,6 +210,7 @@ static void fw_upload_main(struct work_struct *work)
>  		fwlp->ops->cleanup(fwl);
>  
>  putdev_exit:
> +	module_put(module);

Skip the local variable: module_put(fwlp->module)

>  	put_device(fw_dev->parent);
>  
>  	/*
> @@ -238,7 +245,11 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
>  		return 0;
>  	}
>  
> +
>  	fwlp = fw_sysfs->fw_upload_priv;
> +	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */

Isn't it too late to ensure that the module is present? The
fw_upload_start() function itself resides within the
syfs_upload module. If the module isn't present, then this function
cannot be called. try_module_get() would need to be called before
the call to fw_upload_start().

> +		return -EFAULT;
> +
>  	mutex_lock(&fwlp->lock);
>  
>  	/* Do not interfere with an on-going fw_upload */
> @@ -310,13 +321,10 @@ firmware_upload_register(struct module *module, struct device *parent,
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
> @@ -358,7 +366,7 @@ firmware_upload_register(struct module *module, struct device *parent,
>  	if (ret) {
>  		dev_err(fw_dev, "%s: device_register failed\n", __func__);
>  		put_device(fw_dev);
> -		goto exit_module_put;
> +		goto exit_err;
>  	}
>  
>  	return fw_upload;
> @@ -372,8 +380,7 @@ firmware_upload_register(struct module *module, struct device *parent,
>  free_fw_upload:
>  	kfree(fw_upload);
>  
> -exit_module_put:
> -	module_put(module);
> +exit_err:
>  
>  	return ERR_PTR(ret);
>  }
> @@ -387,7 +394,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>  {
>  	struct fw_sysfs *fw_sysfs = fw_upload->priv;
>  	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
> -	struct module *module = fw_upload_priv->module;
>  
>  	mutex_lock(&fw_upload_priv->lock);
>  	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
> @@ -395,6 +401,11 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>  		goto unregister;
>  	}
>  
> +	/*
> +	 * No need to try_module_get/module_put around the op since only the
> +	 * module itself will call unregister, usually when the refcount has
> +	 * dropped to zero and it's cleaning up dependencies to destroy itself.
> +	 */

This comment is unnecessary.

Thanks,
- Russ

>  	fw_upload_priv->ops->cancel(fw_upload);
>  	mutex_unlock(&fw_upload_priv->lock);
>  
> @@ -403,6 +414,5 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
>  
>  unregister:
>  	device_unregister(&fw_sysfs->dev);
> -	module_put(module);
>  }
>  EXPORT_SYMBOL_GPL(firmware_upload_unregister);
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

