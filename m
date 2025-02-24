Return-Path: <linux-kernel+bounces-528297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F72A415F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A8118902FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2B23F262;
	Mon, 24 Feb 2025 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1qumtSW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C320ADFA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380933; cv=none; b=BLsWGOcAgwnZyRZ7hnjPxdcd+gPoOOUiJnYDWpfNAM2m1THPXBX7ae+R0A9GK8KKM+P1ftorjTaSGb4NcP/JzXpHbZjqhQc5wfMIHSwW1MHh3omFKvSqXCFo4Diadw/5eG/yiJrmW+Wj92sVxMTRyrR4QUaFpOZC4ydUKPgwttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380933; c=relaxed/simple;
	bh=MkwbQ9LZo/6/lhuFfrtyiseDQAS/lGEZIPN9WcJGNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eauMp0fH+RL9uAl6f2ENlt4lLbO6iSHCqar1fGgH00cLH7/xoo+onkoXCOM+Y/7j/gpRZI3rKx3N3C+DwR0EG3c9+wGJPVI1ZaCuSSwkeSP77Q2zGWVKrm/8ILeZAIQk0cDXYVa9YRpZVUEh/4JygpB4zfCPk30ofFTW4VqXnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1qumtSW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d39a5627so59154105ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740380931; x=1740985731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0f/tMLiJYULZsRTUCEOnqKZM46qSBJY24xovvsvnuI=;
        b=k1qumtSW9obQQB0YMLHpSu1ds+oEQ7qufETEPGNO+AZ6Wk85LPXXDE2YirNvCaLoJk
         4949arjpZXuttWVITj9l0iErfq1noGg0QbrqBOjJuFvbJa2bj7iImt46eCxb7wr7DG4q
         V+YfAfh7zFT6mWip3cJm8aq9tdCWEV+OABRkKwzYOsWz1FxV5TuFcLlsSiJvXJufPPpn
         4TcS8YJz4/myEc15Tq6qiZ85G4wjlX8ZY5SQf87SiepswGUF1hdufoXARzbFqVmysYdX
         S/9gu19X2HxXtOgVqs8lH6KGJ06jGJp7Up8rMtk3oBLbJ1Lh7RzE+1bZKZoV+yCtBQhQ
         Gr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380931; x=1740985731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0f/tMLiJYULZsRTUCEOnqKZM46qSBJY24xovvsvnuI=;
        b=tQrmFIRAT03fY2CGa92PE+Sv9xpqT7ENwDwiy5LqSAOTlceAPjhP0NSw1VFmAWIGXp
         BuY0ZZC2VFMIVNAsSWGgiZN06MH+DTa/KG7JMAu1YaJ7acaHuzAR59QCeh5SfG+DIc7a
         UWHK38JTlUsEzgTQ4kFI175Fr8mGyyvkctQUmUnZhq+zos/IPLp+HpgsIPAypZJbvSu0
         ZL/RddNXhcUQhWa7VSApT1/hhFBkCT0P5CasiVVDxW2WLPHMyB4pty0pBmXb2Q2TG4/P
         JRAPQ55/SAOrdCVUYabkdxLoynCnYCEE2Zsj0IcmqkzzdjU/0uairJLHSwMg+NXCoUlS
         ivGw==
X-Forwarded-Encrypted: i=1; AJvYcCUSpF6g/dpeSRX6GG6Ffzw+EYybcKgG/zbnu//BGXw3MlmiM0YD9Z+IrXPd4mkQoyWbcF1g0D8JWDtNgsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOm5JTHZpq7Q1RN6iSSl0zbq3aRsBYtuCILl1P4JOfyeAwG62b
	VUcwFyX7An1z9Z30A4n8Pal+lAP9DMdtXHK1Yx9i00YgHB03N3e9eAyIOHO2iA==
X-Gm-Gg: ASbGncuegit63p+3LO8hHmGLAikcVwJUDFwJDKU+5ZFJrSGhosTXN/dH2fwJ02sIspX
	vRU5clS1isBchmJNV4V+8HTruPxHSOw7FXwNq83xFw0BWLcuhjJ7N2sbkDcj5qAVKpNI3DLZxlD
	OoIiKqwtJBjzCk3C22tirTxPZQlxgcd6PVPPzHa+25fJGiK9iCbVq+xvpSjj/cQZSQFhsFpYrLs
	bQoR4axOXpJECY4FsPGjDKf9xm/BnyEeRen3aja3AACaCk8DqfwMdlbMYxzjyzb+tShb5lMaAxH
	TaKCUM30H1aTzLzk+rMzJpDX+WPcE2PgHPQG
X-Google-Smtp-Source: AGHT+IGYWVJJjdXNjc0YzDIJ7TnUfz9dHgBceb0HcOaXD4nstU0qRzoNxcUhZBsY8+NGXb55yZoadQ==
X-Received: by 2002:a17:903:2bcb:b0:216:60a3:b3fd with SMTP id d9443c01a7336-2219ff827c2mr185647485ad.3.1740380930797;
        Sun, 23 Feb 2025 23:08:50 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f12sm174698405ad.46.2025.02.23.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:08:50 -0800 (PST)
Date: Mon, 24 Feb 2025 12:38:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250224070845.6ocpyblzxk7cviro@thinkpad>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
 <20250217072713.635643-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217072713.635643-3-thippeswamy.havalige@amd.com>

On Mon, Feb 17, 2025 at 12:57:13PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the

What do you mean by 'Coherency' here? Cache coherency?

> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. Intx interrupt support is not available.

INTx

> 
> Currently in this commit platform specific Bridge errors support is not
> added.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> - Update commit message.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 48 ++++++++++++++++--------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..9b241c665f0a 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -84,6 +84,7 @@ enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
>  	CPM5_HOST1,
> +	CPM5NC_HOST,
>  };
>  
>  /**
> @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
>  
> +	if (variant->version != CPM5NC_HOST)
> +		return;
> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -493,18 +497,16 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  		   XILINX_CPM_PCIE_REG_IDR);
>  
>  	/*
> -	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> -	 * CPM SLCR block.
> +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to CPM SLCR block.

Spurious change.

>  	 */
>  	writel(variant->ir_misc_value,
>  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>  
> -	if (variant->ir_enable) {
> +	if (variant->ir_enable)
>  		writel(XILINX_CPM_PCIE_IR_LOCAL,
>  		       port->cpm_base + variant->ir_enable);
> -	}

Same here. You should not do these kind of the cleanups in this patch as this
patch is supposed to add only CPM5NC support.

>  
> -	/* Set Bridge enable bit */
> +		/* Set Bridge enable bit */

Same here.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

