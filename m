Return-Path: <linux-kernel+bounces-337245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A9984785
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CD1C22D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BA1AAE19;
	Tue, 24 Sep 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHbggBp+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F571A7AE5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187636; cv=none; b=icUQaAZniZ/dEOiEGI6Yggwr6rsM5dK/Z9GXSweyYguxBYtPx6T3vcuPfUzelNfBOSTzQPCRcd5Yjo6BYrGHIv498WYzujE4fSHoixP6ApNpLURZJ2I5SNNDFQCcwqsUzIzSivJDYOsFG0FwGmyRz3AkWv//gtc6/p5JL2Vx5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187636; c=relaxed/simple;
	bh=UPOk+PK81w0ChOjq5lIjR4WHqssghyXu2vHYYP7PagM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn9PF5i6c9j7/iW9o/4GNiBDA4hWd3pCcCRS1cNemCRHuIjfnujX71BgSiBWBbONhi4ObU0NLsle/5JizzwnuhuVWV3UQ1UGBxKAuPKLHla8hmwGcDlJLHjoXntlruZ542exM3Rr7o/jmEP7Zql4U3zjWLnHiIMT2WHBqoGlxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHbggBp+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so71953425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727187632; x=1727792432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z2S/knbgSeAcPARWI2M4gp/b4Lg1w2RRQzd/K2Q0FjU=;
        b=qHbggBp+kP3hRfOY1XhsH7SzZypLDvxeSEticIzUb8xG4CNBDSz8FGlmV7ZuAGlNdk
         BM9CNQC6te1Q3Cj5MQh3UzXHmQW3sCZJW2lKUg3i0azjVAhCarWKsAmjbMntw8PcrPbZ
         lIzNq4H+KZqDUrsa1Glk6ITpE0E3a+g6WPo6lH9LIzKXyfAvrsAkln1YNP0ar8PV4UWg
         UQ2Zxfa8t5nGSAe88jGwW18EWQhnVxib+D0LCp69n9zPys3BJ6D1bigo9nW1fvo/QOB9
         0xoQ2Yt7PrcRjZO+X0EE18bPqwahoRTGAiVePiefrmDU595ahiHE78R9i9qWx0Aq886N
         CzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187632; x=1727792432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2S/knbgSeAcPARWI2M4gp/b4Lg1w2RRQzd/K2Q0FjU=;
        b=OPlMIPAb/RJJdC5g4ZcIgLzJYhoInGSRnEM9JPOnkXvLJLr/XObPIG+PhbzHJwK/Tu
         AhUM/S3h6aTUoqbdEZ+C3oQMHmJ7TgheOWKn6xh56f+RM598By9v6G9BIGbTHE/xxBVP
         gCT7IVEMgTMLZlXu+yQfZ7MnK67jAfgcIPK6jtdFrxxIz1ml3Z0KoCVAe7Hhuh8xj9wd
         L25EFNBCVlBRBOjxfzmwWJK/CV3LutTIVdT9f1av883IYjY2VAmO+zDUSLvOfHc3RLsO
         o8CIzFqpVPiZxKSZI6TL6LTbb69SHgGyPQ3XmvGqBy7jU9z+6NE9pAhQyT+AGjHlqGBn
         s3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW59ErpE9XSMkhrnCPFCx/Y0vZiLB1Rxkr8gmjy+N6MVUPa7zXNxpozt7mCmTOlYPpmxXnlYnKZh4C7ax0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IQL0GFKGsFINeN1ajdXaSdtrSnYXMuQe0dXTxod+L19bfqns
	FB8ErlBVpourOGhZ1naSgER9TABbfJ4zjRwQ70Jz/3/hTLQp3zF++EQ6arMnwQ==
X-Google-Smtp-Source: AGHT+IEOTz+nNJ1U+A0tyA4/d512bH2gLljmg9erYZzsFxEofVsk6Zadb5PEW+J4WK+3bKM1iJ5COQ==
X-Received: by 2002:a05:600c:4f0f:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42e7ac4b1d4mr175905505e9.17.1727187631538;
        Tue, 24 Sep 2024 07:20:31 -0700 (PDT)
Received: from thinkpad ([62.67.186.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9027450asm19664685e9.0.2024.09.24.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:20:31 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:20:29 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	bharat.kumar.gogada@amd.com, michal.simek@amd.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller 1
Message-ID: <20240924142029.kyln6zcnrlrmfqjf@thinkpad>
References: <20240922061318.2653503-1-thippesw@amd.com>
 <20240922061318.2653503-3-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240922061318.2653503-3-thippesw@amd.com>

On Sun, Sep 22, 2024 at 11:43:18AM +0530, Thippeswamy Havalige wrote:
> Add support for the Xilinx Versal CPM5 Root Port Controller 1. The key
> difference between Controller 0 and Controller 1 lies in the
> platform-specific error interrupt bits, which are located at different
> register offsets.
> 
> To handle these differences, updated variant structure to hold the
> following platform-specific details:
> 
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> changes in v3:
> --------------
> 1. Add kernel Documentation for variant structure.
> 2. Modify compatible string.
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
>  drivers/pci/controller/pcie-xilinx-cpm.c | 50 ++++++++++++++++++------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index a0f5e1d67b04..81e8bfae53d0 100644
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
> @@ -80,14 +83,21 @@
>  enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
> +	CPM5_HOST1,
>  };
>  
>  /**
>   * struct xilinx_cpm_variant - CPM variant information
>   * @version: CPM version
> + * @ir_status: Offset for the error interrupt status register
> + * @ir_enable: Offset for the CPM5 local error interrupt enable register
> + * @ir_misc_value: A bitmask for the miscellaneous interrupt status
>   */
>  struct xilinx_cpm_variant {
>  	enum xilinx_cpm_version version;
> +	u32 ir_status;
> +	u32 ir_enable;
> +	u32 ir_misc_value;
>  };
>  
>  /**
> @@ -269,6 +279,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>  {
>  	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	const struct xilinx_cpm_variant *variant = port->variant;
>  	unsigned long val;
>  	int i;
>  
> @@ -279,11 +290,11 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
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
> @@ -465,6 +476,8 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   */
>  static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
> +	const struct xilinx_cpm_variant *variant = port->variant;
> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -483,15 +496,15 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
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
>  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
>  		   XILINX_CPM_PCIE_REG_RPSC);
> @@ -609,10 +622,21 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
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
> @@ -624,6 +648,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
>  		.compatible = "xlnx,versal-cpm5-host",
>  		.data = &cpm5_host,
>  	},
> +	{
> +		.compatible = "xlnx,versal-cpm5-host1",
> +		.data = &cpm5_host1,
> +	},
>  	{}
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

