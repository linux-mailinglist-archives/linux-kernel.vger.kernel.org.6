Return-Path: <linux-kernel+bounces-560157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E2A5FEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C2017E091
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8D1EBFE2;
	Thu, 13 Mar 2025 18:08:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34FB1DC046;
	Thu, 13 Mar 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889322; cv=none; b=QgrA3iy928JoG0RwFOe46rYTbSn4aaflb7BbZt2zvE1hFJhc9pLO/2MlUThK68hKNdqJ9GDBPwmMT8NNZQCEdEEs2K6oa69a84yCS5RYBefLkcTi0QEoZqL1f8MegIUORfSTjlLmrXXJuCDRnxeHZX/POyGB0gr67SmSKSS7jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889322; c=relaxed/simple;
	bh=pQGtB9l33v5PfLU1rNDNQq3i+W59p2jIMsURHN1eO7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRpkBMHoliVU+SqFi8dB/jIVMCN7wWpQoTWeJcwXIvlgqeBFMyPuzbheycXTZgQegZkEmxJ35+iN9G827ACRcR7kfGR1oxPfpKdqNb8d5VGNr7bhKrIp1pSBs90/Vxs3lIIbomEdKmUXDZdwHMGcJDZ0xDGTKy6bNjRTWKZu5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472DD1477;
	Thu, 13 Mar 2025 11:08:50 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDD53F694;
	Thu, 13 Mar 2025 11:08:35 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:08:33 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
	james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
	oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
	david@redhat.com, jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250313180833.GA40525@mazurka.cambridge.arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <ea10caee-59ef-4a00-9b61-37cb0a379411@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea10caee-59ef-4a00-9b61-37cb0a379411@arm.com>

On Thu, Mar 13, 2025 at 04:13:22PM +0000, Ryan Roberts wrote:
> On 13/03/2025 10:41, Mikołaj Lenczewski wrote: 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d561cf3b8ac7..b936e0805161 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2176,6 +2176,76 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >  }
> >  
> > +static inline bool bbml2_possible(void)
> > +{
> > +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> 
> If you're going to keep this helper, I think it really needs to be:
> 
> return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) &&
>        !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> 
> Then you would simplify the caller to remove it's own
> IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) check.
> 
> But personally I would remove the helper and just fold the test into
> has_bbml2_noabort().
> 
> Thanks,
> Ryan

I was debating folding it into has_bbml2_noabort(), but went ahead and
implemented it separately to match hvhe_possible(), which was another sw
feature helper.

But I agree, folding it will be simpler and read just as easily (if not
easier). Will do so.

> > +}
> > +
> > +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> > +{
> > +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> > +	 * as possible. This list is therefore an allow-list of known-good
> > +	 * implementations that both support bbml2 and additionally, fulfill the
> > +	 * extra constraint of never generating TLB conflict aborts when using
> > +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > +	 *
> > +	 * Note that implementations can only be considered "known-good" if their
> > +	 * implementors attest to the fact that the implementation never raises
> > +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> > +	 */
> > +	static const struct midr_range supports_bbml2_noabort_list[] = {
> > +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> > +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> > +		{}
> > +	};
> > +
> > +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> > +}
> > +
> > +static inline unsigned int __cpu_read_midr(int cpu)
> 
> nit: why the double underscrore prefix?

Again copying other helpers I saw that seemed to do similar things.
Didn't know if this was the expected style, so did as other helpers did.
Will remove.

Thank you for the review.

-- 
Kind regards,
Mikołaj Lenczewski

