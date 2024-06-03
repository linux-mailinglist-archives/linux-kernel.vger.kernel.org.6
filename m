Return-Path: <linux-kernel+bounces-198991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DC8D802F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C47283EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39911839F1;
	Mon,  3 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRA/rBya"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74882D64;
	Mon,  3 Jun 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411089; cv=none; b=ab/Ig9Odz7k3hZBR96rLZxJDPy9eIYQtpuG0pGIxnHHTlY9GonO/VuBEMgMgVrQ1ruPG/1WZE/ILOoG4I/XZ9ofNoZfQJayfoYXTeQ9mPNLhlPG8mpCPAzEvgsJvNoyLQHqeXptN7fBbUaDATc8Ecc2fIdfLCZvRHSWAqHN/XG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411089; c=relaxed/simple;
	bh=kM4oD8NAaDYrx9lv8+wUf5WJMEkwvykiX51xhmqmGMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u54vE2jKptnz5hrERJIFQDg/a6b0IsPZGSzH7w8vL0i1WXcsQ0Bgh4QkCb+WYJphzzKNEFY46gvXB4p3x7/oV2RFiX9UiVex+5EaAzzeOFF3oIRfdSYGlpoP0lMGJuu5myVaiOFmYFMUNWSlAQO9ob5nWiJOhSjoYltYxBQNhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRA/rBya; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717411089; x=1748947089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kM4oD8NAaDYrx9lv8+wUf5WJMEkwvykiX51xhmqmGMA=;
  b=VRA/rByaLyRo4b4Zq0C2d4CNHZKVpktdcTwbgdwJdYLWUDcBVnFHu9fh
   QGnGU3JNGXG4UqKZJdZK3bHlxP08OpiS0Nrq9y+f8G40698TVU3xO506a
   iee9kUdi3kvBdOeU5gGRk+i09Kz0RqmnI58FKUxT6DU2rHdHVurcQa9jk
   SvkQkbcEHcqeRE9PGEXo8/UeWgSpTaTvkK0a7bPXaJNk35kZfoMrNk7so
   nXs7O+Hurv/LBl0L8tOdL15SeCjuXVJmz631rbitvtD8d+Qjpj1T8yKRH
   3akDDXOlvSWipcVVKSTL2G3hh8YI+2PkarVPwuJF0nhb4DwzgHRW14ajR
   g==;
X-CSE-ConnectionGUID: 0eLWl9/+TL2BnxQZzG2RCQ==
X-CSE-MsgGUID: eeteLrWpTz6IPFyrCMaOmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25296647"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="25296647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:38:08 -0700
X-CSE-ConnectionGUID: bcRepabeR2SLdZzSB5waIg==
X-CSE-MsgGUID: 6htlfZ81Qx+2fGK80CVRMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41761292"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 03 Jun 2024 03:38:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Jun 2024 13:38:03 +0300
Date: Mon, 3 Jun 2024 13:38:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2 2/2] usb: typec: mux: gpio-sbu: Make enable gpio
 optional
Message-ID: <Zl2dCytk06deuA7i@kuha.fi.intel.com>
References: <20240603083558.9629-1-francesco@dolcini.it>
 <20240603083558.9629-3-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603083558.9629-3-francesco@dolcini.it>

On Mon, Jun 03, 2024 at 10:35:58AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The enable gpio is not required when the SBU mux is used only for
> orientation, make it optional.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2:
>  - removed useless NULL check for optional enable gpio
> ---
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> index 374168482d36..8902102c05a8 100644
> --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> @@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
>  {
>  	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
>  
> +	if (!sbu_mux->enable_gpio)
> +		return -EOPNOTSUPP;
> +
>  	mutex_lock(&sbu_mux->lock);
>  
>  	switch (state->mode) {
> @@ -102,7 +105,8 @@ static int gpio_sbu_mux_probe(struct platform_device *pdev)
>  
>  	mutex_init(&sbu_mux->lock);
>  
> -	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	sbu_mux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> +						       GPIOD_OUT_LOW);
>  	if (IS_ERR(sbu_mux->enable_gpio))
>  		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
>  				     "unable to acquire enable gpio\n");
> -- 
> 2.39.2

-- 
heikki

