Return-Path: <linux-kernel+bounces-412676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E29D0DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4B1F21244
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF91922F1;
	Mon, 18 Nov 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTbwSX+r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8338F9C;
	Mon, 18 Nov 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924183; cv=none; b=T36Cps/g+KPxfs49t9YEXL0upZsQgTfjr+mgjeCvj9qLevNNIa2r6QXVTbiKN8aUPVQad6CewhXeFWHAcyC70EQpQTOmDzp6ge9XwxANtQ+bk2CcV2YJv3FN9kPSqbrvIGjfS9JthuIAaSLFWoNj+0fyKp5R79L6/uu4i+m4duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924183; c=relaxed/simple;
	bh=oZC1ed1sfLvebXHdVBfc8m0S/2K29wIF9TyDeHdhG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd5En+S3V2sq+kK0RA5s+eprDDJ8gz6kfMLLysY+kEY2K6KeLLoJ/UDrIMrO0FJQA6oV1xW40zF1vTuMsueMCPi6WRaRobBtYk+oPsTsRTNgM16cGJHqGQ5imMKmKZPlqN6dm3+CK+N2RaqKSYd5/Hkdm3tjgEAmeUGHvXeLW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTbwSX+r; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731924183; x=1763460183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oZC1ed1sfLvebXHdVBfc8m0S/2K29wIF9TyDeHdhG7Q=;
  b=KTbwSX+rK6j2g7UzWh8VOPTuXYRg9vCIqJvW/5b4Mg1AHNGDjCQ+z0JD
   3KyO5AowdP+Egp6Rq6k0WZ1m4NGLe/tmJcVLKPaGD5VF3nV+toAr4LtpG
   RZamGylVRwCDgjX5TH2u1vELWYX1tiG5CDqvBuDnUAO0TsFyyPuchIVQX
   5hUdotwgXUuGxlQmFd5T1MqYTYGnCL4AB4xoqjPlCvoiyJGfjlldsfP0D
   bMK0jFmvv07gxLOv8Fcj/FcaGw2TKkD4sb5w+GrFbB33uixGNsiP5ypgZ
   TzgnRU3Zpu+3cTMMaZTL5RJZouvNmnaqAPmKp4/EW7gZZXTurl9wLyyVM
   A==;
X-CSE-ConnectionGUID: 7DmdGUB7ScKNOC+6dY9X0A==
X-CSE-MsgGUID: zheAlziiR9SNeaoflb5b4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="32011209"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="32011209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:03:02 -0800
X-CSE-ConnectionGUID: JxIrzfjvQU+VJaOBLt3W5A==
X-CSE-MsgGUID: AjZ+8XJHTTaY0MXTMmzA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89593924"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 18 Nov 2024 02:02:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Nov 2024 12:02:57 +0200
Date: Mon, 18 Nov 2024 12:02:57 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Oliver Facklam <oliver.facklam@zuehlke.com>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benedict von Heyl <benedict.vonheyl@zuehlke.com>,
	Mathis Foerst <mathis.foerst@zuehlke.com>,
	Michael Glettig <michael.glettig@zuehlke.com>
Subject: Re: [PATCH v2 1/4] usb: typec: hd3ss3220: configure advertised power
 opmode based on fwnode property
Message-ID: <ZzsQ0QeFS6qWdHd6@kuha.fi.intel.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-1-362376856aea@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-usb-typec-controller-enhancements-v2-1-362376856aea@zuehlke.com>

On Thu, Nov 14, 2024 at 09:02:06AM +0100, Oliver Facklam wrote:
> The TI HD3SS3220 Type-C controller supports configuring its advertised
> power operation mode over I2C using the CURRENT_MODE_ADVERTISE field
> of the Connection Status Register.
> 
> Configure this power mode based on the existing (optional) property
> "typec-power-opmode" of /schemas/connector/usb-connector.yaml
> 
> Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/hd3ss3220.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index fb1242e82ffdc64a9a3330f50155bb8f0fe45685..56f74bf70895ca701083bde44a5bbe0b691551e1 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -16,10 +16,17 @@
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
>  
> +#define HD3SS3220_REG_CN_STAT		0x08
>  #define HD3SS3220_REG_CN_STAT_CTRL	0x09
>  #define HD3SS3220_REG_GEN_CTRL		0x0A
>  #define HD3SS3220_REG_DEV_REV		0xA0
>  
> +/* Register HD3SS3220_REG_CN_STAT */
> +#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_MASK		(BIT(7) | BIT(6))
> +#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_DEFAULT	0x00
> +#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_MID		BIT(6)
> +#define HD3SS3220_REG_CN_STAT_CURRENT_MODE_HIGH		BIT(7)
> +
>  /* Register HD3SS3220_REG_CN_STAT_CTRL*/
>  #define HD3SS3220_REG_CN_STAT_CTRL_ATTACHED_STATE_MASK	(BIT(7) | BIT(6))
>  #define HD3SS3220_REG_CN_STAT_CTRL_AS_DFP		BIT(6)
> @@ -43,6 +50,31 @@ struct hd3ss3220 {
>  	bool poll;
>  };
>  
> +static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> +{
> +	int current_mode;
> +
> +	switch (power_opmode) {
> +	case TYPEC_PWR_MODE_USB:
> +		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_DEFAULT;
> +		break;
> +	case TYPEC_PWR_MODE_1_5A:
> +		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_MID;
> +		break;
> +	case TYPEC_PWR_MODE_3_0A:
> +		current_mode = HD3SS3220_REG_CN_STAT_CURRENT_MODE_HIGH;
> +		break;
> +	case TYPEC_PWR_MODE_PD: /* Power delivery not supported */
> +	default:
> +		dev_err(hd3ss3220->dev, "bad power operation mode: %d\n", power_opmode);
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT,
> +				  HD3SS3220_REG_CN_STAT_CURRENT_MODE_MASK,
> +				  current_mode);
> +}
> +
>  static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
>  {
>  	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
> @@ -162,6 +194,23 @@ static irqreturn_t hd3ss3220_irq_handler(int irq, void *data)
>  	return hd3ss3220_irq(hd3ss3220);
>  }
>  
> +static int hd3ss3220_configure_power_opmode(struct hd3ss3220 *hd3ss3220,
> +					    struct fwnode_handle *connector)
> +{
> +	/*
> +	 * Supported power operation mode can be configured through device tree
> +	 */
> +	const char *cap_str;
> +	int ret, power_opmode;
> +
> +	ret = fwnode_property_read_string(connector, "typec-power-opmode", &cap_str);
> +	if (ret)
> +		return 0;
> +
> +	power_opmode = typec_find_pwr_opmode(cap_str);
> +	return hd3ss3220_set_power_opmode(hd3ss3220, power_opmode);
> +}
> +
>  static const struct regmap_config config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -223,6 +272,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  		goto err_put_role;
>  	}
>  
> +	ret = hd3ss3220_configure_power_opmode(hd3ss3220, connector);
> +	if (ret < 0)
> +		goto err_unreg_port;
> +
>  	hd3ss3220_set_role(hd3ss3220);
>  	ret = regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL, &data);
>  	if (ret < 0)
> 
> -- 
> 2.34.1

-- 
heikki

