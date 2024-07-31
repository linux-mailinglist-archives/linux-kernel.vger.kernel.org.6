Return-Path: <linux-kernel+bounces-269173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC06942EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6D428D081
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FA1AE869;
	Wed, 31 Jul 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtOH50iZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BB193072;
	Wed, 31 Jul 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429616; cv=none; b=XiF819noTzF+/3q5u8v0MbkYFECAxlSVmG0bMq2fB9zuRi6OlH08Kzm07KgTzD2+RDfoXuIyIwf4T3SDKWFMeAewgOPeVVtCNkXwwByzqrV+/3IAFsf8PtzJBfVwdYh2IBEVnbfDvsvJ2RZ0XqxQYkQPSSSeG6lPPEWOEL5YAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429616; c=relaxed/simple;
	bh=FxnlBgihM1imi374ks+zuT2HnkmBCvGd1ZVIuKGBOGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icemep5OyyL7wwPdzFBgnDiNBLCTnuqMdAfOHjM3XtJn1AUxP1nHADBIMBu5vhfdvuLMHJ29pB675h1p+E6zFLxqECq+lWUKI0JFsfCYjv1vSWAnwf1wvzxK/Hv2u07cLmQBkfsA7MyjIzxU1oIv0jscnbrIDmhvYkY1etEOO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtOH50iZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722429615; x=1753965615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FxnlBgihM1imi374ks+zuT2HnkmBCvGd1ZVIuKGBOGs=;
  b=PtOH50iZ+hmuaNfAzMnpW2gOPCOJ0vHq+IfzYzTQcc+cTJUdd3733KJE
   +BVbw/Gi1nxUzcLPKp30TWMMDGVRq8Qs+zJD6xHeBviKwLHpspQ+/Ybdg
   qARX9/Fx4AFuJ2rHygWbKlVndOAamevCWu95p29nMU5zMu4RXAQWuYbkM
   zNsMFok3CVQYE+AF+/+4lZKmO61ppCFpl9tZauZeIfFk3/bHnMTWymg7v
   dxK2c97KEL1V9XVUk+lg8Bk4wLgCZ9QE5OvVQe0W2K1LUSb0T1Tc5aSAH
   ymi/WVgoN9POkTE1wzpbCHnAJ+x+5zFWTCOZSJTOF1wrP8lmJHvetHJAj
   Q==;
X-CSE-ConnectionGUID: zSmxhF/bTMG3nnNsAouwgQ==
X-CSE-MsgGUID: Lumhl1aiR9aXKe1y0pUeKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19997297"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="19997297"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:40:14 -0700
X-CSE-ConnectionGUID: m5w0EDkCSUeFWTlspJ8+Vg==
X-CSE-MsgGUID: 58Ks5F4tR1KTLrlu2NYIzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="58997853"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa005.fm.intel.com with SMTP; 31 Jul 2024 05:40:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:40:10 +0300
Date: Wed, 31 Jul 2024 15:40:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] usb: typec: tcpm/tcpci_maxim: use GENMASK() for
 TCPC_VENDOR_ADC_CTRL1 register
Message-ID: <Zqowqn5hkkZucJ8r@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-13-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-13-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:20AM +0100, André Draszik wrote:
> Convert register TCPC_VENDOR_ADC_CTRL1 to using GENMASK() and
> FIELD_PREP() so as to keep using a similar approach throughout the code
> base and make it arguably easier to read.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 7 ++++---
>  drivers/usb/typec/tcpm/tcpci_maxim.h       | 3 +--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index cf9887de96c9..7bfec45e8f4f 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -76,8 +76,8 @@ static int max_contaminant_read_adc_mv(struct max_tcpci_chip *chip, enum fladc_s
>  	int ret;
>  
>  	/* Channel & scale select */
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK,
> -				 channel << ADC_CHANNEL_OFFSET);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL,
> +				 FIELD_PREP(ADCINSEL, channel));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -96,7 +96,8 @@ static int max_contaminant_read_adc_mv(struct max_tcpci_chip *chip, enum fladc_s
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK, 0);
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL,
> +				 FIELD_PREP(ADCINSEL, 0));
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 34076069444f..a41ca9e7ad08 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -37,8 +37,7 @@
>  #define WTRCYCLE_4_8_S                          1
>  
>  #define TCPC_VENDOR_ADC_CTRL1                   0x91
> -#define ADCINSEL_MASK                           GENMASK(7, 5)
> -#define ADC_CHANNEL_OFFSET                      5
> +#define ADCINSEL                                GENMASK(7, 5)
>  #define ADCEN                                   BIT(0)
>  
>  enum contamiant_state {
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

