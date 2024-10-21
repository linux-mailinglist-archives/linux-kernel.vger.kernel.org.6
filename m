Return-Path: <linux-kernel+bounces-374355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD149A68E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D913C28AEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74121F4FAA;
	Mon, 21 Oct 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="njQVeczx"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20FB1F12F5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514664; cv=none; b=T508l2iN33GaFnL6943MmrGYwAskYD5j+9rgVO7FBJ4RoeL/QeRzFNtEGrvohhRNbUdN/bTkGYEFrl6cDxtrSghviFvVObrS0u8w/BK+CGX6yVH8Hck06KnOWGi03GycRU/e8yRp357IPcjOOmEzysxCHVGpTpGFix1iwaFB4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514664; c=relaxed/simple;
	bh=+BOH6oOyd5oDIqKQuziHgWQPT0ab4bBLELQRKxd1Eg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SISM73ZrTHo9fwqiOHnpswR4eSePwRAQbF3qLquRASJ4p8lRgjvSeYsX0UIHUutjdWvr2EzMpgKIebTeaQx0hJqutLxeBv0wlVDf4DWDnydd7AM6lKlLZoKz1+y0d5HhJe+7BOPgzQktUsQZt6vAQteDWKjet2Lkljc8xDFE7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=njQVeczx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1601e853eso155753085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729514658; x=1730119458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9W7G1s/17nlBu2nyfJGMmvDTBLsYC+PG5KaQtDhVjQ=;
        b=njQVeczxrlWUPjy/nIvVLc5atv7V0pH+t25NUQ3GaA6uRHzdvXZ5vr2mipnWFl8f+8
         z3aCbs6mhokx/6++m6KBfEGcHxWwHh2R9GTexokLGSJX9xOOKy+YObBALzcdAOfek/8n
         1xLicIqYY/sdioqoSUaFRRIyCCERU11Ksf3C9idALXgvvS7fQnoTXPDNfqI5YLLGw6xB
         gyPMdg8kv5IIfH2OwNA+lj3RKRpEWidMzwbrLWvduwrg5S58a+phrjJZOqOHBaVYTU6A
         5P/9mxiKEr2G7MGwdcxYywICwkTqy/U6dF5k/XizgwVmsYQKmjIlJF/Laq+bj+szuQ1u
         vvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514658; x=1730119458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9W7G1s/17nlBu2nyfJGMmvDTBLsYC+PG5KaQtDhVjQ=;
        b=OZ3Z7jQn3JQ72xiCWqHPbBTFcibYBJ0rhThDT30aDOKoyMqz7ihN639ZbNXN+o1zTB
         q8oP6IWLEd/4k+Sr/VsxgP7yfgD6KR782+GG+b2to+7xy2BiYJGajjwEOTDRpuUWMmgi
         BHqyLTnaYM/OK1Qcl17/56oYHCCtWIk5HbxnlVITeYhqaEVlfJMeIAgNwPtV2gIqCOHO
         dVVmmv44qQk4jPhTmDt8Zknqq5Cpvp+n4aUPhP7p0tQA9y7J/gICAmQGXPJcEh0FKEo7
         2NQTv25F6t7Ab1dKsld44n5bd1vf5W24bl9lX7V1Wkh07N8lW0E0Mp0AFUM/dPX3oh51
         sD5w==
X-Forwarded-Encrypted: i=1; AJvYcCW5sEXg0pDiuQUBHx0NokNQullKZrGmo5Eptd62cryNcmjmde8mF3smmyJvh0P2XOxq8ReH2Xqnp88BISs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZG60AcCJ6jjnewWNCmkQ7Rja+IOTQ5KKJexUtgqSSKHEc7h5e
	8KkEdtYvF9q5YvzLBFJhJighVTRREFZAeYNPFd2zUx4Et1zBWTOeza/eaGIXtWk=
X-Google-Smtp-Source: AGHT+IE4qA8alqP1kwri4/koenk+ctTsb20wMxCEVTPZXERpjMTtxelCiobHbzlHXSN1WMyhJ8q0ZA==
X-Received: by 2002:a05:620a:4510:b0:7b1:4fdb:6eaf with SMTP id af79cd13be357-7b157c11ee2mr1669848585a.65.1729514658588;
        Mon, 21 Oct 2024 05:44:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a0347asm161962385a.59.2024.10.21.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:44:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2rlh-008H8r-LC;
	Mon, 21 Oct 2024 09:44:17 -0300
Date: Mon, 21 Oct 2024 09:44:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241021124417.GB3576661@ziepe.ca>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
 <20241021085125.192333-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021085125.192333-2-baolu.lu@linux.intel.com>

On Mon, Oct 21, 2024 at 04:51:18PM +0800, Lu Baolu wrote:
> Add the domain_alloc_paging callback for domain allocation using the
> iommu_paging_domain_alloc() interface.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

