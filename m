Return-Path: <linux-kernel+bounces-201096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 185858FB957
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8BE1F21EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD2148840;
	Tue,  4 Jun 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R7c3xhdq"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569814882D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519505; cv=none; b=KU5uc5vQLngC7ItVHIb8C1c7ZttuuJk6sLcviFkFqcWdkvKzlKpEiqHItsyEoCCbky/z2e+mNGm5h9X7MTvB5SDYzJmTEZKRsavbwO7Mj185+iKwbvOamh7PM3BCsA7gA8YiI95DU3LguJLf3ngyvQF7kq9aRmIHutUUzyIXKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519505; c=relaxed/simple;
	bh=Jl68LcgBN1pRhZi6PtJEE4lVnKKYIRWjPxs0FDaFCcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS4p2Nj/wnKzDa0HzUjDSdy8copVX2nISsA6go8wW5DStniPjUTLVZqdxEwqh5qcJuCjKIrbaHu5G27xRMud2VJPL4hd/icb8nQmkXmMZHL3fxWMeQrcXHyVLM/KHosZXfjR0T4kIXR3XHJ5ZtKCmLv35VnifRLmL4ZI3QxFiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R7c3xhdq; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b96a781b63so2601433eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717519501; x=1718124301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13DrUW0wsjFsOLQQnsi9knf7av4PrVRrLk1t14myUlc=;
        b=R7c3xhdqDAsJ5hZnDQYawsz6d0Afl2byGWi181amsLb6UIToEqRaNyMIIvV8V1FPO+
         +2rxMaoZB4FWxfVk3UaHTtKGWGS0OdJ80miL3lrcyqZ4aJP+5RVM7fAHAj0jy7uTE7b8
         zgHEPFEhiaw5ZCCSZixrm1nRA6HFcwS0Z8yfiDMIBd1MxxgjTg8lAvpLPdhCCB2nQEx6
         WCBR0zGDEbaxXavQpzAc52H0zPkhGoN0cG2DjkjyLNeQ0ca4uOaDbL9u1/SzxqrFdqe4
         mQ1+Mb4Pw5LqLLPEtUbtKo9w3yxH58EtucIdCcSbLGjYdEdSidDQT3c+sq6PRh1PP4wb
         GdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519501; x=1718124301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13DrUW0wsjFsOLQQnsi9knf7av4PrVRrLk1t14myUlc=;
        b=JmEsFXeqrxfsghub61bfjq3r4GOIowO0Bk4F9tIOmBovoVK2dHq5GVh/g9AaUzpb5d
         ABIG6uHOCVBGbIPdSkRTcEdvydrsh6+jKKlsk0+Mud5PZUA8m+nd0mm1DfKw3hGgl/gt
         FAXGUQ/BoDtaUAlnbKcdT7T72Pqc699+4l4O7fDQmOs3zHPZp+iOssBshnVz+I5XDrXT
         ABEi7w9St5qofIs/vYl0xYBxHdiSVGpvjf06HoCE54l0GOWbN4pfR9Qn4B5MFWxBiMjD
         dUi/DKrBh4kw6Cn0qW2Yc3vQCCrlq98pLMxO3PRIir9wLdFpMChFk5npCG9Tr7AN4n3u
         N0cg==
X-Forwarded-Encrypted: i=1; AJvYcCUbEequg/DENwx+v+UN68tllB4bqPfs/0h9YsRKaG/P/0u387J2EC3OErc9NHZR0P9qSXuP0PWFFBEH+hoN4FZTTVKrIQeteocZlxjL
X-Gm-Message-State: AOJu0YyZ80naA+C8iDzHYacedYu3aoRv+Pu9QbJ/+pTQ6uBvZafU96Jj
	37M8spIRzNBIrNQNLKN/CidwjSOePvL/zU9DlP71lU69LUNF8zfAEDlEl+iAAxw=
X-Google-Smtp-Source: AGHT+IEfas1lnZdFNBRgqZxmKWv2oXN51AWEQ8aiqFcaC4Ca/kraXgYuVuAGXMg9aTheAhe7N7CZog==
X-Received: by 2002:a05:6870:4708:b0:24f:f297:3ff7 with SMTP id 586e51a60fabf-25122a6d964mr33165fac.38.1717519501608;
        Tue, 04 Jun 2024 09:45:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44009a2902csm30190921cf.38.2024.06.04.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:45:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEXHP-002tE6-4C;
	Tue, 04 Jun 2024 13:44:59 -0300
Date: Tue, 4 Jun 2024 13:44:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/22] RDMA/usnic: Use iommu_paging_domain_alloc()
Message-ID: <20240604164459.GC21513@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-16-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604015134.164206-16-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:27AM +0800, Lu Baolu wrote:
> usnic_uiom_alloc_pd() allocates a paging domain for a given device.
> In this case, iommu_domain_alloc(dev->bus) is equivalent to 
> iommu_paging_domain_alloc(dev). Replace it as iommu_domain_alloc()
> has been deprecated.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

