Return-Path: <linux-kernel+bounces-192013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462318D173B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7703A1C2252C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BD154439;
	Tue, 28 May 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8LxA3gk"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD71153BF9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888340; cv=none; b=fZ6fMOoMqwQeG6shl1MMOZRs6BbEhcVs31qWTcc7VCht6Yr9uO3gIAM50fL/OQ6pw9tRJFcHGN1UhIkwT3Co5qTMZUcYgmbnUlkfOV7HnZV2/t4t4lfZV/UL43RDcdHZCSfYOkXfcFjjNujm1Q/D0aOeVRELj5xmzxdjTwiBk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888340; c=relaxed/simple;
	bh=OsYS7DkCn8nNtCFD65MUYsKRym72b+wJESsGapm9jiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNmQFxX1nDybdoTE0M9vScvJsWpikcEwfKJ+bXBTaCtMja6HbUrpAHO79eJ49mz3uQNzj6Rm3C75b3T5h1Ksc3LYNz7o2sAlDANkXDr1ibi0FBrmSqd3n2+1SkDkns0TeGuwlhHAMZpnujeQ/c4qtMAJTtWCCub4TsJmV89lKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8LxA3gk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-529be98ad96so253442e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716888337; x=1717493137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7gzbi64k1Z/YC0Cdr+2B8FH5cQuGNXkpk1kzN13Mv8=;
        b=f8LxA3gkjwRgFquSZRtlde46RPiEmCa0Xa/leBIivPx87yaOi16NtXH63Th5+1gqkk
         avGS2yRH8cIGMuidHxp4LqZd7PJ0KRg8ATHCQ8u/yfKzTGPKJF6GB5LmpzAKiOsvRLMR
         8Z5H0b67iLO6Q8TkvTL5XzTJJCFpdGaEM99kiArkz+e6HlrfrdrNL+DnxDErQ48flerS
         Sn2HIvv7x1u+CAq8IgN6USeWLoJKoKAT8mjJef78N4sMnC54jpjB3PWsrntoZTBpmdfE
         FnWiPTU+CLSAcBcxNxjJ17CTwJZaU7gfGuFQ85I+Sh4ZgcN0S1S/YahGgyp866lAI2Pa
         0n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888337; x=1717493137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7gzbi64k1Z/YC0Cdr+2B8FH5cQuGNXkpk1kzN13Mv8=;
        b=ak70vmoRjlSlKd+ZIU6zyRGHqT/IQ9KmTg2yDOAxoHzuXTYYsLbqdUhpQUJejFPWJZ
         ITCl6G5K6ObfxUCXLeu2ktwNcq9rmxB/SYUAL3jiTIkHxfK0xakdoaw0WjXRtWXfFaH8
         RqBXaekYkZHdVSKG/RyJetKchL21/gUrfnEjITlQiadYqtMIAmlWxE+ITxXP0MJ3bCaZ
         ZyKG/rsV5v0EHOqvfevrHk/KnUVdDWJR1QBt+OYYiW5K7ykIkSy9dcC9jo1t8/kegrXw
         ZA0qz8ounCbJkNLxwt7IqJCpjO2InqTYknSY1SVZ/UqLFMajZLiFGQ1Q4PgL35N9xjF4
         FTMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAUyJmvioELeYhsx3Vby5w8adfCVyKp6AxPAw05cLYspI3fPYHKZ+j+tueARMgjVNmNqbZtCXJb+WZASrK33Wrb0YT+5C+7iiQ5Rb1
X-Gm-Message-State: AOJu0YxTzSFdef17QHLZTNxM1K9sOCmZh3Zk0wspCPHo9c+K/geGStJY
	18MObS+/i6AZ30c1UyUmUGIgCW38m9Y+eqB2bNCWnp2T4g3WjANbS33QdLbv3jM=
X-Google-Smtp-Source: AGHT+IHp84txR1MlPRb+aUhMu7G2+lw7W/QUySdZsZd9yNkSp9JrXsZVz+sK5xQ4n6Nplmjdc1t8LA==
X-Received: by 2002:a2e:9ad9:0:b0:2e4:e15d:40b0 with SMTP id 38308e7fff4ca-2e95b2566eemr77100521fa.32.1716888337212;
        Tue, 28 May 2024 02:25:37 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9570sm11072618f8f.68.2024.05.28.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:25:36 -0700 (PDT)
Date: Tue, 28 May 2024 10:25:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Message-ID: <20240528092528.GA2482616@myrica>
References: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528042528.71396-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:25:28PM +0800, Lu Baolu wrote:
> iommu_sva_bind_device() should return either a sva bond handle or an
> ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
> check the return value with IS_ERR(). This could potentially lead to
> a kernel NULL pointer dereference issue if the function returns NULL
> instead of an error pointer.
> 
> In reality, this doesn't cause any problems because iommu_sva_bind_device()
> only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
> In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
> return an error, and the device drivers won't call iommu_sva_bind_device()
> at all.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7bc8dff7cf6d..17b3f36ad843 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1533,7 +1533,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
>  
>  static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -- 
> 2.34.1
> 

