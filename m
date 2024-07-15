Return-Path: <linux-kernel+bounces-252356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D389A93120E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC8D283C82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE2187546;
	Mon, 15 Jul 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGv4bg7J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E718733D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038465; cv=none; b=uAo98wmkWf8RZW1S61AjV4vfZNFtg00f7ZUDAmfaugH/Vwjl4azvzqJhxyYasVaUPyHaac8ws6oma83kaXx4i8pV/8aW2/zKxDTMEUeoyy8KP0swwIbepzKmTFajMive0VbBiNQXsSQ8NnOAqm/KnPa/4THW4cxqSm6Wewk21/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038465; c=relaxed/simple;
	bh=L1bddvNpW2JSZGxsWMXxNwVCNw6Mlro5NMh+sB6z/Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO/t4l33egENPdcwhDmg4aowHFJ6TmB4HtfD0epnZBkmaXXekY/1TU0mzsEkD6AZ/9bnrxStTMDldJbxg68krLTky8W38JzuAVbXedCqthz7u3DTwQFfRrJ5a59bn1BECuVjoGdFRTW90DK7ucFeLQVG5ayF6zd0Rg8Wn2olFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGv4bg7J; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721038464; x=1752574464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L1bddvNpW2JSZGxsWMXxNwVCNw6Mlro5NMh+sB6z/Z4=;
  b=ZGv4bg7JCWT8qzsPQJzgs7Sya0IbX8r9UcD09lYLH5gU6JM30sqERUQM
   reJSWT2PmTfgeP4lSdYFukwPU0yFpl02c37H9lq01oQM9oXjKx2vwcZY5
   PUVK5PPkSd4TN6ol8UBoqTr1i9Zp1oEp3Mb+qSQAv8Bn4CZ+Z04wDOuJx
   UAlbXMrh/WLvYWMFXFURcNV5Wy90P6FDlp/QV/7OjkS2XcnLgSXfIlIIv
   kHdZ3aUJ2c1A2RHwpvxgi6P4BfH5ZxJS5TCXTjFcbX2qwoovUv7uNn5w0
   nhaETfhktX5jeub4plJNGD/5oBIDWuiejcjQWkk/OJwL2rqUd49Kmh3AC
   g==;
X-CSE-ConnectionGUID: wmGkYB/xTCCkzr9lXf+RGA==
X-CSE-MsgGUID: KfZuXCEOR8WfKJ8bkBAVyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35950259"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35950259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:14:24 -0700
X-CSE-ConnectionGUID: 5/dgto6aSs2Kmkae56FYHw==
X-CSE-MsgGUID: sHt4WkWgROqcSe9Ym6+ndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49455954"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.147]) ([10.245.246.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:14:21 -0700
Message-ID: <5a39e413-a17e-413b-9bd2-f8e0b0d0e86b@linux.intel.com>
Date: Mon, 15 Jul 2024 11:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soundwire: bus: drop unused driver name field
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240712140801.24267-1-johan+linaro@kernel.org>
 <20240712140801.24267-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240712140801.24267-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/24 16:08, Johan Hovold wrote:
> The soundwire driver name field is not currently used by any driver (and
> even appears to never have been used) so drop it.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus_type.c  | 9 ++-------
>  include/linux/soundwire/sdw.h | 2 --
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 85fa5970d98a..3979be0f8b65 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -198,16 +198,11 @@ static void sdw_drv_shutdown(struct device *dev)
>   */
>  int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
>  {
> -	const char *name;
> -
>  	drv->driver.bus = &sdw_bus_type;
>  
>  	if (!drv->probe) {
> -		name = drv->name;
> -		if (!name)
> -			name = drv->driver.name;
> -
> -		pr_err("driver %s didn't provide SDW probe routine\n", name);
> +		pr_err("driver %s didn't provide SDW probe routine\n",
> +				drv->driver.name);
>  		return -EINVAL;
>  	}
>  
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 13e96d8b7423..5e133dfec8f2 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -704,8 +704,6 @@ struct sdw_master_device {
>  	container_of(d, struct sdw_master_device, dev)
>  
>  struct sdw_driver {
> -	const char *name;
> -
>  	int (*probe)(struct sdw_slave *sdw,
>  			const struct sdw_device_id *id);
>  	int (*remove)(struct sdw_slave *sdw);

