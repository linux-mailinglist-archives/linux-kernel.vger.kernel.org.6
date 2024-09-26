Return-Path: <linux-kernel+bounces-340605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6B9875C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820D2B214F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE81D132139;
	Thu, 26 Sep 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhiGLQd+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB45258;
	Thu, 26 Sep 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361460; cv=none; b=e+dkLyKuJFJK1tuWmRHNovk1+tKkqNriKo511OO2GeNgvuNflhh/+hWEsaPRGqEx6S/UW6i2o3xxY1HlAkmHu4agSIJ7FrUDWicfPSm+NbebnVGYp7mqrpbkW/L7/MtgEUNOKWBrmv4QL3kQiURL30ncxBu3ghseCUKrcD5m4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361460; c=relaxed/simple;
	bh=xK9pFpMvJOrIVwGvp9GSZ6j28+YbgCV3+bdue2q871U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ9G/kXbikdGdhKYGRoff1lM2k27aTnwlwFa8C9alsmwnI2CVw8LxVOT01iplFnXnZL3CV4tTEcYrVURlQnWHix5sG7qY9xqsd3nRMGt8x8JgGmBOq3CufB3Otnt6IiLalrNHHpJZk/V1UnG/rOQCCXKbFc/OR4Usfq9zvUsWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhiGLQd+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361459; x=1758897459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xK9pFpMvJOrIVwGvp9GSZ6j28+YbgCV3+bdue2q871U=;
  b=LhiGLQd+UZBKwh8OLWch4ULqL2Z/avAfIWVrHgnWIGav6/Zq/FP8dw/0
   nfjsz6thBMOgly2DZ5Tdt5m59KNs1Y0e+l5mc78+JOMLptC3AVi86Ikif
   6Y6jk0dSMPk+D2WmKQz00TQI8jhkVWMEsic91+4P4c1w7uJwWZWWZ54hL
   tc5cXWzvvqQHXIeIhDNhGz/KRT/87VhJJw3/6uWxchJmFFHlZ4dF5jGoK
   xio3myjIc0XDLfopx38rzIceKeN1REHs5qCA0PahW8J8zm1PhGwjB7wIx
   cbL1zqjLzv7R/dZxC4+bXriuxAU0FBpT0sTe+5AjBBGmKPMciS8AKQDux
   A==;
X-CSE-ConnectionGUID: LfMXfEAvRh2SiByNATm6pQ==
X-CSE-MsgGUID: 11CI7xV1S7SwXfgbs08Z4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37044563"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="37044563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:37:06 -0700
X-CSE-ConnectionGUID: UIFGZD3fRaqXwU+r6fOLuA==
X-CSE-MsgGUID: tRLtcEk0SvSTCvQR2B2x+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72469879"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa006.jf.intel.com with SMTP; 26 Sep 2024 07:37:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:37:01 +0300
Date: Thu, 26 Sep 2024 17:37:01 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, jthies@google.com, pmalani@chromium.org,
	akuchynski@google.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] usb: typec: intel_pmc_mux: Null check before use
Message-ID: <ZvVxjTcfG0Gm-mmB@kuha.fi.intel.com>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.3.Ib7a83adb069df1cb0a40dcddff29618bf3255700@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.3.Ib7a83adb069df1cb0a40dcddff29618bf3255700@changeid>

On Wed, Sep 25, 2024 at 09:25:04AM -0700, Abhishek Pandit-Subedi wrote:
> Make sure the data pointer in typec_mux_state is not null before
> accessing it.

This really should not be necessary.

> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 56989a0d0f43..4283fead9a69 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -331,14 +331,19 @@ static int
>  pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
>  {
>  	struct typec_thunderbolt_data *data = state->data;
> -	u8 cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
> -	u8 cable_speed = TBT_CABLE_SPEED(data->cable_mode);
> +	u8 cable_rounded, cable_speed;
>  	struct altmode_req req = { };
>  
> +	if (!data)
> +		return 0;
> +
>  	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
>  	    IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB))
>  		return 0;
>  
> +	cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
> +	cable_speed = TBT_CABLE_SPEED(data->cable_mode);
> +
>  	req.usage = PMC_USB_ALT_MODE;
>  	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
>  	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
> -- 
> 2.46.0.792.g87dc391469-goog

-- 
heikki

