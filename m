Return-Path: <linux-kernel+bounces-396197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907559BC93A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F154DB23112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97B1D0E13;
	Tue,  5 Nov 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVXSLghn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D51CF7BE;
	Tue,  5 Nov 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799172; cv=none; b=HUQW0XJCIsJvHxl+tps2LkRpXfSUb4tDp84RRrQECBHjgRK8gUv7Am+TSJcXn5D0PfdxkqAgt/n49nus45ynmsohMX4QclV0AgQmClXgQ1fC0QKB+Pr7WafsnyaPASYn3Sc22cTcLdwbRdXGmubgMMuDEiYoHrovTWPyAvb3QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799172; c=relaxed/simple;
	bh=VzGwYF1KU9qAtBJUJAWuJl2+rTNOSrZ4zXnpCxU9a44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8YpbbGux4k8dA1zZMYxH7g7KkcHqBwlv3SrgEWB6ZT8TaiZoAqLZ+TuMASsBK03ab59ZqWO2VCp6O6dWgabc1aMKM3obxQOZDvSHN0g9E1bP42t/IHjwMdkzgHJcIUKZkm2Sj3rglAddciK8r6Suh2ReQ7cOWUFHArJJA3ARYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVXSLghn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730799171; x=1762335171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VzGwYF1KU9qAtBJUJAWuJl2+rTNOSrZ4zXnpCxU9a44=;
  b=WVXSLghnfzF4S8MVZ/pWWpW4d4yF3W682Mbsx5BUDdZ/5XQ5ofhwKUXG
   6ZbFFwrNkieXIdmMvFyx2CSNc/3BV7SzBk+O5nRcwb8dD7tx6iqx9FDkO
   +VYcr23A4Y6eTwhOtxuSwUHBrIGrnuh+B5TilftItXeJlmcx/Io41bK7v
   /r3zjOVvEaB3VonTAiirNRCwvIx6HoCXl8KjSIlwKQO3sRbycwGtaikRd
   SN7os8N0tk4SSltVY/KqHN3KBq0lVdxodYmJdg9w+1YOaueqni2Bp3kCz
   jSHNMdvb/1SKddZy5FJJgHKbYv4cY3d3fHl7DSbZ8M11jOpo+KFJNusaV
   Q==;
X-CSE-ConnectionGUID: XUgLM682SZiaIlEBloVdNw==
X-CSE-MsgGUID: 6UWT0ccSRYqSeRskvEt2hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55933368"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="55933368"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 01:32:50 -0800
X-CSE-ConnectionGUID: ReeqqnroRriZ+kX+vtcFxg==
X-CSE-MsgGUID: QUTquLKUTby+OEh+FvT8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83465564"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 05 Nov 2024 01:32:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Nov 2024 11:32:46 +0200
Date: Tue, 5 Nov 2024 11:32:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ajay Gupta <ajayg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Haotien Hsu <haotienh@nvidia.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix potential out of bounds in
 ucsi_ccg_update_set_new_cam_cmd()
Message-ID: <ZynmPkv8wXNRjUQS@kuha.fi.intel.com>
References: <325102b3-eaa8-4918-a947-22aca1146586@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325102b3-eaa8-4918-a947-22aca1146586@stanley.mountain>

On Mon, Nov 04, 2024 at 08:16:42PM +0300, Dan Carpenter wrote:
> The "*cmd" variable can be controlled by the user via debugfs.  That means
> "new_cam" can be as high as 255 while the size of the uc->updated[] array
> is UCSI_MAX_ALTMODES (30).
> 
> The call tree is:
> ucsi_cmd() // val comes from simple_attr_write_xsigned()
> -> ucsi_send_command()
>    -> ucsi_send_command_common()
>       -> ucsi_run_command() // calls ucsi->ops->sync_control()
>          -> ucsi_ccg_sync_control()
> 
> Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index ba58d11907bc..bccfc03b5986 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -482,6 +482,8 @@ static void ucsi_ccg_update_set_new_cam_cmd(struct ucsi_ccg *uc,
>  
>  	port = uc->orig;
>  	new_cam = UCSI_SET_NEW_CAM_GET_AM(*cmd);
> +	if (new_cam >= ARRAY_SIZE(uc->updated))
> +		return;
>  	new_port = &uc->updated[new_cam];
>  	cam = new_port->linked_idx;
>  	enter_new_mode = UCSI_SET_NEW_CAM_ENTER(*cmd);
> -- 
> 2.45.2

-- 
heikki

