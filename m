Return-Path: <linux-kernel+bounces-208653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1779027C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAC01F22CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D4145B09;
	Mon, 10 Jun 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ej3yi98M"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EA8F6D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040689; cv=none; b=uD0fymWmvqnwFihZyVZ/8EIVMML6dGucg5NQaEH77wGEoE24ttvpSjVaoq401il8isv+Jqwz5HROqSJZIqme+5mupP+/GRm3YKHuYr7cnp5qDD5RZ7+hPG9muKBw7UB8szpYOr8/nphfkoCKijGpBjtGEXoEqWxLOKz76TQKWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040689; c=relaxed/simple;
	bh=n9rffRvvZDo46Wm4EmkIP9rTg/Dg4fSh/n65t+tFCaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zohlf/f6/egYbsxc+nmw4fq/Jq4S905gnZAnSgBMmCQDGcUWxptqPg2iZEeOR53erPgcNZCCUBJ02qu/N8wvRjSP0Z3MUOijkcrTvX9M8fcZNVM5b+G8LUel0xr9PehAizeYMFJXmZUAOTNAif93BavOIszPGTp+TwN+asldA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ej3yi98M; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2506fc3a6cfso2297497fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718040687; x=1718645487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLPNuDrUNKDp5u92gqFlS+I5przmPvAZoMgl2TmV6Gw=;
        b=ej3yi98MUBQOprm9CDvAr6Skn3VwYbw46Y5ZHRwl9iFzGWfWTgAf4Qfz2mvMkYwWpA
         qfY0+nUqCv5Nuz7kiwblVFQLbXjKfwlN9n9LlL44iEsHn0zEbp5XoPkhz8x+UM5Kd9yq
         iMhbHxXilxbFuzlBal80MGMb0RHHqRh1fL2hW0KEaS9sS2H4h48/Q030XUIyuDCvjxdk
         rOn8hu7eTcHBMdwNVEMYuVE4UeRuF5IrOvLvxTg0/PkhufMeLRmctvZTJoRMZg4bDxeH
         6mIvf4B8580auN7EnGCCCX3UsXhGyNAF8KdYD0bd6u1ovV+MrQqY7NknTZrP4fUcg6t6
         Ie9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040687; x=1718645487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLPNuDrUNKDp5u92gqFlS+I5przmPvAZoMgl2TmV6Gw=;
        b=STH03KO1MppbW7t+ho4uxD+63qTLp3Jcme9WMe4sy9Aj9yY3z51Yw0LjJwM1R9tb+n
         veVs3mJ3RCrgknhTIUeN22wkCeEFuAyX8Mlm0PaOcGQkh6H/y2FB8QntB89aT/PAh40m
         JIaOiFyUFnkK88QmeP3QEi0ynHp97hXOslCjnWxIAXmXh9Mz+7s4Z3830Na/n/7PcUWf
         LaCePjS+k2/1B7pJUugiBSo/TS70Fel80km9rMmdb2Cux0iBiI8WjAuJtB7zGXNKaQVg
         Wdy9stYm2sDApk9mIcQCkcDGi3lLCXm2+KEu97JipGmDCm8dOJgTE/Pr98HBEJfO1qK0
         OW7w==
X-Forwarded-Encrypted: i=1; AJvYcCWmh90WS2VW0NpFjB2pcwW5A3cr8sK9NEP+U7FJxKb9iXWLDZ87W+IuFHD2jX+XBEw2aeYHeJbpOo3I6od2zE8XsBwGJTfSfGzI1eCX
X-Gm-Message-State: AOJu0YxD2zhWlb2OdsQ+aR020N5PqsebFZk43elCiXm26JVn90HeHeJo
	p2tLvSyr9dHr0alAquit5tnoEBTTrLSVdbROaaGsEZb5AQAVdHDia7A8VYpVoqE=
X-Google-Smtp-Source: AGHT+IFXpbUysE/xAsd86TbRqWbmmSWkpKf5x4NJLkNSutmjNPooTKdkJFVMwrKZ0jmXH4RSO4kJuw==
X-Received: by 2002:a05:6870:ae81:b0:24c:ad9d:417f with SMTP id 586e51a60fabf-25464475e26mr11011556fac.7.1718040686697;
        Mon, 10 Jun 2024 10:31:26 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79550c14b4bsm266991585a.29.2024.06.10.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:31:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGirc-00Eq4E-Gf;
	Mon, 10 Jun 2024 14:31:24 -0300
Date: Mon, 10 Jun 2024 14:31:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Message-ID: <20240610173124.GK791043@ziepe.ca>
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528045458.81458-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:54:58PM +0800, Lu Baolu wrote:
> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
> static.
> 
> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
> removal of inline code avoids potential confusion.
> 
> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 8 --------
>  drivers/iommu/iommu-sva.c | 6 ++++--
>  2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

