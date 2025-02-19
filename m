Return-Path: <linux-kernel+bounces-521028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA68A3B2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3389D3ABA71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4761C4A20;
	Wed, 19 Feb 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHJBZIai"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA51C3F04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951742; cv=none; b=GKINF43eC4z6N4V2biz0R0hsIq/bzwlKo4gZAu+9cb5VyQkwvj439p8KkTa4ACLo0xC8DBXyBGjUk5Dfn5zPSEx+E8boj3QXoETMD5tdtcQCVSayHW0/8zuRBJl6pmYc8p0wD9sNN6Wjk5bFC25Cv+JLFcPhuKpEchUWGvK99uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951742; c=relaxed/simple;
	bh=ss6647Vq7Cy6U+GNIlcy6ezE7ATXTzSydGRry2X6VVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phito54FzWyLc1k0NMWwpwqSse6v7PgkcnN6ofGatzhQwTqMQ2S6+XRITCENSzBtu3MR0c9So5PKceQCAzOS/Yb5tIGW9h0wbNFVvRi8QoQF2VedhESl20V8yV1Hx9KX9XXfMbZDUh45aXOW2JlKXJzMP1Mv+i2H9tEV11jTw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHJBZIai; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c4159f87so84798425ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739951739; x=1740556539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQ8YbWKKN0JUEDEyejcT43K2AZBg1IVNzkk5e0M7RQ0=;
        b=fHJBZIaiB+bzCM0QcuUFSBATA7NHiXJ+fGEharNp8aR62bTJmJ/Tz37czbMa/HpchK
         5UVI3B2zuwdLMWOz2CmrdWgRG/WrPSC1sx+9uLlibXj7NEwa3utt9X9+d7qpfUWXoDo5
         KMlpJVPX8KFIeBL5BIvLtdPqlPiqGU1aMnv7VHIExx2ggdCGaTyJGLfRyPxzwPRsMstL
         CtE4w4qv7H9Np+7UHhB86MbHKgBTujhgecBVx1SSIbMCzqbvDnWqKGxR3IvYhOn/hNVB
         y+8NRreta6VijmITbN09iIFZkXafyqNUsfaoqKnhiY8ixx2U3/VQC+uoRrmH0Pk9fhgQ
         zHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951739; x=1740556539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ8YbWKKN0JUEDEyejcT43K2AZBg1IVNzkk5e0M7RQ0=;
        b=l4ABEcHfMpjMVI2FhBWjT33xCqLoPyHymZ9vrkvtIKE/pkMoz/3EH/hytCnctLfXC5
         UL1ELJsc6ejPFsiy9+KyPZVfbmuWddr+sAu4CTar3seb/mSWPjhUG5Ow8k+H+3wAkcM5
         gz00yiGNLsVdbW4WfyP7GoP+ZVa4sRr18OpO7E1vnTwLQ1xn0jE54IKCT0v0BW4/rOgi
         SZYG6VlZJLRIVlueBN+EhTriq0KjKNuJ3gOvvVZ2CQtePzp5FkX53TDmZOQMeNR8Ahnn
         oWBpC34hOmCChIfFq9sVYVjb4W8MuOHC/Q7Z7u238BAMMvf5gODUdDmqmNXeCcT9kIhx
         n58g==
X-Forwarded-Encrypted: i=1; AJvYcCWfYau/M38aCHmHe0QvA7SaC2EnLZSKnEokDPX0+H3ofstWWfzghbm70BCTmA8gMNR8Ni1px5NWzfpzdtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6WGbQIMrtS5IuyuNRdNVm1R+YcB173UZ9Xrc6VbWYlqvKRJK
	6VX6C/rrwa/qo6hH2MWMAJACPiEsjhhaLHEDovnjeHBwLL6np6UR42V3g4jj+Q==
X-Gm-Gg: ASbGncsEK9QupcllkmMD1Z13B4ah1KYvxYBzs+DvY6En2B9ucWqOfbj8V/X61wtYQLh
	Dv7nOQ4yBq2xXv9fA/rniedSRevyfXF+O+Wt5n7INNZc42KHpHV8kp4epJzL2zxbQmxUpsX3KmZ
	IKPvDzPRp0mFkV68E+q1rYKVWR+r64Df2dOimu4NLOWhQGW3vZC2Saf9fGNiInJ3PS5Tjr4GT21
	WfFFemL+9csQwo07wDDTKrN2r9RXzvj7GHwR8G6P8GlE9sJe9QXGyB8vowchkPc+2ZITlR4AZ3P
	ucNc8dvUrnq7KKkzNIHNSivOCas=
X-Google-Smtp-Source: AGHT+IG4njE0mVfhwsbo461mQskQTrTqKLJp04nKx1lPyB6/OYKMHkjA+8znL3Lf5HXh3/3N1AgKoQ==
X-Received: by 2002:a17:903:283:b0:215:ae3d:1dd7 with SMTP id d9443c01a7336-221040269bbmr278400085ad.19.1739951739441;
        Tue, 18 Feb 2025 23:55:39 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491ecsm99383825ad.9.2025.02.18.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:55:39 -0800 (PST)
Date: Wed, 19 Feb 2025 13:25:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to
 'pcie-dwc.h'
Message-ID: <20250219075533.dqj4rqeskilg76lj@thinkpad>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
 <4nnikepf7ay4ml3audn34gmq5jttjcfz3syfnxeowmjb4no2cj@lyawl4saa3sa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4nnikepf7ay4ml3audn34gmq5jttjcfz3syfnxeowmjb4no2cj@lyawl4saa3sa>

On Tue, Feb 18, 2025 at 06:31:02PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 18, 2025 at 08:06:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Since these are common to all Desginware PCIe IPs, move them to a new
> > header, 'pcie-dwc.h' so that other drivers could make use of them.
> 
> Which drivers are going to use it? Please provide an explanation.
> 

I can certainly add reference as 'upcoming pcie-designware-sysfs' driver.

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
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..05b37ea7cf16 100644
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
> >  static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> >  {
> > -	const struct dwc_pcie_pmu_vsec_id *vid;
> > +	const struct dwc_pcie_vsec_id *vid;
> >  	u16 vsec;
> >  	u32 val;
> >  
> > diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> > new file mode 100644
> > index 000000000000..261ae11d75a4
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
> > + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> > + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> > + */
> > +static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> 
> Having it in the header means that there are going to be several
> copies of this data. Is that expected?
> 

Yes. I wanted to consolidate these ids in a single file to make it easy to track
them. Otherwise, these are spread across different subsystems, making it harder
to maintain.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

