Return-Path: <linux-kernel+bounces-418538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAA9D62C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E89160E63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B51DEFC7;
	Fri, 22 Nov 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDW3fhV/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CD1DE8BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295420; cv=none; b=t/Nag8XbHZWJUO+bPG91b9Vo4Hf+58fY9J7q2yqLXginftT/P1RjTiKwpVGqukEGNkkXEVZlatNUSruKX0u2RxIGXi9N0wo7/HGs86djrFlB7YP/EUcAVHVh+wZvd1i3/dP2LwM0Cz/YJn1+KlTx0kMU3dnCMLnAvnH2lkj1a7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295420; c=relaxed/simple;
	bh=G9cr1gHE3g36F9Cu85STAfJ/9tRuQumYU8/56wvDlXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrRVtKrtA5Rn1Wiix4igKmtulmEhXNl+a2SXbo9yew0J0TE8AICUkU50x8H7IPeZouEEpOMgGLhs9FG4hH+3A/sYkUYAU0HZqV/oCW23eUzLAJcOeGOLGCJLaoQe32W3FKNxwcOntBqUmCUTHIaw0yhs4bazTjm5gOjOZMA7HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDW3fhV/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7248c1849bdso2423192b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295418; x=1732900218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UzD8Qbmoty9y3UdrVjMc3lCWpv9Zoxn+WCwHClf78I=;
        b=DDW3fhV/HabYnNfPG57bMwzAfO2vait3ktXjV0wZeAnIK7hEyjzGCOCFijKlndLBl5
         mT6sS2AtF62A6Qf7qm0p/kNYdURnNZvvMwjNZaWOCIVaZ5weeeysSJzhqq1JRMZ4znDf
         Ke1DTDQYC0uIijbvhGmaHWsNCdbBi+Si1iyfTwrbXcr3QkCDbNZVGrkjILl7RwwxfHsg
         SI5EfwHmhLABjEUYl9dvsFnqQruLCwi2f2OLP1nMcIObe9UYaWpBX+kaWOZp1Zxe1mJi
         5vpb9TGzAXqI/RvNfY/ihN1LtjYVDsa8JlhG0XSJzynowFQP6q/6HPUP2Ks2uQPPMlVz
         uGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295418; x=1732900218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UzD8Qbmoty9y3UdrVjMc3lCWpv9Zoxn+WCwHClf78I=;
        b=axxggSe58f+KPGP8KBKiFgS5RyfNDtlWs6wWoZdcF5m23XvyK6l48jgev9RcH24beu
         kfJ6oKhdtQfxN8TYPuWsPw4iGuDRzvDrqWHrW7TBBUq5/10z5kElHHjyPVS9pJRc0HMb
         Xpu263x1keHyO/Htl3aV8Cv1EfOaZhbVf74lTgDxOVRQU/NvfCaznJEvdMRgcmSt8S8H
         59RN3gsd7g3oOu8lcTJQiBEHwLv8IorsVJOP9kJwRVwUBCOf5g3w5A/HYOrOWBVjyQfc
         T9FUJ/gz/ziowdl7zPlpmG3FjwsWmRW6BcW8Gmv7jbwXMKL0r+TPZWHuHqfaXdyPG2Qu
         fvFw==
X-Forwarded-Encrypted: i=1; AJvYcCV1AGQO5FtMjARiiZtGNqavgn/ZQ8e612XDVFTGokenN1hDnYRtT2UgFg279bpKcOI7cBnviNb5DpslQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQ6UIIescV8Go+QRnirGjM/4qOZiTSJN283s2w7DyPxdQXfkH
	S9upJ0qj+6wG+w+d7qkgWXDBAf628WjNKc10y0lFM8xAMyJ9j7RStuuP9QM+vA==
X-Gm-Gg: ASbGncsKHxcIzNoJ+K30crOJtKN3NTv7MFCgyFX6W7ZY+8QVdv1OvW8axHPqlN4f5lR
	20B+Kdukqw7KJD/ksJi+B1VRXejhR5P4S2aVHP3UtckA+fV78zO+6qEHtvKU6RuttLbtOchae3F
	5NbQSdRb2AQgD/i1qbBoFm31Yk0sohdSd+hex9bCd4K5qJ8d6YzBQn9iipQP41tv6RRQs0W+Wag
	o6/f2QWU93eLQ38oO0BfMvPFGioNIb5s3nOx1OnyX2Y1mWveWsqLi0/xcsK
X-Google-Smtp-Source: AGHT+IEwjs4uHZtrKVZd87ooqlW4TAiWtY5jzSaWXJxP5mRGV9M6kvrK8gtdD6fzbjrc4NKONPYTYQ==
X-Received: by 2002:a17:902:cec9:b0:212:23e5:6202 with SMTP id d9443c01a7336-2129f67b3f6mr39737875ad.6.1732295417733;
        Fri, 22 Nov 2024 09:10:17 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b82sm1911272b3a.102.2024.11.22.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:10:17 -0800 (PST)
Date: Fri, 22 Nov 2024 22:40:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Message-ID: <20241122171010.ze6iyxmgaq7g7yr6@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-4-hongxing.zhu@nxp.com>
 <20241115064106.iwrorgimt6yenalx@thinkpad>
 <AS8PR04MB86766F6553A36E75A2B1F6C78C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86766F6553A36E75A2B1F6C78C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:35AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:41
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
> > from DT
> > 
> > On Fri, Nov 01, 2024 at 03:06:03PM +0800, Richard Zhu wrote:
> > > Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and
> > > iATU base addresses from DT directly, and remove the useless codes.
> > >
> > 
> > It'd be useful to mention where the base addresses were extraced. Like by
> > the DWC common driver.
> You're right. How about change them to the below one?
> The dw_pcie_get_resources() function of DWC core codes can fetch the dbi2 and
>  iATU base addresses from DT directly, and remove the useless codes here.

"Since dw_pcie_get_resources() gets the dbi2 and iATU base addresses from DT,
remove the code from imx6 driver that does the same."

- Mani

> 
> > 
> > > Upsteam dts's have not enabled EP function. So no function broken for
> > > old upsteam's dtb.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > 
> > - Mani
> > 
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
> > >  1 file changed, 20 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index bc8567677a67..462decd1d589 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1115,7 +1115,6 @@ static int imx_add_pcie_ep(struct imx_pcie
> > *imx_pcie,
> > >  			   struct platform_device *pdev)
> > >  {
> > >  	int ret;
> > > -	unsigned int pcie_dbi2_offset;
> > >  	struct dw_pcie_ep *ep;
> > >  	struct dw_pcie *pci = imx_pcie->pci;
> > >  	struct dw_pcie_rp *pp = &pci->pp;
> > > @@ -1125,25 +1124,6 @@ static int imx_add_pcie_ep(struct imx_pcie
> > *imx_pcie,
> > >  	ep = &pci->ep;
> > >  	ep->ops = &pcie_ep_ops;
> > >
> > > -	switch (imx_pcie->drvdata->variant) {
> > > -	case IMX8MQ_EP:
> > > -	case IMX8MM_EP:
> > > -	case IMX8MP_EP:
> > > -		pcie_dbi2_offset = SZ_1M;
> > > -		break;
> > > -	default:
> > > -		pcie_dbi2_offset = SZ_4K;
> > > -		break;
> > > -	}
> > > -
> > > -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> > > -
> > > -	/*
> > > -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only
> > IMX95 is defining
> > > -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone
> > so that the DWC
> > > -	 * core code can fetch that from DT. But once all platform DTs were fixed,
> > this and the
> > > -	 * above "dbi_base2" setting should be removed.
> > > -	 */
> > >  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
> > >  		pci->dbi_base2 = NULL;
> 
> The check and the NULL assignment of "pci->dbi_base2" should be removed too
>  refer to FIXME listed above. Would updated in v7 later, Sorry about that.
> 
> Best Regards
> Richard Zhu
> > >
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

