Return-Path: <linux-kernel+bounces-573899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE3FA6DDBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952221887466
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3F25FA24;
	Mon, 24 Mar 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSMgedVI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2C1EB5B;
	Mon, 24 Mar 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828632; cv=none; b=KciZFhwm9rjdo3c7ztqGvItjBwZenfxg+ILRL9oUdkcf4r9jAdfQQcK0taUlA4c6G7oGcyqNkPg5YScbHrTn1ly6CU97+fsz6EpxWaFBqg2zTSfObdaagHkBXLw/GqDcn39cxFGq/Plk2P88wyj2NKp52RsEnhpGxzEQmNOfQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828632; c=relaxed/simple;
	bh=SfgGNGhUAXhFCYuATJkgJZqBCKHvlefEQ6WphQwSQ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukG3DySQz5War7BKOxvccD4onN7R0ajPGftJi0sVdF19yeGGjEUExDCLlpjG3bF+MX4uulxkAGbAZvz8GXpaow+h1w2yz71Y7DdMxTCgZqp8vcbazM+ZesEwHPUpD9f83yj9UvJ1XCcbrBFEdl5hMU5FzT7q1kaFyCKeNZah2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSMgedVI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso29767875e9.0;
        Mon, 24 Mar 2025 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828629; x=1743433429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oenyWM1QtXCgfrXDTzI9rkPd9tDCL5Pr2rmtBV1wm+0=;
        b=NSMgedVIv5Prb0cKcl5FB2+oFjxvwD2xsoJgeIMA37M3g8Xlxl3ytq12ovmW0RTIa6
         16OXcfxZNgS6FioZI7IO3AdvShCY8KKB68bkPgK3yGlMOCurtGWE0acKvww3eS3ThOx/
         CJ8+3suQPml+6NSs/KgxvB9gqR8FDDiNJC/rfnVA8bl0eGp50stSqZEFdanpXl5MXRsm
         pss9V6W2VSHaEwu01HFrrrrzudKj3Qm1GwuWdbAZeXxFOMbXkRpVZGEi0jIBlZquLzw2
         ufMkJAGXlMiFg8H/mrrYNcURsu7ShwsP5SoTtBxRG/2y4vcjhx2udV7h7O/H85goplzo
         ZSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828629; x=1743433429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oenyWM1QtXCgfrXDTzI9rkPd9tDCL5Pr2rmtBV1wm+0=;
        b=U0dyJceNXEI1WBVDWBXTYt/qTqz2Fg3vitK21KsFrlQyU9nk2N1/cz0hXrLN5AItR+
         iImRbSQ2stUjRSGH0iOSBHit1Q0zzIwQNML4hsfC+ZYTtn2vAgCkdHcWr+zNoZI2xhsr
         ErPPTOGujPXYvhrBmtxKkEJlSyFNPFY3T4do6xgbg+MtuMuRw057oTKbTA3fjQKACMdd
         j8FMAnujIjZkX6JAfAYYIS6tyUQxkC2C2kfFRdJDYQFcfmpocUWOsGSTmitv0iXKyEJ2
         MXwYXxx3JjZKY9OHq6GJ7qDjofVsDchtW4OyWgmfGsq+YpzCn7Q1QpeV2IUPO0TwoXkp
         1IKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHRMCFLWbJqTeOcu3NqbSQzX2YUfiZqi1f4DsUw+2GdS0zMatIZbUIbnOw2015mJL83Me71Oy10SAU@vger.kernel.org, AJvYcCXN69iCBhpZatWynGWRR/Bt8ElJIit9TZ/zmz+pbOClOA37cduLAHAjlQQCiA54jEyNkUDbZlJgO+UKzBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfT2qqac+BcL5ogTXV8ib8zVlo+c7T4ZNyLKidLImLJVU/Oxpe
	FodVT0t+97bYrifKC7a9UCSdT24jGEwp4dczjn8jUGqV3FdViwgK
X-Gm-Gg: ASbGnctEFgN5eVGRCmGutvGbgC/L1rlV5j4iCb+hg8WRVWRtdDxzzwdQsB7g2SHgu//
	lriKI9L0MbpAWLD9ZwwdI38dEBhKo/369U7Krr7oNnXJ3gC+6/LMnGf6EA1T084aLMDtRqompEa
	mG0nJiAhUJ4NE0ZL7GcaG1W6uDK4xhOSd9wNReMDXYuuD+cDtGF1YHLI5DfNYLE9zO4om4MJGT4
	VUravGu0aVYTB7viDmN7rBx64PX7LrfYEXQFCldVAROjeVvfU7WBximFlbQYsXLiBZtupbEl9D3
	FozyEB8fHr5dY/8GKJk+lxFv3kHweCfQYFgr7+yRf07r20aiW/Gam/IbfhDt
X-Google-Smtp-Source: AGHT+IFWpMZBp/nxQXf/xVvuPCWSDR2qKw3oQ3FhFCWps5ORIFTVhvMqFO/zzdPiqMcqFXG6xMgOeg==
X-Received: by 2002:a05:600c:3109:b0:43b:cf12:2ca5 with SMTP id 5b1f17b1804b1-43d509efa3bmr115685215e9.8.1742828628618;
        Mon, 24 Mar 2025 08:03:48 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm125458215e9.25.2025.03.24.08.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:03:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 16:03:45 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] usbtmc: Fix slab-out-of-bounds access in usbtmc_interrupt
Message-ID: <Z-F0Ud9tAiK5AQ1b@egonzo>
References: <20250313211907.1179173-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313211907.1179173-1-kovalev@altlinux.org>

On Fri, Mar 14, 2025 at 12:19:07AM +0300, Vasiliy Kovalev wrote:
> Prevent buffer overflow in usbtmc_interrupt by ensuring interrupt IN
> endpoint packets are at least 2 bytes (1 byte ID + 1 byte data), as
> required by the driver. Without this, short packets could lead to
> out-of-bounds reads of iin_buffer.
> 
> - In usbtmc_probe(), reject devices with wMaxPacketSize < 2 bytes to
>   ensure the allocated iin_buffer is large enough.
> - In usbtmc_interrupt(), skip processing and log a warning if
>   actual_length < 2 bytes, avoiding invalid memory access.
> 
> This fixes a KASAN slab-out-of-bounds error:
> 
> BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt (drivers/usb/class/usbtmc.c:2297)
> Read of size 1 at addr ffff88800a41b2e1 by task kworker/0:1/11
> CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.14.0-un-def-alt0.rc6.kasan #1
> Call Trace:
>  <IRQ>
>  dump_stack_lvl (lib/dump_stack.c:122)
>  print_report (mm/kasan/report.c:521)
>  kasan_report (mm/kasan/report.c:636)
>  usbtmc_interrupt (drivers/usb/class/usbtmc.c:2297)
>  __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1650)
>  usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1735)
>  dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:1995)
>  __hrtimer_run_queues (kernel/time/hrtimer.c:1865)
>  hrtimer_run_softirq (kernel/time/hrtimer.c:1884)
>  handle_softirqs (kernel/softirq.c:561)
>  __irq_exit_rcu (kernel/softirq.c:662)
>  irq_exit_rcu (kernel/softirq.c:680)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049)
>  </IRQ>
> 
> Found by Linux Verification Center (linuxtesting.org) with
> 'USB Gadget Tests'[1]:
> 
> $ make usbtmc
> $ sudo src/usbtmc/usbtmc --invalid_ep_int_len
> 
> [1] Link: https://github.com/kovalev0/usb-gadget-tests
> Fixes: dbf3e7f654c0 ("Implement an ioctl to support the USMTMC-USB488 READ_STATUS_BYTE operation.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  drivers/usb/class/usbtmc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 34e46ef308abf..8a3ba90f32455 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -47,6 +47,9 @@
>   */
>  #define USBTMC_MAX_READS_TO_CLEAR_BULK_IN	100
>  
> +/* Minimum packet size for interrupt IN endpoint */
> +#define USBTMC_MIN_INT_IN_PACKET_SIZE 2	// 1 byte ID + 1 byte data
> +
>  static const struct usb_device_id usbtmc_devices[] = {
>  	{ USB_INTERFACE_INFO(USB_CLASS_APP_SPEC, 3, 0), },
>  	{ USB_INTERFACE_INFO(USB_CLASS_APP_SPEC, 3, 1), },
> @@ -2291,6 +2294,14 @@ static void usbtmc_interrupt(struct urb *urb)
>  
>  	switch (status) {
>  	case 0: /* SUCCESS */
> +		/* check for valid length */
> +		if (urb->actual_length < USBTMC_MIN_INT_IN_PACKET_SIZE) {
> +			dev_warn(dev, "short interrupt packet: %d bytes, min %d required\n",
> +				 urb->actual_length,
> +				 USBTMC_MIN_INT_IN_PACKET_SIZE);
> +			goto exit;
> +		}
> +
>  		/* check for valid STB notification */
>  		if (data->iin_buffer[0] > 0x81) {
>  			data->bNotify1 = data->iin_buffer[0];
> @@ -2426,6 +2437,15 @@ static int usbtmc_probe(struct usb_interface *intf,
>  		dev_err(&intf->dev, "can't read capabilities\n");
>  
>  	if (data->iin_ep_present) {
> +		if (data->iin_wMaxPacketSize < USBTMC_MIN_INT_IN_PACKET_SIZE) {
> +			dev_err(&intf->dev,
> +				"Int in endpoint wMaxPacketSize too small: %d, minimum %d required\n",
> +				data->iin_wMaxPacketSize,
> +				USBTMC_MIN_INT_IN_PACKET_SIZE);
> +			retcode = -EINVAL;
> +			goto error_register;
> +		}
> +
>  		/* allocate int urb */
>  		data->iin_urb = usb_alloc_urb(0, GFP_KERNEL);
>  		if (!data->iin_urb) {
> -- 
> 2.42.2
>
Tested-by: Dave Penkler <dpenkler@gmail.com>


