Return-Path: <linux-kernel+bounces-261037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2393B1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E992A1C21119
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259E1581F8;
	Wed, 24 Jul 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxzOCPBp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E313E020
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829192; cv=none; b=GZrZ0fp5gZ/cFLTx9PDoWm/KpZU/WytNABt8+Pf2cpQcEWLo11j3dvrEMmhOS3EH3NxqW5n9iMTKgRuXdaXFCFi5Vc7nESfqNXubF8Y/kJlb1600fqxfKzFj+0w7qJ7mncZQAEtPZVpZOsVpWLHBvtz3hH70MLo+l0EK8Pp2Nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829192; c=relaxed/simple;
	bh=K1Gm5FrXTgsaeMhym9PMm5RXH1m2mr4z+ndq5toTgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9aRArpfw2J3pdqj0LpF/jg+HPFZJV1jDqRClYAIMZzcWRK6I8fAU8/qXAeP1bHWSa0/+VAIHTqi1e/AlM3J/DrwnpC1EZ2OAOsQEUxCJ0NM3LUHuwELFUttkhnFOgbbHsgmLK+2yg/POX5P2acvR2cDV32Bf7EkRrAN79TuHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxzOCPBp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd69e44596so7263915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721829190; x=1722433990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SoDYcqz8sG/AIs+jpcWHgqP0knrGMe57oRo4EDfUESM=;
        b=XxzOCPBpG8Wgq/2R5cpX4MUYvnbw881wHIeGDt9rbt+HTNxOhp5qlMdOUS8iT7DTXK
         htPo//OnC6tfGQfTc5uxm/VBnKjPuqYMautfqI6WrlIURY2YCtfnCpju96wuP7+coqjj
         Z9nyWpL2qGeuBzYjGcbX42dMu68oiJQsraCpI2LmjPf+/3KrxOLak67HQs8jrEdwd63J
         uZ3eJuVkM3enOLKBwAwkz+QY9qDLrTIeuUYqzaVgrJvUL324vyxs4ckUCH0KvnfHXT9l
         fAxugJC3mPrdQ4yiCjV6KZ81cnITJ8gJ9rO9nmXrJLppw4H9/Og+5LwwsDNLvRoL+WPD
         2haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829190; x=1722433990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoDYcqz8sG/AIs+jpcWHgqP0knrGMe57oRo4EDfUESM=;
        b=HMUKkRsYjeQLMOvqRGAhIyCFpz1PKOmT4acccD28Z5YAjX/KPsCm1JCdup3Wnwa33N
         5deAXVz0wjVa3JEMa/vETgQJnI6RKNJEj0vOU5FZqliEXoQEcXZHHTcVmxFYiKDPQ8pA
         1Cy+2/WdnlLIhe3IGm73zRbQP7PXDoQwLRItPnJf4TwA2NQ8wK614ogSbzH5vQhR1q39
         29KnDY2piq/+AUfkUvi//bFT24ilFZnaIFreoF51AKCw1x0dElC1wUb8jGCDBNnICfqr
         pUF/QQoH9QtgCB/UffHANpYCYsa3wCIbJZ/lTHsd85MtvBYT7NQOoKhou2Q0cKxGvSWa
         +QUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ucNWFOyjuQNYmkpWFQAgrL14rcfEIxpKNgs6yJOIsta49waoqSbpkPC2IsfrVlKkv66aqKR5vCe00xS4qiv3hqvEoC5Kpst4GPNU
X-Gm-Message-State: AOJu0YzMJL44NiOFoJ3Yd3uc6m6psOWhC78+pd1iRJ/dnYGFAuuroIsG
	+J1aHVac5DM3btYX0XWylk1s46Y3j8W3SPxHJo3VGIvSLcrA+Pz0b9mOpkXzZhCktuRicd5Vj+U
	=
X-Google-Smtp-Source: AGHT+IEmx7G7fByPz1gtOcoNPb6KHFdsEYyRBjys2M9fZj/hXEBf+Bn4FE+Hw7+Xaaw5KQegbGX9Vg==
X-Received: by 2002:a17:903:230b:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-1fdd6e80b55mr35063315ad.26.1721829190540;
        Wed, 24 Jul 2024 06:53:10 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f290eedsm94532535ad.93.2024.07.24.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:53:10 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:23:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <20240724135305.GE3349@thinkpad>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>

On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:

Subject could be modified as below:

PCI: dwc: Cache DBI and iATU physical addresses in 'struct dw_pcie_ops'

> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> driver to program the location of DBI and ATU blocks in Qualcomm
> PCIe Controller specific PARF hardware block.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 1b5aba1f0c92..bc3a5d6b0177 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
>  		if (IS_ERR(pci->dbi_base))
>  			return PTR_ERR(pci->dbi_base);
> +		pci->dbi_phys_addr = res->start;
>  	}
>  
>  	/* DBI2 is mainly useful for the endpoint controller */
> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
>  			if (IS_ERR(pci->atu_base))
>  				return PTR_ERR(pci->atu_base);
> +			pci->atu_phys_addr = res->start;
>  		} else {
>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>  		}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 53c4c8f399c8..efc72989330c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> +	phys_addr_t		dbi_phys_addr;
>  	void __iomem		*dbi_base2;
>  	void __iomem		*atu_base;
> +	phys_addr_t		atu_phys_addr;
>  	size_t			atu_size;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

