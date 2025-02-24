Return-Path: <linux-kernel+bounces-528361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1DA416E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4927C16D51A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93824169C;
	Mon, 24 Feb 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJRF8M03"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9891EA7E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384414; cv=none; b=cztu+fU4bpm587KkO5ew6M+uZ0cth0a4+rBVqopSE4CF5xtNMCYpFE6qA7rf87kDlJu7sXxIIMH04GVNCSpPkKfipKuuCkZ8WwlzuQOkeIcSi6L9HBE1rmD0IenZM1jTZJtUwavYdiUzYJUeQTcl9MjCjlfnVl9qIaT8bFG7kUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384414; c=relaxed/simple;
	bh=rX0kr9FoxMFMj5Li+t2NvDWyaIZeQGbAJTkHmyg8qjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EevY7dEYbyC1WQ/OBhKOpC/pc5BgZv1hHpTEM/UAQjyoBAf3QIpXSNtVXf52WA3LFBYRrePzeZiJn9UnYYEb0+E7Kirn7hYdLEuP3T7X7ttkSt6zXubqcFqiqslB4p2wgGzMEEUd9pZE/bE1T+EUrwcGhLEoefdYgPTi31a4PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJRF8M03; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212a930001so110865715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384411; x=1740989211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8q33JjqIID2gxUPanrFtnNDEQuq+2F7BIt1N3kOUDpQ=;
        b=BJRF8M03GsVSZ4MjbTBRmIVkLPw+RhoikPAaCEG/9E7eAvyMuS8bz9cxn/pUqwwGRq
         c4vuehZDfIKkFn7PdkLqvAo2uIwf/0GsmFbGqp2YzuSLWdp1GG6H35Oebc05llo4GmgX
         fEVtd8x27ehPJKZzuL1IXio3uCWrZdAwwc4Qd5uDMHfpyZwm6z4iR2WNXAAUQAGmXlSu
         C/oZLqN5sueRX5ju5zuP39Jwi+dGawEWt2yBzTu55kUo+gApt8IjQRly3iBA3diAWUY1
         QX/gL+GXAotip2XRMa7tmjJchXZ6vTeuiDeiHr0+HqzQ8qNDEFow0VPc9WzD4GFIaYeC
         CsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384411; x=1740989211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q33JjqIID2gxUPanrFtnNDEQuq+2F7BIt1N3kOUDpQ=;
        b=PoiNg/yOy8hfAQd9EEw95T4LcmyQCnOy2P7cwNhgcKG9m2DwpQiHZ9EfNAjjAlUkxI
         WW3DOSJm+VCJBnrARb7mXbvc4Efu/TDVf5ov23u7kt6/iJcQbMrUzshSzZiUCOM/ZvTB
         Pw6v9IR8yeH7a9tblo+Cz1AM6E5vsodK50g9dH8/NIWvmUs6Pt/EJrE3BHulp2OfvLEN
         T64KTaKBmNZNkP46ZFWtvqdtb8gycUU55HBgEFTr8cie9Na7o6XRIkg9G6bhck8hZLIM
         R4CsEja0ScoBbxXcRSZfsc8fp1B6vPAn88MZ+B8trpbS3nuy6CQcEMHLzt2b1sK/M4mo
         coGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXR0fA2AI1KrwW+6hr+Yi27NQ/aRtf2Qe6nbCE25nuWraXm10Et9YxwRduFP7jlUnno3jTGra7Gr+P0LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58RHOxGW02WbNlwFSopRBF693TQHriMwBKa2QRvYvKuuyPsNT
	DusWgRIDlnJZUKyFgQMYvdvhFXuW+GKWXq/X87CGCpsrfhiNMW7hgJQkTK/oXA==
X-Gm-Gg: ASbGncsgn4dFT/85NQvXvHoqPUP0nDYbiot4gV5PkeS/InKD9GmVoHH45r8E9nPQRy/
	Vf+WcENhJE9nW18lVorcTLoIQ3SkhT1/fEqoH48jjWgsbbZhlStPxhBXS8/qzzPG75sDMR/pRT7
	elFN54RJ7ZCBWadQ9QWGf+9blTtCCoYMdKRoDE5DsDLU/F2vYXlfQ4Ang7fe9u37GLVnq3ReHHO
	3DVbceLH2EmrzrdKmT3qg9SdDlO4lcKhNNRUEi4mKg/CVTydFyDjIH42HK0MXAXhUu1YJ5HqdqR
	ink08URLjiLL//dT1/I8X5VvMx/D0i5Mxy6q
X-Google-Smtp-Source: AGHT+IET6pCBDcr0viuI6ieEFwCQCFyPovYrU/eJqP+MyvqJc2aeSgcyD79kTf8ygnfu6RR2t6/OwA==
X-Received: by 2002:a17:902:e88d:b0:21d:dfae:300b with SMTP id d9443c01a7336-221a0ec46ffmr204596825ad.10.1740384410819;
        Mon, 24 Feb 2025 00:06:50 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596115sm175105635ad.258.2025.02.24.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:06:50 -0800 (PST)
Date: Mon, 24 Feb 2025 13:36:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250224080644.ldgltonirrtfzrgp@thinkpad>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
 <20250224074143.767442-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224074143.767442-3-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 01:11:43PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. INTx interrupt support is not available.
> 
> Currently in this commit platform specific Bridge errors support is not
> added.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below which is not related to *this* patch, but should be fixed
separately (ideally before this patch).

> ---
> Changes in v2:
> - Update commit message.
> Changes in v3:
> - Address review comments.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 40 +++++++++++++++++-------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..a0815c5010d9 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -84,6 +84,7 @@ enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
>  	CPM5_HOST1,
> +	CPM5NC_HOST,
>  };
>  
>  /**
> @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
>  
> +	if (variant->version != CPM5NC_HOST)
> +		return;
> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -578,16 +582,18 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  
>  	port->dev = dev;
>  
> -	err = xilinx_cpm_pcie_init_irq_domain(port);
> -	if (err)
> -		return err;
> +	port->variant = of_device_get_match_data(dev);
> +
> +	if (port->variant->version != CPM5NC_HOST) {
> +		err = xilinx_cpm_pcie_init_irq_domain(port);
> +		if (err)
> +			return err;
> +	}
>  
>  	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>  	if (!bus)
>  		return -ENODEV;

Here, xilinx_cpm_free_irq_domains() should be called in the error path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

