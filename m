Return-Path: <linux-kernel+bounces-244435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566D92A43A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A170B284225
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248813664E;
	Mon,  8 Jul 2024 14:00:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0212771C;
	Mon,  8 Jul 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447238; cv=none; b=csv2WnY85bpOwe6ZkEmElyP7fOWY7rAFK+Xn/ZTOKtrbOUvTGHZ21JMtdftOWDNcy5WgXF17kNuwtrHO6VhIfk/7RY8DKxswuiS86oTWm+OI5Jgmc1De0uwB7TGeGY/kN53h+FFljK7fyoLlSeLA8g2TFrEldIpV48iFtnwo0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447238; c=relaxed/simple;
	bh=aPgpK0zsSwGW/XSA+DCU5R1XQqrrM6SMAFuJUnByCuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR7ox4XbKZysYsxj4ihJzQWRkagLzLjkgAhlMReTjKDyh2nKRisFMcRZbnzUteb57k94o9m33m4or40QuikqH5tNdLjEVLFbEJAMUj0dEx6Mn2/95+kwmIyPWcvLh7PJd++6BhL+u/7XMhAciQ6YPU8bHKwEbBEJHRvj6VMlL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E437F1042;
	Mon,  8 Jul 2024 07:00:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32313F766;
	Mon,  8 Jul 2024 07:00:33 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:00:31 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v2 3/4] firmware: arm_scmi: Track basic SCMI statistics
Message-ID: <Zovw_4MgumQo8npi@pluto>
References: <20240703143738.2007457-1-luke.parkin@arm.com>
 <20240703143738.2007457-4-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143738.2007457-4-luke.parkin@arm.com>

On Wed, Jul 03, 2024 at 03:37:37PM +0100, Luke Parkin wrote:
> Add tracking of 5 initial statistics
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>

Missing

	---

> V1->V2
> Drop unneccesary atomic_set's
> Use new 'scmi_log_stats' to simplify incrementing of atomics
> Move scmi_log_stats to locations which mean no extra conditionals
> 	are needed
> ---
>  drivers/firmware/arm_scmi/driver.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index df3eb17cf439..937546397cf2 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1146,8 +1146,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
>  		scmi_clear_channel(info, cinfo);
>  		complete(xfer->async_done);
> +		scmi_log_stats(&info->stats.dlyd_response_ok);
>  	} else {
>  		complete(&xfer->done);
> +		scmi_log_stats(&info->stats.response_ok);
>  	}
>  
>  	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {

Up above here in scmi_handle_respnonse() I would take care to track a
few interesting stats about when reponses that went bad...if you look at
scmi_xfer_command_acquire() you will notice that a whole class of errors
there, and  spread all around the core, are handled by scmi_bad_message_trace():
please handle all of these errors based on the type of the enum scmi_bad_msg...

....which means, IOW, add a counter for each the enum scmi_bad_msg and handle
them in scmi_bad_message_trace(), so that they will get counted everywhere....
and... :P ... while doing this please consider as usual the fact that we will
like the log_stats call to vanish completely at compile time if STATS=n

...then please look also into handle_notification() and try to add a couple
of counters there too...

... we can discuss all of these new counters in the next review...

> @@ -1231,6 +1233,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  			       struct scmi_xfer *xfer, unsigned int timeout_ms)
>  {
>  	int ret = 0;
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>  
>  	if (xfer->hdr.poll_completion) {
>  		/*
> @@ -1251,13 +1254,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  					"timed out in resp(caller: %pS) - polling\n",
>  					(void *)_RET_IP_);
>  				ret = -ETIMEDOUT;
> +				scmi_log_stats(&info->stats.xfers_response_timeout);

I would rename this as 'xfer_response_polled_timeout' (so adding one more
stats to the structs and debugfs) in order to discern this timeout case
for the one below.

>  			}
>  		}
>  
>  		if (!ret) {
>  			unsigned long flags;
> -			struct scmi_info *info =
> -				handle_to_scmi_info(cinfo->handle);
>  

..in this same code-block, down below right before the trace_scmi_msg, I
would add a:

		scmi_log_stats(&info->stats.response_polled_ok);

...if not, you will end-up counting only the successfull reply on the IRQ
path, i.e. only the one that are served by handle_response.

>  			/*
>  			 * Do not fetch_response if an out-of-order delayed
> @@ -1291,6 +1293,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  			dev_err(dev, "timed out in resp(caller: %pS)\n",
>  				(void *)_RET_IP_);
>  			ret = -ETIMEDOUT;
> +			scmi_log_stats(&info->stats.xfers_response_timeout);

This is a different kind of timeout...on non-polled request, lets keep
it named as it is now...

>  		}
>  	}
>  
> @@ -1374,13 +1377,15 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>  	    !is_transport_polling_capable(info->desc)) {
>  		dev_warn_once(dev,
>  			      "Polling mode is not supported by transport.\n");
> +		scmi_log_stats(&info->stats.sent_fail);

Same here ... you have different reason for failures in the following,
so you could try to count them separately...

	sent_fail_polling_unsupported

>  		return -EINVAL;
>  	}
>  
>  	cinfo = idr_find(&info->tx_idr, pi->proto->id);
> -	if (unlikely(!cinfo))
> +	if (unlikely(!cinfo)) {
> +		scmi_log_stats(&info->stats.sent_fail);

	sent_fail_channel_not_found

>  		return -EINVAL;
> -
> +	}
>  	/* True ONLY if also supported by transport. */
>  	if (is_polling_enabled(cinfo, info->desc))
>  		xfer->hdr.poll_completion = true;
> @@ -1412,6 +1417,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>  	ret = info->desc->ops->send_message(cinfo, xfer);
>  	if (ret < 0) {
>  		dev_dbg(dev, "Failed to send message %d\n", ret);
> +		scmi_log_stats(&info->stats.sent_fail);

this is the basic, original send failure...it is a generic failure at the transport layer,
so lets keep it named like it is now...

>  		return ret;
>  	}
>  

...here you can just place your (instead of the one down below)

	scmi_log_stats(&info->stats.sent_ok);

...becasue now, right here, you are already sure that the message has been sent ...

> @@ -1420,8 +1426,12 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>  			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
>  
>  	ret = scmi_wait_for_message_response(cinfo, xfer);
> -	if (!ret && xfer->hdr.status)
> +	if (!ret && xfer->hdr.status) {
>  		ret = scmi_to_linux_errno(xfer->hdr.status);
> +		scmi_log_stats(&info->stats.sent_fail);

...this is NOT a sent_fail...you DID send successfully the message AND received
successfully a response (ret==0)  BUT there was an error of some kind at the protocol
layer...i.e. the server sent you an error code in the reply...so I would count here
instead something named like

	stats.protocol_errs

> +	} else {
> +		scmi_log_stats(&info->stats.sent_ok);

and this is really late to be counted as sent, so it would be clearer to
count it above (where I mentiones), so please drop the else.

Thanks,
Cristian


