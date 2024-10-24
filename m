Return-Path: <linux-kernel+bounces-379993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AB9AE6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C56FB21D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE01DD524;
	Thu, 24 Oct 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+lRoR6a"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850718A957
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777062; cv=none; b=lUEtLQcZQAGpYRwvZrtHzRIfd6CSBVDrxHN/vMFIZerfapKN47utL81QV35rL/u8crm+HY9gChC1dzof7bZf8jsL5O9kR+I8SL8nXKikjjTBl8MevOTy9eG918qmSvWQqxPPX0aXwl8XnApk0hvKMEgWfXEogR0syuuMEgvDyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777062; c=relaxed/simple;
	bh=2SnOCBhwyZXux7fMxMhAoghWlcal9u7yKI8UxNjFwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBsDqYjrsY5JeBh2/evNyqORpl35TO4epPLjUeW9Yhk1zoBdtx8XiDM/ac1CoR5vJTZKIt9tk4cxAKrlshQR/Ava3sIQcPseANrwm4hssoQ9HotOFOsWL/fKLTjY2q1HgxKxKsVX3klMCuNurjq/TQhk+Lo5pMY/jOaqST32wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+lRoR6a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c693b68f5so8958585ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729777059; x=1730381859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEUVjMM5cP3IVCnt0k5pdLcYpW2rv69GG7ZEMarKJtw=;
        b=o+lRoR6aKD0qeBdWA+K4bPC+5SWgH7n596QcIzRKSHB1kj17A5qI1Wa/7JExqPLYyF
         SrBdyXrZemDb+UfxeF+m0NTB81047dj5cQp6GAW4IFqcuMb2TwO7L6UKa+5PmYdgvYob
         0G20R/H4vT23h70rmZvvxvDfmCYNjXv5SyZfepVJNxCYjS0j4ZUUIzNzkf93VkHRLq3i
         CHhW/GEkFekwrPHZnZ1bYAHQB9TYdmlDS9cRSJrD2JTYhI4IYKDQa0nQpqAZQ+/UETgc
         qfgFcisXKpMWM8NMzk4+iQ/+t0vLylkDvb8e2su0HdHdxOYEVGKkMZLEYZ2KjXka0eAc
         Dpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729777059; x=1730381859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEUVjMM5cP3IVCnt0k5pdLcYpW2rv69GG7ZEMarKJtw=;
        b=aBsbGIRKfCZGnA454NzoKUIHnpvd6WfR12Tz+2+Rxv8c6ia371UlzTEqfdqW49Tz55
         DpH7WCk1bGJsyf4e54M6TIU8M8oMmK9/EOHgjemDan0v6eBJgOGZ7QINoR3ktR0jLrsX
         9wqkPi/wVT23YLgWp9nwwgdoDwWciMlnjZ0EWGo8vTLurABmynNHV9SX0EwoIGBQwMGq
         Ddi4vp2K1KPct9ru8MfFxR0YmZe0ApM0Zkc/OOf3ofGPEsDu1M1TI0m0CCb1iegU5ggc
         MMofFTO11fy0DB6Zio5jOiBowlCYa2gjJIY10RyxtX3Phk6UUc462xN8C153f6IOHv0k
         rKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4PWg498NUw5cnCZcTJrfgagjeS/SqgdsximjywUXxWRIBUz+wNPr5NdzlfqeBgJgP2Dhc2LxiApvoTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/t+o7DTv7kMPejI1ot6c/1ZvpgBQeJjZ02Hl4+CwPRNfnyljb
	54IzjNvTcJqOcPgMZmxFPKUdnLECw7iXB6epkoBSyD2vNdC312acnLGaLuEykQ==
X-Google-Smtp-Source: AGHT+IFiiaGstAUCa0yhoLQK9WOfZBFCSnbIm9dfRr0/3J1Y6pVv4EtfDs8oy/FmQdzWGXDBeKjijw==
X-Received: by 2002:a17:902:e747:b0:20c:bda8:3a10 with SMTP id d9443c01a7336-20fa9eb64bdmr87232365ad.37.1729777059284;
        Thu, 24 Oct 2024 06:37:39 -0700 (PDT)
Received: from thinkpad ([220.158.156.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0d671sm72669225ad.98.2024.10.24.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:37:38 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:07:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 1/5] PCI/pwrctl: Use of_platform_device_create() to
 create pwrctl devices
Message-ID: <20241024133734.7iibqvjby3id4hjt@thinkpad>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
 <20241022-pci-pwrctl-rework-v1-1-94a7e90f58c5@linaro.org>
 <CACMJSeuBb9VmRrGJnak6D3Ddow+-OMb+79uZzUUaWe3BF1SgTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSeuBb9VmRrGJnak6D3Ddow+-OMb+79uZzUUaWe3BF1SgTg@mail.gmail.com>

On Wed, Oct 23, 2024 at 11:18:51AM +0200, Bartosz Golaszewski wrote:
> On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > of_platform_populate() API creates platform devices by descending through
> > the children of the parent node. But it provides no control over the child
> > nodes, which makes it difficult to add checks for the child nodes in the
> > future. So use of_platform_device_create() API together with
> > for_each_child_of_node_scoped() so that it is possible to add checks for
> > each node before creating the platform device.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/bus.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 55c853686051..959044b059b5 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/ioport.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -329,6 +330,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
> >  void pci_bus_add_device(struct pci_dev *dev)
> >  {
> >         struct device_node *dn = dev->dev.of_node;
> > +       struct platform_device *pdev;
> >         int retval;
> >
> >         /*
> > @@ -351,11 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
> >         pci_dev_assign_added(dev, true);
> >
> >         if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> > -               retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
> > -                                             &dev->dev);
> > -               if (retval)
> > -                       pci_err(dev, "failed to populate child OF nodes (%d)\n",
> > -                               retval);
> > +               for_each_child_of_node_scoped(dn, child) {
> 
> Since we won't be populating any disabled nodes, I'd use
> for_each_available_child_of_node_scoped() here.
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

