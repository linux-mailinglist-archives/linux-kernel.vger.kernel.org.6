Return-Path: <linux-kernel+bounces-221322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1B90F1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7E8284388
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28EE1509B1;
	Wed, 19 Jun 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JG7pgCYj"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394B14EC56
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810029; cv=none; b=U0eCscbZbRIxhr0b1Oe43vDPQoexhhkaFfsydZkrpFCZlQoZqvkQGn0GcW7D2yMqMCk2K0p6bLnvgbPLTkyZgibdY72eDMvlF1o3CFJjkPJ01am2+BlVxdvDn5NfRZnCeHLiCy5lDtuBaLi1uYL8vsuMUKnwYz4bPhOQrT9b5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810029; c=relaxed/simple;
	bh=yCoQElFg1DZuHcJL07Q4G71YiiZQpFnXw230Y845qkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWlt/61dEjN14KQvxqE6JLV656gMBoRg5XbUlYz4mp3xUgw5ojTLe1B0VMNOAjRQPLv1atErRyO/nM7jCY4KGXinS7jMZJUnP760qNEliyPClq6svoU4Sw33ecQldgAFzrCGaHOwV/YJtZiltdgaAy0SxYpratyRBo0kYRbbjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JG7pgCYj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b05c9db85fso32880946d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810025; x=1719414825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moEdRVU3PoPlgPdcVkukT3vEmMSfRXd64UiQM7jDSSo=;
        b=JG7pgCYjQwvgBP6rgxo9vrIQuhmeUTkWel+2Uuoj9Hhk+TmQGrTGZ9G2EKrowxqpja
         /g4RRhFhbwupCNsHZeUjkYNXOEiA8ZlAFT/vDKTnRZZ1w68/qRe1voaGWK6XuOZLnr/6
         XWUE7zoa4pyCDlhBBg2vRBvFFu8fcE2FZ85B0FQ+rbs8TKB+c9M8VuGH9PzseoqjtaT9
         DeaHS0ry58iJj24YdoosMIUDEm4jZ5UZGRYwrYASRBNk81FJsC5tUezJtyyfUTwYWPsI
         JJO63tsSt0j61yLkUtyQ8ahQq+CGw2SPQXwcQfD+gev+FKkxN8Zwrj3btkGFK1WlTuD+
         3HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810025; x=1719414825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moEdRVU3PoPlgPdcVkukT3vEmMSfRXd64UiQM7jDSSo=;
        b=clFL9HucqImLWuWdbtXlGkI+U/SWUdYQPe/v+Cx0RnzJ2qwR/oe9/tSg65Pm4qQlS3
         hBbh3ov6upDBmL4Vn7LQA0B4jDo7ezPWQEFhS4gzXf5E+RvpTBHpFsZye366UAbJxAXp
         0YO5DhfzD3p02Mqg3qhl3qtllRwyfvsE1icZyGvIkvDT9f1kK1Zql+JuFTVrucGsfrBQ
         sCvp+kmgkB0ZtfHLgT8Gcp7Xv1DzuSsag9GAOAgVivhzfPISd64Po9XR7XhhtzWHzsZw
         abyIdVyXvDmWoqnse7x0GwVSNwJEvRsSO7aThJOW17CgL0YnEE66d+E2WLILdLX0S/er
         dHzg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrq2qQp/YrPtU07TSAHqa7/S39LM+5iMckv/wMa5ob4YIDi6FALRU6/3lVKpDYnhETZR/SAt8S4KdmZVWDgVcM/FXsXG0e7dniIul
X-Gm-Message-State: AOJu0Yysa062VBrfM5KPNe1srrFDtnFGr2LtR5SxGzlYXxfXZ7e0XaBu
	SuuwOdyT9ECkZsMx9dsVzHB3UaSkE58DTWVNGNIXzIg+a6s5sg/6NLTa4Shk2dk=
X-Google-Smtp-Source: AGHT+IEJkRZBkgVagiNpl/OtqoGC4d9ZaTPjOU1+2kFAPWdp2oRDjZmssY8YvGAEYa4O75oAH2+OSQ==
X-Received: by 2002:ad4:5849:0:b0:6b2:b3cd:c323 with SMTP id 6a1803df08f44-6b501d22234mr29977206d6.0.1718810025609;
        Wed, 19 Jun 2024 08:13:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2dea97206sm26986726d6.84.2024.06.19.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:13:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx0K-004nTt-3N;
	Wed, 19 Jun 2024 12:13:44 -0300
Date: Wed, 19 Jun 2024 12:13:44 -0300
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
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/21] ARM: dma-mapping: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619151344.GJ1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-18-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-18-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:51PM +0800, Lu Baolu wrote:
> Since arm_iommu_create_mapping() now accepts the device, let's replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to retire the former.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/arm/mm/dma-mapping.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

