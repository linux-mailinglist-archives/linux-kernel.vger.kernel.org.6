Return-Path: <linux-kernel+bounces-234736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2291C9E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054991C214C7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B61B28A;
	Sat, 29 Jun 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OFv5uden"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2613AF9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623514; cv=none; b=NFqDnzs3L41fNqffaJEjuxiOor8Uy7zl7ppe5q7uPHAZzk+SjCVArwVzPSq7wRHus2N26SrSslPN14RCdD7PnlfbDFCkK8CrUeiA3nJdAhm8dmftdzST9E5RWsAxoVNA9Rwm8Ko0jsSXuHRDRllmvOvzu3yhlAUrA3zAFAMOFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623514; c=relaxed/simple;
	bh=6F/k6dwYH218Hyi1PGuaEb/Ijjso6ev6K6yn6UDiB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxZkNHAbCK8vlZOBOld6E+4zDjsEA3O4kZ6jPSVquo5ByU7tuZvDsCuJ9Jy+T5o94JYedMfqNtn0CcuIe08B2jqvYG5csPBD0msbWTwwQwCfN0sYOJpjOb1n4VMuyCQ/yO59+Ll7wWNM0f3XZhkbc6Z1+LjA2ls2o/oEjGoZ5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OFv5uden; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-376069031c7so4957685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623512; x=1720228312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=OFv5udenEcKgF16Y+HBYr9MZHcwY7RYcczrSH6WLqP5mF63vKTpjGH8KTAbPLAxr2o
         APVfcDdP3CZwsOSQ6RiQiOOqoXjqE99HkNEE/CVBu8VhGXlGY0HtfrsGaX8SYkjNjW4Z
         pXl6bdJnrqfUCnZkx4ne+XQHH6+n/gI52zDiLYuij1U6BA4W9d+TPZSJlP+oS51/Ltv6
         cKvR9knTKh58FhYIQFBAZVhWgxi7t9PTTDXuLj60CwbjJcABYHRaAhFpvOUrHavs2aZG
         Z+OYk4wAWGEc36kakav0QZZ8p4k0QeI3IFQsdpY1nLc9XgceQ9IYcJC1gwQIktdP4ecd
         JJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623512; x=1720228312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=lFSnFbnBv5nfMcT0BZ4UgsH6gubzYX66+aG2SCrUfzUzf7hJViX2435UVRtr/rceBl
         z8Yn9rWkjhY6O2c3bOO8LfEwiuNls4UCzOWp/TF1KobrTraxGCBxrmJ9QU7Yn9IqQUX8
         OvxrrGALJO/TDHXcu/+Z2g9i9KzgrAs0CZHYtT+7VREBkq0u1aCLw9hCE5BGUuwAEnGE
         Nt8FCABc13stw7BSTihm08+VrH3UnrvwvGa/zxhlf1M8SLgh0nqGOO2MY3LfEoWbFZ6s
         x1K9gpMESHmEXhEfjAb5/NjxiMYC6Ys0R5ILvdxxuIEe93dTNtpwBjDhvUDPlWoDoxlo
         sw+w==
X-Forwarded-Encrypted: i=1; AJvYcCWPl3LYofT0AqTHxoXSg3y/QLCbJT384s9MVDdPWOdCf4NrVlUy/S1isrpjlDDrg58Q5MKTIBGDcUkaFDiP3gqCRgvvHs2YntQXg3fp
X-Gm-Message-State: AOJu0YzkWMKe8bHRR75v6wHq82TVZ0T9CuSAUsn2hPfcTtAz8WfUxQJR
	myNOt4AX0Jby2GlzgAcgCeBh3xIlOLWEicV/qS5uMjtyB4japUJCFc+6Sdp9jMA=
X-Google-Smtp-Source: AGHT+IEt4WuI6UUriXHM21a/iZG/YuB8wOThjfEiLBUbcEKDogKRn2+UhIh8HyJ2Q/QTwEKSXlIHrw==
X-Received: by 2002:a05:6e02:20e7:b0:376:492e:a13b with SMTP id e9e14a558f8ab-376492ea27amr214270955ab.28.1719623511924;
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIw0-0004UM-BR;
	Fri, 28 Jun 2024 18:15:08 -0300
Date: Fri, 28 Jun 2024 18:15:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] iommu: Remove sva handle list
Message-ID: <Zn8n3Cs7JDxzpRPf@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-3-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:47PM +0800, Lu Baolu wrote:
> The struct sva_iommu represents an association between an SVA domain and
> a PASID of a device. It's stored in the iommu group's pasid array and also
> tracked by a list in the per-mm data structure. Removes duplicate tracking
> of sva_iommu by eliminating the list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      |  2 --
>  drivers/iommu/iommu-priv.h |  3 +++
>  drivers/iommu/iommu-sva.c  | 30 ++++++++++++++++++++----------
>  drivers/iommu/iommu.c      | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

