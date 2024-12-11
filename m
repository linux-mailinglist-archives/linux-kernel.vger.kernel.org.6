Return-Path: <linux-kernel+bounces-441057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E699EC8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C27280AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1402336A7;
	Wed, 11 Dec 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbQCZRk3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440F1A8408;
	Wed, 11 Dec 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908746; cv=none; b=eoxQdwrylcZPQEzlFFKMMDgKX2A8u/xum9d7EWvl3uqjGOSLoJesab3Z47koG26g1QI83+pvf914YlmVjjSfOQX+uckuTU3DrZIfgKM+JCs+WPDltZl7cQKZ5ZcxDjLz3eZbhP4zskm0cRJ0kVxXRBM5GeGt8COaKyCcyV+bVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908746; c=relaxed/simple;
	bh=EAZc5BG/lGj4Chm2b9mW1NY7iiGPZNBIY+xChKuEvmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvkGvTUO+yJcmjDnYlDoLgJKa2Xb6ffJkPDJlMous8vRMY3zkcmasofS0dZTQOh2W6PCF+2vIM19Q3S+X0vzc+u86c4lraoPvZo+jokbQUGIpPplZfbEx3f9Ew/4V94bgF2UWMsHnYOBz/sdnnxXm8F30kBGElorExjrKgCHn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbQCZRk3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733908741; x=1765444741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAZc5BG/lGj4Chm2b9mW1NY7iiGPZNBIY+xChKuEvmo=;
  b=MbQCZRk3tX1ryDDg+dN4pAH/aFVV3GSoeKA4NTguBVRjKhze9GFDAI45
   lHP76WLph0MRDV6GqykZPPmQ739ogVfO2UePT5Wb1ZfTVs5CJHFJMozaM
   s0mrVbpA2ai+mEmeztb/jk+dfmjpSQ5i0D/LsaZvaCRJSlFOXiWwD+QrE
   2OI2760cNUjEeugDJpJvfDZkrNxpt5GLx6cUveDr0/TDkeBaSUBm1KfH6
   HDt9AyFH9nkGsiSsrCqJawHwVCwbZ6HhgPoKRIF7esaIwPwss8KHFJZkH
   5MiNzX26WKT4lcjALYKwqkpmv88J+12vMdKAZIwyREn4xz/KCeNVkeMZ3
   Q==;
X-CSE-ConnectionGUID: n6NGchO+T+6myJ2PV9dDKg==
X-CSE-MsgGUID: /jsb/KS2RPyWx4k9Hy2kJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44951279"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="44951279"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:18:58 -0800
X-CSE-ConnectionGUID: yOTttQY1SJmWD38zPJwHSw==
X-CSE-MsgGUID: AIOLTSZPRBmMr4J7M5fB/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="96203619"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa009.fm.intel.com with SMTP; 11 Dec 2024 01:18:52 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 11 Dec 2024 11:18:51 +0200
Date: Wed, 11 Dec 2024 11:18:51 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix error code in
 max_contaminant_read_resistance_kohm()
Message-ID: <Z1lY-9ik5T76U_Yn@kuha.fi.intel.com>
References: <f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain>

On Fri, Dec 06, 2024 at 04:09:18PM +0300, Dan Carpenter wrote:
> If max_contaminant_read_adc_mv() fails, then return the error code.  Don't
> return zero.
> 
> Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index 22163d8f9eb0..0cdda06592fd 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -135,7 +135,7 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
>  
>  		mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
>  		if (mv < 0)
> -			return ret;
> +			return mv;
>  
>  		/* OVP enable */
>  		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCOVPDIS, 0);
> @@ -157,7 +157,7 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
>  
>  	mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
>  	if (mv < 0)
> -		return ret;
> +		return mv;
>  	/* Disable current source */
>  	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBURPCTRL, 0);
>  	if (ret < 0)
> -- 
> 2.45.2

-- 
heikki

