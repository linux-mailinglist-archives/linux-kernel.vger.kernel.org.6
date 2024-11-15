Return-Path: <linux-kernel+bounces-410312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C49CD9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C0B25644
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C91891A8;
	Fri, 15 Nov 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLTdpFn+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8D17F4F2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655042; cv=none; b=Ryc1wVNvznyTiVzUbj07vR02QtTtAxJv1r2yg4JizHn4ZYPHD4cj4zZlel+eRynmSbzkpzaaboGA6DOTsJ2gHARt8kEN4FxFgNXuBFad0rc2fnMGOYJWi5tFrLzajVw0PNrmOHtyNmPEhBfmnOCxsXshQwQ325DYhAKX9LEghAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655042; c=relaxed/simple;
	bh=CLekJhZV26W4QjUdjO1GmEQq9zGMyZX6n8NItb//Rqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTSV/kebT8nfWD8v8elgzwDzRTuWmhqlzcdnBWeHredTw9kG/L8+zD+EcQUdh6cAe1yHASwlAnFKweiGS7bMu8JUDs2DhuooQRUOshL9AOu2EDE8T/5olRWALNwZkq1/ROa8QW130/mIfzavdKHOL6a5bhhcdicmMjjUlHq/ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLTdpFn+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5130832aso1128019b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655041; x=1732259841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsz5jRvCR/yiZ0wis8iU8Gb8eCp/4LmvdSJpH2W47Yw=;
        b=uLTdpFn+DrV/DKsTkrS2drphO4SFoQt1MJVIVG5SlZGYsIwJOtb7EL8nvW/YGq1Ze2
         7ysAAEWGusO6PHLnoGgRQrcpCfxPlGAD70UpIvAIp2moq65d1GoZ9ub8Fuu8LupyGr9m
         OqthkXhDuZ0UYHsQJsJUkrfPxfHptvsaIsYSbfyor9kT/OXqegqz8PG/8Hhckj2KUnsN
         Hnph+26TtEFHbRQqpZSt1xbk2W6Ylz2KYljGnxlmEqwn1r2ylWLUVjI/CdVFLHsa1pVn
         6M5/XmeMVu1mhdQS5dnd6lHDJpfaBMiIgmLkqEpkqdvbcz5ZAT8uE2ZtuYlKS+U9REra
         jFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655041; x=1732259841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsz5jRvCR/yiZ0wis8iU8Gb8eCp/4LmvdSJpH2W47Yw=;
        b=LN0vY4X8RgjCzAcuGGW+IwmwIvmCBU2uBgPfW4G2mxJFrZKA3L8BMO6eClYfxsdPE1
         Lu1NXvpDrQ/I9G7YwW2MlsmwnuC3PWOi/DQX9qKXa/JqZoML0Oi/p97gyX0+cQF4yfea
         b1hzNk9gAcP+LhF8DZwyZdbMYXLr9ST6RM+xnzNb6fXx2Pn3wywtVpYbYHtHnfSvhkBx
         2Y8hW1/8zc4LyrAuD/sCzV2AC4CfDY132HB4BRjguGBE1+nHqaxfE1u8zelW+iokBEaI
         ATiMOy0zloyGr3AF/q7waeNtLs3iEY3kgNqwScKWM0lEkhBqSZeAdEna/wWtdR9/OBm0
         y+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWrbvGgyXyrkpndx2+8jagCz80SOYFuD/iY1nwDeqKVufrYWXi0YgSwffCGAyT7hlfPeIK7yFBAmNlpxSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGz1y703OpujATcSKliM31qB5hfnuChUrk8tx93en3IWod/OU0
	kx5iDGuA7RIQMTy9fkoG430O0zovFR590NSYTygQ1a8qFE+s2EnlnEKEnaR2hg==
X-Google-Smtp-Source: AGHT+IHTf29QqYruBqey4TpSYqbKF7UQC/DJE+teHJW7VZpyneERQ0LqsCT4V+Xp98m4K3keDZcRiQ==
X-Received: by 2002:a17:90b:33c6:b0:2e2:cf63:224c with SMTP id 98e67ed59e1d1-2ea1559723bmr2130928a91.35.1731655040672;
        Thu, 14 Nov 2024 23:17:20 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm6618765ad.106.2024.11.14.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:17:20 -0800 (PST)
Date: Fri, 15 Nov 2024 12:47:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use of_property_present() for non-boolean
 properties
Message-ID: <20241115071708.nh6tnscmq5khr46o@thinkpad>
References: <20241104190714.275977-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104190714.275977-1-robh@kernel.org>

On Mon, Nov 04, 2024 at 01:07:13PM -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..d2291c3ceb8b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -474,8 +474,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	if (pci_msi_enabled()) {
>  		pp->has_msi_ctrl = !(pp->ops->msi_init ||
> -				     of_property_read_bool(np, "msi-parent") ||
> -				     of_property_read_bool(np, "msi-map"));
> +				     of_property_present(np, "msi-parent") ||
> +				     of_property_present(np, "msi-map"));
>  
>  		/*
>  		 * For the has_msi_ctrl case the default assignment is handled
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

