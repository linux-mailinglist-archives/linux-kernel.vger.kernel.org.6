Return-Path: <linux-kernel+bounces-326056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A79761F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DE11F2341C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4E18BC22;
	Thu, 12 Sep 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZg3tpNx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C964282FB;
	Thu, 12 Sep 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124218; cv=none; b=lA1mus9LCVmH7CenP7YcoAJPwUUGPv2xs1UCPARbJt3gQiL7MmH2tflK3EVHN5/N/nUAlxU9e+V1HEEJ1rd5QfRrit8C8CCMQl290afdrqe8Yljxt7z3f7J10FRJBg14g6wJJ9OWmtgAXS/pxgW8nfTDCg1lbZdeCVVsiOuUBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124218; c=relaxed/simple;
	bh=pAtNUJ33O0bK5joXiQ65JiDytqxm99aC47Jxhgt84nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4G7jFL6DpmOoQWrka7CCbTCq9jJE8/mItHhOGjXW6mof3RuvybN8U/4wyHsuP0D9LWHhntIiCt24gformeCPBSxqN/bdDsQwP0PQENgGbjbTXuN+4sXP1Xe+a0EN4qp8Y3hG7inOeSQWV7arlQQfi3VRfyn3bj8vtWoMSXETVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZg3tpNx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726124217; x=1757660217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pAtNUJ33O0bK5joXiQ65JiDytqxm99aC47Jxhgt84nA=;
  b=iZg3tpNxHfxV2ebiDy+LhWnH2hZKqblPcGLiXF6g02vZBaNdFAdNEWxs
   n/O+5j7wnH6omUamVaLIgX6qfYXGRaFjtbghWLlzEXjUcBqBzebGHkMZ3
   Ggevck+z34ptJ9H6IAXbkm9SUpHx4+WWu5P730EbkSjOG2OfPJ8VU9Vvt
   Vb/gjKpEe/+f1xYC3fE0Eygz88JsCtJVcYEvyk4hZFVzWx/p3pDhLAhf5
   Tt1nlFR4ax1UI0s3+zctMqFE2HzphaHOLAxG5c9rVH0hi6tKPmQrhVnnM
   DdEsT6oh9/mi0JeNxodqiHL/UE2rSitBZMbzyN/YiqsNMeTHvsfz1THlj
   g==;
X-CSE-ConnectionGUID: qQlCvgzESzWHfuohyYyQfw==
X-CSE-MsgGUID: d2l6MwdSQpCDLmBEk6Yh+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24781667"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24781667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 23:56:57 -0700
X-CSE-ConnectionGUID: 2BDirs9cQA2vDTbuoj2Tkg==
X-CSE-MsgGUID: gDwfCEQ1Shq2eXDir4r03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67338633"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 11 Sep 2024 23:56:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Sep 2024 09:56:52 +0300
Date: Thu, 12 Sep 2024 09:56:52 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZuKQtIfACKVQxol0@kuha.fi.intel.com>
References: <20240912054433.721651-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912054433.721651-1-lk@c--e.de>

On Thu, Sep 12, 2024 at 07:44:33AM +0200, Christian A. Ehrhardt wrote:
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
> ---
>  NOTE: Rebased onto usb-next.

You have not versioned this patch properly - this should be already v5
unless I'm mistaken. That is also have not a proper patch changelog.

If you need help with the patch formatting, please check this
document:

https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

thanks,

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

