Return-Path: <linux-kernel+bounces-544241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03548A4DF34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA13B467F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892B204699;
	Tue,  4 Mar 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjmT5HUk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8C1FCFCC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094737; cv=none; b=U23r5fg8XIQACFRZXkRErdVSFP8SzYmWBD28YZA3/eazzggQ/mNUOucH2wtDU48MSEy4qU6dJRNrpL1ZgXcGzmljYORHtmgbA3lHo0rSMFupPb2upbJA2wyK0tyrPgzpTU5Ny1DnAO0aw45XA0pX96k95poGN+d5uGhGmRSWjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094737; c=relaxed/simple;
	bh=hrg5TRRNBdLUQ2zHXbLHEUeFopncg9X6mHK4DEu8vEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw9LGb5YAFDENJ6b4cXQB4Z06AfRmRTPqQ4R5AMNgNsJG8PMVqFKgqt7dKkYQKFP5a8awNPx1sJz2HOxKQlvCzamrAXBZLwtSb471tui4dfZbA0hfPkxlmETOksUJuJqtxmU8/yY4M9aoHq65X/47urSStbossSdGna/Srj4vXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qjmT5HUk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so8957789a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741094735; x=1741699535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zRzp39M4FPV3rBLrWF5aPlMpMnqpUTW4xLGh7q0S7c8=;
        b=qjmT5HUkZatu/IaG1QbzTq5fJIjV/z3LvkdNtNELWOY56VCjtZzP1/a1scr5uZ8UqW
         IQls4t5lAe2/gScJnTooK4VOpQ0w+K72LquK8sZ59+OZnE4WZ8el5CZvrKNvYYArrPyC
         FpSV2R8JnOaFQlTrmULiAKoPOwJBa43GOUt62WtxX7gQ5GsfENig9IWA55ESXeQWF6bT
         8MYCPa41oZc8dNKsdd36ZOo4BnTvKo+VhuNCjak5Kn0R+bpzr52g7yUlkMrWjFNXzNar
         CAWB81wrWwjmSVjYRrQ+hYCkLX/XPs+ZGAe5C2xREEJGP6mNlx2k6mZokXwrYsQP8YKW
         3VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094735; x=1741699535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRzp39M4FPV3rBLrWF5aPlMpMnqpUTW4xLGh7q0S7c8=;
        b=hh0b/u7d3AIUYqHYd4wcI5pOUI60J5mzb+noxw68kMxbTVtpE6oOlKQDiws9+bf6x5
         lfIpvBGLz1W+Fpayn2RDZuerJYm82YkASysvqfeU/tiMqZwQuEuR21K+hS8CLyDe88Zj
         sLZLTLb7bA0rluX5Th/WN4Y4XatmrqbAQISuYtW6S57UFt9+I6ZKHQtvZO4rmg59pkeH
         z6i6HxGMOpkidXGTf5J7kQKSisUJyqymQf2WW0KCB8VY4nU2SAyKLC0LXwERkHM7Sdg0
         FHw+iZ1Cy88WDc2r0VgorCMij6TlOMYWUJ8uvZ4cl2VFDPb4H0jG5SVezVm5uDrAaNRW
         StDw==
X-Forwarded-Encrypted: i=1; AJvYcCXYyoqJEb4vzMlQ4UIlT7LVF42bb4TxxRrL++2m7jt88n0iFSB0ki52cVhspFP4tJYrfZwqegPQh+F3c0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4NXe3r1AGljkKaeCFP7WHp8KiSMJJ9RGlPFtI7BOthu/mFu9
	tZut84BM2y5aF9ROsZhW/x5e22GnD8uMjKnd8kjRm4KNLDd9iFJU1oZeWlR+fA==
X-Gm-Gg: ASbGncto6u4umo89ihFHo1cxh9msF/9U4qQDvrpWAOm/aolEJ6kBM2+3bC8MZ0Z0w65
	8fCU7kfaNjwiUTxYNAoUd9SLP7hJAVeCT9RmxsGpT78Wa8q9UekJ92yQ3R7VKlHll2pA5wiN3Nn
	IRp00PmAcJktBW1tFFC7RWPp29as4za+3NibAcJ+FMZJxH3ub2B7nF68lGHiT3a4FUvVwXeyLnE
	e8xhzQ29hcrQ3d7BDCtzE1aGoYF4n/PMk3ogqSMUfZBP/XFOBh9tykjPfMF1ic/K1LOok15HcUE
	DoTBynrVtu0dN8th/GUwjCqxnU2Aw9tGw6Pxlh5xoOiznd4pGi1X25E=
X-Google-Smtp-Source: AGHT+IGMgJGJf8roiOEdiQxTQJjbdJo8uZPWuNkxO43X2UqljjgGxIyM2jVruHLjEl9BEsxN4NrLWQ==
X-Received: by 2002:a17:90b:4a01:b0:2fe:9fd4:58f4 with SMTP id 98e67ed59e1d1-2febab78d41mr29375712a91.16.1741094734730;
        Tue, 04 Mar 2025 05:25:34 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98f2sm13028887a91.7.2025.03.04.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:25:34 -0800 (PST)
Date: Tue, 4 Mar 2025 18:55:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Message-ID: <20250304132527.gu3husgouddth4x6@thinkpad>
References: <20250227042454.907182-1-sai.krishna.musham@amd.com>
 <20250227042454.907182-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227042454.907182-2-sai.krishna.musham@amd.com>

On Thu, Feb 27, 2025 at 09:54:53AM +0530, Sai Krishna Musham wrote:
> Introduce `reset-gpios` property to enable GPIO-based control of
> the PCIe RP PERST# signal, generating assert and deassert signals.
> 
> Traditionally, the reset was managed in hardware and enabled during
> initialization. With this patch set, the reset will be handled by the
> driver. Consequently, the `reset-gpios` property must be explicitly
> provided to ensure proper functionality.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-2-thippeswamy.havalige@amd.com/
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index b63a759ec2d7..6aaeb76f498b 100644
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
>    - "#interrupt-cells"
>    - interrupts
>    - interrupt-map
> @@ -75,6 +79,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>  
>      versal {
>                 #address-cells = <2>;
> @@ -99,6 +104,7 @@ examples:
>                         reg = <0x0 0xfca10000 0x0 0x1000>,
>                               <0x6 0x00000000 0x0 0x10000000>;
>                         reg-names = "cpm_slcr", "cfg";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
> @@ -127,6 +133,7 @@ examples:
>                               <0x06 0x00000000 0x00 0x1000000>,
>                               <0x00 0xfce20000 0x00 0x1000000>;
>                         reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
>  
>                         pcie_intc_1: interrupt-controller {
>                                 #address-cells = <0>;
> -- 
> 2.44.1
> 

-- 
மணிவண்ணன் சதாசிவம்

