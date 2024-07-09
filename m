Return-Path: <linux-kernel+bounces-246474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1992C265
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CC2B22258
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84C158873;
	Tue,  9 Jul 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b5/f5OXD"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFB3612D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545786; cv=none; b=Gg6fhzlaC25QkU20oNVNeHBGW7Zs+NCwxKto/VNvk5CDZT50vuiqjy6m6oqk0Q28ZhCc2/72j+zaysEjtVF5TsRL1R0ykujsNCm8+fhZMVy2gDeq5r4M6Wn7b6SfMGB3HVWrvIrOwVjqJhv1+erq0kYnojYgtKS/6cYHA1UPb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545786; c=relaxed/simple;
	bh=U2yil5Qb35IaDxgZxylKOI0ns/g0yuIBAEJBs8zRkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axGKSiMVgI5vZND2hV5OciteCwzkz6OHIo29dTxnfDEqxWNL/a7xo16NdgK91+dlD2zaDiXvMqv44FhIsdsJ/h5fvxfEaDGB8Ciiu96p3FzTM8w5E1FGekrjC3ojbg9fstTQI8pXCWktl0Oekgg3X3mThKqfLSHGGweVL3M9wpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b5/f5OXD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-703607df7f3so1628121a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720545783; x=1721150583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=b5/f5OXDPnpqbDduNwrHaHGZ4bqimo0SIRsY3oPMZU3uzQwIDbFuDCGD+YhCwk5ZsO
         UBAUK2Dl+lX5+AW0FU+gPTkm8tpUNoXwrhCN8B/V0yTC9bwMmpaJJ4hrHqKtT+JrIdhp
         8oEq8s0OG/TIAbdka2qkw+qfAsN2bPOtNXieNlwGF3oUDBe9lKe5/hJ77cIz12QiUtMu
         pI+F+JqkITsMyCJi5TyM5W1wX4BFgIBcqjXz92B1MhfmVvR9p5Cd57ioKsDHamPu0dmq
         ejoBJIG8NiZ4swcA0dlPuruU7Qj6E11Lq4g4t1L+m2hSPx16PXqC2xc4BN+KNuaWxB+A
         zilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545783; x=1721150583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=cms24ij6jTMnFUcJp/PPEnzlZ2rF8zShqhTcNZy6ml9dSBqmYso3r2n1ZlCiubg0B9
         mIihp7pTvhvUyiDBaNubp8Pf11BP+939wS5e0QurkEiPlJcH8GwArSXcekf9JrP+MVbL
         YcACAuWhqSR24Nl899tXyvFjHPy85fJW7o9k6wMT4aE/DNIuI/3hBJ7nJt/psO1byRCx
         rTogEIaI3IKRO764+9ps1+FMoEGsi/zj8E18EoZnLQIrxhuL+F8Qj/GFA18z+xnpnGxH
         gLFRioporUIZ4noIj9vArD92lzIhl5u8zPPrgP278+QC6ZD6XFTz0XrAP9rbM4tEfh9i
         fuPA==
X-Forwarded-Encrypted: i=1; AJvYcCXOu6fBOh04/WMdykfxSQRDe3dpqkYlJ38G4m4HR/wXu1NctASJohO1ahP+rr+TeQhIiSMDFnCGr2ydkcVhwYDSHo69agvWYkIicDPr
X-Gm-Message-State: AOJu0Yz3l+0kEYau6b02qPOPw27506BJAHk6ZbeE2GkuCZCek6liZoRz
	uMnE2Y1nPo9Mebfu9L0yifvDBe6j7izrA0Em2w0JwR/7F1HDkDuoYnEKAWoLQJM=
X-Google-Smtp-Source: AGHT+IGVRFbVHaFI7Hg/zyr5X/JIozW5U5BQaYFUSCyCuMlqJhtXyislRKpp2oru18TCtv4Lx2o1lA==
X-Received: by 2002:a9d:3e19:0:b0:703:6ab8:1fe3 with SMTP id 46e09a7af769-70375a0547bmr3177744a34.15.1720545783587;
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff80c7sm116481785a.3.2024.07.09.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sREYQ-002ipU-Hx;
	Tue, 09 Jul 2024 14:23:02 -0300
Date: Tue, 9 Jul 2024 14:23:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, catalin.marinas@arm.com,
	kernel-team@android.com, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240709172302.GH14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <172009718026.360360.18220408964887632139.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172009718026.360360.18220408964887632139.b4-ty@kernel.org>

On Thu, Jul 04, 2024 at 03:18:57PM +0100, Will Deacon wrote:
> On Tue, 02 Jul 2024 14:34:34 +0800, Lu Baolu wrote:
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework. One feasible use case is the
> > nested translation. Nested translation is a hardware feature that
> > supports two-stage translation tables for IOMMU. The second-stage
> > translation table is managed by the host VMM, while the first-stage
> > translation table is owned by user space. This allows user space to
> > control the IOMMU mappings for its devices.
> 
> Applied first four to iommu (iommufd/attach-handles), thanks!
> 
> [01/10] iommu: Introduce domain attachment handle
>         https://git.kernel.org/iommu/c/14678219cf40
> [02/10] iommu: Remove sva handle list
>         https://git.kernel.org/iommu/c/3e7f57d1ef3f
> [03/10] iommu: Add attach handle to struct iopf_group
>         https://git.kernel.org/iommu/c/06cdcc32d657
> [04/10] iommu: Extend domain attach group with handle support
>         https://git.kernel.org/iommu/c/8519e689834a
> 
> Jason -- feel free to use this branch as a base on which you can take
> the iommufd parts.

Done, the whole series is in iommufd for-next

Thanks,
Jason

