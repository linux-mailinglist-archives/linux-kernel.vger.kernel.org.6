Return-Path: <linux-kernel+bounces-252355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172F93120D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC174281E06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6123618734C;
	Mon, 15 Jul 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4OwX7xp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5F1F608
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038463; cv=none; b=Pk8WsKvboUc6/RwvUdtWe2rjSr1ZXNksAq2CgJFbO8LO1dB9yJdh8UoU8hwWDYtjt1vDykwJhU82pEJQejnc3lTnYrv6PqOu820QD7XfSq3D3jd7vClBXD446WmvS3Lx6M0bOZf0eHUgEInpV7dPKigvlEf45KDl7AqEThFZFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038463; c=relaxed/simple;
	bh=8UdBXthv6kcV8OL3lTKGH5Wv7aPW5LihpSVs90pR3pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc5r3Jk+1lj+0Ilb4uI40useygcuNkpsArxkeLAFGdIp5+17E5fi1R8qJXbFl5VsqBXcJ0NoAyBTg7OaxeHfh6MKfRx+ukaDxN2bKcrmeBgi+7A3foz9lwLXA32/pSk1oUkq5h7AHR59XnqinEzfRvgEKBr9QyehklusYkZrhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4OwX7xp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721038462; x=1752574462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8UdBXthv6kcV8OL3lTKGH5Wv7aPW5LihpSVs90pR3pE=;
  b=k4OwX7xpMIkAL0Ptsnfo8PhEglYzVUZ22icLePYAF2VAw+2TTd9Ubo/S
   84mefdp66lfvXOX/b5Wf0u16VH8ed2/z3SedOeoPln1w5jN7DSFpZDYU3
   voPF8cVyhyvFHxvVLFdxAD5cVWLMqBVTo7ZXjm4DzpC4wuoQC+Q2yxDVN
   GbMw2g0n7ctifIADKjLgPhSdxGxLnZ5n63aRcphCwe6wFJazBk7VnkbJj
   TuUnIn3FnM+Yt2R6ZfZm8/jIr873FLcfCgbe3yAiU6DU5xJk7hbQ3yCdz
   xxEyCO48SHX7ThEAR74aywI2wbj/qjM0HmXCawbQP46XeaBMwgys0KX3L
   A==;
X-CSE-ConnectionGUID: czNksVlqR76CQ+A1LKQgDA==
X-CSE-MsgGUID: NdtiL9AHSqWv6+s6OvP51A==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35950257"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35950257"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:14:21 -0700
X-CSE-ConnectionGUID: XApP/1ylRAaC9ZxzUMezUg==
X-CSE-MsgGUID: Pxd7zbB6SoaYGbcTy2LFFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49455945"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.147]) ([10.245.246.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:14:19 -0700
Message-ID: <28fbcffb-bf79-418d-93c9-cfe2516a69a5@linux.intel.com>
Date: Mon, 15 Jul 2024 11:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] soundwire: bus: suppress probe deferral errors
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240712140801.24267-1-johan+linaro@kernel.org>
 <20240712140801.24267-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240712140801.24267-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/24 16:07, Johan Hovold wrote:
> Soundwire driver probe errors are currently being logged both by the bus
> code and driver core:
> 
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12
> 
> Drop the redundant bus error message, which is also incorrectly being
> logged on probe deferral:
> 
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517
> 
> Note that no soundwire driver uses the driver struct name field, which
> will be removed by a follow-on change.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus_type.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index c32faace618f..85fa5970d98a 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -83,7 +83,6 @@ static int sdw_drv_probe(struct device *dev)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>  	const struct sdw_device_id *id;
> -	const char *name;
>  	int ret;
>  
>  	/*
> @@ -108,11 +107,6 @@ static int sdw_drv_probe(struct device *dev)
>  
>  	ret = drv->probe(slave, id);
>  	if (ret) {
> -		name = drv->name;
> -		if (!name)
> -			name = drv->driver.name;
> -
> -		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
>  		dev_pm_domain_detach(dev, false);
>  		return ret;
>  	}

