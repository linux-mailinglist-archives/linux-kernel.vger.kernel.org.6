Return-Path: <linux-kernel+bounces-248501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C009F92DE20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44656B23A93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810058801;
	Thu, 11 Jul 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="pHru8cC0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D0523D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720662464; cv=none; b=apJo3hBUUnBaR6wrPvhd/xQ5AqgQOGsX9nP+q3kgRZW9tQp2hjCeE52q4ykU6h3AJ8QG+ra6PMXakToYQsLEhQGJ9pKjj/SAWk+lcQRavmC6A68TSCiUB/4lnmujYNVx9jWs4wQlCDCkLaKXLM2zILo/+5W8eVIxe8Jp8ngIqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720662464; c=relaxed/simple;
	bh=tMFHkxFPolROgECg5vVgfcIDDwUKCaXiGLwl/jzzNxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtRIYpyf1row6p3nPbuc18yZhLBjP2pmjY3fVCenF+17550W3ZAhU/Z/N/Hd+buY+GVJAywKEt9CnVdWVAxRzB/vRTVVO8bhKFWo0LmiJruJvH51vV3ChVa9VHs1uJ8d8XnkU7OirCVA9KspU0lz8FMewcILRrL8VtxR71l+/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=pHru8cC0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f178e62d1so22807985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1720662462; x=1721267262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tN5R4YnhjAUO3BS4jN/9VwPte3wOBowtI6nf3MDomk=;
        b=pHru8cC0YN6mRmgOdmfgJIWkpiUVicLikpcJ/YpZl+2g5WE5cv04ifNnrvPZg5SF1w
         u9qh01sSs+okmblCat905LupU4j2bM9nZRmDuU5PgjdZSoWBYR1OOmzek1+dfWQXA+bx
         n2jImCartjAPXCz+fC6IcQrBzeDAR4o83b3+UGPM8SScfeakR8tnZT1198ct/SWWhR91
         +CuM/nNOXF/YWAEw18sTGSIJizY3fo+mdjM07pqRoI4BlB9xMuXigqP71rW725rhvXJK
         wl26JOzrs+PosLJKlWwUmAY2GwC6mXFOELpKwiPmyoSvbZnnrZDfCIIyBlHaJeSkyEca
         F4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720662462; x=1721267262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tN5R4YnhjAUO3BS4jN/9VwPte3wOBowtI6nf3MDomk=;
        b=VMEGZdASG4nvNKG/V7FC6fHbEnbI7iRt6qnLQNfgd3JDZeWXsIBTm9Ct8lk6HK9gdr
         Sz6uIRmjswsfeEry39M1xiTfbBtcIBYHvxuLsm2FJ+FRV+R1W0reDvsq23Hc67IMuQxq
         ATxTpaslro5KRh444tVDhF0TL3e+jsdGlp66viseaikSKLQgrcbwdbJP8INoo+xOWvxP
         T2sx/FyoB/777tD6mNrB+3x5VZo72LI+uo7AkFZ5I/0Di7ohV1WHpj3HvYBnXKxCZdfc
         CgVKkSFPWDLGPPcSSsSep6aapJdIi1/5klR+9yOOZHtERaMKtoJWBT8M8b9Km8tJL2Hr
         T9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVkNp9DroEJ1BCi53YZtDu/mYtvJ2u9KTZu7KvRomYL7klr71kwsIhCOu7taFbChgO4AHpCQCroT/gNbeDYgH9edyNUB5LOdT0FmRr6
X-Gm-Message-State: AOJu0Yz+u1fqSmS2cQ91i9DvQVyeYwvcZ1ti4ir0nJ5Pw5Gy/JAjA3NC
	pOesFYe/hllvz5L1YD+4f+S+zdiRCnot1RPk9aIA10J0HzeY/mqLvnoibsuBfw==
X-Google-Smtp-Source: AGHT+IEdvBZ5AhAWw7kB3UrCG2h7ixiJqeq8PURLRH1rrR34tzFsUpVzykFcjUiDfx5fm+R2MjzjKw==
X-Received: by 2002:a05:620a:2482:b0:79f:b3c:8fcc with SMTP id af79cd13be357-79f199e43e8mr1031660585a.10.1720662461925;
        Wed, 10 Jul 2024 18:47:41 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::cad7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18f1a32bsm246551285a.0.2024.07.10.18.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:47:41 -0700 (PDT)
Date: Wed, 10 Jul 2024 21:47:39 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: ryan <ryanzhou54@gmail.com>
Cc: jikos@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: usbhid: Enable remote wake-up based on device
 configuration
Message-ID: <f0c789d8-8ae0-4a46-a5b3-aa9a5a758915@rowland.harvard.edu>
References: <20240710231606.3029-1-ryanzhou54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710231606.3029-1-ryanzhou54@gmail.com>

On Thu, Jul 11, 2024 at 07:16:06AM +0800, ryan wrote:
> According to the USB protocol, the host should automatically
> adapt the remote wake-up function based on the configuration
> descriptor reported by the device, rather than only the default
> keyboard support. Therefore, it's necessary to support other hid
> devices, such as digital headsets,mice,etc.

It's true that the host shouldn't try to enable remote wakeup if the 
configuration descriptor shows that the device doesn't support it.

However, it's not true that the host should try to enable remote wakeup 
for devices other than keyboards with boot-protocol support.  History 
has shown that quite a few HID devices don't handle remote wakeup 
properly; the decision about whether to enable it should be left to the 
user.

Alan Stern

> Signed-off-by: ryan <ryanzhou54@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index a90ed2ceae84..d2901ad9a871 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1179,16 +1179,16 @@ static int usbhid_start(struct hid_device *hid)
>  	/* Some keyboards don't work until their LEDs have been set.
>  	 * Since BIOSes do set the LEDs, it must be safe for any device
>  	 * that supports the keyboard boot protocol.
> -	 * In addition, enable remote wakeup by default for all keyboard
> -	 * devices supporting the boot protocol.
>  	 */
>  	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>  			interface->desc.bInterfaceProtocol ==
>  				USB_INTERFACE_PROTOCOL_KEYBOARD) {
>  		usbhid_set_leds(hid);
> -		device_set_wakeup_enable(&dev->dev, 1);
>  	}
>  
> +	if (dev->actconfig->desc.bmAttributes & USB_CONFIG_ATT_WAKEUP)
> +		device_set_wakeup_enable(&dev->dev, 1);
> +
>  	mutex_unlock(&usbhid->mutex);
>  	return 0;
>  
> -- 
> 2.17.1
> 
> 

