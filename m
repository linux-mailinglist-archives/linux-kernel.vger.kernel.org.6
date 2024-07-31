Return-Path: <linux-kernel+bounces-269060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD4942CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4971F21F67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B371B1422;
	Wed, 31 Jul 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m75s8vF3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EC1AD9ED;
	Wed, 31 Jul 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424168; cv=none; b=rHgND+7FwuWt7AzULY0pOjw4sWlqIYjHv78lHJ/Ks5/1PQI2yg1ns/2uZ7WZRMbzEYG6Cpug4ZUb4VKzFr58iZ4wB3pwLmBQD9SxN8MhrPrF5h6Sq+ySvi40VvIFqYLoOPqyOpo4RW9ZZKB6qkifUBoDFq0rXFtsmobXk+IXN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424168; c=relaxed/simple;
	bh=0wbaklBvidhgCVWydtP1JSplbMUzjg/Z9mE0IUa3ldU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY9baU2KrduJ4RVUQY9KnYvTqn57qj4+I9G3RILImsgLppCAZeS34iNat+HBIVevKxqll/ShQ9NNoiLCaEA/xtGx50gmTrX2epGOuTfbddfGSs1jdnNh7tF0dDy+V6TidmxZ7B77qhgknfDpgRZ92FBqdiU1SdTBXpT1nw3qcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m75s8vF3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722424167; x=1753960167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0wbaklBvidhgCVWydtP1JSplbMUzjg/Z9mE0IUa3ldU=;
  b=m75s8vF3gDHfStOT2Cgk1TFGCHZUK8fwSI7tfp8E5mx6/44CWz3fZkrl
   nDMDVLb2+bHWbkIgusD3ely7DYGNrZDGraH5nd/cLN2Jk0C2VBnEtAvZl
   Ao5I+DKmPXrp4x8epmIp5EHEOZri16Sl9UI7mlufTPq8Vxo5Xyyzzm72p
   ZzXYYLw/kfYPv6nPBe0LvhqckgnTFrbM5d4tycV2zDqDNIsEQVPkCFc71
   gjQtmgWk1+p2TfFvw9h2D8R6kNLpIPMkjgeMRYAzrkF9Lm1dnLppO21By
   A4fKl5vRdiquOL2spJObDtJZw8VIF46CH+Quclc/tG6UFYAe4Q8zoMuVR
   g==;
X-CSE-ConnectionGUID: N17NXhqJTLGsxThN3H+ffA==
X-CSE-MsgGUID: C7llhsmlR+ehV9fh2qwA+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="30874884"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="30874884"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:09:26 -0700
X-CSE-ConnectionGUID: WgJDqCthRY+KfmbqBuUNag==
X-CSE-MsgGUID: fkLd8JwERrODbQeO9SMWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59501647"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 31 Jul 2024 04:09:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 14:09:22 +0300
Date: Wed, 31 Jul 2024 14:09:21 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] usb: typec: tcpm/tcpci_maxim: sort TCPC_ALERT_MASK
 values by bit
Message-ID: <ZqobYaPsEie2k9R+@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-8-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-8-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:15AM +0100, André Draszik wrote:
> This makes it easier to see what's missing and what's being programmed.
> 
> While at it, add brackets to help with formatting and remove a comment
> that doesn't add much value.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index 87102b4d060d..ad9bb61fd9e0 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -97,11 +97,13 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  	if (ret < 0)
>  		return;
>  
> -	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
> -		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
> -		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
> -		/* Enable Extended alert for detecting Fast Role Swap Signal */
> -		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS | TCPC_ALERT_FAULT;
> +	alert_mask = (TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
> +		      TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
> +		      TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
> +		      TCPC_ALERT_CC_STATUS |
> +		      TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS |
> +		      TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF |
> +		      TCPC_ALERT_FAULT);
>  
>  	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
>  	if (ret < 0) {
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

