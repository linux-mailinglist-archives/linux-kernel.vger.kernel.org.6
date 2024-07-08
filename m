Return-Path: <linux-kernel+bounces-244443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5488F92A44F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820BC1C21B25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1EA13BAD7;
	Mon,  8 Jul 2024 14:07:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F177F12;
	Mon,  8 Jul 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447671; cv=none; b=Ouu2SN7ks5JSsylpvjqQtsp+8Su94NHAjNhT05HNde6CwGizExQI1JgjtyIMibvSsKOznM31QOE1VzFz6c/0qcbvBXeaduiG3X+98DnN9wRDn9dfzeUoU09LKj5X8EQ/YDIifOlfTEm0qTNXpHSwtX/OPZlAg63mlLMzD//qEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447671; c=relaxed/simple;
	bh=GXvobha2JzShyhfYlZQuvNRXc9iCXnhgxT/SEcvqLkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX2OxvyBYEE9QdgaCT6W7gp0//f4dIqdQausSXNdkKSZc1bIn7ft+2ogx652iaBL/XKxRDqH3LoIRwxzEnd5tD8tO2jqLYr7uD7fJbXWN0OgybPw08bVtke1QTFgZOYPp0iPhNJPcTEs5i+WkBAnbN7EdvAgV1WLbBCLAnGOgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CDF11042;
	Mon,  8 Jul 2024 07:08:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB6B3F766;
	Mon,  8 Jul 2024 07:07:47 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:07:45 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v2 4/4] firmware: arm_scmi: Create debugfs files for
 statistics
Message-ID: <ZovysXW92kgiKlet@pluto>
References: <20240703143738.2007457-1-luke.parkin@arm.com>
 <20240703143738.2007457-5-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143738.2007457-5-luke.parkin@arm.com>

On Wed, Jul 03, 2024 at 03:37:38PM +0100, Luke Parkin wrote:
> Create debugfs files for the statistics in the scmi_debug_stats struct
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>

Missing ---

> v1->v2
> Only create stats pointer if stats are enabled
> Move stats debugfs creation into a seperate helper function
> ---
>  drivers/firmware/arm_scmi/driver.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 937546397cf2..10cd9a319ffb 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2858,6 +2858,24 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void scmi_debugfs_stats_setup(struct scmi_info *info,
> +				     struct dentry *trans)
> +{
> +	struct dentry *stats;
> +
> +	stats = debugfs_create_dir("stats", trans);
> +	debugfs_create_atomic_t("response_ok", 0400, stats,
> +				&info->stats.response_ok);
> +	debugfs_create_atomic_t("dlyd_response_ok", 0400, stats,
> +				&info->stats.dlyd_response_ok);
> +	debugfs_create_atomic_t("sent_ok", 0400, stats,
> +				&info->stats.sent_ok);
> +	debugfs_create_atomic_t("sent_fail", 0400, stats,
> +				&info->stats.sent_fail);
> +	debugfs_create_atomic_t("xfers_response_timeout", 0400, stats,
> +				&info->stats.xfers_response_timeout);
> +}
> +
>  static void scmi_debugfs_common_cleanup(void *d)
>  {
>  	struct scmi_debug_info *dbg = d;
> @@ -2924,6 +2942,9 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
>  	debugfs_create_u32("rx_max_msg", 0400, trans,
>  			   (u32 *)&info->rx_minfo.max_msg);
>  
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS))
> +		scmi_debugfs_stats_setup(info, trans);
> +

Nothing to say here if not that more entries will need to be added as said.

Moreover, You could take the chance in V3 to add in this patch the
support to handle resetting each single counter (hint...this is a low hanging
fruit :D) and also to support something like:

	transports/stats/reset

which will be a WOnly booolean entry that will reset ALL the counters in
one go.

Thanks,
Cristian

