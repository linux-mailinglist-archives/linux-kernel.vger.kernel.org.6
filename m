Return-Path: <linux-kernel+bounces-533461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02447A45AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDD4188C245
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6F26B08C;
	Wed, 26 Feb 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUdzRG8E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E25189B91;
	Wed, 26 Feb 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563573; cv=none; b=H/jsDdvqthTsi20iSjthRtQIYH9PFucNOvqXmjtQEfWjxk0uwEYkGtLFaKOQNoXw3ZmSBfgqTb+4aEBwjtTqm1VB44CuH3raFSxRjUXF1kuTQJh+5ubjDTuAZ7+vnBreCHUmtE+27rK/Cs6c8DSIYOvGVKDIKuID1fQxAkrEANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563573; c=relaxed/simple;
	bh=ciorLijCDPE3/xsYPkft10tMODFy17X/YsQ/RQhLc8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzynie8tQ/+PkVEdLPYNONy5b71F36LOxhPjrRO5z0KXwoWUcc0eAbLruKJ1PVf53GWEw/1d4pc5XQ23gQRgp/cV5egI2RE38z53y25ERpMi/4aDP2KX/SnaqzW/zwCcmQH5Cg3jHOlLfBuKqjUAmSaFB6uCX6e35iGu3ZIh2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUdzRG8E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740563572; x=1772099572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ciorLijCDPE3/xsYPkft10tMODFy17X/YsQ/RQhLc8Y=;
  b=aUdzRG8E7HXYhO065kwX25yMBAIyvwwLXY4xfeQ2Kuh4K/zSeelsa449
   jSNhlK7bvx2Uey6Au0wbfDQoXS/Oz56BOuqcTESgukWDbrTnLmlDwndL/
   S6TNO/tqd1jLeJuOslMsMELyDBlo7NQvTYkIsc0vBVsCgX11xNIDITZae
   OBgNfgO6IR/yOgIuudwNG/dzQ2TCtaPIx4jt//uZUAXc+KmVWFsl4I1sS
   Gclm6ThYJsVzhI++DFi6AIbfEQU2tYsWJrshrtbBdJV8kOq2pZAfFivSi
   SfrfMr3Y5O+SSvlE5L2M8UW1NjOpgmXFExYPTiF5A9awEJUKT/FwmpE3q
   Q==;
X-CSE-ConnectionGUID: c/JRXZEUSYONl8Mil28o5Q==
X-CSE-MsgGUID: N9Y6F9nQQbaJt4w/H9tRyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52037602"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52037602"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 01:52:51 -0800
X-CSE-ConnectionGUID: TGlmJ6xORTOhT/xH2DNDFQ==
X-CSE-MsgGUID: 6BXYpYZHQD+YRrFY281gdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153831882"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 26 Feb 2025 01:52:48 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 Feb 2025 11:52:47 +0200
Date: Wed, 26 Feb 2025 11:52:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] usb: typec: ps883x: fix probe error handling
Message-ID: <Z77kb2a_Vhln0reU@kuha.fi.intel.com>
References: <20250218082243.9318-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082243.9318-1-johan+linaro@kernel.org>

On Tue, Feb 18, 2025 at 09:22:43AM +0100, Johan Hovold wrote:
> Fix the probe error handling to avoid unbalanced clock disable or
> leaving regulators on after probe failure.
> 
> Note that the active-low reset pin should also be asserted to avoid
> leaking current after disabling the regulators.
> 
> Fixes: 257a087c8b52 ("usb: typec: Add support for Parade PS8830 Type-C Retimer")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 10e407ab6b7f..ef086989231f 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -387,10 +387,11 @@ static int ps883x_retimer_probe(struct i2c_client *client)
>  
>  err_switch_unregister:
>  	typec_switch_unregister(retimer->sw);
> -err_vregs_disable:
> -	ps883x_disable_vregs(retimer);
>  err_clk_disable:
>  	clk_disable_unprepare(retimer->xo_clk);
> +err_vregs_disable:
> +	gpiod_set_value(retimer->reset_gpio, 1);
> +	ps883x_disable_vregs(retimer);
>  err_mux_put:
>  	typec_mux_put(retimer->typec_mux);
>  err_switch_put:
> -- 
> 2.45.3

-- 
heikki

