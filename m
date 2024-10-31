Return-Path: <linux-kernel+bounces-390861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79C9B7F57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AA8282C51
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892C1A7AD0;
	Thu, 31 Oct 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJqudrfX"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E81A76D1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390015; cv=none; b=X8vNbSQn5aYRNErK2xoLVIGZLkDsWoOCgc5wFNCkWwmWN7jUKnTbJNnk0Ycus7DiFQw5pCJ073aoPLj7LgwAIZehgvCHB3Erd47Nb11iynu6vdYTDTvmou85Uy95q/qdEjHjuiolwYFVnV2jzp/+wssnMsD45ifqBi6x4mysMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390015; c=relaxed/simple;
	bh=5pWCyAp6XX6zz4zC7lrJhyP29AmdnACjWmJAJQt3rJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT3BCmnCE0IYK2RWuY3gSYlsIQCFnOwSG98L+Izac2dIhR1nqrl9ceAuFnaCGH9xOpeZNeWAlB3p78/3S22jzodyIlEJpIIk/dCue7rhKGT83g7hW+w7TMgQD1XMDbxb0+jFz0el+y/4wakEHHXom8XbomqiR/I5f5VrcKOC2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJqudrfX; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 08:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730390010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItGokfUZTnEIFpJzaJBforGXAk3jCxreC14pNmoYyn4=;
	b=cJqudrfXMKV+nMnZgGa5WojPKJzj/Nw7TI6DGvtOQeHWcoMKHQ67vEaSjaQSQfmPfp9ifr
	/wi71I+/ZHhFsIVkptfgDFgYGMSWEzX5Ct2digMpGgPzxCAvnZuWRMagXlnCrC9riDBqk3
	pgnJj7F+ddvRcVWOsgGR2WbmaOMDnQk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Dionna Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/4] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <20241031155319.igs673g2s5ddmkpl@4VRSMR2-DT.corp.robot.car>
References: <20241029183907.3536683-1-dionnaglaze@google.com>
 <20241029183907.3536683-3-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029183907.3536683-3-dionnaglaze@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 29, 2024 at 06:39:02PM +0000, Dionna Glaze wrote:
> If a kernel module registers a firmware upload API ops set, then it's
> unable to be moved due to effectively a cyclic reference that the module
> depends on the upload which depends on the module.
> 
> Instead, only require the try_module_get when an upload is requested to
> disallow unloading a module only while the upload is in progress.
> 
> Fixes: 97730bbb242cd ("firmware_loader: Add firmware-upload support")
> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> CC: Danilo Krummrich <dakr@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Tianfei zhang <tianfei.zhang@intel.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Change-Id: Ifac9513de2f58a5120d4c0a681e969cd71cd3c68
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 28 ++++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 829270067d163..97b0ae855b5f0 100644
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

I'm not sure why you think this comment is needed. I think it can
be removed


>  	fwlp->ops->cancel(fwlp->fw_upload);
>  	mutex_unlock(&fwlp->lock);
>  
> @@ -164,11 +168,13 @@ static void fw_upload_main(struct work_struct *work)
>  	enum fw_upload_err ret;
>  	struct device *fw_dev;
>  	struct fw_upload *fwl;
> +	struct module *module;

No need for a local variable here - module is only accessed once,
so just reference it as fwlp->module.

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
>  	put_device(fw_dev->parent);
>  
>  	/*
> @@ -238,7 +245,11 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
>  		return 0;
>  	}
>  
> +
Remove the extra blank line above.

>  	fwlp = fw_sysfs->fw_upload_priv;
> +	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */
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

This comment is not needed.

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
> 2.47.0.163.g1226f6d8fa-goog
> 

