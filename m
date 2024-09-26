Return-Path: <linux-kernel+bounces-340629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0AE987604
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093EA1F22390
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825ED1531C2;
	Thu, 26 Sep 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2IL8Zqj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275014085D;
	Thu, 26 Sep 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362431; cv=none; b=hQ1jGtGjznwid2V4o2D3/OwRSwNlXY/GJ4TR5phUrXyvNKt8SCnvhpb9iOAohbuwY11F9lFqL9FuXAa0QkBEE3oii7F9zk5a2ORbV9FhXVt/2BcbbYj+8O8PJ3fR2SO3/zlMlFdlOehonX3nrEfPXMOOKQbPGerKBqvg+uFwBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362431; c=relaxed/simple;
	bh=XtruzNw/WcaM8w7TPDqDyCX+r4bbPswhk/xGZfsC/BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Biq/d+nVPO5J56QZcMGh7k4HTh++XPwmf+w4kaPGT5ZhuZiEiPMIe7uyNWyrFCxRPywSW0wxeNDhM+cTBiOZdI+sMkAyZqTFepATj9b16Epp8ItW/6QwXFuKD5wv3TlTiOXUfOjQu/CkQK2Euz9+lZX4OHcspdGUe1R+CjCAS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2IL8Zqj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727362430; x=1758898430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtruzNw/WcaM8w7TPDqDyCX+r4bbPswhk/xGZfsC/BY=;
  b=O2IL8Zqj60aQgIoozfw93anMT5jGFCRIntTWbEGH+6s5D0F9gyfG1569
   3LIDv/s39tU7jttIWTtfZi48/qHqh9f4CDOCsCzfrq1VudcG4Q47XOPtb
   PzGnJVwyVpNTFaoyYXm/fVaWKxI/GWPAeWCLPekCmCGDr0lxdMGYj71Al
   0nfgjVMN2Oh4dK0iC6wYdJdbt5PKna+ktCRlxQQYsx6Pi/d3vX2fvKhPd
   Ptwy3+JC1GzvxQ8kEYZOKSdTSYDMrrn1oTn3DrTnr7GiM5elAgQvZB23l
   bCtVjBXrhA32aAmlHntfEq3BPd2oCn9tT2kCPq/v+eNGAokxnGQd9GBEN
   A==;
X-CSE-ConnectionGUID: T4xN9fQbRgGR9ykX3u06+g==
X-CSE-MsgGUID: A7iMAc9jTzyECLLq9QqgnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37133823"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="37133823"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:53:49 -0700
X-CSE-ConnectionGUID: 08tJRF8tRtSIaChfgOSgjQ==
X-CSE-MsgGUID: S6kjXJtCSOmOpRttyAzDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72626084"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 26 Sep 2024 07:53:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:53:44 +0300
Date: Thu, 26 Sep 2024 17:53:44 +0300
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
Subject: Re: [PATCH 1/2] usb: typec: ucsi: ccg: Use common code in ccg_write()
Message-ID: <ZvV1eBoM95w3mT8A@kuha.fi.intel.com>
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
 <983e8bde-513c-4053-b33e-06a1b10eef87@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983e8bde-513c-4053-b33e-06a1b10eef87@web.de>

On Wed, Sep 25, 2024 at 07:32:32PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 19:00:23 +0200
> 
> Add a label so that three statements can be better reused at the end of
> this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index b3ec799fc873..ed075a403d87 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -306,14 +306,14 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
>  	status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>  	if (status < 0) {
>  		dev_err(uc->dev, "i2c_transfer failed %d\n", status);
> -		pm_runtime_put_sync(uc->dev);
> -		kfree(buf);
> -		return status;
> +		goto put_sync;
>  	}
> 
> +	status = 0;
> +put_sync:
>  	pm_runtime_put_sync(uc->dev);
>  	kfree(buf);
> -	return 0;
> +	return status;
>  }
> 
>  static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
> --
> 2.46.1

-- 
heikki

