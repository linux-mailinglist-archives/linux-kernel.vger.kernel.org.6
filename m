Return-Path: <linux-kernel+bounces-236628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0A91E521
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513ED1C21E08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BA16D9D2;
	Mon,  1 Jul 2024 16:20:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCE16D9BF;
	Mon,  1 Jul 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850803; cv=none; b=HRPPSCkETpfXYQHJayIEHcJC/I3bfAM9oOTRQ+D4hhC5qkjk0KUNQBv7gIUbIDpiBoyXxeyVf0FTQiZT1UgtxQGJFGCInKAG6yJHCvpdXMpIlzHWkukbW4ph62U15wGTDXhArzeGy8sTgrLzsYVJPW2RUx+BDTNUC3z5Ze0AKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850803; c=relaxed/simple;
	bh=iO6Kx9m+jAYlkNnwHixLaFfCUBdzqBSg8J1xDSyi6Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHfuEUczcQMBfAWiT5Ku/2S5VczOwNTlQEzTVIAXcb2IGJ/fdkHQ85H8E+TEfXS013k/T7pJsO0S6fvCxuvU+erpn6zdXJ14wgrNbA6JcrsoiDq4uSgYHPHRY7RDGUhVrX5eJwdthNC3KDP++xR6AwcPo+s1r14Rylmwb+/+5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98276339;
	Mon,  1 Jul 2024 09:20:26 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD81E3F73B;
	Mon,  1 Jul 2024 09:20:00 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:19:58 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH 3/3] Create debugfs files for statistics
Message-ID: <ZoLXLlgmNea-Q05n@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-4-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701142851.1448515-4-luke.parkin@arm.com>

On Mon, Jul 01, 2024 at 03:28:51PM +0100, Luke Parkin wrote:
> Create debugfs files for the statistics in the scmi_debug_stats struct
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index f69dff699d48..509ea42d17bf 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2884,7 +2884,7 @@ static void scmi_debugfs_common_cleanup(void *d)
>  static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
>  {
>  	char top_dir[16];
> -	struct dentry *trans, *top_dentry;
> +	struct dentry *trans, *top_dentry, *stats;

stats are conditional...so...

>  	struct scmi_debug_info *dbg;
>  	const char *c_ptr = NULL;
>  
> @@ -2935,6 +2935,19 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
>  	debugfs_create_u32("rx_max_msg", 0400, trans,
>  			   (u32 *)&info->rx_minfo.max_msg);
>  
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
> +		stats = debugfs_create_dir("stats", trans);

you can put the above local *stats var instead so that it is NOT even
defined when STATS=n

> +		debugfs_create_atomic_t("response_ok", 0400, stats,
> +					&info->stats.response_ok);
> +		debugfs_create_atomic_t("dlyd_response_ok", 0400, stats,
> +					&info->stats.dlyd_response_ok);
> +		debugfs_create_atomic_t("sent_ok", 0400, stats,
> +					&info->stats.sent_ok);
> +		debugfs_create_atomic_t("sent_fail", 0400, stats,
> +					&info->stats.sent_fail);
> +		debugfs_create_atomic_t("xfers_response_timeout", 0400, stats,
> +					&info->stats.xfers_response_timeout);
> +	}

... moreover...this is not always enabled BUT certainly will be extend
sooner with more counters...so please split this setup out in a local helper
function.

Thanks,
Cristian

