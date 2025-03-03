Return-Path: <linux-kernel+bounces-541639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F21A4BF63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55231687D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8020C49F;
	Mon,  3 Mar 2025 11:52:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732781F76D3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002772; cv=none; b=h8XG36zNwh/8yIqAzDmzih4gIM20zP14uW03hCrCDfBhQmPBnOpANKoTVL5l8TfmZwPnvZ6BSyT4MKS2LbByIIBvHnUXvHjB2ApMLSN89ypoHv0KPzds03c0/il/pYufBHbXaTMT87g2vb7bLk3vWcuLdS7jKyj4UZpGNCcQ+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002772; c=relaxed/simple;
	bh=sqO8TTi8YCCKMd24QARZVRmS0Th7BbKY8hwsVm8FmCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIu0pP0tSAuEiAOdcBX5S+/XRY6G9wbfdxza++e5MedDPippUYQ5qG6bE4YLFYgOMwUvTbvTZ+dElWjkqLdxU7fPOn3sk90vyHcC+CcBGPb0w0rrbmSKCG2BzDG6xqclHYUn8NRqROxl9x7y282vkDYpnWLPnqwlVz/X9na+xDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E97106F;
	Mon,  3 Mar 2025 03:53:04 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220D43F673;
	Mon,  3 Mar 2025 03:52:46 -0800 (PST)
Date: Mon, 3 Mar 2025 11:52:44 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <20250303115244.GB74129@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
 <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
 <20250303094947.GB13345@e133081.arm.com>
 <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>
 <20250303105539.GA74129@e133081.arm.com>
 <0ff27dbb-401b-4793-be70-1ff9c8010e4a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff27dbb-401b-4793-be70-1ff9c8010e4a@redhat.com>

> > I think I understand what you mean. I agree that it is possible for a
> > concurrent walk to see an invalid TLBI state, if it is on the same TLB
> > that the repaint is happening on. For other TLBs, the flush has not yet
> > propagated our invalidated PTEs (from `__ptep_get_and_clear()`) though?
> 
> What I am saying is: if there is no TLB entry yet, HW will walk the page
> table to find no present PTE and trigger a fault.

Yes, that is 100% correct. I believe that this is unavoidable.

> > That invalidation will only be seen by other TLBs after the
> > `__flush_tlb_range()`, so we should save a few faults because only
> > "local" threads will ever see the invalid entry, as opposed to all
> > threads that try to read our modified range?
> 
> So what you say is, that deferring the flush means that if there is already
> a TLB entry, flushing deferred reduces the likelihood that a page table walk
> is triggered that could find no present PTE: consequently, reducing the
> likelihood that a page fault is triggered.
> 
> (I use the word likelihood, because I assume other action could result in a
> TLB entry getting flushed in the meantime, such as TLB entry reuse)
> 
> Correct?

Yes, and your language here is clearer than the original commit message
(and cover letter). Will amend it to be closer to your wording.

-- 
Kind regards,
Mikołaj Lenczewski

