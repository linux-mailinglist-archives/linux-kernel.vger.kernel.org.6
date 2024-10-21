Return-Path: <linux-kernel+bounces-374356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F339A68E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D731F21192
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0201F4FA0;
	Mon, 21 Oct 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MfV8Nxsh"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAB1E7C18
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514780; cv=none; b=CrW8AKjjEQpfethgec6T+VoU8z1sneB6udIoaKTDGlO1HuoCjy+L4HkYbagttiQRfzgBNZ1zVsSetViLQ0Z0Niz02TdtxszOaggoDkIKFl6ksmSqGQH6lBNd5R5/Iu4AveS0G9YnPDJ1oPg//oNacxi0JlK3iCeLJXtDDWrkG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514780; c=relaxed/simple;
	bh=hxvBJwRtNcqjde4Bcp10tSx/EP4OtbCrC1TrsZa7yoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjz3fPIYowZpYsTDbtOSGi7OZpwi4dbO4TD6h+9/TKOcbXFVyXYlNB962DypJXgH4+T5KG/fucH/HfQQdDIlI2/FTm9rkbZfD2KjTnwKxzD+jxthQwAniQAnVwcjUw5v2ksBmhclcOhYYqnSNOGuzKivAhWnGxWHXyRmwIp/8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MfV8Nxsh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460ad98b043so24605731cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729514777; x=1730119577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KqBamHNwRSuVXvDqMa2+Op5Y2T6BUr3qtbGShSkry0=;
        b=MfV8NxshH8u/LmwGvy873WB3YyoHZcXoV52ydPCeK3dKhFp292tCm2UkvCZDnNqSOE
         mLfWXguMw3VGCZ1QuE1+Kh6aTVyp3vE3iM0t1hmUmeqO66HW9vD90P1TFrTYMAm5wBMA
         3TOJmsrIOkL3Es4GR7uGTvbk0PqkRO68rjrzJpFx4AlozO63DX3OJOG82SIQaUL8ZkC5
         tQ2TrjrVaqXLGfGnDjCDoZlIkvkO4+GTMOeMfYlSVKLiMZQIuptznF+lJo22FIpP6Raf
         x4A8w1IfGgxbCbj6C1RfYz/Aw9gS4tOZanOFVfc47EWQEcYmhxo9C2oTkMWdnOz3Ecta
         xhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514777; x=1730119577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KqBamHNwRSuVXvDqMa2+Op5Y2T6BUr3qtbGShSkry0=;
        b=sCZvEAUuQl8JfNrbN+m4cgTl6DMzjeTawSKkOZvLDcN7jWa5zWrHgKKNJGG0tdJXri
         ++OAdArejXKpnwobjgt4m4zn+oc8ABrsh6jCBCxSTrDOZrL5WI7xuIo/rBgrYdW4VO04
         wLDiyvI3+fD7Aytoks2BGX5K9I1K3wR/A+6CZxOw2Ej212AEnSVEflSFwP2MYZ1YEG+h
         LJM0OdCYq7C3Gg5qsKROJ1X5VgIcWakAsJiE+DF9vmt6ikZKq8wus2M/CH+Hs8S02mU6
         MWg3YwZEPdnkAo0U6TwQ+RI9XY6ifHaTqeI5R67OIf1+en0Cqa+O29pp60tB2XvgGqZF
         hkFw==
X-Forwarded-Encrypted: i=1; AJvYcCVDQ0xQhpCDIFr5IHIlJy/m7wUkSokLSHCSiv2BSO1cc3tlHjdePZsnN+CCHCWxSYc3MqFxFFlNDuEZTTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5W1BBOzmwB67zdcbvXNH4IHFX+2OGme+NmKRRBv3kRZRBrujl
	4U9SygbXq7yYHygfWhlKR4CIEIgG0SGr82ZouYdC8e/CPAl4gqiQnP56VwFixnE=
X-Google-Smtp-Source: AGHT+IEsct49HXAHsyxWnzioIo0Yw00GAMYfsud2aC0qPqa90PVNt1yTAnv4Mb9qPAFxVF2WWW1q2w==
X-Received: by 2002:a05:622a:10:b0:458:611b:ac34 with SMTP id d75a77b69052e-460aee9d875mr170497221cf.12.1729514777208;
        Mon, 21 Oct 2024 05:46:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c95aafsm17271251cf.40.2024.10.21.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:46:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2rnb-008HgB-Pw;
	Mon, 21 Oct 2024 09:46:15 -0300
Date: Mon, 21 Oct 2024 09:46:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Enhance compatibility check for
 paging domain attach
Message-ID: <20241021124615.GC3576661@ziepe.ca>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
 <20241021085125.192333-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021085125.192333-4-baolu.lu@linux.intel.com>

On Mon, Oct 21, 2024 at 04:51:20PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 433c58944401..96016bc40f94 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>  	 * The s2_domain will be used in nested translation, hence needs
>  	 * to ensure the s2_domain is compatible with this IOMMU.
>  	 */
> -	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> +	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
>  	if (ret) {
>  		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
>  		return ret;

This dev_err shouldn't be here, this path would be userspace
triggerable.

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

