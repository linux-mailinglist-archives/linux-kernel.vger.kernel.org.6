Return-Path: <linux-kernel+bounces-331841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31397B1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C81F2152C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C31A0727;
	Tue, 17 Sep 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kef5JOLB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C511A0715
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585807; cv=none; b=jvHFDgugH91FfdJ4pF1eSLbDiuMfdowpNBd9Cvt9ooU1/aeIzJAxLLLSGy87EygiIyPIRGbSnpsOV8/RMH1P/V1fkCqC8MQK2TUpkkEt/3VH+tPWRBlwpm99Y+iEtTmwO8lmJAcBtW19Z4+q5GuW2FvNzhx9pqv4Hw9G2jCaLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585807; c=relaxed/simple;
	bh=PnYbAq39PE3erNcxHa/JuLqNkblIRpP7Fgb21+avdnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHaj3mxrrVA1X3r9Q956xksoHZO2v7+zwMvOBMv12jUGlTed4xvJWgNuQv3ioawAYY7QE2/DfuhYp+hec0yqtIgkGnYLM1Nk3OhkaUFTvQzSpmfZ4jxMsR/9whds2XvkDzfB4SI546xSLerPnjWy9lvkcHBcP0+zttil2kGFzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kef5JOLB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so5264951b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726585805; x=1727190605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCYHskEI+GQ9Ix+yOkIDZ3w1IkWzSol0a0DLeDR1+R0=;
        b=Kef5JOLBJrlNqMAhfWqS4oYahyYULB4Fx/jDgM6G8R4ks9W3ycNXidAK026obR8I7R
         bKa4BlZLl+r7o1SnzbXFTqigyFQ2SHsRKjwxBUHYpt9gAaupyd/Hr0y39NpJ3qvzBEWl
         SlEe/yoj9fQNhqpUvB671INHofSsGGm7t7G0dsD76vp9ofChWn7D/fFHfxH6Eh+ootIK
         AyzhrRnrjuFO9KpEBRaOlBK9BJKNCbOKssrRES9gfZAzUIcoPkyuTxsifKwnv4PyjfVH
         Owrv0M1IqT4fgUFS5MigpME+C8yrCWXwV2xaDqPp/Ux3YTYjXPmAZsQp0d+ZnSF0RJpv
         CDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585805; x=1727190605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCYHskEI+GQ9Ix+yOkIDZ3w1IkWzSol0a0DLeDR1+R0=;
        b=Jks/OLe7vnjPi15iBTG/cAsYHtISXrO7S0Ml+nZ/MuKnQkJDTlsRVsRt1hwoGL0x2F
         WCy5+7T+mdsW5sdjIYBxEfVk7K3uNasSt4DosDhcapw9zdczPr6eBDO1xlSfDrGd4boE
         TyZT8zjvmuyC8acLpJiRe3ePC7xLMoavVE691uahyVfLhJ1rU3aD3rWBOB2uGGBjIt/P
         81kyl3CWcSg1FDYarq0DlyMlpTCpyZkvv+PtA+Q7f75AqO8XFpijmXMJl+5NJt+e80lY
         jrje+qL5tMzmOEgaEpM0rHlMhllkxMCLpjn6GX2HawYERuxKZVHkJp3QDDsEjNCp3nwd
         7mhw==
X-Forwarded-Encrypted: i=1; AJvYcCXEvJ0RHHnxrGz9iTBIYuBLSdyi4KuzVqL8OUyRkljxMkUL/l1LR+F8XobUgXEhQMNoqmxnyVLPNYDZu8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYVjvsNC/5BVU01/CI+FE7xCb+Ymw3II8OX0/mTQCNVn2BSKO
	tsOqJOpM8OKUrSSOkSfa3gkAgYwFvjYGEBG306M06M09R+RTPS2SgUwAu2anLQ==
X-Google-Smtp-Source: AGHT+IFLZcWjrqjoZmsI4ZpaPNRFceD/PPRyGcVrqh1UCItMr9SJpLdCzWP/+3tdf5QVyfDeA87z/g==
X-Received: by 2002:a05:6a20:8420:b0:1cf:d745:d641 with SMTP id adf61e73a8af0-1cfd745d677mr30630257637.18.1726585804735;
        Tue, 17 Sep 2024 08:10:04 -0700 (PDT)
Received: from thinkpad ([103.174.21.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49911546sm5948153a12.40.2024.09.17.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:10:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 20:39:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	bharat.kumar.gogada@amd.com, michal.simek@amd.com,
	lpieralisi@kernel.org, kw@linux.com
Subject: Re: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller 1
Message-ID: <20240917150959.3fsytm4xguoit2xd@thinkpad>
References: <20240916163748.2223815-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916163748.2223815-1-thippesw@amd.com>

On Mon, Sep 16, 2024 at 10:07:48PM +0530, Thippeswamy Havalige wrote:

For some reason, this patch is not threaded and not part of the series:
[PATCH v2 0/2] Add support for CPM5 controller 1

> This patch adds support for the Xilinx Versal CPM5 Root Port Controller 1.

s/patch/commit

Once this patch gets merged, it will become a commit.

> The key difference between Controller 0 and Controller 1 lies in the
> platform-specific error interrupt bits, which are located at different
> register offsets.
> 
> To handle these differences, a variant structure is introduced that holds
> the following platform-specific details:
> 

The variant structure is already present in the driver. Hence not introduced
in *this* patch.

> - Interrupt status register offset (ir_status)
> - Interrupt enable register offset (ir_enable)
> - Miscellaneous interrupt values (ir_misc_value)
> 
> The driver differentiates between Controller 0 and Controller 1 using the
> compatible string in the device tree. This ensures that the appropriate
> register offsets are used for each controller, allowing for correct
> handling of platform-specific interrupts and initialization.
> 
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
> changes in v2:
> --------------
> 1. Introduced new constants for Controller 1.
> 2. Extended the xilinx_cpm_variant structure to support
> 	a. ir_status,
> 	b. ir_enable, and 
> 	c. ir_misc_value for different controllers.
> 3. Updated IRQ handling and initialization to use the variant structure.
> 4. Added a new device tree match entry for Controller 1.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 47 ++++++++++++++++++------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index a0f5e1d67b04..b783fff27c9d 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -30,11 +30,14 @@
>  #define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
>  #define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
>  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> -#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> +#define XILINX_CPM_PCIE0_MISC_IR_LOCAL	BIT(1)
> +#define XILINX_CPM_PCIE1_MISC_IR_LOCAL	BIT(2)
>  
> -#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> -#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> -#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> +#define XILINX_CPM_PCIE0_IR_STATUS	0x000002A0
> +#define XILINX_CPM_PCIE1_IR_STATUS	0x000002B4
> +#define XILINX_CPM_PCIE0_IR_ENABLE	0x000002A8
> +#define XILINX_CPM_PCIE1_IR_ENABLE	0x000002BC
> +#define XILINX_CPM_PCIE_IR_LOCAL	BIT(0)
>  
>  #define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
>  
> @@ -80,6 +83,7 @@
>  enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
> +	CPM5_HOST1,
>  };
>  
>  /**
> @@ -88,6 +92,9 @@ enum xilinx_cpm_version {
>   */
>  struct xilinx_cpm_variant {
>  	enum xilinx_cpm_version version;
> +	u32 ir_status;
> +	u32 ir_enable;
> +	u32 ir_misc_value;

Kdoc comments missing for these members.

>  };
>  
>  /**
> @@ -269,6 +276,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>  {
>  	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	const struct xilinx_cpm_variant *variant = port->variant;
>  	unsigned long val;
>  	int i;
>  
> @@ -279,11 +287,11 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>  		generic_handle_domain_irq(port->cpm_domain, i);
>  	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
>  
> -	if (port->variant->version == CPM5) {
> -		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
> +	if (variant->ir_status) {
> +		val = readl_relaxed(port->cpm_base + variant->ir_status);
>  		if (val)
>  			writel_relaxed(val, port->cpm_base +
> -					    XILINX_CPM_PCIE_IR_STATUS);
> +				       variant->ir_status);
>  	}
>  
>  	/*
> @@ -465,6 +473,8 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   */
>  static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
> +	const struct xilinx_cpm_variant *variant = port->variant;
> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -483,15 +493,15 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
>  	 * CPM SLCR block.
>  	 */
> -	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	writel(variant->ir_misc_value,
>  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>  
> -	if (port->variant->version == CPM5) {
> +	if (variant->ir_enable) {
>  		writel(XILINX_CPM_PCIE_IR_LOCAL,
> -		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> +		       port->cpm_base + variant->ir_enable);
>  	}
>  
> -	/* Enable the Bridge enable bit */
> +	/* Set Bridge enable bit */

This changes doesn't belong to this patch.

>  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
>  		   XILINX_CPM_PCIE_REG_RPSC);
> @@ -609,10 +619,21 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  
>  static const struct xilinx_cpm_variant cpm_host = {
>  	.version = CPM,
> +	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
>  };
>  
>  static const struct xilinx_cpm_variant cpm5_host = {
>  	.version = CPM5,
> +	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
> +	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
> +	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
> +};
> +
> +static const struct xilinx_cpm_variant cpm5_host1 = {
> +	.version = CPM5_HOST1,
> +	.ir_misc_value = XILINX_CPM_PCIE1_MISC_IR_LOCAL,
> +	.ir_status = XILINX_CPM_PCIE1_IR_STATUS,
> +	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
>  };
>  
>  static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
> @@ -624,6 +645,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
>  		.compatible = "xlnx,versal-cpm5-host",
>  		.data = &cpm5_host,
>  	},
> +	{
> +		.compatible = "xlnx,versal-cpm5-host1-1",

This doesn't look like a valid compatible name. Please use the compatible as per
the IP version.

- Mani


-- 
மணிவண்ணன் சதாசிவம்

