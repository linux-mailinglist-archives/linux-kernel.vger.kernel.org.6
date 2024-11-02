Return-Path: <linux-kernel+bounces-393515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB59BA19F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D21C20A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91201A3042;
	Sat,  2 Nov 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IenI1sCz"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66093199E8D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730567969; cv=none; b=SwR+sDDGmgy4qHKoGdo3xBececxxti31W4R6zacQY/b2A4UYGXOvRVMvQ6kMd8jaFdYvAX/5MadRB+j9/RxXRhY6xm69JEMYWLa0xHzghiVBbt45FXPDTGOpyBMGfVx3E2YksjVcPNnoUbnk5TuZ1+qWl8sCCUFDokF4MIjJ/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730567969; c=relaxed/simple;
	bh=CKJSm4gUJEGQwBQWE4FWt2PDmOXHXmHQvV4G7nxVhz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrFSAUgFef+wsW4iXjf/lV8IRQpODaGWyvxHQJnfeneYmOdDL/TEDm7FNaMDV72VVzd7XInOi8tdDmtqehnk1LlG17uNVZh7aahg+3NF6G4UoWm8+65Ht0LTY/vY9In1gtJ0i1ETD5kAOfSWTj0A4+AeJF9thN0O8c98Y+Kfn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IenI1sCz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so2202962b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730567967; x=1731172767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTkV1XhxJ09OcLM/uZ+nNnIbHFyaFXru4on3d7CL7wo=;
        b=IenI1sCzBhqVPKSx2kZNWkUNeLM4Vi0F7ZpJMvwS85J4XUxqdbiSA/QrMd6qXiQ1oo
         5SqpOWcxlGYSQT1lFKnJsJUiTdNdKeSRMnmzcM5v4aju1vDxPFBaaNwLhaIsZVNtNc++
         VBHAN3+1mmke1VMstuCxnpSODa/9qN8v4QnrtfNWkaCYs2rISRI9aHs57oDKODBIOl2V
         320izrrGJRLmb+Zc8A7syDIJWZjZvP1OzcrTJtd8YWZ1M50VHT6ZSGsGE+/e6qVH4uQk
         OmyvFQjcxIyO7dDD81xsaaUEYdK1+8v0DawN81WsOI5stMVU2HyEXb76/5Q3jUEGsoXs
         3gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730567967; x=1731172767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTkV1XhxJ09OcLM/uZ+nNnIbHFyaFXru4on3d7CL7wo=;
        b=OMIend4jtW+2cuTn8WUUQqN2rMFGC/SrPf0RJtjgyaTROLMe8vDRu4g7QcojRPfPC3
         feLx84jnH5MPmU95EgrjRuSl3jrk9SmvnWkGaqAdncnQdeo5adbq8esb0AD2/JT2es9L
         aU9u5ktdFAVlkz8Lsrkw0NS0EBiIzpprRWNSkJm4cGvfdBemQf7/BtFByv9SM4HYMC8A
         abMDWrcLNtgzM2j7kjGhdsGXRi7LRXWkwaw/ntO95CdYvTrkmuAUrrLg0ggG5Aret271
         3mWJphIPsZmbzEFSt1aFA3AgaWCOt7IBEB0ng7uzh6fE0ZA2pfn+J2izn2QnHmeZzNok
         apdw==
X-Forwarded-Encrypted: i=1; AJvYcCUqMfTrvJ7vx3qwGy8q4MLV5aG41PGNyi97YPxDxGndS+6ynSQ11nAJMYBn/XKRS+8hEVLvHqyLZWMiQXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgSBP8fSG1b599tNX77q07RRcSxWwYt3FapDZprL953RvI0x1
	xeHkQN4xmKebBi3XnorWYImhnac9V10APbxwEl0U0VVZ7vWsWIz+ca42ENDAyA==
X-Google-Smtp-Source: AGHT+IFi1cxAsGDs0F8dOgqbrOdXX0s1cA0y/1pfvpYVJz1F9v26FArl0PbmywggQPgDHROhLbLBZA==
X-Received: by 2002:a05:6a00:811:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-720ab4c705fmr20397800b3a.28.1730567967567;
        Sat, 02 Nov 2024 10:19:27 -0700 (PDT)
Received: from thinkpad ([220.158.156.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5722sm4335321b3a.71.2024.11.02.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 10:19:27 -0700 (PDT)
Date: Sat, 2 Nov 2024 22:49:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org
Subject: Re: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Message-ID: <20241102171920.epjf3j4pkbb5u4xq@thinkpad>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
 <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>

On Wed, Sep 18, 2024 at 10:13:06AM +0200, AngeloGioacchino Del Regno wrote:
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
> 
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 66ce4b5d309b..8d4b045633da 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -28,7 +28,11 @@
>  
>  #include "../pci.h"
>  
> +#define PCIE_BASE_CFG_REG		0x14
> +#define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
> +
>  #define PCIE_SETTING_REG		0x80
> +#define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
>  #define PCIE_PCI_IDS_1			0x9c
>  #define PCI_CLASS(class)		(class << 8)
>  #define PCIE_RC_MODE			BIT(0)
> @@ -125,6 +129,9 @@
>  
>  struct mtk_gen3_pcie;
>  
> +#define PCIE_CONF_LINK2_CTL_STS		0x10b0
> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED	GENMASK(3, 0)
> +
>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
> @@ -160,6 +167,7 @@ struct mtk_msi_set {
>   * @phy: PHY controller block
>   * @clks: PCIe clocks
>   * @num_clks: PCIe clocks count for this port
> + * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>   * @irq: PCIe controller interrupt number
>   * @saved_irq_state: IRQ enable state saved at suspend time
>   * @irq_lock: lock protecting IRQ register access
> @@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
>  	struct phy *phy;
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> +	u8 max_link_speed;
>  
>  	int irq;
>  	u32 saved_irq_state;
> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	int err;
>  	u32 val;
>  
> -	/* Set as RC mode */
> +	/* Set as RC mode and set controller PCIe Gen speed restriction, if any */
>  	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
>  	val |= PCIE_RC_MODE;
> +	if (pcie->max_link_speed) {
> +		val &= ~PCIE_SETTING_GEN_SUPPORT;
> +
> +		/* Can enable link speed support only from Gen2 onwards */
> +		if (pcie->max_link_speed >= 2)
> +			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
> +					  GENMASK(pcie->max_link_speed - 2, 0));
> +	}
>  	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>  
> +	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
> +	if (pcie->max_link_speed) {
> +		val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
> +		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
> +		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
> +		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
> +	}
> +
>  	/* Set class code */
>  	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>  	val &= ~GENMASK(31, 8);
> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  }
>  
> +static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *pcie)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
> +	val = FIELD_GET(PCIE_BASE_CFG_SPEED, val);
> +	ret = fls(val);
> +
> +	return ret > 0 ? ret : -EINVAL;
> +}
> +
>  static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  {
> -	int err;
> +	int err, max_speed;
>  
>  	err = mtk_pcie_parse_port(pcie);
>  	if (err)
> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	if (err)
>  		return err;
>  
> +	err = of_pci_get_max_link_speed(pcie->dev->of_node);
> +	if (err > 0) {
> +		/* Get the maximum speed supported by the controller */
> +		max_speed = mtk_pcie_get_controller_max_link_speed(pcie);
> +
> +		/* Set max_link_speed only if the controller supports it */
> +		if (max_speed >= 0 && max_speed <= err) {
> +			pcie->max_link_speed = err;
> +			dev_dbg(pcie->dev,
> +				"Max controller link speed Gen%d, override to Gen%u",
> +				max_speed, pcie->max_link_speed);
> +		}
> +	}
> +
>  	/* Try link up */
>  	err = mtk_pcie_startup_port(pcie);
>  	if (err)
> -- 
> 2.46.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

