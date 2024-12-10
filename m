Return-Path: <linux-kernel+bounces-439691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED709EB2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF34284909
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6491AAA19;
	Tue, 10 Dec 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HR7sfkNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBF5674D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839575; cv=none; b=EplBTZurIyTdPbiU1WJQFk6xI2GjILT34nndItZVpcAQTRR1H+z+skXXea4z4zsdjTq6GihNNze/ZueZnv6I+EDiQXfaCdeHDhB9yboOx/0tE4WCSZ1NED0HSo0ms0pardK46TTBfiJe3c9KSMSGvk/zA3KYGrGB4mYyCPblbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839575; c=relaxed/simple;
	bh=TkrFdK9qsPKEqQbygGsHB9enAc9Qar8C5sqzyjuUiMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjyMS68ygGU2VeJdwCSiZw8YjV8Z2YhAmgfLfzghiFsu/TtZmTNzAu/te2QGWXOyvRlZE5zYJ5WCXP4tQwYE627z3IxcwlhxNSBHFVXCnwMvpXt7JzPz9xvG0HsPN2HQ2WeQvle4qku7fxxONHMDHAE3XuyqPl451hq3mIDXhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HR7sfkNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E71EC4CEE1;
	Tue, 10 Dec 2024 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733839575;
	bh=TkrFdK9qsPKEqQbygGsHB9enAc9Qar8C5sqzyjuUiMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HR7sfkNYVLvET4Kea+4lKWH3S59JZzwFB2tkWDAI8tkYLZmtDBpKqE6c/MQ1xImoP
	 IIv746caQAh0fK58o6C2EuZ3raxgiFQY1dB4d6Bp3DrgF/ChxDRWX3c0hl+Klvkd48
	 CY0sverRslZV2mUuPqMhSYTAHivSPWRjNL7csVN8=
Date: Tue, 10 Dec 2024 15:05:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: add device creation helper
Message-ID: <2024121048-latticed-etching-8961@gregkh>
References: <20241210-aux-device-create-helper-v1-1-5887f4d89308@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-aux-device-create-helper-v1-1-5887f4d89308@baylibre.com>

On Tue, Dec 10, 2024 at 02:43:12PM +0100, Jerome Brunet wrote:
> Add an function helper to create a device on the auxiliary bus.
> This should avoid having the same code repeated in the different drivers
> registering auxiliary devices.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> The suggestion for this change was initially discussed here: [1]
> 
> I was not sure if the managed variant should return the auxiliary device or
> just the error. This initial version returns the auxiliary device, allowing
> it to be further (ab)used. Please let me know if you prefer to just return
> the error code instead.
> 
> Also the non managed variant of the helper is not exported but it could
> easily be, if necessary.
> 
> [1]: https://lore.kernel.org/linux-clk/df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org
> ---
>  drivers/base/auxiliary.c      | 89 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/auxiliary_bus.h |  4 ++
>  2 files changed, 93 insertions(+)

We can't add new functions like this without a real user of it.  Please
submit that at the same time.

And are you ok with sharing the id range with multiple aux bus
implementations?


> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index afa4df4c5a3f371b91d8dd8c4325495d32ad1291..60ca3f0da329fb7f8e69ecdf703b505e7cf5085c 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -385,6 +385,95 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv)
>  }
>  EXPORT_SYMBOL_GPL(auxiliary_driver_unregister);
>  
> +static DEFINE_IDA(auxiliary_device_ida);
> +
> +static void auxiliary_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
> +
> +	ida_free(&auxiliary_device_ida, auxdev->id);
> +	kfree(auxdev);
> +}
> +
> +static struct auxiliary_device *auxiliary_device_create(struct device *dev,
> +							const char *name,
> +							void *platform_data)
> +{
> +	struct auxiliary_device *auxdev;
> +	int ret;
> +
> +	auxdev = kzalloc(sizeof(*auxdev), GFP_KERNEL);
> +	if (!auxdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = ida_alloc(&auxiliary_device_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		goto auxdev_free;
> +
> +	auxdev->id = ret;
> +	auxdev->name = name;
> +	auxdev->dev.parent = dev;
> +	auxdev->dev.platform_data = platform_data;
> +	auxdev->dev.release = auxiliary_device_release;
> +	device_set_of_node_from_dev(&auxdev->dev, dev);
> +
> +	ret = auxiliary_device_init(auxdev);
> +	if (ret)
> +		goto ida_free;
> +
> +	ret = __auxiliary_device_add(auxdev, dev->driver->name);
> +	if (ret) {
> +		auxiliary_device_uninit(auxdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return auxdev;
> +
> +ida_free:
> +	ida_free(&auxiliary_device_ida, auxdev->id);
> +auxdev_free:
> +	kfree(auxdev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void auxiliary_device_destroy(void *_auxdev)
> +{
> +	struct auxiliary_device *auxdev = _auxdev;
> +
> +	auxiliary_device_delete(auxdev);
> +	auxiliary_device_uninit(auxdev);
> +}
> +
> +/**
> + * devm_auxiliary_device_create - create a device on the auxiliary bus
> + * @dev: parent device
> + * @name: auxiliary bus driver name
> + * @platform_data: auxiliary bus device platform data
> + *
> + * Device managed helper to create an auxiliary bus device.
> + * The parent device KBUILD_MODNAME is automatically inserted before the

KBUILD_MODNAME doesn't make sense here, as that's the aux bus file.

thanks,

greg k-h

