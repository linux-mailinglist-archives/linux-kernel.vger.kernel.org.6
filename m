Return-Path: <linux-kernel+bounces-228961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15491691C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8158F1F2A16E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8EC16C437;
	Tue, 25 Jun 2024 13:37:08 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DDF791607BA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322628; cv=none; b=mMgcRtMmPod/4KZyowNNhndzENHJJEAEwAFtWfMyyiv94PSdywOt7VI0+LQs0NcC1jGEeIUHG8iHqg2lUZv/99YhGV+p32VGXLruFzZ7G0swwpkekavg2DJPW0h97xIEyE+WkUdzYbqpreYt9R7ZyQk83SN9oIrr2BvcBPZz40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322628; c=relaxed/simple;
	bh=Wcc8J5L5SEDDqR2fCyXyRMAE3HdEjSKFjS+qFSRMFgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1z22rc4r03M/CKS5nfvJDMn/7Nr8sCzhf4OCdRFUgs7RDiMYe51GWqsVHNueNXswWucBIOMLUb4e6iFZVkKD6RKDSuZP/Atfg9nztrHxV2joGyluWmKiZgnGSeA0MfvyJzedc6uNJhlbr0O00+QpspFDDVJRTjurwVYSh2rTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 664288 invoked by uid 1000); 25 Jun 2024 09:36:59 -0400
Date: Tue, 25 Jun 2024 09:36:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: tuhaowen <tuhaowen@uniontech.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  wangyuli@uniontech.com
Subject: Re: [PATCH] drv/usb: Fix the issue with Realtek USB wireless adapter
 AC650
Message-ID: <83fd1171-5397-40ea-b9e3-54cba073c09a@rowland.harvard.edu>
References: <20240625070724.22044-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625070724.22044-1-tuhaowen@uniontech.com>

On Tue, Jun 25, 2024 at 03:07:24PM +0800, tuhaowen wrote:
> Due to the dual-mode functionality of the Realtek USB wireless
> adapter AC650, it initially presents itself as a flash drive
> before the driver is installed.

Does this flash-drive mode have a real purpose?  For instance, can 
people upload new firmware by writing it to the flash drive?  I can't 
imagine that the manufacturer would have implemented the dual-mode 
functionality for no reason at all.

> In Linux, multi-state devices are recognized as storage devices
> on startup because the driver has not yet been loaded.
> 
> As a result, the AC650 is identified as a DISK device at boot,
> preventing the use of its WLAN mode. The issue can only be
> resolved by unplugging and replugging the adapter.

If there's no way to resolve this issue other than by unplugging and 
replugging the adapter, how can a patch help?

Are you sure that the problem can't be solved by a userspace helper, 
such as the usbmodeswitch program?

Alan Stern

> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
>  drivers/usb/storage/unusual_devs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index fd68204374f2..f660d3e52436 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -1487,6 +1487,12 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_NO_WP_DETECT ),
>  
> +UNUSUAL_DEV(0x0bda, 0x1a2b, 0x0000, 0x9999,
> +		"Realtek",
> +		"USB Network Device",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_IGNORE_DEVICE),
> +
>  UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
>  		"Maxtor",
>  		"USB to SATA",
> -- 
> 2.20.1
> 
> 

