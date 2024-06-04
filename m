Return-Path: <linux-kernel+bounces-200256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82298FADB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A90D282FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F411428EF;
	Tue,  4 Jun 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvnvtfCG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC4142E7E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490281; cv=none; b=WipHdHWw66iVFtOJAys1M1VmT0mvQhzCVA1Q0iqBgu9hjZRDSaN8wUHbxDy/OSAv7d9uxONt2fGS99CGOcVAALL9+c6Fka66EPeeDL0Pwj6J1Y3Dz+zY8/l1Hv4DtenJ8jDvreg2M82t4NP97B1B9ZQlMG5E6+aDC3dekJalXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490281; c=relaxed/simple;
	bh=clr8PNzp28iEXJhUzMTN+VUpyOtU7H+K9NS8XY7eqY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epVA4h5Yn8MbX7P3M6rESQwp3FoWQQNyNt2xrXVpGU7KqyogcFYzRvCZKZgtGG04ezjJw1Q3XnXiAiJV2LIp70+wEmpqi0RAKHcxDQleA5Qu+NdZzG1FDLy5vC0oZGUQS+sKcB+toJBPcMdgYCKmskGRSr6SsL8uPE5xN3UH54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvnvtfCG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717490280; x=1749026280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=clr8PNzp28iEXJhUzMTN+VUpyOtU7H+K9NS8XY7eqY8=;
  b=OvnvtfCGWn9rfhy9oxGHSumCuYmP7WjvBNZx+Cwo2GXA6EPaFABdof5y
   P2ptk7iWXpC3GY7alW180PoFQpfUQjZ5rwizXjj72raCUZAMorAr4QfmG
   9a9B6YCdLzbkE97Tu6TgeZPP6JJQg1W0lLxyQNOFWyLqB4UsVcYPJN5TR
   yGV/vPvfxGq05CXAQk1O17g+UniWdaPw+3wslAMqHQe+yVVpZGViofZbm
   9YUIVdyRGk+nYSrlxQWlvSpWgO9QoZH1B+99K5mDvWnbsfYR9SwFYZyQi
   cOWhmxVRX1r0s5PTT1fC8k3+fidnW/Yh0nEDFTi3++CNEhAvPNdpDSJPo
   w==;
X-CSE-ConnectionGUID: PxrMINsgRGK2C3usNOzgqw==
X-CSE-MsgGUID: Ypi1Iw/ZRweIAHimo8i1ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17809390"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17809390"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:38:00 -0700
X-CSE-ConnectionGUID: Jjtca514SqqL9VXY00N8mw==
X-CSE-MsgGUID: ZUNS3a2lS5SevAcJlkaM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37638040"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.105]) ([10.245.246.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:37:58 -0700
Message-ID: <e1c63097-b628-4c97-add6-40fa479a7806@linux.intel.com>
Date: Tue, 4 Jun 2024 10:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] soundwire: bus: drop redundant probe debug message
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-5-johan+linaro@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240604075213.20815-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 02:52, Johan Hovold wrote:
> Drop the redundant probe debug message which is already provided by
> driver core. Whether probe succeeded can also be determined through
> sysfs.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soundwire/bus_type.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 43e732ca73c0..5b9b129badff 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -152,8 +152,6 @@ static int sdw_drv_probe(struct device *dev)
>  
>  	mutex_unlock(&slave->sdw_dev_lock);
>  
> -	dev_dbg(dev, "probe complete\n");
> -
>  	return 0;
>  }

I don't see the point of removing this, we've used it for the last 5
years to figure out when the probe complete vs. when the device becomes
attached. It's a simple log that helped us immensely with race
conditions, etc.

And no, sysfs is not a viable alternative to look at CI logs, and
enabling dynamic debug on the driver core would be way to verbose.

