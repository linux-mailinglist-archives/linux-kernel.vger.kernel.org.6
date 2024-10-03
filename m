Return-Path: <linux-kernel+bounces-348608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9C98E9A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54449B245AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170985914C;
	Thu,  3 Oct 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ht6wX2wf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17222537F8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935468; cv=none; b=R1vtLxHB7p5VPQPfU05E6wgVD43hsxDL1azU5ea8G0Xl5R2M0a/EPzbSfZbvyy/g6bdAakCY7sozD9L1su6c3UtGwtNSm+HvQLErvLHKRuNIXtYnTsNtuXbBcSakNnv5ig1BP80Qy1XHxwlUu6eQKEpMS+EexChJyt49mQ5HFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935468; c=relaxed/simple;
	bh=X2pDXwzUvcJDk5paVKoKsB3r0vt+Ai0zPt8NKqANJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFx4rybs6WkjpzJ4FLCeG1BDfEHoM2NYhLLe/b1rLfQjxuvA2u5OXQy3/+qfYLIR5h0Yw9ErDYOdUed+HTvhe3bTKmypgGmf1wdGTWebLKGrx0GLRXr82IOP199WGZzw8UtzxcRahiLSpLA0mHKF32+Un7mAi2psxbufwWvhEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ht6wX2wf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b0b5cdb57so11801945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727935466; x=1728540266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSlA9LdetpttvG342s77JyTcYN0Pv4f2/NSU0/ow4Vw=;
        b=Ht6wX2wfDGgz3wQelQ0XKVD09/6r+8mupGmSSgpDeDmMBB6AhdqwnyOrKCQ2OTt1Ll
         4PAlUnVBIIod7kPew3xOkOqJIZ2KoWzZQiFd0zXJp5k60uXrhDZWilvt0AbFyY9pNlJL
         rVqAVy6v/ApYViN+iEyiAwKUgwwL+WZYfgLh4jgfwrZiDqs9XGwCaDEpFd4m/kxwQNbe
         HetlW2DxpIcUXcnwbLjj0OwtqUxA031MmGjUjuNtIJqG2Hw6RT74yikInAv8eRr6gCdD
         0vM2ih03tdtu/NbNU5RC8diAskJKMwunkj5vhWOAhnunY8+0t9LFS/RsiaCoL8a+p3Ym
         OMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935466; x=1728540266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSlA9LdetpttvG342s77JyTcYN0Pv4f2/NSU0/ow4Vw=;
        b=Y1lntPc6SQHpv7NrK07vBI8xkO84XKq1CjmFC6NeDD8CiwtMdfudHecEhCLOLGHuDX
         I6g+tuc4VY7x4g/v+OkyowJPQZB+cVbUmQxU2iKUukcpLB8mx9fgs6AcGYo1lrR4HlH0
         nvn+zAPSGPf+YC8uUTfL+S7vZpiUz2a9vC4mRQIsoVwMjlc6Ydj89aV79hSrFQCP+4Qj
         JpPIiPbt/SgpKitm78fRMlnjjnsn2yaYK59IUXtXf3Ta3xCOngpmMksRlDGAjCAuhT2S
         zFLrjxXkigWjAuv1TUjnt9e9w89FI9paRXN2ESPuOPO7+KJAXqPjhsvdkj4KW5hXB14h
         NAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDZvS9T+YqOB9ZAEiZuOp0nMIt6haCEXH2bNCaEo35HDJboE7XfekRcearsWalOrN+AWDQ6hbH3m9xmFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYzM6OWZ+rvK+dqIjf8tZOXZYVFvbAnvVjLkXRL5RJu18BCwv
	x/KLJAefLtOxbvUK5fHMF/ik91hIDa6DxQM38MIYAt4qIzeXnB0ohud6vaEJYw==
X-Google-Smtp-Source: AGHT+IEbkU9RN3nbPopsmQ73+roAKVA+VXZZkTBotV2rwtzyji8m7LBm5NKo07zHuz5P5iw5DLR6+A==
X-Received: by 2002:a17:903:11c3:b0:20b:59ae:fe1d with SMTP id d9443c01a7336-20be193af84mr29711125ad.25.1727935466244;
        Wed, 02 Oct 2024 23:04:26 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7fd9casm2384025ad.245.2024.10.02.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:04:25 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:34:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Message-ID: <20241003060421.lartgrmpabw2noqg@thinkpad>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>

On Wed, Sep 25, 2024 at 01:48:36PM +0800, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.
> 
> Change call to deinit() in suspend and init() at resume regardless of

s/Change call to/Call

> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a0822d5371bc..cb8c3c2bcc79 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  

There is one more condition above. It checks whether the link is in L1ss state
or not and if it is, the just returns 0. Going by your case, if the power goes
off during suspend, then it will be an issue, right?

> -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> -		return 0;
> -
> -	if (pci->pp.ops->pme_turn_off)
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	else
> -		ret = dw_pcie_pme_turn_off(pci);
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> +		/* Only send out PME_TURN_OFF when PCIE link is up */

Move this comment above the 'if' condition.

- Mani

> +		if (pci->pp.ops->pme_turn_off)
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		else
> +			ret = dw_pcie_pme_turn_off(pci);
>  
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	if (pci->pp.ops->deinit)
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

