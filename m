Return-Path: <linux-kernel+bounces-393381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616FB9B9FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F10B20D6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36419597F;
	Sat,  2 Nov 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUS8DIzs"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731118BBA8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548486; cv=none; b=V6neQEGwJASY5qMREGStbSp9Pct0zdJQK/hNTsNybkUrrqBMdyj5IW8EFF1t7HPY/JZ2RjZiPkAXHPw48URchQZLx0qxA4x41akDdCEDJS3xQQspgPU188Exa0+hbAWtjZV7+3yeEGk6/WG22teXE7eCsGVUKUxxMcI/sPkzVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548486; c=relaxed/simple;
	bh=uenxxXG7WDG5CmlqwyqtlRiBDcCxllosDV07ROVKTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4iqzzCjyb06cPvAy41lT2qr3V5aoqXEiIhetW8h7PX3g6Yuc/84/chknHQwJJxkY+OGUmv+iOF0Cr9RNWDoj17f/a+v3KJFKK7jOj/c+g40YVdxnK6PIu/GtmFt5gt744y6rxkZRBsah6Qlzc5JbActyL4DEc6X+JyND9uz6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUS8DIzs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e983487a1so2393018b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730548483; x=1731153283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf5PO0O/8GxH6YaffdPErJ0yX0DmIFh2NMk1EvLbRA8=;
        b=IUS8DIzshwXzRJ+SILtR52xEwHD331mF8+Mqa0MuTJS6Uy1xdmdyd5w95N29cYSCt7
         QitljdWOA+mMdbt1YvZ0isZhJ0PzGaXiCxoy9J1RYBm3QAdRTBadUS5GqhLBl0Mt2b5r
         xxQzKMNzr6Q4YdxG/d52DsDxH0vzqjlGWonFjF/Hzy+FDad012NJiC5hXgaB6NK9iM13
         W89kjJXFHq1YButE2kso7ulkrC6SXZIkAsvvUE7hNetCd4NHECq80Gk/uFEJK3MiUYIv
         Cz18HT2hdZ3iXhTsUsy+QiBCsGMBVnYc5VgssmPM18vkbiRPO6CfFH2P6ZDYieOl4KFw
         RHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548483; x=1731153283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf5PO0O/8GxH6YaffdPErJ0yX0DmIFh2NMk1EvLbRA8=;
        b=KokWa3Fh27tkGAVPdIIi99XSDckSW/V4IH3BiAdD2tklMGG1q97gMDrAfili+Qi2cV
         tQyD0lRwe6ETuUTy+DlcD9XCkii/kH8YaYXHyKq2sj6+mkeDFBHkhGkoNHBoiplgXRH7
         egG1qLOB15ExwLjHXOlJugLxU0JGCQpD2LJDjWgrwlVWM28SGtnJuLw9IIiVxfFMN5FN
         t1khukyoaS1rl8HCUZnYypjHx20/u2a0+wA0z2zkCNxBAH6qjGMh+zVn6+htGLA+gdHU
         lrn0+WK9JsJtIUN26B6R0eB+jJVNWnsqnOccSj/KHptNJIyTGGPb8SiPPNGElgT/lcOD
         MQrA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxEFQmH0VTIxTXatNupVaA7kxJ8ksuxibVbsawtSgK44g192MssiXDT0Kjeca9D4C/1DHu+rLEN0y1sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04etW1wX65MRGnx8PtKcnvnrmUUbhda54VnKw6Wh7/dPDwrTE
	cqZaTc+uT/Ft1oaP1eZ8qdASxIBMtbhMEDHm1Qhmpk4Cp/+HdlKZ46jIm9BkEA==
X-Google-Smtp-Source: AGHT+IFBSMlqCkyuHYgmkW0THyLKy0cIuZ+FHeVb4thr/BQ4WLID6ROgAM8u2xitC9jx8P6RXoMQtA==
X-Received: by 2002:a05:6a00:1397:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-720b9c96d0emr14158400b3a.13.1730548483312;
        Sat, 02 Nov 2024 04:54:43 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8cf3sm4023582b3a.20.2024.11.02.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:54:42 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:24:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102115435.s7oycrh2pjkfhpsu@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
 <20241102111012.23zwz4et2qkafyca@thinkpad>
 <86jzdl27my.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86jzdl27my.wl-maz@kernel.org>

On Sat, Nov 02, 2024 at 11:32:37AM +0000, Marc Zyngier wrote:
> On Sat, 02 Nov 2024 11:10:12 +0000,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > > Some PCIe host bridges require special handling when enabling or disabling
> > > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > > to identify the source of DMA accesses.
> > > 
> > > Without this mapping, DMA accesses may target unintended memory, which
> > > would corrupt memory or read the wrong data.
> > > 
> > > Add a host bridge .enable_device() hook the imx6 driver can use to
> > > configure the Requester ID to StreamID mapping. The hardware table isn't
> > > big enough to map all possible Requester IDs, so this hook may fail if no
> > > table space is available. In that case, return failure from
> > > pci_enable_device().
> > > 
> > > It might make more sense to make pci_set_master() decline to enable bus
> > > mastering and return failure, but it currently doesn't have a way to return
> > > failure.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v2 to v3
> > > - use Bjorn suggest's commit message.
> > > - call disable_device() when error happen.
> > > 
> > > Change from v1 to v2
> > > - move enable(disable)device ops to pci_host_bridge
> > > ---
> > >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> > >  include/linux/pci.h |  2 ++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> > >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > >  {
> > >  	int err;
> > > +	struct pci_host_bridge *host_bridge;
> > >  	struct pci_dev *bridge;
> > >  	u16 cmd;
> > >  	u8 pin;
> > > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > >  	if (bridge)
> > >  		pcie_aspm_powersave_config_link(bridge);
> > >  
> > > +	host_bridge = pci_find_host_bridge(dev->bus);
> > > +	if (host_bridge && host_bridge->enable_device) {
> > > +		err = host_bridge->enable_device(host_bridge, dev);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > 
> > How about wrapping the enable/disable part in a helper?
> > 
> > 	int pci_host_bridge_enable_device(dev);
> > 	void pci_host_bridge_disable_device(dev);
> > 
> > The definition could be placed in drivers/pci/pci.h as an inline
> > function.
> 
> What does it bring? I would see the point if there was another user.
> But this is very much core infrastructure which doesn't lend itself to
> duplication.
> 
> Unless you have something in mind?
> 

IMO, it adds a nice encapsulation to help readers understand what this piece of
code is all about and also keeps the callers short. Plus the disable helper is
reused in both error and pci_disable_device() (if that matters).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

