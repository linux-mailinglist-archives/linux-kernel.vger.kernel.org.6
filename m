Return-Path: <linux-kernel+bounces-401604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895939C1CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEF1B23DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8D1E7C06;
	Fri,  8 Nov 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuCzlnJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D211E47C0;
	Fri,  8 Nov 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068477; cv=none; b=Ydk2WjI1Gaz3xpWNIjcshvpp8rCme1jnaqGX/nPfwsgAZZSW/KoJpk8VMHuqBFq04+px+hG55qf+//q7A+QBSXhhHVOWL4ACODYpQVgbtkwIE4NsK6pSbqNQ7UTj6+y7oUO/WqkKRL4ciC1gtljcRn6xWXFmdaF+4Stba0c94qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068477; c=relaxed/simple;
	bh=u0iXnKguoLXCt/Mm6UWe8peTQ8LV485EgYB6XyhyzXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSy2FpGYNw7o5DJcR0PIlR9NjeMXnkfV2ga3yr41CBc4Q81vTQBbobGD0Y+E9O+ks/NpN9b2NbCIzhWbtLR/yom7gvCiy15WQVRtbsAQxGR0f4PO9JOw7R0nactpNDLjnWmHcHy3gthuuK50Q95GMttBVrHfkcCwImO1w/wO6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuCzlnJu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068476; x=1762604476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0iXnKguoLXCt/Mm6UWe8peTQ8LV485EgYB6XyhyzXQ=;
  b=EuCzlnJuhRbMmS4i0NZyO3URV7lQ8HRVoCFiOcaDwQTaRIq1TbbmeTtm
   v6edNYwnjCosZuukTkStn3yLJt4Yz5uKL+pNj89kI/hsDqBeiEQmywrAU
   jeET4F5vBwC5AO+DKsnVGwqt+6/WH7UfOcUAT9GKNHHkiBBZo/yXg4Ngk
   +lUQEtLyvOeiPQKpiGS71trYH9N9ZXZat43VBeVenf2i1Q6FzYUlGD7EP
   6kvIdM+6/Q4aKHlh5nydp97szRAiWjvwd1WiV6ycjfrYSOo2z0M3y12QE
   C2qIXNS92w1v1NRtsgh/zO1Q0oJSe8HANODRccZmTDczhssSD4dbF3dPJ
   A==;
X-CSE-ConnectionGUID: +TUqelrQQKOENZVkupxOCg==
X-CSE-MsgGUID: vSkkWlJ+R6+2EG+DGO5Iig==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30347529"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="30347529"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:21:15 -0800
X-CSE-ConnectionGUID: VwFY/ZnXSx+CRNEC01ZXOw==
X-CSE-MsgGUID: B5nmX/3bQoGbpciJqcmtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90350922"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 08 Nov 2024 04:21:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Nov 2024 14:21:10 +0200
Date: Fri, 8 Nov 2024 14:21:10 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, jthies@google.com,
	akuchynski@google.com, pmalani@chromium.org,
	dmitry.baryshkov@linaro.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] usb: typec: Check port is active before enter
 mode on probe
Message-ID: <Zy4CNtSDjbPTcCcI@kuha.fi.intel.com>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107112955.v3.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>

On Thu, Nov 07, 2024 at 11:29:56AM -0800, Abhishek Pandit-Subedi wrote:
> Enforce the same requirement as when we attempt to activate altmode via
> sysfs (do not enter partner mode if port mode is not active). In order
> to set a default value for this field, also introduce the inactive field
> in struct typec_altmode_desc.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Use port.active instead of introducing auto-enter field
> - Introduce inactive field to typec_altmode_desc to set default value
>   for active.
> - Always make port 'active' field writable
> 
>  drivers/usb/typec/altmodes/displayport.c | 7 +++++--
>  drivers/usb/typec/altmodes/thunderbolt.c | 6 +++++-
>  drivers/usb/typec/class.c                | 5 +++--
>  include/linux/usb/typec.h                | 2 ++
>  4 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 3245e03d59e6..f4116e96f6a1 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -767,8 +767,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	if (plug)
>  		typec_altmode_set_drvdata(plug, dp);
>  
> -	dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
> -	schedule_work(&dp->work);
> +	/* Only attempt to enter altmode if port is active. */
> +	if (port->active) {
> +		dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
> +		schedule_work(&dp->work);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
> index a945b9d35a1d..45567abc3bb8 100644
> --- a/drivers/usb/typec/altmodes/thunderbolt.c
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -212,6 +212,7 @@ static const struct typec_altmode_ops tbt_altmode_ops = {
>  
>  static int tbt_altmode_probe(struct typec_altmode *alt)
>  {
> +	const struct typec_altmode *port = typec_altmode_get_partner(alt);
>  	struct tbt_altmode *tbt;
>  
>  	tbt = devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
> @@ -226,7 +227,10 @@ static int tbt_altmode_probe(struct typec_altmode *alt)
>  	typec_altmode_set_drvdata(alt, tbt);
>  	typec_altmode_set_ops(alt, &tbt_altmode_ops);
>  
> -	if (tbt_ready(alt)) {
> +	/* Only attempt to enter altmode if port is active and cable/plug
> +	 * information is ready.
> +	 */
> +	if (port->active && tbt_ready(alt)) {
>  		if (tbt->plug[TYPEC_PLUG_SOP_PP])
>  			tbt->state = TBT_STATE_SOP_PP_ENTER;
>  		else if (tbt->plug[TYPEC_PLUG_SOP_P])
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index febe453b96be..b5e67a57762c 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -458,7 +458,8 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
>  
>  	if (attr == &dev_attr_active.attr)
> -		if (!adev->ops || !adev->ops->activate)
> +		if (!is_typec_port(adev->dev.parent) &&
> +		    (!adev->ops || !adev->ops->activate))
>  			return 0444;
>  
>  	return attr->mode;
> @@ -563,7 +564,7 @@ typec_register_altmode(struct device *parent,
>  
>  	if (is_port) {
>  		alt->attrs[3] = &dev_attr_supported_roles.attr;
> -		alt->adev.active = true; /* Enabled by default */
> +		alt->adev.active = !desc->inactive; /* Enabled by default */
>  	}
>  
>  	sprintf(alt->group_name, "mode%d", desc->mode);
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index d616b8807000..56c01771c190 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -140,6 +140,7 @@ int typec_cable_set_identity(struct typec_cable *cable);
>   * @mode: Index of the Mode
>   * @vdo: VDO returned by Discover Modes USB PD command
>   * @roles: Only for ports. DRP if the mode is available in both roles
> + * @inactive: Only for ports. Make this port inactive (default is active).
>   *
>   * Description of an Alternate Mode which a connector, cable plug or partner
>   * supports.
> @@ -150,6 +151,7 @@ struct typec_altmode_desc {
>  	u32			vdo;
>  	/* Only used with ports */
>  	enum typec_port_data	roles;
> +	bool			inactive : 1;
>  };
>  
>  void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);
> -- 
> 2.47.0.277.g8800431eea-goog

-- 
heikki

