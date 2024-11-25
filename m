Return-Path: <linux-kernel+bounces-420920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12819D8462
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716AA28958B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4A199924;
	Mon, 25 Nov 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pon3bZIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0079197512
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533975; cv=none; b=OswWX5Sppmv4Z3DK5Hm+NhDyLkFm21sQzkj5nfuhDEqaVll7cd79p5+3n2vLHfyxdLQG5SV2ToehS5FLHjj9Om+UMUCrdI1bUUpBrvyWHXugGsUNMLJpJ4VGe6JvH7yhLv9IRSit5AuP4Azb1fy6LxkqYQhwqUVylxJ6r6/nTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533975; c=relaxed/simple;
	bh=mC15klzQcokCCxgKTJeDarxfluP/3985Yy+3xGvs25g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HevpJbd8jY2HC76cZjcS+OsdY8bDDCnDVc53Jx4Rb+qt2Rq9OwALbJrTrY23GevyrFEksfpisLUqkfJAgnUcuQ0DdJI07yrp4kxRlnukpZO9J4kZGF3Z0jVqiG4VuhzCxIotajVzD4kELrJWVqO6QI1j0i8D/tHLNVgfH4BuXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pon3bZIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732533971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=513L1+BOoMWmJN1q29ao/RKzZ70eGNZSG1iZquPy5dg=;
	b=Pon3bZIsH3+TTfsOFXiBJWNP/37EIQMKuSaqmFyeLZ98jN2WyEoS4rB3KyhHfH7y7Lh1zv
	EQU+qXiwdDyxtyuWpGNyzMR2jSYhj1h5qu9DnDPXeN27zJqNi4Nsa13Xh96pMf0TDON6Na
	pqzmfjmi2gRAOA1BaKk/h2emf6Lx8zc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Z4cQXxkENfmbjaiodv_j6g-1; Mon, 25 Nov 2024 06:26:10 -0500
X-MC-Unique: Z4cQXxkENfmbjaiodv_j6g-1
X-Mimecast-MFC-AGG-ID: Z4cQXxkENfmbjaiodv_j6g
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa52bfbdfebso146848366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533969; x=1733138769;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=513L1+BOoMWmJN1q29ao/RKzZ70eGNZSG1iZquPy5dg=;
        b=cU6gVm/PeQPFrwsfdXHtp/ePojEz3tbTztbwjacVLJxzMzSnqkmCMdmPWt49ZNUQRb
         k/Q2qDvOXUsbgWEn0v+md+PyJ5dQwCnJ3QCHe0WpIPifNXVVVT3BKUoZ6+gfo7IoRTDM
         bv9DZHjhsd2qRQigRRjKq2ncJXUkG+YonBeOvNd2NxqooL5mDFtXd47Kb3NN4QwYLJOJ
         MSEgAebb5qqp9zXID8C7T1vYY4DLPrvnHAgEjWkWcDFu8UL16R6WCidWa35SLmSXYWx7
         b/MHlQqauduV1ZcENZNApxQqZ+QuJxPE2G6pZYnUZcX+lPho7kSm5MddR2d98EEZiucU
         6skQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc7ygcWVNlFJEtpJk3HXKDtbgMqib9SxzLGTVHn6oaVXS5kH9N+UQD8OzJh9UzaGyxrvza8ZjHRxCIkU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XuldZuWF/rLHapJj8lKWcIMHVmhvozwEHI8JqKrdGFMfb2b3
	GccSRZGAtJVADmIBYU4uXcl+i8L/u+Mrso9X1VyLxfmLauiGQJaD6p0fVIcp9gkW8uwxNE0w/BU
	4hIfqvWNgrHK/B1syTbCEWVBKoS5uzNfYghiSl6GkiN8sBY/f3xzvfgD7RDmb
X-Gm-Gg: ASbGncv72yLZLmzTf7/1ae/Zx8EtrW2YY6vK1i2ZOxiHPn0DRALD7xiMfgUnyYOQf9V
	qQWe6XBHCGsb9+AQXL5G73tDe6SHHJL3ZIMebLJgTOx7PXjXRnYDBPXBdctBGJBtgu69zTjs6eu
	8UyGo2M9QpSzAiHM4UQZRbopsiVzB87L8kddxztSoQWVfH2QwbC1eWPgKEzvZj0eQ8NOkC7T0qU
	hoL4Bvb3mHvQVh+i0ULC+rkLEh0zQ6TnKQGJ8V50ncWdMaEfvtJfFTbMu65WOrTxJygzrU0eXLm
	FYGjeds5ntnj2M1+X16PNAU=
X-Received: by 2002:a17:906:1daa:b0:aa5:3705:2dc with SMTP id a640c23a62f3a-aa537050336mr656787866b.45.1732533969284;
        Mon, 25 Nov 2024 03:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KVWytwqJaqlfZ/OsOilgWvcd2z8dW1rHBkghtPzJignqI2m0ld9PTGkCkVonEHJv0lw95Q==
X-Received: by 2002:a17:906:1daa:b0:aa5:3705:2dc with SMTP id a640c23a62f3a-aa537050336mr656785166b.45.1732533968841;
        Mon, 25 Nov 2024 03:26:08 -0800 (PST)
Received: from [192.168.1.12] (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa51ae7e5a3sm414383566b.160.2024.11.25.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 03:26:08 -0800 (PST)
Message-ID: <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
Date: Mon, 25 Nov 2024 12:26:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
To: Xu Yilun <yilun.xu@linux.intel.com>,
 Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: git@amd.com, mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
 trix@redhat.com, robh@kernel.org, saravanak@google.com,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-19 05:14, Xu Yilun wrote:
> On Tue, Oct 29, 2024 at 02:47:34PM +0530, Nava kishore Manne wrote:
>> Introduces an IOCTL interface within the fpga-region subsystem,
>> providing a generic and standardized mechanism for configuring (or)
>> reprogramming FPGAs during runtime. The newly added interface supports
>> both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
>> callbacks (e.g., configuration + enumeration, removal, and status) to
>> accommodate a wide range of device specific configurations.
>>
>> The IOCTL interface ensures compatibility with both OF and non-OF
>> devices, allowing for seamless FPGA reprogramming across diverse
>> platforms.
>>
>> Vendor-specific callbacks are integrated into the interface, enabling
>> custom FPGA configuration + enumeration, removal, and status reporting
>> mechanisms, ensuring flexibility for vendor implementations.
>>
>> This solution enhances FPGA runtime management, supporting various device
>> types and vendors, while ensuring compatibility with the current FPGA
>> configuration flow.
>>
>> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
>> ---
>> Changes for v2:
>>  - As discussed with Yilun, the implementation has been modified to utilize a
>>  callback approach, enabling seamless handling of both OF and non-OF devices.
>>
>>  - As suggested by Yilun in the POC code, we have moved away from using  void *args
>>  as a parameter for ICOTL inputs to obtain the required user inputs. Instead, we are
>>  utilizing the fpga_region_config_info structure to gather user inputs. Currently,
>>  this structure is implemented to support only OF devices, but we intend to extend
>>  it by incorporating new members to accommodate non-OF devices in the future.
>>
>>  drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
>>  drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
>>  include/linux/fpga/fpga-region.h |  32 +++++++++
>>  include/uapi/linux/fpga-region.h |  51 ++++++++++++++
>>  4 files changed, 283 insertions(+), 1 deletion(-)
>>  create mode 100644 include/uapi/linux/fpga-region.h
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index 753cd142503e..c6bea3c99a69 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/fpga/fpga-bridge.h>
>>  #include <linux/fpga/fpga-mgr.h>
>>  #include <linux/fpga/fpga-region.h>
>> +#include <linux/fpga-region.h>
>>  #include <linux/idr.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>> @@ -180,6 +181,67 @@ static struct attribute *fpga_region_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(fpga_region);
>>  
>> +static int fpga_region_device_open(struct inode *inode, struct file *file)
>> +{
>> +	struct miscdevice *miscdev = file->private_data;
>> +	struct fpga_region *region = container_of(miscdev, struct fpga_region, miscdev);
>> +
>> +	file->private_data = region;
>> +
>> +	return 0;
>> +}
>> +
>> +static int fpga_region_device_release(struct inode *inode, struct file *file)
>> +{
>> +	return 0;
>> +}
>> +
>> +static long fpga_region_device_ioctl(struct file *file, unsigned int cmd,
>> +				     unsigned long arg)
>> +{
>> +	int err;
>> +	void __user *argp = (void __user *)arg;
>> +	struct fpga_region_config_info config_info;
>> +	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
>> +
>> +	switch (cmd) {
>> +	case FPGA_REGION_IOCTL_LOAD:
>> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
>> +			return -EFAULT;
>> +
>> +		err = region->region_ops->region_config_enumeration(region, &config_info);
>> +
>> +		break;
>> +	case FPGA_REGION_IOCTL_REMOVE:
>> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
>> +			return -EFAULT;
>> +
>> +		err = region->region_ops->region_remove(region, &config_info);
>> +
>> +		break;
>> +	case FPGA_REGION_IOCTL_STATUS:
>> +		unsigned int status;
>> +
>> +		status = region->region_ops->region_status(region);
>> +
>> +		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>> +			err = -EFAULT;
>> +		break;
>> +	default:
>> +		err = -ENOTTY;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static const struct file_operations fpga_region_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= fpga_region_device_open,
>> +	.release	= fpga_region_device_release,
>> +	.unlocked_ioctl	= fpga_region_device_ioctl,
>> +	.compat_ioctl	= fpga_region_device_ioctl,
>> +};
>> +
>>  /**
>>   * __fpga_region_register_full - create and register an FPGA Region device
>>   * @parent: device parent
>> @@ -229,8 +291,21 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
>>  	if (ret)
>>  		goto err_remove;
>>  
>> +	if (info->region_ops) {
>> +		region->region_ops = info->region_ops;
>> +		region->miscdev.minor = MISC_DYNAMIC_MINOR;
>> +		region->miscdev.name = kobject_name(&region->dev.kobj);
>> +		region->miscdev.fops = &fpga_region_fops;
>> +		ret = misc_register(&region->miscdev);
>> +		if (ret) {
>> +			pr_err("fpga-region: failed to register misc device.\n");
>> +			goto err_remove;
>> +		}
>> +	}
>> +
>>  	ret = device_register(&region->dev);
>>  	if (ret) {
>> +		misc_deregister(&region->miscdev);
>>  		put_device(&region->dev);
>>  		return ERR_PTR(ret);
>>  	}
>> @@ -272,6 +347,40 @@ __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>  }
>>  EXPORT_SYMBOL_GPL(__fpga_region_register);
>>  
>> +/**
>> + * __fpga_region_register_with_ops - create and register an FPGA Region device
>> + * with user interface call-backs.
>> + * @parent: device parent
>> + * @mgr: manager that programs this region
>> + * @region_ops: ops for low level FPGA region for device enumeration/removal
>> + * @priv: of-fpga-region private data
>> + * @get_bridges: optional function to get bridges to a list
>> + * @owner: module containing the get_bridges function
>> + *
>> + * This simple version of the register function should be sufficient for most users.
>> + * The fpga_region_register_full() function is available for users that need to
>> + * pass additional, optional parameters.
>> + *
>> + * Return: struct fpga_region or ERR_PTR()
>> + */
>> +struct fpga_region *
>> +__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
>> +				const struct fpga_region_ops *region_ops,
>> +				void *priv,
>> +				int (*get_bridges)(struct fpga_region *),
>> +				struct module *owner)
>> +{
>> +	struct fpga_region_info info = { 0 };
>> +
>> +	info.mgr = mgr;
>> +	info.priv = priv;
>> +	info.get_bridges = get_bridges;
>> +	info.region_ops = region_ops;
>> +
>> +	return __fpga_region_register_full(parent, &info, owner);
>> +}
>> +EXPORT_SYMBOL_GPL(__fpga_region_register_with_ops);
>> +
>>  /**
>>   * fpga_region_unregister - unregister an FPGA region
>>   * @region: FPGA region
>> @@ -280,6 +389,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
>>   */
>>  void fpga_region_unregister(struct fpga_region *region)
>>  {
>> +	misc_deregister(&region->miscdev);
>>  	device_unregister(&region->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
>> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
>> index 8526a5a86f0c..63fe56e0466f 100644
>> --- a/drivers/fpga/of-fpga-region.c
>> +++ b/drivers/fpga/of-fpga-region.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/fpga/fpga-bridge.h>
>>  #include <linux/fpga/fpga-mgr.h>
>>  #include <linux/fpga/fpga-region.h>
>> +#include <linux/firmware.h>
>> +#include <linux/fpga-region.h>
>>  #include <linux/idr.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>> @@ -18,6 +20,20 @@
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>  
>> +/**
>> + * struct of_fpga_region_priv - Private data structure
>> + * image.
>> + * @dev:	Device data structure
>> + * @fw:		firmware of coeff table.
>> + * @path:	path of FPGA overlay image firmware file.
>> + * @ovcs_id:	overlay changeset id.
>> + */
>> +struct of_fpga_region_priv {
>> +	struct device *dev;
>> +	const struct firmware *fw;
>> +	int ovcs_id;
>> +};
>> +
>>  static const struct of_device_id fpga_region_of_match[] = {
>>  	{ .compatible = "fpga-region", },
>>  	{},
>> @@ -394,20 +410,93 @@ static struct notifier_block fpga_region_of_nb = {
>>  	.notifier_call = of_fpga_region_notify,
>>  };
>>  
>> +static int of_fpga_region_status(struct fpga_region *region)
>> +{
>> +	struct of_fpga_region_priv *ovcs = region->priv;
>> +
>> +	if (ovcs->ovcs_id)
>> +		return FPGA_REGION_HAS_PL;
> 
> Could you help specify what is PL?
> 
>> +
>> +	return FPGA_REGION_EMPTY;
>> +}
>> +
>> +static int of_fpga_region_config_enumeration(struct fpga_region *region,
>> +					     struct fpga_region_config_info *config_info)
>> +{
>> +	struct of_fpga_region_priv *ovcs = region->priv;
>> +	int err;
>> +
>> +	/* if it's set do not allow changes */
>> +	if (ovcs->ovcs_id)
>> +		return -EPERM;
>> +
>> +	err = request_firmware(&ovcs->fw, config_info->firmware_name, NULL);
>> +	if (err != 0)
>> +		goto out_err;
>> +
>> +	err = of_overlay_fdt_apply((void *)ovcs->fw->data, ovcs->fw->size,
>> +				   &ovcs->ovcs_id, NULL);
>> +	if (err < 0) {
>> +		pr_err("%s: Failed to create overlay (err=%d)\n",
>> +		       __func__, err);
>> +		release_firmware(ovcs->fw);
>> +		goto out_err;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	ovcs->ovcs_id = 0;
>> +	ovcs->fw = NULL;
>> +
>> +	return err;
>> +}
>> +
>> +static int of_fpga_region_config_remove(struct fpga_region *region,
>> +					struct fpga_region_config_info *config_info)
>> +{
>> +	struct of_fpga_region_priv *ovcs = region->priv;
>> +
>> +	if (!ovcs->ovcs_id)
>> +		return -EPERM;
>> +
>> +	of_overlay_remove(&ovcs->ovcs_id);
>> +	release_firmware(ovcs->fw);
>> +
>> +	ovcs->ovcs_id = 0;
>> +	ovcs->fw = NULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct fpga_region_ops region_ops = {
>> +	.region_status = of_fpga_region_status,
>> +	.region_config_enumeration = of_fpga_region_config_enumeration,
>> +	.region_remove = of_fpga_region_config_remove,
>> +};
>> +
>>  static int of_fpga_region_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>>  	struct device_node *np = dev->of_node;
>> +	struct of_fpga_region_priv *priv;
>>  	struct fpga_region *region;
>>  	struct fpga_manager *mgr;
>>  	int ret;
>>  
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev = dev;
>> +
>>  	/* Find the FPGA mgr specified by region or parent region. */
>>  	mgr = of_fpga_region_get_mgr(np);
>>  	if (IS_ERR(mgr))
>>  		return -EPROBE_DEFER;
>>  
>> -	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
>> +	region = fpga_region_register_with_ops(dev, mgr, &region_ops, priv,
>> +					       of_fpga_region_get_bridges);
>>  	if (IS_ERR(region)) {
>>  		ret = PTR_ERR(region);
>>  		goto eprobe_mgr_put;
>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index 5fbc05fe70a6..3a3ba6dbb5e1 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -6,15 +6,35 @@
>>  #include <linux/device.h>
>>  #include <linux/fpga/fpga-mgr.h>
>>  #include <linux/fpga/fpga-bridge.h>
>> +#include <linux/fpga-region.h>
>> +#include <linux/miscdevice.h>
>>  
>>  struct fpga_region;
>>  
>> +/**
>> + * struct fpga_region_ops - ops for low level FPGA region ops for device
>> + * enumeration/removal
>> + * @region_status: returns the FPGA region status
>> + * @region_config_enumeration: Configure and enumerate the FPGA region.
>> + * @region_remove: Remove all devices within the FPGA region
>> + * (which are added as part of the enumeration).
>> + */
>> +struct fpga_region_ops {
>> +	int (*region_status)(struct fpga_region *region);
>> +	int (*region_config_enumeration)(struct fpga_region *region,
>> +					 struct fpga_region_config_info *config_info);
> 
> My current concern is still about this combined API, it just offloads
> all work to low level, but we have some common flows. That's why we
> introduce a common FPGA reprograming API.
> 
> I didn't see issue about the vendor specific pre configuration. They
> are generally needed to initialize the struct fpga_image_info, which
> is a common structure for fpga_region_program_fpga().
> 
> For port IDs(AFU) inputs for DFL, I think it could also be changed
> (Don't have to be implemented in this patchset). Previously DFL
> provides an uAPI for the whole device, so it needs a port_id input to
> position which fpga_region within the device for programming. But now,
> we are introducing a per fpga_region programming interface, IIUC port_id
> should not be needed anymore.
> 
> The combined API is truly simple for leveraging the existing
> of-fpga-region overlay apply mechanism. But IMHO that flow doesn't fit
> our new uAPI well. That flow is to adapt the generic configfs overlay
> interface, which comes to a dead end as you mentioned.
> 
> My gut feeling for the generic programing flow should be:
> 
>  1. Program the image to HW.
>  2. Enumerate the programmed image (apply the DT overlay)
> 
> Why we have to:
> 
>  1. Start enumeration.
>  2. On pre enumeration, programe the image.
>  3. Real enumeration.

I'm currently working on an RFC to propose a rework of the fpga
subsystem in order to make it more aligned with the device model. One of
the ideas I'm experimenting with is having a bus (struct bus_type) for
fpga regions (devices) so that we can have region drivers that could
handle internal device enumeration/management whenever a new region is
configured on the fabric. Does this make sense in your opinions?

Concerning the reconfiguration, wouldn't it be cleaner to use a
per-region sysfs interface at fpga-region level? It would still work
for both OF & non-OF cases.

Thanks,
Marco



