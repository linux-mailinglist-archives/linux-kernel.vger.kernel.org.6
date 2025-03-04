Return-Path: <linux-kernel+bounces-544518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90DA4E24B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C89D42271E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9426A0A8;
	Tue,  4 Mar 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joUmfuVl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFF20A5EB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099891; cv=none; b=QARvSjspUH3JOfvz68udmphaBb4TFpLNkW05Cvrlcf3toFf1schvUsoQoY7lIUVmgdYqeTWaMDw8JTWFuvKH7Bw7z4hwhAcEilKpiggHWH420yx+ggIOXchuD5ZACG9DuHikg02CsK+Ij+0mA9PHgeoHQF23G0kNXISHXVAkKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099891; c=relaxed/simple;
	bh=Othvkt4z3OMuKADQKjYPkNUm0zui2FIoobFAyRI42mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNs7fE+IpyLNjCxSh+Ktkd4jFi8mKdsCtZgLNmGp9Nw4fXajhkBFNwdY+n/3ovqgZWaxf9Z4nPKnWFPGZ2RioHJklaGHtjEhcy5zUQ9Z8nEBaryZW935IIp8ad3TQzqPo3EgoRiBfmdUemiDHwHvnrEk7mVHotFpIb0tgHB+q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joUmfuVl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349bb8605so111179905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741099889; x=1741704689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gznVwH+MYZINzbreoVjaIlyEQO9ArPaCcwj3cczf12Q=;
        b=joUmfuVlCTm+lEWSmqCHbY/hNYkLvBk0konQk2llGZemZbsYZDLrEqb9KAM1Mia1Lh
         JJ/iLEOhxefiLTcMZ1sFr2F4GmfZrMzFsFJn28lEI2flENULAL8pXeicaxR3/NCn5LZy
         gzR7SljHkthORV0MedWNJ4Sa+1HUS+6Je+HDBhrGSkJG4aobu4mmv4xS7jhyEMDI1TZZ
         ZUukduN508JI9cPUGMCyxyklvffnoKY3ZNlmuILQmRB9dJxyNDfCtHzjheWVgge/hsln
         /mfwb/WkPjP2EWtVf20hsIlMuP1icGNk1RlegUd7Q+xNRVbhqmU6qb/Ro7cY9bJ7w2lR
         lx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099889; x=1741704689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gznVwH+MYZINzbreoVjaIlyEQO9ArPaCcwj3cczf12Q=;
        b=C+Ul6h7fDygZHpmWWkzzwyTorqO6cYoopoQrMRamXFbVClyp/n3tE5SX4HrFmoy9sk
         NbwSFEBz8pr8Di0p59aC+jeadPWhUej0yuR3bCRm945xGlvl5U9gE2UX8+inLv1khd6+
         kICn8ng+VREbGFBfzWztN3KBNRf6G4e/O6MA2ZU/LQAYe0LfuWpcfeDsBkJiAS6kxpLL
         nvwlwgvvv+Zqa5v/750z+sSXpBNXRz3zEV80AGNoYDszMt+KWrQbileahQrrtT0Qvrl/
         6mOkasbR+xqhyye1PsbPW34io7xOUwaFP+35JGWNog6kuhN2pzgVMZRgY0uggCqyBwEs
         Bp5g==
X-Forwarded-Encrypted: i=1; AJvYcCVbyPQxbU7/4z2vAb/uMZb/xc/uGSnPBwDukngA2md3paQhYSDC8F57TYFU8S2YAk73KbHjeu+sQBr7HIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBuOBqpQ0cHudKBSXz6HcyuOP1XDc/AemBoDHeNo3VMhQXaRl
	hIQfUGQQQvlqCA6x0Wvt6bTSLYYVjidfyZSKUlvwBvRKXlCrfPo6QZQg+L+T5Q==
X-Gm-Gg: ASbGncs45FGJ5SttHT+5/3mfT5yx5lLmSKfAcLlZixMJx89zHKOSuubhVKRDD86d5Qp
	bLFcsBk5PK8/lelXt4VkOyjQdk2dAL1qusoutgGfOcWNDoXDbwMUwbgVFeJJcgb05xnlv6zzPOW
	Fg1l3R3ypT/Uspd6GhYecGpYmjUZ2aJEsiQQNl2zubzoRcx5yLpYmckxy2i52h73T5Qj+feotpk
	2jqgGjNGHWf7WjCiwi6qrcmQ6oucTBVyNGd3iZiKAy17gqoNqdjOvrNtx2rxDDaU6za3JJWPooX
	af8eaE84r9ASgxTLmrZqanHr/PdGpvGBVJPTDiCEMlqvDMfJpjRxKbE=
X-Google-Smtp-Source: AGHT+IFgqXki/xp/pRgDQUN3wwkxjCspLF0YwdBipW/dxQdQmaDNd9QyTywhiG7k4tt1FdiccdjR1w==
X-Received: by 2002:a17:903:fa6:b0:223:37ec:63bf with SMTP id d9443c01a7336-22368fbc8f5mr247045075ad.25.1741099888925;
        Tue, 04 Mar 2025 06:51:28 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d326fsm96562045ad.10.2025.03.04.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:51:28 -0800 (PST)
Date: Tue, 4 Mar 2025 20:21:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] PCI: brcmstb: Set gen limitation before link, not
 after
Message-ID: <20250304145120.jrcxrvnuhj2cweyp@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-2-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:29PM -0500, Jim Quinlan wrote:
> When the user elects to limit the PCIe generation via the appropriate DT
> property, apply the settings before the PCIe link-up, not after.
> 
> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> 

Common practice is to use the 12 chars SHA for Fixes tag and not the entire 40
chars. Like,

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

And no need of extra newline here.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 546056f7f0d3..64a7511e66a8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1324,6 +1324,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  	bool ssc_good = false;
>  	int ret, i;
>  
> +	/* Limit the generation if specified */
> +	if (pcie->gen)
> +		brcm_pcie_set_gen(pcie, pcie->gen);
> +
>  	/* Unassert the fundamental reset */
>  	ret = pcie->cfg->perst_set(pcie, 0);
>  	if (ret)
> @@ -1350,9 +1354,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  
>  	brcm_config_clkreq(pcie);
>  
> -	if (pcie->gen)
> -		brcm_pcie_set_gen(pcie, pcie->gen);
> -
>  	if (pcie->ssc) {
>  		ret = brcm_pcie_set_ssc(pcie);
>  		if (ret == 0)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

