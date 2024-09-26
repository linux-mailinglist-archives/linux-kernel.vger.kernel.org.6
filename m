Return-Path: <linux-kernel+bounces-340630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E1987609
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123BA1F2575C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03F14D452;
	Thu, 26 Sep 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0O4G30X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3D14A4DE;
	Thu, 26 Sep 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362470; cv=none; b=OmLwyjZ29A+KmUGN5dDN/ATaTQRr40ethmVY0Qp5azkzYZecdBOjTyM+QsaS2sM2tpCRN4AzJTRAVDF/2eOBzYfQj1WQBggec+rThmq3g9IlEYcZFF8aDV/birNb7k+pV20yWCvdZ3ZTtAYASUFKe7E6lYz9jAq+MgZPBgKc3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362470; c=relaxed/simple;
	bh=L9YXN0t4DVD7+YRuHu7wlstt9F9d+8MVDMPVhMv6YAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdeTcM/i2hxcuQzn5FKW+DHL3vClYNC+SNJIgzynno6RF3aIPy2HWp77T5Epb5zFgNauONxqsjOScyA0T3/Utjnry9aj93oN2S8IWrN2DSHI0gXliMz4xiepM2bp1vMHGRaJpS9wkRycKG39uBCCbzb5FnIkcSCUwc6c4V6Gdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0O4G30X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727362469; x=1758898469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9YXN0t4DVD7+YRuHu7wlstt9F9d+8MVDMPVhMv6YAU=;
  b=S0O4G30XSDgVCyUZ6ohV+OI/8vDJR3fMYaWY0dSFypgZUeX5end9tqH4
   bVwFjdr+Xqx8fvjNILo2NdkYoSaQCa1/g65AWqu/UupjAtvCacRtmOC+a
   huN+Id+9M3dB77quNa8sX8hakHDyHDT9nIGRZsC+bUFIrj7N7B2KvsaEB
   8ABczvuPJ0Vxk24LD+/In09/kXk1PCAwH2JGKEraGD26DqM9PGxcVWu8l
   SO78v0wT95HS4o395ELaGtGLZLyHo28ccJQO3StZTZnngFs7yWCKTO5PT
   L3AKM5kVUgzSzXi8OeLXWN5DuApIMH25m/O7GZ0/JYsp+VUeV21YHcP+M
   Q==;
X-CSE-ConnectionGUID: iJ7aefA9TRCS5A+IhpCJtg==
X-CSE-MsgGUID: tNRoVz7+S8WwoGJ7+IG5Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26559941"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26559941"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:54:28 -0700
X-CSE-ConnectionGUID: S9dH61F+Rxqmf8L46Jo1TA==
X-CSE-MsgGUID: wQjBT8iEQvqtG8Fo58927g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="77016166"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 26 Sep 2024 07:54:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:54:22 +0300
Date: Thu, 26 Sep 2024 17:54:22 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, Ajay Gupta <ajayg@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haotien Hsu <haotienh@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: ucsi: ccg: Use common code in ccg_read()
Message-ID: <ZvV1nqnbJMfTpgwI@kuha.fi.intel.com>
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
 <a4087943-ee25-4e05-80c4-02a77196848b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4087943-ee25-4e05-80c4-02a77196848b@web.de>

On Wed, Sep 25, 2024 at 07:33:47PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 19:08:07 +0200
> 
> Add a label so that two statements can be better reused at the end of
> this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index ed075a403d87..e3850c42583e 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -269,15 +269,16 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>  		status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>  		if (status < 0) {
>  			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
> -			pm_runtime_put_sync(uc->dev);
> -			return status;
> +			goto put_sync;
>  		}
>  		rab += rlen;
>  		rem_len -= rlen;
>  	}
> 
> +	status = 0;
> +put_sync:
>  	pm_runtime_put_sync(uc->dev);
> -	return 0;
> +	return status;
>  }
> 
>  static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
> --
> 2.46.1

-- 
heikki

