Return-Path: <linux-kernel+bounces-276758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26238949805
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8C028213F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC180BFF;
	Tue,  6 Aug 2024 19:10:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0772A1CA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971435; cv=none; b=clMrs7KOmeDWYKNRmvp2YRTnEI+mMjPMeq26JlVOpo6cqpodxBP5muW5abhCwv3rFeiYuwsqLpQBuWDzTU5bgKY7U3/b5pucrioQX6xUboepHZCsG2rkUfROrpqTs2lWgb3xxuoVp27heA2UlKSig8t7qI5fP14gkfeaYblVBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971435; c=relaxed/simple;
	bh=z6WPwhGFP8EvUbEwoSFh4HH4xbYWUvjIPysePECmOEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4NsWMpOV0MFMmGsZ6dKaMXArZORGitjLBx4AW1CjLXDyj/1LBUepAPseqZq6LDwlGBjRESQ6ohyTOBPR0qKoZmICq0brUPyceR5e/sy/ouLTcrTAc6K4oC76LU/Ewv57Qhz75oJ1WSm4b0WpgUYCZWC7c2fVHCh74AkQZf7nAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731ECC32786;
	Tue,  6 Aug 2024 19:10:32 +0000 (UTC)
Date: Tue, 6 Aug 2024 20:10:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, vgoyal@redhat.com,
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrJ1JkyDVpRRB_9e@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>

To Jinjie, if you make generic changes that affect other architectures,
please either cc the individual lists/maintainers or at least cross-post
to linux-arch. I don't follow lkml, there's just too much traffic there.

On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
> On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
> > On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> > will cause system stall as below:
> > 
> > 	 Zone ranges:
> > 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> > 	   Normal   empty
> > 	 Movable zone start for each node
> > 	 Early memory node ranges
> > 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> > 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> > 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> > 	(stall here)
> > 
> > commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> > bug") fix this on 32-bit architecture. However, the problem is not
> > completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> > architecture, for example, when system memory is equal to
> > CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
> 
> Interesting, I didn't expect risc-v defining them like these.
> 
> #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
> #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()

arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
dynamic and x86 does something similar (SZ_64T). Not sure why the
generic code and riscv define it like this.

> > 	-> reserve_crashkernel_generic() and high is true
> > 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> > 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> > 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> > 
> > Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> > to simplify crashkernel reservation code"), x86 do not try to reserve crash
> > memory at low if it fails to alloc above high 4G. However before refator in
> > commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> > crashkernel reservation"), arm64 try to reserve crash memory at low if it
> > fails above high 4G. For 64-bit systems, this attempt is less beneficial
> > than the opposite, remove it to fix this bug and align with native x86
> > implementation.
> 
> And I don't like the idea crashkernel=,high failure will fallback to
> attempt in low area, so this looks good to me.

Well, I kind of liked this behaviour. One can specify ,high as a
preference rather than forcing a range. The arm64 land has different
platforms with some constrained memory layouts. Such fallback works well
as a default command line option shipped with distros without having to
guess the SoC memory layout.

Something like below should fix the issue as well (untested):

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index d3b4cd12bdd1..ae92d6745ef4 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -420,7 +420,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * For crashkernel=size[KMG],high, if the first attempt was
 		 * for high memory, fall back to low memory.
 		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+		if (high && search_end == CRASH_ADDR_HIGH_MAX &&
+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
 			goto retry;

-- 
Catalin

