Return-Path: <linux-kernel+bounces-269116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D4942DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B734B24903
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78521AE86D;
	Wed, 31 Jul 2024 12:11:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A018DF93;
	Wed, 31 Jul 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427889; cv=none; b=PyMtvgHGzCo4+rEhgTDr9WBOWLpQg6UR8f703sqqWKixm79w6TSvPMOTujtLf+lC/HM/a9uCjqBzYPn7p0O6+yN4F+AdZ+KpCf2QyL5pQGEFrnz0uY4d+TAzj05HCCQZTbdZLUMbb2/TXthBlROd1CbSya17huggfTeV5yiYo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427889; c=relaxed/simple;
	bh=WlgnGed378ue9yJeU5OO/zRV3kgWkMscSgxM0Fqwq5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSiJ7e9PhMfWw031KDL8Q14s+WXI1fquTng7BT7RXUWyY6nCVylxUme5UBgQCenuEDEXpxlXPg4bTvJj0oxxZps0rRKclIyXr56cgBnNJ0XILKb8Tn4bE2Zy/hJaixWGBeMd8vU3xawtcAau7hCetTCFQQedGqtXAgmkosfpomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49BC41007;
	Wed, 31 Jul 2024 05:11:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2513F766;
	Wed, 31 Jul 2024 05:11:24 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:11:22 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Luke Parkin <luke.parkin@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, cristian.marussi@arm.com
Subject: Re: [PATCH v4 4/5] firmware: arm_scmi: Create debugfs files for
 counts
Message-ID: <Zqop6qq0jibefw0g@bogus>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-5-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093342.3558162-5-luke.parkin@arm.com>

On Tue, Jul 30, 2024 at 10:33:41AM +0100, Luke Parkin wrote:
> Create debugfs files for the metrics in the debug_counters array
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
> v3->v4
> Use new locations for debug array
> Use counter instead of stats
> v2->v3
> Add extra statistics also added in v3
> v1->v2
> Only create stats pointer if stats are enabled
> Move stats debugfs creation into a seperate helper function
> ---
>  drivers/firmware/arm_scmi/driver.c | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 5acd3d324def..ec6434692d1a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2847,6 +2847,41 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
> +					struct dentry *trans)
> +{
> +	struct dentry *counters;
> +
> +	counters = debugfs_create_dir("counters", trans);
> +
> +	debugfs_create_atomic_t("sent_ok", 0400, counters,
> +				&dbg->counters[SENT_OK]);
> +	debugfs_create_atomic_t("sent_fail", 0400, counters,
> +				&dbg->counters[SENT_FAIL]);
> +	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0400, counters,
> +				&dbg->counters[SENT_FAIL_POLLING_UNSUPPORTED]);
> +	debugfs_create_atomic_t("sent_fail_channel_not_found", 0400, counters,
> +				&dbg->counters[SENT_FAIL_CHANNEL_NOT_FOUND]);
> +	debugfs_create_atomic_t("response_ok", 0400, counters,
> +				&dbg->counters[RESPONSE_OK]);
> +	debugfs_create_atomic_t("notif_ok", 0400, counters,
> +				&dbg->counters[NOTIF_OK]);
> +	debugfs_create_atomic_t("dlyd_resp_ok", 0400, counters,
> +				&dbg->counters[DLYD_RESPONSE_OK]);
> +	debugfs_create_atomic_t("xfers_resp_timeout", 0400, counters,
> +				&dbg->counters[XFERS_RESPONSE_TIMEOUT]);
> +	debugfs_create_atomic_t("response_polled_ok", 0400, counters,
> +				&dbg->counters[RESPONSE_POLLED_OK]);
> +	debugfs_create_atomic_t("err_msg_unexpected", 0400, counters,
> +				&dbg->counters[ERR_MSG_UNEXPECTED]);
> +	debugfs_create_atomic_t("err_msg_invalid", 0400, counters,
> +				&dbg->counters[ERR_MSG_INVALID]);
> +	debugfs_create_atomic_t("err_msg_nomem", 0400, counters,
> +				&dbg->counters[ERR_MSG_NOMEM]);
> +	debugfs_create_atomic_t("err_protocol", 0400, counters,
> +				&dbg->counters[ERR_PROTOCOL]);

Just curious and wonder if we can keep all these read-only and have another
debugfs file which is write only to just reset the counters ?

Cristian,

Thoughts ? Or am I missing somthing ?

-- 
Regards,
Sudeep

