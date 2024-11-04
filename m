Return-Path: <linux-kernel+bounces-394389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC79BAE57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB95A1C211E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED4195811;
	Mon,  4 Nov 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwufyBBd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29718B488
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709772; cv=none; b=XVvYc+F3v4t+qXQ4VpNd0QSq1oF88f0iUMn6IG8c9wlQixhMVID2krPro8UcsY+ML9+oOCIJo4m86RJX8VS8eZrNJ1c5PKtJDPiR5j8MVNvbjEA2EL2WVY4OPMTa8T17HEce6Z2FtjqDBCiTImerDcOcR2a98ueroxLb6nqH3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709772; c=relaxed/simple;
	bh=PMGJRTXJeSK/uC86GqSqce1IAHbTUORnZbtV9juvMH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5xdve/1nqvCaU312+hsV3xFJOT4Tj6+3to1KSi3RzqUcteG0LQd73nL+YTz3OW3eSV1qN/fHGdJ+3KqvYju0jlv9Ua1N68Ek+YQggr+jkblm9/lBGz1tICwWfQOvhL+aeXvqlaWkJnLtE6KC49FFe/5Prm7jjzHsFYUpqsT0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XwufyBBd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d495d217bso3580667f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730709768; x=1731314568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH2a7p6u9/6yeJieZT1sX7At96845cspMVVeyTD+9Yo=;
        b=XwufyBBdpu6JsDwY6j8DYBbUMSko6y9xes3gVGb0Xt8oaEThAcQHrmSmkaotiN1QlU
         Y8Bv2hp9qZwz4GUuanPFFarzv9qGMO4gQEmJF3isbeFj39y2Kn+TJf2MGAGJYGUynAfl
         uOF5cF+1iAKQrmb60I6y0QpASciWSNnbRlQ1BYBy9+ymMqVNAW4fO0y13ocbx1bURPvi
         JQs0wTZVT1qWxCbkGjVk0umsj40A95iZJjubSpaYJD/8FYONdK/uFzTD8m5GoI047gna
         4maI4zRW8zJ9kdQh4XzDTcrthHcW2JYsRsQ6L6cINAWbUNRfQgSXb8+t/ZeUfr6uXoke
         noIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709768; x=1731314568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH2a7p6u9/6yeJieZT1sX7At96845cspMVVeyTD+9Yo=;
        b=t3dMhjv9W2SYd/2wVQB/m5XDUHUbMJD4EwehLSUXvn41kRllIgQHx9emjt1+f+1Rn0
         /bCtbgifwr4Akx2EyPPjNqTMGwXZT7zB9KLrlBSRNjiTAHhlvN9F6/tdWe9yhC3R5Zwr
         +6zOUczrGJWql3jkV5l4Syfx0iF189xul2vF7/tuTTy2O/dGLCabIWMkN7ky2vAwyEJb
         iccTSZ7Dv29eAJIU3P7i1NaDsfkbRGxlwKW6geJPle/l6OohgOBzN8u037cySwCrvHOe
         UlPYaK44Hh9qVO5TDCZnJ2mG9em/AYOlyGTxbFTrYuaL0piQazN1tzlOCHTGJP1oUMkf
         xiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/UHw5F4OTjCY8TMwaR4n066nw5hRcgjK/FT8eioFYLpG/p2WZxNQVQUrVmB9H/S+ULoF8MI7GaBcZxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsjlPiyLOm61x+u8xPQoLFWBtz7keL6fDmxsgaVbLxkmmK6FB
	8Fmz4phHdHgmFZOPyWFdf8FqQMfHvaEZ70mNTOa6LaecE/ZrVLwPctG9gC800YI=
X-Google-Smtp-Source: AGHT+IH0YvBRoj68w9YDPGUZW+eoW3tHfaMzoBGwO/I57qJ6sY1IOTj/JfSskMotJCV0el88/SyLcQ==
X-Received: by 2002:a5d:6dab:0:b0:37e:d2b8:883a with SMTP id ffacd0b85a97d-381c7a464c6mr12433759f8f.12.1730709767667;
        Mon, 04 Nov 2024 00:42:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d7e0fsm12460840f8f.47.2024.11.04.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:42:47 -0800 (PST)
Date: Mon, 4 Nov 2024 11:42:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 04/11] staging: gpib: Update messaging and usb_device
 refs in agilent_usb
Message-ID: <e51ffd6a-b002-40df-94c0-02eb8cbe8c76@stanley.mountain>
References: <20241103212617.13076-1-dpenkler@gmail.com>
 <20241103212617.13076-5-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103212617.13076-5-dpenkler@gmail.com>

On Sun, Nov 03, 2024 at 10:26:10PM +0100, Dave Penkler wrote:
> Replace GPIB_DPRINTK with dev_dbg
> Replace pr_xxx with dev_xxx wherever possible
> Use previously initialized usb_device pointer for usb_put_dev()
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  .../gpib/agilent_82357a/agilent_82357a.c      | 266 ++++++++++--------
>  1 file changed, 156 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
> index 748aadc5cebc..68b40831b9ad 100644
> --- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
> +++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
> @@ -15,11 +15,11 @@
>  #include "tms9914.h"
>  
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapter");
> +MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");

This should go in a patch by itself.

>  
>  #define MAX_NUM_82357A_INTERFACES 128
>  static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
> -DEFINE_MUTEX(agilent_82357a_hotplug_lock);
> +DEFINE_MUTEX(agilent_82357a_hotplug_lock); // protect board insertion and removal


This too.

>  
>  static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask);
>  
> @@ -29,9 +29,6 @@ static void agilent_82357a_bulk_complete(struct urb *urb)
>  {
>  	struct agilent_82357a_urb_ctx *context = urb->context;
>  
> -//	printk("debug: %s: status=0x%x, error_count=%i, actual_length=%i\n", __func__,
> -//		urb->status, urb->error_count, urb->actual_length);
> -
>  	up(&context->complete);
>  }
>  
> @@ -80,16 +77,17 @@ static int agilent_82357a_send_bulk_msg(struct agilent_82357a_priv *a_priv, void
>  	if (timeout_msecs)
>  		mod_timer(&a_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
>  
> -	//printk("%s: submitting urb\n", __func__);
> +	//dev_dbg(&usb_dev->dev, "%s: submitting urb\n", __func__);

Just delete this.

regards,
dan carpenter


