Return-Path: <linux-kernel+bounces-261071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C193B296
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7291F247A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9715A4AF;
	Wed, 24 Jul 2024 14:21:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA215958A;
	Wed, 24 Jul 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830899; cv=none; b=nCW/1OzHwCSZGh+O8dbvJk8H8Rrqfm2O60lq/XEJujs2hjOMpluLhVpVF8y5Q/JDNujXhikBkXopcEcm/2myuI+O7ft3RBeFTObzP81WyfywK1Mws8IWrj+gF5ny6IrzBUXze3eAnx8ax1FyZvHIhBctD10VWxTUXvr7cfySbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830899; c=relaxed/simple;
	bh=voG2gKlsXMh970oCxpUiQ9kXkdKjA6P7p7KOD9L4Dl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQb+zjHaBnA9FakxQj/RzMS4AH4FNu9TeyPw8cTUVJHNYLDQMRgfaDn1k7Vok1aUsGIMh0oZxFw06uIVXCginFE/I+abnOHOi66+N/2BOL8UZz8BgZBVVTZUo118eBozT6ocWqVq2/mqwhCknxWetsK4JXOLGgZ0NJtYjoDitoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75E9A106F;
	Wed, 24 Jul 2024 07:22:01 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB2E63F5A1;
	Wed, 24 Jul 2024 07:21:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:21:31 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Message-ID: <ZqEN6w49zFSDMUIe@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-4-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715133751.2877197-4-luke.parkin@arm.com>

On Mon, Jul 15, 2024 at 02:37:49PM +0100, Luke Parkin wrote:
> Add tracking of initial statistics
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
> V2->V3
> Add more statistics
> Use new log_stats method.
> V1->V2
> Drop unneccesary atomic_set's
> Use new 'scmi_log_stats' to simplify incrementing of atomics
> Move scmi_log_stats to locations which mean no extra conditionals
> 	are needed
> ---
>  drivers/firmware/arm_scmi/driver.c | 39 ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 6edec6ec912d..b22f104cda36 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -126,6 +126,20 @@ struct scmi_debug_info {
>  };
>  
>  enum debug_stat_counters {
> +	SENT_OK,
> +	SENT_FAIL,
> +	SENT_FAIL_POLLING_UNSUPPORTED,
> +	SENT_FAIL_CHANNEL_NOT_FOUND,
> +	RESPONSE_OK,
> +	NOTIF_OK,
> +	DLYD_RESPONSE_OK,
> +	XFERS_RESPONSE_TIMEOUT,
> +	XFERS_RESPONSE_POLLED_TIMEOUT,
> +	RESPONSE_POLLED_OK,
> +	ERR_MSG_UNEXPECTED,
> +	ERR_MSG_INVALID,
> +	ERR_MSG_NOMEM,
> +	ERR_PROTOCOL,
>  	LAST
>  };
>  
> @@ -994,6 +1008,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  
>  		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
> +		scmi_log_stats(info->dbg_stats, ERR_MSG_UNEXPECTED);

I'd be tempted to say why dont you wrap these scmi_log_stats() inside the
scmi_bad_message_trace() ... BUT in order to avoid an additional
conditional inside the scmi_bad_message_trace() you will need to somehow
remap the MSG_UNEXPECTED to ERR_MSG_UNEXPECTED inside scmi_bad_message_trace (lets say
with a local onstack array indexed by -err)...AND that would mean committing to keep
such mapping in-sync with the the above enum, so as to avoid that adding
a new definition into scmi_bad_msg BUT not to debug_stat_counters will
end up in a buffer overflow....so at the end probably better/safer to keep it
this way...

Thanks,
Cristian

