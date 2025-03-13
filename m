Return-Path: <linux-kernel+bounces-560018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05825A5FCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CA31892088
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EE2E3390;
	Thu, 13 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RW5ZPE6z"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67839269AF4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884802; cv=none; b=H4oIV0BsZaGlSOBmOz417aLNYgzXGn50LqCmjGrCMU7C9k5g4W2wYBlW/l8QI2ocrvSQgp484jDBMejeyUDDoqHOHg77oETMtfIwkb6RyYekabwpPWGqFDOlMVci9f10Osu5CgQIcRfp0wDcTVC6L7bcB8Phujhl83c3GJZFKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884802; c=relaxed/simple;
	bh=vwhTZJRxz/U4j6Fnzkv92NNO3NpiYFquEmYKurAYKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A39seXcW6w9OsSCkFBGAVRGxpopuROaMxrR/wvQvy+DMxc90rQ+6lfJFX6jkm0R5iUWTorGNVQnabbox9rkT02b31/1MI4P2798t9QXx3XXxnvUjz/uFAqMrfy9gqUV3z0QEsuftxX5RCkuyfI7pPAfyyQn23hxMah/BP33hZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RW5ZPE6z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so23367605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741884799; x=1742489599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVvf10Ck2ho127r39h3riZTqgWY3zjYMF5s83hBhWK4=;
        b=RW5ZPE6z8irH1KoF0hnYQffpHs8m/c/ALM2SXyC3OntO6Ij67BzGys14gUSuwPKR7D
         XLA+zmh6D0mYfX7wb2XtThnWEg/PFtgE3CAIoHJIP8kR5ZklubksuQ84GkY8O/TC9NaX
         dBi7eIG3fOKXtS1zhM8qtV61POjJGYWjyR3/YJ2q16SJ5JuLcO3ekE3Y7xEN3zekijMj
         3jQb34FnJIUTvwuV4Sur01NY8x2ww/8HmDhjNGsF3or+BKzW9v2GpHRrjWmGB2okKZf3
         dgmJ2Ira8+Uf+U9hXkJwtmdua1twkpkSBO7WTumh1P6fq591HFtOj6Xs8WpsH9PiSkQX
         C9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884799; x=1742489599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVvf10Ck2ho127r39h3riZTqgWY3zjYMF5s83hBhWK4=;
        b=GnZOa4Lclxcx6cVidwVSVlKryRzCPBhwVIs2JJaX4Q+vf76AycNlHKXpXIi4QGDZHH
         9ItxLvHfU1Hzm9m9mjCrRmiOVhu5eqPgzT9b7l/XT1nwGyT6Tpv4JzUE4z0RYuhCa6qt
         /aJ0vM0RmDqKjihL+fPiWH6F6SaCz7CcXg4Q45NFDtegndg5/YsCQUCgIkvaXB0VFvhT
         j1aLu+yetW1AEJNLBObKpZseWKBqHzR3kPwvaED8yJoe93xAwTJeHdgGrzFe5EFWz8i/
         SDc3qwjPpZ9lac28+dGqRHfAjY4kv8YhCSUntZnYqnXNRDKYXBC/LuK6HXuqRdLvj9lM
         tLow==
X-Forwarded-Encrypted: i=1; AJvYcCU5ClXQn1+Yceiyr1p5p1B6HBlIBJhi+LEtYNnR3bE0FbPw5ENwDaRJ10eMbJqRHEitGpptHWPJ6EnjxMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9p92oLN5sp7itYco2du+41IGgw6tqxlnQmUvMgxLcRc8hX+p
	WttL4k2b5NXbNLPeLcNVX5Ic9QZmJITaU8b4g24LjTgdaRdlOi9eP1cCfDlB2w==
X-Gm-Gg: ASbGncsfUkZSH7LhHr/YWP2VNyvzVg6enstzeuAZ8yFxONTbLKXGqiiYFb7vPUyqtqO
	vBy9o2zP26luSV7+AK5oseYmJTzbFimsXsKrwu4l+fCfkv7aNdOA9mcCEE2iQl3cjtwLJoc+SJj
	iBMn9x7NXRA1JQ3FAWgMZIJWBfJI2xJXMYN9KsbSbQIZ6EqJfRdS4a1Q43sluNjrrSx0kdMnryF
	Tc3cfXr8mAyFTsJWt/MrsurWTNAsz2Pk6Peer+rP6efB4/bnJ5UjmhriGdCHWRS0njdh8cJe1DM
	kOoH6g50Xd2PCEyL/9FVEnRfHpnKtecQZpTxS8mpAeyNsfZyehaG1g==
X-Google-Smtp-Source: AGHT+IFfcfuSPGO2mr5Ih54HzoCrJnTgSB49gCqwRuzftDvua6QaTJh101E/NjM3KLYPx8ydFXU52A==
X-Received: by 2002:a05:6a21:3a93:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-1f58cad4b2amr19998674637.6.1741884799320;
        Thu, 13 Mar 2025 09:53:19 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511dasm1605770b3a.60.2025.03.13.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:53:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:23:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>

On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:

If you want a specific patch to be tested, you can add [PATCH RFT] tag.C

> According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> 
> dra7xx_pcie_cpu_addr_fixup()
> {
> 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> }
> 
> PCI parent bus trim high 4 bits address to 0. Correct ranges in
> target-module@51000000 to algin hardware behavior, which translate PCIe
> outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> 
> Set 'config' and 'addr_space' reg values to 0.
> Change parent bus address of downstream I/O and non-prefetchable memory to
> 0.
> 
> Ensure no functional impact on the final address translation result.
> 
> Prepare for the removal of the driver’s cpu_addr_fixup().
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> index b709703f6c0d4..9213fdd25330b 100644
> --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
>  			#size-cells = <1>;
>  			#address-cells = <1>;
>  			ranges = <0x51000000 0x51000000 0x3000>,
> -				 <0x20000000 0x20000000 0x10000000>;
> +				 <0x00000000 0x20000000 0x10000000>;

I'm not able to interpret this properly. So this essentially means that the
parent address 0x20000000 is mapped to child address 0x00000000. And the child
address is same for other controller as well.

Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.

I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
shed light on this?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

