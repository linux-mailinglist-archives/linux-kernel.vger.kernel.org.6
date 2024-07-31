Return-Path: <linux-kernel+bounces-268984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E801942BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBEB2832D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F81AC422;
	Wed, 31 Jul 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUsb2CbT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18398801;
	Wed, 31 Jul 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421602; cv=none; b=loVGsyBKwfbXL7hatuoHDaESHy6PPOho/Tgw+c0l/fMMvviEq6wTlMBUavbazNVOgCvi/14iTrNshJHx7Lb0adpf8WNKRKqfPG3E+Szmn3i13PY47QxFBQTb1pXGIY82EWksMQ68G7d6qtw2fqoRbMFithePH+hFHZIwKAKu4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421602; c=relaxed/simple;
	bh=PA/f1fKRKjwR53a3zPGAlSjFgGeZjIVnBRRR4B3OWmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXCJ1dTml61lT5mF6u36C/0Tj0cMYSqgiDitJD5GWDimwXAicgbcQqulyU9SGLjv0RckUaIwC5KiXpWOB/vXH4x6iW5mLHj7uSizorA9Si4D+33DbDJvhP0W0i1SDC2p7xmYXKFxQ8HZ72qPl8zPs56hX1iwkXiO756ndzvZh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUsb2CbT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722421599; x=1753957599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PA/f1fKRKjwR53a3zPGAlSjFgGeZjIVnBRRR4B3OWmE=;
  b=hUsb2CbTEJUV88jjyaqsw6Ov5ete1PSNirkgSerwkk7vF0Akyz21BjCr
   Q0AZjaGpsRvqb8wbixzZs0ETnHI637P1siEn8u0yf5EvfknY22lpkLJVR
   TC7ncySXTqHQZo+MywCxxH9lJVW9hqU8VHTMJA11FOKdBOkhhClVeYDy1
   SdJvoqu/18BylIUAGU4UF7ud5ZbKuomOo5YXE1f2lnpEL7ErPPIha1mf/
   G00JO+OAli/LAbcD5G0oxEHxNZqiGw4Q0VWzEsL/cJh2PPCTBmW5RHP7O
   ILAhx/C99DUGxqtJ705YQrqEHWrFzlMCyrsyrtfaqEmfdUtsDLZfGYrln
   Q==;
X-CSE-ConnectionGUID: L2MSMAGnT8W9jABYRojGOw==
X-CSE-MsgGUID: tuTBm+gSSYGDHWx+4oC6LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20413669"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20413669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 03:26:39 -0700
X-CSE-ConnectionGUID: AZBWhX5vR6i1OChjVXgpVw==
X-CSE-MsgGUID: KhhyT8gsSpiaqXN1qvToLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85572001"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa001.fm.intel.com with SMTP; 31 Jul 2024 03:26:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 13:26:35 +0300
Date: Wed, 31 Jul 2024 13:26:35 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] usb: typec: tcpci: use GENMASK() for
 TCPC_CC_STATUS_CC[12]
Message-ID: <ZqoRW1qIqPFrQA4M@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-3-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-3-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:10AM +0100, André Draszik wrote:
> The existing code here, particularly in maxim_contaminant.c, is
> arguably quite hard to read due to the open-coded masking and shifting
> spanning multiple lines.
> 
> Use GENMASK() and FIELD_GET() instead, which arguably make the code
> much easier to follow.
> 
> While at it, use the symbolic name TCPC_CC_STATE_SRC_OPEN for one
> instance of open-coded 0x0.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 8 +++-----
>  drivers/usb/typec/tcpm/tcpci.c             | 7 +++----
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c     | 7 +++----
>  include/linux/usb/tcpci.h                  | 8 +++-----
>  4 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index f8504a90da26..e7687aeb69c0 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -5,6 +5,7 @@
>   * USB-C module to reduce wakeups due to contaminants.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/irqreturn.h>
>  #include <linux/module.h>
> @@ -48,11 +49,8 @@ enum fladc_select {
>  #define STATUS_CHECK(reg, mask, val)	(((reg) & (mask)) == (val))
>  
>  #define IS_CC_OPEN(cc_status) \
> -	(STATUS_CHECK((cc_status), TCPC_CC_STATUS_CC1_MASK << TCPC_CC_STATUS_CC1_SHIFT,  \
> -		      TCPC_CC_STATE_SRC_OPEN) && STATUS_CHECK((cc_status),               \
> -							      TCPC_CC_STATUS_CC2_MASK << \
> -							      TCPC_CC_STATUS_CC2_SHIFT,  \
> -							      TCPC_CC_STATE_SRC_OPEN))
> +	(FIELD_GET(TCPC_CC_STATUS_CC1, cc_status) == TCPC_CC_STATE_SRC_OPEN \
> +	 && FIELD_GET(TCPC_CC_STATUS_CC2, cc_status) == TCPC_CC_STATE_SRC_OPEN)
>  
>  static int max_contaminant_adc_to_mv(struct max_tcpci_chip *chip, enum fladc_select channel,
>  				     bool ua_src, u8 fladc)
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 8a18d561b063..ce11a154c7dc 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -5,6 +5,7 @@
>   * USB Type-C Port Controller Interface.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -241,12 +242,10 @@ static int tcpci_get_cc(struct tcpc_dev *tcpc,
>  	if (ret < 0)
>  		return ret;
>  
> -	*cc1 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC1_SHIFT) &
> -				 TCPC_CC_STATUS_CC1_MASK,
> +	*cc1 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC1, reg),
>  				 reg & TCPC_CC_STATUS_TERM ||
>  				 tcpc_presenting_rd(role_control, CC1));
> -	*cc2 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC2_SHIFT) &
> -				 TCPC_CC_STATUS_CC2_MASK,
> +	*cc2 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC2, reg),
>  				 reg & TCPC_CC_STATUS_TERM ||
>  				 tcpc_presenting_rd(role_control, CC2));
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 67422d45eb54..c6dbccf6b17a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -5,6 +5,7 @@
>   * Richtek RT1711H Type-C Chip Driver
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
> @@ -195,12 +196,10 @@ static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
>  	if (ret < 0)
>  		return ret;
>  
> -	cc1 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC1_SHIFT) &
> -				TCPC_CC_STATUS_CC1_MASK,
> +	cc1 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC1, status),
>  				status & TCPC_CC_STATUS_TERM ||
>  				tcpc_presenting_rd(role, CC1));
> -	cc2 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC2_SHIFT) &
> -				TCPC_CC_STATUS_CC2_MASK,
> +	cc2 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC2, status),
>  				status & TCPC_CC_STATUS_TERM ||
>  				tcpc_presenting_rd(role, CC2));
>  
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index d27fe0c22a8b..31d21ccf662b 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -92,11 +92,9 @@
>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_TERM_RP		0
>  #define TCPC_CC_STATUS_TERM_RD		1
> +#define TCPC_CC_STATUS_CC2		GENMASK(3, 2)
> +#define TCPC_CC_STATUS_CC1		GENMASK(1, 0)
>  #define TCPC_CC_STATE_SRC_OPEN		0
> -#define TCPC_CC_STATUS_CC2_SHIFT	2
> -#define TCPC_CC_STATUS_CC2_MASK		0x3
> -#define TCPC_CC_STATUS_CC1_SHIFT	0
> -#define TCPC_CC_STATUS_CC1_MASK		0x3
>  
>  #define TCPC_POWER_STATUS		0x1e
>  #define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
> @@ -256,7 +254,7 @@ static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
>  		if (sink)
>  			return TYPEC_CC_RP_3_0;
>  		fallthrough;
> -	case 0x0:
> +	case TCPC_CC_STATE_SRC_OPEN:
>  	default:
>  		return TYPEC_CC_OPEN;
>  	}
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

