Return-Path: <linux-kernel+bounces-368565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC59A1166
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9BCB23AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A555185939;
	Wed, 16 Oct 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU87YC5z"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513A18DF6E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102716; cv=none; b=pV1B1+U8xYvDqS9C96vaO/YxcJbwdRfgJh7TQ6Jo+xKMZSH7lZ+K0tIjWxSYbDQy9pOa/oIXbYJ/X4jzfLAGuihbz6KlIWl54bcsO3ifOT3vTlongjJmF7kF3He5l0nvqibKP3oNtlBJaQpxnF0KyEP16u9X2oyGAied8CSheAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102716; c=relaxed/simple;
	bh=0RLxWeRy7lIWLtpH6trxl5wUyZXhGtOIOX2LMCj6/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vehw9nsbLokUdwKYd4UTd6YwnIDb3y7Nk2bAn+uurDgFycONdB3POApbOfmKn9LZjEu/VWJXOKpgzCHBub/6QlpmjiG0vF3Js67Bm46dMn0BvkPtf4kW8dxK51Gk0O/1Q14XWB2E0U1wg6iX72riRaOaqMjeMeKM9iHX4xm5KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aU87YC5z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-208cf673b8dso1067375ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729102714; x=1729707514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KSLOhR9xxYJXQViHS9mwcM/ewvXBBg+Ia/LYbbJpFyw=;
        b=aU87YC5zk93RPwVvSms6thOMXp75EN6SWzE9mgMWodeb+28twSNgf/uSrwVs3eYAvE
         x9x/84HY53+ioIfsgYwvR5CQIjghilaGNBf75vs2gqB6eCFJzPDLTftui3lH9SSGHxza
         75G5i2PT7IfzWqU8NhYklo9DAp5HWxEtsyQ1403JhcNgIBawDxHdA+g6RNbTKN6CGzlI
         l4P5HER4fVbkS3RlvL9I6jHwOMdIVi2gmrfLTgDBP/i1TnLkh1BcK8GQMxs1/jek3zLD
         rxd+9s8CrcsBojEaKJmmw22EaybbzB8e8HhvxxfHBjAXf8PUdPFKoZVldt6oakM3xYt8
         BBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729102714; x=1729707514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSLOhR9xxYJXQViHS9mwcM/ewvXBBg+Ia/LYbbJpFyw=;
        b=rFHKk+G4H2P85ZXX3Ou5k6nMAxx5CENb/pnQ5/3tpG7v/HyyA7vSCIKavhr/sbasTP
         FV7Kszv9IoEMtKs1zt08oSd/Y+pFAR+RnKjRadXaBie4X0TK5uxCHy5UdZQTTemN/w+c
         r6fa9SkqcAHl8vGc9K/gjfB7Sqm6algLiYzsMIMS+WazV5YLE6amFby4YlwrMAuP9O1Y
         HCW2ZWGHIfHawN/mCl7NUR8/SohgVB827efrf/7FDz5rN6bYQK5zGH5uhNYpoN85/8pU
         FW/Y5RpUqmsk7rWDX0dup4rgjryRn9paooZC2KkWqgwpWgKrxxRwPA+suCqxPQGjCZaQ
         Vx8w==
X-Forwarded-Encrypted: i=1; AJvYcCW0F7tVOk1/n0QHLmw6s8DRWGqTjbhHWhS3jWfesceQi2D6pPcsrqluN6HXU0TIxQWugP3ro3HbjmLvocg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPak1BZR2VExL0M4uGiAe2rr3hd4fZWEl4SP3TGanxB1norl+i
	q6MWdIkyPzxH3BN06KUaj08coiRvWB7J0+it8/OQShNEmaJoCsJJWtQ0pUqhTA==
X-Google-Smtp-Source: AGHT+IGL15xkEGVz/G0WNUShtqNUkX0igr2aU5z36X8kq9Zvhx6EQrdSgDcWVqEV88nIpdgYWyyv2Q==
X-Received: by 2002:a17:902:c951:b0:20c:9983:27ae with SMTP id d9443c01a7336-20d27f275b3mr70371435ad.48.1729102714364;
        Wed, 16 Oct 2024 11:18:34 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6f3sm31527825ad.300.2024.10.16.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:18:33 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:48:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Frank Li <frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Message-ID: <20241016181829.lfgjtw76sm6pzgcz@thinkpad>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>
 <20241003060421.lartgrmpabw2noqg@thinkpad>
 <AS8PR04MB8676495DB585E7F2C9F6659B8C7E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676495DB585E7F2C9F6659B8C7E2@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Oct 08, 2024 at 08:25:32AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年10月3日 14:04
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: jingoohan1@gmail.com; kwilczynski@kernel.org; bhelgaas@google.com;
> > lpieralisi@kernel.org; Frank Li <frank.li@nxp.com>; robh@kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is connected on
> > some platforms
> > 
> > On Wed, Sep 25, 2024 at 01:48:36PM +0800, Richard Zhu wrote:
> > > The dw_pcie_suspend_noirq() function currently returns success
> > > directly if no endpoint (EP) device is connected. However, on some
> > > platforms, power loss occurs during suspend, causing dw_resume() to do
> > nothing in this case.
> > > This results in a system halt because the DWC controller is not
> > > initialized after power-on during resume.
> > >
> > > Change call to deinit() in suspend and init() at resume regardless of
> > 
> > s/Change call to/Call
> > 
> > > whether there are EP device connections or not. It is not harmful to
> > > perform deinit() and init() again for the no power-off case, and it
> > > keeps the code simple and consistent in logic.
> > >
> > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
> > > functionality")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 30
> > > +++++++++----------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index a0822d5371bc..cb8c3c2bcc79 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > PCI_EXP_LNKCTL_ASPM_L1)
> > >  		return 0;
> > >
> > 
> > There is one more condition above. It checks whether the link is in L1ss state or
> > not and if it is, the just returns 0. Going by your case, if the power goes off during
> > suspend, then it will be an issue, right?
> > 
> Hi Manivannan:
> Thanks for your comments.
> Yes, you're right. It's a problem that power is off in suspend when link
>  is in L1ss.
> How about to issue another patch to fix this problem?
> Since this commit is verified to fix the resume failure when no EP is
>  connected. I'm not sure I can combine them together or not.
> 

Fine with me.

- Mani

> Best Regards
> Richard Zhu
> > > -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > > -		return 0;
> > > -
> > > -	if (pci->pp.ops->pme_turn_off)
> > > -		pci->pp.ops->pme_turn_off(&pci->pp);
> > > -	else
> > > -		ret = dw_pcie_pme_turn_off(pci);
> > > +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> > > +		/* Only send out PME_TURN_OFF when PCIE link is up */
> > 
> > Move this comment above the 'if' condition.
> > 
> > - Mani
> > 
> > > +		if (pci->pp.ops->pme_turn_off)
> > > +			pci->pp.ops->pme_turn_off(&pci->pp);
> > > +		else
> > > +			ret = dw_pcie_pme_turn_off(pci);
> > >
> > > -	if (ret)
> > > -		return ret;
> > > +		if (ret)
> > > +			return ret;
> > >
> > > -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val ==
> > DW_PCIE_LTSSM_L2_IDLE,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > -	if (ret) {
> > > -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > -		return ret;
> > > +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val ==
> > DW_PCIE_LTSSM_L2_IDLE,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > +			return ret;
> > > +		}
> > >  	}
> > >
> > >  	if (pci->pp.ops->deinit)
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

