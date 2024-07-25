Return-Path: <linux-kernel+bounces-261757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E6F93BBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4689EB23774
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAA18046;
	Thu, 25 Jul 2024 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUxOa+HB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3417C91
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882249; cv=none; b=WzK+ZvwHniLQkkVf491P260JVPBU9MMVAlZEu/+FKDkSnVIWI820RlEDumpa+LbmY8i2U8sZqmi2YcOF5BlTuPZ5kOLwM2dnp8BHn3SnDa98CsdcI/w0/n2yl+zsRvrF65R/dDN4iAv0DB49I0YfgaJXYYO6yM0mpTyRyIA8L6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882249; c=relaxed/simple;
	bh=nQ+RJQHyfq63tZOKYOqsxP8VydZPSKB+6877TeGYgio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChW45ox5JI6BfXRPbD8Ge4Dte+bAfuGk7OdjZjXIk5Pa+EccIqj7Jr9i0mH/kKMoKkMHO93J4uLPWQUcAg02qltmXRiZaK0zwHiqEX4N1kGCf88U+pz1NwpFQsm7DaSZMFMGVv50+ojuV1TQqceC+n6f0pVrqGPWH8jjMDyfVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUxOa+HB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so365511b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882247; x=1722487047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1JZC88oKp8I89s655kcwpoA6y+G6A3ga7BdD3U4lzs=;
        b=NUxOa+HBG00K471GvLFQE6JMIxdeTHYD8pYpZe+5w8N6yux4Nvawu2MyRCDiVxuI37
         Q/IKMSrZ1g+LyvxfspAb/6JhCiRAWXL4ZM34iGfukmer/0xm8rTxDl2njcXraKCQvJhX
         C0mAJGfaH0FXjeFQUSrlJWa9FFEeqgUHuOy3vX+XA9Cg8dgFAsqkVnQQYnwEFxTDFf7E
         UUSHP/2E0uRGrR5B54QP+yhunPAKJZ39w5rsX9Yw8iERpKnIzMrXETFmFHCHCHOPIv9U
         Lhc+h9TKEREqU3HcUmpw1pKN7yHeZKPiqlslVZpZ/NwWWH4NhSwoQx2XkpaOlega9iRv
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882247; x=1722487047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1JZC88oKp8I89s655kcwpoA6y+G6A3ga7BdD3U4lzs=;
        b=kzSSSkUavM+6MetjCFzQHf7WGItWYZoEfugiQ60+t+lnKCevM8HiT2Klv3IwhWv9TC
         dX09TQenem4sN0dGLcCJoHHH31RLnrum2gu3X0HtFStX3U2Xu1NjXmwttrqHp70bi1KB
         riRTwf5B0EYJkfEM+g/1Dea1gMMpPCieJ4I8GimfGtAEpQdCYFYmr2f//3dfaOK/APrs
         LdBAxLDWmkukA9ozhU1GUzaPfIS0BFLpXk93PWEeaDH91XrPlRJEb3FkhaWbRadsEXTt
         nc/2CigF6dz7FEhABnvjYJkLvxhwu3yZJY3noVtj7il3EwGMYCFU/omCSl1Xh6Al0ZZV
         gMaA==
X-Forwarded-Encrypted: i=1; AJvYcCVNs6FE1M4Dg2jJBGA2nEzCtqQLpnFF7CmERESr7MbyBBJ9axxbGrwkwwfkZ5Hzz1ODi9wbQpJ90Rn7QRK+hxKm0Qmgsu348BYk0DP3
X-Gm-Message-State: AOJu0YzV/rRVJ71R65RRJJnksevqWswV6DNXFhpZOLSnX1ds3P6nK9XU
	lFAF0e+m6cmn16dolm5yr6smM9CVHHbzLR45XXB0T7XT9vIVsZFxSt1/C3tvlQ==
X-Google-Smtp-Source: AGHT+IHb2jiz9X2SslE25mDu/kpZvHi3w6d2thIeHc9lJAHRInMESIHfvCFleCXeNij5wye9qnJ6mg==
X-Received: by 2002:a05:6a21:328e:b0:1c3:b1e3:eb42 with SMTP id adf61e73a8af0-1c4727fb229mr2515129637.15.1721882246765;
        Wed, 24 Jul 2024 21:37:26 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ccd5adsm4291585ad.74.2024.07.24.21.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:37:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:07:20 +0530
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/12] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240725043720.GE2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-5-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-5-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:19PM -0400, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c257434edc08..92816d8d215a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge;

'bridge' is an opaque name. Use something like 'bridge_reset'.

>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (pcie->bridge) {
> +		if (val)
> +			reset_control_assert(pcie->bridge);
> +		else
> +			reset_control_deassert(pcie->bridge);

Well, these APIs will bail out if the reset_control pointer is NULL. So you can
just call them directly instead of if..else condition.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

