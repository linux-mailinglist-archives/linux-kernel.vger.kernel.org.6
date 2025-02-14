Return-Path: <linux-kernel+bounces-514510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B40A357E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F7416C177
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A318A6CE;
	Fri, 14 Feb 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2USEROi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE215573F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518239; cv=none; b=gjVR66L8lb2yEaohKjyXnQN8nVpwN8VpyDky90H9d8VFFNmw8O9grlcmWZCLMcSNLi/Yraysdf53So6CXxGNKq104gM4+7OikwmeO+r7rwH3/fMLdymph8DuyKV5j36CqgILq+4p54j8DZFXWZFWZqOm6rkRC2AAB+xCW8Q3hUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518239; c=relaxed/simple;
	bh=28rW3L+4nMWFL+nhXSzHh6pgOySV65uLWE7NC0neh+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7CJDRC/BH8X2FgNLZmghlvXEluubWwwNaoxUPU9nYMIT7p4AxEG+jnTY08O+3StKjijusknAIGPszJ9NWSDr084pyk1SvcA7tv21/Dw+uWkPnmyqEbMBJ6ixSbc2TSomRbTkMUt9MLS6mFiZd34zuiEJ5ekyA3sLJQlFxo9ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2USEROi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f5660c2fdso34931645ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739518237; x=1740123037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ws4LKbTJycmWRh3Ik4Ggj9kxLRFUQc51QCqp+xMN91E=;
        b=o2USEROiSFsMWKvAq9/RdDSAK4f94iZSNoF0qjH9antxgF+fwhRDpH7OxLUl8nVyRG
         LjmQaV1glqmyU1XIMQvEY3F7Nbpt+r8gnkvUG8XOAnxgyK5gZbju0sc3ZA+adqLs0oud
         T+BgWkoZpTMAspWSghQrV2+wOL6cptoPeMTjSLqtKdWZPLOfudLToqpGUDhp1EDvZY84
         DFHmh/JLS7iuy6mQ96FF7u1fyJecDS5hTq2KS08L+Y7b7fszbKd/otySLnBlJ68vPIEo
         WoUWJxW9gYJturSFg76HJtTxv5Fv4DOEc7AoA0n4+agDmjcm+JVRj/rDvZ31Nf//7i8V
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518237; x=1740123037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws4LKbTJycmWRh3Ik4Ggj9kxLRFUQc51QCqp+xMN91E=;
        b=KIUQ+3nQIrBKygxX2tZx+EZ/Vn7B3sly2aKgNEzJ/9476QAJ+EiyfG3BPJz03JqGQc
         a/cfgiMYwIHN0IDdce1ySNFneQgXv8Am/pW/4HBI2BzmAcL66DdLrK3X0aChT7Zod3jN
         C4DTfT38l6wT2gpw3ygbaCzTq/7Uvug33wmgCpMy/DUbk5r043xJ555N+feH7DdMbTjV
         TWQ1yN/Pf4pWkadFcUMQ5/afLHMMDu+ZJ263xZ7U78g2GRWukyEleuX61+PSPao9chnp
         2NRWwLu8U9sFsdGNOXH+9CNnJZAhVEw18BDl/WW/A7TGgjIPePT1Sz31qweFJ5DxrteH
         RYqw==
X-Forwarded-Encrypted: i=1; AJvYcCXll25oB+lDirhRxvFTizDaIpdWNCypmCeSHZqdJamVX81efKBM5ZVkT+kGA9b4UFJAcnXDDXSRt6txpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3VK0CpYJ2EFSEzGWrWP6QAHkSqVpFgAfPOA9WMolFDgHnO51
	4+8+eUB0AOaETPfrTLNoo6w1rieZuKfPbs2N6zEb663a85mwy9uQS6kiOkCDvw==
X-Gm-Gg: ASbGnctLPuvNqJkjOu5bUYYwBgJRbV9u+7lHTa+fKF9Uhsr8twNZK1/Hk+EgQWxj1HX
	Kq0iVMVNjN2iu2zZsC1Sg8zc53v+V134wSEVUEL8GK9/wDUH9gtcK2lmmVCAIKX5BuPy8LHt4kP
	BiYGcxr1KRK7GRnrYg3DdQ07PX0gWiwfFPVOY5BPwrqVo+FjlZYH77UWz1mv5Q4dyJJz2xoqUFl
	jx+aL/y8oIGSW2yyG8BmKHnC43d7rQvoYYO4UU2KzPUrw4FDYsa0kREMMbvlrZPxmqfjoe6BgUO
	+LsNGg9W5LgxdL0XfcrTrPg02wnyaCE=
X-Google-Smtp-Source: AGHT+IF0u2uYmR+S94peEcofW8EmAj70ydB2+yw1LVmSVhy63KgDEAG/iBAcVgqhQzg4Mo/5g9Mo9Q==
X-Received: by 2002:a17:902:cf4c:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-220d20e901amr96943215ad.27.1739518236765;
        Thu, 13 Feb 2025 23:30:36 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220e21d2453sm18272205ad.184.2025.02.13.23.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:30:36 -0800 (PST)
Date: Fri, 14 Feb 2025 13:00:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207103923.32190-1-18255117159@163.com>

On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> Registers below:
> 
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 
> Signed-off-by: hans.zhang <18255117159@163.com>
> ---
> Changes since v1-v2:
> - Change email number and Signed-off-by
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>  drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index e0cc4560dfde..0bf4cde34f51 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>  	spin_unlock_irqrestore(&ep->lock, flags);
>  
>  	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> -		 CDNS_PCIE_MSG_NO_DATA;
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>  	writel(0, ep->irq_cpu_addr + offset);
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..39ee9945c903 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>  #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>  #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>  	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> +#define CDNS_PCIE_MSG_DATA			BIT(16)

Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
have reported it as malformed TLP isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

