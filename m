Return-Path: <linux-kernel+bounces-174588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA08C112F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A121F22F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AD15E5C4;
	Thu,  9 May 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jJ7hf3lA"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5C13A3F3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264875; cv=none; b=Rmnx7iJ/szxECV8LbXgIN0h68KSXdbCv7RcPbPaVuL+LAvQThVUoSbNiavAztB6Eo9/g/IsC5JWkiCOSX/1wpZeRiRikljMb+CIyOcvz19gsoWs2G7zZjiucaS0W1119ig5mm6i+osthvl03gX8UXSwCv7IjpTOC1rj2+GQh39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264875; c=relaxed/simple;
	bh=1uhfhafS4VV4PHgoUQ5TuHqPZNqpK2JZEVOjHwXCYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZysPV9OLo2R0IlXjXDodi1KD7uS08W77Wpu7axtGao+Xghv/eWnBkODFlM9xgato2PMJIsYG8WLAR/2d3zM3qhcyuGss8gkysYvQgzoFM3n3UUSXKefcP5DinuaFyw/9Q15OTVMq+WOst492wjS3H1IL2+sUFTrd6nHh3OFZq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jJ7hf3lA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso17280916d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715264872; x=1715869672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4S6reri4cKofwFkAd+jT6QPIjidYk8ttTypd2kM9f8=;
        b=jJ7hf3lAKtb0JDNMTujXCOVH8rsPLpILCiPsHe91x4kmG8aWyUV4PpGpRq+TCXHRzL
         mwP2h3GyjeTHxFAFz++ZoIQ/mZ/3gkc+Ov2dl+VlZobaYjk+O/N3goaNkzVRC/+tZTqt
         M5Q9mApuPsc/SU7tZjvFjtAWvfuHpbyka44A3QGbbwDaVZPZATi0I2MQ2gxfjRW+yC5h
         r0geQRDUPRLK+KUpq4ZqUYJ4dlQXrqouu1+yGYLhk47u4p4IsqbIRsrwk76WG3SrMfSU
         TfNMrzR5vi4983j6dVsgitg6gmXfZsdI/Up6mESCUP+LjdIMCPJgFNu+O1qCI6Swdlqu
         rb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264872; x=1715869672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4S6reri4cKofwFkAd+jT6QPIjidYk8ttTypd2kM9f8=;
        b=pJFzIepwCqgvzyHCob7qucqrtfE9tsoPuoe9+rPce0w1FDezHRCgMfWN8NZdqMIbHs
         FUlTQxSEs1H5UYsdEXeGJ5BeVXjltbINsDaGDNulLql1Xhma5Vj+3X2ms0HjYC3fmjji
         wZXK2GrBlh1/2bvvX5vx+kD4nI0hwBj6bmhabhauIvW2v6Pv2JGoXcb/zS6T8FVZL5mS
         x4ogZedhTBtv5hGPPJPTwQh5+WjwfISKeUdBc8kj9WcOYx1w+m+ZmCp5wYe5Oqxy4d5O
         i7LK1cYUJEIxTRmp0xA+SN5BGG8AKd6mReEO0egtdS1v3Nzt2noZQUjNQxoetFTt6HYj
         uHqA==
X-Forwarded-Encrypted: i=1; AJvYcCWH4B5czz9MJeCcU4TELaiKe9KjOd3MDIzu/DfFDzH3ph4JaMVy0qJuRdHeuwTl20r85OhsMvElXWscxEKrzr3dN9S2DSfo5hkSwMUy
X-Gm-Message-State: AOJu0YzMJuytUdwOu8rE/p7OuX6LuO6bq7H5txvLWCIkb2z2PvWP0iYf
	0G7jqVlEacBbAoVEn5yq1pTOvYjodYnX/LQnRzDu1mUZf58qPyGnCMD1WQwcCU7a05kTEuLCz5d
	t
X-Google-Smtp-Source: AGHT+IHRAhh8tN9+EXuub2af5CR+HcDFKY8azEps8iXW3JQRPsiXf15qVWgu8qQM1DMkblJTYCrgJQ==
X-Received: by 2002:a05:6214:5299:b0:6a0:c123:8a78 with SMTP id 6a1803df08f44-6a15cbbdecemr53529646d6.6.1715264871839;
        Thu, 09 May 2024 07:27:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f195018sm7556076d6.74.2024.05.09.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:27:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s54kQ-004VPm-Kb;
	Thu, 09 May 2024 11:27:50 -0300
Date: Thu, 9 May 2024 11:27:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1 1/1] iommu/arm-smmu-v3: Use *-y instead of *-objs in
 Makefile
Message-ID: <20240509142750.GT4718@ziepe.ca>
References: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>

On Wed, May 08, 2024 at 06:15:55PM +0300, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Note, the original approach is weirdest from the existing.
> Only a few drivers use this (-objs-y) one most likely by mistake.
> 
>  drivers/iommu/arm/arm-smmu-v3/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

