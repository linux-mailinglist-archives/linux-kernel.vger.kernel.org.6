Return-Path: <linux-kernel+bounces-269171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B4942EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A6E28CF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B741B0105;
	Wed, 31 Jul 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ouyw8sLu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4F1AE869;
	Wed, 31 Jul 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429523; cv=none; b=FYQa6LPe1gd+756dGXama+NoPLrPXa38YA8sYY2PwVsiXeG4IyTKe3ydrM7eqRof0oS6q7/Bzs1NJm8jSZY4l7NPGdX0dqNwx0MjjEtyA94f1WHG/tuKu0oGhUjHgguVcFHTANRpLiCJqE/HmKS8xQCVa5pU/+QH2Cp5wzJl2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429523; c=relaxed/simple;
	bh=H3n+i4UwBjFtCGKD1tha9bJSAZ4cY9bih8IUa9yvJ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNTjtUOyQA/yBHj548UnWzAoS1wFRHgcy1plBx8GwE1E3KWEiEkm6c5WvcQSFEPcCSQ9BoudExlCJ57UsD0gEeU+WQMxJNqB5HRcSzDpusqAXygn01onRNADYQDa9fzQGf9pVyegx0MbZ5FwocYYz9Tq6vNMnW6CjHp+jPpDgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ouyw8sLu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722429521; x=1753965521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H3n+i4UwBjFtCGKD1tha9bJSAZ4cY9bih8IUa9yvJ3Y=;
  b=Ouyw8sLuygLEaw3hGk5P4IvW4kD4B0ja4Y/LEDzj88pCFLK/NJlVvacn
   9i+PfVk14FwvQrV+bJwipvFDFQ6ePFQpJ1rh98M+MqZUBoUSGBi3ld+Ru
   cI0iRqT4iSv+SUlK8REoxaOLm4jkpndCSWNGvd1KcItzfN6jaOnsSyqBI
   hdfC12gJXDJZi+bqWD/vof37gT/7bYydK0jSnc1KMlUKEX+zKqfdsSDVW
   W+zf7wz2trY6BndyY/jfMVsDasBTH1tCRqA9ek/4iElVQV+AMfoVT2Ihv
   QB1XimauxfEV/yX1pkKPBBcVksc4Y0RXOxxDSIar5gKm5AKSJtRgiobgf
   A==;
X-CSE-ConnectionGUID: P5DY/s5/RJqw5e0eV+MnLQ==
X-CSE-MsgGUID: N2IBo9d6Q+uwT2S002T6mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="42835102"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="42835102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:38:41 -0700
X-CSE-ConnectionGUID: eSLGD3LbRTOj1kj2lKfKqg==
X-CSE-MsgGUID: fC8kL5nqQfarnicfDIeaIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55471437"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 31 Jul 2024 05:38:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:38:37 +0300
Date: Wed, 31 Jul 2024 15:38:36 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] usb: typec: tcpm/tcpci_maxim: use GENMASK() for
 TCPC_VENDOR_CC_CTRL3 register
Message-ID: <ZqowTIgSpSm9rwyP@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-12-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-12-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:19AM +0100, André Draszik wrote:
> Convert register TCPC_VENDOR_CC_CTRL3 to using GENMASK() so as to keep
> using a similar approach throughout the code base and make it arguably
> easier to read.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 9 +++++----
>  drivers/usb/typec/tcpm/tcpci_maxim.h       | 9 +++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index f7acaa42329f..cf9887de96c9 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -283,10 +283,11 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
>  	u8 temp;
>  	int ret;
>  
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL3, CCWTRDEB_MASK | CCWTRSEL_MASK
> -				    | WTRCYCLE_MASK, CCWTRDEB_1MS << CCWTRDEB_SHIFT |
> -				    CCWTRSEL_1V << CCWTRSEL_SHIFT | WTRCYCLE_4_8_S <<
> -				    WTRCYCLE_SHIFT);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL3,
> +				 CCWTRDEB | CCWTRSEL | WTRCYCLE,
> +				 FIELD_PREP(CCWTRDEB, CCWTRDEB_1MS)
> +				 | FIELD_PREP(CCWTRSEL, CCWTRSEL_1V)
> +				 | FIELD_PREP(WTRCYCLE, WTRCYCLE_4_8_S));
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 92c9a628ebe1..34076069444f 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -27,15 +27,12 @@
>  #define UA_80_SRC                               3
>  
>  #define TCPC_VENDOR_CC_CTRL3                    0x8e
> -#define CCWTRDEB_MASK                           GENMASK(7, 6)
> -#define CCWTRDEB_SHIFT                          6
> +#define CCWTRDEB                                GENMASK(7, 6)
>  #define CCWTRDEB_1MS                            1
> -#define CCWTRSEL_MASK                           GENMASK(5, 3)
> -#define CCWTRSEL_SHIFT                          3
> +#define CCWTRSEL                                GENMASK(5, 3)
>  #define CCWTRSEL_1V                             0x4
>  #define CCLADDERDIS                             BIT(2)
> -#define WTRCYCLE_MASK                           BIT(0)
> -#define WTRCYCLE_SHIFT                          0
> +#define WTRCYCLE                                GENMASK(0, 0)
>  #define WTRCYCLE_2_4_S                          0
>  #define WTRCYCLE_4_8_S                          1
>  
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

