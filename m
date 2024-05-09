Return-Path: <linux-kernel+bounces-174712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7F8C1361
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9553B219F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB0BE66;
	Thu,  9 May 2024 17:04:46 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325C4C8B;
	Thu,  9 May 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274286; cv=none; b=IIcL7fEQduAR4njPxrqLRr7litDpKuecu7NO/me+64VghHivEUoFm/8TdxbWmWdTauox6q/jWoRBs8y07NQxUnfJ6pMjfl8oj6N0VpVsRL4l4KgM+z4O9D4rsulm4WD+JOdqTY/TAqFFKTobxV4HkZfKCJu+umkCNXJqLvtuHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274286; c=relaxed/simple;
	bh=jRJENUshDFsZV0tAZUXv5gYyUnozVPD/3nComIwGvsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmNM+nVhPsEppvZP8TQ21GeEk5qtIR4/49wolTwymANOSS5lHj3TOVEKzhoWeaLNR8AdihHjxTbBZ0Zz7aVX1PLMhV/LWs1wwBNaQn2NRya6zlj9MeWPku9C7FQlj10Z6HSPEuzL3IvleWhf3armHOdDyawoJGEMInaOghTPivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EF02830013CCC;
	Thu,  9 May 2024 19:04:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D919F3FCAA; Thu,  9 May 2024 19:04:32 +0200 (CEST)
Date: Thu, 9 May 2024 19:04:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: bcfradella@proton.me, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danil Rybakov <danilrybakov249@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ben Fradella <bfradell@netapp.com>,
	Ranjan Dutta <ranjan.dutta@intel.com>,
	Yifan2 Li <yifan2.li@intel.com>,
	Jonathan Yong <jonathan.yong@intel.com>
Subject: Re: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Message-ID: <Zj0CIPR5djf0-hHb@wunner.de>
References: <20240509164905.41016-1-bcfradella@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509164905.41016-1-bcfradella@proton.me>

[cc += Shin'ichiro, Klara, Andy, Danil]

On Thu, May 09, 2024 at 04:49:34PM +0000, bcfradella@proton.me wrote:
> From: Ben Fradella <bfradell@netapp.com>
> 
> The P2SB could get an invalid BAR from the BIOS, and that won't be fixed
> up until pcibios_assign_resources(), which is an fs_initcall().
> 
> - Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
>   enough to avoid a race with any dependent drivers.
> 
> - Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catch
>   unset BARs going forward.
> 
> - Return error values from p2sb_fs_init() so that the 'initcall_debug'
>   cmdline arg provides useful data.
> 
> Signed-off-by: Ben Fradella <bfradell@netapp.com>
> ---
>  drivers/platform/x86/p2sb.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
> index 3d66e1d4eb1f..1938a3ef9480 100644
> --- a/drivers/platform/x86/p2sb.c
> +++ b/drivers/platform/x86/p2sb.c
> @@ -56,12 +56,9 @@ static int p2sb_get_devfn(unsigned int *devfn)
>  	return 0;
>  }
>  
> -static bool p2sb_valid_resource(struct resource *res)
> +static bool p2sb_valid_resource(const struct resource *res)
>  {
> -	if (res->flags)
> -		return true;
> -
> -	return false;
> +	return res->flags & ~IORESOURCE_UNSET;
>  }
>  
>  /* Copy resource from the first BAR of the device in question */
> @@ -220,16 +217,20 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
>  
>  static int __init p2sb_fs_init(void)
>  {
> -	p2sb_cache_resources();
> -	return 0;
> +	return p2sb_cache_resources();
>  }
>  
>  /*
> - * pci_rescan_remove_lock to avoid access to unhidden P2SB devices can
> - * not be locked in sysfs pci bus rescan path because of deadlock. To
> - * avoid the deadlock, access to P2SB devices with the lock at an early
> - * step in kernel initialization and cache required resources. This
> - * should happen after subsys_initcall which initializes PCI subsystem
> - * and before device_initcall which requires P2SB resources.
> + * pci_rescan_remove_lock() can not be locked in sysfs pci bus rescan path
> + * because of deadlock. To avoid the deadlock, access P2SB devices with the lock
> + * at an early step in kernel initialization and cache required resources.
> + *
> + * We want to run as early as possible. If the P2SB was assigned a bad BAR,
> + * we'll need to wait on pcibios_assign_resources() to fix it. So, our list of
> + * initcall dependencies looks something like this:
> + *
> + * ...
> + * subsys_initcall (pci_subsys_init)
> + * fs_initcall     (pcibios_assign_resources)
>   */
> -fs_initcall(p2sb_fs_init);
> +fs_initcall_sync(p2sb_fs_init);
> -- 
> 2.43.0

