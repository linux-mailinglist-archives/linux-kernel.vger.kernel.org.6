Return-Path: <linux-kernel+bounces-567727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77557A689A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ABA3A54FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB596253B6F;
	Wed, 19 Mar 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErdaFt3H"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E01C84D8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380347; cv=none; b=SqnUR+HwyhKaG4/UIYMCyMItBCj7Mfx+5Ev0kqIm6P4w+/SiFFhxOtByz1lA+I9Ehug2XVv9EVj3u80Z/zhoYFeXxOrKH3wc0c5z/T8Qa1/cgUFx1LrrDD07WPik9YO9+3zciYltQRZDuwHi2+fMyd4NTfrCX8MYw/jAuxbH8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380347; c=relaxed/simple;
	bh=XpIZsgmvvxNNIAMRoNlx26gRU9BTDC3eUsBzOPt2Ra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHurbanFauWpJjzrijDSnlD6UYkl0ILMEKeXAkdd+mZUxYEVYhZJIBdGCUUyIEJmS1ri7fxmxVc9PWy9E4+kxO46ySjKQ3UcsxB5Bey3yKCRqcxCy/3IXRgmxq2PpOaqd1V1/x32oFmrF3ZxjTAz9FJEu++5l/Bg+d6ZTVeHErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErdaFt3H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2254e0b4b79so29228855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742380344; x=1742985144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evNZMhqkj1ttyktAM6FNCpZ80KvQoIj6HuNmJYBDqp4=;
        b=ErdaFt3H2S7cxn20jmO0GT1cBQWHrsuCcCWaLnlCx6zeXV+btG2kMAVqWgchdYrX89
         lMptYFL9CUUR2JomolmU/bwAoTkrjwm9TrmPdjF0FfnBx6CCVsa2dJ2KQx1OGoyUdFFq
         daWUYM9/9HatJvbWX9BqNaPvuTbQ0mgVlkfHhcWOUqMrqN4Duqhu/ma8lpAIg0C0eU/G
         h8oYHF6cQIAHitgmwflGqCOeaYNpdA108xCcOV7GSYXveGrllP9JhqWlH/lcbtcGotLP
         iTjlT2TWavYASjGazNlqHGwqARN1wjfSowT6Q3iLyaNeopWpqEMEhOclcF47iMoAZSkQ
         W72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380344; x=1742985144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evNZMhqkj1ttyktAM6FNCpZ80KvQoIj6HuNmJYBDqp4=;
        b=LE5aPxL4j5brnLeLOrVMC4anfwstwNYkGpHqxnPYcv8OdV3DojR/DuqP9NuX0A/Jyo
         wsL7sOVlKHYjL/591ZNaoOu3+P3JYUt5QHJcU5TqYa+AbdVGbJWoybAsWKQsyDMo+LUu
         rcCIdH2dmLJCI1q6+vkldYan6gNHTh91wH25AdS9xour2h8wUDnFDpf93eOthXPx8KSJ
         dZoSNxdMAiW6mR/K5hcdL5Fp+2oGGNQJJM1CVRsoKtosaDsJpqMsauUWec6xZuS6NdjS
         sxFWRYSzP6OGMFe9mzRFu2bQnfRhKcxU6S+dpV5X/HvTHDW2ZhpnFm0MT2BuX7e/u+0X
         EKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWe6gqkGlXlWGhy4ie6OtXIxkVmU40CXp3+oX4RLrw1gsLX6X3OgdQPC3QxkGUlgJxsTV3DfKJ8TyRcsrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbgbJ3y6Ga6R4i6UFJI68dwAjS4wCKKXzVgdwSX8CO6Nb+XPc
	7+bd8UKwtS39l655bt7FVm+C9/A0QaPWs+lbs/mQqmmRdxyOol1LHVews9zj5w==
X-Gm-Gg: ASbGncv8/wSff85wXCJ/aunb+GiVM6lYIKMg+Czj2Wye9QHdWa4jaexmtb8swzFBjkm
	piezGQJCtilnnqA47pPSj50919YsA5r6uZWKJ+mxucdw1/YCy2rjqZH6AxnjZHViX6I9BRAzTYS
	xXcvrGLz2uDn2SWWtg5DS/A6vURUzw4+iRHEcE9N05vZCfSbhilG45TUHXbynWXT52mWN6c2Fqx
	0nZzbZ14I0ue4/eZLSIGq25P0Bg9uiPZfnN4RmjXr5ezRDjnQVNpK8LLRwQm0cT2aZlCBoRrQ9v
	Se8pvrCe0VSXWNJ7AKQEB6z5PB6WywtkNhexaS/uQ4qY2ecvNgKdYO0=
X-Google-Smtp-Source: AGHT+IEP6MgbdWZWJAzv7d+SZahNfAT+u7CepjEY9PXUCqNZUa5QkB79CIbo0WUj8WbyfNiS2xiL0w==
X-Received: by 2002:a17:903:2287:b0:224:1074:63a2 with SMTP id d9443c01a7336-22649cb2f7fmr35461815ad.43.1742380343853;
        Wed, 19 Mar 2025 03:32:23 -0700 (PDT)
Received: from thinkpad ([120.60.70.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6c8dsm110467105ad.156.2025.03.19.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:32:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:02:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <20250319103217.aaoxpzk2baqna5vc@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
 <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318081239.rvbk3rqud7wcj5pj@uda0492258>

On Tue, Mar 18, 2025 at 01:42:39PM +0530, Siddharth Vadapalli wrote:
> On Tue, Mar 18, 2025 at 01:33:04PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> > > Introduce the helper function cdns_pcie_ep_disable() which will undo the
> > > configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> > > by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> > > to cleanup on their exit path.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
> > >  2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > index eeb2afdd223e..85bec57fa5d9 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
> > >  	.get_features	= cdns_pcie_ep_get_features,
> > >  };
> > >  
> > > +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> > > +{
> > > +	struct device *dev = ep->pcie.dev;
> > > +	struct pci_epc *epc = to_pci_epc(dev);
> > > +
> > 
> > pci_epc_deinit_notify()
> 
> I had initially planned to add this, but I noticed that it is not
> invoked by dw_pcie_ep_deinit() within
> drivers/pci/controller/dwc/pcie-designware-ep.c
> Since cdns_pcie_ep_disable() is similar to dw_pcie_ep_deinit(), I
> decided to drop it. Current callers of pci_epc_deinit_notify() are:
> drivers/pci/controller/dwc/pcie-qcom-ep.c
> drivers/pci/controller/dwc/pcie-tegra194.c
> while there are many more users of dw_pcie_ep_deinit() that don't invoke
> pci_epc_deinit_notify().
> 
> While I don't intend to justify dropping pci_epc_deinit_notify() in the
> cleanup path, I wanted to check if this should be added to
> dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
> is different from cdns_pcie_ep_disable()? Please let me know.
> 

Reason why it was not added to dw_pcie_ep_deinit() because, deinit_notify() is
supposed to be called while performing the resource cleanup with active refclk.

Some plaforms (Tegra, Qcom) depend on refclk from host. So if deinit_notify() is
called when there is no refclk, it will crash the endpoint SoC. But since
cadence endpoint platforms seem to generate their own refclk, you can call
deinit_notify() during deinit phase.

That said, I noticed some issues in the DWC cleanup path while checking the code
now. Will submit fixes for them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

