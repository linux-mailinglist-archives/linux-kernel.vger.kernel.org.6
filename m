Return-Path: <linux-kernel+bounces-314983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E296BBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3644FB2CD3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175D1D88A3;
	Wed,  4 Sep 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJOmBMeO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3E1D67A1;
	Wed,  4 Sep 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451672; cv=none; b=DQ7F5pJANlWoQMI3aUxws/yaZTKT3TT5ohNpgvCEh73tiIOD/Ax+rDGnNi2Bp7ANlU0q2lrfTF1kI5X6vmfjw6+4vudGvDQK4rmrcy/Zj5PP6BB5ryWSkzmDdhf5qbw7fzCtbzDXd2ZzKgxG56L/wj3HSdvsfbp0dLMH/VEQb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451672; c=relaxed/simple;
	bh=4wd26ICFLcjbaJVhZFC+iRRVM4oG9r9W9bwp3RQjkSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ88LXU5GCvMOKdMOzwbmSYhxxMw7nlMcSQcsWM8GUy6PAsOYJLwHrOfIjA/3qtOuDEtHkgj2rQOsYb6BoRb8RdFv/Ubl9abvcTkAlQ3N2UdcuWQnA1Mr3x75mjhk4jA06+DM4edQzZVPnlaxdEjuungQn/fXQ5FGZhbE8KEqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJOmBMeO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725451671; x=1756987671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wd26ICFLcjbaJVhZFC+iRRVM4oG9r9W9bwp3RQjkSY=;
  b=OJOmBMeOa5Ob6rcIrWY0u7ks5tO3f/+qWNd5XT3/zeZvohdaAmpM909I
   R9K6dUAlTJ+2e43e6WZL1CLh59j9otWGEyhIAv+9s8RkDKxhL1Q/qT98x
   7ZumwXhyyPOCaNMJb5JjhqqtOoTLnW3AxMtFzfW720Ul/Bk7JdOSoy/Mq
   h8eUol726AO1mNMwom5ByzZgj1J+6y3fZdYYxZYddkmfxgljuM7rcNPos
   PFKFsFnYIDmTA8UGqzdnOCKLj5kOQSmhKwvIPaCj8cG2v/4XuC1UBj9Y9
   jxquUMMm9z8WTqXzxAdsEb5Q0q4SdnQxzUdprXxNXdCFAzn6C2x4JI312
   A==;
X-CSE-ConnectionGUID: /wtLqIjYTdOkq2cne1o3wQ==
X-CSE-MsgGUID: kzH+tUv6S9W34fH1Qi8Kjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34678068"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="34678068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:07:50 -0700
X-CSE-ConnectionGUID: iK/H3f4tQQKhcha/I3XkpQ==
X-CSE-MsgGUID: jlKi/HD0QWqUm+7BrJ7dgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65489940"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 04 Sep 2024 05:07:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 04 Sep 2024 15:07:45 +0300
Date: Wed, 4 Sep 2024 15:07:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v3] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZthNkY4MEpUgw3We@kuha.fi.intel.com>
References: <20240903181917.617400-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903181917.617400-1-lk@c--e.de>

On Tue, Sep 03, 2024 at 08:19:17PM +0200, Christian A. Ehrhardt wrote:
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
> Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
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

I started testing this and it looks like the commands never get
cancelled when the BUSY bit is set. I don't think this patch is the
problem, though. I think the BUSY handling broke earlier, probable in
5e9c1662a89b ("usb: typec: ucsi: rework command execution functions").

I need to look at this a bit more carefully, but in the meantime, can
you try this:

	if (cci & UCSI_CCI_BUSY) {
		complete(&ucsi->complete);
		return;
        }

>  	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  

thanks,

-- 
heikki

