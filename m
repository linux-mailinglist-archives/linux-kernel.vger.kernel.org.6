Return-Path: <linux-kernel+bounces-521059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD3A3B36E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C5518922C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0911C5D72;
	Wed, 19 Feb 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXZKsptq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788421C54B3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952889; cv=none; b=IX/SH180r/3DTPc3oEfUocAQkT0+dr6rNRoFzbtMraRMqFzgIERtjwRg92mvdZSD4JBniHSDtZsGycmpDq0dgll+BBLQCbhH/HO41OebbBFWct0VqWbzFOGVxCeK6tb52hg2cAwV6E2OmCqEr5YlvHPLnAO9yQFr9qlA6CBZLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952889; c=relaxed/simple;
	bh=aOW+Yf0535bZ0SI0BsWWcmOtsx/1+kasCAcIMhgpuLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJIYxg/+4yCE2EoZD6htQLuQbdrp6g2JOD2mwqzvqFZX1oDgCzGJVF85dYY9YWV7pyNVhOnRpGJp7FO/JQlAJPbRn0VGKpGEofHM6A2EqOPw5SF0SOLr5IFk3iLWCgf1iKdGN+Je4DEk3r4olfdPBswpD3BRnCJ5V6MEpPywuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXZKsptq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so117679395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739952883; x=1740557683; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MsT69ZOLMdFZIvD1YxUdjLqp4nB+JO3UK8B0xhjxIJ4=;
        b=yXZKsptqDyWGo4CC4vHOOH2FUo+i31JbNYKU9WH3lOvs5UUQUG2bYyLk8gSvDUEAzV
         WPSmslSmy/BWEoMftjV62Js4hHJhftjW3+QO04XOVTKX4DP6ByUe7q2qnIu9FXDN46tR
         2dEMj1sWLgqLalbNvZ1aDSOv3Ta7B+imPbkzuFUkvBiaXRzDmZ0FqPchr8g5Vwkz9qgV
         2uCP8ZtQjVg1K4N8PqesACMUHA81NwXg+SgwvVFTup94lBl42MYGPvGLljisiHLlP3Ct
         GKTBBCmnntBF/xwe+VpYypAHbAFI0fcWJO7sQHPGb+lw2nHEj7xkipaCHzbxQb5TvQpf
         4P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739952883; x=1740557683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsT69ZOLMdFZIvD1YxUdjLqp4nB+JO3UK8B0xhjxIJ4=;
        b=kwwLsCNkQJAt3WgH/LN9Q4zFJr/qRIkiQPe3xWsVhLs1VoNXWyV7ny0hHOLJTdWKhh
         Ys8CXRJ+fsVmB7VSZ9rf96b/hdRdtTsM7q/dF2SNgCVn1cLg/cHYsXwwddr60BWeVWtp
         YTy7r0VyGXhBIf88xxjrgpULZf2+isqHp01TGbSz+2GSbmT5Lp/hPfAU0Lg+Gh0pqRir
         LTgBWxWeZsICdBgozBiL0Q8+SwxTch0tk1R6LX/vsVYz6T1mMHB/Sd8vjTN6X7Ui1BdJ
         gwGCbsWVZrQnOzDrqFq3JZgjN6C5BYejFelIomo1tWvLBqc/IC7/5Z7cnfFs8RFt8V2A
         EFdg==
X-Forwarded-Encrypted: i=1; AJvYcCVN5T3ybvd4DEutPqJNCdaw4hHQaxNsX41++LrRiMxX+x0S6DRzv81QjdAaYZh0aHIV3BjkGplMpMiS/uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaYb32h9lf96C67EEc3wGrnDoZh+YzMGKfJhNyv1njrFKKH11
	g+CaCf3CI79TWx9MMAhPpqLIdyZfJY7sRFGCC51tt3vGPj+tfJbD9ZaWpJOM3A==
X-Gm-Gg: ASbGnctPy9ZxWUHAElgXEA5pjM+MTndu3rBfrQPIQPkiCFxzQbKytNaHPGFChKzIZn4
	uEK8q135INPTMCu/ZoMwboGipvodFLa8xBK8WUfYJAHJvEZprg0g7aYFPwsz3bZvkG//f2+d4zL
	ovLLi2V8oMd900x1dJt9XYWsSmMdtgger8o2oz6TKy+Ob264q0hCVazgmmVUiHqXzld8qgOMbC4
	UGYVmbak59+La1dBuPqGWCHJ0tZTMPFUdKvSqIe6zhjqYpKdnUdzIqY06oPaQVXUtQJA/5JwpRa
	nM+B/EHeobm6hWcYA4awaA1TzJo=
X-Google-Smtp-Source: AGHT+IENOnfR6SSjOBhgQxo3L/XeWd+wkkORnG1gESsnoAjwgiA1eIzRjF76GYaTtPte8EUQzIdbFg==
X-Received: by 2002:a17:903:1a2d:b0:220:c813:dfd1 with SMTP id d9443c01a7336-221040bd77bmr283520705ad.36.1739952882676;
        Wed, 19 Feb 2025 00:14:42 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22178514287sm4640175ad.175.2025.02.19.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:14:42 -0800 (PST)
Date: Wed, 19 Feb 2025 13:44:36 +0530
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
Subject: Re: [PATCH 3/4] PCI: dwc: Add sysfs support for PTM
Message-ID: <20250219081436.ivllsfctvjgtyu25@thinkpad>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <20250218-pcie-qcom-ptm-v1-3-16d7e480d73e@linaro.org>
 <qvkpasuxn54dpsvsq6vinuyjvnphvnvfcedqzvmhkpgbrgurvm@7e55l7rkkqo4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qvkpasuxn54dpsvsq6vinuyjvnphvnvfcedqzvmhkpgbrgurvm@7e55l7rkkqo4>

On Tue, Feb 18, 2025 at 07:54:24PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 18, 2025 at 08:06:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
> > sec 6.22 allows precise coordination of timing information across multiple
> > components in a PCIe hierarchy with independent local time clocks.
> > 
> > While the PTM support itself is indicated by the presence of PTM Extended
> > Capability structure, Synopsys Designware IPs expose the PTM context
> > (timing information) through Vendor Specific Extended Capability (VSEC)
> > registers.
> > 
> > Hence, add the sysfs support to expose the PTM context information to
> > userspace from both PCIe RC and EP controllers. Below PTM context are
> > exposed through sysfs:
> > 
> > PCIe RC
> > =======
> > 
> > 1. PTM Local clock
> > 2. PTM T2 timestamp
> > 3. PTM T3 timestamp
> > 4. PTM Context valid
> > 
> > PCIe EP
> > =======
> > 
> > 1. PTM Local clock
> > 2. PTM T1 timestamp
> > 3. PTM T4 timestamp
> > 4. PTM Master clock
> > 5. PTM Context update
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dwc-pcie  |  70 ++++++
> >  MAINTAINERS                                        |   1 +
> >  drivers/pci/controller/dwc/Makefile                |   2 +-
> >  drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
> >  drivers/pci/controller/dwc/pcie-designware-host.c  |   4 +
> >  drivers/pci/controller/dwc/pcie-designware-sysfs.c | 278 +++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.c       |   6 +
> >  drivers/pci/controller/dwc/pcie-designware.h       |  22 ++
> >  include/linux/pcie-dwc.h                           |   8 +
> >  9 files changed, 393 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dwc-pcie b/Documentation/ABI/testing/sysfs-platform-dwc-pcie
> > new file mode 100644
> > index 000000000000..6b429108cd09
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-dwc-pcie
> 
> Should be a class or just a ptm group in the PCIe controller device? How
> generic are those attributes?
> 

Even though these are generic attributes, the way PTM support is exposed in
kernel right now makes it harder to make these as generic attributes. These
attributes are specific to RC/EP controllers and the generic PTM driver is for
endpoint devices. Maybe I could think of exposing it for RC/EP controller
drivers (not just DWC). But still then these would be exposed as a group under
each platform device.

> > @@ -0,0 +1,70 @@
> > +What:		/sys/devices/platform/*/dwc/ptm/ptm_local_clock
> > +Date:		February 2025
> > +Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +Description:
> > +		(RO) PTM local clock in nanoseconds. Applicable for both Root
> > +		Complex and Endpoint mode.

[...]

> > +static umode_t ptm_attr_visible(struct kobject *kobj, struct attribute *attr,
> > +				int n)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct dw_pcie *pci = dev_get_drvdata(dev);
> > +
> > +	/* RC only needs local, t2 and t3 clocks and context_valid */
> > +	if ((attr == &dev_attr_ptm_t1.attr && pci->mode == DW_PCIE_RC_TYPE) ||
> > +	    (attr == &dev_attr_ptm_t4.attr && pci->mode == DW_PCIE_RC_TYPE) ||
> > +	    (attr == &dev_attr_ptm_master_clock.attr && pci->mode == DW_PCIE_RC_TYPE) ||
> > +	    (attr == &dev_attr_ptm_context_update.attr && pci->mode == DW_PCIE_RC_TYPE))
> > +		return 0;
> 
> The pci->mode checks definitely can be refactored to a top-level instead
> of being repeated on each line.
> 

Ok.

> > +
> > +	/* EP only needs local, master, t1, and t4 clocks and context_update */
> > +	if ((attr == &dev_attr_ptm_t2.attr && pci->mode == DW_PCIE_EP_TYPE) ||
> > +	    (attr == &dev_attr_ptm_t3.attr && pci->mode == DW_PCIE_EP_TYPE) ||
> > +	    (attr == &dev_attr_ptm_context_valid.attr && pci->mode == DW_PCIE_EP_TYPE))
> > +		return 0;
> > +
> > +	return attr->mode;
> 
> I think it might be better to register two separate groups, one for RC,
> one for EP and use presense of the corresponding capability in the
> .is_visible callback to check if the PTM attributes should be visible at
> all.
> 

What benefit does it provide? I did thought about this idea, but then I didn't
find useful since the top level platform device (RC/EP) should itself
distinguish between PTM requester and responder. So one more differentiation
seemed overkill to me.

> > +}
> > +
> > +static const struct attribute_group ptm_attr_group = {
> > +	.name = "ptm",
> > +	.attrs = ptm_attrs,
> > +	.is_visible = ptm_attr_visible,
> > +};
> > +
> > +static const struct attribute_group *dwc_pcie_attr_groups[] = {
> > +	&ptm_attr_group,
> > +	NULL,
> > +};
> > +
> > +static void pcie_designware_sysfs_release(struct device *dev)
> > +{
> > +	kfree(dev);
> > +}
> > +
> > +void pcie_designware_sysfs_init(struct dw_pcie *pci,
> > +				    enum dw_pcie_device_mode mode)
> > +{
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	/* Check for capabilities before creating sysfs attrbutes */
> > +	ret = dw_pcie_find_ptm_capability(pci);
> > +	if (!ret) {
> > +		dev_dbg(pci->dev, "PTM capability not present\n");
> > +		return;
> > +	}
> > +
> > +	pci->ptm_vsec_offset = ret;
> > +	pci->mode = mode;
> > +
> > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return;
> > +
> > +	device_initialize(dev);
> > +	dev->groups = dwc_pcie_attr_groups;
> > +	dev->release = pcie_designware_sysfs_release;
> > +	dev->parent = pci->dev;
> > +	dev_set_drvdata(dev, pci);
> > +
> > +	ret = dev_set_name(dev, "dwc");
> > +	if (ret)
> > +		goto err_free;
> > +
> > +	ret = device_add(dev);
> > +	if (ret)
> > +		goto err_free;
> > +
> > +	pci->sysfs_dev = dev;
> 
> Why do you need to add a new device under the PCIe controller?
> 

Just because we cannot reference the 'struct dw_pcie' from the 'struct device'
belonging to the platform device. All the controller drivers are already setting
their own private structure as drvdata.

> > +
> > +	return;
> > +
> > +err_free:
> > +	put_device(dev);
> > +}
> > +
> > +void pcie_designware_sysfs_exit(struct dw_pcie *pci)
> > +{
> > +	if (pci->sysfs_dev)
> > +		device_unregister(pci->sysfs_dev);
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index a7c0671c6715..30825ec0648e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -323,6 +323,12 @@ static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
> >  	return 0;
> >  }
> >  
> > +u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci)
> > +{
> > +	return dw_pcie_find_vsec_capability(pci, dwc_pcie_ptm_vsec_ids);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_find_ptm_capability);
> 
> This API should go into the previous patch. Otherwise it will result in
> unused function warnings.
> 

Yes, but that should be fine. Unused warnings are generally acceptable if the
function is defined in subsequent patch. Only rule is that the build should not
be broken when using defconfig.

Moreover, the previous patch just adds the VSEC helpers and I inherited them
from Shradha's patch. Clubbing PTM API would make it look like two separate
changes in a single patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

