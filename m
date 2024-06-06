Return-Path: <linux-kernel+bounces-204017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCD8FE2FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A3C2838C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EF1552FF;
	Thu,  6 Jun 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFu9v8vv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61C19D8B5;
	Thu,  6 Jun 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666477; cv=none; b=f1uhGl4GcE7PesaZRclmhadoZ1sI2x8f8pO0tvUF7ivmhdJK1+2rZ6Ggl4ZDLd1It9d+AUQfUWTKSpYllK6AtuBJnRRfpsoXHdLn5iL6wVpS/zmmDbbsTczjzD7Jg8ggx6XEGufqD/E6aoQB7KwcVKEGvsDKpd6kVnHwlxxctWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666477; c=relaxed/simple;
	bh=hpQf42qO3MldKUzInM+V4YN6hGRQ+MuTA6xdfGIOxiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz5+xs3uSMF5wv+9ayuKSsM+uDlGapnc4aJ3qhy/pbjYj9KI9mHwBg0ckCu5Bhm/7Q5r0aZMjEEIX8ZvS5a2RGxKAGCXW16St5RLOcEG5OlQu8uhAU1M+SZKksKBHIJ0AY1uWLgk2JJR+L8/IJdTHeyaUbi5NZOkEZNtwUjarr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFu9v8vv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717666476; x=1749202476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hpQf42qO3MldKUzInM+V4YN6hGRQ+MuTA6xdfGIOxiE=;
  b=AFu9v8vvNedvXxE3BbNfFW3WUl03K6Zef/XxI4X4bzFAZubRum86uX2w
   ZSfE+J88vfajzeA8n/1jS7H9jd86SPgkbgrD8ZlzbMFOFoU48yJ9tfnGB
   sPaOTzY6FAKmuqxusAtt9AzSyal7SCooa8DCJdAmzYDXjOvGuPSS1NWaa
   xGvxJqtT8K9kjqcK8oLNUnFqSb28ZqlbOael269ldf/52zH0nLdAmrof2
   rIKDjPszXiORqa9Hq+w4DNVnD4B0PS2RYWNKWA3eD+dCTE/i2l/FJeChg
   j+KNihc/6K98P3IBDpqeHvHC2SoGesLf6LudT9VDhodhZUZk3h4tpdjAo
   w==;
X-CSE-ConnectionGUID: tA1pQjBCQ3mLyjZAeZzXpg==
X-CSE-MsgGUID: +hef+bk6TeCJsiGj3ZbOaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14160722"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14160722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 02:34:35 -0700
X-CSE-ConnectionGUID: 6lFhivlMQbOOE+4FuD6zMA==
X-CSE-MsgGUID: HV4SniVhQUKAJFr0KO1MjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38350304"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 06 Jun 2024 02:34:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Jun 2024 12:34:31 +0300
Date: Thu, 6 Jun 2024 12:34:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: tipd: drop second firmware name read
Message-ID: <ZmGCp8G4nK2ljRU8@kuha.fi.intel.com>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
 <20240606-tps6598x_fw_update_log-v1-1-2b5b8369a0ba@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-1-2b5b8369a0ba@wolfvision.net>

On Thu, Jun 06, 2024 at 11:03:55AM +0200, Javier Carrasco wrote:
> tps_request_firmware() reads the firmware name and there is no need to
> repeat the action in the device-specific implementations of the firmware
> update mechanism.
> 
> Provide the firmware name as a parameter in tps_request_firmware() to
> avoid repetitive operations in the device-specific implementations.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index ad76dbd20e65..851b0d02727a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -892,19 +892,19 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	return 0;
>  }
>  
> -static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw)
> +static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw,
> +				const char **firmware_name)
>  {
> -	const char *firmware_name;
>  	int ret;
>  
>  	ret = device_property_read_string(tps->dev, "firmware-name",
> -					  &firmware_name);
> +					  firmware_name);
>  	if (ret)
>  		return ret;
>  
> -	ret = request_firmware(fw, firmware_name, tps->dev);
> +	ret = request_firmware(fw, *firmware_name, tps->dev);
>  	if (ret) {
> -		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
> +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", *firmware_name);
>  		return ret;
>  	}
>  
> @@ -999,12 +999,7 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
>  	u32 addr;
>  	struct device_node *np = tps->dev->of_node;
>  
> -	ret = device_property_read_string(tps->dev, "firmware-name",
> -					  &firmware_name);
> -	if (ret)
> -		return ret;
> -
> -	ret = tps_request_firmware(tps, &fw);
> +	ret = tps_request_firmware(tps, &fw, &firmware_name);
>  	if (ret)
>  		return ret;
>  
> @@ -1155,12 +1150,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	const char *firmware_name;
>  	int ret;
>  
> -	ret = device_property_read_string(tps->dev, "firmware-name",
> -					  &firmware_name);
> -	if (ret)
> -		return ret;
> -
> -	ret = tps_request_firmware(tps, &fw);
> +	ret = tps_request_firmware(tps, &fw, &firmware_name);
>  	if (ret)
>  		return ret;
>  
> 
> -- 
> 2.40.1

-- 
heikki

