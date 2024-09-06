Return-Path: <linux-kernel+bounces-318988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F123596F63D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B55B1C20EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755231CFED6;
	Fri,  6 Sep 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="nCdsvhQB"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19171D0140
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631516; cv=none; b=APGfJplcZkq7O/WbPlauk3b9JJciIoG+cPE2aQRNBobNMkVtzJU7ZXOFjHmGnBck3D2sdTl6SMe8uTITkUOBeNjRh4C7Mlb5hGcyIXJ3+S/1mvzxgemNhurozZC30OY6klu5j16kezbkxi4iAmCqxgxdShQsS0jIqNh7hQ6WOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631516; c=relaxed/simple;
	bh=uDsqCwfI7vgNpHZZKv4YKyigu7g1XnPzVrDBj+LKp/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv5inMuVCwilk+nXJAe4TMgY0UoXUc8NkQjZ8Q+Jxr6Kj1n4N1IWxoFd9Gr2vlov8ve2piY9po6OIsia0Y9z7cWzbnMdERTTaZNRVQuAgKcjiuAYUNc+e8BNV/3MtxPY3DXgmNShJLEmLnkw5LgRybmFbeE46poakAtKYtpME+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=nCdsvhQB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-456954d0396so12225961cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1725631513; x=1726236313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYHQBKYKAdtYaK3msJholEAcglrE+FLWhPy/VM+Wan0=;
        b=nCdsvhQBIR91eSViFw06twy4BxZkq1U9jJhjGFmMhHmlJGAVYMDzQuErrmbkZdhzUV
         4IdzX7RRt6YoPIycX78UYlrEK5oZamtGSPWEFlTP4dYSpjb7aLc0c9a5BSVeRgzciJgD
         nCYAEc/EyRI6mqZin6evNFpI3vD1U5fPJ6L5vtoXpFaRbwPv0XGE6i12Tw0t1i7bMAHj
         QxUnahjvixnfSP0Pyo8HnNPa+VLxCYSIGSsSRMwfrRsfA8EgJfzBjrcMnDOXTWkkvCoM
         UQipM8+09RDpWZBwX47nnfrw9HT7MlXcBPb/JBU3Eu6dGJz8S3vcm3Oqqyk7+4gKgWLQ
         Tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631513; x=1726236313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYHQBKYKAdtYaK3msJholEAcglrE+FLWhPy/VM+Wan0=;
        b=aXV+1v1YBMiQnDaL3Q6fiXHVs15B5KwizPi+Vz9m/AKgy5LWsYQRoQFzRQAPIgSuRi
         rbLyTy8wAj0AS/rq/EE/vNcyh+eR0nCUKuSGnialUrCONOEdJsSFi1lVHEhZikyYT53w
         37gddNZ3rNkGKRLJnXXbjcOLVI+IdCiph6qeNYVB2X0tTZEnHPdSsHT8X8pARiPIfuvl
         etTQ7JEy3sllTSvj1iBXFF8Hjbp6j9/07+uKv8XQpSgZKxLQHEp6MnzScuOj1AhpvctL
         FlwkYNiGmWilEDTW+lm/+HVZU1l/RI8BNMrfeS22RLAV/EyS5Kw0i6b2Yw26mWffx8jT
         YfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfPxrhHV/TUqoOuRgl/jzHle+NKrSR0ZhE9qMv/1HJf0kIfPIW8wYvJxboru0ZOcDkqF/z5UokttKNo/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0T4AQXTTPdFJrBO80hpaydu7VryeTSukhyMMUi191T642BFf
	oNiw/Qis8As9kagavYIJaBwq2xitAuNWczLkM0RGGcYo/IYbrCiB5Eqyr9WTIw==
X-Google-Smtp-Source: AGHT+IHc+O3QFitoD9IjyvM885Rga7Y3BitGXxq51ednYgodsGbuU6GgswPl3iUBCWpjqD0dX6dLqg==
X-Received: by 2002:a05:622a:30e:b0:458:a70:d9b8 with SMTP id d75a77b69052e-4580c6e1f2emr32207891cf.26.1725631513134;
        Fri, 06 Sep 2024 07:05:13 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::24a8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4581dec188fsm193331cf.42.2024.09.06.07.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:05:12 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:05:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Duan Chenghao <duanchenghao@kylinos.cn>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <50249245-fae6-480c-ac00-7e3fef97390d@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906030548.845115-1-duanchenghao@kylinos.cn>

[Please make sure that the lines in your email message don't extend 
beyond 76 columns or so.]

Lots of things here seem to be wrong.

On Fri, Sep 06, 2024 at 11:05:48AM +0800, Duan Chenghao wrote:
> When a device is inserted into the USB port and an S4 wakeup is initiated,

There is no such thing as an S4 wakeup.  Do you mean wakeup from an S4 
suspend state?

> after the USB-hub initialization is completed, it will automatically enter suspend mode.

What will enter suspend mode?  The hub that the device was plugged into?
That should not happen.  The hub initialization code should detect that 
a new device was plugged in and prevent the hub from suspending.

> Upon detecting a device on the USB port, it will proceed with resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state.

HCD_FLAG_WAKEUP_PENDING is not a state.  It is a flag.

> During the S4 wakeup process, peripherals are put into suspend mode, followed by task recovery.

What do you mean by "task recovery"?  We don't need to recover any 
tasks.

What do you mean by "peripherals are put into suspend mode"?  That's not 
what happens.  Peripherals are set back to full power.

> However, upon detecting that the hcd is in the HCD_FLAG_WAKEUP_PENDING state,
> it will return an EBUSY status, causing the S4 suspend to fail and subsequent task recovery to not proceed.

What will return an EBUSY status?

Why do you say that S4 suspend will fail?  Aren't you talking about S4 
wakeup?

Can you provide a kernel log that explains these points and shows what 
problem you are trying to solve?

> This patch makes two modifications in total:
> 1. The set_bit and clean_bit operations for the HCD_FLAG_WAKEUP_PENDING flag of Hcd,
> which were previously split between the top half and bottom half of the interrupt,
> are now unified and executed solely in the bottom half of the interrupt.
> This prevents the bottom half tasks from being frozen during the S4 process,
> ensuring that the clean_bit process can proceed without interruption.

The name is "clear_bit" (with an 'r'), not "clean_bit".

> 2. Add a condition to the set_bit operation for the hcd status HCD_FLAG_WAKEUP_PENDING.
> When the hcd status is HC_STATE_SUSPENDED, perform the setting of the aforementioned status bit.
> This prevents a subsequent set_bit from occurring after the clean_bit if the hcd is in the resuming process.

hcd_bus_resume() clears that HCD_FLAG_WAKEUP_PENDING bit after calling 
hcd->driver->bus_resume().  After that point, usb_hcd_resume_root_hub() 
won't be called, so how can HCD_FLAG_WAKEUP_PENDING get set again?

Alan Stern

> Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> ---
>  drivers/usb/core/hcd.c | 1 -
>  drivers/usb/core/hub.c | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 1ff7d901fede..a6bd0fbd82f4 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2389,7 +2389,6 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>  	spin_lock_irqsave (&hcd_root_hub_lock, flags);
>  	if (hcd->rh_registered) {
>  		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
> -		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
>  		queue_work(pm_wq, &hcd->wakeup_work);
>  	}
>  	spin_unlock_irqrestore (&hcd_root_hub_lock, flags);
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..7f847c4afc0d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3835,11 +3835,14 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  int usb_remote_wakeup(struct usb_device *udev)
>  {
> +	struct usb_hcd  *hcd = bus_to_hcd(udev->bus);
>  	int	status = 0;
>  
>  	usb_lock_device(udev);
>  	if (udev->state == USB_STATE_SUSPENDED) {
>  		dev_dbg(&udev->dev, "usb %sresume\n", "wakeup-");
> +		if (hcd->state == HC_STATE_SUSPENDED)
> +			set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
>  		status = usb_autoresume_device(udev);
>  		if (status == 0) {
>  			/* Let the drivers do their thing, then... */
> -- 
> 2.34.1
> 
> 

