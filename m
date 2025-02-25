Return-Path: <linux-kernel+bounces-532128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171AA448F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4660318868D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629118FC8F;
	Tue, 25 Feb 2025 17:52:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31C19B3CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505951; cv=none; b=DTGoi5VEO514cwCBqTMIVlcqq9LZQbWsM2vhLZH0VzM2IrUTV5ZYMOEQ48o82nAmwRPEq+d+MW+TYuio4pcSOoDm6QF1p+Q+S9IaV8RJCYylZt2PqiDmkgV9Ev+K44w3DdAcgbHAJmWaa5Ay55t8xicoUHW066cJX0SBBpmYjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505951; c=relaxed/simple;
	bh=pgcA9JK0EKlacZiWkqx+C3sx/vPAa/HUHyJsPVogTkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDqIpz+K+UgV+vVne2612BAXCtXkACEsxQTWa5te5TIx4drGx1KaeFb53cTpr5xyD8OLLKusPxu+pKj7+omTV5GqX/En0M/WHk7ZmfobuCvEOLN2rI9axTszmdh04GZKjOyzkEoXggdXZsGGZEQmxNyNMg/Ag+sVhn4T8yxe124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDDC4CEDD;
	Tue, 25 Feb 2025 17:52:27 +0000 (UTC)
Date: Tue, 25 Feb 2025 17:52:25 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] mm: Generalize arch_sync_kernel_mappings()
Message-ID: <Z74DWQJ7g-KNpHLY@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-13-ryan.roberts@arm.com>
 <4fad245f-a8a6-468b-82d5-13f089aa525b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fad245f-a8a6-468b-82d5-13f089aa525b@arm.com>

On Tue, Feb 25, 2025 at 05:10:10PM +0000, Ryan Roberts wrote:
> On 17/02/2025 14:08, Ryan Roberts wrote:
> > arch_sync_kernel_mappings() is an optional hook for arches to allow them
> > to synchonize certain levels of the kernel pgtables after modification.
> > But arm64 could benefit from a hook similar to this, paired with a call
> > prior to starting the batch of modifications.
> > 
> > So let's introduce arch_update_kernel_mappings_begin() and
> > arch_update_kernel_mappings_end(). Both have a default implementation
> > which can be overridden by the arch code. The default for the former is
> > a nop, and the default for the latter is to call
> > arch_sync_kernel_mappings(), so the latter replaces previous
> > arch_sync_kernel_mappings() callsites. So by default, the resulting
> > behaviour is unchanged.
> 
> Thanks to Kevin Brodsky; after some discussion we realised that while this works
> on arm64 today, it isn't really robust in general.
[...]
> As an alternative, I'm proposing to remove this change (keeping
> arch_sync_kernel_mappings() as it was), and instead start wrapping the vmap pte
> table walker functions with
> arch_enter_lazy_mmu_mode()/arch_exit_lazy_mmu_mode().

I came to the same conclusion why looking at the last three patches. I'm
also not a fan of relying on a TIF flag for batching.

> These have a smaller scope
> so there is no risk of the nesting (pgtable allocations happen outside the
> scope). arm64 will then use these lazy mmu hooks for it's purpose of deferring
> barriers. There might be a small amount of performance loss due to the reduced
> scope, but I'm guessing most of the performance is in batching the operations of
> a single pte table.
> 
> One wrinkle is that arm64 needs to know if we are operating on kernel or user
> mappings in lazy mode. The lazy_mmu hooks apply to both kernel and user
> mappings, unlike my previous method which were kernel only. So I'm proposing to
> pass mm to arch_enter_lazy_mmu_mode().

Note that we have the efi_mm that uses PAGE_KERNEL prot bits while your
code only checks for init_mm after patch 13.

-- 
Catalin

