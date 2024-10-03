Return-Path: <linux-kernel+bounces-348790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F498EBE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9391C22A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D713B2B4;
	Thu,  3 Oct 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M04nxZ9m"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5313D29A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945449; cv=none; b=NvQDcsyF+6Fk9ejjBA0NyPLH0D1aOpV15voja0We+ZpkUr/avtLwjpCXW0muWwnQ1ed4UDYnFIkT0hrzXNvtZSr3b/AdFPWlQZ7SpoFHIC/gFsY1hA7IDKbIEQmw5LNi/J15RvsfEsBzkTjJp15cxHBznthEjX1WZl2JN0jFb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945449; c=relaxed/simple;
	bh=/FmHmBpd5XDOLhQhi/5I3Km8K1myZ143jQBtndvdIOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe0lEriR3Lv2wCnmxjRwx+t4WSWOWmyQmIsxM9ffqCXYJv3CdRFeJTQ3AqfayUsqVK/tSMkvKvbo5Nx7MgXNektIDupctx6H6/ACS2LmRqJAuJe616oHBoDSVTn8J4DRjvcDLAV9y7U+G7IpBVQ8hS7YleaqNQFb6vDy9ilZ0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M04nxZ9m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71957eb256bso686402b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727945447; x=1728550247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KQ7+I4I78I58DCOoMZSP/bllSWx1mddI+1OwxdetBE=;
        b=M04nxZ9mK3liv7VZMotY/Z5VWMGKY24OGYnGDnYjSv8jBAwx71YXfM+9TsgR8+2nws
         0kDjITYrEgLKqZezDvDRZ79/oj53ErPZ31eOT7gsfaCHOmqY+8k0LqeO123mYzjHE4K6
         sjVbazew4HWqNmnS/np3TvwevI9uf4102SAXGejvosh7wFaPwcY0fSZ090W3YDX6yn7Y
         gwZpMB/HiWBuxg41psiHpPUs19NajTOMpozltARuraTLhUzKnyzrjwgc/6Lgjie7fhN+
         Yc4GzpyszjjT/GRDIT3CH997Q4oWxEC34GH8VTTGhkmnvtiyl3zQzPecA3cH8Juk9LFC
         sfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945447; x=1728550247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KQ7+I4I78I58DCOoMZSP/bllSWx1mddI+1OwxdetBE=;
        b=gz4eZpmW8MG103uvt0QNJNeTv85HwxFnnQzYEosDSwz9GWgKcyMUkvKMAGmnpWHuCl
         v/9NhkpqCUBagzXDCRjgTt9Cjrp3XxGSih/tz6xPyc68H57GEBUwv5cOxWY35cSA3SfZ
         uu2MDx0bkUgupZrbsy6wD7yVSU7eW7V8g9DvnRLJwdAmevkilDcTcZdYpUmJsDt3/GxL
         QggULk20l1VS0E4UHKcxsqKBt3DfZ/rCY/lzPyuIEvgbc7KkIr026vgqgxubIdc/f8ed
         BNzWneoqZa9TqKcS0avnmgRQTdpak85Fi6A/wg4zxhaCuLm8GaWopeLXjULaOutYREK5
         Z8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3K8tLf5txtBeeiwCd16fvCAKMwsPuzNDDRvXKPPpIuYkGncN9PCHbg0yvbxpRUIS/MpdN6lY1atCK+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1dCVyafR1S0oRv7ba7PoYRF3+rm0v4Zjig25Eoi1Iww+cyYg
	I3bN1wd+gcwr0HotqrwU4bIJ71irom4aaqS1HgXUrIyD9bc5L8nCTGz5nGiWzy2g4HEVez2JEyU
	=
X-Google-Smtp-Source: AGHT+IG2HoPAdPTHe9BKFz0bx6mX818wSoCf/G1Oj2DqmoO9d5KjePwIuI2iQfkVv1fwjTfAhr8xiA==
X-Received: by 2002:a05:6a00:4fc5:b0:717:90df:7cbb with SMTP id d2e1a72fcca58-71dc5d5bf53mr9374915b3a.22.1727945447365;
        Thu, 03 Oct 2024 01:50:47 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e65fsm829846b3a.87.2024.10.03.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:50:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 14:20:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] PCI: take the rescan lock when adding devices during
 host probe
Message-ID: <20241003085042.w7d3h2tiogr56un7@thinkpad>
References: <20241003084342.27501-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003084342.27501-1-brgl@bgdev.pl>

On Thu, Oct 03, 2024 at 10:43:41AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since adding the PCI power control code, we may end up with a race
> between the pwrctl platform device rescanning the bus and the host
> controller probe function. The latter needs to take the rescan lock when
> adding devices or we may end up in an undefined state having two
> incompletely added devices and hit the following crash when trying to
> remove the device over sysfs:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Call trace:
>   __pi_strlen+0x14/0x150
>   kernfs_find_ns+0x80/0x13c
>   kernfs_remove_by_name_ns+0x54/0xf0
>   sysfs_remove_bin_file+0x24/0x34
>   pci_remove_resource_files+0x3c/0x84
>   pci_remove_sysfs_dev_files+0x28/0x38
>   pci_stop_bus_device+0x8c/0xd8
>   pci_stop_bus_device+0x40/0xd8
>   pci_stop_and_remove_bus_device_locked+0x28/0x48
>   remove_store+0x70/0xb0
>   dev_attr_store+0x20/0x38
>   sysfs_kf_write+0x58/0x78
>   kernfs_fop_write_iter+0xe8/0x184
>   vfs_write+0x2dc/0x308
>   ksys_write+0x7c/0xec
> 

Thanks for adding the crash log. It always helps to have the log in patch
description to find *this* patch.

> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v1 -> v2:
> - improve the commit message, add example stack trace
> 
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..f1615805f5b0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	pci_lock_rescan_remove();
>  	pci_bus_add_devices(bus);
> +	pci_unlock_rescan_remove();
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> -- 
> 2.30.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

