Return-Path: <linux-kernel+bounces-412854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B79D1036
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882F0B287AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43476198E77;
	Mon, 18 Nov 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1BjMiFA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53398190470;
	Mon, 18 Nov 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930595; cv=none; b=uwvSiF31Wkkp4H2lH4c30W03m0qcekqj+aaovWu30nNbKfDi1ErZzb43vQo3BKm1OwU1VS5AWlTEfB3uvJdoA6Biazn2SDjaWzocIDhP6KNgEo162dLzTkCYrnmhjf5lK1UGSZyO/tD5lBqfc8p9EvYVa7M+spR3VUhH+mzGGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930595; c=relaxed/simple;
	bh=y/shz7LJykfGzzvEzrrxF6u6icM67RlSI5at4T/ucJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWjv5rkGdiW6qpGI2mXM4m9kUdlTetteul6nMmVhdAz5td4K4lSIDNGW6TwuszvMo+bQlrfPdWEkzsc4euN/J1jCOIq6VLLM93xJhLVY2IvGQEontZGy/IyXcN0w+mN119kg6JMQp+kjTPD/mBA2MCkevfyLZpgx11RUq+ZXMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1BjMiFA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731930593; x=1763466593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/shz7LJykfGzzvEzrrxF6u6icM67RlSI5at4T/ucJY=;
  b=X1BjMiFAJFNumQrQSw2SPjI1+mrtjQqz+PRWbtam0DlG6iseR5ZOImzN
   S8D7Cffb9GI1ymxFy4W+JiPHcH5Kk/inAU+aW4hloKKW4qTlKfmPQS8Jh
   PS4MIZ/xs809M6Z0TU1vF4+4Wb2ogbDgUcMH2ljuoytd+UTAVLcJabt0U
   HvQxuu4qCE3MDw4mzKwCRO5ny+cCHQH8rcZNpWbvrhaX7MYRwLQuJvCA4
   cSqAHqaNoH42mQLjzxQIjQj2H2iUTfU2BFftcjBBcdmXj0cmyUcgS7OqK
   LYhjF7zZqS7sRtps7EkE1XRmXkSWtTwXjV/6d7tAAW82DZziTUJB4DZyQ
   Q==;
X-CSE-ConnectionGUID: bVs1VyvYRGqFSUIVhoXdAA==
X-CSE-MsgGUID: CVw8LPfDSTOEHYDXPLzkBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="32116551"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="32116551"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:49:48 -0800
X-CSE-ConnectionGUID: Y5q5JUYXRHqqdGh1UVCO2g==
X-CSE-MsgGUID: F8479wZnQm+mCm2oL3VcLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89602526"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 18 Nov 2024 03:49:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Nov 2024 13:49:44 +0200
Date: Mon, 18 Nov 2024 13:49:44 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Oliver Facklam <oliver.facklam@zuehlke.com>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benedict von Heyl <benedict.vonheyl@zuehlke.com>,
	Mathis Foerst <mathis.foerst@zuehlke.com>,
	Michael Glettig <michael.glettig@zuehlke.com>
Subject: Re: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Message-ID: <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>

Hi Oliver,

I'm sorry, I noticed a problem with this...

On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> The TI HD3SS3220 Type-C controller supports configuring the port type
> it will operate as through the MODE_SELECT field of the General
> Control Register.
> 
> Configure the port type based on the fwnode property "power-role"
> during probe, and through the port_type_set typec_operation.
> 
> The MODE_SELECT field can only be changed when the controller is in
> unattached state, so follow the sequence recommended by the datasheet to:
> 1. disable termination on CC pins to disable the controller
> 2. change the mode
> 3. re-enable termination
> 
> This will effectively cause a connected device to disconnect
> for the duration of the mode change.

Changing the type of the port is really problematic, and IMO we should
actually never support that.

Consider for example, if your port is sink only, then the platform
almost certainly can't drive the VBUS. This patch would still allow
the port to be changed to source port.

Sorry for not realising this in v1.

I think what you want here is just a power role swap. Currently power
role swap is only supported when USB PD is supported in the class
code, but since the USB Type-C specification quite clearly states that
power role and data role swap can be optionally supported even when
USB PD is not supported (section 2.3.3) we need to fix that:

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 58f40156de56..ee81909565a4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct device *dev,
                return -EOPNOTSUPP;
        }

-       if (port->pwr_opmode != TYPEC_PWR_MODE_PD) {
-               dev_dbg(dev, "partner unable to swap power role\n");
-               return -EIO;
-       }
-
        ret = sysfs_match_string(typec_roles, buf);
        if (ret < 0)
                return ret;


After that it should be possible to do power role swap also in this
driver when the port is DRP capable.

> Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> ---
>  drivers/usb/typec/hd3ss3220.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a01f311fb60b4284da 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -35,10 +35,16 @@
>  #define HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS		BIT(4)
>  
>  /* Register HD3SS3220_REG_GEN_CTRL*/
> +#define HD3SS3220_REG_GEN_CTRL_DISABLE_TERM		BIT(0)
>  #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK		(BIT(2) | BIT(1))
>  #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT	0x00
>  #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK	BIT(1)
>  #define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC	(BIT(2) | BIT(1))
> +#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_MASK		(BIT(5) | BIT(4))
> +#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DEFAULT	0x00
> +#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DFP		BIT(5)
> +#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_UFP		BIT(4)
> +#define HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DRP		(BIT(5) | BIT(4))
>  
>  struct hd3ss3220 {
>  	struct device *dev;
> @@ -75,6 +81,52 @@ static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opm
>  				  current_mode);
>  }
>  
> +static int hd3ss3220_set_port_type(struct hd3ss3220 *hd3ss3220, int type)
> +{
> +	int mode_select, err;
> +
> +	switch (type) {
> +	case TYPEC_PORT_SRC:
> +		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DFP;
> +		break;
> +	case TYPEC_PORT_SNK:
> +		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_UFP;
> +		break;
> +	case TYPEC_PORT_DRP:
> +		mode_select = HD3SS3220_REG_GEN_CTRL_MODE_SELECT_DRP;
> +		break;
> +	default:
> +		dev_err(hd3ss3220->dev, "bad port type: %d\n", type);
> +		return -EINVAL;
> +	}
> +
> +	/* Disable termination before changing MODE_SELECT as required by datasheet */
> +	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> +				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM,
> +				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM);
> +	if (err < 0) {
> +		dev_err(hd3ss3220->dev, "Failed to disable port for mode change: %d\n", err);
> +		return err;
> +	}
> +
> +	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> +				 HD3SS3220_REG_GEN_CTRL_MODE_SELECT_MASK,
> +				 mode_select);
> +	if (err < 0) {
> +		dev_err(hd3ss3220->dev, "Failed to change mode: %d\n", err);
> +		regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> +				   HD3SS3220_REG_GEN_CTRL_DISABLE_TERM, 0);
> +		return err;
> +	}
> +
> +	err = regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> +				 HD3SS3220_REG_GEN_CTRL_DISABLE_TERM, 0);
> +	if (err < 0)
> +		dev_err(hd3ss3220->dev, "Failed to re-enable port after mode change: %d\n", err);
> +
> +	return err;
> +}
> +
>  static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
>  {
>  	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port *port, enum typec_data_role role)
>  	return ret;
>  }
>  
> +static int hd3ss3220_port_type_set(struct typec_port *port, enum typec_port_type type)
> +{
> +	struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
> +
> +	return hd3ss3220_set_port_type(hd3ss3220, type);
> +}

This wrapper seems completely useless. You only need one function here
for the callback.

>  static const struct typec_operations hd3ss3220_ops = {
> -	.dr_set = hd3ss3220_dr_set
> +	.dr_set = hd3ss3220_dr_set,
> +	.port_type_set = hd3ss3220_port_type_set,
>  };

So here I think you should implement the pr_set callback instead.

Let me kwno wh

>  static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
> @@ -273,6 +333,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  	if (ret != 0 && ret != -EINVAL && ret != -ENXIO)
>  		goto err_put_role;
>  
> +	ret = hd3ss3220_set_port_type(hd3ss3220, typec_cap.type);
> +	if (ret < 0)
> +		goto err_put_role;
> +
>  	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
>  	if (IS_ERR(hd3ss3220->port)) {
>  		ret = PTR_ERR(hd3ss3220->port);
> 

thanks,

-- 
heikki

