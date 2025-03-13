Return-Path: <linux-kernel+bounces-560177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A0A5FF08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87867AD7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398B1F2382;
	Thu, 13 Mar 2025 18:13:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E041F1521;
	Thu, 13 Mar 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889610; cv=none; b=rU070hjbubsIs315L4yabBuKFrJ2/uu5AhVWrRFzIOL8U2eLL3NLXx/JOrivHP1vCpPKxknTHMHUZ5uvmhC9rIv2lX0IWKZmJce78jsyP3AJbs3IxfQDrL7C+ivyO4oNobvTbnCU/sApmgqCQPJWrfBGU9avzcymNJxW/UYn/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889610; c=relaxed/simple;
	bh=AtNQjjVdscgWVSr+RTDdyxr7XpgafgYkkTReKsEuNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1q0C6q8KPEHBIpghzW55WyJDoq22+SccRuIKe7izaq7F8FVqgW3zr1eP0MZIx60xxRMSiaGb352vX+Jlq2Ouk+UdaC6NYHkfUsKA59UJTCXS9BZlX5rinI427nmQo78dQ4F47PsUCvqTEC+NsOitYSQ/DJabHumnedmShvAdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEEC1477;
	Thu, 13 Mar 2025 11:13:36 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FB4C3F694;
	Thu, 13 Mar 2025 11:13:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:13:19 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com
Cc: suzuki.poulose@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, akpm@linux-foundation.org, mark.rutland@arm.com,
	joey.gouly@arm.com, maz@kernel.org, james.morse@arm.com,
	broonie@kernel.org, anshuman.khandual@arm.com,
	oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
	david@redhat.com, jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250313181319.GB40525@mazurka.cambridge.arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <0abe8643-d4ea-4e77-bd77-afe07399eec9@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0abe8643-d4ea-4e77-bd77-afe07399eec9@os.amperecomputing.com>

On Thu, Mar 13, 2025 at 10:21:51AM -0700, Yang Shi wrote:
> On 3/13/25 3:41 AM, Mikołaj Lenczewski wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index fb8752b42ec8..3e4cc917a07e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -453,6 +453,9 @@
> >   	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> >   			32 bit applications.
> >   
> > +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> > +			2 support
> 
> Hi Miko,
> 
> A question about the kernel boot parameter. Can this parameter be used 
> in early boot stage? A quick look at the code shows it should be ok, for 
> example, cpu_has_bti() is called in map_kernel(). But I'd like to double 
> check because my patchset needs to check this parameter in map_mem() to 
> determine whether large block mapping can be used or not.
> 
> And a nit below.

I will need to double check exactly when the arm64 software overrides
are finalised, but as long as those values are finalised in / before (?)
the early boot stage then it should be fine? Will reply again once I
check and have an answer.
   
> > +static inline bool bbml2_possible(void)
> > +{
> > +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> > +}
> 
> Can this be moved to cpufeature.h? My patch will use this, anyway I can 
> do it in my patchset.
> 
> Thanks,
> Yang

I can do so. In fact, on second thought, I will probably extend this to
also include the `IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT)` check as well,
and then move it to cpufeature.h, instead of folding said check into
has_bbml2_noabort().

-- 
Kind regards,
Mikołaj Lenczewski

