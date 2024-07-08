Return-Path: <linux-kernel+bounces-244373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36992A362
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F094D1C20E57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FC81729;
	Mon,  8 Jul 2024 13:01:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639C134402;
	Mon,  8 Jul 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443669; cv=none; b=CaReRR3lzAvwtRdHz9hO2kAOT6PjHJ1u42nml/ZZYMsMD/MD4TXd23FG75jqqYOxMVppOLaNBLGYYNj8K9+/RcWDO3m33yVB2FQ+CspcTcpEyfvslXa9X+STSmo5Hl3ki4ZxHkvjE4azj7JWpNydWjjvEWaQaoApaHu1nAvUz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443669; c=relaxed/simple;
	bh=kgbLhehsyq6qo0dFoejiRWYMllGkYQM6goGKO/w7wO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVFH6X4IYHBWQrdY+0AavTPgCpamzoCbdX+yvsrCADeyeWix3hOCcPJjJA3TmfSFTHB9lUzpSkIKMqNQBcAnkAPn2RIw+eEv8F6ai4ItpnqP5LIyzA1timdVXCFPfQWqdDo1jA7bGJAoFKvM91owbdSpIiOZ86Lf4EJTzuVFxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8BB1042;
	Mon,  8 Jul 2024 06:01:31 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E74C3F766;
	Mon,  8 Jul 2024 06:01:05 -0700 (PDT)
Date: Mon, 8 Jul 2024 14:01:03 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v2 2/4] firmware: arm_scmi: Add support for tracking
 statistics
Message-ID: <ZovjDxQyMl6jFhkx@pluto>
References: <20240703143738.2007457-1-luke.parkin@arm.com>
 <20240703143738.2007457-3-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143738.2007457-3-luke.parkin@arm.com>

On Wed, Jul 03, 2024 at 03:37:36PM +0100, Luke Parkin wrote:
> Add a new config option for statistic tracking in SCMI subsystem
> Add a struct for tracking statistics
> Add scmi_log_stats op/no-op function for incrementing statistics
> 

Hi Luke,

good that you keep a summary of viersion changes in the series you
are posting to aid in review....but...

> Signed-off-by: Luke Parkin <luke.parkin@arm.com>

...you need a 

---

...separator here before the summary

> v1->v2
> Config option now depends on DEBUG_FS
> Add scmi_log_stats rather than if(IS_ENABLED)
> Move location of scmi_debug_stats in the scmi_info struct

...if not this sumamry info will be kept in the final merged commit
message, which is not what we want...this is only for the sake of
reviews...

> ---
>  drivers/firmware/arm_scmi/Kconfig  | 11 +++++++++++
>  drivers/firmware/arm_scmi/common.h |  9 +++++++++
>  drivers/firmware/arm_scmi/driver.c | 18 ++++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index aa5842be19b2..45e8e7df927e 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -55,6 +55,17 @@ config ARM_SCMI_RAW_MODE_SUPPORT_COEX
>  	  operate normally, thing which could make an SCMI test suite using the
>  	  SCMI Raw mode support unreliable. If unsure, say N.
>  
> +config ARM_SCMI_DEBUG_STATISTICS
> +	bool "Enable SCMI Raw mode statistic tracking"
> +	select ARM_SCMI_NEED_DEBUGFS
> +	depends on DEBUG_FS
> +	help
> +	  Enables statistic tracking for the SCMI subsystem.
> +
> +	  Enable this option to create a new debugfs directory which contains
> +	  several useful statistics on various SCMI features. This can be useful
> +	  for debugging and SCMI monitoring. If unsure, say N.
> +
>  config ARM_SCMI_HAVE_TRANSPORT
>  	bool
>  	help
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index b5ac25dbc1ca..1f50c4a209d7 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -301,6 +301,15 @@ extern const struct scmi_desc scmi_optee_desc;
>  
>  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
>  
> +#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> +static inline void scmi_log_stats(atomic_t *atm)
> +{
> +	atomic_inc(atm);
> +}
> +#else
> +static inline void scmi_log_stats(atomic_t *atm) {}
> +#endif
> +
>  enum scmi_bad_msg {
>  	MSG_UNEXPECTED = -1,
>  	MSG_INVALID = -2,
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 56a93d20bf23..df3eb17cf439 100644
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
> @@ -161,6 +177,7 @@ struct scmi_debug_info {
>   *		bus
>   * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
>   * @dbg: A pointer to debugfs related data (if any)
> + * @stats: Contains several atomic_t's for tracking various statistics
>   * @raw: An opaque reference handle used by SCMI Raw mode.
>   */
>  struct scmi_info {
> @@ -187,6 +204,7 @@ struct scmi_info {
>  	/* Serialize device creation process for this instance */
>  	struct mutex devreq_mtx;
>  	struct scmi_debug_info *dbg;
> +	struct scmi_debug_stats stats;
>  	void *raw;
>  };

Once the above nitpicks are fixed, I think this is good enough for our
purposes for now; optionally we could quickly move to a macro-based machinery
to avoid carrying the stats field in full even when STATS=n if someone
prefers that way... 

.... but...I will ask you anyway to add a few more stats in the next patch
by splitting a few of the existing ones...

Thanks,
Cristian


