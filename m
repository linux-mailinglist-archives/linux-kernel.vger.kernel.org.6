Return-Path: <linux-kernel+bounces-291939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811A95691D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5599A283180
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40081662EF;
	Mon, 19 Aug 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYq4SbkH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED715B995;
	Mon, 19 Aug 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066045; cv=none; b=rfycDWiWU/uRQtVmxsXeVrGTaXbRnp7jP0vhVWiPXuVka8jYm4ZtTJYVvrRJOzsrGx5Z/byTnwj403CTLlNn+YC09Uk81HWpVhLR5XL+GLrfZYXS5YCOfgd6xlVXaYUvP7+/sI+SEQwy7KuJoKo30sPIVKO0fXeCo+mtvdhhWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066045; c=relaxed/simple;
	bh=wqivuAtMCQV/XAC/sCYbD+dHR6ZzqWzi5UCasd6w21w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvmBQL4qZTNkQk4TBRBbh1cHFiXm5Issv9sNS0xQrzQ3uI54T6zr4V42tUaqIOJ5refsIiwkulspKtYXzbpD7jHLpxYqV0RAHBUKSiDbmPcGp6NL1p4r6Mkz6qtkE3nf/nj0rZv3rBVSDGdW0yANZDKC2lnp/K9nX5R0AwYTq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYq4SbkH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724066044; x=1755602044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqivuAtMCQV/XAC/sCYbD+dHR6ZzqWzi5UCasd6w21w=;
  b=EYq4SbkHcuxCzbZ8PfjWvNkdH1K3ekW/r6OoBLqG+OF7GD2O2zKg1Uxi
   YsO/ltDu93M2tZbUTYEnIANyXRKBVdm34C1I6xGPfhVXfzQKa2W5swT9x
   0vfNxwIF8hms03WoSIfvtA1lFmhbzY9agxqQ+nQVyCyw3Gx+AuZKpC7rs
   xeoqdBY33D3NgNO2Yb7OFI4kONuUs3czMYfSd49orbbDHlTiTKc4afA5I
   EyN7yZFkmy1irBB3VXyDcs8o1Tn8DjpjUOX4j8xHgzFGsb7LjHLpoojYk
   1ZWIUp7YHKWURrVL4YehzPoNR1hQSKdDdSOExdgwmVdde2V1wb1MuLrJB
   Q==;
X-CSE-ConnectionGUID: tsLUPSMLQnydc9o9LPQx5Q==
X-CSE-MsgGUID: BXUN3QJGS0KEOmM5WXVRxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22121708"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22121708"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:14:04 -0700
X-CSE-ConnectionGUID: xq145QvITm+zArgykmlpzQ==
X-CSE-MsgGUID: jkVcxC44TX23GqI2nLmI8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65173107"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 19 Aug 2024 04:14:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Aug 2024 14:13:59 +0300
Date: Mon, 19 Aug 2024 14:13:59 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	upstream@lists.phytec.de, gregkh@linuxfoundation.org,
	javier.carrasco@wolfvision.net, abdelalkuor@geotab.com,
	harshit.m.mogalapalli@oracle.com
Subject: Re: [PATCH] usb: typec: tipd: Free IRQ only if it was requested
 before
Message-ID: <ZsMo9/sqiQ8kHhZj@kuha.fi.intel.com>
References: <20240816124150.608125-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816124150.608125-1-w.egorov@phytec.de>

On Fri, Aug 16, 2024 at 02:41:50PM +0200, Wadim Egorov wrote:
> In polling mode, if no IRQ was requested there is no need to free it.
> Call devm_free_irq() only if client->irq is set. This fixes the warning
> caused by the tps6598x module removal:
> 
> WARNING: CPU: 2 PID: 333 at kernel/irq/devres.c:144 devm_free_irq+0x80/0x8c
> ...
> ...
> Call trace:
>   devm_free_irq+0x80/0x8c
>   tps6598x_remove+0x28/0x88 [tps6598x]
>   i2c_device_remove+0x2c/0x9c
>   device_remove+0x4c/0x80
>   device_release_driver_internal+0x1cc/0x228
>   driver_detach+0x50/0x98
>   bus_remove_driver+0x6c/0xbc
>   driver_unregister+0x30/0x60
>   i2c_del_driver+0x54/0x64
>   tps6598x_i2c_driver_exit+0x18/0xc3c [tps6598x]
>   __arm64_sys_delete_module+0x184/0x264
>   invoke_syscall+0x48/0x110
>   el0_svc_common.constprop.0+0xc8/0xe8
>   do_el0_svc+0x20/0x2c
>   el0_svc+0x28/0x98
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x190/0x194
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index dd51a25480bf..256b0c054e9a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1465,8 +1465,9 @@ static void tps6598x_remove(struct i2c_client *client)
>  
>  	if (!client->irq)
>  		cancel_delayed_work_sync(&tps->wq_poll);
> +	else
> +		devm_free_irq(tps->dev, client->irq, tps);
>  
> -	devm_free_irq(tps->dev, client->irq, tps);
>  	tps6598x_disconnect(tps, 0);
>  	typec_unregister_port(tps->port);
>  	usb_role_switch_put(tps->role_sw);
> -- 
> 2.34.1

-- 
heikki

