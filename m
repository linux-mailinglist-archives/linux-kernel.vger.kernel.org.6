Return-Path: <linux-kernel+bounces-221206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73190F04C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B01C20CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D281946F;
	Wed, 19 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ao8Ygeue"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15828DD2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806890; cv=none; b=Va+pfWO00S8SvOaXw0zNHrEVrTw/HXe9p62O+eHifrNCxQ/PqyDi2I2bmg7TwtmVd4I7Syd7+oTPS/uJ5xcApX1YMSia81Bw382DVuc3Q6kinMHqhX4zU2nZ6DmXpcaOz5XooXY6TzX4G11j1dODC/PDVgmnhBrIVJ8KeYbWIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806890; c=relaxed/simple;
	bh=jDmb7VW45DnqwAzmE0G7Yx8+dpvdynBkwVU5igS3sOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B97PzNQ+nwfFchmP8TY7jaoQZQ7sJsIlNCedGQMe8t10Q7D2hqnmQMy53/Fe3vNWhacKbxi1VDWlxtmc1AeWP8e6F3SUzYRnIiNL+5a02TayHWiUr/TZCa88HiGAmiYfeCxnRT6auucRGrUKRA8RiFDVFYIU3vvH0i9vzIwQ8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ao8Ygeue; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9d70d93dbso4248566b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806888; x=1719411688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXd93FB8mW37LRaoaeih1f4UeSXMaaR0S6po9oPAKCU=;
        b=ao8YgeueFzTO4hq+L8u4sJ6dQf7Cxy5xxMCUhFYkXjej6hTmg7HrBVzLrFDNRv4+Aj
         5vbbPLQ5p5pjJh0CoAHsN4JdBjGPAroEkMMNP3U/kT8X9V3ZXUi4WwJGY3y6MrendmJm
         wGRJhPYchGDz5lpPB5oCpkOmH0k3sDKLSZruRMzYlM01Brzc2jGbSPFqNfDnX0lGYyur
         QMkA2xF6+Dxi5nMRvS3Avq9lgItKkpk69rGWM3z0sW0DSktKGvhB4JxBHTYm0Loy4LeO
         fpvmVWpU1QUdk0fc+1GBiwUHaGVzBNUNJ8NkcrvuJW9j0YIKasNlOxRq4Ot8AjvtuP3y
         nycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806888; x=1719411688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXd93FB8mW37LRaoaeih1f4UeSXMaaR0S6po9oPAKCU=;
        b=lgm2K7q8yM+2u77laOd0x2acptyb/H8Z0dq7LH5ChL+7bL1ZWl09qJ+0yo/6wrot1l
         j1APRyv6oWnPAKyZ/N66OMyz4muGtixEwvcU6kW14kmPwi6ZuzVsS7ltuVlsOXoxHvpw
         OWctJ57hT848nChpWqFPNnEXmofw0JnNtUBVWDb3/28jmRT8/IckwUMvWMOGq04PqsUs
         FhUbgpyBV07hC1MbX0m34MeVPD9dU+M7Y9fG1QnakhEEieQG9KSqlYjFddZJ5PUwIpdS
         +alTSKIGSkSqBXzk3SVP+R0Ye6dIaGgmAilJ7dpWAd69qKZTbImkLQmnLbgeXcUmbTEs
         l5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHZ8BuIg3nOIlad40hl8HC2hfNLDIrAkGN49Lk6BTTjjxRG9UlgkAaGvGkyZbWZHKCrJFIdWymdet06KAFWAQbdTvE7YTcWopN0v8P
X-Gm-Message-State: AOJu0YxzcjfORQBk4rWnrunz5vqlRBgN2ffQfkjYOTzvQSecxhvF7pX3
	090vE9zVGxYbINvEda/oll4cCSgqybIMgsuLos5ZaTSlwUgWFm5btDJZ1cC8TG8=
X-Google-Smtp-Source: AGHT+IGeUQCBPT+VgM+BpkPpQTiytNsNv7t22Ffuk+cASd5EIDo/hVSa+fwqc195JPldb8qsFYSfsg==
X-Received: by 2002:a05:6808:188f:b0:3d2:29d6:fe8e with SMTP id 5614622812f47-3d51b962118mr3218240b6e.8.1718806887789;
        Wed, 19 Jun 2024 07:21:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444b3aec088sm454201cf.62.2024.06.19.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:21:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwBh-004YeT-Jx;
	Wed, 19 Jun 2024 11:21:25 -0300
Date: Wed, 19 Jun 2024 11:21:25 -0300
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
Subject: Re: [PATCH v3 03/21] vfio/type1: Use iommu_paging_domain_alloc()
Message-ID: <20240619142125.GI791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-4-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:37PM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

