Return-Path: <linux-kernel+bounces-575910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53457A708CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21669188B436
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AA264A61;
	Tue, 25 Mar 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7NVhPDu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019525E81E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926165; cv=none; b=kRbrJzial/QvwURk6EqvGNjoLDfNCCvf7n9WCtxyZBXivqW6j4iUzC3TlkchAtzR28METj7kfIVHxEgbm5UklK4H9AguRfwvKiKs92ZUXncIamZBM/9FsXiAjyr0hWwbADAYYyc4wWTeaqfUQo1kO2xsF7uEC1PCvYlRPDau/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926165; c=relaxed/simple;
	bh=kwrD0kk73w4WKSwM/MIyzGd8Rlp1W5PDLpfyMta66ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DByKqbubAoj+SwHV++FM398SxrTczweWDKFemmg6d183+UPLMCoGLI+b/Lhypwcf5blI401UhJuBNFLM4RSbkmeDlrIpCwekf/PUHgaNuvzldskv63OPcerOc2soIdUYJFgdO/rd6VcI+M3WNkkdC90BakQTGf93QZBYzABNMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7NVhPDu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso122571065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742926163; x=1743530963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkFwRrf70rNA8OmaYxw9PFrRp7+gsmsE+hCsvNFF5YM=;
        b=Z7NVhPDuB+Y3DuWrbTOvbanmmzpJtXBDYwhLHrn5CoJTurebba7PYZhajOiHeI7F+c
         0gu1OzwsM2y5iHIKxd6OxGh3fDnRw6ko6gbZOuKY1mPrP/fovJ3rrkyq60K63t/jETB/
         ZKdXDGNINBvqhKEaBoNzLPX2e62F3mZZI/jV03dXBTW0+GCgdM6U36tof0kEm/kGwQun
         oI5rL8ePicWlbgufQnhIx2ou3g6Hb99hcGmb/GLqo3aaj3KWnC1FxGJAJtTs0AKqODQw
         bkayENc1FYgogirMyQ+739ShUFWUe3GWa5ju38v/7nTwLE4q/UJD+mxn6EDY2fyGtCVg
         GRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926163; x=1743530963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkFwRrf70rNA8OmaYxw9PFrRp7+gsmsE+hCsvNFF5YM=;
        b=RRXvWXkgJWxOXW4QYPeTuugbOyoovHQTG2H/hz8KCGIPVxttsLhGu0cIXOjxi+4WcH
         tyt3AiJ2RCCUOHOwZxmck2ba1/oxIsQV481IVn6rTKOlGRoq4naeAhXurgHDnDz9gfB1
         QYpY20i5ePZC1a30SS1KRmF08Y9bGjCsdpcEZQ+ukOuhjybZ1lSwpPhNh1q4TOXo/EYC
         u4S8TTsXpBOx7EyrTIqD0KGXj+PzspnmoZ4laA5sdS/PmX27NQbXpb2hzxK8jRdZE2T5
         wKVxWOLZrTynG1Bf5SiGLRk/19Hkvpwu3VmP99f6hQu80oQTxD1GscG/gJ3/vKReBLO3
         CktA==
X-Forwarded-Encrypted: i=1; AJvYcCWa74b2lvy+uc0oaDZeiG4hueQNrYbG1Y0SQVQx37/cTY+t9Ow94N2je+U2r/BvZxg+lkMR9mfTZJ2bi44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkmd3Z+0iuvajZz0RVkzjKlMSRzCjxrctF8hRy25VpzVW5+F1
	wA59xd3AeXsavW3eyR5FGObnFhcLh4IxgiLz2nHDunE428TXdzZMyZzt/W/Ogw==
X-Gm-Gg: ASbGnctL0AywB8+Ir9CfaSnOPnPKx8lcRXS6o+zP3Yr+MVEn1rKK3+qdMbCg9pBEka8
	DV/0DqQVkWWF1gjWQQyBMCCCQjbwxYnKEJxw+JHFYJ0kA7J/hol266lf3chSRaMJZTHCBziifjd
	BBKoGTNEN/x6rCaEJmOveuYrs8+l4DVZhHHzorn6JGBh6Z6vK3kWlEYlf6wYKBwWrcMboTeZ5O0
	2VI9FQ4viHCjChdVLYcKk1QSMjOo41bqgYc9ZP43WCiAR/DjussRfFjAzeJEMwDni5g5TVvnCle
	Ya+bf6r0kKRz/XiGOGl4TUHWH+vzRaP5sRtt+f2nbrr3VE7T/nh5MIc0amhy5KGjlbI=
X-Google-Smtp-Source: AGHT+IHsQEtK5eDuRWsdEQBYf6f44q2yB07kDLfDBWhVOxMWTo+zOzGbIhIFFRGiGOEd2PP4iDFCkA==
X-Received: by 2002:a17:902:f693:b0:226:3781:379d with SMTP id d9443c01a7336-22780e1044fmr239586185ad.33.1742926163021;
        Tue, 25 Mar 2025 11:09:23 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3962esm93992265ad.4.2025.03.25.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:09:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 23:39:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <3rtte7uyv7gilxnstcxjizpkdlfk5rfxwyc3bd4ednjakn5rfc@fhidkj5vvmtf>
References: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
 <20250324200437.GA1257874@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324200437.GA1257874@bhelgaas>

On Mon, Mar 24, 2025 at 03:04:37PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 24, 2025 at 11:00:24PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > > is a hard-coded way to get the parent bus address corresponding to a CPU
> > > physical address.
> > > 
> > > Add debug code to compare the address from .cpu_addr_fixup() with the
> > > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > > redundant and should be removed; if they differ, warn that something is
> > > wrong with the devicetree.
> > > 
> > > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > > identical to the CPU physical address because we previously ignored the
> > > parent bus address from devicetree.  If the devicetree has a different
> > > parent bus address, warn about it being broken.
> > > 
> > > [bhelgaas: split debug to separate patch for easier future revert, commit
> > > log]
> > > Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
> > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 0a35e36da703..985264c88b92 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > >  	struct device *dev = pci->dev;
> > >  	struct device_node *np = dev->of_node;
> > >  	int index;
> > > -	u64 reg_addr;
> > > +	u64 reg_addr, fixup_addr;
> > > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> > >  
> > >  	/* Look up reg_name address on parent bus */
> > >  	index = of_property_match_string(np, "reg-names", reg_name);
> > > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > >  
> > >  	of_property_read_reg(np, index, &reg_addr, NULL);
> > >  
> > > +	fixup = pci->ops->cpu_addr_fixup;
> > > +	if (fixup) {
> > > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > > +		if (reg_addr == fixup_addr) {
> > > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> > > +				 cpu_phy_addr, reg_name, index,
> > > +				 fixup_addr, fixup);
> > > +		} else {
> > > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > > +				 cpu_phy_addr, reg_name,
> > > +				 index, fixup_addr);
> > > +			reg_addr = fixup_addr;
> > > +		}
> > > +	} else if (!pci->use_parent_dt_ranges) {
> > 
> > Is this check still valid? 'use_parent_dt_ranges' is only used here for
> > validation. Moreover, if the fixup is not available, we should be able to
> > safely return 'cpu_phy_addr - reg_addr' unconditionally.
> 
> Yes, that's true IF the devicetree has the correct 'ranges'
> translation.  This is to avoid breaking platforms with broken
> devicetrees.
> 

You mean the driver without cpu_addr_fixup() and devicetree with broken 'ranges'
property? So the existing platforms... Not a bad idea though.

> > > +		if (reg_addr != cpu_phy_addr) {
> > > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > > +				 cpu_phy_addr, reg_addr);
> > > +			return 0;
> > > +		}
> > > +	}
> > > +
> > > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > > +		 reg_name, cpu_phy_addr - reg_addr);
> > 
> > This info is useless on platforms having no translation between CPU and PCI
> > controller. The offset will always be 0.
> 
> You're right.  This was probably an overzealous message for any
> possible issues.
> 
> What would you think of the below as a replacement?  It should emit at
> most one message, and none for platforms where devicetree describes no
> translation and there never was a .cpu_addr_fixup().
> 
> It's still pretty aggressive logging, but I'm just concerned about
> being able to quickly debug and fix any regressions.  Ideally we can
> revert the whole thing eventually.
> 
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 27b464a405a4..4b442d1aa55b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	int index;
> -	u64 reg_addr;
> +	u64 reg_addr, fixup_addr;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
>  
>  	/* Look up reg_name address on parent bus */
>  	index = of_property_match_string(np, "reg-names", reg_name);
> @@ -1126,5 +1127,42 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>  
> +	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phys_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
> +				 reg_name, index, reg_addr, fixup_addr,
> +				 (unsigned long long) cpu_phys_addr, fixup);
> +		} else {
> +			dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
> +				 reg_name, index, reg_addr, fixup_addr,
> +				 (unsigned long long) cpu_phys_addr);
> +			reg_addr = fixup_addr;
> +		}
> +
> +		return cpu_phys_addr - reg_addr;
> +	}
> +
> +	if (pci->use_parent_dt_ranges) {
> +
> +		/*
> +		 * This platform once had a fixup, presumably because it
> +		 * translates between CPU and PCI controller addresses.
> +		 * Log a note if devicetree didn't describe a translation.
> +		 */
> +		if (reg_addr == cpu_phys_addr)
> +			dev_info(dev, "%s reg[%d] %#010llx == cpu %#010llx\n; no fixup was ever needed for this devicetree\n",
> +				 reg_name, index, reg_addr,
> +				 (unsigned long long) cpu_phys_addr);

So this check is to detect the usage of old DTs with new kernel without
cpu_addr_fixup()? If so:

(1) The log is not accurate
(2) The driver would be broken, so the log should be an error. This condition
should not be met (if we do not remove the fixup for some time). But I think
this check should be moved ahead of cpu_addr_fixup() so that the correct DTs
would be honored first and the fixup would be ignored for them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

