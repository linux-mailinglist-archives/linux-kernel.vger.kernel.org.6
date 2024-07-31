Return-Path: <linux-kernel+bounces-269062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F4157942CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F7B220DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E5C1AD40D;
	Wed, 31 Jul 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBsUbzxW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04971AB52E;
	Wed, 31 Jul 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424358; cv=none; b=i2gRGg4EBJ5CFM/u+YxCQGRTjYAP2fAT7MPtQB7zFQbrK4CI0U/hLqx/IJ28NY4xZ7apuTDNWyrKwTSucJKzaj2UBCu2rU69psLcWaUmdC3WSkMO0JOsZwi2CgTCJy2AwBuMBROFiMfofQr0pXKmt0nbJVHGt1qqXv5fsLl3LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424358; c=relaxed/simple;
	bh=G+Zpz6SvXzu6f4JKhaVaaYDOnPvcxPO1X6/kJAHyN/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtnnLpthk9wfoQvM02czPBz/QnGfZg5UxoSSyKtS2VYvj/SNgqJZrfSUrFl0IMu0SylQKt1U1ntDXI8QlhcR0BmD41oQBe86mJvge8KeKBNO/mLsJBszthQJPLUEhgh3q0iiLAk9QqYUHkIYPDBMPEJCWWgWmPIjqEoGxmNZYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBsUbzxW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722424357; x=1753960357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G+Zpz6SvXzu6f4JKhaVaaYDOnPvcxPO1X6/kJAHyN/U=;
  b=OBsUbzxWgCptOsgDMVqydsPUWdxo9adzgPkzEPi4A29UqguT5U7z2910
   +oUJvii9zRuS5C/fSx9xMPTdm0g7fHmbn4jRD6SMprNZD/M8BGMMw5d8v
   ZOcnKXUTB+dFTKLvNK4UdUQlgA0O7c7PDmzaVgc3hU109znRkzuWIooi3
   Vwi0qeBKR/cV0qtqnBqsQhWzeACVEcT+ONfSBChkBpkeqhD0kPEd+z05B
   ah8IDN38kie/xZ/Q1sMTQ1/v8Ybxigttp5iNX8/TH6oTjnXvMF53N1wUd
   hh1PB0sJaspZSQnDv087/MN39y1UUj19Qrz27u9J3tzGSzcCI3JOi7AWm
   g==;
X-CSE-ConnectionGUID: yuiqsuVaQjGw0FWdfGiilQ==
X-CSE-MsgGUID: ow6DHgrcSpGDzkWK/HcAHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31445150"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31445150"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:12:36 -0700
X-CSE-ConnectionGUID: am95G9WIR/KXaeH3jJvrEQ==
X-CSE-MsgGUID: cTQXCV2PR4Ktsn8OtMxmkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85290213"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa002.jf.intel.com with SMTP; 31 Jul 2024 04:12:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 14:12:31 +0300
Date: Wed, 31 Jul 2024 14:12:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] usb: typec: tcpm/tcpci_maxim: simplify clearing of
 TCPC_ALERT_RX_BUF_OVF
Message-ID: <ZqocH1QlwUnvN00n@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-9-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-9-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:16AM +0100, André Draszik wrote:
> There is no need for using the ternary if/else here, simply mask
> TCPC_ALERT_RX_BUF_OVF as necessary, which arguably makes the code
> easier to read.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index ad9bb61fd9e0..5b5441db7047 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -193,9 +193,8 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	 * Read complete, clear RX status alert bit.
>  	 * Clear overflow as well if set.
>  	 */
> -	ret = max_tcpci_write16(chip, TCPC_ALERT, status & TCPC_ALERT_RX_BUF_OVF ?
> -				TCPC_ALERT_RX_STATUS | TCPC_ALERT_RX_BUF_OVF :
> -				TCPC_ALERT_RX_STATUS);
> +	ret = max_tcpci_write16(chip, TCPC_ALERT,
> +				TCPC_ALERT_RX_STATUS | (status & TCPC_ALERT_RX_BUF_OVF));
>  	if (ret < 0)
>  		return;
>  
> @@ -297,9 +296,8 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  	 * be cleared until we have successfully retrieved message.
>  	 */
>  	if (status & ~TCPC_ALERT_RX_STATUS) {
> -		mask = status & TCPC_ALERT_RX_BUF_OVF ?
> -			status & ~(TCPC_ALERT_RX_STATUS | TCPC_ALERT_RX_BUF_OVF) :
> -			status & ~TCPC_ALERT_RX_STATUS;
> +		mask = status & ~(TCPC_ALERT_RX_STATUS
> +				  | (status & TCPC_ALERT_RX_BUF_OVF));
>  		ret = max_tcpci_write16(chip, TCPC_ALERT, mask);
>  		if (ret < 0) {
>  			dev_err(chip->dev, "ALERT clear failed\n");
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

