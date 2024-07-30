Return-Path: <linux-kernel+bounces-267078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF4940C19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92174B26D88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2B193092;
	Tue, 30 Jul 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS7zRYi7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89055769;
	Tue, 30 Jul 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329091; cv=none; b=ZrTiTplRW5rZGg9Wu+J2SXtr68RnvgQyuNmkFtKepgRYdbG2xOU5Aju0CMODjiyUKkAs4XrjVVE0Dlx4ol40g7lKKVAoQyNrCQ9uUhvhMlsR8p8eY7AFj8QfN4//ktOGo/mT/aDLphES7OgfCaYb23lRbkfrolYqqsjQo2+c2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329091; c=relaxed/simple;
	bh=uCCaYijHTbeodCBnvBF+GJTlMCdFoa8W0RnliCAXaY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlpUMBLZ2PhqPzUebhm6RYgvKRSKMv6huZvV142Zpi4fsnEFhm9qnWdiEIh/kN6NU+o9TnJ1B2I6Y8p0jcGn8lPME1DUDhD8lvmvFqv/J6/81v+g83gm1Y7uBvL4vXOgSKymk0YC1wVPYVyMwE4l9HtzSHbGMli4MHzDex7wl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS7zRYi7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722329090; x=1753865090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uCCaYijHTbeodCBnvBF+GJTlMCdFoa8W0RnliCAXaY0=;
  b=bS7zRYi77TeFFJxWShF5iQouFH8eGPenUqk6t5qo4SIirFMAyNv8x9v6
   yNDPoTViOWCu2tda+T/U2WmjIrLVa1LUM0Gk98lA1bYx1Hu+9OdYrfrPm
   9vbn59keDi1hVdkG/K367kjGvZRYoGf2uYMmWICujnQQTsu/XbemmXxIZ
   pB5fAEylRSEm0M0JMA2n7fG13AkLXKMeXw668mOmewdNjnTeWUNMbBFA2
   kFjCuwxmUQ5xGgIs4dJmDufJR0QzTqJi6/nVuBgQI0OAHR65kCq2EFhjg
   iNynCOZ/Z5OI/Iarno4qVD4iQrHfElAqQW9Kiqn+bW58wDi6DsNy33+AV
   A==;
X-CSE-ConnectionGUID: S7II4tfxS2utYuMOmmp1Jg==
X-CSE-MsgGUID: C8amMMBmQC6qhhLO0pzDmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20079367"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20079367"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:44:49 -0700
X-CSE-ConnectionGUID: SPhP2Qm7TB6OeBJ1XWyZPg==
X-CSE-MsgGUID: mATv5y/KTVyoX4pxePOJFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54175206"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa008.fm.intel.com with SMTP; 30 Jul 2024 01:44:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jul 2024 11:44:44 +0300
Date: Tue, 30 Jul 2024 11:44:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH 1/2] usb: typec: tipd: Fix dereferencing freeing memory
 in tps6598x_apply_patch()
Message-ID: <Zqin/MvcyKLd3RAr@kuha.fi.intel.com>
References: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>

On Wed, Jul 24, 2024 at 09:23:50AM -0700, Harshit Mogalapalli wrote:
> release_firmware() already frees fw, fix this my moving release_firmware
> after the dereference.
> 
> Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> This is found with smatch, only compile tested
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
> 2.45.2

-- 
heikki

