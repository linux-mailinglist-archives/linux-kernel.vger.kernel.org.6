Return-Path: <linux-kernel+bounces-269156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68AE942E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27A528AE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC81B010C;
	Wed, 31 Jul 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvozGt9Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EA1AD410;
	Wed, 31 Jul 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428949; cv=none; b=DUOvmy9L8IDcSmtcz26LKOEsca8b8TiXngGtf2RMaO5zRCdlIUeEM2azhTY0ECJgIetp/P7KEe5uFzWgLZSurwbz1aohxtkYEWe1Ge8qNSD540VCMGoVGrPXS87QM8kwU+8+0EvA4NqOcpcuEzdLsV2Shi5elSJKVTiAjJEFWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428949; c=relaxed/simple;
	bh=Mapy/o2+Q1rlGdMpUO0g9AAfTmFz2LFYRFwRxo4DL5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuU9Jm5Mx007KM2IQw8SE6+dEXUIq9CkNmuePbMNAaZdG05RyTONeOoxJ8daQYIqEAGn2vAnOgLzxB4L4tuPVxl0jwBehKU67tsltlEXEJDBMiBj0mnFT394YrqalyR/TmL0wHtuIKsCKMh5aR++uZ9abkMltYFjs6zjvkydZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvozGt9Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722428947; x=1753964947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Mapy/o2+Q1rlGdMpUO0g9AAfTmFz2LFYRFwRxo4DL5w=;
  b=AvozGt9ZTusHpYbJH4gNDWZ9Or06p8w9GjyDADCmWXALTdQwp/qo3xm4
   YUNJRk/lfIgmGWt93GWqoBKdNAMlQyjNGqaTFJyk+XdKTy+pPy338uDZB
   SszovRAnQj4dtTdk1vanytZ08GAh9wvLBQhl6Dv+ahaD/m1k9Xpdg3kqM
   aCOVqegcb6C1dMaFwoQ1aNpTBT5307GobUe4+5fUj2SsXenxAkV0y2uLH
   Qyqw63mJUAh4DDVAV1Bm2fi4Eyedi4xriR84ULK1L5LRx6bcRrpZ3NNgC
   qFUGhPV4VuTHY1vmd4uqe8QksAMw83HZCpz+mcUTKlUKw3pkGxkMCHM3S
   Q==;
X-CSE-ConnectionGUID: oIB6Y9YxSnOLOLbfnUMkrQ==
X-CSE-MsgGUID: b5e+0usyRaa+8j+X0UcFnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20149980"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20149980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:29:06 -0700
X-CSE-ConnectionGUID: IUCW0VopQq2Dli9EgPpbPA==
X-CSE-MsgGUID: DHGZRiAkRCGud3xp8OujDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="58995736"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa005.fm.intel.com with SMTP; 31 Jul 2024 05:29:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:29:02 +0300
Date: Wed, 31 Jul 2024 15:29:02 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] usb: typec: tcpm/tcpci_maxim: drop STATUS_CHECK()
Message-ID: <ZqouDgCTPrQX4B+9@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-10-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-10-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:17AM +0100, André Draszik wrote:
> Only one user of STATUS_CHECK() remains, and the code can actually be
> made more legible by simply avoiding the use of that wrapper macro,
> allowing to also drop the macro altogether.
> 
> Do so.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index e7687aeb69c0..8ac8eeade277 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -46,8 +46,6 @@ enum fladc_select {
>  #define READ1_SLEEP_MS			10
>  #define READ2_SLEEP_MS			5
>  
> -#define STATUS_CHECK(reg, mask, val)	(((reg) & (mask)) == (val))
> -
>  #define IS_CC_OPEN(cc_status) \
>  	(FIELD_GET(TCPC_CC_STATUS_CC1, cc_status) == TCPC_CC_STATE_SRC_OPEN \
>  	 && FIELD_GET(TCPC_CC_STATUS_CC2, cc_status) == TCPC_CC_STATE_SRC_OPEN)
> @@ -368,7 +366,7 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
>  		}
>  		return false;
>  	} else if (chip->contaminant_state == DETECTED) {
> -		if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) {
> +		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
>  			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
>  			if (chip->contaminant_state == DETECTED) {
>  				max_contaminant_enable_dry_detection(chip);
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

