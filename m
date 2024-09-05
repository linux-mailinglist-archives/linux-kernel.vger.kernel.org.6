Return-Path: <linux-kernel+bounces-316940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BA96D74B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB14281A81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34482199E9E;
	Thu,  5 Sep 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n62G6JuP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F719342A;
	Thu,  5 Sep 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536166; cv=none; b=lWq+2iv7QyEDAqNcP80iOko3+PcRiAGLoBDQupa/oAVM6C9KLsZvMr1k5gw+TvPj9CbAevysQLjmKidQR+bvV1K25Yhbi6FJHRw3xrMU2/uBUxq126jeHKkocUm7fjOQlC7212yX+HfmfNELT3Pld8Ij/LalX6Qo1QdBvA6yf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536166; c=relaxed/simple;
	bh=T+4ZZIcX79/JHfYELeyG3pX+pz0BFgc2EUGDMCkbgis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4SdpLv/rToRz+jp/KpiCm9dO3MJAJ+Whm9mumnnsZbgG070J+zxR8XaQg3Sdlt7ktjBBuONklOJfrPaNNsY3tr5CjYaGyCjwri6DlP0ot1PwQWpfGBrEWQOsp/2H7t/FrnUlrZ2ZXWyiL/ulfBtDFQv5HS0RaIHYjnEBoonacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n62G6JuP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725536165; x=1757072165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+4ZZIcX79/JHfYELeyG3pX+pz0BFgc2EUGDMCkbgis=;
  b=n62G6JuPCvun4LbIDxAzM7rBlxw63OUaJarCCXsqsfHFHrEDfPxy59dK
   iNyF6Y2UGOumjlNA0uR8f52PMV5yxbKJwc0q6P/JNLjG6tDX2L3s8eQ+P
   NYn0FRv+DehNt7aEq1JdMZXo8kgUlliqMEDtwLFicOUFE4Ojpyxlg0cNC
   mT0xAyk/wpHne/w3YnTArv5VJ5qTzMll/Xkd5qKDnFIic094EawArOSM2
   LGEMMngmcl3oqJAqTbFjxjgXc0tCYhKTn+8V/HUWqQRRozU1Tyy4jgjin
   y+HlY69jfkQSa4ug7Ng4nhyaOKXASZbX3qS15fuQRnWk+c54LXa5shxgo
   w==;
X-CSE-ConnectionGUID: EIN7+d2aSNq1OUp9Jno7aw==
X-CSE-MsgGUID: mgUuiLwUS0KBPUakOPSMQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24362395"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24362395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:36:04 -0700
X-CSE-ConnectionGUID: yqeSQoKbSVmLnyW3gb00bg==
X-CSE-MsgGUID: SaU0FK/HSCKxfm+mSXleAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="66117639"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa007.jf.intel.com with SMTP; 05 Sep 2024 04:36:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Sep 2024 14:36:00 +0300
Date: Thu, 5 Sep 2024 14:36:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: Re: [PATCH v2] usb: typec: tcpci: support edge irq
Message-ID: <ZtmXoG1t2SZLDug2@kuha.fi.intel.com>
References: <20240905065328.7116-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905065328.7116-1-parth105105@gmail.com>

On Thu, Sep 05, 2024 at 08:53:28AM +0200, Parth Pancholi wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> TCPCI USB PHY - PTN5110 could be used with SOCs that only support
> the edge-triggered GPIO interrupts such as TI's K3 device AM69.
> Move the interrupt configuration to the firmware which would
> allow to accommodate edge triggered interrupts for such SOCs.
> In order to support the edge interrupts, register irq line in advance
> and keep track of occurrence during port registering.
> 
> When the edge interrupts are used, it is observed that some of the
> interrupts are missed when tcpci_irq() is serving the current
> interrupt. Therefore, check the status register at the end of
> tcpci_irq() and re-run the function if the status is not clear
> i.e. pending interrupt.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: Re-enable irq irrespective of tcpci_register_port() return status which was disabled before this call
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index a2651a2a7f2e..ed32583829be 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -707,10 +707,13 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  {
>  	u16 status;
>  	int ret;
> +	int irq_ret;
>  	unsigned int raw;
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
> +	irq_ret = status & tcpci->alert_mask;
>  
> +process_status:
>  	/*
>  	 * Clear alert status for everything except RX_STATUS, which shouldn't
>  	 * be cleared until we have successfully retrieved message.
> @@ -783,7 +786,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  	else if (status & TCPC_ALERT_TX_FAILED)
>  		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
>  
> -	return IRQ_RETVAL(status & tcpci->alert_mask);
> +	tcpci_read16(tcpci, TCPC_ALERT, &status);
> +
> +	if (status & tcpci->alert_mask)
> +		goto process_status;
> +
> +	return IRQ_RETVAL(irq_ret);
>  }
>  EXPORT_SYMBOL_GPL(tcpci_irq);
>  
> @@ -915,20 +923,22 @@ static int tcpci_probe(struct i2c_client *client)
>  
>  	chip->data.set_orientation = err;
>  
> -	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> -	if (IS_ERR(chip->tcpci))
> -		return PTR_ERR(chip->tcpci);
> -
>  	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>  					_tcpci_irq,
> -					IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), chip);
> -	if (err < 0) {
> -		tcpci_unregister_port(chip->tcpci);
> +	if (err < 0)
>  		return err;
> -	}
>  
> -	return 0;
> +	/*
> +	 * Disable irq while registering port. If irq is configured as an edge
> +	 * irq this allow to keep track and process the irq as soon as it is enabled.
> +	 */
> +	disable_irq(client->irq);
> +	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> +	enable_irq(client->irq);
> +
> +	return PTR_ERR_OR_ZERO(chip->tcpci);
>  }
>  
>  static void tcpci_remove(struct i2c_client *client)
> -- 
> 2.34.1

-- 
heikki

