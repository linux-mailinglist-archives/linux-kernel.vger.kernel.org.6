Return-Path: <linux-kernel+bounces-395095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5309BB86D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F42B1C21DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BF1B6CEA;
	Mon,  4 Nov 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcUcCydQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C52B9A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732455; cv=none; b=oex4siLFOK3QFdLUdQP2UzlGGsH3Tlrk5yhfnHwZjYx2D+rZ6h3b/gAyjiKu408mKmOz3QwDUZ9iydg5Y0+MMg8g7mZ2fJcEF2WX5UpOMiNWSdJF3LBafUa1y1V+simOuPg6FSs/wcPHb4MFDuYh8woLnbWicy8KIZCz7kqOkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732455; c=relaxed/simple;
	bh=6CwdJQ+w8zHSNyvm3QdjuWgxa1oGhK+8wtCuWv4RDc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA9sGGCN6Tjc/xfFYCkdy/SuXEagwJ6rC3SSdco17JWz8GmgX+4JXiiVClP8MdG59DqLyhgEsyejlBEoj7IRophnVDj1E+HfhB/xYU0RMtpzimd7WUmph8yUj5nHy1PcOz7CKLD3yAQ2XXSog+GtzfjnhorGXozLGbjG9e5midw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcUcCydQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730732454; x=1762268454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6CwdJQ+w8zHSNyvm3QdjuWgxa1oGhK+8wtCuWv4RDc0=;
  b=RcUcCydQ+MCqJucmDWz47JsWOFtcIV7tNumItNIHBv/irtiHD1KwjrMf
   JKcFE2qUKD2xKpHmy4Wpd4Q+JkqAUqdV5aapKfHSnuSGffwq6wyruADLr
   kmadnyXwKVvSC5VDM/wP6TD6oLIZUEdHi+OwIbBv2GeeJcNeR02Q1+HbP
   7CILrz5vCllzYQLOHYaLblWaCx6YnaLdCGfF8lgN9rXDEjAzh+jfiyUD7
   YOJa9xIa5rcJpG447EoYXJ4ZY9xknD9e4kxSf90gRb86jhgyW0erpsxfF
   xBaPjYSa7MyixCstFrk2OjkduDFO4geaP0UXos2zQTYLpDSGctmdvIq1u
   A==;
X-CSE-ConnectionGUID: pKJF0sjfRJa48ALCdtSbQw==
X-CSE-MsgGUID: B3PyI+x6RSq+KQR4LO3PKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30285316"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30285316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 07:00:53 -0800
X-CSE-ConnectionGUID: rs+2s/WbT/6R8OdFFhV8OA==
X-CSE-MsgGUID: URAQmgMyRIGeqZBM7vZ93Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83200205"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 07:00:51 -0800
Message-ID: <583c5381-11fe-4fc0-83b4-512c2aae50bd@linux.intel.com>
Date: Mon, 4 Nov 2024 17:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] i3c: master: Add support for SETAASA CCC
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-6-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241023055118.1400286-6-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
> I3C devices like DIMMs over SPD use SETAASA for bus discovery instead of
> SETDASA. Add a new routine for I3C host controller drivers to use. If the
> I3C slave on the bus is an SPD device, skip the regular DAA process.
> 
> According to the SPD spec[1], use SETAASA for bus discovery, and avoid
> sending RSTDAA and DISEC, as they are considered illegal. Skip this entire
> process if the slave is SPD-compliant, as indicated by the "jdec_spd" flag
> from the BIOS.
> 
> [1] https://www.jedec.org/system/files/docs/JESD300-5B.01.pdf
> (section 2.4 and 2.6.3)
> 
SETAASA seems to come in MIPI v1.1.1 specification. I think worth to 
mention in commit log.

> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master.c               | 32 +++++++++++++++++++++++++++++-
>   drivers/i3c/master/dw-i3c-master.c |  1 +
>   include/linux/i3c/ccc.h            |  1 +
>   include/linux/i3c/master.h         |  1 +
>   4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index ba6f17cb8aa6..1596efd6d82a 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1657,6 +1657,21 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>   	}
>   }
>   
> +static int i3c_master_setaasa_locked(struct i3c_master_controller *master)
> +{
> +	struct i3c_ccc_cmd_dest dest;
> +	struct i3c_ccc_cmd cmd;
> +	int ret;
> +
> +	i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR, 0);
> +	i3c_ccc_cmd_init(&cmd, false, I3C_CCC_SETAASA, &dest, 1);
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	i3c_ccc_cmd_dest_cleanup(&dest);
> +
> +	return ret;
> +}
> +
>   static int i3c_master_add_spd_dev(struct i3c_master_controller *master,
>   				  struct i3c_dev_boardinfo *boardinfo)
>   {
> @@ -1684,6 +1699,10 @@ static int i3c_master_add_spd_dev(struct i3c_master_controller *master,
>   		i3cdev->info.pid = i3cdev->boardinfo->pid;
>   		i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
>   
> +		ret = i3c_master_setaasa_locked(master);
> +		if (ret)
> +			goto err_free_dev;
> +
>   		i3c_bus_normaluse_lock(&master->bus);
>   		i3c_master_register_new_i3c_devs(master);
>   		i3c_bus_normaluse_unlock(&master->bus);
> @@ -1907,7 +1926,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>   		goto err_bus_cleanup;
>   	}
>   
> -	i3c_master_add_spd_dev(master, i3cboardinfo);
> +	/*
> +	 * If the I3C slave on the bus is SPD device, then do not follow the regular
> +	 * DAA process. Also, as per SPD spec SETAASA is required for the bus discovery
> +	 * and sending RSTDAA and DISEC is considered as illegal. So skip the entire process
> +	 * if the jdec_spd flag has been identified from the BIOS.
> +	 */
> +	if (master->jdec_spd)
> +		return i3c_master_add_spd_dev(master, i3cboardinfo);
>   
>   	if (master->ops->set_speed) {
>   		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> @@ -2311,6 +2337,10 @@ static int i3c_acpi_configure_master(struct i3c_master_controller *master)
>   		return -ENODEV;
>   	}
>   
> +	status = acpi_evaluate_object(master->ahandle, "_STR", NULL, NULL);
> +	if (ACPI_SUCCESS(status))
> +		master->jdec_spd = true;
> +

Am I right "_STR" object should carry a string "jdec_spd"? But this code 
is not actually checking it, only the existence of _STR?

>   	num_dev = device_get_child_node_count(dev);
>   	if (!num_dev) {
>   		dev_err(&master->dev, "Error: no child node present\n");
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index f683e2a398ad..90a43209e55e 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -282,6 +282,7 @@ static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
>   	case I3C_CCC_GETSTATUS:
>   	case I3C_CCC_GETMXDS:
>   	case I3C_CCC_GETHDRCAP:
> +	case I3C_CCC_SETAASA:
>   		return true;
>   	default:
>   		return false;
> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
> index ad59a4ae60d1..a145d766ab6f 100644
> --- a/include/linux/i3c/ccc.h
> +++ b/include/linux/i3c/ccc.h
> @@ -32,6 +32,7 @@
>   #define I3C_CCC_DEFSLVS			I3C_CCC_ID(0x8, true)
>   #define I3C_CCC_ENTTM			I3C_CCC_ID(0xb, true)
>   #define I3C_CCC_ENTHDR(x)		I3C_CCC_ID(0x20 + (x), true)
> +#define I3C_CCC_SETAASA			I3C_CCC_ID(0x29, true)
>   
>   /* Unicast-only commands */
>   #define I3C_CCC_SETDASA			I3C_CCC_ID(0x7, false)
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 367faf7c4bf3..cd8390d8b469 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -516,6 +516,7 @@ struct i3c_master_controller {
>   	const struct i3c_master_controller_ops *ops;
>   	unsigned int secondary : 1;
>   	unsigned int init_done : 1;
> +	unsigned int jdec_spd : 1;
>   	unsigned int hotjoin: 1;
>   	struct {
>   		struct list_head i3c;


