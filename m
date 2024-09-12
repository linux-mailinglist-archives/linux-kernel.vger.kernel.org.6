Return-Path: <linux-kernel+bounces-326054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCD9761DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18FF1F234C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A318BBBC;
	Thu, 12 Sep 2024 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUbEoL8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755B10FF;
	Thu, 12 Sep 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124010; cv=none; b=ZzjKkk5rZQ1qczakBCNCtLZsu3n/AE84zdSDJxQv7nP5EYKFPCTFHMDak4oWY1mSJyz+pVOGqutNe7g0d85s8jHEE0FL/ohGOzoCXNMCwEy8PROiVMT+gW3mP6hIFnwu+aDxB3fw1rV5t/ADJvsthrMkBhKUHXVyJBXn4V1zen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124010; c=relaxed/simple;
	bh=x1z6am5b0jOeS5/RmI9p91PrHTnNU3+NkzsNXV+rKQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r06ztzIgdEBGurq9U5zW71aCdHYEvYLHZB6DqQnnO0QPZXqMhTYAkFfMMS6Wxur2Z3oVu84KHMo61SNl5vPGu9nY6gYxmUFNXYrceKIrHwB+Y4Gp/LF4HDPPuGUvcOFZ7qmQ2FyW4uF0LHFsIXCa2No6NXcINpBuXgSTKZ7tRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUbEoL8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A233AC4CECD;
	Thu, 12 Sep 2024 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726124010;
	bh=x1z6am5b0jOeS5/RmI9p91PrHTnNU3+NkzsNXV+rKQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUbEoL8y6t1LgtuRraiS0oWdU0B1FnwzQZi5OK23+cdv0oDdNDT10e8jDF30PVGKp
	 EpC9xx5gKrcPPT75ycE+Wykd/BwVMm/e7vRxkIJTi4q+Mx2BThaa+timlFoR07AaOM
	 EiBUJ6uVHdhTvqpIxrILKO1UA38wMskjmS2hbANs=
Date: Thu, 12 Sep 2024 08:53:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <2024091215-mullets-praying-375b@gregkh>
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
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

