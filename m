Return-Path: <linux-kernel+bounces-528353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16524A416D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF83D1719D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAC241CA9;
	Mon, 24 Feb 2025 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPBqIrxD"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE951D90DF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384096; cv=none; b=UBNbkv9sJ+ixQWvtscqDwIphgmPFiNj8McsdVSCafWti+Hy7SmNfiq3Pncr9yHaWqexTSkzTa18KZRyWmc8uKuAIAUA9Nxb4pE2hSwRcswNxZU20gpmpvN8MPRDDMp+GqCBbamt+7uhK6HFjdKNqrGRG0uodIgelKK7tQzd/i+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384096; c=relaxed/simple;
	bh=c7+qy8I4aVajDJ7q8pwae9rTcGIOOfIbB3vrS74dFQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWUsDOvKral65LTJkRQRF/eDxP6vfT4LmehlUpb115AcDoWEXeimlr013b5yEXheH9iZXfNNGojRPcqU+MUeN9YBycpeCJA4JJvTZVKgkdkH0ov1wahVoHjiYH+o+M6bwp2BVar8wtSEbXl1GAvzUYKQmksr2YMXWop2o9VRruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPBqIrxD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso6834512a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384094; x=1740988894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qbCbRKBT7nYUMZ7e71egOL9DxulLD66sFDSiePK/h4s=;
        b=CPBqIrxDDRvxk/gnvGMM2UoxAvge/U4ZAbYL+4Wtnm9jPfjZfah1+C4adPJ8sz0LCy
         cLBxz++t3S4pb5aVyL2hAuB4GpNfeRTXHb2JGNypCPaNr7w34sGBD9qrTxgnZuav2aTQ
         dh5TGbl3iiiNo5jgw/dU6ucS97SK0h+/Y1TXolwTHmukYCx5sBLzDzp8lM3qG+UUCeMR
         oINiLU/EDluP5CW1dGX0BYDLqA4EuvFPTYRWDRe39fcGTyagMr+zY1oO5EIJzWToTDQb
         MZ9eXVW8WhnONuckSok59pXfl149VBTFXMAr/TIPS3+aXcFnDJLrEOMRIkDuSeoO7G72
         g4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384094; x=1740988894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbCbRKBT7nYUMZ7e71egOL9DxulLD66sFDSiePK/h4s=;
        b=V6X/03mlm8kn58vyIWRN1Xyq7ijIYgRUW7J7ookRLb6GHIs1mFdH4PseVAABEJl5cg
         NHvhadYPM5D1vuM+9ucphLf7e2OV/b8XLCbFNsCxuCVr1ARcD1mLzllyvVvgnpvqa6JE
         mVj0IqAQz//6Gd0X3KOpAsvW7/ZsM1HDW+hPFYmGWAyVIlRQNsvs+5KFyn7KrTp9d81x
         mjeb2dTbEkQn88X0S9aqckq6meyTYjeyYezz2Wo34dU8Rj20z4jg/PavzoEHlokvPbGr
         D3CofJ9xFeXD4GEKAEivoid8R4jF0CICeXRA+fKUAIZUPlnWStuL9wnLTIH3yLs2FkhO
         pKag==
X-Forwarded-Encrypted: i=1; AJvYcCX6YbtzZiTSNtgweTkKyL8OdaBIx4Q2r1alrKslxo15u8E6eL872sw83m5rSEwg8GKRknouvQlps80efQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVkTHeNuUfw7Ea2HOOUo1NR/obWNPQF4ZlXZiJxysddgCNMly
	3GO01Vm8QP5zKzxq/sZjP4RPaYzG9hkw5BofHKJ+W4JOkyNmlBK8FDHxKBq72g==
X-Gm-Gg: ASbGncvmcgtBZdW4bx0Pv5CLpdZmkqmYEbE3ziWA6SmLsw+RjLQk2CCO/kn+lOI+Coz
	gjnfHq86KT8FPpYoLRCrSupnUxL1Cax4xPJ4xqiq9tKPYLRgwC2VnyIhJzM/4vLAtcki74Ls67U
	X1BA1Bs6hmYMmrkaZJ8Y1ZCh7J4CNQWPPuxkCWCL/jI1zCiLa9AFx7o6pn7DR0hWrAhSHvt8Nd5
	yYan2h9Gn41Lz+HzWpeQ/bU4X2xYD1LlQv1HOCaFprn6JjtIJGAqNCaoUZWTVy22u5kQhHGrYEe
	b7lOBRRIX5OHE7mS9l2+O2mtZ8hQIqCOE7/5
X-Google-Smtp-Source: AGHT+IFSJRHQaoas4hBith0wVUqSgTYRtfPMiQmQRzahw7+ResAWhqCfmrXX0fr8xkSBMMUEpNn5Tg==
X-Received: by 2002:a17:90b:350e:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-2fccc1172demr27937034a91.6.1740384094186;
        Mon, 24 Feb 2025 00:01:34 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f7fesm5736053a91.43.2025.02.24.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:01:33 -0800 (PST)
Date: Mon, 24 Feb 2025 13:31:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250224080129.zm7fvxermgeyycav@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
 <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
 <20250214060935.cgnc436upawnfzn6@thinkpad>
 <CANAwSgTWa9gwpPhVCYzJM5BL5wUkpB4eyDtX+Vs3SX3a9541wA@mail.gmail.com>
 <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgRvT-Mqj3XPrME6oKhYmnCUZLnwHfFHmSL=PK+xVLHAqw@mail.gmail.com>

On Thu, Feb 20, 2025 at 03:53:31PM +0530, Anand Moon wrote:

[...]

> Following the change fix this warning in a kernel memory leak.
> Would you happen to have any comments on these changes?
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c
> b/drivers/pci/controller/plda/pcie-plda-host.c
> index 4153214ca410..5a72a5a33074 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -280,11 +280,6 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
>         return events;
>  }
> 
> -static irqreturn_t plda_event_handler(int irq, void *dev_id)
> -{
> -       return IRQ_HANDLED;
> -}
> -
>  static void plda_handle_event(struct irq_desc *desc)
>  {
>         struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> @@ -454,13 +449,10 @@ int plda_init_interrupts(struct platform_device *pdev,
> 
>                 if (event->request_event_irq)
>                         ret = event->request_event_irq(port, event_irq, i);
> -               else
> -                       ret = devm_request_irq(dev, event_irq,
> -                                              plda_event_handler,
> -                                              0, NULL, port);

This change is not related to the memleak. But I'd like to have it in a separate
patch since this code is absolutely not required, rather pointless.

> 
>                 if (ret) {
>                         dev_err(dev, "failed to request IRQ %d\n", event_irq);
> +                       irq_dispose_mapping(event_irq);

So the issue overall is that the 'devm_request_irq' fails on your platform
because the interrupts are not defined in DT and then the IRQ is not disposed in
the error path?

In that case, none of the error paths below for_each_set_bit() loop is disposing
the IRQs. Also, calling 'irq_dispose_mapping()' only once is not going to
dispose all mappings that were created before in the loop.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

