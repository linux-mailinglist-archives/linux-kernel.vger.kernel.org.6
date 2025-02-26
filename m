Return-Path: <linux-kernel+bounces-533480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6770A45B25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7599173F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257802459C2;
	Wed, 26 Feb 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFfi6bS8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D401DC997;
	Wed, 26 Feb 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564291; cv=none; b=ulcbIgIfGMJYLOSxO4Ut4xhLdo3rgajSYvZeCIMV7mZNI4B9OkF6o1DqC/eKPy16vMpsNnLIcBSs7GO7wHZJ/+zoZr7Khw8tCsR2/A/74itUzRxR7/cRlnnA0syeGQI6NjOQcspZsfW9UG/H+F/qRaIdzyILGL5pJUQ6z9Qc8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564291; c=relaxed/simple;
	bh=nwyXZWonvxH56q4PtFgwHkVNFRxl+D+0O2BdzxMl7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G60+CvMZ+QQm5+TOZV6wMAZz03g16RD+Tyl87yoQij3Z9krU/GTq6MBG2BUInxCdmK2qtnTPQl6kgW9zHEDhThXdE5MeK+pT3J7Qa/8xSZsOFuJsa+Hfjyd3MInjrdUldnZyhG4deohQnJ/zjFIHz0w1ffgVbjcfLY8sGy0bUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFfi6bS8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740564290; x=1772100290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwyXZWonvxH56q4PtFgwHkVNFRxl+D+0O2BdzxMl7fY=;
  b=RFfi6bS8tj7ZnoagIz4mq6szmkH8wktSbNDk2m9r2XN2TjrzmNaHlHNe
   wkEbNehHam2XWe9V4haF9MxeW1/467LXmbsU0VtywPGitLh6bRZ33f9dV
   lqSV4zP6XKX4//opbQ+yKPxtWMXNiEudfcz+y0GCrvQJ/a5sn1OQcfHEw
   VtvyKR4++u63MErQH0SNTo7YMXjB3OeoLEIF5hbtzEMRl9H798PzcbBdn
   dR4fu33RvogbunwA96fdNqYpJemhhhgKvr815Any6RSRYyAAPkLMepEgq
   Z1gHOMxv8UfE8z/QyKUs7KDmox9olSp0ROrylAJJXXqmPkelAINRzeUjj
   Q==;
X-CSE-ConnectionGUID: /4Gd3JnZStuoagv0zfHr9Q==
X-CSE-MsgGUID: fEKiWb55QHeuXJR3gWBGFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66775054"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="66775054"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 02:04:49 -0800
X-CSE-ConnectionGUID: cenwX1QHSW+spLX9RDCSfg==
X-CSE-MsgGUID: wBIpO7YkTEyjGPU0CfMYUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147484070"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 26 Feb 2025 02:04:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 Feb 2025 12:04:44 +0200
Date: Wed, 26 Feb 2025 12:04:44 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, andre.draszik@linaro.org,
	linux@roeck-us.net, shufan_lee@richtek.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, pablo.sun@mediatek.com
Subject: Re: [PATCH v2] usb: typec: tcpci_rt1711h: Unmask alert interrupts to
 fix functionality
Message-ID: <Z77nPL_84FgjkDMX@kuha.fi.intel.com>
References: <20250219114700.41700-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219114700.41700-1-angelogioacchino.delregno@collabora.com>

On Wed, Feb 19, 2025 at 12:47:00PM +0100, AngeloGioacchino Del Regno wrote:
> During probe, the TCPC alert interrupts are getting masked to
> avoid unwanted interrupts during chip setup: this is ok to do
> but there is no unmasking happening at any later time, which
> means that the chip will not raise any interrupt, essentially
> making it not functional as, while internally it does perform
> all of the intended functions, it won't signal anything to the
> outside.
> 
> Unmask the alert interrupts to fix functionality.
> 
> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Shouldn't this go to the stable kernels as well?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
>  - Moved interrupts enablement call to before enabling irq wakeup as
>    enable_irq_wake() cannot fail, and if anything goes wrong, since the
>    interrupt was previously requested with devm, no further action is
>    needed. Thanks Greg!
> 
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 64f6dd0dc660..88c50b984e8a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct rt1711h_chip *chip;
> +	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
> +			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
> +			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
> +			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
> +			       TCPC_ALERT_FAULT;
>  
>  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> @@ -382,6 +387,12 @@ static int rt1711h_probe(struct i2c_client *client)
>  					dev_name(chip->dev), chip);
>  	if (ret < 0)
>  		return ret;
> +
> +	/* Enable alert interrupts */
> +	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
> +	if (ret < 0)
> +		return ret;
> +
>  	enable_irq_wake(client->irq);
>  
>  	return 0;
> -- 
> 2.48.1

-- 
heikki

