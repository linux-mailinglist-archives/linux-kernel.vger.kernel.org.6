Return-Path: <linux-kernel+bounces-236622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8FC91E517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B681F23543
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080F16D4E8;
	Mon,  1 Jul 2024 16:15:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D836F2EB;
	Mon,  1 Jul 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850535; cv=none; b=iHUPoIhZ2PlC0OvLPqEkC3qA8yQEIf609jCewXp5MJFxkD+kTo+HtIEWwa92OOLuENH5f1v6IHBBeehw5NnfEvvJv7Mrnn1swOdF4mOUX9KAqWa01HUHeVDHGjBthwXOQmRNtqkVPnW+0+gf1PpyXSP4Wkyb85dH32otsFPjoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850535; c=relaxed/simple;
	bh=YtlCIhlzvR741FG+CjEjpuyfwMmqxuTKUqcadGHXiNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asZ6wVzB5kS6AZ0nOIPRjGDnEEeo++kQxBFmRuU4qY7k/nPtAS8Nq3PecAAz8opREgdSbA6XS+jzVAHnQlTOhk5HauXbO/ccObCInTtcaq/l+gYIY4YU9YJS2w+walG9jXP9kYwZ/QRIfcsNG4apfrI6NuNkRktgP4XMZhL8Irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F68339;
	Mon,  1 Jul 2024 09:15:56 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F65B3F73B;
	Mon,  1 Jul 2024 09:15:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:15:27 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH 2/3] Track basic SCMI statistics
Message-ID: <ZoLWH9-JPFQB4YSu@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-3-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701142851.1448515-3-luke.parkin@arm.com>

On Mon, Jul 01, 2024 at 03:28:50PM +0100, Luke Parkin wrote:
> Add scmi_debug_stats struct with atomic_t types to prevent racing.
> 

Hi

"Add SCMI debug statisticts based on atomic types to prevent races."

if you want to specify why you did it this way in the commit message,
but this seems really more something for a comment in the doxygen that
on the commit log.

> Add tracking of 5 initial statistics
> - sent_ok & sent_fail
> - response_ok & dlyd_response_ok
> - xfers_response_timeout

Morover I would not specify here in the log what you added, you can see
it from the code. "Add some initial stats counter" if you want.

> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 46 +++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 6b6957f4743f..f69dff699d48 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -125,6 +125,22 @@ struct scmi_debug_info {
>  	bool is_atomic;
>  };
>  
> +/**
> + * struct scmi_debug_stats - Debug statistics
> + * @sent_ok: Count of successful sends
> + * @sent_fail: Count of failed sends
> + * @response_ok: Count of successful responses
> + * @dlyd_response_ok: Count of successful delayed responses
> + * @xfers_response_timeout: Count of xfer response timeouts
> + */
> +struct scmi_debug_stats {
> +	atomic_t sent_ok;
> +	atomic_t sent_fail;
> +	atomic_t response_ok;
> +	atomic_t dlyd_response_ok;
> +	atomic_t xfers_response_timeout;
> +};
> +
>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
> @@ -141,6 +157,7 @@ struct scmi_debug_info {
>   * @protocols: IDR for protocols' instance descriptors initialized for
>   *	       this SCMI instance: populated on protocol's first attempted
>   *	       usage.
> + * @stats: Contains several atomic_t's for tracking various statistics
>   * @protocols_mtx: A mutex to protect protocols instances initialization.
>   * @protocols_imp: List of protocols implemented, currently maximum of
>   *		   scmi_revision_info.num_protocols elements allocated by the
> @@ -174,6 +191,7 @@ struct scmi_info {
>  	struct idr tx_idr;
>  	struct idr rx_idr;
>  	struct idr protocols;
> +	struct scmi_debug_stats stats;

Pleaase move this field right after scmi_debug_info down below, so that
we keep all debug stuff together.

Also this is an embedded structure, not a bare pointer to dynamically
allocated stuff (and this is fine...) so you should probably ifdef
ARM_SCMI_DEBUG_STATISTICS at compile time the presence of this field itself
so as not to waste memory for something you never use...but this is
opinable because it will also, on the other side, polllute a bit the code
with unpleasant ifdeffery... so maybe Sudeep wont like it...the other option
would be to make this a pointer and conditionaly devm_kzalloc a struct to this
pointer (like scmi_debug_info)

>  	/* Ensure mutual exclusive access to protocols instance array */
>  	struct mutex protocols_mtx;
>  	u8 *protocols_imp;
> @@ -1143,7 +1161,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  						SCMI_RAW_REPLY_QUEUE,
>  						cinfo->id);
>  	}
> -
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
> +		if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
> +			atomic_inc(&info->stats.dlyd_response_ok);
> +		else
> +			atomic_inc(&info->stats.response_ok);
> +	}

Ok, so IMO, this is the main core thing to rework in this series: the
"counting" operation/block should be defined as a macro so that it can
be fully compiled out when STATS=n, because these are counters
incremented on the hot path for each message, not just once in a while,
so the above if(IS_ENABELD()) now will be there and evaluated even when
STATS=n.

Something like:

	#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
	#define SCMI_LOG_STATS(counter)			\
		<your magic here> 			\
	#else
	#define SCMI_LOG_STATS(counter)
	#endif

.... I have not thought it through eh...so it could be radically
different...the point is ... the counting machinery should just
disappear at compile time when STATS=n

Moreover please define this macros magic here in this patch BUT split
out in a distinct patch all the places where you make use of it, so that
this patch contains only definitions of mechanisms and struct and
another patch will contain all the places where stats are monitored.

>  	scmi_xfer_command_release(info, xfer);
>  }
>  
> @@ -1279,6 +1302,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS) && ret == -ETIMEDOUT) {
> +		struct scmi_info *info =
> +					handle_to_scmi_info(cinfo->handle);
> +		atomic_inc(&info->stats.xfers_response_timeout);
> +	}
> +

Ditto.

>  	return ret;
>  }
>  
> @@ -1414,6 +1443,13 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>  	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
>  			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
>  
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
> +		if (ret == 0)
> +			atomic_inc(&info->stats.sent_ok);
> +		else
> +			atomic_inc(&info->stats.sent_fail);
> +	}
> +

Ditto.

>  	return ret;
>  }
>  
> @@ -2994,6 +3030,14 @@ static int scmi_probe(struct platform_device *pdev)
>  	handle->devm_protocol_get = scmi_devm_protocol_get;
>  	handle->devm_protocol_put = scmi_devm_protocol_put;
>  
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
> +		atomic_set(&info->stats.response_ok, 0);
> +		atomic_set(&info->stats.sent_fail, 0);
> +		atomic_set(&info->stats.sent_ok, 0);
> +		atomic_set(&info->stats.dlyd_response_ok, 0);
> +		atomic_set(&info->stats.xfers_response_timeout, 0);
> +	}
> +

I think that you can just drop this zero initializations because the
stats are part of the info structure which is created devm_kzalloc'ed...
so zerod at creation time AND indeed atomic_t is just a structure containing
an int counter which will be already zeroed too...I dont think that any
other special init is done, it is already zero, and nothing more is done
by your atomic_set(v, 0)...but feel free to verify I am not missing
something, please.

Thanks,
Cristian


