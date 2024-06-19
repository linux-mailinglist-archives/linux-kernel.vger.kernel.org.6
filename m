Return-Path: <linux-kernel+bounces-221254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79490F0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346051C241B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA802262B;
	Wed, 19 Jun 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cgMilols"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322781CD15
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807910; cv=none; b=Kf8rymm6llzeQ4A70H3WfnhIk6HavcqhA6TKPLwIQ4xIj0FInuHWWh8Pz+Sygnr5jFDfmh+c1QJ4Sbpgh8S5iW1PMD9HTM62TQ250LKPhadiKtm8b7HIP3j9/2XaP+zGcZFnMIGgZaIasfICC+hvIxGxyOXeoFpSQ0oRXzY7mmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807910; c=relaxed/simple;
	bh=vHJZR07TDsfMQhSOpJNQ7ySVcEwfyhK/k1s8y8Oef78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBGHGgh0GHu4yb0jSzLefK5pPhTe4Rm1TiLido+D6UnBCxZgbm7+7qCQ/UshMTfAOU+qQajil2kHwpNol9f650Eyh1AxPsPuGCvHyU7dgW8qj4V2DCsmxNrFM3NKA0Q043JVhYh0w4Br6Nu1M9W3AbC+YESgQZgKPrxfSPzqDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cgMilols; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4421c014b95so7906911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807908; x=1719412708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eSifi9kzw937hBs9m+vGjWLDbN4rIVu8qbt3p8ubO8=;
        b=cgMilolsiUYk+2ryzymTsdMFNtxEIu2giNffwwDhHmhD2/AtZrAf5bnoeMcrf4xSLH
         iGHu0+rUx5iFussFMBuRfh2MENs0tzdZvx3LfTJ7iy8JyGhpK2C2+WIQzny3zu8Ag/kg
         zksyGxcX3F+QJSzrfwZrjYcLAAiYI/1MBv/RR3cnVry2tRYDSzmm4xp0yz5I01D5DVQt
         8hrzrZ96wvZiDxbnZsWjGseb/mEkjyfJ+HgzUQLyQRkvM82QRsCVB2FHli48Qbx9FKyt
         pznSae8ymmrEG9TKlSH5GegKD0a1XLa5oQooGuLOWif5rpjwCmncJMpvWHCvu5x8hSMQ
         gcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807908; x=1719412708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eSifi9kzw937hBs9m+vGjWLDbN4rIVu8qbt3p8ubO8=;
        b=KZaZbQe3su64XtFRoNS5Q8doRtyv69EgYiKGllNCoHC2BBhTDqXiiLy9BQMn0P1O9z
         Flcpzn4kNYwkn/JTfVT5Lafta87zLtfqtqmJD3CpaeVOhTje11vABQFAlBgO4hgfTtQR
         91Qaj6krkC9Xaf242mtRTgOLQuhl4BcFl9SmCO9KGpZ8T/tvtTXWGskWQvUyPuio+oV9
         Fb+jgCMH7wgI3TLN+PX1Dj3kj3Fr3Zm7Smsetnj4d7BVKK+/vseBjc2+pZR6SvxWbhOY
         vDt3Hpc9rco1uZYreu7jqT8xtLy8j7JYTX9O+3nt0WO0E3SlKhK9KbhdiWcrcvH6vn8L
         b11g==
X-Forwarded-Encrypted: i=1; AJvYcCVCGhxwtNJx2Wls8c5Juis4Oea8Io9FDdT+abhfwlyxKT8KNxRiMRSjsY9vZZHIcYEX0MDf8glh+eq8hkSpQ1yoA2zjCSMqxZtofl7y
X-Gm-Message-State: AOJu0Yzp2V6f2qvB6JSgviep6sI0rwsKslD7scbXM+uZD1kRTYEnM1uk
	0jSNaNkfjUqHK6HvRaLWcAm4jhkGcloj2UGZ3lsrCt7B+DScSPd3h3tZcfaTvOQ=
X-Google-Smtp-Source: AGHT+IGZSB/Brli4dklvGSX8RN5hj5Xa3TKJWnONX5AltWqs8DK5Wub0LYx6UoNFdFIIjbi83LBDQw==
X-Received: by 2002:a05:6214:124c:b0:6b0:8991:a2f7 with SMTP id 6a1803df08f44-6b2e230ec57mr96370946d6.12.1718807908248;
        Wed, 19 Jun 2024 07:38:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4f4asm77884476d6.98.2024.06.19.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwSB-004dXU-Dy;
	Wed, 19 Jun 2024 11:38:27 -0300
Date: Wed, 19 Jun 2024 11:38:27 -0300
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
Subject: Re: [PATCH v3 12/21] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <20240619143827.GG1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-13-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:46PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in rproc_enable_iommu() and is attached to
> rproc->dev.parent in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

