Return-Path: <linux-kernel+bounces-234737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587091C9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325FC1F21DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81DE1CF9B;
	Sat, 29 Jun 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MkFWT+YU"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA217C9E
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623515; cv=none; b=oU24Bt3g8XPtppTpoaiP4edEWPS1w7k8t414Ed5Ra1G3wLwOjLkjqF9yZGc7YMTgmRHDSxtLdYIbg93yncICU49CQB8RV0h47Vfz5LZVMmWCcI80HgiuKq7iMq8rttbLMRLjoDIjRBTO8LMm5KCdgOPGiNI/WCU5c+W7g/FoWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623515; c=relaxed/simple;
	bh=aef4F0Bvpd2E+ekA6aOSsipc4x6PfNlwGk26KdC5swY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIemQDYCuOygAPbazM0Fv9JTOvCMxBfZ3JqZNaTO/LgUwBHfU1/gXTAnwd9D052XFFoSD9MzbsfEPWYbxKBtBu47zfigfqpEYf8YSAoK1hO5I066iE2Rn0e3fhWeABkvlN9Qm3ngWPB26b90oA2U0MoGtcUdNHLcNwwIGrsMN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MkFWT+YU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d562b35fb6so696451b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623513; x=1720228313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=MkFWT+YUt22312FSKDNpkKlD8daLvbvO66OQtcq1uBUuJ606yHlAeJi7HZ22/1poeI
         jtyh03vnuYBFa+F8KynhAq3Tkf66mfkh8vypaZMUw5NCprtu1Yi2bgVaF83U3XP7uQAw
         /NAPRLigCNsRpZdzu4WeeeCVzVNelFqFfpcgG6Aspzb/PGKq10exTuOddUPtPJk3mNeb
         kKuWCr8DOhCLr1+DWjwW/UNfviGvOFI84ucwtTNyoljx9U9axDsffIm+Jf75BeHvEh8c
         mtasUlSYRpeSbwEzyBv3lFqLrd1CN2vTMg8c63Mtpjh8gzDZHxRhO/Tn2u1tePU6RpFn
         uarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623513; x=1720228313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=HqS6acUL8nTsgQE/7NQDoshrEjhjwVoG3QqPiZ6+nj75SWhG3yv6WbyEfXlyaH/6K9
         2YxvUIRjw4LasQBj4tNrzcl0AwosbQs14XbesB5af6Lm5npeYfThAFrU8+IqXypBEFUP
         kNryw2qnE/WPhukftv0cOOKYuiUbr1bx3vtm/myqB2pcgZ8v2zld+H39SeX7lT41TMD0
         WRNmmf8QrBIhte1My/X+wt/O7SNLdNUsXUHrNosnMz3DeqIr36qVWsRe5bypYCuhiSFs
         vj5YHgklt0oa8kaXbhxR/utzoPaG4yg+P5CeyCuMZx2n0PWgMDvndoCpVzbuYpCgwlFl
         QweA==
X-Forwarded-Encrypted: i=1; AJvYcCXD1hCm2WRf7emJA40+aGEN7fqhl6JDmzv+YvXREFULGJv/E1ScCfRP+qE8jINKgESq4n1+WTWP4/rlFsTdq/WdWma3YBMrVMvoiKOu
X-Gm-Message-State: AOJu0YxdN1IQFQVrpxQ/2b628kOBhdBgfg12ywG938VO6wcQ4hfEEIw0
	E0ZGw3dvBVt4YHmNGzfVsPqY3r4/o3zQd60TQez7EjC5F0ApzXA/0xsjhCZSSEY=
X-Google-Smtp-Source: AGHT+IGI3SD8A1N5RAQhEKo93yRDR33fQ3JlDGvi7EAwNp2DA4Cb9gac0LEseC9mjRgt/U5qth10Jw==
X-Received: by 2002:a05:6808:17a7:b0:3d6:342b:d7f3 with SMTP id 5614622812f47-3d6342bdbb0mr2109008b6e.52.1719623513063;
        Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJrv-0004oI-S0;
	Fri, 28 Jun 2024 19:14:59 -0300
Date: Fri, 28 Jun 2024 19:14:59 -0300
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
Subject: Re: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <Zn814+VwyCJ/okax@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:45PM +0800, Lu Baolu wrote:

> Lu Baolu (10):
>   iommu: Introduce domain attachment handle
>   iommu: Remove sva handle list
>   iommu: Add attach handle to struct iopf_group
>   iommu: Extend domain attach group with handle support
>   iommufd: Add fault and response message definitions
>   iommufd: Add iommufd fault object
>   iommufd: Fault-capable hwpt attach/detach/replace
>   iommufd: Associate fault object with iommufd_hw_pgtable
>   iommufd/selftest: Add IOPF support for mock device
>   iommufd/selftest: Add coverage for IOPF test

Small remarks aside this all looks fine to me, send a v8 and I'll try
to pick it up next week

Thanks,
Jason

