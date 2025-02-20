Return-Path: <linux-kernel+bounces-522777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D932DA3CE68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E41A189665D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC22AEFE;
	Thu, 20 Feb 2025 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="irvYvZwr"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC02AF12
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013471; cv=none; b=hJkSERvl3g57KlHpA7dp/sZ88dAXpbdow4A68Ep/FTgoZSZKgSkuqkwS7xvvGdATz1WqS9n8nKOGUb8bEEG/McWUGHgCKZUokLK4kxPg3HDMO1LHra/EkOvPmudHQDatkJamVx3oX8wr63qSkuU599EEBiu/getJE5yYmIUHOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013471; c=relaxed/simple;
	bh=C29IJtFpYGRYKsWTYcgC9qheUzdabqeu5JhpvwBda6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vkhEGsu+d4V5Pd+k8K88/K9FOyyChfEpymCJDWVin0W/HjBd30VY4AbX5mcU5aVfpZ1XsR6C/EY/9MP1BhVi/lNONdkdfLFnqZP6dHVZRhHAlqPYn7TqfxuXAJyNVTKzDhdYr/dKQChVCUmQrVBP/wKY3IdUBhk7Dcyxxn1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=irvYvZwr; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd049b5428so3761916d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013469; x=1740618269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlBB0aKQKBsztfZQlifhRLpsfESEiLzHxC3ZCafSuu4=;
        b=irvYvZwrfRs14Kb72xVGJPMS4m3csI6Z3LqSyGhyCcphEMWdRp2Z0w6kzbzpXPtQun
         YJPydt7n+E/GzArRPBcepda1abKWp08X8fxYgyerMoTDacw+l6qQ631sPFcYYo31FENd
         f3IgW6o/Samtch9xGCCCrq0GQPwgG3cTfLx4qbPaqfcJmRpREbI4B5xkFVVB726qOYfx
         R3nrrT1XXnit1uhYL2F9Ky11WZ9JH5F0rHWhB5Akxp50wvIM8IsDjmq+N74+CnoDI58k
         kK17Iy5niaw/rfn5XwuXCfIvXpfniRGl/qXtnV1igTgpO37kZur9PDh4tXX21Kb+9m9Q
         Vx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013469; x=1740618269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlBB0aKQKBsztfZQlifhRLpsfESEiLzHxC3ZCafSuu4=;
        b=izQqqnW5wxG9OoP7bNeR2UL2GA9xsnJcvh9sCt48UMLz8IrCdcAWtk9yV8bBnP+Td8
         vCBZKFKDX2vfIzBC2PJM9xGsl48vBq9dzwFd3z0HinCjWYexQaU0eZLiQyxFO67JQOQe
         o0J3Ogk6rlHFsX2aO4L1OLO7Z01Cti+cU2sa2QfEt4tITxCuFCJJwzZKMdD/LqOyUHW0
         ws6BBCfjjul545Q96TUXaO8G+wx0D9pPzYd4U35R7o4dHHVCH5GU0X2uutAkXa8F5O/a
         FwAL5pMIj8ZzVWmqDyQUEyJKb8q3175TWFUyqoU5pO+dL3Tfo/J1QBsGAijz1RiTPu1c
         lmLw==
X-Forwarded-Encrypted: i=1; AJvYcCVuEoc/YNzl6WSeptS/09fwhTEQ4blQgGqFPMMyhRHiLEmyeTvRtjhg6n5qmys0thRAPldi/3kMxhjRg7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTiD+ZIKoEZ8XxZv/AQMKKvTYYWUxP0Mr2ze9suJ38GwMyWodu
	Cnq0uJtbe/rNl7pxF/GfDEbPOCODTuX3OTNkUFK+IPTPL5DItXyU+BoE29rfpsA=
X-Gm-Gg: ASbGncs1PHelE+pKRKD2leLu8o9F5INbtCsbt8gQT2xCEo1X7Gcd4AQ6hi1l+ScwpQE
	8YvD3GjXWKrgjyfrCF7nS6gQc5RQvzqHl1fcNbHL3mf9wY81Y69n7lkMmTP6D4dxhEkm7cD79C5
	khmdD9oisPvOvkBxRIaNLXRMCUzvdTnSp9NUEWXXI1zhlSGU6vz9cD4N2ZQ5fmD/1BHWodEtLPt
	DxpJ8jn2Nxt5KzEfJzdRkViDH/CSdXaPvKWddrn4fjyko3HY15/3EYjG+X09jXPSxCcVZCoYUf0
	5LwSlVQzDsr4JGFYcrqNsIbaEbOEGDXewCTRZ+IxQgY/1fum5nYOQNL7ayZIbwbm
X-Google-Smtp-Source: AGHT+IHcrI2Sdpanjxyb1AyuOiw6ku+mWhPj/GzEld6OBXyHMhT/tZ6FK6HNNSZLEbKX+mPhf8xznA==
X-Received: by 2002:a05:6214:242f:b0:6e4:4331:aad9 with SMTP id 6a1803df08f44-6e697499339mr90259476d6.2.1740013469121;
        Wed, 19 Feb 2025 17:04:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3b64sm80749506d6.50.2025.02.19.17.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:04:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuzM-00000000D8L-0kGU;
	Wed, 19 Feb 2025 21:04:28 -0400
Date: Wed, 19 Feb 2025 21:04:28 -0400
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
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010428.GT3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-12-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
> The iopf enablement has been moved to the iommu drivers. It is unnecessary
> for iommufd to handle iopf enablement. Remove the iopf enablement logic to
> avoid duplication.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/device.c          |   1 -
>  drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
>  drivers/iommu/iommufd/iommufd_private.h |   3 -
>  3 files changed, 28 insertions(+), 87 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

