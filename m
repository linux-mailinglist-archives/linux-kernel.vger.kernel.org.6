Return-Path: <linux-kernel+bounces-256406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544C934DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32D61F23D91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAEA13D262;
	Thu, 18 Jul 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kohwbtlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8513C80F;
	Thu, 18 Jul 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308474; cv=none; b=BD2quDv8xKr7O3COJmZopd+7pGl0oWxwyrTVsy3cGY3eYT9QyM6gf24b+IqNPkrenHwwl9v3PNLATts/R8WPbuNhqE/OXBflsyvfT/Fpvy56rNbsqpK7kHcYW3D67vALPmqMrmxxOWCLRga/wQYuc651zoFvykzq6c+PVE7HmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308474; c=relaxed/simple;
	bh=HvrJ9oF4i6bQhzSV0CfGEEb9fgSftBt40VoTMdJ6uxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfEewgy8dBRl99FG1JBUMqCzp6H9m3ZZzA345w5b/gYP1UFR4+MRV9BNd30VHfJtnX3RN80dSpFKVe2CIlVaiLkqHxZ4lmhZMWMcDlfDFd5yS7k+E2O3S6WkqrW88/7lFWm04/Q2gzBNxV7san0bcZB3Lx+nJKRZFms05xLMv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kohwbtlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655A0C116B1;
	Thu, 18 Jul 2024 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721308474;
	bh=HvrJ9oF4i6bQhzSV0CfGEEb9fgSftBt40VoTMdJ6uxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kohwbtlZAW0NkahfLKpf6AS09Jn/Gy//fwHk2p2jfOja9MlwghkCWBkrohbkyV26v
	 RvFn597yfmv6Js+6xv1t/XwPcs3NDtAQueB0BMBGlZiSgdoybnkC+DgCn5mPz3qIBO
	 T6t1rAtbuMd5kRVzMv4xO8He/BJF0jERUtOFLsSKRVO/jYGDvMTSNtmxWfcce+B5PA
	 L1d2COfz5pz7y3syNoajDo3KcroceWhEUhGZVcOnW4LrUhFgdgG4JYFP1exBCtvjaz
	 uQSdaLmWehWYGSauYvbItyCdJ25N3SecMB47BRSIBH3eNfi5b7/V7uSLpJgPdgT46X
	 QPcEIgTlYZRow==
Date: Thu, 18 Jul 2024 14:14:28 +0100
From: Will Deacon <will@kernel.org>
To: Asahi Lina <lina@asahilina.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
	mark.rutland@arm.com, ardb@kernel.org
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
Message-ID: <20240718131428.GA21243@willie-the-truck>
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Lina, [+Ard, Mark and Ryan],

On Thu, Jul 18, 2024 at 06:39:10PM +0900, Asahi Lina wrote:
> I ran into this with the Asahi Linux downstream kernel, based on v6.9.9,
> but I believe the problem is also still upstream. The issue seems to be
> an interaction between folding one page table level at compile time and
> another one at runtime.

Thanks for reporting this!

> With this config, we have:
> 
> CONFIG_PGTABLE_LEVELS=4
> PAGE_SHIFT=14
> PMD_SHIFT=25
> PUD_SHIFT=36
> PGDIR_SHIFT=47
> pgtable_l5_enabled() == false (compile time)
> pgtable_l4_enabled() == false (runtime, due to no LPA2)

I think this is 'defconfig' w/ 16k pages, although I wasn't able to
trigger the issue quickly under QEMU with that. Your analysis looks
correct, however.

> With p4d folded at compile-time, and pud folded at runtime when LPA2 is
> not supported.
> 
> With this setup, pgd_offset() is broken since the pgd is actually
> supposed to become a pud but the shift is wrong, as it is set at compile
> time:
> 
> #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> 
> static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
> {
>         return (pgd + pgd_index(address));
> };
> 
> Then we follow the gup logic (abbreviated):
> 
> gup_pgd_range:
>     pgdp = pgd_offset(current->mm, addr);
>     pgd_t pgd = READ_ONCE(*pgdp);
> 
> At this point, pgd is just the 0th entry of the top level page table
> (since those extra address bits will always be 0 for valid 47-bit user
> addresses).
> 
> p4d then gets folded via pgtable-nop4d.h:
> 
> gup_p4d_range:
>     p4dp = p4d_offset_lockless(pgdp, pgd, addr);
>          = p4d_offset(&(pgd), address)
>          = &pgd
>     p4d_t p4d = READ_ONCE(*p4dp);
> 
> Now we have p4dp = stack address of pgd, and p4d = pgd.
> 
> gup_pud_range:
>     pudp = pud_offset_lockless(p4dp, p4d, addr);
>          -> if (!pgtable_l4_enabled())
>            = p4d_to_folded_pud(p4dp, addr);
>            = (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
>     pud_t pud = READ_ONCE(*pudp);
> 
> Which is bad pointer math because it only works if p4dp points to a real
> page table entry inside a page table, not a single u64 stack address.

Cheers for the explanation; I agree that 6.10 looks like it's affected
in the same way, even though I couldn't reproduce the crash. I think the
root of the problem is that p4d_offset_lockless() returns a stack
address when the p4d level is folded. I wondered about changing the
dummy pXd_offset_lockless() definitions in linux/pgtable.h to pass the
real pointer through instead of the address of the local, but then I
suppose _most_ pXd_offset() implementations are going to dereference
that and it would break the whole point of having _lockless routines
to start with.

What if we provided our own implementation of p4d_offset_lockless()
for the folding case, which could just propagate the page-table pointer?
Diff below.

> This causes random oopses in internal_get_user_pages_fast and related
> codepaths.

Do you have a reliable way to trigger those? I tried doing some GUPpy
things like strace (access_process_vm()) but it all seemed fine.

Thanks,

Will

--->8

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..3afe624a39e1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
 
 #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
 
+static inline
+p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
+{
+       return p4d_offset(pgdp, addr);
+}
+#define p4d_offset_lockless p4d_offset_lockless
+
 #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
 
 #define pgd_ERROR(e)   \


