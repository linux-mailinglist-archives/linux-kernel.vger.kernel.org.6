Return-Path: <linux-kernel+bounces-261105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F0093B2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0514DB229C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49E15B0EB;
	Wed, 24 Jul 2024 14:41:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136F157E6C;
	Wed, 24 Jul 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832082; cv=none; b=WVfieK0QwW7OcEaJosdHvO5SwbTs1KCwPsApZqQNHgLmseHVxeYvmtwipktH/7UVZqU2u4dibSX1EoKHe8maqoN2IrMNHu0L1QcTV/BYgvSOPYPTfxIp6erRrMq+iKlHSld60u7YEv8YBfTvpVth2s5OefzqhGpbAsy2VAqEmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832082; c=relaxed/simple;
	bh=nC45cGvCiWqc6Z/EJVSED7YnrayrH6G68T3x6vNxClY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEDeow46EazD2zYsVyBw1CTz6EiuNCx/N5twnRxj+YRJZ167jCd1bdBp0EjPPb1mkagPrI076zPBjIf403mD1eie/7jRY3fz+2XougGkdCybkKyxxTEsXBLnXgt1vMdj8cVx9wvjjvYWvW9HEy2TM/ExyG0qSrZEstxn7p5tNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95FF8106F;
	Wed, 24 Jul 2024 07:41:45 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C276C3F5A1;
	Wed, 24 Jul 2024 07:41:18 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:41:15 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v3 5/5] firmware: arm_scmi: Reset statistics
Message-ID: <ZqESi1-NgX6XSN-d@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-6-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715133751.2877197-6-luke.parkin@arm.com>

On Mon, Jul 15, 2024 at 02:37:51PM +0100, Luke Parkin wrote:
> Create write function to reset individual statistics on write
> Create reset_all stats debugfs file to reset all statistics
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 104 +++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 9378e2d8af4f..6a90311f764d 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2865,6 +2865,47 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static int read_atomic(void *atomic, u64 *val)
> +{
> +	atomic_t *atm = (atomic_t *)atomic;
> +
> +	*val = atomic_read(atm);
> +	return 0;
> +}
> +
> +static int reset_single(void *atomic, u64 val)
> +{
> +	atomic_t *atm = (atomic_t *)atomic;
> +
> +	atomic_set(atm, 0);
> +	return 0;
> +}
> +

So, you rightly built a fops_reset_on_write to handle any write to a
single stats field and zero teh counter...BUT...for the sake of
simplicity, we could relax a bit the requirement and just think about
handling generically the writes...because if you look at the definition
of debugfs_create_atomic_t:

https://elixir.bootlin.com/linux/v6.10/source/fs/debugfs/file.c#L867

you will see that if you declare the mode as RW 0600, the debugfs core
code will automagically provide you with RW debugfs atomic fops...so
that you wont need all of this and you can still keep using
debugfs_create_atomic_t....the only limitation is that the user will be
able to reset the counter to any value, NOT only to zero...BUT being a
debug/test feats seems to me acceptable.


> +static void reset_all_stats(struct scmi_info *info)
> +{
> +	for (int i = 0; i < LAST; i++)
> +		atomic_set(&info->dbg_stats[i], 0);
> +}

You can drop this function and just nest the for loop inside the
function below...

> +
> +static ssize_t reset_all_on_write(struct file *filp,
> +				  const char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct scmi_info *info = filp->private_data;
> +
> +	reset_all_stats(info);
> +	return count;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_on_write, read_atomic, reset_single, "%llu\n");
> +

..and drop this as said above to keep using debugfs_create_atomic_t

> +static const struct file_operations fops_reset_stats = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.llseek = no_llseek,
> +	.write = reset_all_on_write,
> +};
> +

This is good instead for a quick general reset...

>  static void scmi_debugfs_stats_setup(struct scmi_info *info,
>  				     struct dentry *trans)
>  {
> @@ -2872,32 +2913,43 @@ static void scmi_debugfs_stats_setup(struct scmi_info *info,
>  
>  	stats = debugfs_create_dir("stats", trans);
>  
> -	debugfs_create_atomic_t("sent_ok", 0400, stats,

using 0600 here made the trick...

> -				&info->dbg_stats[SENT_OK]);

Thanks,
Cristian

