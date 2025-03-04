Return-Path: <linux-kernel+bounces-544528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8BA4E2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539373A38F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08327C172;
	Tue,  4 Mar 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ4Vsen9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F120AF68
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100075; cv=none; b=ZK01hEI0eF1FiF/GI4te3ArmnPpIo9aKMykseaq0p6YfdwCRu+s8XS//wpc4A+3hq4kMjNej2CNqAChrL7vnpj9IifRZk4MlyhenyWNOlkQ/kTuTGVyGWdL3lPsYph0jjejNg+03+bPCIYFkpWVRSnv4MS5fmsmkwT/baNrQ0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100075; c=relaxed/simple;
	bh=UBoe1XShmX3P7j6hT5643LUFLy9aSuTJBPLFULrG/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWmpniSW4lWZlAWK6B9Ow0bVytdDtLmQDNQbyuu9DBRg9ChX4TEgzIKpE/HjLIInq/+e+1tKps9ktVSVVKSGtymWJ/p/MdLRlPCGzxJWLuexR6F5W2Vc854Utc55Am2nwFgGQSfmqyTMVS808MI1kSE7jaaEgv98J+X1z5EQki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQ4Vsen9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235189adaeso94350595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100073; x=1741704873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fX1Owrn1AszAewAaO9ydb9Cq7XmK0rDK8G2P8SgcArg=;
        b=fQ4Vsen9CieS3KnKkbPLZE2g9yixxVuCKJTLtEffihSIU2bRS0EmMhhEwLKMnaNJXe
         5m4b2b8kYsFNeXWE0Crszoix4nQDaTTDyER9otBRhDfN9qX846Xhc+1OHskKjJ9fStfN
         eBDQFrQ1X2ioYOC9tCP6Tv5LySeLJl2ATnhW+tp7nK3VniKcfmS5FdgnhcPUxTrZV1BK
         nLyUvPtjT6jrLrjlBzBgRSDfBbT++SAXjfBl0AoSFW15NnvrI0+X95aQPqZ41QFyvwCX
         YSGKYsZmPNZpDLpk/3C74zIT+jRWt8MBJBnCxxGomSbd9OXn4Yee+bMtNnGuszQEawCm
         YFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100073; x=1741704873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fX1Owrn1AszAewAaO9ydb9Cq7XmK0rDK8G2P8SgcArg=;
        b=IK7zpR4jwEqDk4DAYaj3bBnbFglkr+VP8D9cloWbp3gpYWU2JZ7yWuZ3a1mgeynQM1
         6kumFrTY9CISdgWwkHVcfGZGD3ve1e/Fz7lwO+9mPaMbZaBnVUJyUSXSvah1vbdrs+V1
         EXvHIjxjyuL+Qu7yT8w4K65Mv/GK95HUnFLneZektsx2UzZ71e4lt+LAcSJ+FtV57aAy
         9xBp8RAR+f1wlMG6y2mSpRF02GK9nPvILDgMkyCCVeNb9icXgZqK5Zbd4QC0BPKtX6rg
         tuxHdxIMVguv6Yo3XjK1I4fCDt2yTwoHfyj/47y/xh+Us94Etz3KmQKdrAT7LBu66SaV
         BRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAy4ddfiywZDPfP3tPPdFh/JrmnOKi8BqMCvSKqNYMgEnCpCa4LevhCBTHuklPckcNsti0iUGR96lqnF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0rPCBV2Z/OEFW6nxdrzpbRzsm1fq+e+QcS/j5iTK3zCDrog2
	QIt5TttSwstJe+JM9xqb0EKTUEoMuoSzRZ5GyxVUOW1Jyf/G5opmtwVHE51xiQ==
X-Gm-Gg: ASbGncueqMTcTNgnjWwYOSL4dDWW9zGJOEw0eAgY+ZnkSg/fL1FGMS05/FhDKb1IULe
	UDFjB6+kAjju5uRXNC3NjdCOnHgbP7LpgZpavHOBeiWOnswOWmy8Xu5eAouFBPco+0KnIBO0UmC
	+mehAOBjrfHgSimyun1aU2vLoWSUCLQ+vVLhi2Wgw1BMt5nP+t7FFg0Plm4x8bH4xZABXM8hico
	QVLRvlEq6aWSci5P84rBp98/g6asDIH+QvII+IOrWBYmTJJEAXTL2kA5/NdqDHdbQtRXvx27tzj
	egPUZ4SAGMlcH90IB4f+SmWxplMsFoQA92+dkYHkWF3om4eB82lPXus=
X-Google-Smtp-Source: AGHT+IFOAFZRsvKQ5dtlmg9hihcEFbJufYkzxSZoZRlfkF27sYRSEvn0Q3zH2r9qpC5gI/Bx2ZfWFw==
X-Received: by 2002:a17:903:2447:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-223d9137f1bmr50389425ad.7.1741100072628;
        Tue, 04 Mar 2025 06:54:32 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223852162bcsm58948015ad.8.2025.03.04.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:54:31 -0800 (PST)
Date: Tue, 4 Mar 2025 20:24:25 +0530
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
Subject: Re: [PATCH v2 2/8] PCI: brcmstb: Write to internal register to
 change link cap
Message-ID: <20250304145425.rayj5zowyxp7s4se@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-3-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-3-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:30PM -0500, Jim Quinlan wrote:
> The driver was mistakenly writing to a RO config-space register
> (PCI_EXP_LNKCAP).  Although harmless in this case, the proper destination
> is an internal RW register that is reflected by PCI_EXP_LNKCAP.
> 

You mean to say that writing to RO register doesn't cause any issue, but what
about the link capability not getting updated? It is a bug nevertheless.

> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> 

Same comment as previous patch.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 64a7511e66a8..98542e74aa16 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -413,10 +413,10 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
>  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  {
>  	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> -	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
>  	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> -	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> +	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
>  	lnkctl2 = (lnkctl2 & ~0xf) | gen;
>  	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

