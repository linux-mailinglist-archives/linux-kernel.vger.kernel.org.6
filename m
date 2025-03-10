Return-Path: <linux-kernel+bounces-554804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C7A59E84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794FB3AAA19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882A2327A3;
	Mon, 10 Mar 2025 17:30:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C717A31A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627827; cv=none; b=sFgKhKRh5e+kx/lQcq9MxOWNpjliTl6FjPPubn9uE1gSa9Vk/I8dDaB/UkcA0vycOLgvQdRyyMYHwIt0pa8SirVFVC9r3jf5+Q2MWDJEeVx/RP2aAybQuC29jf8WCpcbVbQOKRBfOF/RjBGS2r3SRWfYTccgx2wy5sz+kPu/16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627827; c=relaxed/simple;
	bh=LL09H4g/wxiqkOrlLebTGRw72BFofPQHBxWzxamYGKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjaeHy8utx4JAbzx7rl3p4OOnuR37bjMIJrixLBBoB4FklODgw8E6ETOkM6+fq3ckVz0YoprdO9CbP2LiJV67ctuYabsqIUMo8Ocgfo6Q7HT5SoB2ttDUkNcy4jI+iv/L52P8FSQt8ECDVlWw/t6tx6hF4dsLt4pObJbkyXCBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA9D1424;
	Mon, 10 Mar 2025 10:30:36 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7651F3F5A1;
	Mon, 10 Mar 2025 10:30:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:30:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Create level specific section mappings in
 map_range()
Message-ID: <Z88hrbNFM_7hIx_Z@J2N7QTR9R3.cambridge.arm.com>
References: <20250310062812.216031-1-anshuman.khandual@arm.com>
 <Z87FFqV03Pd0-NXl@J2N7QTR9R3.cambridge.arm.com>
 <b1fb982a-4936-4c18-aaad-3e8e8f61bccc@arm.com>
 <Z876UI5-xGRHl4td@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEZ86C8bouLt+xNkNr+L9AvCSQ2SZeJpLMtyvGo-8h6gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEZ86C8bouLt+xNkNr+L9AvCSQ2SZeJpLMtyvGo-8h6gw@mail.gmail.com>

On Mon, Mar 10, 2025 at 03:53:33PM +0100, Ard Biesheuvel wrote:
> On Mon, 10 Mar 2025 at 15:42, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Mar 10, 2025 at 01:48:53PM +0000, Ryan Roberts wrote:
> > > On 10/03/2025 10:55, Mark Rutland wrote:
> > IIUC the problem is that for a sufficiently large (and aligned) extent
> > of physical memory, we might try to create a block mapping larger than
> > the HW supports?
> 
> Yes. However, this code is only called to map the kernel, the DTB and
> the ID map code and data pages, and so it seems unlikely that we'll
> hit this bug in practice.
> 
> Nonetheless, it is a shortcoming that we should address to avoid
> future surprises.
> 
> > With that in mind, my earlier comment about LPA2 and blocks at level-0
> > is particularly relevant...
> 
> Indeed - at the higher levels, there is quite some variation between
> page sizes, LPA2 vs !LPA2 etc in which level is the highest at which
> block mappings are supported.
> 
> But given the context where this code is used, I'd prefer to simply
> map everything down to level 2 or higher (for 64-bit descriptors)
> rather than add elaborate rules for all these combinations that are
> never exercised in practice. The net result should be identical.

That sounds much better to me!

> > Though TBH, maybe it makes more sense to split this up into separate
> > levels (as with the code in arch/arm64/mm/mmu.c) and handle each level
> > explicitly with a separate function. That way each level's check can be
> > handled within that level's function, and we can use the right types,
> > etc. It feels like that might be better for D128 in future?
> 
> I have a slight inclination towards having a separate routine for
> D128, but I can easily be persuaded otherwise.

FWIW, I don't have strong feelings either way w.r.t. sharing the code
with D128. If it's cleaner for that to be separate, sure, but I'd have
to see the code.

My concern here was the the current recursive nature of the PI
map_range() function makes it hard to have level-specific behaviour, and
means that it's structurally different to most other code in the kernel,
e.g. the alloc_init_pXX() functions in arch/arm64/mm/mmu.c, where we
have separate functions for each of the levels that handle the
level-specific details.

I think that structure of separate functions per level is clearer, even
if it's a bit more code.

Mark.

