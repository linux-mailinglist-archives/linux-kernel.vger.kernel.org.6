Return-Path: <linux-kernel+bounces-270893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5309446B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8B4B224D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B8016EB7A;
	Thu,  1 Aug 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haQEDJOg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8316E86E;
	Thu,  1 Aug 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501333; cv=none; b=kAf4s2sd2lsmeo+4kd2LRp9QQ2B298rfP3bEw1tBUgHLlYdQTN1UgntPk0+SoZFcAWJ6zwxTcBCPT/0gT4EqlBNXN78qCWBKJMKE3NydVqbmQiC/IDP0goxH8SyPPkXUSEBS9JvjgU1GG9F2SoNf+XBo3zcLrL6sLw4ns3nZTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501333; c=relaxed/simple;
	bh=eYp09Enzo5RdanBOF4Cu0/t6tpG469XR13eaMGptRHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxESR7k046DbHoF0JTcIoqXQLpvbjDuCVESk0VGlsceTIDgDjBXA2CqYwIgcKjzzkby/oQuj7M/U3+LIZgkyaGn22OB/mjNIsfsR3zILJpqVI9ZESy5NJxDpc4QvMRBMMtYSB9J7oEKhZunHw77prwpUIKrPNTY+yEgP1laHxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haQEDJOg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722501332; x=1754037332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eYp09Enzo5RdanBOF4Cu0/t6tpG469XR13eaMGptRHM=;
  b=haQEDJOg6b+lX/9hh/Xh1l6ZBWlbIw8mc4blpe3OebjEaAYX0XIdu7+E
   pZcu7jdhsGEdpGSX24dPfiUYj6J0g19ROI85bcuGERtagxYOLvrnPP43K
   5ArvvIwAf80S1IXxIfqZBDlJnKjWyi1t/bQkv1zlgkqIFQJ2R9oIFzBSb
   1JSzDwFZbG6SK4B93vtNVnfaCZWtrUe6hBsy9X/8rKSNfIC7NWyxxU+zG
   0uOZCmaA9y87hu3Zyp3XLWPiGZcxvTpGFrVVrs/9PBgEUihZAb+osBgBx
   LSAmPNWZVvCjrO3dVqQq9kyra4Thc0WrkSngRgoAwPf5MBrC+GUCYr9lf
   A==;
X-CSE-ConnectionGUID: 8CDw//LPQ4u5padJdLZvyg==
X-CSE-MsgGUID: Ws/Aj1XNStucVMHZNwCNqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="24202505"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="24202505"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 01:35:31 -0700
X-CSE-ConnectionGUID: mfGR6wxpQ4+QXFhjc+0XbA==
X-CSE-MsgGUID: 8KDhH2y9RJ+dGPlwuyVuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59287697"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa005.fm.intel.com with SMTP; 01 Aug 2024 01:35:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 01 Aug 2024 11:35:26 +0300
Date: Thu, 1 Aug 2024 11:35:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	RD Babiera <rdbabiera@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC
 handling
Message-ID: <ZqtIztzIS/M+duYT@kuha.fi.intel.com>
References: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org>

Hi André,

On Wed, Jul 10, 2024 at 07:28:32AM +0100, André Draszik wrote:
> tcpci_maxim currently never triggers the TCPM state machine when CC
> status has not changed due to a contaminant but due to a real
> connection event, i.e. a genuine plug event, meaning the system will
> stay idle and not notify any subscribers.
> 
> The reason is that the initial state of the port is 'toggling', which
> causes _max_tcpci_irq() to only drive the contamination part of the
> TCPM state machine (via tcpm_port_clean()).
> 
> What should happen instead is that if no contamination was detected,
> the TCPM should be notified of the CC change in this case.
> 
> To fix this, we update ...is_contaminant() to also allow its caller to
> determine if more CC processing is required and then call into the TCPM
> as required.
> 
> While at it, add a kernel-doc for max_contaminant_is_contaminant().
> 
> Note: the code has an issue where I2C errors during contaminant
> detection also cause the TCPM state machine to not be updated. This
> commit doesn't change this behaviour and should be addressed by
> follow-up commit(s).

This looks okay to me, but just in case, let's wait for comments from
Badhri, or maybe RD can take a look at this. One nitpick below.

> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c |  7 +++++--
>  drivers/usb/typec/tcpm/tcpci_maxim.h       | 15 ++++++++++++++-
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c  | 12 ++++++++----
>  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index f8504a90da26..e7fa3e36f8ae 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -322,11 +322,14 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
>  	return 0;
>  }
>  
> -bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce)
> +bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
> +				    bool *cc_handled)
>  {
>  	u8 cc_status, pwr_cntl;
>  	int ret;
>  
> +	*cc_handled = true;
> +
>  	ret = max_tcpci_read8(chip, TCPC_CC_STATUS, &cc_status);
>  	if (ret < 0)
>  		return false;
> @@ -368,7 +371,6 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  				return true;
>  			}
>  		}
> -		return false;
>  	} else if (chip->contaminant_state == DETECTED) {
>  		if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) {
>  			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
> @@ -379,6 +381,7 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  		}
>  	}
>  
> +	*cc_handled = false;
>  	return false;
>  }
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 78ff3b73ee7e..9c7f714d2c21 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -85,6 +85,19 @@ static inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg
>  	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
>  }
>  
> -bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce);
> +/**
> + * max_contaminant_is_contaminant - Test if CC was toggled due to contaminant
> + *
> + * @chip: Handle to a struct max_tcpci_chip
> + * @disconnect_while_debounce: Whether or not to sleep as debouncing measure
> + * @cc_handled: Returns whether or not CC toggling was handled here
> + *
> + * Determine if a contaminant was detected.
> + *
> + * Returns: true if a contaminant was detected, false otherwise. cc_handled
> + * is updated to reflect whether or not further CC handling is required.
> + */
> +bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
> +				    bool *cc_handled);
>  
>  #endif  // TCPCI_MAXIM_H_
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index eec3bcec119c..55d931672ecd 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -357,12 +357,15 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		tcpm_vbus_change(chip->port);
>  
>  	if (status & TCPC_ALERT_CC_STATUS) {
> +		bool cc_handled = false; /* CC toggle handled by contaminant detection */
> +
>  		if (chip->contaminant_state == DETECTED || tcpm_port_is_toggling(chip->port)) {
> -			if (!max_contaminant_is_contaminant(chip, false))
> +			if (!max_contaminant_is_contaminant(chip, false,
> +							    &cc_handled))

One line is enough for that.

>  				tcpm_port_clean(chip->port);
> -		} else {
> -			tcpm_cc_change(chip->port);
>  		}
> +		if (!cc_handled)
> +			tcpm_cc_change(chip->port);
>  	}
>  
>  	if (status & TCPC_ALERT_POWER_STATUS)
> @@ -455,8 +458,9 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
>  static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *tdata)
>  {
>  	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
> +	bool cc_handled;
>  
> -	if (!max_contaminant_is_contaminant(chip, true))
> +	if (!max_contaminant_is_contaminant(chip, true, &cc_handled))
>  		tcpm_port_clean(chip->port);
>  }

thanks,

-- 
heikki

