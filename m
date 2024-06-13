Return-Path: <linux-kernel+bounces-213126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C35906CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9460D1C21A45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAA146009;
	Thu, 13 Jun 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MelYgE+K"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F4145FFD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279393; cv=none; b=NJg62s1NdTWlTtuGjasjcveIe36pIyBAz7cfw7O5DgATmrCt7rUjCFGXcU5ZK0WncgLTtv3HA32Nr45IvOmh98DQFvvtxv6nIM6e10FDKfEr5cslbbzsiWWQWPYXibj9Q2JFXuMcu+fPP0LSIYBka3QaljYmGM6NZuOKTUPo+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279393; c=relaxed/simple;
	bh=JMH7aegv+MnUlyAhiAM0CDdTw+aBY3IivqXYt0vaVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSEBWKvHLVzhfcv5h2pgFGBAf0Nhf0oYAj6N2tSrYZ9mnGVU+O9iGNKAqlC/Wjq5tidDLsq09de3bFBLe48lToc56diHCr+gbNt9SYUH10BcLqEzoMW+8EM2Dn6h22H0htYK8WoZguv4ybK4mm/TGA2wW8I46kcvytjunI47MX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MelYgE+K; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955ddc6516so57641485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718279391; x=1718884191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=MelYgE+Kl7Ng5gKsWGHUdZcEBt3m9G1gbQ/LukJ+6QdDvIIzfAE4or/6pGER/H1TUD
         ZB7U5V1zn5JoLql72f4+zOQyN6CTQJX3H1ap0IUype7mhUrKZKIoZ4IJsfh75XxTRbJ+
         9WTSmlMz5E0yGdBhnnGfqMlQGxz8O17gZ6QRkyxMh28TbyQ6MTCYgc5EjEFONDHyiaf6
         zTHUzjvTFdRawHV8kpTJ9H9voRecAonQz37DDV9XDN4Q769wRHz3dmuPjK7VEKMXXDkF
         6l/sOzyC62pa6W7HvTh5asUhUSa3gaYQX5ZZs/BiK+q9NFRYNGgYYUL+iyX0I8oHV4Nj
         e4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279391; x=1718884191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=kdPwxjYDFL6uKObYkC/bNUcHWdce2QepHERINiSlA6HglVlNO76WpHhIZEiQQbfCQo
         ZqVax5VLOLSR8YCfTXf/lBskyhz5EBzfEPVp93lYgsjwdIPQn7RXQB96FDchFq3yP/C/
         9uZmzkVKqtbcsTh6KdM0sKP4rFmm6cbs2yrm2WAFiJTBqMbzqBR25YBJrfo/ySfFvsK6
         DoOEALP0794DiGumwbASe7cx6OxQQFAIlQk6Cmm7Zi9NJ0XgWsswCHbPJRTEleCVFNJM
         tbeYDfFpiU59PUGD2ep4ezfn7lgUYI4vuY3oDB3pVcF4J+EjJ0z9gfHyKLRGA5XdzOXJ
         2ihQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT7ixBx6LGja3eVOR0zPNJE0uHQa6W6LJH6kQ+Bev6dt5++qV+ho9Wmpf0pgiiM3B3YjEdhfB7WAcaHJ7S+4dJfUrQ/HgPb/PlVtE4
X-Gm-Message-State: AOJu0YwFEyhBjlYgZ3R/lWwWvgeoWYir2g+wIRMeaP9uxBuZedR+Dh6J
	w19D9daglr7lU1dS6HcqDqUkHZnnU80ZrkHCh2rar3gwZoJnHKPgXUelNc2klVUu7SfAc63TmGb
	oRV8=
X-Google-Smtp-Source: AGHT+IFWK9h3YEybm6BIGLMJNixPvA73NV4oZYSszQRCqVG7+H7HxqTpkqRohcPjaEg2JALqIvr1Ug==
X-Received: by 2002:a05:620a:4482:b0:794:d988:521a with SMTP id af79cd13be357-797f6006419mr521195085a.7.1718279390820;
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b73fb4dcsm40891385a.100.2024.06.13.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHixg-00FW6s-Sj;
	Thu, 13 Jun 2024 08:49:48 -0300
Date: Thu, 13 Jun 2024 08:49:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240613114948.GA791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
 <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>

On Thu, Jun 13, 2024 at 12:23:17PM +0800, Baolu Lu wrote:

>  struct iommu_ops {
>         bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -600,6 +598,7 @@ struct iommu_ops {
>         struct iommu_domain *blocked_domain;
>         struct iommu_domain *release_domain;
>         struct iommu_domain *default_domain;
> +       bool user_pasid_table;
>  };

Yeah, maybe spell it 

  u8 user_pasid_table : 1;

Jason

