Return-Path: <linux-kernel+bounces-261761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA793BBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93581F220F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7FDF6C;
	Thu, 25 Jul 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyJH0Amf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4B4690
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882632; cv=none; b=EVUhLFMD/nZE7tcnXCXsmz8v9li0cuMy9NeDFS9MM1qIGH/E6DLzgTcdvwF14f09YETahRfuiq9pX3dnIdO6hfNiCRMvR0HPJWJqV4clfTn/7kNx/63YApzkXYT7rPAumJulranjFuUSQWfyGoV333oa0jdfRdrdD5ZMfHHlB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882632; c=relaxed/simple;
	bh=guKMdJDh2Dsp0ZvO0y2p2rkfeU5PbBBaTqPQnUlwHec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srtR0rEoWQSj2K373LscuG5lYjqsJe1pZ3gS8Ebh3NwtbfYnHSciLDj/+gA5EE4FNv9Ts/gTJEYtbc9iBCctT77fxt/+j+P+VsKPoSUz8u3QdAnVS7WbufDKgGQOLGfccpMJp5hMaMhxonAgtJH2YZp0urQ55CU5jVWTtGajE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FyJH0Amf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5296e214so4433475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882630; x=1722487430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wEKpUv4fMwfLgYNRd8DtitOmSI092BkaurqEG/TeoI=;
        b=FyJH0AmfjHHew3GLu9iNP4+UFwiNClsWdNdd1/j6RIewAEiuPRsgSZaQvMQYrutj8T
         ari3+ZlIIMGOA/c6lF2QNQbUatrB4L9znLl6yKN74FVnlKv26MpV4b8sOd/wyhLWZr3a
         ptUpQ++9q8J8JliQgIXc+ZooKUSkyLcM8WNIeGXf46HV3PGp6zn3JUfkPcTBK6IVP9DA
         rsfeYbYovNLtevunOU/Wrjs9kgG69RK6njhb94FILuyc//6sy+qHWQXvESf9VbyQ8Us3
         e4waR049q+Gl9IoHszYs29TGgGIkQmy6kN6v/SrIIty1SgkpEtFjof4voDFDt4kDWHdi
         JlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882630; x=1722487430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wEKpUv4fMwfLgYNRd8DtitOmSI092BkaurqEG/TeoI=;
        b=kFhATM5m18RbPP0cHZuuJKBVvP3Oe5u3KdEPdX8ZlRmt7F/D++zJ6y8fuOI4ePYMhV
         oO+cS077flhlCAPDh+vJdIfYua/JCjoKQP+PpG3Gr83ifAOEPrmIVeckR/uFjMTYI6PE
         KbinpmPEEGFZAWVtVgwDAXrFXMOKro/lfoNRtif2VYbiQZCaBDSNM6vkaVNN7VyMLzU4
         YILuZqLbp8Mh5TBy40fpof/jdzpVYmav8nwid9qW58+sr6tb6fYF5DYpaoVa480hbG1Q
         xeSF2DQkVDtqPXifmMCPcv817IO5TWFKykwEt49Q6KCZrUmPB7IRYvkMfvVePIIU7tJm
         jqeg==
X-Forwarded-Encrypted: i=1; AJvYcCVD0ZLNmj7euHz7lOMDjho0hhqhpVQXShPTfQ1snrPTIwCrJLYlvpSAfjJzizaujjWaG71N6USRIkXBHtK1Xjx+H7GKIsUMdgaYryrE
X-Gm-Message-State: AOJu0YwY59s5MeEcmZfZs75TAeBWrfYw2rnonO9hcTXcXZEO2mMoMpkl
	wG05H3L5uJoUEPGl2RSNZb58NnfabErFVlcUnzFNOTjSlKljH418ynViqyAW5Q==
X-Google-Smtp-Source: AGHT+IGWryDYkmYqfGQhtlkQZyoWV2+MeYYkU6VgJs8IspKUBX7yQT5hHKvRN20Mhn96afsnACiolw==
X-Received: by 2002:a17:90a:1fc8:b0:2c8:bf72:5389 with SMTP id 98e67ed59e1d1-2cf2e9d200cmr698468a91.9.1721882630473;
        Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73f00cesm2519947a91.34.2024.07.24.21.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:43:50 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:13:44 +0530
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
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/12] PCI: brcmstb: Remove two unused constants from
 driver
Message-ID: <20240725044344.GH2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-8-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-8-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:22PM -0400, Jim Quinlan wrote:
> Two constants in the driver, RGR1_SW_INIT_1_INIT_MASK and
> RGR1_SW_INIT_1_INIT_SHIFT are no longer used and are removed.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 073d790d97b7..dfb404748ad8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -210,11 +210,6 @@ enum {
>  	PCIE_INTR2_CPU_BASE,
>  };
>  
> -enum {
> -	RGR1_SW_INIT_1_INIT_MASK,
> -	RGR1_SW_INIT_1_INIT_SHIFT,
> -};
> -
>  enum pcie_type {
>  	GENERIC,
>  	BCM7425,
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

