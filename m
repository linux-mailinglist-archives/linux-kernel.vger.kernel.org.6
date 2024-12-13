Return-Path: <linux-kernel+bounces-445466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE99B9F16BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800CD285AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464318E359;
	Fri, 13 Dec 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2gI+lfb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A918756A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119341; cv=none; b=da+OTLBbSncBVdbVRZNUSnuKr0dSz1OY8xQJJ0Hv4i7sLCG4HS8tzLLNBk0nMgCdVLFkJFX04UMnlqqV0Nmc2YxsTGi5Js5g9FGe2CjF4KJpsPA1UMFnq9REe4I2mfet8RrEvlTIgCDZZiG6nwuQgvNoxkcZtyICgsQuvm8wOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119341; c=relaxed/simple;
	bh=Hcu+xxfk93UjbX+XANzHa25tjGomPC71CobQm6FJoQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS2h38SObcT4uT0hmCoRSmXS7ydrz48i9u7PBjxwuCJP5cGeh7IjK+GxCszX8ne3q2YiuFRf/haKwX839ZExBHtQ4xh+ng4TQxXNUm96AnvL/+QP/0WgIyxo85TYeypcFEsUwZ64q3ktP2rt0dcaKUfiDHGx5pTd8JcWkBH3W28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2gI+lfb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso10435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734119337; x=1734724137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTudxL7akG15arLWgUhGBbqBkCySihKjSTxtiyHKj/M=;
        b=q2gI+lfbinWfGnJurmSCTjMGFjVUJH5KazdeUNAGYQ+r6r0c5h4RaLm9IfGxlQk9sn
         eFUh15XLrkmuakEj7+9SoUmGh6ao0t5oWdiY+7eB4tIq+D1qtL71d1ukymHbvtVSL1ZP
         5Cnq+jjg/eTp0AvWVi2/WIemW4ld/MoRRX/1VVBuVBVlxvaNcH+lChyclm/ZBKw/WWBA
         cMN9GnhP8k1LUk1CWWKNWH/A3sZn+ki9cFgoe6GZ8Aovdt7GPt5ez1OkUtKB1CYDjnMP
         SMTV1hHDoIeGGMENiunyIGKbz53LzNK5pK1wGo6v/UysDCeBe7eg5ybWXS+0YcCuP3pi
         Ab4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734119337; x=1734724137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTudxL7akG15arLWgUhGBbqBkCySihKjSTxtiyHKj/M=;
        b=lHRc4Zg2xJDnaJk4XxrrcrXSqE3uTOpKfTvuV37K8sH4FBuFtJzFORbUC0mb37zYpz
         ARCy7QSXMqSk8icUF3f0ZiYDxpi6YE0pKhU44UNeyTiQzait0+ZMSEUFFWF9amZFRHUr
         Mgm/j5Hn4BiICGLQSHw++b7G6Cfn3ZHOBQg4QSUKA5xD5MTp13Wo4runc9THvN/aCqtW
         YFtb8hg1bR8woKntfSPR57dF6WSVfSoG4Pr18GQdgAoD+DUmIj9DDn1uQQzRnBCcacGu
         FKi+LUhDzeOltRgnEGGnCRi6ucKgouVfDfl+mw1YF/580CHLL4XUdDwUha3yfuHapLvU
         mA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYC1WHm68sfPOG9jgq0/nEp57+3II71cXrs/P98EgbJvGldBdjVznXZBp6RNfbu1abXOfi5WexkgwJUog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEUsVaZsnQJGlEIlyRMFjaf2meE6yF6yqcWp2srDLr+n5AzlE
	KYMgFNsCXsN/IMowGhT9Kdfo70rTwtnJxjTnw40jg260l3PFefF/bGTquJU8fcNJdhEu4T1ylA1
	leQ==
X-Gm-Gg: ASbGncsst9KRnGAKfSUnfQtPWkFUS6KYDAAE4C7XTEq/cKKai00tkLzqcZZNaOZBGVa
	I299ZVcmdtmY8P7xhj4k9hpQBUoLuQLLIcFrRL+gd4bkvQiJ/WKx5L/u64oRH49H1MlRqkNYZU7
	S1ozNcckKxm8O3HPN3k2jOtZ0TIctBwWVe3V+qryZdA8EgW5x4PJgp0pS68oFbsoSWtIvIq2aUy
	X+6cdK+iFJdW9a16S/RFo/XzDt0u7RPTZjhtPrpOCatnH9+R6VkschV+HUaFW6yp06s4w0CcQPL
	y5zeMPSEWKOD28A24UI=
X-Google-Smtp-Source: AGHT+IFh74AH+6TGpxyM/Uf5omXCGX0AECGGvFVa2XBNN6YOFzqhpkphP8YdxRAEn5U+Y5leBLnhfw==
X-Received: by 2002:a05:600c:35c5:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-436367928cfmr106175e9.4.1734119337464;
        Fri, 13 Dec 2024 11:48:57 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806ce56sm342452f8f.111.2024.12.13.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:48:56 -0800 (PST)
Date: Fri, 13 Dec 2024 19:48:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 40/58] KVM: arm64: smmu-v3: Add map/unmap pages
 and iova_to_phys
Message-ID: <Z1yPpEn_MElCRzLG@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-41-smostafa@google.com>
 <20241212194435.GA5484@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212194435.GA5484@ziepe.ca>

Hi Jason,

On Thu, Dec 12, 2024 at 03:44:35PM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 12, 2024 at 06:04:04PM +0000, Mostafa Saleh wrote:
> > Add map_pages and iova_to_phys HVC code, which
> > mainly calls the io-pgtable.
> > 
> > For unmap_pages, we rely on IO_PGTABLE_QUIRK_UNMAP_INVAL, where the
> > driver first calls unmap_pages which invalidate all the pages as
> > a typical unmap, issuing all the necessary TLB invalidations.
> > Then, we will start a page table with 2 callbacks:
> > - visit_leaf: for each unmapped leaf, it would decrement the refcount
> >   of the page using __pkvm_host_unuse_dma(), reversing the what IOMMU
> >   core does in map.
> > - visit_post_table: this would free any invalidated tables as they
> >   wouldn't be freed because of the quirk.
> 
> I don't know if the timelines will work out, but the pagetable stuff
> I'm working on will let you write a much more appropriate
> implementation for pkvm's usage than trying to hack it into the
> iopgtable code like this.

I didn’t check your new page table patches yet, but I would say it’s
more likely your patches would land first, because as mentioned in the
cover letter, there are still many dependencies for pKVM before IOMMU
support lands, so I don’t mind converging if possible.

Thanks,
Mostafa

> 
> Even the iommu focused routines I have got now would solve this
> problem because they allways spit out a linked list of all the memory
> to free after map/unmap and never internally free it..

> 
> Jason

