Return-Path: <linux-kernel+bounces-317621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430F96E12A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D01F2881EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6331A0717;
	Thu,  5 Sep 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hulCOhoy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22043AD7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557698; cv=none; b=NLlstVlUf2136XkCM8ZwEd89f5rDOPHQIsIgEN9c2RykLvKfKQjWD2qh8a+dIpANfaEoN4AWfWVc1aty5a4VQjDof++4nq7TgQA4EdQH2NJXH/rarEA1mO4+oBdtufbFTdp3mJANk5kL36xfZR/b236KAGuyAPHRcb0n/8K944M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557698; c=relaxed/simple;
	bh=MI2LRc6AktxdTOVKQGnfpzkt/G3bqZJj+90kchL1ybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecuxj9LOe1R6/+dBV3+IWReqR0mbzshISoYdTz+QsQP0lfBGnblb90LxR1lOw+a/UmhDkAhzsQ+J7bC7B6JVs46xKqT1qf+1mad79p8vUjQnTdAl4qGDyWkvxSaCUkcQfszWJbbC5kck7N02t1v0qkprpTktI5gUtnIAIwsGYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hulCOhoy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20573eb852aso14943795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725557697; x=1726162497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIgzal7ITyKn4Uu6UhwVaplHaAv3wUp9Qsoun/N+n+c=;
        b=hulCOhoyJCHBTWpZY3k0dfuTPeZGDEkSROIH4NWLDKyXdLv/1pK8Ku/SWLaIR6QLgp
         CcJzqECDc9oDWK9w95OmGKOKDDbPVue+SzU4QLtXHCzMr6/UiYM8dj+34YttIb75k8jj
         1AICwt+dhQPVN0vEY4EBN982S/jgVjMCErT+nyH9nvUo/atk8ZEkOws2qkdYaBXKbGjx
         J+sGiH924F+hVcjZ7Nzu7ldSVSKSHUhycocG2D8/I93BjABk67sGhTTCrevoF6IoqJQ6
         jRkXCuY7WKRbhn2ZJhPY36JTWoAHHS1wlnJC4lFy2D5CPUxiPU4dNwz3wkB2NfIsDu6I
         TyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557697; x=1726162497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIgzal7ITyKn4Uu6UhwVaplHaAv3wUp9Qsoun/N+n+c=;
        b=bSic2ErCIWoZAebS57fDPhXRWOHkApsqtUMGsROGt/z4bk1xh6izEV/ElRgUuxEQCS
         SCOM0pVekrutJBw5R5tzIRNs0O6HXEK/h0FCWqaDCWh6rsan1UmvaA56DpR1DaW1bxHR
         Mn9bzUWuTXksizaJPgmgafRkSXIFYCe6LYuZiUUKOigsTgwPYP08KvQF+6cf7LC2SfUb
         8fHz1QVISXa31rI11IupAVzodAStxSKlBHRcyiaViZJ4aNnAvRYTya6de4yz4eDtyCCR
         SGLECyg+4Ta3k4tYw7tPGG2ODF3RTBKCKj1Ot3Qqp/NFhWVC7s1K0mkwbLPONHchJFNe
         uLRw==
X-Forwarded-Encrypted: i=1; AJvYcCWYRXY8aK9yGfE1Plcn4ykOQhYOMWoOQm5Ol1XCl2Glp8+C6UTOi2elXBLQ8wEkurLK5+rLYpR89i6aX+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN/NK/D04zEKPf68smg7Xf0mvO2O2BKOZ0ONugJbhkFtC2Crq
	zQ5x21e5+jpQLJIMN/V3x6XWiGJR3npsnXOlHXtVXlgDBECD4ScOSA9YwtF6jQ==
X-Google-Smtp-Source: AGHT+IElFJh9mBN0d10CvX+yxAjA8cHTDsSZBmgENNb/EtffZEORF9F48GUK1FqLfVaqnR4xQfoX8Q==
X-Received: by 2002:a17:902:ea0a:b0:205:3475:63be with SMTP id d9443c01a7336-206eeb8c61amr497735ad.25.1725557696776;
        Thu, 05 Sep 2024 10:34:56 -0700 (PDT)
Received: from thinkpad ([120.60.52.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea69770sm30809955ad.277.2024.09.05.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:34:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 23:04:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <20240905173437.hm3hegv5zolaj7gj@thinkpad>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240905152742.4llkcjvvu3klmo6j@thinkpad>
 <Ztnb-GauC_8D8N-i@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztnb-GauC_8D8N-i@hovoldconsulting.com>

On Thu, Sep 05, 2024 at 06:27:36PM +0200, Johan Hovold wrote:
> On Thu, Sep 05, 2024 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:
> 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > > new file mode 100644
> > > > index 000000000000..259e04b7bdf9
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > > @@ -0,0 +1,8 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > + */
> > > > +
> > > > +#include "pcie-designware.h"
> > > 
> > > You only need a forward declaration:
> > > 
> > > 	struct dw_pcie;
> > > 
> > > > +
> > > > +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> > > 
> > > Compile guard still missing.
> 
> Sorry, I meant to say *include* guard here.
>

Okay. I got confused initially.
  
> > Perhaps we can just get rid of the Kconfig entry and build it by default for
> > both RC and EP drivers? I don't see a value in building it as a separate module.
> > And we may also move more common code in the future.
> 
> It is already built by default for both drivers. I'm not sure what
> you're suggesting here.
> 

Right now it is selected by both drivers using a Kconfig symbol. But I'm
thinking of building it by default as below:

-obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
-obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
+obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o pcie-qcom-common.o
+obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o pcie-qcom-common.o

A separate Kconfig symbol is not really needed here as this file contains common
code required by both the drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

