Return-Path: <linux-kernel+bounces-333521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAE97CA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BA12848E5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2E19E83D;
	Thu, 19 Sep 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipDaxNfk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27F41746;
	Thu, 19 Sep 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752731; cv=none; b=MgBSIF6DSpcl51BY55+5FxlMKgq5G9PUaRjuPvL0F7OBuF2MKpwn6j4726zGd1HfDO0fPh1KYHI+FyY/taeBlOb/QjflzdC0jsDuV3HL7T8O4XZ+1G6zlMwBoO1wzm8MIUnYJ0Bk9DxVJKik31DAVddP8W11PXVS9EpjDyT0U1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752731; c=relaxed/simple;
	bh=Jb/anHTkXrSm6Yy5ZWeNGaJK5ig3ZketJSgS+6lhycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSNH/kz6jt5CHpihlSIPNoSowSu7Ubi7W09Rhhd9CNgV9ohWhGlNlAqTWHJOgfs4rBKhZN/O8zfhCD83ikTh6j/8y1VhwB2tNZIUGiX7Dtf/KZBzDRB/Hqsm43wuK5ZS0eYR9d3u2roJMp6/Wl2YPSWy0SObDbBHPVZrBnQMq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipDaxNfk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726752730; x=1758288730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jb/anHTkXrSm6Yy5ZWeNGaJK5ig3ZketJSgS+6lhycA=;
  b=ipDaxNfkUUUS+2IimCiC75cib3S3zAtyPyr4+cjfhpInDzApLoM0Ty8B
   HaBHFsmBChwkjKDGBn7vuQiPrVKyM8M+kDf/4LeGUnIU/ZIsCfqSx4e6s
   IcTjDWq4cICVAYzbdWB/b0RGYZAP0ALTEampZiziWXiovhx+qnKTUotHU
   Uk5SRQFCKEzjsr/tVaGeRMFyzH4XwNJkt6zCDZyBfUtfwdmz5WhlC4O3/
   5HD84FkPbXlCeKdZIWshjGsw8zrr8vuWiBa6O/A1LUys2GvVh5o2FRhca
   ktFXxmKK9ULzv+SoVXwJl30k3qUo2cum9fajcO4HKlLOaVm/o9v/0ASyL
   Q==;
X-CSE-ConnectionGUID: SjRyy696RguM1rqW99TJ2g==
X-CSE-MsgGUID: nGnHeR2rRsGhYtrvC3JgZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29503576"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="29503576"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 06:32:09 -0700
X-CSE-ConnectionGUID: jmcUUYSOS3yYs9z3kgbZvw==
X-CSE-MsgGUID: o6Xk+0DUSD2ZuBzvOwW7aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="74911348"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa004.jf.intel.com with SMTP; 19 Sep 2024 06:32:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Sep 2024 16:32:04 +0300
Date: Thu, 19 Sep 2024 16:32:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org,
	dmitry.baryshkov@linaro.org, badhri@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
Message-ID: <Zuwn1Fn1DrLGvPK9@kuha.fi.intel.com>
References: <20240919075120.328469-1-amitsd@google.com>
 <20240919075120.328469-3-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075120.328469-3-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:51:14AM -0700, Amit Sunil Dhamne wrote:
> Add support for DT time properties to allow users to define platform
> specific timing deadlines of certain timers rather than using hardcoded
> ones. For values that have not been explicitly defined in DT using this
> property, default values will be set therefore, making this change
> backward compatible.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4b02d6474259..e6c243bc44f7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -310,6 +310,17 @@ struct pd_data {
>  	unsigned int operating_snk_mw;
>  };
>  
> +/*
> + * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
> + * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
> + * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
> + */
> +struct pd_timings {
> +	u32 sink_wait_cap_time;
> +	u32 ps_src_off_time;
> +	u32 cc_debounce_time;
> +};
> +
>  struct tcpm_port {
>  	struct device *dev;
>  
> @@ -552,6 +563,9 @@ struct tcpm_port {
>  	 */
>  	unsigned int message_id_prime;
>  	unsigned int rx_msgid_prime;
> +
> +	/* Timer deadline values configured at runtime */
> +	struct pd_timings timings;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -4639,15 +4653,15 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SRC_ATTACH_WAIT:
>  		if (tcpm_port_is_debug(port))
>  			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
> -				       PD_T_CC_DEBOUNCE);
> +				       port->timings.cc_debounce_time);
>  		else if (tcpm_port_is_audio(port))
>  			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
> -				       PD_T_CC_DEBOUNCE);
> +				       port->timings.cc_debounce_time);
>  		else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
>  			tcpm_set_state(port,
>  				       tcpm_try_snk(port) ? SNK_TRY
>  							  : SRC_ATTACHED,
> -				       PD_T_CC_DEBOUNCE);
> +				       port->timings.cc_debounce_time);
>  		break;
>  
>  	case SNK_TRY:
> @@ -4698,7 +4712,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		}
>  		break;
>  	case SRC_TRYWAIT_DEBOUNCE:
> -		tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
> +		tcpm_set_state(port, SRC_ATTACHED, port->timings.cc_debounce_time);
>  		break;
>  	case SRC_TRYWAIT_UNATTACHED:
>  		tcpm_set_state(port, SNK_UNATTACHED, 0);
> @@ -4901,7 +4915,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		    (port->cc1 != TYPEC_CC_OPEN &&
>  		     port->cc2 == TYPEC_CC_OPEN))
>  			tcpm_set_state(port, SNK_DEBOUNCED,
> -				       PD_T_CC_DEBOUNCE);
> +				       port->timings.cc_debounce_time);
>  		else if (tcpm_port_is_disconnected(port))
>  			tcpm_set_state(port, SNK_UNATTACHED,
>  				       PD_T_PD_DEBOUNCE);
> @@ -4941,7 +4955,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_TRYWAIT:
>  		tcpm_set_cc(port, TYPEC_CC_RD);
> -		tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
> +		tcpm_set_state(port, SNK_TRYWAIT_VBUS, port->timings.cc_debounce_time);
>  		break;
>  	case SNK_TRYWAIT_VBUS:
>  		/*
> @@ -5014,7 +5028,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_DISCOVERY_DEBOUNCE:
>  		tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
> -			       PD_T_CC_DEBOUNCE);
> +			       port->timings.cc_debounce_time);
>  		break;
>  	case SNK_DISCOVERY_DEBOUNCE_DONE:
>  		if (!tcpm_port_is_disconnected(port) &&
> @@ -5041,10 +5055,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		if (port->vbus_never_low) {
>  			port->vbus_never_low = false;
>  			tcpm_set_state(port, SNK_SOFT_RESET,
> -				       PD_T_SINK_WAIT_CAP);
> +				       port->timings.sink_wait_cap_time);
>  		} else {
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> +				       port->timings.sink_wait_cap_time);
>  		}
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
> @@ -5066,7 +5080,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
>  			tcpm_set_state_cond(port, hard_reset_state(port), 0);
>  		else
> -			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
> +			tcpm_set_state(port, hard_reset_state(port),
> +				       port->timings.sink_wait_cap_time);
>  		break;
>  	case SNK_NEGOTIATE_CAPABILITIES:
>  		port->pd_capable = true;
> @@ -5203,7 +5218,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, ACC_UNATTACHED, 0);
>  		break;
>  	case AUDIO_ACC_DEBOUNCE:
> -		tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
> +		tcpm_set_state(port, ACC_UNATTACHED, port->timings.cc_debounce_time);
>  		break;
>  
>  	/* Hard_Reset states */
> @@ -5420,7 +5435,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, ERROR_RECOVERY, 0);
>  		break;
>  	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
> -		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
> +		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
>  		break;
>  	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
>  		if (port->vbus_source)
> @@ -5475,7 +5490,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_cc(port, TYPEC_CC_RD);
>  		/* allow CC debounce */
>  		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
> -			       PD_T_CC_DEBOUNCE);
> +			       port->timings.cc_debounce_time);
>  		break;
>  	case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
>  		/*
> @@ -5510,7 +5525,7 @@ static void run_state_machine(struct tcpm_port *port)
>  						       port->pps_data.active, 0);
>  		tcpm_set_charge(port, false);
>  		tcpm_set_state(port, hard_reset_state(port),
> -			       PD_T_PS_SOURCE_OFF);
> +			       port->timings.ps_src_off_time);
>  		break;
>  	case PR_SWAP_SNK_SRC_SOURCE_ON:
>  		tcpm_enable_auto_vbus_discharge(port, true);
> @@ -5666,7 +5681,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case PORT_RESET_WAIT_OFF:
>  		tcpm_set_state(port,
>  			       tcpm_default_state(port),
> -			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
> +			       port->vbus_present ? port->timings.ps_src_off_time : 0);
>  		break;
>  
>  	/* AMS intermediate state */
> @@ -6157,7 +6172,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>  	case SRC_ATTACH_WAIT:
>  		if (tcpm_port_is_source(port))
>  			tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY : SRC_ATTACHED,
> -				       PD_T_CC_DEBOUNCE);
> +				       port->timings.cc_debounce_time);
>  		break;
>  	case SRC_STARTUP:
>  	case SRC_SEND_CAPABILITIES:
> @@ -7053,6 +7068,35 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
>  	return ret;
>  }
>  
> +static int tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fwnode)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (!fwnode)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32(fwnode, "sink-wait-cap-time-ms", &val);
> +	if (!ret)
> +		port->timings.sink_wait_cap_time = val;
> +	else
> +		port->timings.sink_wait_cap_time = PD_T_SINK_WAIT_CAP;
> +
> +	ret = fwnode_property_read_u32(fwnode, "ps-source-off-time-ms", &val);
> +	if (!ret)
> +		port->timings.ps_src_off_time = val;
> +	else
> +		port->timings.ps_src_off_time = PD_T_PS_SOURCE_OFF;
> +
> +	ret = fwnode_property_read_u32(fwnode, "cc-debounce-time-ms", &val);
> +	if (!ret)
> +		port->timings.cc_debounce_time = val;
> +	else
> +		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
> +
> +	return 0;
> +}
> +
>  static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>  {
>  	struct fwnode_handle *capabilities, *child, *caps = NULL;
> @@ -7608,9 +7652,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	init_completion(&port->pps_complete);
>  	tcpm_debugfs_init(port);
>  
> +	err = tcpm_fw_get_timings(port, tcpc->fwnode);
> +	if (err < 0)
> +		goto out_destroy_wq;

This is somehow wrong. You are using default values in case of
failure, so this should not be a reason to fail port registration
under any circumstance. That function should just return void.

I would also just call it after tcpm_fw_get_caps() (or maybe even from
tcpm_fw_get_caps()), because tcpm_fw_get_caps() checks fwnode in any
case.

>  	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
> +
>  	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;

thanks,

-- 
heikki

