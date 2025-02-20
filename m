Return-Path: <linux-kernel+bounces-523119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4EA3D238
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE49B188E158
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB801E7C28;
	Thu, 20 Feb 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO0IGoc+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE91E5B83
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036476; cv=none; b=MCMj1RqyLcx6TeD4ZsW8PKcsW8vQ56YHjguEALwxqQpHr1KC8WRfg6F77HvAyAMGcZJbD2lHNH5vDBiAVrs49gnmYRm6kfwMTJAAvRFi790O382rCgdx6YVwceaMlX3InxcLX5Jva/DCOpO8Xot4oePvozjZl4yNdGiFDto7nG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036476; c=relaxed/simple;
	bh=p3TD4N5ncUSlR7g2MNebA4UOXXszC8KvLXpzVDZ+CJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN4MXL0nEIwSAh1jwzhYfiDwa6PVz2TIz/ZUOZSQEUxbyUkUNcC4wK/f4flmVm93kkqn5SVR1Cjbl1CvEmhXIbIolMm6Ugddw3jIQuP/0XVRNaStQGQMAvMEz9DGUMo1BembhF6q+vdAPz3/belIPpDTspkxoenGG7KGxcxNL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PO0IGoc+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220f048c038so10206695ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740036472; x=1740641272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0YiPjJjyP/SfskdcyKsiE+Tu2gFKc0Gw/xXDAcrX5o4=;
        b=PO0IGoc+eNnetJrPKHq+GZnngvfpWyQ3F6Ct2aD3YCNjVAIKOGShRuuvdbFU3nmfvM
         v7QcEUsMYP0VgIML15pW2FPAI1IaeoDOTdeyqLEouV6Vt/fFGwvMZNdYMi91rXC+PWbR
         8A96k76sJCt8dqjLhF+XcGQmcg5E72/ACYPcZf4xLz/vYYfWCkn1lAKUNgFNaqhBku4Q
         J67X22SR+p1Q0Huq+UBtjxTQyjbEDSEl8Z97gms+Zn/3a6sfaW0w5xAm/gsa2M7nmLw9
         tmhDz+r1CN73R0zldP2Ayp6kMMBBNBsuKCwBjI/aTegEvhYqbBpYLDnNkyT2wWH9Nix8
         ErtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036472; x=1740641272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YiPjJjyP/SfskdcyKsiE+Tu2gFKc0Gw/xXDAcrX5o4=;
        b=vfeEWwva2lLdqieaJi2r60qMXbC+TVYDIDKXCtlDisDT4T0AI2r+WQkbfh3uq8ZoJZ
         dK6Yw+JLBY1T1jiXgsTEXrO7CqobjWA5yrpIpoGyCRuP1/c1amQ4eyPTdd+h0Jv0L459
         2Eas+X/COJmL4JxUbXMh+rYriSCmJ4wEu7wzo41PkMztTs5Xy1X0Z/w5Al4EAjbEKXG2
         lYG4e5GsGr9PgAiZgmvfrVP7RabpUngnxv6QPxjSdCNLGRiczE1cFEAhwvizGdqlSvF+
         4LdpD2s1OVqeC1PxsjBrEX3gcFyv1nL3uImkXgNPCnrJLDRlmeNbf3zzOYixgb4NUdVQ
         zuqg==
X-Forwarded-Encrypted: i=1; AJvYcCUglKWALDSWTZQNKNC2qUm5zRN2enVc3Sb6YZxiJa0tzmeh/p6E98ORJqvVRpSKE9HyOBAFOWnWUDGZW1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRIWumkPVKM8uoqw2QW0yfu7tjAETdlY+9pkeXU7cjlta7eN0
	ej3gCh3onqquq8FkGWzFmSyBMuFB1lg39dWHNucOZScZKteyM3gT6FxdA0hudh1S3klqLELt5sY
	=
X-Gm-Gg: ASbGncsUm3gyEsfWtSIhf1GP5GCLZ1uXJZrxDpVcJEG19tk9uFhMgjuPNW3zXAzdcQV
	y/whmizAHzLWOVyAErcR/To/3ajnhG+iWEXsHdCEnrPx6gjDcPndNJheulgneZsesyqXW+j7RIL
	8lOgjWk8T01ZW2lxfp4xOkq1k9eI/OdH1JA0k2vbFvhnK1MGxkNgNUxNDjMnxcEMeGiCqBpF8lz
	zt2SSh2O/QBF+H9VtOly9Ep8biGJK8nyDMR0M4caf40PwoZa+sAiMAY0pc0tX3zXrSL64zrgfGE
	Std2o8CMbpsZ5ymD4JGCHs0+mA==
X-Google-Smtp-Source: AGHT+IEbtwoZL/ZxWNIg3lz+aSPbQjpyQnSpBy7VKI7Jg+TnXQypLzMP3r745tdSDFVEJjlsB7KSqg==
X-Received: by 2002:a17:903:1a0e:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-22104028854mr364462485ad.19.1740036472649;
        Wed, 19 Feb 2025 23:27:52 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366242sm115665795ad.87.2025.02.19.23.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:27:52 -0800 (PST)
Date: Thu, 20 Feb 2025 12:57:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Shuai Xue' <xueshuai@linux.alibaba.com>,
	'Jing Zhang' <renyu.zj@linux.alibaba.com>,
	'Will Deacon' <will@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>,
	'Jingoo Han' <jingoohan1@gmail.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Lorenzo Pieralisi' <lpieralisi@kernel.org>,
	'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>,
	'Rob Herring' <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to
 'pcie-dwc.h'
Message-ID: <20250220072747.azfluj6mrkqy5osq@thinkpad>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <CGME20250218143703epcas5p2c0b9a60d17e030f7d3ce37c00c9b56ca@epcas5p2.samsung.com>
 <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
 <02d901db835c$f0710450$d1530cf0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02d901db835c$f0710450$d1530cf0$@samsung.com>

On Thu, Feb 20, 2025 at 11:31:49AM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
> > Sent: 18 February 2025 20:07
> > To: Shuai Xue <xueshuai@linux.alibaba.com>; Jing Zhang <renyu.zj@linux.alibaba.com>; Will Deacon <will@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Jingoo Han <jingoohan1@gmail.com>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>; Krzysztof Wilczyński <kw@linux.com>; Rob Herring <robh@kernel.org>
> > Cc: Shradha Todi <shradha.t@samsung.com>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-perf-
> > users@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-msm@vger.kernel.org; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > Subject: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'
> > 
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Since these are common to all Desginware PCIe IPs, move them to a new header, 'pcie-dwc.h' so that other drivers could make use of
> > them.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS                 |  1 +
> >  drivers/perf/dwc_pcie_pmu.c | 23 ++---------------------
> >  include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 37 insertions(+), 21 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 896a307fa065..b4d09d52a750 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18123,6 +18123,7 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> >  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >  F:	drivers/pci/controller/dwc/*designware*
> > +F:	include/linux/pcie-dwc.h
> > 
> >  PCI DRIVER FOR TI DRA7XX/J721E
> >  M:	Vignesh Raghavendra <vigneshr@ti.com>
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c index cccecae9823f..05b37ea7cf16 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > +#include <linux/pcie-dwc.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > @@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
> >  	struct list_head dev_node;
> >  };
> > 
> > -struct dwc_pcie_pmu_vsec_id {
> > -	u16 vendor_id;
> > -	u16 vsec_id;
> > -	u8 vsec_rev;
> > -};
> > -
> > -/*
> > - * VSEC IDs are allocated by the vendor, so a given ID may mean different
> > - * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> > - */
> > -static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> > -	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{} /* terminator */
> > -};
> > -
> >  static ssize_t cpumask_show(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> > @@ -529,7 +510,7 @@ static void dwc_pcie_unregister_pmu(void *data)
> > 
> >  static u16 dwc_pcie_des_cap(struct pci_dev *pdev)  {
> > -	const struct dwc_pcie_pmu_vsec_id *vid;
> > +	const struct dwc_pcie_vsec_id *vid;
> >  	u16 vsec;
> >  	u32 val;
> > 
> > diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h new file mode 100644 index 000000000000..261ae11d75a4
> > --- /dev/null
> > +++ b/include/linux/pcie-dwc.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021-2023 Alibaba Inc.
> > + *
> > + * Copyright 2025 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +#ifndef LINUX_PCIE_DWC_H
> > +#define LINUX_PCIE_DWC_H
> > +
> > +#include <linux/pci_ids.h>
> > +
> > +struct dwc_pcie_vsec_id {
> > +	u16 vendor_id;
> > +	u16 vsec_id;
> > +	u8 vsec_rev;
> > +};
> > +
> > +/*
> > + * VSEC IDs are allocated by the vendor, so a given ID may mean
> > +different
> > + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> > + */
> > +static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> 
> Rename this to dwc_pcie_rasdes_vsec_ids? pmu was perf file specific but technically the vsec is rasdes.
> 

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

