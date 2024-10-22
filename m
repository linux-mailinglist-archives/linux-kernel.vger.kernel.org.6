Return-Path: <linux-kernel+bounces-376640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A19AB449
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD881F235A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261CA1BC061;
	Tue, 22 Oct 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEHAGO7t"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2049256D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615573; cv=none; b=QhpqKLyyZ7W0U1YiGXCq0pyirudz9txX7iZD6tvDK+M+WrKnItii/OP9ZLk2ZsPvNg+WU7yyNVst2JTzS3pfy6SQonSG+YlyyTzLluqN2XpxhATr1CO0Rox8WZQKkzNAqgumG6+NCPlCNRNoKUmrrTVIm/Hx0A78Ihweec0VNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615573; c=relaxed/simple;
	bh=Lj6PNMCNIu8hj4OyaUbUFkAeau2NGIb0esj+zs559b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e40dwycIKeAIDhEE54mKG26JpplUbZutHAf9EYn2xYfr1MyE0RUpwC9qeFT2qBCqWXN8GFAqlDFpL+vNrGNcBLwj3pU0wnRWygaa9YDxf9vKSyMqRlE+SPpDQ0PjNEx19I2wCXX1P96WZeji5UIP0yTUGxO8F99nuiDkjhfjRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEHAGO7t; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e52582d0bso4460455b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729615570; x=1730220370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPeTnArfy3kVD9qdVEi17t1QYmpfbQ/+MP9HcRzS7Mw=;
        b=JEHAGO7t9ZbxGNMC34L2qNsuOY6jYy5CbdJV4rHwsDt4APCLljxpPcXJDzubAdwDcg
         Q2SUUjAAnWGodDVdBqR/R6fbV3fDZw3ffIDykc8fNZWVOl+Jq/SKh8VhFN0mYQCI6qXs
         x3XVYG99yZaV7UUOQLrNcYudD3vHwgIrNbThgb6hxwTkmBdmgLDAtluB7MP/2EaEioyO
         kazudFNF3wbt2r+YNpPgAwvs+jCudWdA76cMrlgng6Pf6qK6zwpRw5moH5gEIclXAeu1
         3w21u7Jg5oeQ7q+miDvhGX6gi7uSSjJHyn/VYZqT6PX9Sz2t+J7g+VPoMnCZJ4TssW1X
         MLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615570; x=1730220370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPeTnArfy3kVD9qdVEi17t1QYmpfbQ/+MP9HcRzS7Mw=;
        b=mmzOW4IN+J2JrkWIY1gsOE2JC1wHMB4xNjKEV+x7Sa8ULTa3GWSLiRLxJTh+xwsyUr
         JvVVeae1etfsfjYZHI7OW1W9Z5ORLcWhEUxQ3uLopaw3qRhJl7R37MO66IdIxUAEZLvl
         sVb8JHqoWl1+0gbQgwIeRKKVc3MBde+UX/Sfd0xUW2XkUOpwJiw+Lzgfpg1+41H81MkA
         93NZUsq6oAYuXSMunJWnm5X9lTtr43m3CItep4mStSdtkzGYO7DgX9mOqQhDqIlxckzT
         B5i2y+LFLx77BDEa5DTj70R687H/jXsvLBXGeje0gWfb884DbEjXYpfNUX7Nj6D/ZUac
         fjXw==
X-Forwarded-Encrypted: i=1; AJvYcCW9xbNbd7kKcIwJkmfXwVGCLtJEsSkkJF3H7SCljl5YLbyqU0iSgpSazU6Uvg6OJROuHktjr9rKZ9SkgHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2SvsixRpyTzqhlq0ClBAzscEcw89WgHxy/FgE1e4CfOgZCRe
	MIPS6aDre54G1U5ZnFQGiQJEJS/BBlIY8M5qIK4kmZc3KsBmGtLQQ03NNEgfVg==
X-Google-Smtp-Source: AGHT+IHTS9yyMdGSpDBkN1ZywG4L881bK6lpw9juFK/sdg8K6E7YS49sKlIWRIuG+HaxSkMO8HbgaA==
X-Received: by 2002:aa7:88d4:0:b0:71e:b8:1930 with SMTP id d2e1a72fcca58-71ea321e7famr21475298b3a.16.1729615569937;
        Tue, 22 Oct 2024 09:46:09 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13336d1sm4966249b3a.56.2024.10.22.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:46:09 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:16:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kw@linux.com, bhelgaas@google.com, lpieralisi@kernel.org,
	frank.li@nxp.com, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
Message-ID: <20241022164603.gndz4vgbm2sgwtfj@thinkpad>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1728981213-8771-3-git-send-email-hongxing.zhu@nxp.com>

On Tue, Oct 15, 2024 at 04:33:26PM +0800, Richard Zhu wrote:
> Add "ref" clock to enable reference clock.
> 
> If use external clock, ref clock should point to external reference.
> 
> If use internal clock, CREF_EN in LAST_TO_REG controls reference output,
> which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.
> 

So this means the driver won't work with old devicetrees. Am I right? Then you
are breaking the DT compatibility.

You should make the clock optional in the driver.

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f105417..52a8b2dc828a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1480,6 +1480,7 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
>  static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
>  static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
>  static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
> +static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
>  
>  static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
> @@ -1593,8 +1594,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX95] = {
>  		.variant = IMX95,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> -		.clk_names = imx8mq_clks,
> -		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.clk_names = imx95_clks,
> +		.clks_cnt = ARRAY_SIZE(imx95_clks),
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

