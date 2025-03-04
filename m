Return-Path: <linux-kernel+bounces-544784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87530A4E52B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BD5168059
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4421524EAA6;
	Tue,  4 Mar 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNptpm8Y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EB24EA90
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103178; cv=none; b=ixhhi83W5dkiYEaACWYi4nkCqHQEj51j/qIR9lbWfmw5nujmBWhJia8Us0YjHPYzKnlX+t4Fc4T7xV2RCNO9mfBQuqgpemxftmBU0Pudt9kFWyEhvCbtL2qKe4tN7z2uQ6Jk3F1D7BGq6fZSGIQ6+taoRHhHc4Z0MswE4tdPKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103178; c=relaxed/simple;
	bh=p9MPleuZDVUI+Z5MIM/sLliMtf8a2r+Xk6MzUvX+8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKQMKrCqcDmlRs7GKSO6Dj2wjCx2KjvhjK9JcdEroDf91fO2Dltaj5T25kulwd52qLclzWqxG1EgN0mjZzzEjVsdmJTr/WhPkSGFe3R6Fbd1V1rlFPI7XN0OZrAzDlQiIn1hw+TQ4zc0HWdXtiCP6Lydfed1b2Ox0ACobHsSuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNptpm8Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349dc31bcso102433335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741103175; x=1741707975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YL+VxJ0Q3RaNWRR/aVESAdhzcvG1F11vJfodj75NqY=;
        b=RNptpm8YkrxZcFlQ2rmewYn89/+UhNfS16RNomfluGKNP0b8nm9uCeOcsTv9w8R+CF
         DtThGJFCaAFF+Bvq1IIltAJO1URcZ4z4ZXGbjXU2X2NTzzVCKCJEjyXUeHJgH7IK2C1q
         pmQwjPq4LFEsK9ukMBov1dgkFGpsVce9pNBJ4E5lboMB28Vl4H523S2ULXgiN7kzJoZH
         NiyIAT/6HzWP5IOswShSCBUQmLPjvPtK4BgYUDc2XUaYxsnaYlsLgyVexqgE8tcyOXaX
         cHCIpxgtFC07FBV26Bq98ANcYpLL93I7mXchbtXKqWdi3VYoVt7ktBQvNXwr2lg9S163
         2VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103175; x=1741707975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YL+VxJ0Q3RaNWRR/aVESAdhzcvG1F11vJfodj75NqY=;
        b=HuhjPXr0pozCUMJWZym+DD2HxxEXGWZz82rCiVK0+gsVT1W+g+FOR9me42xJgTXWOn
         m3ZhD/LUKO+qCzAyz9IkWoQMJK3LvTbfDMVrnezV+AE6ZtYWfTdG6dmcNRp/9yEUBI97
         R/G5SldvqQotwoXNRlrn7soQB4fZHDGFgSSG/iZMXOAiTzS+WRq0QZm7NsecDF6GE8sN
         uFrvj34n/U3WFe9PYFKRae4766UE0geTeGE2r2ahHfLSSTnhol1LuTiEspPKViZts4Id
         CxBn+Utn9CtMfMen4VlD5huCJiaFmyBrHs8OQV4NlzSWx2DhsP25BuCIchmsUCdkYfES
         0FAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbHIJhzsIqDUIuumb17BOrhU6oj2x0RkxT6SP1mhs9/X0jHhoeQ9qGd+psqmwR7op/IuZVjzABWKdE1wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HY98XfLgv033jFBanhgk2o4VipzoGxRdcSb+a3KkIM9tBvm9
	823hb8m318YqmiLZTkUZSd+dQspyaISt2c8hXEiTL61e6lrFD+TAIZiSyy+B7A==
X-Gm-Gg: ASbGncvojTfDKQsOaALggFAyKPU6yenY5TuJ3Sb18aNrcGwFnw7j57d81gc4u2fULUJ
	jMMH748tJNZDDqxpSrZ9qpT0KtlRj1X0owTylwXAfWLxcSdpiUayKT1QmrwNQK2lnsjseeQCsHv
	Frn9y9ByhPX7kNJnfwJMOlwlbLzKRk7ab1TdX1KjyV6IwOxgAuu9L2Qf1C8dVME6EJh3txSI/B0
	VfT6DC2pizuzqZIX+zgF7oYJEnmpN4n+QdhkO12SbHHlsoI0PMYqedrV9CF5nIsfBlhP3JyUtkc
	TvEGZDLJfsxlXDqOAS5R8HwP75oy+phMF1ineswa18BmNdtrK5i9tLI=
X-Google-Smtp-Source: AGHT+IEu5Llady3MDRUfE27shPyV3JvqN+sd6X1GgDxXaMbDHoS38zRfVq5TjcSVc4smqJopw9/IuQ==
X-Received: by 2002:a05:6a20:2447:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-1f2f4e4e1f4mr33125419637.35.1741103175351;
        Tue, 04 Mar 2025 07:46:15 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf206bsm10352962a12.6.2025.03.04.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:46:14 -0800 (PST)
Date: Tue, 4 Mar 2025 21:16:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error
 path of probe.
Message-ID: <20250304154608.5nmg4afotcp6hfym@thinkpad>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250224155025.782179-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224155025.782179-2-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 09:20:22PM +0530, Thippeswamy Havalige wrote:
> The IRQ domain allocated for the PCIe controller is not freed if
> resource_list_first_type returns NULL, leading to a resource leak.
> 
> This fix ensures properly cleaning up the allocated IRQ domain in the error
> path.
> 

Missing Fixes tag.

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..660b12fc4631 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  		return err;
>  
>  	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> -	if (!bus)
> +	if (!bus) {
> +		xilinx_cpm_free_irq_domains(port);

Why can't you use existing 'err_parse_dt' label? If the reason is the name, just
change it to actual error case. Like, 'err_free_irq_domains'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

