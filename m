Return-Path: <linux-kernel+bounces-335559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC397E76E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97142B20B63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB989193428;
	Mon, 23 Sep 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFNKGmcP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD9192D7E;
	Mon, 23 Sep 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079629; cv=none; b=I1ziOxUhzGA3ZM+z4myxdDJsqCa7wSYXcIOAwVvChchWWhNH215HkUVkPcO2egea0DfWtgG6BidLwoyJ7AhorLkqEcSsLyLU3PeQ9GG3l853Nc/BTVaucVniDaXsNx0jOAkPoWhwg5xGrzgF+y9aVCpY7TX+GqLEXB8/WefUcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079629; c=relaxed/simple;
	bh=gtX1ufG1d7RliMXAfdW/G9khgrDwtNsLvgPMiBUHbGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvupyBjwmj/QyRS+mKrzucasUv+WGdrRNhMz1gPAwBHhe0hTvpGz+ru3m2bRHYI71RtBESHx7+Jr7Sx2lW/o6aOElWvoDwupCy4loBRDulsOI/cv8xu1ImI1kbyvoysEjEDC5bONPTVHUs69tjU9kk15HxH4VZWirT5wWiwg8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFNKGmcP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727079628; x=1758615628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gtX1ufG1d7RliMXAfdW/G9khgrDwtNsLvgPMiBUHbGw=;
  b=PFNKGmcP4Vvl65jbrzfYIFmIIlrQeAiG+HNERX1uwrmqra/o626vcFrc
   yzk/FaSeKZCdAfoWJ4pPCO9X8cJYk4G1ZS2C2N4DNV2NajFRvCySoaHKe
   Oa6G4GD/lYce4cii4iAAUoja76s7KXlqyjhn6jbTxGTe1A/doyEpvymhQ
   n/sEm0o9+ewrWS8oM34aYEn8TqDUb25PksMLUuytWi3cWNvHuhW94G33n
   2BpXKLs9uHhS95cEiCF3yMhRu1ePZ8crQk1f3Zx8XuBhXGrPnVF3KhhgY
   3uAxJ9B3UXCHw8cXHTrj3+7swdpy22OidIsxRU7FCnMf0oSLfokMjOv58
   w==;
X-CSE-ConnectionGUID: c5ovfAp3TkuzS3QRPjIE0w==
X-CSE-MsgGUID: a1fCMfZlTheKnZ561ptxBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25965081"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="25965081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:20:27 -0700
X-CSE-ConnectionGUID: LCOiF/VeRMCRb3MnIbVbEw==
X-CSE-MsgGUID: 6sn05GnwThWzlcG2uR+v5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71137228"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 01:20:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 23 Sep 2024 11:20:18 +0300
Date: Mon, 23 Sep 2024 11:20:18 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix  dereferencing freed memory 'fw'
Message-ID: <ZvEkwqxArMQij8VG@kuha.fi.intel.com>
References: <20240922105212.28099-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922105212.28099-1-kdipendra88@gmail.com>

Hi Dipendra,

Thanks for the patch. You forgot the susbsytem and driver from your
subject line:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

On Sun, Sep 22, 2024 at 10:52:11AM +0000, Dipendra Khadka wrote:
> smatch reported dereferencing freed memory as below:
> '''
> drivers/usb/typec/tipd/core.c:1196 tps6598x_apply_patch() error: dereferencing freed memory 'fw'
> '''
> 
> Invoking release_firware(fw) just after checking ret.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

This is a use-after-free case, so please add the Fixes tag:

Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index ea768b19a7f1..eb5596e3406a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1191,11 +1191,11 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	dev_info(tps->dev, "Firmware update succeeded\n");
>  
>  release_fw:
> -	release_firmware(fw);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
>  			firmware_name, fw->size);
>  	}
> +	release_firmware(fw);
>  
>  	return ret;
>  };
> -- 
> 2.43.0

thanks,

-- 
heikki

