Return-Path: <linux-kernel+bounces-229071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA8916A70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE031C22EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18447172BA4;
	Tue, 25 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4JhrTVw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B21170848;
	Tue, 25 Jun 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325826; cv=none; b=tkqQpqLz0f0IpIpefBQITr544fXVzKPVRG8I+V8aGkzWrafk3QA/gwJ9hxRCuZRiV0vj/k6vbhx46W0GYa6ywSzNMeXj1KeBgyCgUXjvjIu4stG7KSFp2Cjcss9O27UslodJ1luC2GHfruR9ubZWjPQKp54Adq6parDFqE0UGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325826; c=relaxed/simple;
	bh=73V4St2DKaL1yBWaZluZxjZ70qvjqIqjFp3J1vzdyak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDSZu7cO2HNtR8Pgeq+Qu+PrLxaQbXC368lTc4f410XDxKlHRzUCneXIziiOuqBwT5xyvRqZSASe+jhUc/iJVB+bk/ZgkNFfuAm/eRP1xahKBKttSVuwLs9gMFrKPdScD+47KDJJBzRgbRPPEuBvD4Tqg6zqdMzLzFhsbwW726M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4JhrTVw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719325824; x=1750861824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73V4St2DKaL1yBWaZluZxjZ70qvjqIqjFp3J1vzdyak=;
  b=k4JhrTVwEFVfo/SDh4HXqtFk9j1ZyPDtmHYzpOzdfK3siEvLWxFKHnwT
   +FhfZBz9EV1CYGySJt0OteD598eUO5REHH75ZRXzPHb/IQEjBTq8R7Gml
   4pLVPRC6nKgQpnYGPQeY769kUi5/pycmMe7Q1mE2el5S7Y8Fj0XwqQDQp
   B99s69/MbrVtACn5jGhN3jGnlRcrcxeYjVgJQfVJCQ0FMa2N2tz5xyQUY
   nATb5GcgzXIM6tmB0DfcWp5gb65QamlyDW6uNQp3LtV7KyV/sqoawzaCW
   f8uPWkjQJC9ofhguJ9sz/egBTbNyoo/dYCGf2R4y5p0ScIg1K1jwHFHW6
   w==;
X-CSE-ConnectionGUID: TlBthGLKS8mXhUffNsnOxw==
X-CSE-MsgGUID: /xM8dhTxRKe/JJMhpvmQTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16309319"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16309319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:30:24 -0700
X-CSE-ConnectionGUID: zx1tc17YQ/C6HqrYlFOBAQ==
X-CSE-MsgGUID: +pt+awAdRSSEmB7j5eQvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44111401"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 25 Jun 2024 07:30:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jun 2024 17:30:21 +0300
Date: Tue, 25 Jun 2024 17:30:21 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
Message-ID: <ZnrUfW2gj1fYWxf0@kuha.fi.intel.com>
References: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>

On Sun, Jun 23, 2024 at 12:35:11PM +0200, Javier Carrasco wrote:
> Use the scoped variant of `device_for_each_child_node()` to
> automatically handle early exits.
> 
> This prevents memory leaks if new error paths are introduced,
> as no explicit refcount decrement via `fwnode_handle_put()` is needed.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> This patch is a follow-up to the recently introduced commit c68942624e25
> ("usb: typec: ucsi: glink: fix child node release in probe function")
> to account for a safer approach to iterating over child nodes.
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 2fa973afe4e6..d41c9caa84e0 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -333,7 +333,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  	struct pmic_glink_ucsi *ucsi;
>  	struct device *dev = &adev->dev;
>  	const struct of_device_id *match;
> -	struct fwnode_handle *fwnode;
>  	int ret;
>  
>  	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
> @@ -365,14 +364,13 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  
>  	ucsi_set_drvdata(ucsi->ucsi, ucsi);
>  
> -	device_for_each_child_node(dev, fwnode) {
> +	device_for_each_child_node_scoped(dev, fwnode) {
>  		struct gpio_desc *desc;
>  		u32 port;
>  
>  		ret = fwnode_property_read_u32(fwnode, "reg", &port);
>  		if (ret < 0) {
>  			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> -			fwnode_handle_put(fwnode);
>  			return ret;
>  		}
>  
> @@ -387,11 +385,10 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  		if (!desc)
>  			continue;
>  
> -		if (IS_ERR(desc)) {
> -			fwnode_handle_put(fwnode);
> +		if (IS_ERR(desc))
>  			return dev_err_probe(dev, PTR_ERR(desc),
>  					     "unable to acquire orientation gpio\n");
> -		}
> +
>  		ucsi->port_orientation[port] = desc;
>  	}
>  
> 
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240623-ucsi_glink-scoped-2d417fc9afd3
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>

-- 
heikki

