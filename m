Return-Path: <linux-kernel+bounces-281535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B994D7E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BD31F22D80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F48166311;
	Fri,  9 Aug 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5A/hqWM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74B16088F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234218; cv=none; b=MMTQaaEJiltRZrvjClKy9+16WnVPRiXmr/JMacTPtMvvA5uJ7L/ssYLpuI1R3wLNtCoV2pDACd/s7Ia2YiU/GLJStqrPRPOH2n96xFeUcWTPzCSq7AZKRAqjx5QpX0AUALr8zfhA7+VZgqqO5+6ZNEY64+wiK74hOshA+oVGOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234218; c=relaxed/simple;
	bh=42W0tLghB4yvv48FXzrpn0uYSoZjE6pUUTBSeMH1Qqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrA+8Vvqqn894iRPt+Bjor50+u4vEozPe5hXSBUfCgadaW4zZHcG9PePGli6J+t2nytwOObTYCfx2T9zn+psoXGuXc/2w6HtMhE65Ix3X6ej8Os8VnxOQzjEvC0EK1nHfMsJHEsyKgkoMtJBoIPQ5vGmgspcMIEH3GBI2C7kwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5A/hqWM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-200aa53d6d2so45185ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723234217; x=1723839017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgqce5rXdRX+XwqcnFHtjrWp8PyPm6TN4Q0gJ9i4UiU=;
        b=t5A/hqWMieBy9S9NnQQbKCoIVVwO/69TaQhcL0WBkw3iiR4M1UR2n4eUC6ulolD9uG
         DzEkTe1V+ofX9BOmoDunLQNs+EcohMlFIgOwGAW/WQAhxyAXYadGLQzsd/YJiSlXrzGL
         BsigWekR2UGX59HNFVLFIpj2CWIpsWf3r9qyu5w5BlOe7baC9HpDmh9eUuZez3hOlLYb
         qWGXBRJ8+n9N7iZGo7xV1+/QriOMnPhjp0GIBmu4V0ZdIUsK0Y+MCF8n3eZZH5Pyhqdd
         Y85YP57UpJhySl9aEWEYF4zeCEln/0tActh0kSg5YgITtWP7yMeU2pE3dO/AEfal73qz
         DdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234217; x=1723839017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgqce5rXdRX+XwqcnFHtjrWp8PyPm6TN4Q0gJ9i4UiU=;
        b=UtiMDnqajqfMYSwC6XmBM01x7cwLaRWfiIDlSGfLYVY59qOVUAif+wQJhIDaIpkgGH
         N9TpfepD0H1ZlVOzIfLira2xipbWJMMvEpbvUh+jFnlTQ21GUZVyJeZpZzYs2sTIGgp0
         BUygPiuQ3ZOnqm5i4dxbDkx3ymOCxZ9Y3nXCW3VKjyVG+Oi0cYgEdxcLlWxZXjkV/n3G
         NlIKzBvwLU/CLKB48M0wrxaPd9VyUoxEFUnJoJrIdStQEpy6wCFxU8zcQHgOmaKgIK6W
         63CKeil9mc2uv2xu65sl/bDxoQRPyTPobnjDRezzMhEnoWnI/Y3aDj4rk3ryfBkPKZvl
         /LJw==
X-Forwarded-Encrypted: i=1; AJvYcCUekbJd1vmGKYQx09OOclUMwG4kuvGDY7uHZdcP6HX9DcPNWBOrOOqG3S1HXv7pL1aEdlLHIqjPtjo7lI66taXXy6NBYivB1M0ef+QY
X-Gm-Message-State: AOJu0Yy7eR4w1ndm4AKqBxTuzYuWzOBCIqWlXjO8IStspVCOFbctGaWQ
	+dAQK///ZK/DbsgWAF7F6uSogHb40QeiInRfdiB4PGwL9yo3yNhhALpL6XxXaw==
X-Google-Smtp-Source: AGHT+IGCwF0wDx64AEbXcI1PmYNKlXMXiszjM75RvAm9xC3BTuLx9Ns1kMzSlCVJ3QIjU1KiQ9CWrA==
X-Received: by 2002:a17:902:c403:b0:1fc:7357:9076 with SMTP id d9443c01a7336-200bbb3b48fmr557185ad.6.1723234216116;
        Fri, 09 Aug 2024 13:10:16 -0700 (PDT)
Received: from google.com (255.248.124.34.bc.googleusercontent.com. [34.124.248.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab7c27sm134892b3a.205.2024.08.09.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:10:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:10:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: Un-demote unhandled-fault msg
Message-ID: <ZrZ3nm2U5ox3a25O@google.com>
References: <20240809172716.10275-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172716.10275-1-robdclark@gmail.com>

On Fri, Aug 09, 2024 at 10:27:14AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Previously this was dev_err_ratelimited() but it got changed to a
> ratelimited dev_dbg().  Change it back to dev_err().
> 
> Fixes: d525b0af0c3b ("iommu/arm-smmu: Pretty-print context fault related regs")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> We have crash telemetry watching for "Unhandled context fault", so we
> want to preserve this error msg.
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 723273440c21..8321962b3714 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -417,7 +417,7 @@ void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
>  void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
>  				       const struct arm_smmu_context_fault_info *cfi)
>  {
> -	dev_dbg(smmu->dev,
> +	dev_err(smmu->dev,
>  		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>  		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
>  
> -- 
> 2.46.0
>
Yup, this should be changed back to dev_err.
Reviewed-by: Pranjal Shrivastava <praan@google.com>

