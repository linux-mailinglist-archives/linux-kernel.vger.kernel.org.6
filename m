Return-Path: <linux-kernel+bounces-529876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819DFA42C18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E018902A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AF26656D;
	Mon, 24 Feb 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4maUy39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A826618D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423312; cv=none; b=mB3/H32oce6v/c0TAUjqYIPj9AtR0zzmKgIBoG8h69YF84cZgoMb9sD6bHVvvgP1yaNh3O/V2R9Dt6pU5jWECc6JM9Qixhnw3iJGeuMKWFsKGinbBnon/3Dlp3R7v8o0iq0V5k9+k2Lc8pnRrtcu2qgEjr26aAu04XAPmuEa2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423312; c=relaxed/simple;
	bh=ft8CEFd/B9EWWaNhclgzjiPcmMKBqJqNTYXBKCCQPAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krvYLGU6nI5cPAw7eaSDHvTut4lLU6dH50zM64nvmD/3E2EXlV5b2PKgYx97e7R/LIVLnmUds2bBCaDWZluAYLroroomdA6f36zCTAB0xDATRrki7ur+hZF2Q0aRJ6OMvGX68IGr6J6B+5tvxaHg66YOnZDOpsH8plcco89cVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4maUy39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E49C4CEE7;
	Mon, 24 Feb 2025 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423312;
	bh=ft8CEFd/B9EWWaNhclgzjiPcmMKBqJqNTYXBKCCQPAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4maUy39EIFs+kCzsrz/E+/MhxeYMsNt4SbDcbjtTj5+C6cvHlZ/q1UyUCglnSI3i
	 SyDNXlc3sBao9IwfJDXDfs3P7o6kGbMi69yJhc04e20ra7IXxvW8C/PBBn/w7FDv+Z
	 onZ/Oe7P97WI4aS4b1sg/+xr57FUTqcQPFXdGhsuRQYYbuH2M5JO6RTmegvGAeJmR6
	 a+h80tSf0dR/nlC+PVyWlXJvTCeq2Yf24lIEEsZ/jpXpPAqnN8Ag4oC/nEZpoZlLmb
	 XXa1j445wskciCgSspbtHpBRQZmK4lgjX0UqJDxNLm6/AtSjnU+3HFKWQzMPkYzr2u
	 O1uJjgnIItxEQ==
Date: Mon, 24 Feb 2025 19:55:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, joro@8bytes.org, luto@kernel.org,
	peterz@infradead.org, kirill.shutemov@linux.intel.com,
	rick.p.edgecombe@intel.com, jgross@suse.com
Subject: Re: [RFC][PATCH 0/8] x86/mm: Simplify PAE page table handling
Message-ID: <Z7zAhSAzpU_MCGnO@gmail.com>
References: <20250123172428.D6D8C8D9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123172428.D6D8C8D9@davehans-spike.ostc.intel.com>


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> tl;dr: 32-bit PAE page table handing is a bit different when PTI
> is on and off. Making the handling uniform removes a good amount
> of code at the cost of not sharing kernel PMDs. The downside of
> this simplification is bloating non-PTI PAE kernels by ~2 pages
> per process.
> 
> Anyone who cares about security on 32-bit is running with PTI and
> PAE because PAE has the No-eXecute page table bit. They are already
> paying the 2-page penalty. Anyone who cares more about memory
> footprint than security is probably already running a !PAE kernel
> and will not be affected by this.
> 
> --
> 
> There are two 32-bit x86 hardware page table formats. A 2-level one
> with 32-bit pte_t's and a 3-level one with 64-bit pte_t's called PAE.
> But the PAE one is wonky. It effectively loses a bit of addressing
> radix per level since its PTEs are twice as large. It makes up for
> that by adding the third level, but with only 4 entries in the level.
> 
> This leads to all kinds of fun because this level only needs 32 bytes
> instead of a whole page. Also, since it has only 4 entries in the top
> level, the hardware just always caches the entire thing aggressively.
> Modifying a PAE pgd_t ends up needing different rules than the other
> other x86 paging modes and probably every other architecture too.
> 
> PAE support got even weirder when Xen came along. Xen wants to trap
> into the hypervisor on page table writes and so it protects the guest
> page tables with paging protections. It can't protect a 32 byte
> object with paging protections so it bloats the 32-byte object out
> to a page. Xen also didn't support sharing kernel PMD pages.  This
> is mostly moot now because the Xen support running as a 32-bit guest
> was ripped out, but there are still remnants around.
> 
> PAE also interacts with PTI in fun and exciting ways. Since pgd
> updates are so fraught, the PTI PAE implementation just chose to
> avoid pgd updates by preallocating all the PMDs up front since
> there are only 4 instead of 512 or 1024 in the other x86 paging
> modes.
> 
> Make PAE less weird:
>  * Always allocate a page for PAE PGDs. This brings them in line
>    with the other 2 paging modes. It was done for Xen and for
>    PTI already and nobody screamed, so just do it everywhere.
>  * Never share kernel PMD pages. This brings PAE in line with
>    32-bit !PAE and 64-bit.
>  * Always preallocate all PAE PMD pages. This basically makes
>    all PAE kernels behave like PTI ones. It might waste a page
>    of memory, but all 4 pages probably get allocated in the common
>    case anyway.
> 
> --
> 
>  include/asm/pgtable-2level_types.h |    2
>  include/asm/pgtable-3level_types.h |    4 -
>  include/asm/pgtable_64_types.h     |    2
>  mm/pat/set_memory.c                |    2
>  mm/pgtable.c                       |  104 +++++--------------------------------
>  5 files changed, 18 insertions(+), 96 deletions(-)

The diffstat alone is pretty nice, so I'd suggest we pursue this series 
even if continued work on 32-bit kernel features is being questioned. 
Until the code exists and isn't explicitly marked as obsolete, such 
changes are legit.

Thanks,

	Ingo

