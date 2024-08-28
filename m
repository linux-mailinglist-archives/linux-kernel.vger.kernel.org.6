Return-Path: <linux-kernel+bounces-305195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21576962ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA0C283FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590B19FA94;
	Wed, 28 Aug 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/UWkv9f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8032868B;
	Wed, 28 Aug 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856833; cv=none; b=EEx6b79pNzXKSGsleJaoAuqEcIFl+Yw9usNvBcgKwV412Ee38C6yX6TpDLIqSBw+AiJW/s0CM+KJnb04B1UX+yGzQh8pA8NnIUCLB0eDFVDnNfp2goLbbdGt0S7In5l/EXGxdgRLCAnZVDCMmiU/sIVx/42vYp91Vycu5+K5xLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856833; c=relaxed/simple;
	bh=V8arl6lpeyELiohDoLFezex7CGe6GUdRnt+dBPTOy8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chGyfRyGecKT/1U+hfGVJRmDWUXFbFU6zK1kiFwrMQZc2/RNSair1l8Hr4ee+vZ6CNkxbS9U0frP1uvM+cdgv602mNH35dcVeZG9kT/r5A4QM9WtDeN67q57eFP3RnNZTIpek3E3kB2UJGJaOLpDlb3ygBb5BVHIo2CpYB7TqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/UWkv9f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724856832; x=1756392832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V8arl6lpeyELiohDoLFezex7CGe6GUdRnt+dBPTOy8A=;
  b=g/UWkv9fOpJ2AMSkXXtetSswpt0tmJwWGMuV+yRP+JfkHWJ3eaYIiX8+
   U+8OA+1KCVK9yC9c4acP0mzGMYMpg2xItJfSWLpSsCnuStGf0aO/qXlme
   rAECvqvP/jMXmml0OVz4J4sUlxU+KSEJxm0ViUSca0+3/c4nQFr/e0dxp
   nXsLqPQa0BmXUBE6tYpXdBCUKc/lbM5xMgVn1iHK7YvqoXrEqrfeN1n7n
   LgIxxXLa+8JCDYJa/8oTSUaEkOAYmQoHqtg6l2MNoorA70/cS2KOR3kuc
   1DOmsQcF7Arva8bG1EVxFiZVvmLl24aFHkEit5B+y+5oAVcFqNs8NEhr1
   g==;
X-CSE-ConnectionGUID: DaCG3isCQrCw3/w6m/K+hQ==
X-CSE-MsgGUID: 1Hk1S0YcQfKwZpDHr5hYyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="33961276"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="33961276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 07:53:48 -0700
X-CSE-ConnectionGUID: kCR/1cL1QrSJ+4rjpOJvLw==
X-CSE-MsgGUID: /HQxcthCSTafOH65CJy67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="67386686"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa003.fm.intel.com with SMTP; 28 Aug 2024 07:53:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Aug 2024 17:53:44 +0300
Date: Wed, 28 Aug 2024 17:53:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <Zs85+FeIDz4n7DHx@kuha.fi.intel.com>
References: <20240828063314.552278-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828063314.552278-1-lk@c--e.de>

On Wed, Aug 28, 2024 at 08:33:13AM +0200, Christian A. Ehrhardt wrote:
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
> Finally, the quirk for some ASUS zenbook models is required for
> ASUS VivoBooks as well. Apply the quirk to these as well.

Can you please split this last part into a separate patch.

thanks,

> Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c      | 8 ++++++++
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 4039851551c1..540cb1d2822c 100644
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
> @@ -1249,6 +1253,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
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
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 7a5dff8d9cc6..aa586525ab4c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -197,6 +197,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)&ucsi_zenbook_ops,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop"),
> +		},
> +		.driver_data = (void *)&ucsi_zenbook_ops,
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),

-- 
heikki

