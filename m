Return-Path: <linux-kernel+bounces-539031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F5A49FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD171188BDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4826E140;
	Fri, 28 Feb 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKQ7WrNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CD1AA1C9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762683; cv=none; b=qLyRBEqEqnbEyVpVKrkEOqznk63znSsZbtcGbZg7pIBxVdvViJ+APOnnzZSDrPGnwMce+o20MzKasC1pzsthASnOasC424i0f/ip7KYT8zpGqp0lytSbRVi1yXC1J0q8bHDGcDDUryEBFGYd4MABVY8pLJaIJ+5x/dTCLOSPa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762683; c=relaxed/simple;
	bh=eOBvfLPd6sH6pwSfSsDL1pZRdm6y/Ph/EACXvVNoXHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyVSmflLzk5Poxn+//8hlCckmzep+8d3zrTlbWhtWzS/+VABZlTuT+ZRWPN8+Rc3VN1hKFv6OmR2rLteBBGby1JiS8Ax204rmW6VfjVZMBj9/O+0Ofes2MEM9AWcv+V29ZJYjD6DMgGn5tCSZIeI52vuEQEGp3RBZlHCAsv1Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKQ7WrNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699F3C4CED6;
	Fri, 28 Feb 2025 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762682;
	bh=eOBvfLPd6sH6pwSfSsDL1pZRdm6y/Ph/EACXvVNoXHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKQ7WrNy/bx4Qm/45aVxbZA98WxyXe7VTlzuCQOcMcfq0IS5jGfmlZ9+7NiXwhu+X
	 wwEkv5+GHZwmk8oNTR7Z5xQiA69Jlp43jWRnUJkgZbCduS/GQArLSWO8XmUHKnkZX7
	 /8C6uhE2Wx4o9GL2RpVn1+Y37JR0yitbfJCHPR5nyBkXDYAfDhWrUNZSCwNKrzbLmp
	 nANHoUUhedDupyLEDsPAqM2lQ0lJBoRp8IAMpyq+vLFG+yF+oQWFqfMjRxUlMyygEQ
	 F4ZKll4emGmLNvh9ewqsNZMYJA7IH+F2crs5y9+rBY4wOKCMEdSx+DF22zcQ1tgM+k
	 Nn+22z2UntsEQ==
Date: Fri, 28 Feb 2025 18:11:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8HuMFQLex_cVn8j@gmail.com>
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
 <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
 <Z8DY7P6UJFyCg47Z@gmail.com>
 <Z8DZcj-jrTJIOat8@gmail.com>
 <9381647d-de62-4c72-9b1c-930cbd9231d6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9381647d-de62-4c72-9b1c-930cbd9231d6@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> > > I propose a new addition, an extension of functionality: if a new 
> > > CPUID bit indicates it, and a new MSR is written, XFEATURES bit 3 
> > > becomes active again - and the MPX area is now used by AVX. 
> > > Obviously only AVX-aware host and guest kernels would enable AVX.
> > 
> > Erm, s/AVX/APX ...
> 
> Just thought of another aspect of this:
> 
> I'm curious about how core dumps should handle this. Initially, an 
> xfeature mask was added to the software-reserved area [1] to indicate 
> which xfeatures were present in the layout. More recently, a new note 
> [2] was introduced to expose CPUID-reported size and offset 
> information, helping tools like GDB. From an offline interpretation 
> standpoint, I think these bits will become ambiguous without further 
> extensions.
> 
> [1] commit 5b3efd500854 ("x86, ptrace: regset extensions to support xstate")
> [2] commit ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86
> core files")

Okay, I guess I agree and you guys are right, the MPX/APX ambiguity is 
probably not worth it.

Still not happy about xfeature_noncompact_order[], but I guess that is 
the price if we want to reuse the MPX area. :-/

Thanks,

	Ingo

