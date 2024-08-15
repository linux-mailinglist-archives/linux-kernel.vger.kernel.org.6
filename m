Return-Path: <linux-kernel+bounces-288270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A995382E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009621F24566
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE91B4C31;
	Thu, 15 Aug 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXUsAW6o"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DE1B012B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739107; cv=none; b=SJNn/upsE+zmrQYwtAigWJlNuc9ChboNJ/EhMXk/9hMV3fyaMgGlRcZuEKUDaiGaYH+kxTMBZH1YEu/rcjixuH1VKRKtwelPkObxCFoSIDGLXCepzS5fzMyNhPegrWxu2rzMRnFr2tkR8E6BVLGy5Etqq6sZUgevEuAEOpQxFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739107; c=relaxed/simple;
	bh=NoNuEvn7tp8Jic3j78xm1TiJXcYt5TFN3+CibXhlwvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7jyUsvQKEoHiSCmpjAt2bwArlIgQb2Q1MXuVnpSjeLDWg82Kgy5pjJo3rrZ8qqO21qbys0TGwGyWumzz7OTtXoNDSHgfdInsQWx5zu7BkMjmY7Q6TvswzQMk5sl1FcDx4jbm6xkUy+1HxtLyhVwKHd3XeNCD4CgqEKyV6K6y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXUsAW6o; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso803237a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723739106; x=1724343906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkUGIQbwRXV6Lq2jowcyGfccaaCLPz7bWJxbdPn9n30=;
        b=OXUsAW6oISN0a//3b2BnhG1lXxQFPs8FE5ap77EdCEFQVzg5ZwUI1iM4918+CO6tXa
         tQzUsj1Us5HkXHpItX6mF9qR9wJ1bkNuNloN/yCkJJXOTXf/ZVJextekGuc9y6s0CwjN
         AUe35Fu0/RcvqjE8bsOP47a1y0iuUYby7YsJAlawlIMERrDIkrkzQlDUvWiBiZYBmY0W
         3JKohUj2OR0RTlhYy6otHME2j+a4At3MVTIIOVfMsv/tl5cZRl/TE8OFYLplCXJOnphx
         92HCQ8QYoohXTSkOrxZWmBjG22h2VcQ8/fPsFyrruhxM6g58m8WM2xESnWAbDRR8rSnH
         zv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739106; x=1724343906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkUGIQbwRXV6Lq2jowcyGfccaaCLPz7bWJxbdPn9n30=;
        b=nb8IbG2+RdTYEiumEMn1KPpSKxsCjFFCNcVCWbn1Npcst+i/aitqWBgyynOioYaxVW
         NkcVtcBtJEs5eI+oNhIJHpDqtQilyZIBYKjb8Of21rmbFfBy7MIdQ44JdaKDIwYyBpWO
         b/a1AqQfIm7mg7OjTMIPbjT02AlyrTrHZrhyR2gjyJXQ5uzl4nu4xlpbtv6PpNj+LbCA
         02wyILxdjVPmD9dLu2JDV/oohWxqh8P+FUWk2E0dKnnJLrPwiHYSrf4ypMmWem9zIK/N
         MkoUA7y7YUNDF+90sgK879jTIDfar5i/Fcz5NA7AWMDLLEc63B5gLJBA2CP3UnmurODZ
         SJzw==
X-Forwarded-Encrypted: i=1; AJvYcCV5+sBfJx2U5ysZt0oKvtVYVY+MeIeh2QZI/WcmmPFU4jL6otTCvEdBY4IFqiYvdQIwyehVE0exZIJ62QeMRxNEEoIGPnBmSaiHFVwz
X-Gm-Message-State: AOJu0YzLS/XKuBtM1BgvSX+E+8vPSElVMDbQYaYNrZqp85oV7Z4fkAy3
	doWWHqzIEB5k+oXNgJcGDzYcNEjllD1k+cXAeMMceYhW3kFp9/G1R9zriYKjxg==
X-Google-Smtp-Source: AGHT+IEf9BWPqw66jhhiHQthvPGpBzvSfL+a+8WG13ziSXvFf+QiYJM8a8qmItiT1VexAhIkaMs9OQ==
X-Received: by 2002:a17:90b:ec1:b0:2bd:7e38:798e with SMTP id 98e67ed59e1d1-2d3dfff5d77mr163380a91.28.1723739105668;
        Thu, 15 Aug 2024 09:25:05 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca30bsm3787522a91.7.2024.08.15.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:25:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:54:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: rockchip: Refactor
 rockchip_pcie_disable_clocks function signature
Message-ID: <20240815162459.GG2562@thinkpad>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
 <20240625104039.48311-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625104039.48311-3-linux.amoon@gmail.com>

On Tue, Jun 25, 2024 at 04:10:34PM +0530, Anand Moon wrote:
> Updated rockchip_pcie_disable_clocks function to accept
> a struct rockchip pointer instead of a void pointer.
> 

Please use imperative tone in all patch descriptions.

s/Updated/Update

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

With above,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v4: None
> v3: None
> v2: None
> ---
>  drivers/pci/controller/pcie-rockchip.c | 4 +---
>  drivers/pci/controller/pcie-rockchip.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 024308bb6ac8..81deb7fc6882 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -272,10 +272,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>  
> -void rockchip_pcie_disable_clocks(void *data)
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
>  {
> -	struct rockchip_pcie *rockchip = data;
> -
>  	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 27e951b41b80..3330b1e55dcd 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -354,7 +354,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
> -void rockchip_pcie_disable_clocks(void *data);
> +void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_cfg_configuration_accesses(
>  		struct rockchip_pcie *rockchip, u32 type);
>  
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

