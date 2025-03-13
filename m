Return-Path: <linux-kernel+bounces-558803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409BDA5EB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9317A5CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C21FAC57;
	Thu, 13 Mar 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zplUBdIc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE1132117
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845792; cv=none; b=eYc4/hxdQq0Yn6Aj1vOwqO6uZC5o3ZazQ1qyMgzOeRdXCnf1o1KdgypaWJzzuAqM/4aD6GPpqWuW3dTlULeJwO23XqpvFdeN0YeMmeg2dicZ3/nMARNE2b8eKF+ay1nBsBdXpkxHKybR5tDHfbla3m6RffVlzn0LIb89aq4g4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845792; c=relaxed/simple;
	bh=3IHj0fwKLeVDGBEhR8BPbj3M6F9IduKAqL/V0C9213o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP011SQmFL2snVE/S8hTmEaz7jWpsNkGSSHwenqP402PTk6828qEAQvFvleVB+3u34tCh33S3070muYxAXziaBykxLGEHkIUn9SVUZaSbiakHEn5oTybsTDoFZmUYcVBvLEwBDIDwLY5WHeF1gXi03LQzmz4mgLugchis3vtzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zplUBdIc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so16003415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741845790; x=1742450590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6MdjnJ3ua2k7HKceKUirt21FtnY4dMiCyblx2R2tuo=;
        b=zplUBdIcrp7/hOs653ldpWZ0xoFlR1vsnxtwjz2h+Ci9p/zwf3/5J2K20czzrE6cTz
         dTO9HluaW/hMJFKnuRg++aptR3zGIB3zAiz8Wg6VOzRM3GA3ogzBozHoPVmfOVuABoOR
         2xjJ1cVihKMgJDT83AoBq2joYl2HGsw6CQo/9iMmFNy7inj2y87VoKkMoFu+g3Iqbktd
         /vPdrqW3P/EAlFyqU3azOhiV+PikG2uciQ6vM3kPFhLG3Th7ohFl3VD1j+j18j0HQuAN
         TPhnq9+uXXSFzQK82qY1ASsQwHGu/ZLLRilNPI/fsBzc9apQCM/xrpxZq5PqEwdTkpQc
         bAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741845790; x=1742450590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6MdjnJ3ua2k7HKceKUirt21FtnY4dMiCyblx2R2tuo=;
        b=Go26h4JsutXRZTxe/i72ko7q40bRTI+tQOCDa0ricbbx1Mnq+ufc82xu2n6sPoohDx
         GFAVe2dKxc3xeZcU149KBJiGv8QdlZfwfO+KHc8AGaVIKnH/aI0SYDoUqrludVGlW72S
         sbwOyoy2O1Q7ye8uOqMGKGjPwRzgxCeuVflvp8v+oq37zzp3/8om4s31PFr0L+72fN1H
         f7g7sFHymfqJaM4C77HsL8G3aVKQ5MPwUfbpHKyH0NsFGatFXlnoNyawQcKbe/T2lEAz
         E5JqJ7SDjKLxSq42sayDlZ2oJQjYB+seEBzKKFgxRy6dBkikbnEdsKdIa1JuQY3JmAF9
         FYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxKc4Q/mkk3Vcfhdo01xPc4cRfMRQF4aLM8ru8hO4CI+6JmuL3wkbVmswnvT3tsxrTjgCEl5GoRWMGlxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWt2YlPgKnEl1Op3d3kf/V+2w++25oLDyGSmoY27W5dJmvryTu
	do4gLwoVfqYDR0abSJDitDFz6ORGNtDTLUxoUqQGSCloUbqhCyoqFy7A8uf4VMrsEpXFw53fE0U
	=
X-Gm-Gg: ASbGncsCgLLWHgvPdGyAqeLfHjjftg9NelWbNPLWcElAWxYzTFuzMECQgSNX9fzv9sR
	Ixzc7kEyNTBKte/tqWQO0gs6NP1sAwuwKPjDkB8F8dOyU0+ueciQBk2B0pVmNk9JERgAvFnVBuI
	SEBLGcMTsvGwM4nSitfym2Aev1oiMN4ZVZNVzJsfa1Dn/plPWZMaez2zs0Gww1PR6KbgFup+0co
	OfatoFddzfMtIVt7fzOCMgQoD1ecG57aN21Fj+kfxOg2NrWQd6Vf6UDFSgaaflrB8AdDucuOv9y
	h7HMUWxaQLzA1rQkuKqj5jXp7wBtZQxEMkUu646V9eWQnl0exSc/vA==
X-Google-Smtp-Source: AGHT+IFPxLRLvvJqzA698/VJnGHbi0WkE2Kuvvzmsfile6eRsQmYWiTTJ/9mF+iWI4d+NDoThioxKg==
X-Received: by 2002:a17:902:e802:b0:224:584:6f04 with SMTP id d9443c01a7336-2242888ab27mr315006605ad.18.1741845790022;
        Wed, 12 Mar 2025 23:03:10 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688866asm5616385ad.50.2025.03.12.23.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:03:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:33:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Return -ENOMEM for allocation failures
Message-ID: <20250313060303.66eqdf7ok5xpkokw@thinkpad>
References: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>

On Wed, Mar 05, 2025 at 06:00:07PM +0300, Dan Carpenter wrote:
> If the bitmap allocations fail then dw_pcie_ep_init_registers() currently
> returns success.  Return -ENOMEM instead.
> 
> Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 20f2436c7091..1b873d486b2d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -908,6 +908,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ret)
>  		return ret;
>  
> +	ret = -ENOMEM;
>  	if (!ep->ib_window_map) {
>  		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
>  						       GFP_KERNEL);
> -- 
> 2.47.2
> 

-- 
மணிவண்ணன் சதாசிவம்

