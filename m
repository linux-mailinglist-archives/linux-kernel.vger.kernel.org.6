Return-Path: <linux-kernel+bounces-200255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30168FADB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BA5B22ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212E4142E6C;
	Tue,  4 Jun 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byF+c1Z0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290021428EF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490278; cv=none; b=JeU9EJwdfChO6l6hj8VctXTPkUo+GKakoXvTeK3UJSomySbIfej0xdWQMIjllDjPH7k2OYrbK9u40FI4FRzl/GU2BKEZgY6/tOupcSb4pBAHkRpMyLjQne9Mns30ps6h2tAUi4v3y8NjnetXcxwRzwtX8H8+Gh8VhWmEetvcOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490278; c=relaxed/simple;
	bh=YxyvpYu5+hq9m2N6cRjmeKqrhwAeBwX4i0FpqUqrPrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5HdH8AFyBFkNOBoW7rQYioPlSEZeeLNhGDV9/79ZlAg2ZfFggYFPS+8r8cVdY0ctgXsNEYy9XB68lnprbZxbEp1F5iS9UFDSEzlvfH9VikDOG5sDv2ZciGeJk05B+rF/KVsIl+r3+dmFy/mNNbZxRdaTHC9oqNLBuYZ31BKJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byF+c1Z0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717490277; x=1749026277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YxyvpYu5+hq9m2N6cRjmeKqrhwAeBwX4i0FpqUqrPrk=;
  b=byF+c1Z0DXjTy5PBk2AMo9AeU1cYoNo78FzvvSwRJB0vNTGWv2uknBIJ
   qdrPJ78d+rmQs4pPZAuwEUlAkwkcUoI+FFnyKpWGGJtjEZh1GtcNoEde3
   fgulfngWlZ0Wl0sB6rsRH2c8nW6+Tm7bDdrSpGl2AKsQ3a71Ww64aRbdr
   a0nZq8tur6H8f5tqSXsLMm2OOrZFy+8+FURU+PgjzCH+SG+AlaUKO7rDw
   +6QvmJGIsnXOgznxKTslU3SpZRNyoG9zb2ClMhjGScw+DDZZcXKPFKLr8
   GbQJgoGhivuB8Rxt25HFnCAiurFGEX3G3wan13qAdyYFdDVTv0VejqDLK
   w==;
X-CSE-ConnectionGUID: 0z8Ks/igS5iNvok5fWRvFw==
X-CSE-MsgGUID: pmomu5MMTT6mcqj0l5/+cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17809387"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17809387"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:37:57 -0700
X-CSE-ConnectionGUID: 6NACwwD1SJ+/9p6O2rfM0Q==
X-CSE-MsgGUID: xOEvdgI2QUG6h7dt4G7Ypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37638037"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.105]) ([10.245.246.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:37:55 -0700
Message-ID: <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>
Date: Tue, 4 Jun 2024 10:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240604075213.20815-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 02:52, Johan Hovold wrote:
> Clean up the probe warning messages by using a common succinct format
> (e.g. without __func__ and with a space after ':').
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soundwire/bus_type.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 3979be0f8b65..43e732ca73c0 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
>  	/* init the dynamic sysfs attributes we need */
>  	ret = sdw_slave_sysfs_dpn_init(slave);
>  	if (ret < 0)
> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
>  
>  	/*
>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
>  	if (drv->ops && drv->ops->update_status) {
>  		ret = drv->ops->update_status(slave, slave->status);
>  		if (ret < 0)
> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
> +			dev_warn(dev, "failed to update status: %d\n", ret);

the __func__ does help IMHO, 'failed to update status' is way too general...
Replacing 'with status' by ":" is fine, but do we really care about 10
chars in a log?

