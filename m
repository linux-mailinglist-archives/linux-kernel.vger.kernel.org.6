Return-Path: <linux-kernel+bounces-549015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C530A54C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6F33A5E36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB320E6F2;
	Thu,  6 Mar 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WtYsCFSV"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3820E30A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267755; cv=none; b=Ruazf2U768aFaNh+q2g7YBcaZOfTsDp1bF9TqTwMuenXCJ8fnCa0mrVAX5DbpX+Uu3z9GsSOGTxAByIS08ziPy8RYr/MSuyX1AcCQeaQtIm0fpw9/JYk+X0VrmOCyX45H1vIQWqWLIh5oDzs92q/H2zGSKd+S4tqa1TQF6uIz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267755; c=relaxed/simple;
	bh=Zk6KznM1Mny3IifnHC66rR/yxzf5hcz/58qW1fHNFzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI7oyA5KaEbF7Y9et5sZC9Dvm1RM4uImJPXNFmcnMjHFJ2A2/oTG1nxg58Ag21z8a1iYNljK1cdHVgsqGYL/xD4dctTKiA6r80jvqUPP8tZRm37r5qh/c9TrGodZK8JdNNNg1ldik9YwD1T3lVD9B9y4bVWy0q9sdOd0lkuG77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WtYsCFSV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3db4a6110so150078585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741267752; x=1741872552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TO273gAYQ0oUb9YC0Kv4nC2xrHAVYrUP62Xzo8si0Uw=;
        b=WtYsCFSVWhhtSCYH1osSgbgSDODlO+pseYZ8PDoJ7ZtIZXCvVe1bHvtazsLLqa+4Pv
         TSmhtudLi9/tzvdvaixJJ99FLuU7vd65/AkjLdnPi/4h5/+3waaLqP1eVTgaLctMA5Ir
         UZapzOek0/n8MErWvTldVeqAxc8Gub2x/a+pyHwKSLog9sk5EVnytI0M12M6eQe3o9AN
         lcjvj+6t4bPngx3U0Bz5zFb7bh+JyluchjPfASqeXqfKVHkZBiYau+pxVgC4KZWMWVzC
         ykgc2EQnJuswMbmAOmTmtKRRKYtSBcpYTUKFhWMhTY2p8WbcMMc5scpzGTYO7YDPClpv
         A+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267752; x=1741872552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO273gAYQ0oUb9YC0Kv4nC2xrHAVYrUP62Xzo8si0Uw=;
        b=i08fULoy6nONQwwNqxP2GfJPC7CEHufhYGvUwdO0yGDk3vG/ALzBCrLg9gSGN3/Hx0
         w2NEuOKaCzuztaIRJEtsMxbfOPtQtH6dqzV1JEPyXilGdHVN0p4mNuoazxZBBCC7xMlC
         225Eyp3QgOd0oPyYSyy/DuuP0whdh9Hcn7ig7aRVxpTqxga26UbgEWtdQVCawCXWMnjs
         5cAslP+m1sI8k0SajKPYZe6+GFk5Y7HN3NN9iJ1w3EzJFfiYDgR0jnBAmeAkoRdFam1c
         R4slNbPJSTI3L04VAo8k6Nwi63ZbIn0Sji1pWJ9jWrvDVl5n1x+jbkNRrh1YSsIUUhcH
         l13A==
X-Forwarded-Encrypted: i=1; AJvYcCVZIOBSFOz3QJHMQkcJMxPllEL2n6HeF9txo0I2CEsTRmi9g9aJLtU1WyvoQWEb0ZYW0lqjCoHKw9ffG5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLktkWwJ5JFevfrFzvOckHgwgJm6DaNYIa9mNiP1dwe8o6reWY
	z/ooLog8rH/zLjidS0n3hbH/dtcAmMj+5g1tWxQ97i9MKLjVimFBVx6c45cjuA==
X-Gm-Gg: ASbGnctC4z8oO6xwSrzdRgBtCQ6RaYrScI0Ql0hjVt4w3rtJk36TsTfBvYbQ2jQqXhb
	jkgX7KeCcx/pky87cTilwNDlj7qA5j1mVt+em8tBV+8de8D0oUKjp4HZqAaH4Hflz21ItDyAEGC
	9Eile4dh5as2ibp4ayRn2eVywIFa3r3nrAZus+nwM/MgyTMezaYHXKKP5C+UZo0hh5j4/5WBFUR
	5yerqPnQsblIb2GFDCV3B7zdKoXOXFkcXICD96a3fnsTUa34ktJ2foUgUGHmj7MMIbA8JlwsmQ/
	9qkIBHo2kjLtbEouzemVvPjnBGSWphLLJGVer5+J1beODw==
X-Google-Smtp-Source: AGHT+IG8tT1+AXlJX2np1Pv8ZLeKeVEq894Sr4SIQ9hI43LDy8VQzN1drOvtY/uAtno3oVS/H4tnyQ==
X-Received: by 2002:a05:620a:6087:b0:7c3:ca29:c87e with SMTP id af79cd13be357-7c3e3a1c978mr415437085a.21.1741267751741;
        Thu, 06 Mar 2025 05:29:11 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::3ca7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551d075sm90283285a.112.2025.03.06.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:29:11 -0800 (PST)
Date: Thu, 6 Mar 2025 08:29:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: gregkh@linuxfoundation.org, stefan.eichenberger@toradex.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiayi_dec@163.com
Subject: Re: [PATCH v1] usb: core: Add boot delay for DH34 board in restore
 mode
Message-ID: <d3b12542-4919-45e7-b2a5-28742a6c7943@rowland.harvard.edu>
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
> not being fully initialized when device registration occurs.

Why does that make any difference?  The driver core will probe the 
usbhid driver when it is fully registered (assuming the keyboard device 
hasn't been bound to a different driver in the meantime).

>  This
> results in inability to input 'y'/'n' confirmation.
> 
> Detect this scenario by:
> 1. Checking DMI_BOARD_NAME for "DH34" substring
> 2. Verifying "restore" in kernel command line
> 
> Introduce a 200ms delay before device registration when both conditions
> are met. This allows sufficient time for the usbhid driver to properly
> initialize before user interaction is required.

Why does delaying device registration help?  In theory it should make 
things worse: When user interaction is required, the keyboard device 
won't even be registered yet, let alone bound to the usbhid driver.  

Furthermore, your patch delays registration of _all_ devices, not just 
the keyboard device.  This will slow down the restore-mode boot 
procedure considerably.

It sounds like what you really need to do is delay the user interaction, 
leaving the device and driver initialization and registration unchanged.

Alan Stern

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
> +
> +	/* In order to load the usbhid driver on a specific model motherboards
> +	 * before the restore mode confirmation, add 200ms of latancy.
> +	 */
> +	if (board_name && strstr(board_name, "DH34") &&
> +		(strstr(saved_command_line, "restore") != NULL))
> +		msleep(200);
> +
> +
>  	/* Register the device.  The device driver is responsible
>  	 * for configuring the device and invoking the add-device
>  	 * notifier chain (used by usbfs and possibly others).
> -- 
> 2.47.1
> 

