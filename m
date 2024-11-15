Return-Path: <linux-kernel+bounces-410419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A39CDB55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09DB281F57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6AE18A6AF;
	Fri, 15 Nov 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCY46aTR"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE863D0D5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662290; cv=none; b=RWrkAg4gtHZJWOfw5hl3daTYZ5Izol8vNYf2WiBvnQIlG4yGfRO2/zwWhLpf6aNDuR7AkmOkKR3jf5Xogi3Q6os8eMy/X9xSNN/Zkc5y3ujdMSRKtTdFpZIDf8W9cygqZZImr0+sglchwXkInzqaMjRk3PSdAdXgLf/7lcCDfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662290; c=relaxed/simple;
	bh=qqeiaL5NykQfrPHYUw6wgvGixgN3W06DlRNcgeCkRHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/fYRppw05OJh5RCKv9+PIrA81ywhOdI/7Xnu5XDmhbSf6pTaREyyT15Kt3yQObXvhyU5es1iiC7o2pvFQjac2VPVUVbtUZgxJASo3T9lGCAUhkvgS4a6ndaYGKECWBb4qegC8uffk38vCSz5xzBYZc2FbNbUyEiGK/qNXmsoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wCY46aTR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso1324070a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662288; x=1732267088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0ZNc3FqrVEx3WM8p2pnlvV9LYAT23GCoRvvHS9Wd68=;
        b=wCY46aTRK8/IoOhgUYpVHiZMvvv+QXWtYj7Stj8Ab48fuoQ3A6x4eJq9JmwVn2MRcZ
         x2Oem/4RflEOXnd6QNR3qaptlBQSyniVkl+6rjK6dUQe5plW6n+xotfoYeQrVMHD1bCn
         n2pCD8EHrIiiZ0Wz6R+tjwUtJLq1mwNMMwVXFipzl98OO/0fACB+Hn0Jo8CTopJGfuGI
         xwD3sqa50CegbvwS8KbS5xbm2w79Mf5mVHRIBIfiUu7zGQzGv03aVW4MFqJpuDcrr/YK
         oCPGViAF/Zdeebjv2uYmrKDxUoK3MOustYQQe9nYMhoerc7t1W6YWwzmpLnAP83sj8ru
         pS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662288; x=1732267088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0ZNc3FqrVEx3WM8p2pnlvV9LYAT23GCoRvvHS9Wd68=;
        b=LoTaw/tOQlHbzVuTN0ZxVBhYsZsKRIPvBTQHq+va0Cvu9Nt2ghRYJkyLXPXt6ixe81
         AlKTH4/HGiPF5TCHYAFaaQxY9hCQ7zTBK8gB1pwwnofkSS5UZZ4yvj4xNDc8eEe3wuac
         c6W61J3y1sUhN6kgQ+0AORfR+H/U50x4XmzbrbNQwGmGyG3wq71i558rPNa5eZX7SMNC
         oFGGPnNGbDZwcuKp2iKDRdtR/kr2EoGuxJZY2N7wNYWevGGYGdVHNaLBzTYL5PNFaMAS
         2ARGHgkEXSDTLY3y6K6tz5kkWrmu5u5K5+tG1k8ZJ6ESgwALOHAHiGDEPFTE3d4aOnVc
         w4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB2KotYkESMFIoNhSE11QLF/7AFH/D05n0IciYxblR4sUBCDxVyF86yN81mEFb0lzHmO836FAj3pJoUeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnaf+yUShBfFNXnIUkgTj662pkdX9KFzlagFBn9Y+i4bz6LRS
	W1Al/PHbDSeZmGHrhHv7Nwr8w6bB92DPl4RHcJ1/9W3VRH2YWtHU6ZP4A8PZHg==
X-Google-Smtp-Source: AGHT+IFiw4LXRo8HqMygrCnoRpV+6wXgJ5hiFEiuhbbxBAUzQ7mLi2e7kDhHQXw6flZ6SWWJ/m7Erw==
X-Received: by 2002:a17:90b:4ecd:b0:2e1:682b:361a with SMTP id 98e67ed59e1d1-2ea15587d6fmr2071088a91.28.1731662288307;
        Fri, 15 Nov 2024 01:18:08 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9f1f3sm2398700a91.37.2024.11.15.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:18:08 -0800 (PST)
Date: Fri, 15 Nov 2024 14:47:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 2/4] PCI: host-generic: Export gen_pci_init() API to
 allow ECAM creation
Message-ID: <20241115091759.5wogqwvyaqgc7iua@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-3-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106221341.2218416-3-quic_mrana@quicinc.com>

On Wed, Nov 06, 2024 at 02:13:39PM -0800, Mayank Rana wrote:
> Export gen_pci_init() API to create ECAM and initialized ECAM OPs
> from PCIe driver which don't have way to populate driver_data as
> just ECAM ops.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 3 ++-
>  include/linux/pci-ecam.h                 | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index cf5f59a745b3..b9460a4c5b7e 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -20,7 +20,7 @@ static void gen_pci_unmap_cfg(void *ptr)
>  	pci_ecam_free((struct pci_config_window *)ptr);
>  }
>  
> -static struct pci_config_window *gen_pci_init(struct device *dev,
> +struct pci_config_window *gen_pci_init(struct device *dev,

Please rename the API to something like 'pci_host_common_init()'.
'gen_pci_init()' is fine within the driver, but doesn't look good when exported
outside.

- Mani

>  		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
>  {
>  	int err;
> @@ -48,6 +48,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  
>  	return cfg;
>  }
> +EXPORT_SYMBOL_GPL(gen_pci_init);
>  
>  int pci_host_common_probe(struct platform_device *pdev)
>  {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 3a4860bd2758..386c08349169 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -94,5 +94,7 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev);
>  void pci_host_common_remove(struct platform_device *pdev);
> +struct pci_config_window *gen_pci_init(struct device *dev,
> +		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
>  #endif
>  #endif
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

