Return-Path: <linux-kernel+bounces-405352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FE9C5026
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17347283B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A920BB27;
	Tue, 12 Nov 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzx3ukmF"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0620B811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398409; cv=none; b=Ca9gYLZhbrYOje/Oq9OhwAwvcA/o/J3qpVnx54Rsnwe3wQK147KrVLTP4CHPaBeohxFDk399sI/KFQf5opKA/fuvbOCVVaeE7/5NTB9A2qNcUiechvJsI5eAHUcoBqQLNBKLHpbg/3LD3mAtn57yNgYhCijmOkBaUaAdQrSqOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398409; c=relaxed/simple;
	bh=t59seX+hJq4lNhKVPVYwYRzwgOYtQeQTWXsroLhzZlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bruo5BGKJeQpro2jtg8XFcaNzUb+e8AYh3rARhpKbMWpuLSUlZUk96VvPsfsjs/0jSRu/vH0nYaz7vEChvznl4fvXRMJ9xD/ZglY9dF4QfEkY0hyQ3P4IAlwudxeistVEo0TBnUzuwcO64gR5/IQwO+7/Ag9UR2xuouxlm8L4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzx3ukmF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9e377aeadso540238a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731398407; x=1732003207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5BvAkAKztYW6xCj+mZI8U7st+LWYK/vV8FsPRMq38w=;
        b=vzx3ukmF42t/n4MrptWLCY//4YsHUmZfa9vSYwWZO0pinmOruTbhzqm5njO6XucdXi
         pb8Hd2NPogWBVpwEsYILaEjtt7Fg16k3MCkJAdAaXNrmO2sMKYZjE1ImDjS29r85g/d3
         8XhLOd30y525PJWlPM6aMl60NOXsY5uknXUTzMCaoenFLnPJmkBTw9mZeelNj7XwAXJG
         um/Q4P9wvsBD0QHYK9CcQPSSHNL2v7o6SpDGiMC0k9b5rDZHcPj17oAiEiRFcp0kPwqk
         pWDlKamUOXB8/5n2C1DEX7NV3zllkGzj2MtUZuCWdAH/tZ0F6Sm/3bh1s0lf/Id56d3a
         wriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398407; x=1732003207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5BvAkAKztYW6xCj+mZI8U7st+LWYK/vV8FsPRMq38w=;
        b=QHnpRHgy/nUADiekCE8i6qjB86fDqIVJ7H0dz0T8VLXrVZQWs8nrdlo0asjoEPHNzu
         w2hWlLaeNG6BEUGqo/EZsqTSRu4NDD3Q6QEYUomO9sbs8p0kYJYs/i6yelB5bnUZbTWg
         7vVN7YgE8RtRWIUtCeywI1fqPEOMTmAZZLnj5TnCdbI/dcdytw3tDhCn+TM36Lww0YLD
         1I49w3SYhkBvWnAggTaTWISLOr9SYkkjoBS+AYtDpQwU8oSyDniJW89b1sqKBHAqc0/p
         pCJL4ALhm9RJXQBtW1kPsUtxWrTn9SbS+3vNKskNN5E16XtITLbINngkn1MRxb8VTys3
         JhQg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3s18agB0tDXmIUpTtkDWuQmIYOXoPEVgS8E7d2ulki60iS3NDtAKm+Vpw9KRZcb9OfZI2IDCgrjJ2t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JkpND4BYrR6F7EEE+eseGYh5f43dCoWU5/JptCVflLZQIMJ4
	s8aXPVZNnVcz9YSfaTDNJrWKW5o9x9+sUklIcwQLrYrmLqef9caQCsKZcthcqg==
X-Google-Smtp-Source: AGHT+IEl2XL5FCKVfnW5u6LivJkD4NnNJy29pjQKJz1cJx2jS0MCN9K5ShRz8rqcump7HIgEqbQkbA==
X-Received: by 2002:a17:90b:3808:b0:2e2:b2ce:e41e with SMTP id 98e67ed59e1d1-2e9b16824admr20274247a91.13.1731398407154;
        Tue, 12 Nov 2024 00:00:07 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde1b8sm87828335ad.60.2024.11.12.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:00:06 -0800 (PST)
Date: Tue, 12 Nov 2024 13:29:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] dt-bindings: pci: armada: add system controller and
 MAC reset bit
Message-ID: <20241112075959.jatez7wwiukymj2t@thinkpad>
References: <20241112065229.753466-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112065229.753466-1-jpatel2@marvell.com>

On Mon, Nov 11, 2024 at 10:52:29PM -0800, Jenishkumar Maheshbhai Patel wrote:
> Adding Armada 7K/8K controller bindings optional system-controller
> and mac-reset-bit-mask needed for linkdown procedure.
> 
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>

Please send the patches as a series if they are all related.

- Mani

> ---
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index ff25a134befa..a177b971a9a0 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -24,6 +24,10 @@ Optional properties:
>  - phy-names: names of the PHYs corresponding to the number of lanes.
>  	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
>  	2 PHYs.
> +- marvell,system-controller: address of system controller needed
> +	in order to reset MAC used by link-down handle
> +- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> +	needed in order to reset MAC used by link-down handle
>  
>  Example:
>  
> @@ -45,4 +49,6 @@ Example:
>  		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <1>;
>  		clocks = <&cpm_syscon0 1 13>;
> +		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
> +		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
>  	};
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

