Return-Path: <linux-kernel+bounces-254060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91A932CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF15E281DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBF19E7C8;
	Tue, 16 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WY0JRKAh"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E119DF71
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145590; cv=none; b=gnCslG9nMFDBB7+nEyDftT0CGV/H5i4Y8ocIj8NsNWOQjUnmPuyWP6yLk+uLmuZtPivHwfsKQ0obU+sT7RJmc271XdVrqlSzY9NAz6Rwkkp1NLz+/imve2R3ukIWkC8es78b7KA7BsxzXSRBbRYGy+luQNlPOp4tdpd6VRxmOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145590; c=relaxed/simple;
	bh=/f9cEEl/8MayIBFDh5qE7G73v8hj1iS5ECJxNgSsu4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC0OLM4Bxx4FXDyaVhzTn31MMFcst8/BRP9IbLVyvFvWdxKvifRS9zmxKdAxaBMJ4LNWPFTmG6ilib9BMoPZq4Leh6EnExjzemgp1A3mUydT+s4YMFkBd0HozT8IoAtlsKYoGKnHylyQW5n9D54XKcLMPa6RRrouGaJ31ykLDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WY0JRKAh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so3740339a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721145588; x=1721750388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kl3Jx4H/WoP0kRmoJKehZi92SYKLfR+SxVfx7nbEybM=;
        b=WY0JRKAhQJVDB1jbkAmT9dTD1ZuzxGieKRzJMbonixWI6s2iQwjMKDeI3J+PqPs13i
         WENE5IPFrJviymrNeJJ9LOjZ89TGAdWi0uNoox+M/HVutjVTmJlRuOTPGrvd5LxctLzr
         rwnkUQwOEEeV8IWEMHEbtfbNgCgTL+BXfGJ7//40qDadj29Sj+v1oju/McmpomAITMBx
         sC5ea/kxhSBdKpeL1779ei8dObvoAQSoZEF9ltCrU2GI+PUcw380bDUXzmF8BfMIZNpz
         8RAFUN5KcCzTwLEjdF7008WSgdgHkZ+px/j329CNb4vkWjPMGxYlbWqw8ZCPr7DjU0bC
         p3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721145588; x=1721750388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kl3Jx4H/WoP0kRmoJKehZi92SYKLfR+SxVfx7nbEybM=;
        b=TPn/wYcvgwUE2nhtZP8Cy1mnmhL63o5mmDrsHm5miksdhm6BUsoWhFfuLI8mkk4goe
         x76L95qns1aIzDQ6tDxC53gf5XrMPdokHj/SlAokDyo2EQMj3JYS9la+QdU8LPyBuA8S
         OOMoiWyaI+IMsEYP1VT6iPMPxA1gOqYI9+62eUBEMFQ++mjJlcfGxvydoBBLTGTrkLcT
         hbBoNf/ZvOvf0LgMVRMl7nbJxrZp7x0RB1pRD52e4cQ9qRnRAlvuSLva1jxXjB8t2rLZ
         bT6WBj+kEmnKMtHRfZtgmQPsGMXg/IBBH3RdBLQysC4jygrXHZLNkbxy3K0p1jIO9Cpb
         O7IA==
X-Forwarded-Encrypted: i=1; AJvYcCU0AMGkkRDsWnXiIflVxqt4FFljMgKOhhZvdKVoHKoZlO27zdgRUCfgQrPyazvq64Wr6SNG0MVShTbtAy+lt0G3yrxtWsWP0bDFjcLk
X-Gm-Message-State: AOJu0Yy3ahvM6mHuiNz/RH/C5UQeL9tRygaJjOyYDwtimh+NtsXpxMZs
	4NY2GMlEjYaGWXyWTx+Q8adJAoka9EnQRyMNDWgW8DqrDopZgqGxG1OuG6IEZXK67HbjuYq7Fto
	=
X-Google-Smtp-Source: AGHT+IHHz98ceVJ8T5HzQt1BnBw5Awqzt0u6lGO5YK4BDL0d0/bxDwtAIk26dAssJfi7VGkM8sJGdw==
X-Received: by 2002:a17:90b:4c8a:b0:2c9:63ef:95b9 with SMTP id 98e67ed59e1d1-2cb37402065mr1970857a91.14.1721145587606;
        Tue, 16 Jul 2024 08:59:47 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd419b6bsm8487009a91.27.2024.07.16.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:59:47 -0700 (PDT)
Date: Tue, 16 Jul 2024 21:29:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
Message-ID: <20240716155943.GM3446@thinkpad>
References: <20240716152318.207178-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716152318.207178-1-brgl@bgdev.pl>

On Tue, Jul 16, 2024 at 05:23:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Kconfig will ask the user twice about power sequencing: once for the QCom
> WCN power sequencing driver and then again for the PCI power control
> driver using it.
> 
> Let's remove the public menuconfig entry for PCI pwrctl and instead
> default the relevant symbol to 'm' only for the architectures that
> actually need it.
> 

Why can't you put it in defconfig instead?

- Mani

> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/pwrctl/Kconfig | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> index f1b824955d4b..b8f289e6a185 100644
> --- a/drivers/pci/pwrctl/Kconfig
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -1,17 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -menu "PCI Power control drivers"
> -
>  config PCI_PWRCTL
>  	tristate
>  
>  config PCI_PWRCTL_PWRSEQ
> -	tristate "PCI Power Control driver using the Power Sequencing subsystem"
> +	tristate
>  	select POWER_SEQUENCING
>  	select PCI_PWRCTL
>  	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
> -	help
> -	  Enable support for the PCI power control driver for device
> -	  drivers using the Power Sequencing subsystem.
> -
> -endmenu
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

