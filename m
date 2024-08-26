Return-Path: <linux-kernel+bounces-301639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD495F382
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DA8B21BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59B18661B;
	Mon, 26 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CD9xdbVM"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CE172798
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681162; cv=none; b=h78arZ24buX55jWlHl+qAcpSx/YrAuNsj0ZgXeFIiIYcpCpRAKJstnI8vRiua/8czbq04IxOys/v5jDr3r99efpKMBSxShkFX9l5V9Mnk08i+nxTzWNKPEI8TMlJMpChos/VXSfHDzrPDbE9slKQ54rYj6tK3ouyg8auGT8RtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681162; c=relaxed/simple;
	bh=RIDwIR+2Rx9D5RHR1S20zfCpZr4QXOrWH/qKh3d3piI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+rAH8C17Sp7kyQjxojbowaugutrLSsgrgeMzVl8HM2ojfLhbXJwMI5TuvRPIy0jPn+kfIvnB0iyDhRj8f5Y33PcnCN9m7yaOM3N71Mn1o8fTyJX1EEpW1luWxIlLxupUY9v/Z/NpbvKDqrzwtJ6MMuHwP9k9qALz1eCzUcwQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CD9xdbVM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fe11dedb3so24175391cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724681159; x=1725285959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WhmiaSBnitzHla03ty0244NTX239qMpOZBKbSMJZCM=;
        b=CD9xdbVMvac88TCDQDImPI4tBwEw29V3x2tegFKWaYZNxQxoP9V4fgEekA7zpoF4eC
         IVrF2VsdOUlcw0h+cjydRqzWdwL5MfCet8bZZL0S46yep7RhgA5YBiFJhJeVlexdeSm1
         4cyJUFKU+RMulbJL7xXhzm2luax4ENjd1citgDqlLgaPy0JUxW9RDwcfh3EBkl/XmV0V
         3MG1W5bTy4O979w8WbHo4QwiS3kmJqVINnXyMh+iEPk3CLg0b/J6oEcLkzU7E2FNbLXe
         OVCSeSKKHRdajZD/9yno+QtFEdRNx+M47eVeQ5HMz2R3hhxQNDSCbFvMi3OUmreVmjeS
         UvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681159; x=1725285959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WhmiaSBnitzHla03ty0244NTX239qMpOZBKbSMJZCM=;
        b=miDlz/hcaV8F7y8HE/IjdGZhEGFGOfUtj4KRci1+DCMoRUKRdCjOTHy6xBwmZfF6tb
         jWAVKtA7PIbX56IeioE1xrnkDIuFPT3AjHj1a5AH4WDGjYjoAXC64X9wYSHbbQeeG2B7
         eTDw8nwGy28TtclnV59/uzsj20+8RRbigI9nTtzt4ab1IAv2k/BLqpQ7iFkhFIp0R5wn
         4MXG56UkebdmsQGFr03+CFSgMm9uyOxHY3amF+rkM87eNvq5rLFiBvAD1zaZFCUvglXb
         d/kWrsA/k8sJYV5iM9hiQ5jJgtHkcF5AglcPtQ9T284JuIhRZuIrr51K0Kp+k4kLjEoe
         tyfg==
X-Forwarded-Encrypted: i=1; AJvYcCWvqYy7qb0sD+MTfw6HQ+VuZs0ErpswJOogsfBlw3CuKVDu38l035M5cWmSjHhYQpN2epKZCoCIzd4/W64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QcQjdDw5u72QPMJAgaiekS9Aw7byTRIFnqWxlnfScJYyq4TV
	84GR3m2lsdlVExcfApw2IaUyintGWy1W0rve3jX0K6z2GW16zNkXb4O01gkOnLo=
X-Google-Smtp-Source: AGHT+IHTFNEwi8Tgl5mNGmRza2dJvvg6NJOxBP7ZRRcTgGYGS4YXyziMSVzhUNWK6bum0ImXxbrC/w==
X-Received: by 2002:a05:6214:4a8c:b0:6bf:960e:3d84 with SMTP id 6a1803df08f44-6c16dcbf642mr136210126d6.40.1724681159148;
        Mon, 26 Aug 2024 07:05:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d52a68sm46958906d6.44.2024.08.26.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:05:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1siaM2-00BycP-4x;
	Mon, 26 Aug 2024 11:05:58 -0300
Date: Mon, 26 Aug 2024 11:05:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Klaus Jensen <its@irrelevant.dk>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 2/6] iommu: Make IOMMU_IOPF selectable in
 Kconfig
Message-ID: <20240826140558.GJ3468552@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>

On Mon, Aug 26, 2024 at 01:40:28PM +0200, Klaus Jensen wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> IOMMU_IOPF is no longer selectable through INTEL_IOMMU_SVM effectively
> severing their relation and allowing them to be used independently.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/iommu/Kconfig       | 2 +-
>  drivers/iommu/intel/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a82f10054aec..d3ee8a0ad4a6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -164,7 +164,7 @@ config IOMMU_SVA
>  	bool
>  
>  config IOMMU_IOPF
> -	bool
> +	bool "Enable IO page fault in IOMMU"


Currently IOMMU_IOPF indicates that the driver wants to consume the
library functions around IOPF, it is not a user selectable because any
driver that links to those functions should have them working. If you
want to make the core driver use them then the select should be moved
from the SVM sub config to the core driver config.

If you want to change IOMMU_IOPF to a user configurable then it should
have a full help text and all the kconfig places touching it should be
turned into

  depends IOMMU_IOPF

Ie you can't enable any drivers SVA kconfig without also picking
IOMMU_IOPF.

This is doing neither fully.. Pick one :)

Jason

