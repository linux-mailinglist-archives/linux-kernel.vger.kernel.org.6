Return-Path: <linux-kernel+bounces-199223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83A8D840D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF321C21E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073D12D769;
	Mon,  3 Jun 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hv+/H2aM"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D52209B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421754; cv=none; b=NgXYiOg4X77WNCk6C8wcxqmh4zjs9lgV8vOUJVmoGdomj8mX6ktGTyZslu+SoK7PTwmaVjd3XREhYwcjMFsPQ0l4mBATpGQ+fbzNtI2tAfUQEE0HqxCk9jrYyPek5YLsByZZILYT0m9FZWEh2HE7v+G8BpHzikmC2QDrtjPtlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421754; c=relaxed/simple;
	bh=5vkjRRpZm+wtBgmWH3raHLW2cMefR+vkRLLw6ojp6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPUtfG2p4ogLBrvJHwUz7IQ2LHbqHR6IFvPoPtHoWIgkt6MVKo3fRJLK1kKksQ7lfTHe5mwcVXx0Fpt8ZU14kNoSf+BY6qom5DFGYlqc7FCKv6bFIJgq42n6yH6l6jkmpieo40vHiOvnlJ8RXnaxkWZTXOhDw2StND8PeOBHYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hv+/H2aM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9234e4261so949713a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717421752; x=1718026552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpQgkoNkKgb0seCNmhxhfzV1gHyMbT/I1OQXluiQxwc=;
        b=Hv+/H2aMA+zzZaFolCVdhJ2X291EPbk2IjoSmwbmNwau7IPgIZ1uGoQBGpWCLDUNrb
         CgSbnY2pmoyX7RgXyXJnaAKFQ0ilRYJBVEFYrVzZdyiZUFu13U8TIfhDXR3AvTGTFNM6
         LXY7H4bMVj9zhh5eXz5s+t9yzeTss9HRDdVchd4gwRyoPStlCVhi8ZqaPdzPnKjYfDQr
         dvQrOmNYs2O5ErVC3xhRsCdVEXPj598rep7FMh5F6zDJTPhvzaWGVHxNoX4PsJ+j53xj
         tLc/x5ECEyFKwDYiNK/P/rxf9nqNTiblEamNT8IgQQaG6seqhLG6JzPZoSeGAjHdakAl
         MMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421752; x=1718026552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpQgkoNkKgb0seCNmhxhfzV1gHyMbT/I1OQXluiQxwc=;
        b=nWRDwEXR78i5ZnZUpL4GukOXklPFSfFiqSOSTspqyljmTjINFGcR06icknL0rCCUoG
         GW2oFbqKMNWdGs6O+AM93cLxgb3OHC/cRN8/scxoLR4N4hLNBI+E3TEG+TBwVgMC46N8
         gVMBpZik5GK+IHaRAg9HbanEKg15CBR92oGFACpW2zOw9v1fCBziDkgR7EXQwLG78r1P
         US1hb7PfSgAbFGEYIh6ShABOWmy5X7Kf5rFQzP9RwV43yqzuPKeNa+nE7nPXXu50AhQ1
         ZuwkuWgAluX1tJ6ipDN7qgaOEtNHXivvJO34Ck8XOB9EdPGNrgGV45wCxzYj/iKiPKEN
         49sg==
X-Forwarded-Encrypted: i=1; AJvYcCXSjKtjZ+odyN9QnvPG2UmdArlWeEe56ar2mJw9Vo+RNsm0LWlTVJaeRpQ/R2R+MxWsj2JKv4z7zLbAjtGWtblSSNz0grf2/yRW4Rfl
X-Gm-Message-State: AOJu0YyHKgO/9/SeU3krs7BP5aDiuYH9rFE41qPs39YC5E5JnN380lQ2
	o5dhGq4kZfcnLbzZt7Kmk78y3Ra/B7WWNMoaX3jR2I4HWB855PLzidV5fvQi11c=
X-Google-Smtp-Source: AGHT+IFk+PIg9jr3UzWb/ecm5ANWBtqD6TQzpjGRhkl/ZcSOByIZ3UxqiIS2caCT2io9CTuWhRCjQQ==
X-Received: by 2002:a05:6870:c1cc:b0:24c:ae57:b4b9 with SMTP id 586e51a60fabf-2508b7e469cmr11967214fac.14.1717421751641;
        Mon, 03 Jun 2024 06:35:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3172d05sm283188385a.113.2024.06.03.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:35:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sE7qo-000Eba-Az;
	Mon, 03 Jun 2024 10:35:50 -0300
Date: Mon, 3 Jun 2024 10:35:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] iommu: Refactoring domain allocation interface
Message-ID: <20240603133550.GA21513@ziepe.ca>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <efd902f6-eafc-4a26-8057-bdd9d7d6e535@intel.com>
 <a1f2c08a-e92f-4080-b55e-8d6dbd94db78@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1f2c08a-e92f-4080-b55e-8d6dbd94db78@linux.intel.com>

On Wed, May 29, 2024 at 08:02:12PM +0800, Baolu Lu wrote:
> > > drivers/infiniband/hw/usnic/usnic_uiom.c:       pd->domain = domain
> > > = iommu_domain_alloc(dev->bus);
> > > 
> > > This series leave those cases unchanged and keep iommu_domain_alloc()
> > > for their usage. But new drivers should not use it anymore.
> > 
> > does it mean there is still domains allocated via iommu_domain_alloc()
> > on VT-d platform?
> 
> I think the drivers mentioned above do not run on x86 platforms, or do
> they?

usnic does.. What was preventing converting it?

Jason

