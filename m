Return-Path: <linux-kernel+bounces-268986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF2942BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70665B214EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD841AC437;
	Wed, 31 Jul 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2qzKiTQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBF1AAE23;
	Wed, 31 Jul 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421738; cv=none; b=L/Ey+m0dD+cGklqcoqoVg7pLcr5xQJ3NajV2iH8RAAIF5WYgqK4JPC8Zj2tKTdJ1ATF22P+VDrDkFe6sorZ1HgJfDHpE3FL6yh9ttzO9sZCipJL4feTRhlvgbmSsRsCICNYVW7p3Ow6vB/JbZi7s5nC4h+xunrWkN1bQBlX2QG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421738; c=relaxed/simple;
	bh=F+InPI8QiElPu7SoKRm4IPnmagGjON5efOc401N+JsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LipriItOivdON0sbx0uPjKmgx2Z0pGk9uXRTedTaVYIGuJ3LtrXXfwXX3m2UtLFStqjz6l2O9S2OV0jgWKwksjHVlHdWBHBBz3sV1v/icB2XDBt22W+7q6pQsQkZzsL5dhxSVfFYd/fhEoSAiJuFX/9UwEo1JCkRjlUnW0MLkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2qzKiTQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722421737; x=1753957737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F+InPI8QiElPu7SoKRm4IPnmagGjON5efOc401N+JsQ=;
  b=n2qzKiTQH2Ms2z3J2AdF1+1OvXHOOgmNUUX6EjLIRsi5Grinevloy1Sd
   tZXErWLkGkk4WDWmVh2V+cg5VNerfOHwkwr7WqTv2RDUvrV2JG1/wbqwa
   FNw78uHXV820sjZnc8NrCvo4b4yWiOMOS+7QNWoncpHW5LpbS1UWwXGLI
   QskjW+F4Sa+itq6hH39YNxqgZSpLzo2RqbQKGMzJbMavH9l6Bj4zy5YoD
   zBWT5Mw5zDpN5bAMme5yDI+AEOnqZV0Vu4dSPObyDzZvoeg2SAGpZY2Qy
   WVYKdQ5BR3azmtTmVwde4XVH9miwqZCfGAz1qUUkls8i/ydKI5I+wwAVE
   w==;
X-CSE-ConnectionGUID: x4SUhdj3QSic0E7QeTY/dw==
X-CSE-MsgGUID: XrPywc9PT72h6ManW0vxxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="12804174"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="12804174"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 03:28:56 -0700
X-CSE-ConnectionGUID: 7dCnzNedQ3uTQOPxlh3QDA==
X-CSE-MsgGUID: 6TfxKWiTSqmfcUlAwb3lBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54630168"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa009.jf.intel.com with SMTP; 31 Jul 2024 03:28:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 13:28:51 +0300
Date: Wed, 31 Jul 2024 13:28:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] usb: typec: tcpci: use GENMASK() for
 TCPC_ROLE_CTRL_CC[12]
Message-ID: <ZqoR4/wTUAF9o0Hw@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-4-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-4-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:11AM +0100, André Draszik wrote:
> All this open-coded shifting and masking is quite hard to read, in
> particular the if-statement in tcpci_apply_rc().
> 
> Declare TCPC_ROLE_CTRL_CC[12] using GENMASK() which allows using
> FIELD_GET() and FIELD_PREP() to arguably make the code more legible.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c            |  5 ++-
>  drivers/usb/typec/tcpm/tcpci.c         | 73 +++++++++++++++-------------------
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c |  8 ++--
>  include/linux/usb/tcpci.h              |  9 ++---
>  4 files changed, 43 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index b12a07edc71b..78b0d856cfc1 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -6,6 +6,7 @@
>   * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
>   *
>   */
> +#include <linux/bitfield.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -884,8 +885,8 @@ static void anx7411_chip_standby(struct anx7411_data *ctx)
>  				OCM_RESET);
>  	ret |= anx7411_reg_write(ctx->tcpc_client, ANALOG_CTRL_10, 0x80);
>  	/* Set TCPC to RD and DRP enable */
> -	cc1 = TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT;
> -	cc2 = TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT;
> +	cc1 = FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD);
> +	cc2 = FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD);
>  	ret |= anx7411_reg_write(ctx->tcpc_client, TCPC_ROLE_CTRL,
>  				 TCPC_ROLE_CTRL_DRP | cc1 | cc2);
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index ce11a154c7dc..cd71ece7b956 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -104,45 +104,42 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  
>  	switch (cc) {
>  	case TYPEC_CC_RA:
> -		reg = (TCPC_ROLE_CTRL_CC_RA << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_RA << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RA)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RA));
>  		break;
>  	case TYPEC_CC_RD:
> -		reg = (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD));
>  		break;
>  	case TYPEC_CC_RP_DEF:
> -		reg = (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT) |
> -			(TCPC_ROLE_CTRL_RP_VAL_DEF <<
> -			 TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> +		       | (TCPC_ROLE_CTRL_RP_VAL_DEF << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
>  		break;
>  	case TYPEC_CC_RP_1_5:
> -		reg = (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT) |
> -			(TCPC_ROLE_CTRL_RP_VAL_1_5 <<
> -			 TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> +		       | (TCPC_ROLE_CTRL_RP_VAL_1_5 << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
>  		break;
>  	case TYPEC_CC_RP_3_0:
> -		reg = (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT) |
> -			(TCPC_ROLE_CTRL_RP_VAL_3_0 <<
> -			 TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> +		       | (TCPC_ROLE_CTRL_RP_VAL_3_0 << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
>  		break;
>  	case TYPEC_CC_OPEN:
>  	default:
> -		reg = (TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			(TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_OPEN)
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_OPEN));
>  		break;
>  	}
>  
>  	if (vconn_pres) {
>  		if (polarity == TYPEC_POLARITY_CC2) {
> -			reg &= ~(TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT);
> -			reg |= (TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC1_SHIFT);
> +			reg &= ~TCPC_ROLE_CTRL_CC1;
> +			reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_OPEN);
>  		} else {
> -			reg &= ~(TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT);
> -			reg |= (TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC2_SHIFT);
> +			reg &= ~TCPC_ROLE_CTRL_CC2;
> +			reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_OPEN);
>  		}
>  	}
>  
> @@ -168,15 +165,11 @@ static int tcpci_apply_rc(struct tcpc_dev *tcpc, enum typec_cc_status cc,
>  	 * APPLY_RC state is when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2 and vbus autodischarge on
>  	 * disconnect is disabled. Bail out when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2.
>  	 */
> -	if (((reg & (TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT)) >>
> -	     TCPC_ROLE_CTRL_CC2_SHIFT) !=
> -	    ((reg & (TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT)) >>
> -	     TCPC_ROLE_CTRL_CC1_SHIFT))
> +	if (FIELD_GET(TCPC_ROLE_CTRL_CC2, reg) != FIELD_GET(TCPC_ROLE_CTRL_CC1, reg))
>  		return 0;
>  
>  	return regmap_update_bits(tcpci->regmap, TCPC_ROLE_CTRL, polarity == TYPEC_POLARITY_CC1 ?
> -				  TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT :
> -				  TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT,
> +				  TCPC_ROLE_CTRL_CC2 : TCPC_ROLE_CTRL_CC1,
>  				  TCPC_ROLE_CTRL_CC_OPEN);
>  }
>  
> @@ -215,11 +208,11 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  	}
>  
>  	if (cc == TYPEC_CC_RD)
> -		reg |= (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD)
> +			| FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD));
>  	else
> -		reg |= (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			   (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
> +			| FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP));
>  	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>  	if (ret < 0)
>  		return ret;
> @@ -281,28 +274,28 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>  		reg = reg & ~TCPC_ROLE_CTRL_DRP;
>  
>  		if (polarity == TYPEC_POLARITY_CC2) {
> -			reg &= ~(TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT);
> +			reg &= ~TCPC_ROLE_CTRL_CC2;
>  			/* Local port is source */
>  			if (cc2 == TYPEC_CC_RD)
>  				/* Role control would have the Rp setting when DRP was enabled */
> -				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT;
> +				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP);
>  			else
> -				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT;
> +				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD);
>  		} else {
> -			reg &= ~(TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT);
> +			reg &= ~TCPC_ROLE_CTRL_CC1;
>  			/* Local port is source */
>  			if (cc1 == TYPEC_CC_RD)
>  				/* Role control would have the Rp setting when DRP was enabled */
> -				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT;
> +				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP);
>  			else
> -				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT;
> +				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD);
>  		}
>  	}
>  
>  	if (polarity == TYPEC_POLARITY_CC2)
> -		reg |= TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC1_SHIFT;
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_OPEN);
>  	else
> -		reg |= TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC2_SHIFT;
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_OPEN);
>  	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index c6dbccf6b17a..bdb78d08b5b5 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -246,11 +246,11 @@ static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>  	}
>  
>  	if (cc == TYPEC_CC_RD)
> -		reg |= (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD)
> +			| FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD));
>  	else
> -		reg |= (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> -			   (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT);
> +		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
> +			| FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP));
>  
>  	ret = rt1711h_write8(chip, TCPC_ROLE_CTRL, reg);
>  	if (ret < 0)
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 31d21ccf662b..552d074429f0 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -68,10 +68,8 @@
>  #define TCPC_ROLE_CTRL_RP_VAL_DEF	0x0
>  #define TCPC_ROLE_CTRL_RP_VAL_1_5	0x1
>  #define TCPC_ROLE_CTRL_RP_VAL_3_0	0x2
> -#define TCPC_ROLE_CTRL_CC2_SHIFT	2
> -#define TCPC_ROLE_CTRL_CC2_MASK		0x3
> -#define TCPC_ROLE_CTRL_CC1_SHIFT	0
> -#define TCPC_ROLE_CTRL_CC1_MASK		0x3
> +#define TCPC_ROLE_CTRL_CC2		GENMASK(3, 2)
> +#define TCPC_ROLE_CTRL_CC1		GENMASK(1, 0)
>  #define TCPC_ROLE_CTRL_CC_RA		0x0
>  #define TCPC_ROLE_CTRL_CC_RP		0x1
>  #define TCPC_ROLE_CTRL_CC_RD		0x2
> @@ -176,8 +174,7 @@
>  
>  #define tcpc_presenting_rd(reg, cc) \
>  	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> -	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> -	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> +	 FIELD_GET(TCPC_ROLE_CTRL_## cc, reg) == TCPC_ROLE_CTRL_CC_RD)
>  
>  struct tcpci;
>  
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

