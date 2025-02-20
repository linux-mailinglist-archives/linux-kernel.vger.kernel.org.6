Return-Path: <linux-kernel+bounces-522774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC5A3CE63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8233B18959B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3C28F5;
	Thu, 20 Feb 2025 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eBKJbc4s"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BC130E58
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013410; cv=none; b=a3Vd2KB09GkvYxijIWocSluM31S5lyFE+R+2kYvMGloCGrAh7HeaEvm3q8fIPJAzR64fwlGYJkiCzVP/IvUFnYny5/aAY1thZGuxoHYOkOcDqoeIMEvaX1N2FiSGa14pL8cikS+tyIPjBjCMWvddJ03JebIbODj7pJ4WFYHLxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013410; c=relaxed/simple;
	bh=uoKT8mn2kqsuF35fq8S96ubypduruFZKYY1NqO9aO4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCKyC+ubqXEIjYpQa5v9/R3fFSIIW6tfEYiWwqoAFqiovTDIIPXT1kZndvQkzp1cvaBaMr1n+L01UGkaZiK+iBK6b+wRXusef7E9mv+Cjn4vbnDx9iGjDsa9UYeoYPYXtdegWM/O6MvYgy/oIU1P9Rrn2FVQQsodpYCdrOhv1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eBKJbc4s; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46fee2b9c7aso2964401cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013407; x=1740618207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJnHTfhhh5oO/5QVFdYosizxDAfM8S4m8Bge+zqnfMQ=;
        b=eBKJbc4s2xP1CpyrJ4qOgnTqn/nLX+0WIGBUeRieOTKpJE5d3YhbdiSjPkxIWn1sTB
         r8jpmyjx8ZM3XHbbs8hiOKHIskUpDBc4mjbsBLK3FHBYu48GLtbdXYZvOnSyT8HeFtgO
         Q/nHCALf3R1SBtwb4hz1h2+Wq9M5DYZnQcXQGpfRDGIDiTbt3SkewLARIRP8PJUFeGBo
         x6mj1Jhmehjgj5tDowoapI9cmpERwiAImVkvsDSJRrFxoPjsVNXE0ZTw0lraGyNC+dq4
         5agXdPWrxH8yh1dQxKUNgHiiWuqADHo7ShedWjMv4O8g9URgXZOGM9KXnogBEDt+0TuO
         y9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013407; x=1740618207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJnHTfhhh5oO/5QVFdYosizxDAfM8S4m8Bge+zqnfMQ=;
        b=qHIaOoQ04wU4Yp1rDet5sgvma3KgVbmjf/7oA7ZSbYX9znYLoPFoeMVWXGVqbzY4Hp
         eO8YZdIUt5w6tnLxAZmDeiXvAbQ8AIcgaI+vsCCEzyjm+Sy+cr0ZUGFrF3sQjDKVSYuQ
         TzLm2nmfNR9bbPSWYuv2Totprk5KZByxeeug79I9Q9uZKZmGYy/mLSpQ29ZmEBrVtpRW
         c1S8UQg99PzmvKqtff0V1Ok0xYJS29BipzpkRQxh8fFF9mFFDqAt27Qc72yTxkK5Wu6F
         y0jRByTXCFslhYYQaXLQuKVzOqgG7UvXi4DlC3hH6np/+qWXREaX5c4vXAXyzMAmE7y1
         COoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMwPdYHgu7m2kIBzeA1Y1GnBngtw4I6xLbycA+olhuRKjtLS0XAyrqUj4mHYzkiCyMhhVoWJvblmbiivI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDt9SpfPzAXPZ5vCgtB5JK9s5182oSGtLHtCSrVYZjDszSId5S
	EFjSARH2OvCH/r5gBJa3hLhpATM4pJxjBJ6X/pWPHHftDL3sbdgIurHb5WOheJg=
X-Gm-Gg: ASbGncv00AXies9Z3MirqeCaHV9pUrY40Q8rYS6W6uE5yoKrHwWa+UyoRmUFPtM58W6
	70xqS/1qEbOV9I4/iQ4PcHg5PoUKJVnrapMTszvLDQyS8OqiEpA3p/IToIZaTlRQ3Vgooy6iXR9
	3D5NAze/eLLbnhuvFysPc1OMCrlJlzUDxbhOCAbz7Z32fL1sdBWoiYuU/m+Xj9jyA5lsTOMa0TN
	yZB3r+UOoFeaT6EH5LgthgZugi45zaSetvz03krb/QOVztp1w8yngUUmDVbGZkKzcXYnjtVH4He
	geEaHbJxzuVW86YZKOIc8kPBSvyUaQTFgCoW+rv/3reBSOEg0zO2sMGgHwpf89yr
X-Google-Smtp-Source: AGHT+IEP0SznMWngJV+XmUdphWVKwsCLb8oL7y9FuJxNV2MD0qkEQHKc4YBhbpTr5rtelyk7i+YEMg==
X-Received: by 2002:a05:622a:302:b0:472:5ac:48bb with SMTP id d75a77b69052e-47217372cf5mr6048941cf.29.1740013407667;
        Wed, 19 Feb 2025 17:03:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472069c3482sm18629721cf.20.2025.02.19.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:03:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuyL-00000000D7S-2awh;
	Wed, 19 Feb 2025 21:03:25 -0400
Date: Wed, 19 Feb 2025 21:03:25 -0400
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
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010325.GR3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-10-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:01PM +0800, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/dma/idxd/init.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

