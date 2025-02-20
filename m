Return-Path: <linux-kernel+bounces-522772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D66A3CE60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EAF176075
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE15D477;
	Thu, 20 Feb 2025 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gUGsPYoT"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232F17BB6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013374; cv=none; b=e9CIXfL+pjLV8GrPLSfc/x23K1wxxfpo6s+eT/5912I72WheuT7OcATUjusi0sRbqwAkiCgoq26LfMVOvLFLjE3b6m6cPNBU5kyJpC7gLaiLA6yxTgi10BlsKkFtS9YlAmYgl8aOTZbEnV1qgB0QpXsMr4GOV2Gf81cAeekKTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013374; c=relaxed/simple;
	bh=ZhTrlgc+69pvUq4i22CA5jurxLSucq94AvJJuIwOxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYeZUIb5g1lKjq5J+g8lI8GChAHiulIumUIwfp6k13uD+qhX8bgrANtCagu6IM4HenKWZEmOo2x7X4CqCQ2rbaF5GOdLsg+TN9KY5yF1/pemunk72alowBHK42kxbF2idsQB266ZWT24uCDOJiUPsC2gmL5tRYP9Lq/JmEXERLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gUGsPYoT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e66a7e2754so3160616d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013371; x=1740618171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRs/JKSwsGTXcOODWipBNJ36S3MEcNOB+8tXv5oqvN0=;
        b=gUGsPYoTBnXMdnc1j/wgiRf2SAmzNArH97FOmILfk+mhCjsuT96jf6npdJWFeae7tW
         9TKdnH4/wx0et9nb9W6vTuYCGlmAvJQ3nEC2GDtZb834HI7XgiRkXoTnVJBO3wVHkxHd
         FDYZEuHIm+qi13VEBMMmcDD+w8y97yQZ25g3rWmjfZUWfTriZqAPFDCcBEYWwJngjV7M
         jJQXZ8EAVgM2aMeilK+Bq5ywzz2jDEh0RXI8fJ4xT0uE/3KInyjF0AMgiNvbrkiX/WDy
         jCoheo+MCBwMrQoggsM3IIGCEPG2xVaMHVErZU9LR59cJt+FVKX3krpmSFsnIXljIOTH
         Y0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013371; x=1740618171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRs/JKSwsGTXcOODWipBNJ36S3MEcNOB+8tXv5oqvN0=;
        b=BKwUH0VZYG4pfBXDF43h5ZbT1NpVN/s+K+u734NV4f0UxRIOmKBD/60urjZB6lpcIL
         9vd/sFsB3iedSJYc6r+D6+AZDR4FrVOsEm6KC4yJOxUoHtBLprfNaDZ7pWLqi7wIiiFK
         OJ8d9vpSGQM3vMv6Rx7duUl6D8XGblSFAzHRhHSs8byTT6r9vqbGdSnt5Rdh730Lv1OS
         LpBBRhf9Qib5HkSj11fpffhP9lFrrNSMPU6Zv5EuQg4boGjPMNA2NIIXQ5TCfn/oxr+h
         9AtMT7skwxnweItmruj4D5uBjo/1TAHiPT0eZpOyGRfFEPrjIGqbFzFuGYDPOLQiYs2t
         5GTA==
X-Forwarded-Encrypted: i=1; AJvYcCVqeg6SmwQfOhdGTZimFq5G/n34QBsnpThB4/Bv9lHcQNWyKpmhGNGZsQhyHg6YDXlGUoZG7l2gDPOtB84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBoroaQDsW/eEMVjuVZibdgkCzD21+XZODeAlX8eekUGpMuVA
	horxjtvrfeUTnEJ2o4Wbs+xeSNRz0os0bwjFFrSJTeVcLMSN0tGGgh8FQbaxWiCQaZsIe57b69c
	2
X-Gm-Gg: ASbGncsPI0wkWVx+kw7iNm1QY+K0W6dDd/3Md28FYhxpDxn+TRizaLBwk88k6DRIkHk
	+pTQAPfQsZqtcKaj2cV1N30h3KQCo+SYDSZWi2mHtxeNqE/nQJdgw4D1VQUp8LCUV9bQVsRoNfk
	eR3HHolkV2jfubBv4gQGVz4FpCqrBHohT1o7eS0lpHoc4XD2UwxzUhSz7JushQr9BLK+Up+v+EL
	+Q21ivOtCkjoCORBH5Bl9H5ZTU0aHlXt6pDCYcup5cyLbhqg8f2JTUkuBquakO0fzXjSRUfu6ut
	mqD7d1c/H6h+lbnNrNreR/cgVM9rL09IF8dp4tTXYSWyzlUZzJ3p5+ZXVhL1+D1m
X-Google-Smtp-Source: AGHT+IELnZYcib0uVQ5YAM0A6QDyvBF/tj8DmFXHYAT7rDf1dWIAeZvN7kiG5K6bL1Spk0FG/2Rv+w==
X-Received: by 2002:a05:6214:19e8:b0:6e6:6252:ad1d with SMTP id 6a1803df08f44-6e6a4b91dc7mr7604826d6.20.1740013371423;
        Wed, 19 Feb 2025 17:02:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31fdsm80390616d6.69.2025.02.19.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:02:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuxm-00000000D72-1DAT;
	Wed, 19 Feb 2025 21:02:50 -0400
Date: Wed, 19 Feb 2025 21:02:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250220010250.GQ3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-9-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
> @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>  	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>  		return -EINVAL;
>  
> +	return mock_dev_enable_iopf(dev, domain);
> +}

This isn't going to work for a replace type operation? Maybe like:

if (old_domain->iopf_handler && !domain->iopf_handler)
	return mock_dev_disable_iopf(dev, domain);
if (old_domain->iopf_handler && domain->iopf_handler)
        return 0;
return mock_dev_enable_iopf(dev, domain);

?

Jason

