Return-Path: <linux-kernel+bounces-321060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E89713E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F23AB2441E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC01B3F22;
	Mon,  9 Sep 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYD5sFBw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC601B3724;
	Mon,  9 Sep 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874427; cv=none; b=rWdm4N8emGC/Yqf/yBKJEWUp4Zm5W81+OFQFllAihG6SM3tlSjyapzDeKr6aWCwQ7PsO0SfxdxVdJEIWbZ6fR60lUKt1jxGgatHjE8w136sEmSbrYDyNYTPhTEkGRdrWh4Y4YSJhVYDVHojvsPLFZhS9xacy+kUGDLqRFEyT3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874427; c=relaxed/simple;
	bh=DIKNCNiGhIjn9n1V5kMQXTMDbSl+SXirRNtiyKv/cFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBiNiVoAonKoej3cbAHmEHhCfpsBXMofTX1IELn4pMKIQLWqeVz/+jS7wpUAulQYZnXvaPPgMOPa/Scur7xmv1XJzcbe5JXR4RfBzmf5hyOzm4xPEuFO6ENInkN/cdgH+QEWfkeSfTU0ToOoQjNYhTICYg3LSORa1q57iGBjGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYD5sFBw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725874426; x=1757410426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIKNCNiGhIjn9n1V5kMQXTMDbSl+SXirRNtiyKv/cFY=;
  b=fYD5sFBwzvOI2EgSosdM4UoIXj53S80LDTSOy5fJYosCmuCZeZQvpLZa
   NEafaTBlvJJHg5XUzjtByDD+P3yVxaTyqrXEs+Y9XLsVOVqEUCj6zahWy
   +rqd3QPH91mYXbHVX2I44a7pI8b/0LAsBmP1BNtxsWieP6W+VfKv6iMi6
   ouIpoBwDFXvogceBJEwBCxKD+njNmptk/s3No8JHdYh5jbMhx9UEaIJMa
   RNX91p96qL6vokewA9BnYDsd/PhguUf0qw1JeMWjGNcUBtJZYR7NCWbnS
   uKxl/sRTY7AqKptFL2HVh8/vWta7tbSZAT6MypN/pILMHoj9kcZgg68vT
   w==;
X-CSE-ConnectionGUID: 90C/ZtjCTaebxikLJpq5bQ==
X-CSE-MsgGUID: nHA78hL3QYmve3SmWChS9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24673237"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24673237"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:33:41 -0700
X-CSE-ConnectionGUID: yYzMhBXASGSePtWNnhhfDw==
X-CSE-MsgGUID: k9CyDuEmTdGy4ofPkKB7FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89892116"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa002.fm.intel.com with SMTP; 09 Sep 2024 02:33:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Sep 2024 12:33:14 +0300
Date: Mon, 9 Sep 2024 12:33:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <Zt7A2lcW9v3ItKGm@kuha.fi.intel.com>
References: <20240906065853.637205-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906065853.637205-1-lk@c--e.de>

On Fri, Sep 06, 2024 at 08:58:53AM +0200, Christian A. Ehrhardt wrote:
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
>  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 4039851551c1..d6d61606bbcf 100644
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
> @@ -107,15 +111,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
>  		size = clamp(size, 0, 16);
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
>  		return -EBUSY;
> +	if (ret)
> +		return ret;
>  
>  	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
>  		return -EIO;
> @@ -1249,6 +1251,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
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

