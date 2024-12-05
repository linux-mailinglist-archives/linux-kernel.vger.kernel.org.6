Return-Path: <linux-kernel+bounces-433517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5F9E5975
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC3E18843F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786EE21D595;
	Thu,  5 Dec 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AiofJIco"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC121C9F8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411547; cv=none; b=TQjxUA2/GdPHLufeLCnthvXpX1BQHUFsos/zBtjSA/k6UAW0dRO52IaCI9BhoxGoUt6AoXih+EqjaWgJ5bh1ugK5ENbxMLdQLa7C6II+YIRbtznNF0p1qNAfpK1gwW91T2OYrXzIzdPcGy65vSf9hhg+vArkiO6WbycmArUwp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411547; c=relaxed/simple;
	bh=8oBlH9Skh5+tYIY+TSUzZhh7emwiSyw93vKxzSMqwEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhjrkZ1KgN15wqP394Uvzk8wzIkck6UDXAbXy9OQr3mKUZ6BIKQDSvD3mtD/03Hsm7a/qNQzzWXu0eNeV7z8mjIQGt3+AJ7MRehKFGdBrTVtJSo0AsnmtTRektOU+iGrEj0XN+FZwxJmIC8tGoX9w8IJitFAsZoHWPqcUfYsj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AiofJIco; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so8452776d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733411544; x=1734016344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpDuirXeCkooc6CrYIBSyW5CbLWq2iPbUdPYDNgR92g=;
        b=AiofJIcoWSSwqw1GEGpOT6SRUMSujaBKPHcX+5hsMedLEoE3U4ASkENK17O8lHZ88u
         rbfsTo5YXQ/FRACXrqjGC8M3+Xz+y/HYuwX+Yf4BVdLBWgGUUn/40jq/vhwC79h+nBGW
         w7ywSB0euUeQ/qLNYAN0TpK5MqvOEW3J+OcCer2YnUmsfTa/3wKbKY09im1dtM0Dnah9
         Kyc86sf3bvrgGBOhYnmCuTnuJGJHNtMDFfDwHBQ1sJxbAsQ3+Cxy7XfvP4PoTWlmgO/b
         NJ2A1sD7It7jHoEYP4eouapDbmoVQgV/SxrASnqcafh9W60H79vU1f1AcH1vWE8xTUjY
         +9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411544; x=1734016344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDuirXeCkooc6CrYIBSyW5CbLWq2iPbUdPYDNgR92g=;
        b=m2IUacd1Zm6LXvVIG6hNoonLC5iZa83tEc2nrQ+59pptrdZ98LpTMTtta2pbCSsG4p
         5aCX1hhGwsYVInI3b81895PN5DZwiNYD6hoB3f+R8pRU4Ls/tfcTsqzTZD9w2kOnoSwy
         SjL3PMsy91twbpmgO//GlwOpU3/WcGdYDHHUZkDd0jHs+6Oax+uWrLy0Z/2KknPDgEMN
         90CDIkstSIMZ6QiqsEYq/krbm/q+Rab24oMGwyWvpLdgDCBmdbUfAPJ4+NPBBlyZXoOi
         lBnGJkJ4pPgZbqKpeWcZYAQ8tqmsLd+uwGRuGfmRr/im45K3ZaZCZkJ07QXeFAPJZI87
         IWPw==
X-Forwarded-Encrypted: i=1; AJvYcCWiBIl5R6/B2PNs7Smnj73wNUJkxsvhm+ePrB93y3yT+oeN7z8wcCjTvAXmP6rd8d3Tnhyy3ydCQz0z/dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mypd0te7E7yTE5WEcMVOh7nvYzZJTHD2JiTiqVrjtgBr/7g0
	Iaqjrm+JbFo2nhNP1PAaiBkr7KIeVxeF9zVhpJJhRqTNdrRjjMBoX5HNGmkqcg==
X-Gm-Gg: ASbGncvbyq8N8WiGwlRODMM2qhuJY2aActpbfZP8PaTz734qr1I/yF/+ODYEitdgD61
	hvSBXfMEC7pQ2HQNcFYZ+fVVsXZkoQWrt2yBtGdk43/Wh7L30y9OOxFClxpmYDhSZgY8RVmb5dv
	BpHLxO6wlM3dLS+3m+g8TbKQQa8uo5DkMXZpkXP2wRagNPZ7eTLtesUeFgQ1S+eJksEVKgHq2Vp
	EEtdUNfzbIpJ6z7d0WP8MvHaJ0V3/bQPfwSkSGtVlNf9VRzN3c=
X-Google-Smtp-Source: AGHT+IGMhfCAwtSQVxKuS1TWRYoQx3MDjyra1gBdo8y0EUiz1ShXMjGXkrxghW12qu50gM/TSSZqXA==
X-Received: by 2002:a05:6214:29c9:b0:6cb:e648:863e with SMTP id 6a1803df08f44-6d8b7454e0emr157169546d6.43.1733411543697;
        Thu, 05 Dec 2024 07:12:23 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66ddd4sm7370816d6.9.2024.12.05.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:12:23 -0800 (PST)
Date: Thu, 5 Dec 2024 10:12:20 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Deepak Saxena <dsaxena@linaro.org>,
	Manjunath Goudar <manjunath.goudar@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-spear: fix call balance of sohci_p->clk
 handling routines
Message-ID: <81c02947-5617-4ab5-a8bd-56349b9929f4@rowland.harvard.edu>
References: <20241205133300.884353-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205133300.884353-1-mordan@ispras.ru>

On Thu, Dec 05, 2024 at 04:33:00PM +0300, Vitalii Mordan wrote:
> If the clock sohci_p->clk was not enabled in spear_ohci_hcd_drv_probe,
> it should not be disabled in any path.
> 
> Conversely, if it was enabled in spear_ohci_hcd_drv_probe, it must be disabled
> in all error paths to ensure proper cleanup.
> 
> The check inside spear_ohci_hcd_drv_resume() actually doesn't prevent
> the clock to be unconditionally disabled later during the driver removal but
> it is still good to have the check at least so that the PM core would duly
> print the errors in the system log. This would also be consistent with
> the similar code paths in ->resume() functions of other usb drivers, e.g. in
> exynos_ehci_resume().
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: 1cc6ac59ffaa ("USB: OHCI: make ohci-spear a separate driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-spear.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
> index 993f347c5c28..6f6ae6fadfe5 100644
> --- a/drivers/usb/host/ohci-spear.c
> +++ b/drivers/usb/host/ohci-spear.c
> @@ -80,7 +80,9 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
>  	sohci_p = to_spear_ohci(hcd);
>  	sohci_p->clk = usbh_clk;
>  
> -	clk_prepare_enable(sohci_p->clk);
> +	retval = clk_prepare_enable(sohci_p->clk);
> +	if (retval)
> +		goto err_put_hcd;
>  
>  	retval = usb_add_hcd(hcd, irq, 0);
>  	if (retval == 0) {
> @@ -103,8 +105,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
>  	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
>  
>  	usb_remove_hcd(hcd);
> -	if (sohci_p->clk)
> -		clk_disable_unprepare(sohci_p->clk);
> +	clk_disable_unprepare(sohci_p->clk);
>  
>  	usb_put_hcd(hcd);
>  }
> @@ -137,12 +138,15 @@ static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
>  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
>  	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
> +	int ret;
>  
>  	if (time_before(jiffies, ohci->next_statechange))
>  		msleep(5);
>  	ohci->next_statechange = jiffies;
>  
> -	clk_prepare_enable(sohci_p->clk);
> +	ret = clk_prepare_enable(sohci_p->clk);
> +	if (ret)
> +		return ret;
>  	ohci_resume(hcd, false);
>  	return 0;
>  }
> -- 
> 2.25.1
> 

