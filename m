Return-Path: <linux-kernel+bounces-285238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D5950B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340D91C23FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753219D09C;
	Tue, 13 Aug 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gc5+eFBv"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC661CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568606; cv=none; b=tvkXntHySlzKsZg4MORvQTh0KkxvxMK76YO2zJIRXB5vJUVQnQJf0gdbhTu+27mW1UoUXlI06jrfyxswzmoRqsFUqFMjpcUSUvmOpJ/6uR7G+dmranvDedQUE0BqGH7t9EM7GZboQP9XH53Bt3R0D7Pla3rs6Vilt4gojY+DhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568606; c=relaxed/simple;
	bh=+88RSkxN/H6afefxdGHCqq377VWT9vaJAn1EHtYr1rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQd89cGDy9ECWPypwoinZBGHq6bU2w+SMr3OxOpz33aCrDR1Nxy2Obmw0ul8zTeZJTJRTylOf2AGbTxvmq+FsGeJ3ta/mnJ3zldQJOnCx73ZsjdiuLlRp4j6M44+7XaU3QLS1ggCI8luzfHN1XhBNcQsIoo/y0QyTEh3SaJ3Ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gc5+eFBv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bba6ced3d4so27979736d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723568603; x=1724173403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+N8UBYC8SKNdClQHm8KFeXbKwY6AotyQfa8NkNjLDpo=;
        b=gc5+eFBvZK/qicNx++aTYKtLhAmXPlOHadQ6wp8pjKguIhM7JyakS+8zPx5kJaj2Xb
         YMhr8PrSE4bx/DSIz2FUEwacQPwq/rnga0JseR+zQfr8HitACGf7KJBJOgcFxvEDSoXN
         G5mP1lQnMEE1S4yoUS/XjjVH5SYFRjUED3MAYdMufhh9b49zUytwMDpEil6Yf0hySriP
         +x6ci5pBGBOpIE53GNIm+zuGyu9UGtVe+0bNO/InijHnUbm4mvrArUEZa8sS28ZVHP1y
         ryRDYNDHckWx0Mt1o77kW2hHiSnKVRazhG0VwUbAnzgRK1MuWGpJLOsJa5XMGDWESCq4
         crIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568603; x=1724173403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N8UBYC8SKNdClQHm8KFeXbKwY6AotyQfa8NkNjLDpo=;
        b=L01kOVlV606aa+KKVnEMnL5uY9cGV2BgiWamJilgtVyrcIrMREviLsACQeInBffcSh
         oPKShTP8zznsfGcRU0z98rR9h8Qe4EEn061n5+8KstWDVByiAbkiNcGXnkpDoMa8k2Dj
         hLKmx7WwnSwMBQtvyRV9SnX2734WKaSha0GWZMk8JkQKnhOvMtOcRdk6Lh7xMP9yNdW4
         q7N2sgvRYHWCHolpr/S4g+oyoViHyViK+1g4oXHa/d5F+w7FuL+6dltSKvoPYLqiImeU
         SdKc3PXAX1NKMUf+NDVI2ALDgNWVEPJqpjLica+suuTRuzObuKyE9RJE+L41Y5UORwFN
         8Gfg==
X-Forwarded-Encrypted: i=1; AJvYcCUV4YQL4KV+dJnmTMjkT52rovnKk2jNiuz9tqV4f/UTeuEIQ9kz0JdB8Eo6xzHloRJvE2oBSbIXFwiMLk21qZaOUwGaYk/Q5h2uOPFI
X-Gm-Message-State: AOJu0YytKHO1d2dcc1dPS3aJALi2EkaLVH9//vD90awG4nvEWu83Niih
	Yt651Ej1dJ43d9fq9MmXj7OfPTh3hmRhiGrGPIiG47m/CrucVjFEW2hbMDI1BvaHmsGbQPYpmdQ
	=
X-Google-Smtp-Source: AGHT+IEthgbcgoAs4AuQD1OxGgSkqwR6WBXoTTpYwsR/9bZNZTl31mk8MOD1vQ8KTchWQT15dBdhBQ==
X-Received: by 2002:a17:90a:680d:b0:2cd:2992:e8e5 with SMTP id 98e67ed59e1d1-2d3aab422a5mr123893a91.33.1723568572275;
        Tue, 13 Aug 2024 10:02:52 -0700 (PDT)
Received: from thinkpad ([220.158.156.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6c4dsm10810545a91.33.2024.08.13.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:02:51 -0700 (PDT)
Date: Tue, 13 Aug 2024 22:32:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240813170247.GA26796@thinkpad>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
 <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>

On Sat, Jul 27, 2024 at 01:32:40PM +0300, Dmitry Baryshkov wrote:
> On Sat, Jul 27, 2024 at 02:36:04PM GMT, Manivannan Sadhasivam wrote:
> > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > for drivers requiring refclk from host"), all the hardware register access
> > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > from host.
> > 
> > So there is no need to enable the endpoint resources (like clk, regulators,
> > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > doing DBI access, which is not done now.
> 
> ... moreover his makes PCIe EP fail on some of the platforms as powering
> on PHY requires refclk from the RC side, which is not enabled at the
> probe time.
> 

Yeah. I hope Bjorn/Krzysztof could add this to the commit message while
applying.

> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Thanks!

- Mani

> > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > EP controller in the case of failure.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்

