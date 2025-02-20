Return-Path: <linux-kernel+bounces-524466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65344A3E370
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942397011DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28E2144DA;
	Thu, 20 Feb 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4VMO2tE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FA2144D7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074986; cv=none; b=B0N3RTCIwLpzQwkzoGlL/1M/fEkj3ojJw6vIB7cK4lHR2VPbjo/Jvg/z8LTU/IZBkSgPZ57cVWH/bHBcK0hssr92lz+Hc0OmCwDc6R+vJYXBE6EkMia4my21hio4Uz0EnWRKnELlkgjCRfEg6luqTZu+nPhUTqQwMwpUf/wLDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074986; c=relaxed/simple;
	bh=aOsd90qPoQgE7IOydh8+Nrn+s+R9GK0bjIAwoTkEA0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Albirkj3WlyTGOqdndG+FYvluBa9bl6R0PDoMhGeydXP5hz3oFRgQbk/aidt//h7FilWTA0Irh7dOQ8OYnznIXJWTRnquY68CKbaFZrEWJvTBCjkiD8zMgQR0JbThOgodL6RHTcaRJxWXHN/FUQcvx/4UN2CMfR7Fkyzblb8rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4VMO2tE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ecbdb4c2so32866005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740074983; x=1740679783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UehZxvbwuBQb9qKRTrVZFnoSFSok+4Q0ALSzooCxF+w=;
        b=n4VMO2tE10twSBCGJURv8WoGI2Q9jbulLNOwYbbAUp7MHthI2xpv+P7N9WCUlERJ6A
         Vhm3O45j4+IKlYOcl4iGucytfN+FDTLKzG3lXyzYNdBJPJX+Q6Q3DpaVWi/FOagezqLo
         JeJDxpC7g2bGWHsv+niDR4ZYHHM3gjbzxriqAksbSCyq/9qPIgqRJOMKO9Vgp3y8Pw9e
         zn3ZuE0qTxnR6PoFZjIThI72InjGk4yARE1hr6oXnfo9aBkesMalXodu2Z2+vjITmKLV
         wkcxmKmTz+muJibt2Q8PzUE3Lgo/xbb2Y8o0oF/mApHMIpb7eHO04Z/wbsIK9KpXJ8FO
         zEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074983; x=1740679783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UehZxvbwuBQb9qKRTrVZFnoSFSok+4Q0ALSzooCxF+w=;
        b=vnpuWHBTB6UsG0Eav48OIlHhUihaA0jN3A6dF8lkSu5PaKrzFUWIqjcHAX/l+jg0mR
         eXJ5MsONNfQQSZylQqxESdSfSxis7n7tCfffTMxMRTCx+FH235E4Ftgc3LZ5PBtpasCv
         UPMpT5fbMbzPyjMGwY+nIFXzFzQr5unWMx+euQax+vfXAP7zxKeuk6XMmtICs4pkUsjw
         v6UJ/WaWiLaPFVU+qQJdOVzfRS7uBfK6C4xCqx7wHk0cfEYGiD1pIilcXNyDS95DVBCZ
         p//a9/R8BdEwRF4mgofeLtyu9Lh4ZREDp5h1GJHmgqFr+46eqUVsKTgEqt++75P78BO1
         tK4g==
X-Forwarded-Encrypted: i=1; AJvYcCVGTf6f9iLAbEi7avQLq/TBDPEVW0R3LuTPrHZh/cTgtwMtQ9/ReGZqk/XgH+CTi4YfpuTxe8KnNrkcgm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpQ8E3PasLfHeeTxyIhCOlPTbil8BZXvUn4t9jj4Gl4PTieE+
	bdyb09r6hHnV4SyvrhOduWYlCpuz3UtC+Fa6dVX5BsOFQf93IOZxywO60F/UIQ==
X-Gm-Gg: ASbGncsOZoLioCxvrfxovVqdgjlbmOR6KeKDlUI0KYNpfb2iHjSeWL0k+ZCCOw20oD2
	EU/GVrsS4WDaDL6DRvcC2Jv7vMmwpWJqX4XKAX3izbjdnF9vPHf9b1/s5Ao9/DPasJ0u3FQRWqH
	vwNUU/7gTRMpTPeo5JiM7wULUkkMd9umEkDx9jvKewRc3tbAzAsZqg4Sl0Jyz/vaCsYVcPn7s+a
	fhgzf9WXnsLbzRt2A+4GkfCtIsyrVwo0dHnhdFjb5BEN3/UBpd87ICGv9ORzmiQr+psBfOvgBsu
	iAQNZhjRvTanW06i8TP9NGzkmLCY8cUDtqsX7jdL+X9mmJaH6BsuECeG
X-Google-Smtp-Source: AGHT+IETDgl9Fde4f2iPllIyaLiXQFK4fhca7MgqL5XHTXjG6CRlGUfnstElUz1XbRBlXTpxKXIS9Q==
X-Received: by 2002:a05:6a00:198c:b0:730:8a0a:9ef9 with SMTP id d2e1a72fcca58-7326190d9edmr35296420b3a.22.1740074983388;
        Thu, 20 Feb 2025 10:09:43 -0800 (PST)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52aee0sm12880779a12.47.2025.02.20.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:09:42 -0800 (PST)
Date: Thu, 20 Feb 2025 10:09:38 -0800
From: William McVicker <willmcvicker@google.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
Message-ID: <Z7dv4rEILkC9yRwX@google.com>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>

Hi Prashanth,

On 02/17/2025, Prashanth K wrote:
> Currently the USB gadget will be set as bus-powered based solely
> on whether its bMaxPower is greater than 100mA, but this may miss
> devices that may legitimately draw less than 100mA but still want
> to report as bus-powered. Similarly during suspend & resume, USB
> gadget is incorrectly marked as bus/self powered without checking
> the bmAttributes field. Fix these by configuring the USB gadget
> as self or bus powered based on bmAttributes, and explicitly set
> it as bus-powered if it draws more than 100mA.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
> Changes in v2:
> - Didn't change anything from RFC.
> - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/
> 
>  drivers/usb/gadget/composite.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index bdda8c74602d..1fb28bbf6c45 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
>  	else
>  		usb_gadget_set_remote_wakeup(gadget, 0);
>  done:
> -	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
> -		usb_gadget_set_selfpowered(gadget);
> -	else
> +	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> +	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
>  		usb_gadget_clear_selfpowered(gadget);
> +	else
> +		usb_gadget_set_selfpowered(gadget);
>  
>  	usb_gadget_vbus_draw(gadget, power);
>  	if (result >= 0 && cdev->delayed_status)
> @@ -2615,7 +2616,9 @@ void composite_suspend(struct usb_gadget *gadget)
>  
>  	cdev->suspended = 1;
>  
> -	usb_gadget_set_selfpowered(gadget);
> +	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
> +		usb_gadget_set_selfpowered(gadget);

I'm hitting a null pointer derefence here on my Pixel 6 device on suspend.  I
haven't dug deep into it how we get here, but in my case `cdev->config` is
NULL. This happens immediate after booting my device. I verified that just
adding a NULL check fixes the issue and dwc3 gadget can successfully suspend.

Here is the crash stack:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000002a
  <snip>
  Modules linked in: tcpci_maxim(E) at24(E) phy_exynos_ufs(E)
    phy_exynos5_usbdrd(E) dwc3_exynos(E) ufs_exynos(E) i2c_exynos5(E)
    s3c2410_wdt(E) arm_dsu_pmu(E) simplefb(E)
  CPU: 0 UID: 0 PID: 885 Comm: irq/118-dwc3 Tainted: G            E
    6.14.0-rc3-next-20250220-4k-g50a0c754714a-dirty #1
    02ae1fc192b79fc15e3493a7f5cb2e58e2817b0a
  Tainted: [E]=UNSIGNED_MODULE
  Hardware name: Raven (DT)
  pstate: a04000c5 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : composite_suspend+0x8c/0xe8
  lr : configfs_composite_suspend+0x70/0x80
  <snip>
  Call trace:
   composite_suspend+0x8c/0xe8 (P)
   configfs_composite_suspend+0x70/0x80
   dwc3_suspend_gadget+0x48/0x64
   dwc3_thread_interrupt+0x568/0xbe8
   irq_thread_fn+0x30/0xb0
   irq_thread+0x174/0x284
   kthread+0x130/0x21c
   ret_from_fork+0x10/0x20

And that decoded at base commit 50a0c754714a (from linux-next):

  composite_suspend (drivers/usb/gadget/composite.c:2619) (P)
  configfs_composite_suspend (drivers/usb/gadget/configfs.c:1939)
  dwc3_suspend_gadget (include/linux/spinlock.h:351 drivers/usb/dwc3/gadget.c:3962 drivers/usb/dwc3/gadget.c:3957)
  dwc3_thread_interrupt (drivers/usb/dwc3/gadget.c:4466 drivers/usb/dwc3/gadget.c:4494 drivers/usb/dwc3/gadget.c:4514 drivers/usb/dwc3/gadget.c:4535 drivers/usb/dwc3/gadget.c:4577)
  irq_thread_fn (kernel/irq/manage.c:1191)
  irq_thread (kernel/irq/manage.c:1318)
  kthread (kernel/kthread.c:464)
  ret_from_fork (arch/arm64/kernel/entry.S:863)

Thanks,
Will

> +
>  	usb_gadget_vbus_draw(gadget, 2);
>  }
>  
> @@ -2649,8 +2652,11 @@ void composite_resume(struct usb_gadget *gadget)
>  		else
>  			maxpower = min(maxpower, 900U);
>  
> -		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
> +		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
> +		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
>  			usb_gadget_clear_selfpowered(gadget);
> +		else
> +			usb_gadget_set_selfpowered(gadget);
>  
>  		usb_gadget_vbus_draw(gadget, maxpower);
>  	} else {
> -- 
> 2.25.1
> 

