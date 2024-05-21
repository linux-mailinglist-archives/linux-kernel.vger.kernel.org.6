Return-Path: <linux-kernel+bounces-185035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E68CAFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967531F22AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A07EF06;
	Tue, 21 May 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGMmqm7c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E355783;
	Tue, 21 May 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299490; cv=none; b=tcKBnP/CEfDZSrUbX16bNWCl6rc81NbabMabafBXVxaycY4w/joZR5DdYQ0bxUIIy0aI2tRFiXqyGrDCuyGJqrdZNntgjYrbgIZalm+rV1ProNnZO24YF1bjkFwKy6xpujI9vnTTOY+LhKeO0ectrQXhxieK0hl3XkuFiyhqhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299490; c=relaxed/simple;
	bh=/Hd/hqTFsk9NCSs8oalLv788+rthDwiVYXez3GwSjEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBmMXZRbK5Qcfe+dYjBekhzTT/bRjvWdfDLskcmiCH9gKBJhw0/1JIZNJFxd2pAvZnTh1lX+O+Wy6TeeOfww/rD9nathf7nl/n5HYIBILOuDwvZ42EP1ckQ+PNMjnh8WUdeQ7lHxrPPtdfESv5RpO+yYm4ZH4IJ4LBWzWV6+Fpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGMmqm7c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716299489; x=1747835489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Hd/hqTFsk9NCSs8oalLv788+rthDwiVYXez3GwSjEc=;
  b=RGMmqm7crKEIS7SYsL0ryVv7n/KmfFQA1f2OcK3NihgnNZU8u5IHfcC4
   HXiB6FEWVMbXQARxSQeNAYUhKVsThACIhIxy/DkT/iys8X0Br2IzSP4hB
   hziv33foMc+1h3BkdCT143jF5DSq95Y25BnRODE5gRhqd5dUy2l4aIEDR
   k7m8MPNjJIAi/0MDW4+PspHVA7a9Q7+BooA1FpH81f1judM+6ODNG3iFB
   +5Ew1FY4j85YtnJLTU7ZcNjr3APD3EQCdtkHY6z69nMiwin55Tn+MznGe
   Jxmd3uyVrGiMBOcEcxaJaLSO83wmMPB+q41eYcKYp08EBhK8q2iXJR2bq
   Q==;
X-CSE-ConnectionGUID: IbC/W18qRtmOLeWFyiQxiA==
X-CSE-MsgGUID: bsCRWzU5T7ydiIiUdcETdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16320039"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16320039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:51:28 -0700
X-CSE-ConnectionGUID: qJ0r4cG4TGqzzhu3VyiI7w==
X-CSE-MsgGUID: AbBacB3XQdaM1z4OzNPbMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33052469"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 21 May 2024 06:51:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 May 2024 16:51:21 +0300
Date: Tue, 21 May 2024 16:51:21 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	bleung@chromium.org, pmalani@chromium.org, jthies@google.com,
	abhishekpandit@chromium.org, lk@c--e.de, saranya.gopal@intel.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Add new notification bits
Message-ID: <Zkym2UtGXp8GwuaK@kuha.fi.intel.com>
References: <3filrg6mbh6m3galir7ew5juakd25uvksimr7mqd7uc5td3xza@fdvxcewozqeh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3filrg6mbh6m3galir7ew5juakd25uvksimr7mqd7uc5td3xza@fdvxcewozqeh>

On Wed, May 08, 2024 at 04:43:40PM +0100, Diogo Ivo wrote:
> Newer UCSI versions defined additional notification bits that can be
> enabled by the PPM. Add their definitions and convert all definitions
> to BIT_ULL() as we now cross the 32-bit boundary.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.h | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index c4d103db9d0f..e70cf5b15562 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -124,18 +124,23 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>  #define UCSI_ACK_COMMAND_COMPLETE		BIT(17)
>  
>  /* SET_NOTIFICATION_ENABLE command bits */
> -#define UCSI_ENABLE_NTFY_CMD_COMPLETE		BIT(16)
> -#define UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE	BIT(17)
> -#define UCSI_ENABLE_NTFY_PWR_OPMODE_CHANGE	BIT(18)
> -#define UCSI_ENABLE_NTFY_CAP_CHANGE		BIT(21)
> -#define UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE	BIT(22)
> -#define UCSI_ENABLE_NTFY_PD_RESET_COMPLETE	BIT(23)
> -#define UCSI_ENABLE_NTFY_CAM_CHANGE		BIT(24)
> -#define UCSI_ENABLE_NTFY_BAT_STATUS_CHANGE	BIT(25)
> -#define UCSI_ENABLE_NTFY_PARTNER_CHANGE		BIT(27)
> -#define UCSI_ENABLE_NTFY_PWR_DIR_CHANGE		BIT(28)
> -#define UCSI_ENABLE_NTFY_CONNECTOR_CHANGE	BIT(30)
> -#define UCSI_ENABLE_NTFY_ERROR			BIT(31)
> +#define UCSI_ENABLE_NTFY_CMD_COMPLETE		BIT_ULL(16)
> +#define UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE	BIT_ULL(17)
> +#define UCSI_ENABLE_NTFY_PWR_OPMODE_CHANGE	BIT_ULL(18)
> +#define UCSI_ENABLE_NTFY_ATTENTION		BIT_ULL(19)
> +#define UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ	BIT_ULL(20)
> +#define UCSI_ENABLE_NTFY_CAP_CHANGE		BIT_ULL(21)
> +#define UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE	BIT_ULL(22)
> +#define UCSI_ENABLE_NTFY_PD_RESET_COMPLETE	BIT_ULL(23)
> +#define UCSI_ENABLE_NTFY_CAM_CHANGE		BIT_ULL(24)
> +#define UCSI_ENABLE_NTFY_BAT_STATUS_CHANGE	BIT_ULL(25)
> +#define UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER	BIT_ULL(26)
> +#define UCSI_ENABLE_NTFY_PARTNER_CHANGE		BIT_ULL(27)
> +#define UCSI_ENABLE_NTFY_PWR_DIR_CHANGE		BIT_ULL(28)
> +#define UCSI_ENABLE_NTFY_SET_RETIMER_MODE	BIT_ULL(29)
> +#define UCSI_ENABLE_NTFY_CONNECTOR_CHANGE	BIT_ULL(30)
> +#define UCSI_ENABLE_NTFY_ERROR			BIT_ULL(31)
> +#define UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE	BIT_ULL(32)
>  #define UCSI_ENABLE_NTFY_ALL			0xdbe70000
>  
>  /* SET_UOR command bits */
> -- 
> 2.45.0

-- 
heikki

