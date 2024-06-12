Return-Path: <linux-kernel+bounces-212050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40498905A89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0731C20C51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7375538F98;
	Wed, 12 Jun 2024 18:16:19 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 65B562E3E0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216179; cv=none; b=lxNCZH46bLS93uTh1AIoSmw/Tquac5kQwo3nQWO8GqQt6PErLqDjTubHAPIFziKChGoRCF/77S3uR0icm9GGIWnERxbcEfT2L5UXy/D3Uj03Q2jBEoHjLO6TegNgZuJkpS9esQgNPgcexHwYnHCI0951JNHQH1FvPGoHHEx8pCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216179; c=relaxed/simple;
	bh=Fegv2307vxylDdMBcSU8WOxyIWy1vn+xS4tfkkD5nVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrGCCotbcBbqv/lBihnd/eBxTiUTBwylPchg2eq/UAI2MrHpsZjJP8GFJeT9CDKicEs+cS1zWqBry6HjBW4jPf57ai/fskhgNTA3RWcHWeVxb411IOi39xGLvpjIMD2X1sDyO4M8CMJ5hel3bRwsvN2ZF9bSLEzqtE+37Y4DkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 232816 invoked by uid 1000); 12 Jun 2024 14:16:15 -0400
Date: Wed, 12 Jun 2024 14:16:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Peter Chen <peter.chen@kernel.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: add missing MODULE_DESCRIPTION() macros
Message-ID: <183a4d6a-30ad-4dce-b54d-3624aba36ac9@rowland.harvard.edu>
References: <20240611-md-drivers-usb-v1-1-8b8d669e8e73@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-md-drivers-usb-v1-1-8b8d669e8e73@quicinc.com>

On Tue, Jun 11, 2024 at 07:37:20PM -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/core/usbcore.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/mon/usbmon.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/class/usbtmc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/storage/uas.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/chipidea/ci_hdrc_msm.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> This is the remaining one-off fixes in usb.
> 
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> 
> Let me know if any of these changes need to be segregated into
> separate patches to go through different maintainer trees.

> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index a0c432b14b20..65f9940bc7e8 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -1150,4 +1150,5 @@ static void __exit usb_exit(void)
>  
>  subsys_initcall(usb_init);
>  module_exit(usb_exit);
> +MODULE_DESCRIPTION("USB support library");
>  MODULE_LICENSE("GPL");

I would change this to "USB core host-side support", or something more 
along those lines.  It's not just a library because it does include 
several drivers (such as the USB hub driver).  And it's host-side rather 
than device-side -- that's a separate module.

Alan Stern

