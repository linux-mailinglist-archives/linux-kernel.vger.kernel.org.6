Return-Path: <linux-kernel+bounces-400310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29479C0BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53071C23A27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E31212657;
	Thu,  7 Nov 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4CdXoO+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE641215F51
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997067; cv=none; b=H/hoE8xE0sBydSv7VrsVLJyYEtqggrXEcvAXwhSARHna+fRzoLHMLyhiuMsgkiOpZd8jrPvAOuXBaoisNQLoMMIgZD2VCn8XNvBR6I89VbFZG1ndrKW62SpJxUvRFHR7eg6dY6Jf+q4LzufpVjDdn8ijP8UWb3xuBeSzPBNEP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997067; c=relaxed/simple;
	bh=t3GKQ93gnY+IQZ99F1ny/61LvAa2Wpx/BVP9oL9INX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIKLkG3aH8c6Miz9OS+kWtL3MymkZwTSnGb9LO+brxU5T1YIEq/akBYodPaEVarf3q91z5XPzEAXpKlS2q+etu8oZWokgzXy87ODFhaHFDehHglg2byIp+4AQb+Y9b7veAqSM3tQDgqnQkzs42/EG/L2tKESf8Mu37MPov0lZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4CdXoO+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d808ae924so731393f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730997061; x=1731601861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGn2f45tYzpwIDupkR6z6PhyeqcvE77Fm8hNIVc/RIg=;
        b=T4CdXoO+4qs6FHPcC/ndsC7AQiyZo+lPd89xjy04bb+Wce7rFaJwvLX6Zy/+ZsEijD
         oUfkO/WhWVAorxoEGSGLRGU1MfgJrcf/QWPeVMfd3T0qqTua8dyY5z8+ISO9Mg5cNHeL
         zb0oo6eHT0ughD2m4BeKQKQngi2itS0MJoadFTH8KXjGQmukTp72HTP1vnzY/kmgSL4u
         gauE+/Qx5IzKgGsexXSfDH1ayyf4yiEOCMwhaGjICpntS61M0qXW4WweE42S5Ah0oSD+
         NZkmUozetfaaK5nTDQzcvCvp5ivGcp+wl8/k3mmS9Ew0bu6ygjo7Hqw8KL1qOlKyg3V7
         3mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997061; x=1731601861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGn2f45tYzpwIDupkR6z6PhyeqcvE77Fm8hNIVc/RIg=;
        b=woQr0uGCmLxXVRxP8Nz6yFYyQmObFqIo8EB5lr2auUkDpXVchpm9KUrsrDMKvvLyuD
         Y1NN9eLZdAkP9EOMUQkulZcnFImK0vgijy1hO/OIGprg0dipOJa5bsPmqtWiDjGPfIPt
         BqvJPvrk6h9yjQ1RHpqptkw1Q8ZoPqTh3kSF/urH/5o/bxi9mjY8v5fxbzZ+njGHglAY
         Gl4w2QgwuCRte0uwmvwyH0HQouKwTtfc5Z/SAILHF8WFrNEo5RpW2XQf17rXWs2E426o
         TdJkq8HMvCTQNq5Vuqzs+ybVZJaqj6qVSnPTW1RVIHmZ/4k7dloQhtNd6EcDItBw2UAQ
         T7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUZKyYB8LFd1QaxIjSYy6eWI99j3lv73Y+YFQHV/ljqUYEH0LhjUPZ8wn5uZNJrMJ6IFkkX3R/DhLVEwME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyht8sWMg01XGgARYNj3hDBgpBTX9QvCnEv7bnY0Juoz1dnT0nH
	yBy8uX+Hgmcr7AsaLracFbaWma/yt+v7+oSCGNSlrHb47qJYr8SyeWZOp8saOA==
X-Google-Smtp-Source: AGHT+IFn8hMMlS1vuzDlBFPgri4GJhUAcCDVni34CQZgGkvMHUH9vsy1be+oNOc80rBebleeE6GosQ==
X-Received: by 2002:adf:f784:0:b0:37d:4aa5:eae5 with SMTP id ffacd0b85a97d-38061221e2cmr29305957f8f.55.1730997061238;
        Thu, 07 Nov 2024 08:31:01 -0800 (PST)
Received: from thinkpad ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda13780sm2103038f8f.109.2024.11.07.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:31:00 -0800 (PST)
Date: Thu, 7 Nov 2024 16:30:59 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241107163059.q64qebgwzn377fwb@thinkpad>
References: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
 <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <ZyzmBQlt5WJ+D9xM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyzmBQlt5WJ+D9xM@lizhi-Precision-Tower-5810>

On Thu, Nov 07, 2024 at 11:08:37AM -0500, Frank Li wrote:
> On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> > On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
> > > to send PME_TURN_OFF message regardless of whether the link is up or
> > > down. So, there would be no need to test the LTSSM stat before sending
> > > PME_TURN_OFF message.
> > >
> >
> > What is the incentive to send PME_Turn_Off when link is not up?
> 
> see Bjorn's comments in https://lore.kernel.org/imx/20241106222933.GA1543549@bhelgaas/
> 

Thanks for the pointer. Let me reply there itsef.

- Mani

> "But I don't think you responded to the race question.  What happens
> here?
> 
>   if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
>     --> link goes down here <--
>     pci->pp.ops->pme_turn_off(&pci->pp);
> 
> You decide the LTSSM is active and the link is up.  Then the link goes
> down.  Then you send PME_Turn_off.  Now what?
> 
> If it's safe to try to send PME_Turn_off regardless of whether the
> link is up or down, there would be no need to test the LTSSM state."
> 
> I think it may happen if EP device HOT remove/reset after if check.
> 
> Frank
> >
> > > Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> > > Because the re-initialization would be done in dw_pcie_resume_noirq().
> > >
> >
> > As Krishna explained, host needs to wait until the endpoint acks the message
> > (just to give it some time to do cleanups). Then only the host can initiate
> > D3Cold. It matters when the device supports L2.
> >
> > - Mani
> >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 20 ++++---------------
> > >  1 file changed, 4 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index f86347452026..64c49adf81d2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -917,7 +917,6 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  {
> > >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > -	u32 val;
> > >  	int ret = 0;
> > >
> > >  	/*
> > > @@ -927,23 +926,12 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > >  		return 0;
> > >
> > > -	/* Only send out PME_TURN_OFF when PCIE link is up */
> > > -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> > > -		if (pci->pp.ops->pme_turn_off)
> > > -			pci->pp.ops->pme_turn_off(&pci->pp);
> > > -		else
> > > -			ret = dw_pcie_pme_turn_off(pci);
> > > -
> > > +	if (pci->pp.ops->pme_turn_off) {
> > > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > > +	} else {
> > > +		ret = dw_pcie_pme_turn_off(pci);
> > >  		if (ret)
> > >  			return ret;
> > > -
> > > -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > > -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > -		if (ret) {
> > > -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> > > -			return ret;
> > > -		}
> > >  	}
> > >
> > >  	dw_pcie_stop_link(pci);
> > > --
> > > 2.37.1
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

