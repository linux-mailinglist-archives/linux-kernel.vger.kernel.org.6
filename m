Return-Path: <linux-kernel+bounces-289160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2395428D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCE1F22748
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CB126F2A;
	Fri, 16 Aug 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slELu6+L"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06282C8E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792658; cv=none; b=kNWLU1RbSjadl4edSvZVDDq8xQd5hgnPbBeaBlZ6HnzX/4l+hYn7Jj1ZV5yfsvUpb+FTmoO1Cdd5oM/jpXQTsVXYDq/N3CG83pCeJZFkTWoHBgluu5e5v0ge2EvPFFCsTC4Bwj8JCsWoEHLb5+GlPlI474/vvXltfD8wVp09EBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792658; c=relaxed/simple;
	bh=VFcqDuwbb1mS0aCP+juK7aY9YZYGb2PrM9d03V2DQaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahNb0H2Lj6bugHGHwp5TDWUhUdP8QXjeCnS716n84zy5ldp9pqJObdB3/9n/fXyZvsHr1LSdnJ71Zq7IpwV17/U3RWgbXfNCqjgyRttRM87EkU7u+9zLIvdVtjZj6tKNhWDZYwsd9FKv3gnZB/pXmJNFhbCWIk6RWPIR8ywVfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=slELu6+L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710cad5778fso1458011b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792656; x=1724397456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CeC8mjQI9mRuC2JdpWZ62HhXL0mgU7iY1ydTgTfi4uk=;
        b=slELu6+L3DW1IdMvX3j+AxOqyQb2FC8HsjTArrIe18Jbr/4S6NYLIpzTcRd5nI8e4M
         8W/17E7pvXqRlhGmmhj2pvODGbGCmP9qLnOPwb6yTTeEPWuzkbrqxwPSMGvq4ewJ4gvU
         rQduZIleYOR8xxPwZhoyd6YqfCDvrM6L18UVt+EuRXuG+WWzpuzO4DhSvBO1WZQtA5FK
         nkVFKCLR8VR7rSx/X3fck/ahYRWXvbbt5D2d3bpEGsU6zX0rZ5BQAvddcsKxu0RhI6vc
         qtMgfuHf3PWJPbGgzp2MN0D0HqMAA382QhrzE1wxX3qa0XRfHP5u2t9aVRvr4bP6CMOK
         Y90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792656; x=1724397456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeC8mjQI9mRuC2JdpWZ62HhXL0mgU7iY1ydTgTfi4uk=;
        b=Mh7ez5VIcusS7MeZlaFqz+fCMZeeJzTblRJ7NdUthmrxL2NaOAjtO/i43iQZlhvc/x
         nBw7kOU5pXmUWNHE1KegGUK3PPUSjidAK951TOfBIqI+bslL6jsubOTZUNJ/3sGUR4rC
         jVXn75IWcT+f8rxuuzvuYcLtED0DwYPe9ePUCsSM+a9E3E/ZT0IAZ9MYLYAMrXieK+G6
         v/Y/Ikvk58D9bQ+MoMo4SEKtEDLo/c7aF8bS0KjH/54KwOWlygV01ItFj1Jm/3jlzHHz
         6iHKoAmWOl32R/sJVqRQBb/Whqw2W5iYvnvjVMdTNKLEnzq6OaiTXiE6xefYKFaUN84x
         wUeA==
X-Forwarded-Encrypted: i=1; AJvYcCXTMjj3dSZIulB8nGP4pOOe7rKi1s6og+yvXqVcLaeAlFss5xjfMaIiSL4aeBo4VFIHh30pwYn4QzW/qqP88FzIklz5PgUaGZZVnDJ3
X-Gm-Message-State: AOJu0Yw3swH48T+jipFFnCuaYjP8ihnKbHs0silAUpdHvt3czY1hr/Nc
	49hzz3vA60qEJsAbCbQ0VRshO6pUMU66U4A3x3PVQi572Z5gqUDU3LBdu3Nj7Q==
X-Google-Smtp-Source: AGHT+IGKLvQtGvO4lzGIbWD3EY/i3WZJIYkvPxiLMSnRmqwUy9frZivlpbQNfsvhRvaFBhms1yPX1g==
X-Received: by 2002:a05:6a00:2d15:b0:704:2563:5079 with SMTP id d2e1a72fcca58-713c4f3426dmr2892107b3a.27.1723792655800;
        Fri, 16 Aug 2024 00:17:35 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6364e76sm2342468a12.81.2024.08.16.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:17:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:47:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 12/13] PCI: brcmstb: Change field name from 'type' to
 'soc_base'
Message-ID: <20240816071729.GN2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-13-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-13-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:25PM -0400, Jim Quinlan wrote:
> The 'type' field used in the driver to discern SoC differences is
> confusing; change it to the more apt 'soc_base'.  The 'base' is because
> some SoCs have the same characteristics as previous SoCs so it is
> convenient to classify them in the same group.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d19eeeed623b..26e8f544da4c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -218,7 +218,7 @@ enum {
>  	PCIE_INTR2_CPU_BASE,
>  };
>  
> -enum pcie_type {
> +enum pcie_soc_base {
>  	GENERIC,
>  	BCM7425,
>  	BCM7435,
> @@ -236,7 +236,7 @@ struct inbound_win {
>  
>  struct pcie_cfg_data {
>  	const int *offsets;
> -	const enum pcie_type type;
> +	const enum pcie_soc_base soc_base;
>  	const bool has_phy;
>  	u8 num_inbound_wins;
>  	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> @@ -277,7 +277,7 @@ struct brcm_pcie {
>  	u64			msi_target_addr;
>  	struct brcm_msi		*msi;
>  	const int		*reg_offsets;
> -	enum pcie_type		type;
> +	enum pcie_soc_base	soc_base;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge_reset;
> @@ -295,7 +295,7 @@ struct brcm_pcie {
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
>  {
> -	return pcie->type == BCM7435 || pcie->type == BCM7425;
> +	return pcie->soc_base == BCM7435 || pcie->soc_base == BCM7425;
>  }
>  
>  /*
> @@ -861,7 +861,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	 * security considerations, and is not implemented in our modern
>  	 * SoCs.
>  	 */
> -	if (pcie->type != BCM7712)
> +	if (pcie->soc_base != BCM7712)
>  		add_inbound_win(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> @@ -878,7 +878,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  		 * That being said, each BARs size must still be a power of
>  		 * two.
>  		 */
> -		if (pcie->type == BCM7712)
> +		if (pcie->soc_base == BCM7712)
>  			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
>  
>  		if (n > pcie->num_inbound_wins)
> @@ -895,7 +895,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	 * that enables multiple memory controllers.  As such, it can return
>  	 * now w/o doing special configuration.
>  	 */
> -	if (pcie->type == BCM7712)
> +	if (pcie->soc_base == BCM7712)
>  		return n;
>  
>  	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> @@ -1018,7 +1018,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
>  		 * 7712:
>  		 *     All of their BARs need to be set.
>  		 */
> -		if (pcie->type == BCM7712) {
> +		if (pcie->soc_base == BCM7712) {
>  			/* BUS remap register settings */
>  			reg_offset = brcm_ubus_reg_offset(i);
>  			tmp = lower_32_bits(cpu_addr) & ~0xfff;
> @@ -1046,7 +1046,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		return ret;
>  
>  	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
> -	if (pcie->type == BCM2711) {
> +	if (pcie->soc_base == BCM2711) {
>  		ret = pcie->perst_set(pcie, 1);
>  		if (ret) {
>  			pcie->bridge_sw_init_set(pcie, 0);
> @@ -1077,9 +1077,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	 */
>  	if (is_bmips(pcie))
>  		burst = 0x1; /* 256 bytes */
> -	else if (pcie->type == BCM2711)
> +	else if (pcie->soc_base == BCM2711)
>  		burst = 0x0; /* 128 bytes */
> -	else if (pcie->type == BCM7278)
> +	else if (pcie->soc_base == BCM7278)
>  		burst = 0x3; /* 512 bytes */
>  	else
>  		burst = 0x2; /* 512 bytes */
> @@ -1676,7 +1676,7 @@ static const int pcie_offsets_bmips_7425[] = {
>  
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= GENERIC,
> +	.soc_base	= GENERIC,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound_wins = 3,
> @@ -1684,7 +1684,7 @@ static const struct pcie_cfg_data generic_cfg = {
>  
>  static const struct pcie_cfg_data bcm7425_cfg = {
>  	.offsets	= pcie_offsets_bmips_7425,
> -	.type		= BCM7425,
> +	.soc_base	= BCM7425,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound_wins = 3,
> @@ -1692,7 +1692,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
>  
>  static const struct pcie_cfg_data bcm7435_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM7435,
> +	.soc_base	= BCM7435,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound_wins = 3,
> @@ -1700,7 +1700,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  
>  static const struct pcie_cfg_data bcm4908_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM4908,
> +	.soc_base	= BCM4908,
>  	.perst_set	= brcm_pcie_perst_set_4908,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound_wins = 3,
> @@ -1716,7 +1716,7 @@ static const int pcie_offset_bcm7278[] = {
>  
>  static const struct pcie_cfg_data bcm7278_cfg = {
>  	.offsets	= pcie_offset_bcm7278,
> -	.type		= BCM7278,
> +	.soc_base	= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.num_inbound_wins = 3,
> @@ -1724,7 +1724,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
>  
>  static const struct pcie_cfg_data bcm2711_cfg = {
>  	.offsets	= pcie_offsets,
> -	.type		= BCM2711,
> +	.soc_base	= BCM2711,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.num_inbound_wins = 3,
> @@ -1732,7 +1732,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  
>  static const struct pcie_cfg_data bcm7216_cfg = {
>  	.offsets	= pcie_offset_bcm7278,
> -	.type		= BCM7278,
> +	.soc_base	= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.has_phy	= true,
> @@ -1789,7 +1789,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->dev = &pdev->dev;
>  	pcie->np = np;
>  	pcie->reg_offsets = data->offsets;
> -	pcie->type = data->type;
> +	pcie->soc_base = data->soc_base;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> @@ -1867,7 +1867,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		goto fail;
>  
>  	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> -	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> +	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
>  		ret = -ENODEV;
>  		goto fail;
> @@ -1882,7 +1882,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
> +	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
>  	bridge->sysdata = pcie;
>  
>  	platform_set_drvdata(pdev, pcie);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

