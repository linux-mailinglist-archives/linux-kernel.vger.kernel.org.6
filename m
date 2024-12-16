Return-Path: <linux-kernel+bounces-447115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462999F2D88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF966164347
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8920371A;
	Mon, 16 Dec 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0R82nCP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CB202C26;
	Mon, 16 Dec 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342981; cv=none; b=YtAK/bQ39dnOy8ieOVzQ7/03ohx/SYxEh0L7+MIv2oGgYDGSnDWSGUEf7zqZr0KHUscOCt02x7DcFyFRF0sOXkx9oD6ZV0Ybuiv13kXcdCR28QGvyqaEwYs8v72sGKk4EYFLbftFxi2Ct6TfPzXMxjfsAfMKmOMX3VWxtr6i9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342981; c=relaxed/simple;
	bh=pIHZqEF0neNxwQmxNhxbje5qYNAonKyqllihe15PubY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL3RwXOk7S2rnblMdzLqW139MqRaz4n0bb4uXdKNMn6Nm8EfuiXrl84pRrr16iJnqOYS0NMiPLjVVA2MNYWDwnR7JUs17x010Smrfffzw5tLPZwgB4yEcHpcSSd2Kz87/WneWQPCnClAoLwP3KdnQxiihbyYaHgkufZESm5AERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0R82nCP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734342981; x=1765878981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIHZqEF0neNxwQmxNhxbje5qYNAonKyqllihe15PubY=;
  b=b0R82nCP3JanYWvUcJ2vtM4yXkKZqo2wrNceFfK8TTRQtLyq+HUY1hbX
   zvlx6MrymQdk1BIBg5MYfxQZ1+RHnFvdd12Cb4caNQWLD5sFsMMeBfE6F
   H3EN65OrUzf/8/yG4cumpYTFor9V7MJ0GQNRfaC8kGUwWJk/eXAcSXNjq
   QvXd4yRejqAb1fpmEHli76ZE4szn56JFmiYuXeGLbMU9SElZ+zZZDwfg9
   JBI1mSrnWULVfAcKq9TzFBdaHwKwpmfNkiGVE+r/vIcrUns/EWVNe5Rvc
   EsaHPY9r3xLM3FB6Oh6pcuii4W3My3DGz3ZQkwbWD0DsfeF3ivlFzSkBO
   g==;
X-CSE-ConnectionGUID: wUXdMzAdSBCD/A6GMJYtjw==
X-CSE-MsgGUID: CflIntkaQh+bApn6lbwcAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="38494984"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="38494984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 01:56:20 -0800
X-CSE-ConnectionGUID: 9pLqZCk2Rn6Y4x7MS4Wywg==
X-CSE-MsgGUID: rTBh1KIHRW6JqEqk5x/VWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97951755"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 16 Dec 2024 01:56:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 16 Dec 2024 11:56:15 +0200
Date: Mon, 16 Dec 2024 11:56:15 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Oliver Facklam <oliver.facklam@zuehlke.com>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benedict von Heyl <benedict.vonheyl@zuehlke.com>,
	Mathis Foerst <mathis.foerst@zuehlke.com>,
	Michael Glettig <michael.glettig@zuehlke.com>
Subject: Re: [PATCH v3 2/3] usb: typec: hd3ss3220: support configuring port
 type
Message-ID: <Z1_5P2zZJBm7Nzut@kuha.fi.intel.com>
References: <20241211-usb-typec-controller-enhancements-v3-0-e4bc1b6e1441@zuehlke.com>
 <20241211-usb-typec-controller-enhancements-v3-2-e4bc1b6e1441@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-usb-typec-controller-enhancements-v3-2-e4bc1b6e1441@zuehlke.com>

On Wed, Dec 11, 2024 at 05:32:46PM +0100, Oliver Facklam wrote:
> The TI HD3SS3220 Type-C controller supports configuring the port type
> it will operate as through the MODE_SELECT field of the General
> Control Register.
> 
> Configure the port type based on the fwnode property "power-role"
> during probe, if present. If the property is absent, leave the
> operation mode at the default, which is defined by the PORT pin
> of the chip.
> Support configuring the port type through the port_type_set
> typec_operation as well.
> 
> The MODE_SELECT field can only be changed when the controller is in
> unattached state, so follow the sequence recommended by the datasheet to:
> 1. disable termination on CC pins to disable the controller
> 2. change the mode
> 3. re-enable termination
> 
> This will effectively cause a connected device to disconnect
> for the duration of the mode change.
> 
> Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/hd3ss3220.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 56f74bf70895ca701083bde44a5bbe0b691551e1..e2059b925ab15733ff097e940751759ed51e0ab3 100644
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
> +
>  static const struct typec_operations hd3ss3220_ops = {
> -	.dr_set = hd3ss3220_dr_set
> +	.dr_set = hd3ss3220_dr_set,
> +	.port_type_set = hd3ss3220_port_type_set,
>  };
>  
>  static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
> @@ -211,6 +271,28 @@ static int hd3ss3220_configure_power_opmode(struct hd3ss3220 *hd3ss3220,
>  	return hd3ss3220_set_power_opmode(hd3ss3220, power_opmode);
>  }
>  
> +static int hd3ss3220_configure_port_type(struct hd3ss3220 *hd3ss3220,
> +					 struct fwnode_handle *connector,
> +					 struct typec_capability *cap)
> +{
> +	/*
> +	 * Port type can be configured through device tree
> +	 */
> +	const char *cap_str;
> +	int ret;
> +
> +	ret = fwnode_property_read_string(connector, "power-role", &cap_str);
> +	if (ret)
> +		return 0;
> +
> +	ret = typec_find_port_power_role(cap_str);
> +	if (ret < 0)
> +		return ret;
> +
> +	cap->type = ret;
> +	return hd3ss3220_set_port_type(hd3ss3220, cap->type);
> +}
> +
>  static const struct regmap_config config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -266,6 +348,10 @@ static int hd3ss3220_probe(struct i2c_client *client)
>  	typec_cap.ops = &hd3ss3220_ops;
>  	typec_cap.fwnode = connector;
>  
> +	ret = hd3ss3220_configure_port_type(hd3ss3220, connector, &typec_cap);
> +	if (ret < 0)
> +		goto err_put_role;
> +
>  	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
>  	if (IS_ERR(hd3ss3220->port)) {
>  		ret = PTR_ERR(hd3ss3220->port);
> 
> -- 
> 2.34.1

-- 
heikki

