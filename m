Return-Path: <linux-kernel+bounces-390631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7509B7C86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276AA1F21DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C101A0BDC;
	Thu, 31 Oct 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq2iJRwq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2D1A08CB;
	Thu, 31 Oct 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384032; cv=none; b=kAtTMXeecbIiJdo240qSMz6UZOSPnitcRHClcPEpmQMp5jGc1qRJ0IKhWO0ZnkepsLBFngMpUke6Hthb110vJAllD7D2C2rwijIHvjNODdSa9owf0i5jJOTtD4dD7bySccHhq8gPlEVBifEz2VgKn5a/i3TKSJeqTouG7weXfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384032; c=relaxed/simple;
	bh=JywwJxQVAHChhIAg5z61taueze37SO4nmFgRUU7ZM20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7d5uDUB6KzPq/pYINl4lXo9uvGdUqm7p5ZDQ6EZnVJqOb1ewULrtViXFxQPVlf60mnrRgojQ/H9l8X7Rue9DAttrUWyEpcGEO5jfYRZP6SlJzjtCATCkIiwRgBuOrrolK5e+E/Ps358hHYCtojp5Eqrc6KCe/VyZfXn+PJSlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq2iJRwq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730384031; x=1761920031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JywwJxQVAHChhIAg5z61taueze37SO4nmFgRUU7ZM20=;
  b=Iq2iJRwqlU+5BkiskNU10IFIfWc/yKTu0iYTag0hbKl/a0zjDVcHeAEc
   +0sOo4sTArB8B6Ej3+Joy1fCkRBKvBiWo1Wk1s20sSbbwnuzGc2zxlQnh
   VzODDs8tgme++iFtSfSXyYcDMLpzymNmif7vM96HRMEoTpdZaSsFT+MMW
   OzlpcSjZyIk5DnRjMbcD8IH9leDxapi8D52q1V59Tm6clFSIDMhLHcttM
   aUU0mJ4yjRjgmT2uiF3CXpP8fBgh39yd64O3QwtIBbJ6L1p3JCi30E9Nt
   gF6V+wk53ObJj1HnxvWrnnYTGhqY35sTuJrTNobEA9nL1md8JP6zC0U64
   A==;
X-CSE-ConnectionGUID: Q325GDvBQEu3s7VcMIgt9g==
X-CSE-MsgGUID: bGICj/CEROGSz6xdYnAKqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29893709"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29893709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:13:50 -0700
X-CSE-ConnectionGUID: cokTh+xrRbCvzQMsWs9UBQ==
X-CSE-MsgGUID: 4IscBYx1TneV2nt/7HIgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113425607"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 31 Oct 2024 07:13:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Oct 2024 16:13:44 +0200
Date: Thu, 31 Oct 2024 16:13:44 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] usb: typec: Only use SVID for matching altmodes
Message-ID: <ZyOQmEBubO1WG8a1@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>

On Wed, Oct 30, 2024 at 02:28:33PM -0700, Abhishek Pandit-Subedi wrote:
> Mode in struct typec_altmode is used to indicate the index of the
> altmode on a port, partner or plug. When searching for altmodes, it
> doesn't make sense to use the mode as a criteria since it could be any
> value depending on the enumeration order of the driver.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Update altmode_match to ignore mode entirely
> - Also apply the same behavior to typec_match
> 
>  drivers/usb/typec/bus.c   | 3 +--
>  drivers/usb/typec/class.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index aa879253d3b8..a5cb4bbb877d 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -454,8 +454,7 @@ static int typec_match(struct device *dev, const struct device_driver *driver)
>  	const struct typec_device_id *id;
>  
>  	for (id = drv->id_table; id->svid; id++)
> -		if (id->svid == altmode->svid &&
> -		    (id->mode == TYPEC_ANY_MODE || id->mode == altmode->mode))
> +		if (id->svid == altmode->svid)
>  			return 1;
>  	return 0;
>  }
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index bd41abceb050..85494b9f7502 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -237,7 +237,7 @@ static int altmode_match(struct device *dev, void *data)
>  	if (!is_typec_altmode(dev))
>  		return 0;
>  
> -	return ((adev->svid == id->svid) && (adev->mode == id->mode));
> +	return (adev->svid == id->svid);
>  }
>  
>  static void typec_altmode_set_partner(struct altmode *altmode)
> -- 
> 2.47.0.163.g1226f6d8fa-goog

-- 
heikki

