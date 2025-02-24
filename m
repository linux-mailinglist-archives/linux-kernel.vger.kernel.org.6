Return-Path: <linux-kernel+bounces-528261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874EA41595
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBFF188FE18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22020ADC7;
	Mon, 24 Feb 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfoVZOt6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B732C85
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379339; cv=none; b=O1CCA3D2vv+jwslcyMeLZziYVr85ayne8pkRClwLbSasrFxJZ4GbQPRWlThBx7VkRHxuYcoT1MjaenoSE57Yjb2fhkM4QwCcmV+fIvQIGkQwFC28fVUNBjjoqsbmO5U7bvoKxTlJ+oenDr28Yx4hPfRbPZAXGrMLyUoJcYj98RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379339; c=relaxed/simple;
	bh=MUfIUGq0ySzAISvgyOFVfUeCEEOxUBftBO46J9gwf9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csGIN9OwFdnd9IogzeI/StGVvorFItgyionQyRx/y2WNicTyp8pbFnAf9lqkl3jt6K8ADc68dRDK5zpKif/CWLhhyIQsS/oQzGUuwMlDw9XFZLOYbgcEJ90FyTm/aIV5KOusKm6reJISjebSLsJpXcDvs8XdoR9oR46NrEopT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfoVZOt6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22128b7d587so74785515ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740379335; x=1740984135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kq6DmAc1mPgZsYnLbQg4+lsGkwNUTX+i9eYRvcNTn0g=;
        b=MfoVZOt64k+uHgBnm5k1uxLXN9yjOheACAXckcnkTXvKkXlbb+pXCJJsI7SNufR+Fs
         mGd11v39ZOqREuUbpP6bPE/yK0ZGlDh7gnV9ramkcGMMKZgTWvKlx7hW2ZfOu98/CbyR
         e/ioAloT5yPgRdC80uK6ghgvTM6gmSy530+RGOCRJt5A4gc28RdYOahFECxv8VGbmUJN
         ZC3qNZN2NMeTn54YsYrq9usifV2q6g00EbM4p0x0I7rIP/S0SUwzfxiLN4XZ6uVqsnVs
         rtLR18IFLV4Jx4C7LafhBUwyLUA5AfEjOj4DpkLOjt1FEYAV1AFa/VLx+YY+oyqeXDx4
         im6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740379335; x=1740984135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq6DmAc1mPgZsYnLbQg4+lsGkwNUTX+i9eYRvcNTn0g=;
        b=OECF5QucyidmG2dDiR2mceGX2FuRT1QHy1wAU+s5O0a4lQNUtjdCI28oXIRoeLL54I
         zAXSuiS8x62GJpdYfCRwoFVT29rc58JgSJt9hJ+cwoK++SoCrU4/mFK5Dut7tPGqLykX
         +MLNQ0Ya/fK/1Wa6+gKodfkM5nNWgnZZlurlkMp28okQzFDDXHmBdUmdZiBoUcwd131F
         7qPGi0yKobh01PuUjnladLLYhfw26BHGt1mXTyRVLs03zijfbaUZBWiJpUCA59liB/6f
         /sAqMBerD0YTiec4IAB5rEZlgHbxpVuQQtz5Ug3VRwFVDgFa3BO3qsZcYdDRnBxLHg0U
         aQJg==
X-Forwarded-Encrypted: i=1; AJvYcCVHM8IqlUSfEu6kA+w0DTxxVeiP10aW0z071EKAxAlu1PJSkWtEQpA8fYUY37PafsfVjayHjOXM4joQ4G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4iwC3aq0dfk5ZPY+AMXcLEW7diwqxoIva3X3vdtUX8xA9Lgq
	pu3uOGCOR3jBqzThmi7f5Hq+hAN+9B6RXTJkeKbLZGOh9GKxqmnsUFMraAV8YQ==
X-Gm-Gg: ASbGncugGmXyeXHxErd1fV/QnsjumkDuQ+Gfv6jQfbYYKimuHlV8eoKgafoIjcEMbT7
	bs/rOZshs2cH4L3Kgj8U11fSVzBiK+JmyHtF/+eKIxuo73+ilQL05dTRUyL4Pmc9EPbm2JAkcHy
	H4jNhRKaiktXhMJ4nth6xyaMqGgqiV1gqmk0bQI6LIXnasVYSxrrsIXLyCc5fouxlWmis+affXr
	Kb4KR9srPOAy1qF9bOrxfeENd/HpGaojYvoXigAi7GKk50RJF2lUpDRir3VJYbKvXYU2hF0Iz7j
	vxDTcg9RPA1EiAVd1yQx2FqyZ9nBEoNjOLcH
X-Google-Smtp-Source: AGHT+IEwF+vLY+LCfHIZyqyr7Gb87PMyqsVhLzbCXy50uOwdx1qsfBGxMboeEHIMM+6rTzgy8eBxrg==
X-Received: by 2002:a05:6a20:d491:b0:1ee:c463:23cf with SMTP id adf61e73a8af0-1eef3c770c6mr22195316637.13.1740379335667;
        Sun, 23 Feb 2025 22:42:15 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5870e862sm18223894a12.44.2025.02.23.22.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 22:42:15 -0800 (PST)
Date: Mon, 24 Feb 2025 12:12:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Message-ID: <20250224064209.h7te3o3vhcf33alh@thinkpad>
References: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
 <20250224063046.1438006-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224063046.1438006-2-sai.krishna.musham@amd.com>

On Mon, Feb 24, 2025 at 12:00:45PM +0530, Sai Krishna Musham wrote:
> Introduce `reset-gpios` property to enable GPIO-based control of
> the PCIe RP PERST# signal, generating assert and deassert signals.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-2-thippeswamy.havalige@amd.com/
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index b63a759ec2d7..293ed36d0cea 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -33,6 +33,9 @@ properties:
>        - const: cpm_csr
>      minItems: 2
>  
> +  reset-gpios:
> +    description: GPIO used as PERST# signal. Please refer to pci.txt.
> +
>    interrupts:
>      maxItems: 1
>  
> @@ -63,6 +66,7 @@ properties:
>  required:
>    - reg
>    - reg-names
> +  - reset-gpios

This is an ABI break. If you make it required now, old DTS will be broken.

>    - "#interrupt-cells"
>    - interrupts
>    - interrupt-map
> @@ -99,6 +103,7 @@ examples:
>                         reg = <0x0 0xfca10000 0x0 0x1000>,
>                               <0x6 0x00000000 0x0 0x10000000>;
>                         reg-names = "cpm_slcr", "cfg";
> +                       reset-gpios = <&gpio1 38 0x01>;

Please use proper defines in include/dt-bindings/gpio/gpio.h for the GPIO
polarity.

>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
> @@ -127,6 +132,7 @@ examples:
>                               <0x06 0x00000000 0x00 0x1000000>,
>                               <0x00 0xfce20000 0x00 0x1000000>;
>                         reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +                       reset-gpios = <&gpio1 38 0x01>;

Same here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

