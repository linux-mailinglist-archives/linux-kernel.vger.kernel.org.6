Return-Path: <linux-kernel+bounces-221325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F248590F1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA92880EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3113D525;
	Wed, 19 Jun 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kpdvThHM"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23521EEF7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810076; cv=none; b=RcviBYQxSxfcTkCm3loqIUEZcEnwMqiQ0ps4HdndkedFqR5pOCfQHj1F+fnNJSJlKmGPP29WqgfSpyAVh1CmLSraVi6yl2QFFT4L0Ej3GSniLHXiLG/K27oe4Q3D0NH9j7+cnzx7N9ZfexSLatrAoGScgwFMscUNBaJ/p7R2tAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810076; c=relaxed/simple;
	bh=HY7zkgA9tZJI2Xa1OwMokfTgAVoJ8NTLRZ5ONf6HCvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaK50bWUxSji2YFBpGkvEDpt0tqIGFxV2CQOUl21z4Hl58eXcNGs00Jk+IOxcu6mt9U3fqAcn16VAWkPFGG5g/Rc40MMVrOtXsv6DpYjNRkX1NPyD4lEBGBNhoM+ePJkA6y/clZTxmlu8A8wC+NbapBgD/VwyXnZViLE8/t/W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kpdvThHM; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b9706c84e5so3863110eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810073; x=1719414873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FK6SjWXdq6bSAPX1rh4xTRaTP0djMJZM1guOyU6PPog=;
        b=kpdvThHMbodSa3T7Dm+vm3ztVxlsqQnWVp/aFKAHuzwQTuKmoO+zMXcoRl4IadP77n
         +asr0fkM0fqACeKB/FVFhnVCWxY/HoTC4ZBS31a6LPnH7h+aluNjIWRRyCgc16BpNPC4
         emCcP7KxLqM8nR47Hqe7ePYXyouYt30NowtePQC6uTmUeznOz9blnKKeGLuy+1BN0Yse
         zYqGr6ykTclsjDgGGHwOZJW31DDkHulyXBEGYA8z25aUdMLH5kq+KE7lchgIE5+4tRo7
         ZtgQhkYoRQM88cK+OYivUJXLV0JqqY7ehxep2xje4v/pGuf1Ob7N6C5pbnsEk8IHUJDA
         oJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810073; x=1719414873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK6SjWXdq6bSAPX1rh4xTRaTP0djMJZM1guOyU6PPog=;
        b=Pqno+P/H37lONc4Dk9pB7GsLpFcWfb4m5B8qIOw2u2wyKTPAELjCq12ZbVxalaN4sY
         aCaEOESmCsYobZckFrboRdvRCDTyunAj1EYQKZ8fiMt71nZuBk2J8iB6apYg4Jq2mmyM
         PDj9P/HTWCObcljdsywpPejze338zwwJHeClQOEIqcDfvhyiqujggc/926rNkvnAMLAu
         J6gCH/haNjCf1p7N7a6I3B73K1I/5FrtiWU8ShpJELBabXEXxGryMf9cFL7V2Mihfe+6
         6YSnc0KVgoLAFH5VfyYeZk2j3IMc9I3pyacmsQRb8DpYxneUMuTHkhS+bg0kf1M7NGnk
         46Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW+L++Qh8IYL9EU1WoPOthPMtv7qwp5VsamPJz/kUXDVF9tQkvnE22+0He7F/fBCEQ0JprNNcKEPLX3uAYJzX2GqssBAdDubP8AX55s
X-Gm-Message-State: AOJu0YyEAX0iK2dq+Iji7UEeSndNuf4Myjx3QhQ7H9i1fGRuFD++bZff
	bF+esjenC3jnSx736MkVb1Bom7FAA9BZOFFc0VwlzesUWeTHKQZKN4PNLtKp/sU=
X-Google-Smtp-Source: AGHT+IEfWtO517AiTmrP1W6dPNlAON8bn6xv/7Wv+S6voiPx4xyrmyITXKPZjbJGoypZCOWemcF1Kw==
X-Received: by 2002:a05:6358:6f11:b0:1a1:cb05:243c with SMTP id e5c5f4694b2df-1a1fd5cdffcmr360413155d.25.1718810073496;
        Wed, 19 Jun 2024 08:14:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc068sm613342485a.34.2024.06.19.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx15-004nig-UU;
	Wed, 19 Jun 2024 12:14:31 -0300
Date: Wed, 19 Jun 2024 12:14:31 -0300
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
Subject: Re: [PATCH v3 20/21] iommu: Remove iommu_present()
Message-ID: <20240619151431.GL1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-21-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-21-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:54PM +0800, Lu Baolu wrote:
> The iommu_present() interface is no longer used in the tree anymore.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 25 -------------------------
>  2 files changed, 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

