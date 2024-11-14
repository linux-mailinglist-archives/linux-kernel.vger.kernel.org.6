Return-Path: <linux-kernel+bounces-410063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A29C9610
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E2BB234E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF771B21B8;
	Thu, 14 Nov 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="G8LOJ57s"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72171AF0B7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626578; cv=none; b=ROrI6gcz3V8Ub+KFos77NOPXAsDd6k57//H5z061rWejvEeX8Prpj4fYBPqz1br+g4ItTk1xv5NVZzz9xdNRjRszETEv+PyfvlJUPub8u/4BwDJcDCRCmkfvsa7cRiBW0H2HhrWhwx9xrzic81Axw7EwNiBEtd5dUjkuouWKv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626578; c=relaxed/simple;
	bh=TWnpyIatOfVsTW5fWjCdwqVZjLxprKAsxdhtPO+S+RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6+QuHkI92eLvSwDzgnWCCUQ8cLiMYHLenRBXCwhCjly/AGgHyE/lFU8n0x6WHvknu/rnE7ErkR0h/SJRLxlxeOS8i4qd3oage4n1ZKBdb6AXIDMmeDhUGqsBP2G5lYIr8wYMm/+g8E+tQNYXjzryn75wGg3qNZLn9Tku9V5AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=G8LOJ57s; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b13bf566c0so65484185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731626575; x=1732231375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3miarDpBKS5LhnK/EzKRYHtnDfo0D2mSnrLFUUoEoc8=;
        b=G8LOJ57s4rMd3Cfk+FQP3ephIWB0pHS5e0yyex14o3svIQVppeFv6Qiyj5GoxyPkmP
         8njkNy2QLt6+0hBqvEFf/O9Lwl0p0SuWRmkGdJDUItNqbx9GMSniQTh6he/aiYpPyDBS
         BW5OLXV2tkRkZh1ZZaemgl+9x8HEQMQExLscrqpAxZ4YdbstwH4W5E83Lw6wVcWmFlLv
         AAcVgSz1JQ7zv9Y7hP6zhcAC5kPZxONPUoSiJsaHdgJpPRNRBgWb2tKkl70BA/wLqY2Z
         gSA3xaIBg9DTG02qhRFtHcNUbPeMPF3A3MqQGTYP9fsWToTrb2UwRxpn4i5FcjGfAQSe
         SyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626575; x=1732231375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3miarDpBKS5LhnK/EzKRYHtnDfo0D2mSnrLFUUoEoc8=;
        b=Pk1aOoE5ROZJeOjEtMfasHgs8s3JAzEHeWbVbm19bcLeFZVZx7YVbjRtlQdGNRD6ab
         fsJRY6yn1pMz1Jqt1fLK4reatpn91oYpGhnofJP24dqlzTxjvE59ocgIOrPTYo5KNeGF
         KwkNjaqErS2ydwNYrnv2AG5/J0sWMCYY0nk90WueWo9g6GpQPYlLPCSfgQPbYEr6kW7z
         TRO2e2fgcxV+0DzXeJfiKjDsvJvUKcI89gJgAcGfoIZ4p1Amd7eyrib5pgtiknehnrln
         VQ8XiEtfHdeAYswFm6NoD/ZW3XmcW7TjDsEYFTm1RVwH2O8Tb+Gjlv83rZtTOhl7orJe
         xVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfuBRtBlk3a+4IEBXpEMsWYmoZqtWGA0L6S9yrb1fJ0UX4wuEC3S8VOAsmaZ+dONVX4VfF/g5j9kLd/tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU3usOnPNEj2T3CdTlTjEnOW1vqokID/yveo0fgMVT7/9vs1M
	hySPoV9lxHniYoZR3yyy18sPLAjXyAYzhNIVM8qOxou8xJU06cFEMjUVaAwuhA==
X-Google-Smtp-Source: AGHT+IFjqrMVlowDr20dpgTwYGF+thfsw4K47/2damjGsM8Ss1t2jb6yNgUAMmnFYAEV7eQ7+iqVVg==
X-Received: by 2002:a05:620a:2446:b0:7a2:c13:458d with SMTP id af79cd13be357-7b36230fecbmr94929485a.42.1731626574793;
        Thu, 14 Nov 2024 15:22:54 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::24f4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c98458dsm100205185a.14.2024.11.14.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:22:53 -0800 (PST)
Date: Thu, 14 Nov 2024 18:22:50 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: ehci-spear: fix call balance of sehci clk handling
 routines
Message-ID: <b507c3b1-931f-4abc-870c-68f377cd7b63@rowland.harvard.edu>
References: <20241114230310.432213-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114230310.432213-1-mordan@ispras.ru>

On Fri, Nov 15, 2024 at 02:03:10AM +0300, Vitalii Mordan wrote:
> If the clock sehci->clk was not enabled in spear_ehci_hcd_drv_probe,
> it should not be disabled in any path.
> 
> Conversely, if it was enabled in spear_ehci_hcd_drv_probe, it must be disabled
> in all error paths to ensure proper cleanup.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: 7675d6ba436f ("USB: EHCI: make ehci-spear a separate driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-spear.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
> index d0e94e4c9fe2..11294f196ee3 100644
> --- a/drivers/usb/host/ehci-spear.c
> +++ b/drivers/usb/host/ehci-spear.c
> @@ -105,7 +105,9 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
>  	/* registers start at offset 0x0 */
>  	hcd_to_ehci(hcd)->caps = hcd->regs;
>  
> -	clk_prepare_enable(sehci->clk);
> +	retval = clk_prepare_enable(sehci->clk);
> +	if (retval)
> +		goto err_put_hcd;
>  	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (retval)
>  		goto err_stop_ehci;
> @@ -130,8 +132,7 @@ static void spear_ehci_hcd_drv_remove(struct platform_device *pdev)
>  
>  	usb_remove_hcd(hcd);
>  
> -	if (sehci->clk)
> -		clk_disable_unprepare(sehci->clk);
> +	clk_disable_unprepare(sehci->clk);
>  	usb_put_hcd(hcd);
>  }
>  
> -- 
> 2.25.1
> 

