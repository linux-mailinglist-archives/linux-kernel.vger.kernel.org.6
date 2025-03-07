Return-Path: <linux-kernel+bounces-551499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC3A56D33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0CA16A6C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE2226D18;
	Fri,  7 Mar 2025 16:09:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D132226D0F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363772; cv=none; b=Qefs8hZr8AZRAzvtrdeJG5RvXwqDEhlQphJKrjCRp8FtmNs8aX3tSK3ET2BqiMkp8uhS7KfCyOm1JgTClDEqmkq2YtSN+s+IQBTOxLJ7uAn8wFc6koQpQP8y551wtQcSBxzObxAolALAdVyPGbEwYNtgV0srPKn0fZPbF9eo+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363772; c=relaxed/simple;
	bh=a5KFd6sTkQu+/wDgqrPbXGnZ8YsyJMvOLaM7Xl6i9kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk8dxaI7SFqBOD53QnBfR6o/2iw4oRlV1VDkhpNpSliThG1bTYHAz1qeQVB63uOy5jnHeZXBQHhUEwbkGozCIhJu7q/Z1a98cAwkMNTVJxyVYEhL09fclrC6IG7jdmpjqfMS/OVoTi7a2BcZZfLfBivolwDbSNbCtWsAvBl5VCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0495C1477;
	Fri,  7 Mar 2025 08:09:43 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962E43F673;
	Fri,  7 Mar 2025 08:09:28 -0800 (PST)
Date: Fri, 7 Mar 2025 16:09:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH] arm64/mm: Define PTE_SHIFT
Message-ID: <Z8saM94ixmDNjZzV@J2N7QTR9R3.cambridge.arm.com>
References: <20250307050851.4034393-1-anshuman.khandual@arm.com>
 <17931f83-7142-4ca6-8bfe-466ec53b6e2c@arm.com>
 <c3dddb6f-dce1-45a6-b5f1-1fd247c510ab@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3dddb6f-dce1-45a6-b5f1-1fd247c510ab@arm.com>

On Fri, Mar 07, 2025 at 02:50:56PM +0530, Anshuman Khandual wrote:
> On 3/7/25 14:37, Ryan Roberts wrote:
> > On 07/03/2025 05:08, Anshuman Khandual wrote:

> >>  #define EARLY_LEVEL(lvl, lvls, vstart, vend, add)	\
> >> -	(lvls > lvl ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * (PAGE_SHIFT - 3), add) : 0)
> >> +	(lvls > lvl ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + \
> >> +	lvl * (PAGE_SHIFT - PTE_SHIFT), add) : 0)
> > 
> > nit: not sure what style guide says, but I would indent this continuation an
> > extra level.
> 
> IIUC - An indentation is not normally required with a line continuation although
> the starting letter should match the starting letter in the line above but after
> the '(' (if any).

Regardless of indenttation, the existing code is fairly hard to read,
and I reckon it'd be better to split up, e.g.

| /* Number of VA bits resolved by a single translation table level */
| #define PTDESC_TABLE_SHIFT	(PAGE_SHIFT - PTDESC_ORDER)
| 
| #define __EARLY_LEVEL(lvl, vstart, vend, add) \
| 	EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * PTDESC_TABLE_SHIFT, add)
| 
| #define EARLY_LEVEL(lvl, lvls, vstart, vend, add) \
| 	((lvls) > (lvl) ? __EARLY_LEVEL(lvl, vstart, vend, add) : 0)

... and ignoring the use of _SHIFT vs _ORDER, I think that structure is
far more legible.

With that, we can fold EARLY_ENTRIES() and __EARLY_LEVEL() together and
move the 'add' into EARLY_LEVEL(), e.g.

| /* Number of VA bits resolved by a single translation table level */
| #define PTDESC_TABLE_SHIFT	(PAGE_SHIFT - PTDESC_ORDER)
| 
| #define EARLY_ENTRIES(lvl, vstart, vend) \
| 	(SPAN_NR_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * PTDESC_TABLE_SHIFT))
| 
| #define EARLY_LEVEL(lvl, lvls, vstart, vend, add) \
| 	((lvls) > (lvl) ? EARLY_ENTRIES(lvl, vstart, vend) + (add) : 0)

... which I think makes the 'add' a bit easier to understand too.

Mark.

