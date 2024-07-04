Return-Path: <linux-kernel+bounces-240996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B692757A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0F1F23208
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA61AD9D0;
	Thu,  4 Jul 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSn9hP53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFB1AD9C0;
	Thu,  4 Jul 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093847; cv=none; b=apBMSNdHvccUXAfUS62cHJ88trytC1ywQDzxB83GZxNfgA/r1e1oeKW7jeL0rFSsE6yKIqubv0xHLJ8TRg0BVxcbgBV/0rzGgfLexVF1r4hIO8E9ZrtGruoysBpEy0YiOjWfx1zSteNPwGl/Ob2BcvL4PxWrH9rzucDjlux86qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093847; c=relaxed/simple;
	bh=r32OYyafeioYlL/gWWhzHmJjQ3BGcDLQ9nYLWcuZLM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlSNqUmFfeGp81pKAt6mfon892ezCKc1p2bjwCoTLi1PWKiUcYao9wLvC5o4Cb+/So4ByjBMmhBlB8ZB6cI0+wMBkRxgcwXv7UBUcErAJm1mIyfg//Vr//o03b+PVrQo5sUvjyiM1l1ZOb9feI8AlA/4z1MAsBBBi74cAOz8u54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSn9hP53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BEEC3277B;
	Thu,  4 Jul 2024 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720093846;
	bh=r32OYyafeioYlL/gWWhzHmJjQ3BGcDLQ9nYLWcuZLM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSn9hP53yxT2sMm3nTyHnW19q20XewBwbtlnHWYJCCbDLnWG4EA41M38M+Hz39jqe
	 xH1kM1Zg3uwTxJogL2MqJxxCr5ZzJLw8gi0dtKtvo9aWmzLF+BkkdIZj0zW9SjvBnk
	 94+gMj0UeeExbL7udPSdHWYAMyDdEo6wM0M6yzPE=
Date: Thu, 4 Jul 2024 13:50:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 2/6] misc: sbrmi: Add platform device add to create
 platform device
Message-ID: <2024070447-cosigner-shanty-fbbd@gregkh>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-3-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111624.1583460-3-akshay.gupta@amd.com>

On Thu, Jul 04, 2024 at 11:16:20AM +0000, Akshay Gupta wrote:
> - AMD provides socket power information from out of band
>   which can be read by sensors.
> - platform driver will probe drivers/hwmon/sbrmi as a platform device
>   and share the sbrmi device data.

So you are "splitting" a real device into different ones using a
platform device?  THat's not ok, and an abuse of the platform api.
Please use the correct one for that instead.


> 
> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> ---
>  drivers/misc/amd-sb/sbrmi-i2c.c | 25 ++++++++++++++++++++++++-
>  include/misc/amd-sb.h           |  2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
> index c4903d9e9f0f..b593bbdd78e0 100644
> --- a/drivers/misc/amd-sb/sbrmi-i2c.c
> +++ b/drivers/misc/amd-sb/sbrmi-i2c.c
> @@ -72,7 +72,29 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
>  		return ret;
>  
>  	/* Cache maximum power limit */
> -	return sbrmi_get_max_pwr_limit(data);
> +	ret = sbrmi_get_max_pwr_limit(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_set_drvdata(dev, (void *)data);

No need to cast, right?

> +	data->pdev = platform_device_register_data(dev, "sbrmi-hwmon",
> +						   PLATFORM_DEVID_NONE,

Yeah, that's not ok.  Please do this correctly, as this is NOT a
platform device, but rather a made-up one that you just created out of
no where.  Instead use the correct apis for that.

> +						   data,
> +						   sizeof(struct sbrmi_data));
> +	if (IS_ERR(data->pdev)) {
> +		pr_err("unable to register platform device for sbrmi-hwmon\n");
> +		return PTR_ERR(data->pdev);

You don't need to unwind anything else here?



> +	}
> +	return ret;
> +}
> +
> +static void sbrmi_i2c_remove(struct i2c_client *client)
> +{
> +	struct sbrmi_data *data = dev_get_drvdata(&client->dev);
> +
> +	if (!data)
> +		return;

How can that happen?

thanks,

greg k-h

