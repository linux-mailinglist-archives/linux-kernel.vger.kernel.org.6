Return-Path: <linux-kernel+bounces-198966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4418D7FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E3EB249A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335682C7E;
	Mon,  3 Jun 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWLmI6CT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C581735;
	Mon,  3 Jun 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409457; cv=none; b=Ti+JhjL4xO9HwXk4buACnl7b6TeyDQDYCHxNdQdJurPeQ1oWXFR3ce3Aab1UfR8Stz6Rmy2gSnNXSunQhkV3usWqhZI17xIxflyC0bz81Lb7EO84Mg4THsKnj8qhMSJMsZ1jdnPn/nVn4Jh2oz9RKDtGwrDb3L4RLEtz8wGAMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409457; c=relaxed/simple;
	bh=f+W5jOGxLJ2ONFfis6RiM4MTi/XGMzqB73fbGqWIWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTiutGAhfiYZ99XXiRvHMEZ9oB2POuqWft/jUUEnoa1zcosGpMt8fhwi/+SvqQ7l7Xrl0dzHq0V8wKloXntDLRszJUSCj7Z8gRlA47geK4DqUJsbmXe0ZfTatEeArfAJylZoKsvW4L6P3hSPV9y6zEncR3dB1ItSUBKeDFSE/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWLmI6CT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717409455; x=1748945455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+W5jOGxLJ2ONFfis6RiM4MTi/XGMzqB73fbGqWIWDY=;
  b=iWLmI6CT5ofUe149UaWYk+yBzUhZexX4KMw4xuPyX4YSS8diq3nn8i3Y
   ZRd2ZtHdSxRCcrfkrzE7Zv40YzR/OYPCy0U7DARom5kwrXQUxqknmub5T
   lmIvd2hKSzLk1G3cn5TAs5Mel3N7zMHPDBpQhsJ9hyoBtZnavAV/Q/p2r
   LVlSZ9Eg8D0njcl8wwDpjojmI8MxZKe1SEtXuSSfZTysK6musbbiPoQ2G
   dSmleUeBMJ30aguPd+eghTlqRsQJXsWTkmWaRsUqU1LT4B2DqRjEeOKNk
   UJbH4oCRwhg6ybXHwxeVEP+5Y1Ijjru/3dtkdDbRz7TeIFCltGSGJop5g
   Q==;
X-CSE-ConnectionGUID: xUWw2ITLReiZd44dZghJzg==
X-CSE-MsgGUID: DJBzUZkNT5iqvOCtBTXojw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13760352"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13760352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:10:50 -0700
X-CSE-ConnectionGUID: HKVzVmnUS8Wg9qUz9TNufA==
X-CSE-MsgGUID: rNG5L8TeQ3im08l4J9VCCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36907601"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa009.jf.intel.com with SMTP; 03 Jun 2024 03:10:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Jun 2024 13:10:45 +0300
Date: Mon, 3 Jun 2024 13:10:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	jthies@google.com, bleung@chromium.org, abhishekpandit@chromium.org,
	saranya.gopal@intel.com, lk@c--e.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmalani@chromium.org
Subject: Re: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
Message-ID: <Zl2WpdJvH4koI2mK@kuha.fi.intel.com>
References: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
 <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>

On Fri, May 24, 2024 at 11:58:21AM +0100, Diogo Ivo wrote:
> UCSI version 2.0 and above define new PPM notifications. Update the
> logic to determine which notifications to enable taking into account
> these changes.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cb52e7b0a2c5..0cc1c49da4a0 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1664,7 +1664,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  
>  static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>  {
> -	u8 features = ucsi->cap.features;
> +	u16 features = ucsi->cap.features;
>  	u64 ntfy = UCSI_ENABLE_NTFY_ALL;
>  
>  	if (!(features & UCSI_CAP_ALT_MODE_DETAILS))
> @@ -1680,6 +1680,23 @@ static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>  	if (!(features & UCSI_CAP_PD_RESET))
>  		ntfy &= ~UCSI_ENABLE_NTFY_PD_RESET_COMPLETE;
>  
> +	if (ucsi->version <= UCSI_VERSION_1_2)
> +		return ntfy;
> +
> +	ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
> +
> +	if (features & UCSI_CAP_GET_ATTENTION_VDO)
> +		ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
> +
> +	if (features & UCSI_CAP_FW_UPDATE_REQUEST)
> +		ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
> +
> +	if (features & UCSI_CAP_SECURITY_REQUEST)
> +		ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
> +
> +	if (features & UCSI_CAP_SET_RETIMER_MODE)
> +		ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
> +
>  	return ntfy;
>  }
>  
> -- 
> 2.45.1

-- 
heikki

