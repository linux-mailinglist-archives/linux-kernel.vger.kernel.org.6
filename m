Return-Path: <linux-kernel+bounces-549236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BDA54F68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6153A90BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CB20F062;
	Thu,  6 Mar 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1SGHsnrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8720E337;
	Thu,  6 Mar 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275877; cv=none; b=M/hDLgBjda9H/phrNtwb3UWriT0We4jFufRdXYaKQWbJVq5UOR8+J3ruNC6tS52ungi1s9R274c/LzErii67VgdYnvWOEZ2mqWR8NoiOyeS3KrF2JwqXu8jbCYv/WEKy0PH2RCGbyyM1pT5QjLSXRyQgwdb0Q55X3+d2KB4EfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275877; c=relaxed/simple;
	bh=YQkVNE2kK5y/jABEGO2F2R52sP4k+FaEHFvrY5kyfiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YThoGYEbAxt72ldyCm05pqk2DGI6L7HwS8HcFqPvjlhtSlLT0RmjlTBRy3SVmPBG+LiTMRJXtq8IxYY6ugguKa5/ebQCtMw2EG7zO8utITS7fZSvAKuGAFvBUG55UBom4qFM3TmggmhCn8bEPM5CerSCnxpfPBQxi3zR2Fshq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1SGHsnrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94BAC4CEE8;
	Thu,  6 Mar 2025 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741275876;
	bh=YQkVNE2kK5y/jABEGO2F2R52sP4k+FaEHFvrY5kyfiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1SGHsnrj8WCz5S+6yZh1hAW59jb+n6t4M39Zs1IH40DSJ0fYDFnFdxXjceAregFQY
	 VFv16JYsyXzLoh4Gyi6TvSlzrOJYTcycPXVsAA4cHZrnD9vBK/i7NAxRFgwjSTVuud
	 viWJnVqi96eoRPQnH2teBH5himIjPlj8nLyWxQ2Y=
Date: Thu, 6 Mar 2025 16:44:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: stern@rowland.harvard.edu, stefan.eichenberger@toradex.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiayi_dec@163.com
Subject: Re: [PATCH v1] usb: core: Add boot delay for DH34 board in restore
 mode
Message-ID: <2025030659-backspace-skimmer-2f01@gregkh>
References: <20250306061749.1502029-1-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306061749.1502029-1-lijiayi@kylinos.cn>

On Thu, Mar 06, 2025 at 02:17:49PM +0800, Jiayi Li wrote:
> On certain DH34-model motherboards, USB keyboards may fail to respond
> during the restore mode confirmation prompt due to the usbhid driver
> not being fully initialized when device registration occurs. This
> results in inability to input 'y'/'n' confirmation.
> 
> Detect this scenario by:
> 1. Checking DMI_BOARD_NAME for "DH34" substring
> 2. Verifying "restore" in kernel command line
> 
> Introduce a 200ms delay before device registration when both conditions
> are met. This allows sufficient time for the usbhid driver to properly
> initialize before user interaction is required.
> 
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>  drivers/usb/core/hub.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a76bb50b6202..b81b518f438b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -36,6 +36,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/uaccess.h>
>  #include <asm/byteorder.h>
> +#include <linux/dmi.h>
>  
>  #include "hub.h"
>  #include "phy.h"
> @@ -2610,6 +2611,7 @@ static void set_usb_port_removable(struct usb_device *udev)
>  int usb_new_device(struct usb_device *udev)
>  {
>  	int err;
> +	const char *board_name;
>  
>  	if (udev->parent) {
>  		/* Initialize non-root-hub device wakeup to disabled;
> @@ -2656,6 +2658,17 @@ int usb_new_device(struct usb_device *udev)
>  	/* check whether the hub or firmware marks this port as non-removable */
>  	set_usb_port_removable(udev);
>  
> +	/* get board manufacturer information (DMI_BOARD_VENDOR) */
> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);

What about platforms that do not have DMI?

> +
> +	/* In order to load the usbhid driver on a specific model motherboards
> +	 * before the restore mode confirmation, add 200ms of latancy.
> +	 */
> +	if (board_name && strstr(board_name, "DH34") &&
> +		(strstr(saved_command_line, "restore") != NULL))
> +		msleep(200);
> +
> +

Always use scripts/checkpatch.pl before sending patches out.

thanks,

greg k-h

