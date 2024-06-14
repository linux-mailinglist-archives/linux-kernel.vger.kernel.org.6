Return-Path: <linux-kernel+bounces-215425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC66690928C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF62F1C21AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3461A254F;
	Fri, 14 Jun 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="f4+ZqOpx"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53F1A0B1B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391130; cv=none; b=eji2lrQffxTzWQ6ciLQDBOQz0PVnJRf9ywf9PKEIabeUOkqgQ+2dJtGNuFvhfXlbMGt78VRjuR5CANFnzUXiy7MrDKvtJPfeb414wyHMuU8fRF9IMTzHFVvsLsPgkWWyygmMC9Se1WSp3nbuBj8Z89jX2UNOaOJIHqyo058h42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391130; c=relaxed/simple;
	bh=Wnop8Qq538e7eVgLq4rlSTIJC3zohtdzZO1W1QS3zjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk6vy9azXi9wCOyhIQ8yV+Rlf1JOhGS3LLciXLe9AIzmnoI2czvmg+zrZByOufS5sC9DEMKCy7ViT21qqAujOni10geeV/CtVbMH41tXh1I8WUQD2sxk4avSmGU9Iw+zUT6Ih68Ag2jSoGmE7Mg/HfBNQ45kddWZMJ1rAlK6oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=f4+ZqOpx; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9cc681ee7so1071253b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1718391127; x=1718995927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVDBvdP08HJe2LLNeEFHiRk2XhY0KePdWqVaxMDbvKE=;
        b=f4+ZqOpxDlaOGx/uXxzo+JBV3c2J+GdTOHq0+3o/5hHOeiEIA3IMlgKm9Hvu7Y+4Pn
         HKoQYCiCJj7/mPtUf5e1lapZ3Stw453sOUQmF43/uKKN/vqrX+TshpH6rxDd1KQ7zN2x
         EOGzifnTP+0JdNPUnf5sv5ffBAXf+KbzaJ50jCN1lv55KQLh1VB3OSuyCN2R/iUEZ93O
         kN87c9B6b1nv3WH2i50U1tVXOQocVi+ftsmta9MD6vSkoz9WLR2+IMxCgtyhL0oFYjuH
         4IXpXhNh5eLnMGKUUHtWmSji8+VhyIHzRXeUaHP7L6izMP2mjkzQB0iZCBBCyH6gicic
         y6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391127; x=1718995927;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVDBvdP08HJe2LLNeEFHiRk2XhY0KePdWqVaxMDbvKE=;
        b=snndWa2kYoCtFGQNskYAr/pfC7vB2LcFhRb4nsfxVQihfBkMFzi0X3LFmPFU+fPTQB
         tG/pNYcTnYK0q/sEiKT/uyCzaVKAyUF1UjY8yyANgDl0Vl/EFzsi3SbK7cY11fdZXOkq
         r4J0q1fjyROz/7V8kWEpnNEtsqAPNvHP1p9mkmD0u+uDFCi3Mbm3plf/Sbu04CWqUFfw
         +Ayx3CsdkhT2hhFzuTKS2eYmkUx/xtDeRNaGjTDm+WfG7Kki8jG7caxxUzfFsk9aJ+sS
         WMKMG2BQzou4NVslXVyuMX5vXDCB2uv+PZSTvDxOJhmHeaJNbbSdJN79I0GW+xyKQOyB
         yHIg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHwXwEYtXZ0qrYov0i/JhS1EkyVXC0YZgI37AU5X6j922UbYTKOj+J8dUNCGR2K7HzOJxmLHY3/HQ7IUAOGGpI5CYT6bzu9womyCQ
X-Gm-Message-State: AOJu0Yys2aA0mb9maNSd/kewtf9P4DN+OffVNgOPvEo+dD763yp0P2iG
	3H5YjHQ1DeD2+7D/2+toWf2nGESj0wrgCELpffNRfywsLwmu/feOL0wRnRgbPJg=
X-Google-Smtp-Source: AGHT+IH5wsewHDu4BXzms8+/hfuFuKIa/9eeUhy5xDV/FWcrmW7WzNgNCo/H/BIyrLMqqglhgTp+DQ==
X-Received: by 2002:a05:6808:11d0:b0:3d1:d36b:379e with SMTP id 5614622812f47-3d244f362e9mr3226002b6e.26.1718391127297;
        Fri, 14 Jun 2024 11:52:07 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:c3a8:c961:e73:5e22])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476bb36fsm618151b6e.40.2024.06.14.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:52:06 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:52:05 -0500
From: Corey Minyard <corey@minyard.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Quan Nguyen <quan@os.amperecomputing.com>,
	Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: ssif_bmc: prevent integer overflow on 32bit systems
Message-ID: <ZmyRVQzcIbDwgnP9@mail.minyard.net>
Reply-To: corey@minyard.net
References: <1431ca2e-4e9c-4520-bfc0-6879313c30e9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431ca2e-4e9c-4520-bfc0-6879313c30e9@moroto.mountain>

On Fri, Jun 14, 2024 at 08:30:44PM +0300, Dan Carpenter wrote:
> There are actually two bugs here.  First, we need to ensure that count
> is at least sizeof(u32) or msg.len will be uninitialized data.
> 
> The "msg.len" variable is a u32 that comes from the user.  On 32bit
> systems the "sizeof_field(struct ipmi_ssif_msg, len) + msg.len"
> addition can overflow if "msg.len" is greater than U32_MAX - 4.
> 
> Valid lengths for "msg.len" are 1-254.  Add a check for that to
> prevent the integer overflow.

Thanks, this is in my tree.

-corey

> 
> Fixes: dd2bc5cc9e25 ("ipmi: ssif_bmc: Add SSIF BMC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/char/ipmi/ssif_bmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> ---
>  drivers/char/ipmi/ssif_bmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index 56346fb32872..ab4e87a99f08 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -177,13 +177,15 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
>  	unsigned long flags;
>  	ssize_t ret;
>  
> -	if (count > sizeof(struct ipmi_ssif_msg))
> +	if (count < sizeof(msg.len) ||
> +	    count > sizeof(struct ipmi_ssif_msg))
>  		return -EINVAL;
>  
>  	if (copy_from_user(&msg, buf, count))
>  		return -EFAULT;
>  
> -	if (!msg.len || count < sizeof_field(struct ipmi_ssif_msg, len) + msg.len)
> +	if (!msg.len || msg.len > IPMI_SSIF_PAYLOAD_MAX ||
> +	    count < sizeof_field(struct ipmi_ssif_msg, len) + msg.len)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&ssif_bmc->lock, flags);
> -- 
> 2.43.0
> 

