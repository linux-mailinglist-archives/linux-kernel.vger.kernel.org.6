Return-Path: <linux-kernel+bounces-447120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1E9F2DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27C31883837
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CB20126C;
	Mon, 16 Dec 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxqfXanT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0F433B1;
	Mon, 16 Dec 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343257; cv=none; b=fhGtFrWLbxrZ/+UpP+U1f+X3nW2EdBPkPLNZeE/liRyoTr7F6Mn4zN8/EbruR2aUWe3r+6n+tnTrWMidbspaBEJkPR/fCBg/KxJ5I3KkbE0LquRVmNxuXjUVRAX0DckQ7zCKt7bCuA291hoIXbLl+tOcUveuaIQzk6hc8hCeG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343257; c=relaxed/simple;
	bh=VjW2fuhwgVhl6Ghu0BCFNxELi/ct5mDSDMDHO8NZWRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0DdOOrxEsTJZ9bHd72zKKHTj8Ip+NpcwnHodgOSChbfX//4Obj8xNxjI6g34kFZJeYwCyh8dyM7dgHMxstn90A5irHVuftn9BQQFyLlQh+/E85iR8O74a2K0TmXjuumrspy+c1Tbs24/5rgNYBsfZL9+wpQctOOJW3CVX5zLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxqfXanT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734343256; x=1765879256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VjW2fuhwgVhl6Ghu0BCFNxELi/ct5mDSDMDHO8NZWRk=;
  b=HxqfXanTU3SdYXOoo/pBagDB8RvU2XVDDBP+voNnPhxdtIZPruBxjA6B
   6Lz7+PQWAAMVfKJVe3zfg76Jfc74XAdm06sbWYU0YbN3bYwzxtmaWt8ot
   Va2qmJYYfssQq6zOLmjSnS1NreMdPqOy2fVN96h2aU5E1eFgGXWzBFuHR
   wcyXw1YM+QVavIUds6fpuUlJO/XifEPghMsFwxyd6BU0kWW8xzvo21rBR
   XUADsf5zh5ZZn6mgz+tvoj4U819xkjkvtn80jmVJwJinoHXT88HN5YBuN
   +szwzAFL+y+3Ta8xtT//h0pmwIuabQAf6snrYONEAxKPp3ZBnf6TeCYHD
   g==;
X-CSE-ConnectionGUID: 74HcnFG0RNq3BNabhQZQLg==
X-CSE-MsgGUID: yy1vsAy3RW6FRNPUkJEhHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="57203515"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="57203515"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 02:00:55 -0800
X-CSE-ConnectionGUID: o/AQbDNyTXC6hFGPHvCutg==
X-CSE-MsgGUID: 6DaYNTQITLOQ+0F6jfiyIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97023132"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa007.fm.intel.com with SMTP; 16 Dec 2024 02:00:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 16 Dec 2024 12:00:50 +0200
Date: Mon, 16 Dec 2024 12:00:50 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Oliver Facklam <oliver.facklam@zuehlke.com>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benedict von Heyl <benedict.vonheyl@zuehlke.com>,
	Mathis Foerst <mathis.foerst@zuehlke.com>,
	Michael Glettig <michael.glettig@zuehlke.com>
Subject: Re: [PATCH v3 3/3] usb: typec: hd3ss3220: support configuring role
 preference based on fwnode property and typec_operation
Message-ID: <Z1_6UiUEbFUorP0j@kuha.fi.intel.com>
References: <20241211-usb-typec-controller-enhancements-v3-0-e4bc1b6e1441@zuehlke.com>
 <20241211-usb-typec-controller-enhancements-v3-3-e4bc1b6e1441@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-usb-typec-controller-enhancements-v3-3-e4bc1b6e1441@zuehlke.com>

On Wed, Dec 11, 2024 at 05:32:47PM +0100, Oliver Facklam wrote:
> The TI HD3SS3220 Type-C controller supports configuring
> its role preference when operating as a dual-role port
> through the SOURCE_PREF field of the General Control Register.
> 
> The previous driver behavior was to set the role preference
> based on the dr_set typec_operation.
> However, the controller does not support swapping the data role
> on an active connection due to its lack of Power Delivery support.
> 
> Remove previous dr_set typec_operation, and support setting
> the role preference based on the corresponding fwnode property,
> as well as the try_role typec_operation.
> 
> Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/hd3ss3220.c | 72 ++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index e2059b925ab15733ff097e940751759ed51e0ab3..3ecc688dda82a371929e204a490a68c8e9d81fe9 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -127,8 +127,25 @@ static int hd3ss3220_set_port_type(struct hd3ss3220 *hd3ss3220, int type)
>  	return err;
>  }
>  
> -static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
> +static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int prefer_role)
>  {
> +	int src_pref;
> +
> +	switch (prefer_role) {
> +	case TYPEC_NO_PREFERRED_ROLE:
> +		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT;
> +		break;
> +	case TYPEC_SINK:
> +		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK;
> +		break;
> +	case TYPEC_SOURCE:
> +		src_pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC;
> +		break;
> +	default:
> +		dev_err(hd3ss3220->dev, "bad role preference: %d\n", prefer_role);
> +		return -EINVAL;
> +	}
> +
>  	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
>  				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK,
>  				  src_pref);
> @@ -160,27 +177,11 @@ static enum usb_role hd3ss3220_get_attached_state(struct hd3ss3220 *hd3ss3220)
>  	return attached_state;
>  }
>  
> -static int hd3ss3220_dr_set(struct typec_port *port, enum typec_data_role role)
> +static int hd3ss3220_try_role(struct typec_port *port, int role)
>  {
>  	struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
> -	enum usb_role role_val;
> -	int pref, ret = 0;
>  
> -	if (role == TYPEC_HOST) {
> -		role_val = USB_ROLE_HOST;
> -		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC;
> -	} else {
> -		role_val = USB_ROLE_DEVICE;
> -		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK;
> -	}
> -
> -	ret = hd3ss3220_set_source_pref(hd3ss3220, pref);
> -	usleep_range(10, 100);
> -
> -	usb_role_switch_set_role(hd3ss3220->role_sw, role_val);
> -	typec_set_data_role(hd3ss3220->port, role);
> -
> -	return ret;
> +	return hd3ss3220_set_source_pref(hd3ss3220, role);
>  }
>  
>  static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type type)
> @@ -191,7 +192,7 @@ static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type
>  }
>  
>  static const struct typec_operations hd3ss3220_ops = {
> -	.dr_set = hd3ss3220_dr_set,
> +	.try_role = hd3ss3220_try_role,
>  	.port_type_set = hd3ss3220_port_type_set,
>  };
>  
> @@ -200,9 +201,6 @@ static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
>  	enum usb_role role_state = hd3ss3220_get_attached_state(hd3ss3220);
>  
>  	usb_role_switch_set_role(hd3ss3220->role_sw, role_state);
> -	if (role_state == USB_ROLE_NONE)
> -		hd3ss3220_set_source_pref(hd3ss3220,
> -				HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
>  
>  	switch (role_state) {
>  	case USB_ROLE_HOST:
> @@ -293,6 +291,28 @@ static int hd3ss3220_configure_port_type(struct hd3ss3220 *hd3ss3220,
>  	return hd3ss3220_set_port_type(hd3ss3220, cap->type);
>  }
>  
> +static int hd3ss3220_configure_source_pref(struct hd3ss3220 *hd3ss3220,
> +					   struct fwnode_handle *connector,
> +					   struct typec_capability *cap)
> +{
> +	/*
> +	 * Preferred role can be configured through device tree
> +	 */
> +	const char *cap_str;
> +	int ret;
> +
> +	ret = fwnode_property_read_string(connector, "try-power-role", &cap_str);
> +	if (ret)
> +		return 0;
> +
> +	ret = typec_find_power_role(cap_str);
> +	if (ret < 0)
> +		return ret;
> +
> +	cap->prefer_role = ret;
> +	return hd3ss3220_set_source_pref(hd3ss3220, cap->prefer_role);
> +}
> +
>  static const struct regmap_config config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -319,8 +339,6 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  	if (IS_ERR(hd3ss3220->regmap))
>  		return PTR_ERR(hd3ss3220->regmap);
>  
> -	hd3ss3220_set_source_pref(hd3ss3220,
> -				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
>  	/* For backward compatibility check the connector child node first */
>  	connector = device_get_named_child_node(hd3ss3220->dev, "connector");
>  	if (connector) {
> @@ -348,6 +366,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  	typec_cap.ops = &hd3ss3220_ops;
>  	typec_cap.fwnode = connector;
>  
> +	ret = hd3ss3220_configure_source_pref(hd3ss3220, connector, &typec_cap);
> +	if (ret < 0)
> +		goto err_put_role;
> +
>  	ret = hd3ss3220_configure_port_type(hd3ss3220, connector, &typec_cap);
>  	if (ret < 0)
>  		goto err_put_role;
> 
> -- 
> 2.34.1

-- 
heikki

