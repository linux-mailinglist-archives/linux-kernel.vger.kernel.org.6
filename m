Return-Path: <linux-kernel+bounces-399735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EC39C0395
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9848A1C20E46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225C1E32DC;
	Thu,  7 Nov 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSnGu9hS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C851F4279
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978020; cv=none; b=JysmoxP6ppSYg38eD5xn7Fs7HWeDcFZi3aUVQ45pIdPnCmxS7rtwArZ2tZedGS5JyDmUmGnxiWY5sRK7CiD6oTNfscYf+gkpYc5rowBNqIF+7Rw43bcuvkc30ZIkE2jXh75TIwZmvoBD4fkZVW7L45xii6T7lT1vVPPC370csRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978020; c=relaxed/simple;
	bh=xR5pdVfgkT00dQCFk3s5OdvuMU6MRoAKCsf2yaeddaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKyfDmJo6TQxhXL7DCOpDJFXwNB9Uvi0D7VXf1RTBdYlvThLRqI7omUwwtQw8CPyM3LbuiEIbn/6ZuUpaSmj8Lg4YzEPWQT5JL4lBC4Y6YTGp3OYIem5J6FswBNozRCVvM3Qt/W5RwKqCqdSnvOv2oEKfI6sSBNvdF1fVhHwim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSnGu9hS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1225983a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730978017; x=1731582817; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/3w+/l9YSjeY64zgTCdy6DkO3ioqAuiza1Q3OTguoY=;
        b=lSnGu9hShRAOAbvPcyVlUCNhjuxCEGSSTaglVb7wLmiBxVsN1Zfba+56fBnYe6gnp9
         V/V1Trkl2bae4H7gBRrx1J6zOMKQssUXQc/CGQoAX5MV0l4wKLyYRkIQScn21LxTMzh/
         77QpwhUzFv8IYrPOiY2z4xIPD3FOwwAWqvynfX4lRr32RDz1oDq3/oFMW74KbOuMU3Wl
         qXlz1ahRQ8OLfGCjARdx9lFQsJT3WChfXReWQuFVN0BFmsfCEMEBJT2jtcx+KA4SQsL6
         ON2mC3fw8xddtbOLIrnMdZGVX8bnbeNLQ7/cOIXmHMewHvEOlwUK1AsWgvCxSCDSleKj
         +tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978017; x=1731582817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/3w+/l9YSjeY64zgTCdy6DkO3ioqAuiza1Q3OTguoY=;
        b=KMZbfFX4FcesEdw32thrrWsSH13w8IfekYSShaSnwkV2xF9/JFX6wEbyUFciil0Jlx
         G1vVV0FqiD8w65YW3Vumq6e2250veSIAZof94XFCC/c5MuRQj2wjNQG7jrJwZeU0ZB9d
         GHGJSElGQ0aKEigEv93ahJW1kUA6xYsVJkj3uPDdWnzI3DGQY9A7s98cYtN4Ce2F8xD0
         vMfZ5VtXNzFd1GfppBp3wKUubU8IpltCLtqpRbQzR34+zZMsAjkM4lYabj0oAWPl+Pdk
         sEm6QG4d45751mhLWJE8GFKFf635sQlQPHrQpSl9Lx5Sq8IFI/6lEB9qj8jhHEF502T/
         WhFw==
X-Forwarded-Encrypted: i=1; AJvYcCUei3Xx1nsUDNwsk+dZH1YcAACnEAnGp/zZ5xanzUn2NouExlzqeV/MiHr56x1nbtjQqkAVtm0JgE9hlb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/j9uNmqEP/J4snDrNU28AvD/kzirqFEd+13TLUuDSKfSn4/g
	+tgg9svLvVER9Cqt8QXHQNQ8xUepNUix0XqXkVHPqEtiHoC/pGzZYsy8qW4gTg==
X-Google-Smtp-Source: AGHT+IEF+y4T/yBDvNKsM1yFvgAPhXYXn3816WCOJX1Gqz/PtM2p2O/kE8pi/kOMGYXwMKuR2W+sFQ==
X-Received: by 2002:a05:6402:5188:b0:5ce:d3a9:ae76 with SMTP id 4fb4d7f45d1cf-5ced3a9b427mr9874492a12.3.1730978017061;
        Thu, 07 Nov 2024 03:13:37 -0800 (PST)
Received: from thinkpad ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7cabbsm658776a12.79.2024.11.07.03.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:13:36 -0800 (PST)
Date: Thu, 7 Nov 2024 11:13:34 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, frank.li@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
References: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107084455.3623576-1-hongxing.zhu@nxp.com>

On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM stat before sending
> PME_TURN_OFF message.
> 

What is the incentive to send PME_Turn_Off when link is not up?

> Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> Because the re-initialization would be done in dw_pcie_resume_noirq().
> 

As Krishna explained, host needs to wait until the endpoint acks the message
(just to give it some time to do cleanups). Then only the host can initiate
D3Cold. It matters when the device supports L2.

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 20 ++++---------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f86347452026..64c49adf81d2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -917,7 +917,6 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 val;
>  	int ret = 0;
>  
>  	/*
> @@ -927,23 +926,12 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	/* Only send out PME_TURN_OFF when PCIE link is up */
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> +	if (pci->pp.ops->pme_turn_off) {
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	} else {
> +		ret = dw_pcie_pme_turn_off(pci);
>  		if (ret)
>  			return ret;
> -
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
>  	}
>  
>  	dw_pcie_stop_link(pci);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

