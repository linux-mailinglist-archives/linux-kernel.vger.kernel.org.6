Return-Path: <linux-kernel+bounces-288231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB19537AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385EBB23D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7911B29AD;
	Thu, 15 Aug 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdIwG3+V"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DC1A4F0F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737234; cv=none; b=iUxXcgFa4Vi6IsHAZZ4KkW4fKyFtfE9icrQPNrEq/FXqWwAuSbVm8VoBuHEaxUqxTchijPvROUW6xckVAEZcOrLuxTdYh8bHojl6dS9aLlRV4czMUTSGdAOSsaMctQgOfjwIHcR1dVdvMYavcFWe1OeBY2Mt0R1vUeBJ/7NEVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737234; c=relaxed/simple;
	bh=F5oZlzKS7LV0vco3hf6kzYpAppwKPAa4bDeIJnmZJCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts86yxDTtGirBbZGkta+wH7DTPdAihcyyrlrWxRVTtyxwtiQ9xztN6hHNg3aUm+zIDPcQed6bKX8p9lIZPOqRGefJnQv04qU7jTWLyaIXYaAjobYwTtHof61qV7Z3NGKuyzkFRQCLrpsSjSMeAytK6ATYbcbkx6VwgUWaix/+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdIwG3+V; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so817321a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723737231; x=1724342031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8FkPO3LPGoGF13VvZyZHk15TI2ex5hx7elWLr/UyXk=;
        b=DdIwG3+VmFraA5PEa7AUBmnsXNRhX/DgXdzpSu7SdBaGs5R9rBhpaMeTL/PXRLHclB
         LL2/1R6C5ry/uPrzgmiS1HAcl7tOv4mefPWr6vCUSCnXtR+/5jrqMnNVi7Aar3J1NHjQ
         AkDx6LOqv0JBWdW8ttbHuPZMiy9WWnw6Yf3/2itNi7VeNd0RYon6LECVD2gNcb7bH2L4
         IeX/jHJmRBTKF2g3ts1z7IJSPMaggSXTfDD2qRRPzwQJDQ3n2BaWUvDg97CM5inpiQ8v
         snAw7SbqjhfP9wWu7qvX48nwmw0tEAIlFkiNIhTPyDuVGgVscxalp4PPqXgSHFU5Jytk
         Rmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737231; x=1724342031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8FkPO3LPGoGF13VvZyZHk15TI2ex5hx7elWLr/UyXk=;
        b=FVAJNpxM/Ak9W179Fql82gn8QMTNUHqCEXthwS9umnFTPfwmhGeZeW3Qqseea4NsdT
         SDKdcssQh6CyfO5vJ8yYOFGS3hm61Lq3OQA4LJH4Gp6mw3nEbVxUtBmiYsH3d3JKwXTP
         E4owaskC1TeHCE5PR75oigeWJ4P2/jxWqX+rm0ExBFY5Hx1flmZ4FxopxNt4A2oq+OYA
         NZpAdabgjafvDW2/6LiX7rylSzlegGT7nyytU6mabgFCOWUrXE11iTF6paE+ua0im+iF
         sY9aBFZKX8komILGhDS41cOs29D8Q9P1AMxPmydU7Sb3mAol4QdG/INm1EDvj5Tsq427
         VUIA==
X-Forwarded-Encrypted: i=1; AJvYcCWCx/eX9JBjnhU72yCvPVhIu2pCxWeWi6z62TuFvCN8csdcAN3FOHPuUybmCQ85sropOksG1CvfpjefmublnJ/DRU4+rk3XTnRHj6bI
X-Gm-Message-State: AOJu0Yz1yTOC4F/C7c6mPJ/X96ZGI25pIzJtmCcYxXm8j0Iqsu518QSf
	LFdKITMiza40+YXQTomO8Y+6tA9K//Mm1OVbI6nV3KTUdacRjyhofTQqnkrK+w==
X-Google-Smtp-Source: AGHT+IFFhMzPsFhY6B8IutZ/NT80L7w/pSH6eUiPk5JneBgDCW93h41FVTkK8Xj+zNfxYMkf+hjWEA==
X-Received: by 2002:a17:90a:d517:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2d3dfc1f4d7mr97707a91.3.1723737230823;
        Thu, 15 Aug 2024 08:53:50 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d396a59287sm3068691a91.0.2024.08.15.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:53:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:23:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Message-ID: <20240815155343.GC2562@thinkpad>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
 <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com>

On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
> so drop maintainer information for that.
> 

Instead of suddenly removing the code and breaking users, you can just mark the
driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we could
hopefully remove.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e71f97fb6749..9b683899cd088 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17556,14 +17556,6 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  F:	drivers/pci/controller/pci-tegra.c
>  
> -PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
> -M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> -L:	linux-pci@vger.kernel.org
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> -F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> -
>  PCI DRIVER FOR PLDA PCIE IP
>  M:	Daire McNamara <daire.mcnamara@microchip.com>
>  L:	linux-pci@vger.kernel.org
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

