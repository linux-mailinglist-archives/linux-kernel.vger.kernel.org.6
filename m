Return-Path: <linux-kernel+bounces-261030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374B93B1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528251F242E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE515B0E0;
	Wed, 24 Jul 2024 13:40:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5A15AD9B;
	Wed, 24 Jul 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828458; cv=none; b=f7VQRHxzfWD/7wy7F0NXFn+JPvfoBa5sVOR4z1J2R8zHUDrF9cFaCr6eKziRdG3G4Xqg47Aub1NfvAQPQ9FE8F3CJ1033UqUaPN3NLYP34yJdO5CmXqJNj/MMW75WYKxAaDfg5fb79JXgTrjHTiQu2iZheH5osiq4PVfq9XT0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828458; c=relaxed/simple;
	bh=yX7WfcqDmjp3eNSuCHh4OIitIGxeM7hLi5pzkY3AMZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6bEqJz1k78UR6cp9mRWtO/Y4nhmyRHcYAzrwMNq9QbS9d66DVMjWweYmKpaJ0LLu/JqwipQpKrz6aKkmBLq6SbU5QR1cNYD4UO6PYJ0MzhI7nrYOh9WTfWaHZRJqyS8NZlPiGcX7vJR5xaQAvl0//PnPqksqfQTvPvosUDhR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A02BF106F;
	Wed, 24 Jul 2024 06:41:19 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9773F766;
	Wed, 24 Jul 2024 06:40:52 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:40:49 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v3 2/5] firmware: arm_scmi: Add support for tracking
 statistics
Message-ID: <ZqEEYfLGshkKyM-x@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-3-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715133751.2877197-3-luke.parkin@arm.com>

On Mon, Jul 15, 2024 at 02:37:48PM +0100, Luke Parkin wrote:
> Add a new config option for statistic tracking in SCMI subsystem
> Add an array and enum for tracking statistics
> Add scmi_log_stats op/no-op function for incrementing statistics
> 

You should terminate your sentences with a period, and I would stay more
generic, no need to detail the changes in the commit log.

Some times there is not so much to say more than what is expressed in
the title :D .... I would only stress that new support for SCMI statistics is
added and that such support is optional, configurable at build-time and
OFF by default...

> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
> v2->v3
> Switch to an enum & array method of storing statistics
> v1->v2
> Config option now depends on DEBUG_FS
> Add scmi_log_stats rather than if(IS_ENABLED)
> Move location of scmi_debug_stats in the scmi_info struct
> ---
>  drivers/firmware/arm_scmi/Kconfig  | 11 +++++++++++
>  drivers/firmware/arm_scmi/common.h |  9 +++++++++
>  drivers/firmware/arm_scmi/driver.c |  6 ++++++
>  3 files changed, 26 insertions(+)
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

" SCMI Raw mode" .... this is unrelated to Raw mode...probably just a leftover
from V2 ... to be dropped...

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
> index b5ac25dbc1ca..157df695aeb1 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -301,6 +301,15 @@ extern const struct scmi_desc scmi_optee_desc;
>  
>  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
>  
> +#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> +static inline void scmi_log_stats(atomic_t *arr, int stat)
> +{
> +	atomic_inc(&arr[stat]);
> +}
> +#else
> +static inline void scmi_log_stats(atomic_t *arr, int stat) {}
> +#endif
> +
>  enum scmi_bad_msg {
>  	MSG_UNEXPECTED = -1,
>  	MSG_INVALID = -2,
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 56a93d20bf23..6edec6ec912d 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -125,6 +125,10 @@ struct scmi_debug_info {
>  	bool is_atomic;
>  };
>  
> +enum debug_stat_counters {
> +	LAST

You should definitely call this something more specific like SCMI_DEBUG_COUNTERS_LAST.

Also, I would move this enum definitions to common.h since in the near
future we could want to track more stats from other area of the stack...
(i.e. outside this driver.c file)..and also because scmi_log_stats is
already defined in common.h

> +};
> +
>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
> @@ -161,6 +165,7 @@ struct scmi_debug_info {
>   *		bus
>   * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
>   * @dbg: A pointer to debugfs related data (if any)
> + * @dbg_stats: An array of atomic_c's used for tracking statistics (if enabled)
>   * @raw: An opaque reference handle used by SCMI Raw mode.
>   */
>  struct scmi_info {
> @@ -187,6 +192,7 @@ struct scmi_info {
>  	/* Serialize device creation process for this instance */
>  	struct mutex devreq_mtx;
>  	struct scmi_debug_info *dbg;
> +	atomic_t dbg_stats[LAST];

I would also move this dbg_stats inside scmi_debug_info and name it just
plain as 'stats' so that you will then access it as 

	info->dbg.stats

...unless I miss something about scoping and it is problematic...

...while at that, I would also place the new stats[] field as last in the
scni_debug_info structure...this is because, even though you are a building
a real array of atomic, up until now in the seris you are indeed introducing
(apparently to static analyzers) a zero-length array (since LAST is zero)....
...and I think gcc/llvm or static analyzers would complain if thet see an
arr[0] placed NOT as the last elemnt of a struct

Thanks,
Cristian

