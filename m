Return-Path: <linux-kernel+bounces-198969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16D8D7FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9118B2858A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29982885;
	Mon,  3 Jun 2024 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0+QHCsi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4D7FBA3;
	Mon,  3 Jun 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409587; cv=none; b=Q7yS3IyryNTwHuqbybnql3XFMe+Iuouce96J6gaNFhXiEmhTv9G8PAPugFBRGI0Et7KRIzKxg8b8lnZK4y89IjHxEiSxPwi+tLplJgjX8rgYlmnxBEhOfxUTLbzAOWSXNLijqtr1myrKXoSBxMuj6+omqg4IqeqPwLUasFp9wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409587; c=relaxed/simple;
	bh=N4oZOeI5QrjgnGp3SssH8o31kJ57VtQSEiQ2DCumK4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRGQ+1dzpKm1ODEIhZ8/ObMe7gcqFGS9c9JZVDB/PNxNwxo5WKUi0nQhA//r9gfTetTHA2fTujn9J2DIBFuCI4X5zV8rW4vzIGIfkTiCB2Y19o6eyikvgCJSBSnPzChn3DZxg03w2dsrJ92JbXQgBh1mKGL5PNuPEcIkpmKvoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0+QHCsi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717409585; x=1748945585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4oZOeI5QrjgnGp3SssH8o31kJ57VtQSEiQ2DCumK4M=;
  b=B0+QHCsi9b3GoakD1GxVMkVF7FVm+A/3Jvv9aVucyJFoYwYLGhLhwnFc
   aHXxr1L5sEZoqikv83GB7lSAvZJROEKvvogBQudXAzBqb2gFjUBUpnIdL
   0HFF4ZuBdO+NhTrBg2UKVUkuN9FXCwWg9nwiZ+HP+G+uSfQM7bOxPrNnf
   J6k1bKOS0PuTYzt66tgRyJecY8MIyaTTHB5OvwNzbaG+noAIQbBwtUtaM
   FA0vWViYEm98BzIrR7O4ZO/iy2yXxvradYonB8rEExB3hkJJKLD9YwgkP
   vdrwKEwgfXtYrSOuTB4bD7r2lGZ08G/p43sa5Tb7bZeeE3ELzYI6wmGYp
   Q==;
X-CSE-ConnectionGUID: 31u6H1gFQF6wPtIVnDeJKw==
X-CSE-MsgGUID: r7mGNLCGSLqkrQYUA6DNbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14082037"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="14082037"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:13:05 -0700
X-CSE-ConnectionGUID: 8ASaOD0gSx+/CFtYNYuC+A==
X-CSE-MsgGUID: 4yavY1VEQWGXdS5R4EpFXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36733139"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 03 Jun 2024 03:13:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Jun 2024 13:13:01 +0300
Date: Mon, 3 Jun 2024 13:13:01 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/1] usb: typec: tcpm: avoid resets for missing source
 capability messages
Message-ID: <Zl2XLbOfAgYq6yWE@kuha.fi.intel.com>
References: <20240523171806.223727-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523171806.223727-1-sebastian.reichel@collabora.com>

On Thu, May 23, 2024 at 07:17:52PM +0200, Sebastian Reichel wrote:
> When the Linux Type-C controller drivers probe, they requests a soft
> reset, which should result in the source restarting to send Source
> Capability messages again independently of the previous state.
> Unfortunately some USB PD sources do not follow the specification and
> do not send them after a soft reset when they already negotiated a
> specific contract before. The current way (and what is described in the
> specificiation) to resolve this problem is triggering a hard reset.
> 
> But a hard reset is fatal on batteryless platforms powered via USB-C PD,
> since that removes VBUS for some time. Since this is triggered at boot
> time, the system will be stuck in a boot loop. Examples for platforms
> affected by this are the Radxa Rock 5B or the Libre Computer Renegade
> Elite ROC-RK3399-PC.
> 
> Instead of directly trying a hard reset when no Source Capability
> message is send by the USB-PD source automatically, this changes the
> state machine to try explicitly asking for the capabilities by sending
> a Get Source Capability control message.
> 
> For me this solves issues with 2 different USB-PD sources - a RAVPower
> powerbank and a Lemorele USB-C dock. Every other PD source I own
> follows the specification and automatically sends the Source Capability
> message after a soft reset, which works with or without this change.
> 
> I decided against making this extra step limited to devices not having
> the self_powered flag set, since I don't see any huge drawbacks in this
> approach and it keeps the logic simpler. The worst case scenario would
> be a power source, which is really stuck. In that case the hard reset
> is delayed by another 310ms.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 375bc84d14a2..bac6866617c8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -57,6 +57,7 @@
>  	S(SNK_DISCOVERY_DEBOUNCE),		\
>  	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
>  	S(SNK_WAIT_CAPABILITIES),		\
> +	S(SNK_WAIT_CAPABILITIES_TIMEOUT),	\
>  	S(SNK_NEGOTIATE_CAPABILITIES),		\
>  	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
>  	S(SNK_TRANSITION_SINK),			\
> @@ -3108,7 +3109,8 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  						   PD_MSG_CTRL_REJECT :
>  						   PD_MSG_CTRL_NOT_SUPP,
>  						   NONE_AMS);
> -		} else if (port->state == SNK_WAIT_CAPABILITIES) {
> +		} else if (port->state == SNK_WAIT_CAPABILITIES ||
> +			   port->state == SNK_WAIT_CAPABILITIES_TIMEOUT) {
>  		/*
>  		 * This message may be received even if VBUS is not
>  		 * present. This is quite unexpected; see USB PD
> @@ -5039,10 +5041,31 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_SOFT_RESET,
>  				       PD_T_SINK_WAIT_CAP);
>  		} else {
> -			tcpm_set_state(port, hard_reset_state(port),
> +			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>  				       PD_T_SINK_WAIT_CAP);
>  		}
>  		break;
> +	case SNK_WAIT_CAPABILITIES_TIMEOUT:
> +		/*
> +		 * There are some USB PD sources in the field, which do not
> +		 * properly implement the specification and fail to start
> +		 * sending Source Capability messages after a soft reset. The
> +		 * specification suggests to do a hard reset when no Source
> +		 * capability message is received within PD_T_SINK_WAIT_CAP,
> +		 * but that might effectively kil the machine's power source.
> +		 *
> +		 * This slightly diverges from the specification and tries to
> +		 * recover from this by explicitly asking for the capabilities
> +		 * using the Get_Source_Cap control message before falling back
> +		 * to a hard reset. The control message should also be supported
> +		 * and handled by all USB PD source and dual role devices
> +		 * according to the specification.
> +		 */
> +		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
> +			tcpm_set_state_cond(port, hard_reset_state(port), 0);
> +		else
> +			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
> +		break;
>  	case SNK_NEGOTIATE_CAPABILITIES:
>  		port->pd_capable = true;
>  		tcpm_set_partner_usb_comm_capable(port,
> -- 
> 2.43.0

-- 
heikki

