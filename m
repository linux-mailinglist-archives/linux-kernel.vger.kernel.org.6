Return-Path: <linux-kernel+bounces-250656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9592FAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C34B222C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4D16F839;
	Fri, 12 Jul 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jbG58NDC"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAC16F297
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788751; cv=none; b=X6ANepEn3gawys6oFsjM5I+pnRFxQnzW0nooZhNunp4g+jvytShbGGmC8hzOxR0eSolzXoifiAkYRdvrBMEIDpLtHMNi/dCpGn/5qBhKEpH6OaP8Jsr573UkqC95nKSv8u38YwoclU/3PH2jFBxVud1Ghiaq5Sk1cNSLdgTaGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788751; c=relaxed/simple;
	bh=SDo32lqaEdgpKmnbB45hNjQ5qll9+Li1SCmphlKrzik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiPF9fDUJC9vpwVQ6ehKVFjpQ9NiQrAPET4IFNxiy+zDr/HJD7WRO0+kyWWmoVCtmA20loIPk1mEtLlGVUhBgn2ZAXJVcVz61oGB4bq19/DTowabXyQ3tysLxGM8VSZgBvTJlrDDj49s77J4OBh3gj4L6wM7eK4J+i+DLj2sDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jbG58NDC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b6199ef089so10911746d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788749; x=1721393549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZwt1H7oIW6nXmkPtQFYiNDgw6nwG52P49Io5oP+Jfg=;
        b=jbG58NDCGW8QuRkB2678E5ojnYec7NYxTyPiNBFa/LOtBNT+gxrcWvgZPB/y9nGCiL
         O9RStqfP9vFSqx1uuumf5RPF6dnqwZBN8iJq15MOzXyK6nZPMk7td6aST0cbY9Z4xrSB
         ytC0k+LTGTx7dbtm6CZ6hg8P3gXkMcdJks+MPLk1mPlpu7yL16JCNRkVDKyTGVtwYxQt
         gG/2mko6O6ViuUZEWR8igb30b1cbY7SQDFoMKu0AuQAbOruldFAJPFfgb0UpXqSfym6D
         2uqaqIG8mNP3DRD7GZqBNWtqfxT5G92zZN+K44tdVvUlvm2O2kJeKfyaf2CtUzc2Poa5
         SzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788749; x=1721393549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZwt1H7oIW6nXmkPtQFYiNDgw6nwG52P49Io5oP+Jfg=;
        b=vTvNJAqRZ2rm1lwAGIkHlt8GMcURScgeki9A6uabwktic7RU5YsW0O2xeq0tq0Ty+x
         66w98fQHBaLG8NyB4eEsZ3WWaz/mao1AhyRKxl6IcQVUfkfNXmZbBCklJtEOlFdE6KGy
         GHlgyq9Na1rNMlA4NEX0L8v/1v+r6d5f85MxtsKNzhYpQeLbO99/9yZ5nzlu1nyWfoo2
         QEkumeD/J7uoysQPmDd01yhTPI+CH5g4QL2CUgME3ecc8q/T4l0GeyOVG55g3iFGRQ1E
         qIb13tDdLXF1wN1Ijjzx+HwuyDYrs6Gl0eQ1tKgCVESJtmlmE6ndKrEsxXIZB0/k/TUE
         sGQw==
X-Forwarded-Encrypted: i=1; AJvYcCW30swkOo/eSu8IHopvaNxaAgQLE/Q4ur5OM80j4IpI0F2rN8+aJJ3HVIKKyIOuoFZ+IypWf+LJ7c6PO6mYlUeHHfSMZL8zFWpVqMd3
X-Gm-Message-State: AOJu0YzJmllDAbG7QrmbhSweZJsMarvYrXJglFkCeBTSf0p3JIzJolfd
	PnJ0EhgKYvgYdCpilIt1gionlqlDHN1tCMQ7/xIs38qsReNTumj5XS+aQpWvvzY=
X-Google-Smtp-Source: AGHT+IHIkQn3yXzLP7vYHXmOANs9UFpH9tGkJikLJj4kjPZefiBKLX1DQjbvKbejP3eOobRWdj5qlg==
X-Received: by 2002:a05:6214:1cc3:b0:6b4:fda5:8230 with SMTP id 6a1803df08f44-6b61bbe0c8amr143829566d6.0.1720788749076;
        Fri, 12 Jul 2024 05:52:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8c9f1sm34903496d6.123.2024.07.12.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:52:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFlE-000HKf-3g;
	Fri, 12 Jul 2024 09:52:28 -0300
Date: Fri, 12 Jul 2024 09:52:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd: Fix error pointer checking
Message-ID: <20240712125228.GZ14050@ziepe.ca>
References: <20240712025819.63147-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712025819.63147-1-baolu.lu@linux.intel.com>

On Fri, Jul 12, 2024 at 10:58:19AM +0800, Lu Baolu wrote:
> Smatch static checker reported below warning:
> 
>     drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
>     warn: 'handle' is an error pointer or valid
> 
> Fix it by checking 'handle' with IS_ERR().
> 
> Fixes: b7d8833677ba ("iommufd: Fault-capable hwpt attach/detach/replace")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iommu/8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied

Thanks,
Jason

