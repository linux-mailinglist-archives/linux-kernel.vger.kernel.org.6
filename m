Return-Path: <linux-kernel+bounces-400084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B839C08C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6BC1F22F32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487C21265A;
	Thu,  7 Nov 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9gRiJXZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0D20F5DC;
	Thu,  7 Nov 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989267; cv=none; b=OWvudi8oxX0wkOHPKBSRB4iOM24bvVSHGkIt2qjY9VwVbplEUs/IF0jGUayivA1Vp0rrWAVqDaov39Y5rKNTTeGS/jPbnTULJdmau2YX8s3V+UaRwMaPpIyozygi86lKdYy8phBzU5qMxgvKyhqzIf7PIWgTfs+7Ytdt1Pzeeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989267; c=relaxed/simple;
	bh=IEVwxSRNKA4Yn8NRHtPqnLyaZV9KG+cxBfFjKW7vWaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6H6d7VE2NBEJ1KZaHjoXHZC14IUhlbKH9cKl3ulV6Lum0dEQxU2Lz2M1A4Af+f/0z9DxC/IL0Pt6sOLz+RgL1muNwsR3jWZOyYs3BLY/bf/EgNAjLFXhmdqvPrDmjN5vHlXQXotlIBawa3WENQUZ1v5R7fcql8Ek99G5EIr4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9gRiJXZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730989265; x=1762525265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IEVwxSRNKA4Yn8NRHtPqnLyaZV9KG+cxBfFjKW7vWaI=;
  b=M9gRiJXZhq9GccQ2nxoXx5KY56SNh1j1MnCo+uAhGH8wH8qAVjjG3jnL
   Qm0c3m+N3OtoH5cOyPu5rK88QDNrMo12H0CoZEQs4cmqwvdUskqtjtlNu
   Ifg8HehiPFlVFCQ64+785CNk+hbqn30kVUs0LHj7Bizn0ednmHea/4wQG
   iH9pbh0Z2WUO7/9Kxqmr3E42rWLGu4hDMruLZezfK5PCsWA1Nvat4y5h1
   02ymskDRpUS/BkE35Wr2K5beFuUqgsgZF38zUEf8lLU4k3iLwXPxCQauJ
   5rIH4ys4IIwKcDk8GewP8mUN1WnwAbPtnD4bLoY3oRunynggQotKI1whF
   g==;
X-CSE-ConnectionGUID: Tnz9CFBtQJqK5OUA7dx12A==
X-CSE-MsgGUID: 7qMxSG8HTJSlmEjyaWF8SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30994232"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30994232"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:21:04 -0800
X-CSE-ConnectionGUID: 1WTeQjKRRqGXF8bMqueftQ==
X-CSE-MsgGUID: 3lzMI0LjRA6P0gjsBcUeWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="85901770"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 07 Nov 2024 06:21:02 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Nov 2024 16:21:00 +0200
Date: Thu, 7 Nov 2024 16:21:00 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: oliver.facklam@zuehlke.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benedict von Heyl <benedict.vonheyl@zuehlke.com>,
	Mathis Foerst <mathis.foerst@zuehlke.com>,
	Michael Glettig <michael.glettig@zuehlke.com>
Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to
 fill typec_cap
Message-ID: <ZyzMzEHA9DPMc_z9@kuha.fi.intel.com>
References: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
 <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>

Hi Oliver,

On Thu, Nov 07, 2024 at 12:43:28PM +0100, Oliver Facklam via B4 Relay wrote:
> From: Oliver Facklam <oliver.facklam@zuehlke.com>
> 
> The type, data, and prefer_role properties were previously hard-coded
> when creating the struct typec_capability.
> 
> Use typec_get_fw_cap() to populate these fields based on the
> respective fwnode properties.
> 
> Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> ---
>  drivers/usb/typec/hd3ss3220.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 56f74bf70895ca701083bde44a5bbe0b691551e1..e6e4b1871b5d805f8c367131509f4e6ec0d2b5f0 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -259,12 +259,12 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  		goto err_put_fwnode;
>  	}
>  
> -	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +	ret = typec_get_fw_cap(&typec_cap, connector);
> +	if (ret)
> +		goto err_put_role;

You are not leaving any fallback here. Are you sure all the existing
systems supply those properties?

There is another problem. At least "data-role" property is optional,
but that will in practice make it a requirement.

I think it would be safer to use the values from the device properties
only if they are available. Otherwise simply use default values.

>  	typec_cap.driver_data = hd3ss3220;
> -	typec_cap.type = TYPEC_PORT_DRP;
> -	typec_cap.data = TYPEC_PORT_DRD;
>  	typec_cap.ops = &hd3ss3220_ops;
> -	typec_cap.fwnode = connector;
>  
>  	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
>  	if (IS_ERR(hd3ss3220->port)) {

thanks,

-- 
heikki

