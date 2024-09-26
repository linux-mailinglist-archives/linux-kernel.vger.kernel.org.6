Return-Path: <linux-kernel+bounces-340938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81898793F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820E31F22586
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CE171E5F;
	Thu, 26 Sep 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CrMCQFrj"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F338171088
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376217; cv=none; b=vC49QOTZib1YjZShze1lc+yazYKWGer5Q/0LkqvIhsTwT4XB4nj/An1TppIRyCXJkdUyJJIQvymPKN6sWIGnQ1EoNiUkG0QW8ctAbB/I9Ydy+Kq1Wi4OZjYQjAk9wdoi+TyjfmGxwk2e7XdOSTZ6HYaYd8YiykKXvHtz7lq3ERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376217; c=relaxed/simple;
	bh=a/5m2zK58zkx4nM/V+xJ6JyzxFdkSfEPu9cHhxirWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciRWPK5x7GJOxnbs7ATPAKS7YK/VHAhJGxct6I/XmcF5OFdjjt8QzBjYEYPGpSy7XlZO8gDFmc5/yn+QG2jCtHHnLv2TgMi1LHf+HzdRpJc26Qepv0AAA15dmTOg/Kshw1AKyw1obTOPTKPceXgehDdujXnBBL2JwcNqJYc/7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CrMCQFrj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9aec89347so98602885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727376215; x=1727981015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=CrMCQFrjp3k8NQEJJANc/66ALMaYqp0s3IjxWAaegdxslX0Pol8Ulrn2TNv12Sk6o0
         /EdRPk52EyZoX536taouv1lVyzj87icX4m7t1JXVDGpO/6kzZ3aFpcBPs1PfEebiZ/cw
         xvcGdj/DasxCs1qwMZpmDFeJi2SQEb39H9aRLzMDrExT2pHqO8cHVBo0JdkJ/9zWmbff
         I8hxYl7z0yg2G7lVn7If5NmxoxHiLJRMfK2yZt8jUoLPICGqFOvDp+LAQsVs82inG6JA
         X+xZIehXGgQyUffAXFZ7drpoljIUiJ/Y+OGVZTQtbxVfeOAH4joc8IPhU8MnXkEsghFm
         wVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376215; x=1727981015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=c86zeinhgMSgHmcRYKzYL4z1S0k5LKK2UPAZL2Em77JEVeP3W5+pmgdNdGimD9txZU
         ifvwtoY3lblGyeSYbp7dccMPJ1ZHtzaq8xIjGe41fVofWIa7GdaYoY0goVDe+VbmghFt
         zlnSiPUK8S3yr9J0Vz6Qbjc6HeXqn+xk9QuQWreLiHVZ5zb36x7jntd+K8RmLuwIfLNQ
         U7xiUlr6LDMl7WrIGyiQtofWSHN5Ah/EqubRY323k5nqH8RXRtu4p0qVj60nk9pwLhu3
         hbrtUu0qvnwu3GvOc1BorqSU94cqQ1On6t53aMeGGuB4cyK9hxAXsOwgLjrQJqFnUFrm
         1rJA==
X-Forwarded-Encrypted: i=1; AJvYcCWILz4cD+c2zM9wXxKGjJqjEadqB4njQykMIgI3CK7HDXpZq4TyFCKK6OzPL8/U7OeJ/jbj7ZJGek+168Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM92AEaGkZ6g72oRH/BsM2ZhC9fOmMhnrAdlZPhBvOriQ+oNmJ
	hESGmkh4RFLZpGSRKT6Iux0Zyis1W+mKAmoXQnX9J502hC+eGaovdzWSwLotkbg=
X-Google-Smtp-Source: AGHT+IHahoaHFJtuu1gsK0aQtYJow2bdyMNiogW2IcChPTuHJqaCLBrGWEI30mWx2ZRm25asoXWR5w==
X-Received: by 2002:a05:620a:44c2:b0:7a9:b425:6 with SMTP id af79cd13be357-7ae37838380mr75987185a.24.1727376214700;
        Thu, 26 Sep 2024 11:43:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782a221sm15168385a.73.2024.09.26.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:43:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sttSf-000qCj-2k;
	Thu, 26 Sep 2024 15:43:33 -0300
Date: Thu, 26 Sep 2024 15:43:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	baolu.lu@linux.intel.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com, jroedel@suse.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] iommu/s390: Implement blocking domain
Message-ID: <20240926184333.GD9634@ziepe.ca>
References: <20240910211516.137933-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910211516.137933-1-mjrosato@linux.ibm.com>

On Tue, Sep 10, 2024 at 05:15:16PM -0400, Matthew Rosato wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling.  With this change, the crash is fixed but
> we still hit a warning attempting to change DMA ownership on a blocked
> device.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> Changes for v4:
> - fix lockdep assert
> Changes for v3:
> - make blocking_domain type iommu_domain
> - change zdev->s390_domain to type iommu_domain and remove most uses
> - remove s390_iommu_detach_device, use blocking domain attach
> - add spinlock to serialize zdev->s390_domain change / access to counters
> ---
>  arch/s390/include/asm/pci.h |  4 +-
>  arch/s390/pci/pci.c         |  3 ++
>  arch/s390/pci/pci_debug.c   | 10 ++++-
>  drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
>  4 files changed, 59 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

