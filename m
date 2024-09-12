Return-Path: <linux-kernel+bounces-326519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF60976956
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679C0B2453F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C61A42DA;
	Thu, 12 Sep 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFfh1/y/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486619F42D;
	Thu, 12 Sep 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145033; cv=none; b=C9B3cFGw8/vb15yYDFAlYza7uTIWZTg503Zufyx52zf6uudNbuSaK/hPEE5swEO0WEALk0iUAegSvZX3S7BYnTzrFa7izPI2XoDJb6xsJ8GrevU8TVn7q61Qm1q9BpFnSvwgnUkfC/z5vkwm+9ZC6j6BJcNEux/+qRtBEerM/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145033; c=relaxed/simple;
	bh=IDkxlvm6XZtP/KDhyz89G+TMnQ4CIX8A9FuQEJL5VmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8ZF4SimLevwc4p0IG1tbcp8JUCRhRMejLxdA4pJvZrg7rwzjj+F+FA9jcwzCG+7npcacq5IT/9qvfJFV07irgT5AstgOGjFLusq3rLLMQr3SAiT8wb/OVSfu2raywGkeql9DuNSfNr9tKd95llC7hJAkUWaJ/z7vdIU8dGiVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFfh1/y/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726145032; x=1757681032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDkxlvm6XZtP/KDhyz89G+TMnQ4CIX8A9FuQEJL5VmU=;
  b=mFfh1/y/ySrxEKXmtrlSFx10yGWWwDsU2IkAuM6BVNURPF6yRcFRwLPv
   ExwgWAdMnFmzPaRpHEWe1InXa5+Rmzp7rPJCv0GdDhf/R6/AaxSbXzsdm
   dNPDJujqrDghq9zhtBZ3GrEMCJdZl8heeguYvqt3KZY14h0sS0CwsMiHq
   M6204FPIu6z16PIu0nXQ9zjhmMMIS60byVqsMDZbfkutfcOTxLf0ndyER
   BnbqFo5uYCflZjK2s8eSB4YVM+MAAshdZKJyAfJSZg+nB9plVEoQeAlbK
   tz7Y0jB69JAPx+ra02xeUw0peWWkvJiLv0jgPX5qiynGNvmku/x4udy5d
   w==;
X-CSE-ConnectionGUID: cZ0QDl8HQESlh+6a7tNdVQ==
X-CSE-MsgGUID: 9y4KksxgQZO/9wqGB5cfCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25189029"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25189029"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:43:51 -0700
X-CSE-ConnectionGUID: op32tmxCSjatLMdfJRaPeQ==
X-CSE-MsgGUID: QRSUhwtVTfGvAHGGi5e5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67988731"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 12 Sep 2024 05:43:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Sep 2024 15:43:46 +0300
Date: Thu, 12 Sep 2024 15:43:46 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v5] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZuLiAsliEq66XjYP@kuha.fi.intel.com>
References: <20240912074132.722855-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912074132.722855-1-lk@c--e.de>

On Thu, Sep 12, 2024 at 09:41:32AM +0200, Christian A. Ehrhardt wrote:
> If the busy indicator is set, all other fields in CCI should be
> clear according to the spec. However, some UCSI implementations do
> not follow this rule and report bogus data in CCI along with the
> busy indicator. Ignore the contents of CCI if the busy indicator is
> set.
> 
> If a command timeout is hit it is possible that the EVENT_PENDING
> bit is cleared while connector work is still scheduled which can
> cause the EVENT_PENDING bit to go out of sync with scheduled connector
> work. Check and set the EVENT_PENDING bit on entry to
> ucsi_handle_connector_change() to fix this.
> 
> Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
> This ensures that the command is cancelled even if ->sync_control
> returns an error (most likely -ETIMEDOUT).
> 
> Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  V1 -> V2: Split out the ucsi_acpi.c part
>  V2 -> V3: Dropped the ucsi_acpi.c part due to conflicts
>  V3 -> V4: Additional fix for command cancelling
>  V4 -> V5: Rebased onto usb-next
> 
>  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 35dce4057c25..e0f3925e401b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -38,6 +38,10 @@
>  
>  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  {
> +	/* Ignore bogus data in CCI if busy indicator is set. */
> +	if (cci & UCSI_CCI_BUSY)
> +		return;
> +
>  	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  
> @@ -103,15 +107,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
>  		return -EINVAL;
>  
>  	ret = ucsi->ops->sync_control(ucsi, command);
> -	if (ret)
> -		return ret;
> -
> -	ret = ucsi->ops->read_cci(ucsi, cci);
> -	if (ret)
> -		return ret;
> +	if (ucsi->ops->read_cci(ucsi, cci))
> +		return -EIO;
>  
>  	if (*cci & UCSI_CCI_BUSY)
>  		return ucsi_run_command(ucsi, UCSI_CANCEL, cci, NULL, 0, false) ?: -EBUSY;
> +	if (ret)
> +		return ret;
>  
>  	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
>  		return -EIO;
> @@ -1197,6 +1199,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  
>  	mutex_lock(&con->lock);
>  
> +	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
> +		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
> +			     __func__);
> +
>  	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
>  
>  	ret = ucsi_send_command_common(ucsi, command, &con->status,
> -- 
> 2.43.0

-- 
heikki

