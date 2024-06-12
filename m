Return-Path: <linux-kernel+bounces-211572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4F89053E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5757F285A09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41FA17BB37;
	Wed, 12 Jun 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X0HXb1MF"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44A17B408
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199458; cv=none; b=B1qfvJTvK+A+eXpiZbLfEnVM2oj1ApthWrQhK3i2ztmMUMWyBiLTaMUcAyWN4wotdmVDwOIMI9HX3JNpyGWWdqhH9iR7SEbRtNjexH2AwRUjiEctImMnn2f9E7geCZaPce1yGAzVgpoImo8QAMU+GRQgTxF7NfJESOsErRJ1hZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199458; c=relaxed/simple;
	bh=fe0VWMI+8IbOduW8IuBosS5lQngZX3belBNixyoqkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCEKyFg4j6j/X0Suev4WXT0J3jK0tJVXDDZKe1ftbAiFPq5kNHVT3ivuRKZ0nYYf32FbttwHR1/fT3R9fLavRL2IJNvVyFvkwDU9qaBV4nTF+yi9/fU21WRblrTH5ge9O73Qdblhm/BlFvU11NXEINVd0N5xtRfU8CczNU/bm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X0HXb1MF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b06f1f9a06so21209776d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199454; x=1718804254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=X0HXb1MFfUF4Q0onJRTeLT7twjifQNAd2cbw4JgxMwbHh5eWrcT/gDZRl7DKYSLgMw
         kaNBisbtc7tUN+t9BZwTheceZHcinPsA4889ZA7WzqrbORpmLXJ8U65h+fiBq28nm3rH
         CSw9Xo/hMmD4jUx+ECO+DCt9syZmzbje1cPcZfQAFHKj6X46GSa4fkS+UwD+7+bYx9Lf
         sO7y/QTNXC5fDOogBYH941c1/QOGSZg1wFQYWKwXfHt9HA5T6H6Kz68zDaIuTsg4bCyP
         bcNi4KIA0FymZrcXEZjISSLemDQiDBMAzwnanA1uB4A1B1WHJlax2ooZ/kdW3RvpxS1H
         ZMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199454; x=1718804254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=RQduyhwSdgGB/PL9K2wvbCK6u7LupaYXMxiRpX8p86mOJYizPKEMq3mlFayq8dFPrp
         0N6bwGDeoG405mQSHX1LDsliGkAtGB1WCtkkqRJ22dkjJypqgF/9ztPo159ToksfwPe7
         lKs9zxU66YB2a07ZErplpBqx8U+Atjm85a+ade8OAAMfziCK4eNCZ6mqTN+X7/R/O5B2
         vZEZrMw9yBT5VPpMdq3XI72dZ0EAtgErDsnxENgMgB00rDBE62IU4DkQ3dBNs/PzhBhD
         LCT/cUr1QCOWqgxUJN5NSgbLbSmg/X/hcs29IQ6EPmBXXwlI7bPo5aTDeIrQegKyq672
         DpKg==
X-Forwarded-Encrypted: i=1; AJvYcCX1P+dLl055P3fa0ZznH7TEPZgUZzVTIvWBJcGl8lcr3sLUOHzt9RfUE5WJrQMwJqnbpEstN8yqW3lvtM86oM9o7akb5lvt4IKvpuhL
X-Gm-Message-State: AOJu0YyZj0xB0vC3Xl/T6J12o5Npu5uQEqd9gMxZF8U7mlM20QvSkW1d
	2584EnweBHzm1wlElyHZHu1rh/VkDWFonG1wRsVebFFUJEgmRQVLn7/bxBB6c6A=
X-Google-Smtp-Source: AGHT+IHSfEYGwDvsij2R0661tz6O7lYNLUUlm/+RnRLZK7C4edHuNG4iu5XV2Em15wUQSAV1AhEuuw==
X-Received: by 2002:a05:6214:5889:b0:6b0:6671:86a with SMTP id 6a1803df08f44-6b1a7ad4be4mr16867256d6.48.1718199454661;
        Wed, 12 Jun 2024 06:37:34 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11949346d6.87.2024.06.12.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOAO-008wzF-E8;
	Wed, 12 Jun 2024 10:37:32 -0300
Date: Wed, 12 Jun 2024 10:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240612133732.GW791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-4-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:10PM +0800, Lu Baolu wrote:
> @@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> +		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +							       fault->prm.pasid,
> +							       0);
> +		if (IS_ERR(group->attach_handle)) {
> +			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
> +				goto err_abort;

I'm not excited about calling a function pointer on every fault. Let's
just add a constant flag to iommu_ops?

Jason

