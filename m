Return-Path: <linux-kernel+bounces-439776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768A9EB3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135EC188988A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812451AA7A3;
	Tue, 10 Dec 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR+nFoj5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E9B676;
	Tue, 10 Dec 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842065; cv=none; b=ES3yiejknB2q3KL3rHMQPeUezv9bZ7PS4X8CGp1aS8ZuJrAafKMjKv09sHV4622d7gL8sMTIaRYgCfM1bp+vRYFo1kQwcQjIBN/TvpxMWmNz0byptHpKWPX4ZcoUHNtAYBr6lt36u1PPLV7qAAWHEYkOTGQZG/DYcuz34Rr80I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842065; c=relaxed/simple;
	bh=OSbBVHFSnoLD3d/sFOchTp8lD3nMnqHhclQ+D0oRQ0M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YSPiMzBUNR+H4QXmOq8NBfxfbGXnn0d7bcWVliu1bMlKDKJMc/EqdB4cYkuo2bGaJPVgM6DJ5ovEHQ21ofFVqE/uPQvRDbB3LKjJsWecQjZnyR7/OaXu0fbiMAofECgnRUyUWC4SWUoWJfNWCQjHScZz6XjlVo6SiijvBU7M2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR+nFoj5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733842064; x=1765378064;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OSbBVHFSnoLD3d/sFOchTp8lD3nMnqHhclQ+D0oRQ0M=;
  b=AR+nFoj540ufqvCOFvyqXY07MpxUzgSZWoJYI0up4iDR/5slqLFP/9Dq
   /tuTm/pRuxU7jz7AiDCBcigp3jcdVBT+XBsLZzvHV2Ps0bekwAnudWlFX
   Czps6fH+IsXT40xbhq7Of66+sZm8thykyaczWZvL8eQFRKY2jGxqdZd/n
   2Ia/DvmK3Un4jc+KKTqV4yInjKASXT+OEGtZF9fAJA4B+7kxwodEFrJvi
   XX1sOJHCeiHsFZTZwZh07+RTrqr25Vs7YWLIG46IBvT9ud2Xb8yMLQEf/
   QDnukPCu9hJCia7mp3naPT0GkrPDYj2T7m4j3yDNSAtesN8NHorPudD+k
   g==;
X-CSE-ConnectionGUID: 6AEVInIuQF2Qr/vIoNWVXA==
X-CSE-MsgGUID: CsfMOzEQQh6dEgg/Pna/3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51599691"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="51599691"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:47:43 -0800
X-CSE-ConnectionGUID: jm+XQhz/SQOHoUbmyM6beQ==
X-CSE-MsgGUID: 5fZsAwrkRI+Lruldh+12xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100487086"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:47:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Dec 2024 16:47:38 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: wmi-bmof: Make use of .bin_size()
 callback
In-Reply-To: <20241206215650.2977-1-W_Armin@gmx.de>
Message-ID: <ad05e251-37bd-0cc2-8b11-a859e453f476@linux.intel.com>
References: <20241206215650.2977-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Dec 2024, Armin Wolf wrote:

> Until now the wmi-bmof driver had to allocate the binary sysfs
> attribute dynamically since its size depends on the bmof buffer
> returned by the firmware.
> 
> Use the new .bin_size() callback to avoid having to do this memory
> allocation.
> 
> Tested on a Asus Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi-bmof.c | 75 +++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
> index df6f0ae6e6c7..3e33da36da8a 100644
> --- a/drivers/platform/x86/wmi-bmof.c
> +++ b/drivers/platform/x86/wmi-bmof.c
> @@ -20,66 +20,66 @@
> 
>  #define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> 
> -struct bmof_priv {
> -	union acpi_object *bmofdata;
> -	struct bin_attribute bmof_bin_attr;
> -};
> -
> -static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
> +static ssize_t bmof_read(struct file *filp, struct kobject *kobj, const struct bin_attribute *attr,
>  			 char *buf, loff_t off, size_t count)
>  {
> -	struct bmof_priv *priv = container_of(attr, struct bmof_priv, bmof_bin_attr);
> +	struct device *dev = kobj_to_dev(kobj);
> +	union acpi_object *obj = dev_get_drvdata(dev);
> 
> -	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffer.pointer,
> -				       priv->bmofdata->buffer.length);
> +	return memory_read_from_buffer(buf, count, &off, obj->buffer.pointer, obj->buffer.length);
>  }
> 
> -static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
> +static const BIN_ATTR_ADMIN_RO(bmof, 0);
> +
> +static const struct bin_attribute * const bmof_attrs[] = {
> +	&bin_attr_bmof,
> +	NULL
> +};
> +
> +static size_t bmof_bin_size(struct kobject *kobj, const struct bin_attribute *attr, int n)
>  {
> -	struct bmof_priv *priv;
> -	int ret;
> +	struct device *dev = kobj_to_dev(kobj);
> +	union acpi_object *obj = dev_get_drvdata(dev);
> +
> +	return obj->buffer.length;
> +}
> 
> -	priv = devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +static const struct attribute_group bmof_group = {
> +	.bin_size = bmof_bin_size,
> +	.bin_attrs_new = bmof_attrs,
> +};
> +
> +static const struct attribute_group *bmof_groups[] = {
> +	&bmof_group,
> +	NULL
> +};
> 
> -	dev_set_drvdata(&wdev->dev, priv);
> +static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
> +{
> +	union acpi_object *obj;
> 
> -	priv->bmofdata = wmidev_block_query(wdev, 0);
> -	if (!priv->bmofdata) {
> +	obj = wmidev_block_query(wdev, 0);
> +	if (!obj) {
>  		dev_err(&wdev->dev, "failed to read Binary MOF\n");
>  		return -EIO;
>  	}
> 
> -	if (priv->bmofdata->type != ACPI_TYPE_BUFFER) {
> +	if (obj->type != ACPI_TYPE_BUFFER) {
>  		dev_err(&wdev->dev, "Binary MOF is not a buffer\n");
> -		ret = -EIO;
> -		goto err_free;
> +		kfree(obj);
> +		return -EIO;
>  	}
> 
> -	sysfs_bin_attr_init(&priv->bmof_bin_attr);
> -	priv->bmof_bin_attr.attr.name = "bmof";
> -	priv->bmof_bin_attr.attr.mode = 0400;
> -	priv->bmof_bin_attr.read = read_bmof;
> -	priv->bmof_bin_attr.size = priv->bmofdata->buffer.length;
> -
> -	ret = device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
> -	if (ret)
> -		goto err_free;
> +	dev_set_drvdata(&wdev->dev, obj);
> 
>  	return 0;
> -
> - err_free:
> -	kfree(priv->bmofdata);
> -	return ret;
>  }
> 
>  static void wmi_bmof_remove(struct wmi_device *wdev)
>  {
> -	struct bmof_priv *priv = dev_get_drvdata(&wdev->dev);
> +	union acpi_object *obj = dev_get_drvdata(&wdev->dev);
> 
> -	device_remove_bin_file(&wdev->dev, &priv->bmof_bin_attr);
> -	kfree(priv->bmofdata);
> +	kfree(obj);
>  }
> 
>  static const struct wmi_device_id wmi_bmof_id_table[] = {
> @@ -90,6 +90,7 @@ static const struct wmi_device_id wmi_bmof_id_table[] = {
>  static struct wmi_driver wmi_bmof_driver = {
>  	.driver = {
>  		.name = "wmi-bmof",
> +		.dev_groups = bmof_groups,
>  	},
>  	.probe = wmi_bmof_probe,
>  	.remove = wmi_bmof_remove,

So do I understand right that this meant to supercede the patch from 
Thomas?

-- 
 i.


