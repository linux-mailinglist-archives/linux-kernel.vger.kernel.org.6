Return-Path: <linux-kernel+bounces-531507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E35A44164
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B93A8BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5126A085;
	Tue, 25 Feb 2025 13:52:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C8269CEB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491547; cv=none; b=S/QsSwe3BWvKBtKoYIk7tnH0dHAoNdGVvB/oOG1Dxx8Mmqn245HbzPEBHGysH4HYiN9l4TEiR1QVYZcyoZU/KkR8VI3R+yGrUBDVxtjCtjLLfpKh2bdQqIa93qTyx8mctAjAXxTLqXHQQF2BucXtJV/X40luetJSI0Vx9zpTncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491547; c=relaxed/simple;
	bh=JQ2dzTXE5UTbX/B/MkCSYrF0zv4bAi6YWKSM3MOw6Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFJfuT+3Opn9jzQzGS3QOn3TcKqSzdQrS+t9pUxHDNC9TmTLNWkGNaINzI9iL/mcJ8yB9dfGlufUUUzXUQxElytGpKSb0Vuthqrj02ufVdmSNog9IGfbtf76a/X1BwxafslKWg5krEIVtWcu0o+n7ur9y8eZvMHE16JgRkAwqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B235152B;
	Tue, 25 Feb 2025 05:52:41 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5003F6A8;
	Tue, 25 Feb 2025 05:52:23 -0800 (PST)
Date: Tue, 25 Feb 2025 13:52:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Explicit cast conversions to correct data type
Message-ID: <Z73LEkHklpjvIlmZ@J2N7QTR9R3.cambridge.arm.com>
References: <20250219035646.536707-1-anshuman.khandual@arm.com>
 <Z724Q1ofM1GvKquV@J2N7QTR9R3>
 <9e1721a1-54a4-4007-a0f5-d651f5f21ae2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1721a1-54a4-4007-a0f5-d651f5f21ae2@arm.com>

On Tue, Feb 25, 2025 at 01:00:40PM +0000, Ryan Roberts wrote:
> On 25/02/2025 12:32, Mark Rutland wrote:
> > On Wed, Feb 19, 2025 at 09:26:46AM +0530, Anshuman Khandual wrote:
> >> From: Ryan Roberts <ryan.roberts@arm.com>
> >>
> >> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
> >> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
> >> respectively as expected. But otherwise without this config being enabled,
> >> they are defined as macros and their return types are implicit.
> >>
> >> Until now this has worked out correctly as both pte_t and phys_addr_t data
> >> types have been 64 bits. But with the introduction of 128 bit page tables,
> >> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
> >> conversions, which leads to compiler warnings.
> > 
> > Does 128-bit page table not imply 52-bit PAs?
> 
> Not to my knowledge. For now the prototype code base is explicitly sticking to
> 48-bit PA and 44-bit VA (for initial simplicitly because that's the limit for 4
> levels).

Fair enough; info dump below, but hopefully nothing of consequence.

I assume that you're relying on the VMSAv9-128 PA bits [48:12] being in the
same place as in the VMSAv8-64 descriptors, and being handled by the same
PTE_ADDR_LOW mask that we use for CONFIG_ARM64_PA_BITS_52=n.

From a quick scan of ARM DDI 0487 L.a, the VMSAv9-128 translation table
descriptor format always contains a 56-bit PA (though PARange could be
smaller than that). Bits [51:49] are packed differently than in
VMSAv8-64 descriptors, and bits [55:52] are obviously new.

> >> Fix the warnings by explicitly casting to the correct type after doing the
> >> conversion.
> > 
> > I think it would be simpler and clearer if we replaced the macros with
> > functions, such that __pte_to_phys() and __phys_to_pte_val() are
> > *always* functions.
> 
> Yeah, agreed. This was initially just a hack I did to get things working.

Cool; sounds like we're aligned.

Mark.

