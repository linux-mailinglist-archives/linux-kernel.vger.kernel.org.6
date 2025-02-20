Return-Path: <linux-kernel+bounces-523291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53552A3D4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09EF1894B55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3811F03C9;
	Thu, 20 Feb 2025 09:34:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2091EBFFD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044042; cv=none; b=rBwju+WyjDiWRCEoxbRpGDgkoJEzSTi2/HuIahbYR19gUKj0APxwFw7/ow74gh/ofhEEJUEwdqOLPlBvcS2TVmdLkkgtsOESz4Mfayq6l4HEQftexRrmLXPigCdcAiHhrP8f5SR5zlgsSmlshHsJnnb5sbsoH6zReJhWmlEFp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044042; c=relaxed/simple;
	bh=rVqOrcawk8w4I58kgaH5Oo80s8er9u+SBF8+GzGZrK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+IAU/3lCo3DaPGuvsPeZS5pyIHCU7LocBKWU5A1YyKgAGmH4undKtvIpGVntWTOOuhwdW2MfgDebvVfiWpGz61uBDtTr7OGtNdDU05cPpH9PaEBu4aP2QS6vSt58PXA4zY0AN14RcbaFhgKsrhCfPCZ54R8NrD/4I73Wkl5RK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9EFC1BB0;
	Thu, 20 Feb 2025 01:34:16 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089D03F6A8;
	Thu, 20 Feb 2025 01:33:54 -0800 (PST)
Date: Thu, 20 Feb 2025 09:33:52 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, yang@os.amperecomputing.com,
	catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
	broonie@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
	yangyicong@hisilicon.com, anshuman.khandual@arm.com, maz@kernel.org,
	liaochang1@huawei.com, akpm@linux-foundation.org, david@redhat.com,
	baohua@kernel.org, ioworker0@gmail.com, oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250220093352.GA11745@mazurka.cambridge.arm.com>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <a6846db8-9efa-46f8-9939-7727c83d1601@arm.com>
 <cbc3f62b-8890-42ca-81ff-66f1e4ea1cf3@arm.com>
 <e0a6308f-5628-4698-95a7-ec1b918358b0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0a6308f-5628-4698-95a7-ec1b918358b0@arm.com>

On Wed, Feb 19, 2025 at 04:25:56PM +0000, Robin Murphy wrote:
> > On 19/02/2025 15:39, Robin Murphy wrote:
> >> ...
> >>
> >> If this may be used for splitting/compacting userspace mappings, then similarly
> >> to 6e192214c6c8 ("iommu/arm-smmu-v3: Document SVA interaction with new pagetable
> >> features"), strictly we'll also want a check in arm_smmu_sva_supported() to make
> >> sure that the SMMU is OK with BBML2 behaviour too, and disallow SVA if not. Note
> >> that the corresponding SMMUv3.2-BBML2 feature is already strict about TLB
> >> conflict aborts, so is comparatively nice and straightforward.
> 
> Yup, it's really more just a theoretical correctness concern - certainly 
> Arm's implementations from MMU-700 onwards do support BBML2, while 
> MMU-600 is now sufficiently old that nobody is likely to pair it with 
> new BBML-capable CPUs anyway - so it's just to cover the gap that in 
> principle there may be 3rd-party implementations which might get confused.
> 
> Cheers,
> Robin.

Hi Robin,

Thank you for taking the time to review these patches. I will add the
check in the next patch series.

-- 
Kind regards,
Mikołaj Lenczewski

