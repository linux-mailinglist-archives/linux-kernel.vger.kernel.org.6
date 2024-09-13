Return-Path: <linux-kernel+bounces-327821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FA977B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951BE1C262E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25611D6C79;
	Fri, 13 Sep 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3MpF1HH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0651714CD;
	Fri, 13 Sep 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217515; cv=none; b=TdAzkJsZhl3d0nTxKQUjR/QONGTfVik2s89/ykkey1abe15d5sV9CPOiR00X7AqdVy79LWqEh6IuSQc1WTaGIpTJ4VJmWxKoZyshUUVk3vOexPyUguD7Wc7L5++EO3wyA08BiOUw/y1ui9Zae9tltqvRUw3S0YvwUDFeWcTUn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217515; c=relaxed/simple;
	bh=NTzttWqrbCGcePhblw3/n6xG8yRKJoBHaeMA4ZzQAYk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F9kxCB5UhxxuGVxpvzLJnUQjqMeovl7bvEfSl9SC25zWOe2mg0ujKvYBv+5MvYa5C/aBkWH9RfWM5S+KTBZNf8nlyV2Na7TsuKm6ozzrBOchXv12WmH0uh/GA68k1ztzgeAcn+hudM6+TlQn5nKp1j8FAylk9FzzCQcB3T9dfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3MpF1HH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53659867cbdso1034623e87.3;
        Fri, 13 Sep 2024 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726217512; x=1726822312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk0E6BCm30g0GxBtlyK/KF5VtT4XzwvZU2m9YT6pjqo=;
        b=D3MpF1HHIEL8cgDCTUNXQ10Pg/3EVDEN4o5wxAVKozaW8p2DSQw3qwBBxhSn9G12QH
         QTgLJ0JByO+Hl6jXrGAGP4c9sD3Mad1v8hIe/iBHJlnfuGtHOs5N14XWftvsYtl0HpTF
         cUD0AwWvcZ4kkTDwa7B6qfuErWe7PlVN/6xEl9Jyu+LFqJsCTqvy4ASPzXjSzLZ7hpj7
         KtPDTelPaxOkhjTaHfbxYREhXIWxJgQrXouBsCifjTtgAIpyspx45rbys7ksl+QzpRD/
         Ea/frCWxQ3fR/oe01hzhyT2w0pH6MZy2sfVmdpvL+6bfOt292Xjs6oaL2Ky4X8O5qzLI
         7iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726217512; x=1726822312;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk0E6BCm30g0GxBtlyK/KF5VtT4XzwvZU2m9YT6pjqo=;
        b=JXvi/Z+e8bWB8aJ3c+JG4laeSAMfLvFx5pue3PxGIJU9jmeRZo3rF9LGKr4kuJ86JN
         nbWvBToGvoF/xSMplVJ8ttJsSHelppuSTifMswBToRHOSFon+qPnlO1GRUMxjhIBjOUt
         4jOw5Epresl79ppnNq2QS2rHm2x11IuxuMA3bD15iKtsjiRNbZYzTrxpQQ5c1b1RKo3i
         0YBdGTbvB4AsKBSLohgTGbeYM27FAHWXC/JAZkFW1fa43Pii1OO0bbyLDPrLSBvnHk0R
         tk2fgDFZVbMijbWBCCBNoqgsdlHA2vMh+0/+boFc5nADAELckMdjdJYsFtOhOao32cDk
         q4dg==
X-Forwarded-Encrypted: i=1; AJvYcCVCdoV+Px8m6tOKlaCKFndTXIJZvIID9SC2dSuDDaZKacGCPWHKahPdWzWSwQopl6lx5DKJhSW3hxhj2v4=@vger.kernel.org, AJvYcCVxoTrxwJ+dBxbjiBN2sZ8wnb88zBI4DTIcNa4rbEcXfGyKYYwoEzG6PcwnlQvksO3pmiu+I+bRmvX0@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqgWU5fJQqLDd37wgt4tyJ+JRh1acLvoDuL4/SWjo74pU6yED
	r/4DdhvJUJOgtvZti47A1NuHd6jwTCQbK8nhea82rVz+ssOXAu5yOCU35A==
X-Google-Smtp-Source: AGHT+IGxNi/eksmtDF9xNgBpBumKlvsbz3pMNR6bhHQfTmiKOxvcJ675AwKH3vEM2OB16uqxa+kP0g==
X-Received: by 2002:a05:6512:224e:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-5367ff329ccmr1750424e87.51.1726217510618;
        Fri, 13 Sep 2024 01:51:50 -0700 (PDT)
Received: from [192.168.1.106] ([31.173.86.0])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5367ae68509sm511807e87.89.2024.09.13.01.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:51:50 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] xhci: pci: Use standard pattern for device IDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>
References: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
 <20240913084411.3309911-2-andriy.shevchenko@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <9ccea075-5724-3a9c-738f-03eb2d519c45@gmail.com>
Date: Fri, 13 Sep 2024 11:51:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240913084411.3309911-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 9/13/24 11:43 AM, Andy Shevchenko wrote:

> The definitions of vendor IDs are follow the pattern

   s/are//?

> PCI_VENDOR_ID_#vendor, while device IDs — PCI_DEVICE_ID_#vendor_#device.
> 
> Update the ETRON device IDs to follow the above mentioned pattern.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[...]

> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index de50f5ba60df..6d9eb2b031e2 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
[...]
> @@ -388,12 +388,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> -			pdev->device == PCI_DEVICE_ID_EJ168) {
> +	    pdev->device == PCI_DEVICE_ID_ETRON_EJ168) {
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	}
>  	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> -			pdev->device == PCI_DEVICE_ID_EJ188) {
> +	    pdev->device == PCI_DEVICE_ID_ETRON_EJ188) {
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	

   Hm, these 2 *if*s seem mergeable?

MBR, Sergey

