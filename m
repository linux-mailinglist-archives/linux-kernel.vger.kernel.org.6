Return-Path: <linux-kernel+bounces-280449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC294CAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B7F1C21A20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835516D33F;
	Fri,  9 Aug 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC5fB1Gz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61041B964;
	Fri,  9 Aug 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186100; cv=none; b=NjwLqY8roIeo70L8UcydetSRyWvKwHS7ILI4eArIe2ciOxbZVSlAaalW9rVEhy+s96v/JNXBmTHYDCTDNzybEIz9gTPzlrGHpO3ksveQNLSNFKj15XKKQR31sN3IrJqroSXoMtDoz3ZmNR5UhfgZNGeBsGGX7nld2DP0rBSzCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186100; c=relaxed/simple;
	bh=ikDBciJQ5FRD7hK+kzsRbaUqNZBJgUIgjso2CxtV70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/GSOSzMRlG9sCyaKDL9ubnMNdUAv3c9j8lViWvqaPfJMU5K3ztiEI0ZvYI9HqRh7jj1S9cmdIIGh2NxOWT48o6XAT4jUEtF4YDhwswF7kxRJSIwVwncznZFcsYNZ9JujWmTLf9r9OZcsk6Gqo1vx2fic0RflUxxXsVLHKkAmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC5fB1Gz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723186099; x=1754722099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ikDBciJQ5FRD7hK+kzsRbaUqNZBJgUIgjso2CxtV70w=;
  b=AC5fB1GzpHIdgyX3WEW2TPWXX3b7RluXdLbXuZ9S82ptTKjbZVkNMV7s
   juz+rSjrBe2yPWm1eEOJjUXkawYte5O9zBLJYD0ZYHP1ETC1WDLG1mABs
   53HGiEeafVNs6oPy+77DB9vXlCYSoYI7EDIFBs9LKXW2mgoSiwufQjIRx
   5hlEanjpri4hUz+vP+AiLHy1H66M5HMe/LSkcaeIsqRRs526UgBOoT/+g
   PlpMxrxwSvX1azkFCs8356cynAsIlwtJaBirlp9q8blXcmOTtnhDgltQ3
   jhMl3WyilUzSBxJgjNFXiR11icCwhEd2SottLfIexdfzEWZUFd3Fbvlrs
   Q==;
X-CSE-ConnectionGUID: 0TqXiwbFQEOk8aT9xh56cg==
X-CSE-MsgGUID: 8Cj/Q+nlR1GMJg1MYpBHtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21207977"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21207977"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 23:48:17 -0700
X-CSE-ConnectionGUID: RWKsDl7XRxqt0/lW1QD57w==
X-CSE-MsgGUID: vybfhV0MSd+4dppXoQ8lGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="88348217"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa001.fm.intel.com with SMTP; 08 Aug 2024 23:48:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 09 Aug 2024 09:48:12 +0300
Date: Fri, 9 Aug 2024 09:48:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	RD Babiera <rdbabiera@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC
 handling
Message-ID: <ZrW7rPfbf68W5ZHk@kuha.fi.intel.com>
References: <20240806-max33359-toggling-v2-1-a66ab37baafb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806-max33359-toggling-v2-1-a66ab37baafb@linaro.org>

On Tue, Aug 06, 2024 at 05:25:24PM +0100, André Draszik wrote:
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
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - longer line length in tcpci_maxim_core.c (Heikki)
> - update kernel-doc (Badhri)
> - drop now-obsolete comment for cc_handled in _max_tcpci_irq() (we have
>   kernel-doc now)
> - Link to v1: https://lore.kernel.org/r/20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org
> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c |  7 +++++--
>  drivers/usb/typec/tcpm/tcpci_maxim.h       | 16 +++++++++++++++-
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c  | 11 +++++++----
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
> index 78ff3b73ee7e..7719e291132a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -85,6 +85,20 @@ static inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg
>  	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
>  }
>  
> -bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce);
> +/**
> + * max_contaminant_is_contaminant - Test if CC was toggled due to contaminant
> + *
> + * @chip: Handle to a struct max_tcpci_chip
> + * @disconnect_while_debounce: Whether the disconnect was detected when CC
> + *      		       pins were debouncing
> + * @cc_handled: Returns whether or not update to CC status was handled here
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
> index 760e2f92b958..22bc05064b3e 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -357,12 +357,14 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		tcpm_vbus_change(chip->port);
>  
>  	if (status & TCPC_ALERT_CC_STATUS) {
> +		bool cc_handled = false;
> +
>  		if (chip->contaminant_state == DETECTED || tcpm_port_is_toggling(chip->port)) {
> -			if (!max_contaminant_is_contaminant(chip, false))
> +			if (!max_contaminant_is_contaminant(chip, false, &cc_handled))
>  				tcpm_port_clean(chip->port);
> -		} else {
> -			tcpm_cc_change(chip->port);
>  		}
> +		if (!cc_handled)
> +			tcpm_cc_change(chip->port);
>  	}
>  
>  	if (status & TCPC_ALERT_POWER_STATUS)
> @@ -455,8 +457,9 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
>  static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *tdata)
>  {
>  	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
> +	bool cc_handled;
>  
> -	if (!max_contaminant_is_contaminant(chip, true))
> +	if (!max_contaminant_is_contaminant(chip, true, &cc_handled))
>  		tcpm_port_clean(chip->port);
>  }
>  
> 
> ---
> base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
> change-id: 20240710-max33359-toggling-cf7f7e5e1443
> 
> Best regards,
> -- 
> André Draszik <andre.draszik@linaro.org>

-- 
heikki

