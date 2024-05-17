Return-Path: <linux-kernel+bounces-182406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5D8C8AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53045281B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096A13DBBF;
	Fri, 17 May 2024 17:25:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77638DD6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966747; cv=none; b=VYWdr6TjlqSB8A0lIFvE/C5sNNsc2yVAQpWf0xto0EfPfyBRZwWeqHM5v+EWED2Pigad+szXNZmlzgg3FfhBBt41OIUBR/aXqHbFDnDaAfjRpUKv3quG/PEmD8XedG5+Hr1oMh4t7QjpdBRdqek1x0CpJOkuus8kw0qg5YspSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966747; c=relaxed/simple;
	bh=xTrgfjrD4g3Hlii3WVx0sS/D+vbmZjqWJkxgae/P9qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meb2vAnAuYGb2CnK5cDpL+4psQgTelG2ov0xY9XsPxRe0mYgPA6apdSLJJprThaItp76DRGbBVcYV/dzJePpNcmemsnqTw79aEPSH59Pk6XT8RR0fcit5vdGu5fuY0EnT5jvp6oikHZa1t7uhuDTpyNDZ9/N8kE10EoID1Q47dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24867C2BD10;
	Fri, 17 May 2024 17:25:44 +0000 (UTC)
Date: Fri, 17 May 2024 18:25:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: peterx@redhat.com, will@kernel.org, scott@os.amperecomputing.com,
	cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Message-ID: <ZkeTFiF_OOy80stO@arm.com>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
 <ZkM_WXxEQo51mrK5@arm.com>
 <570c686c-6aa1-43f0-ba31-3597a329e037@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <570c686c-6aa1-43f0-ba31-3597a329e037@os.amperecomputing.com>

On Fri, May 17, 2024 at 09:30:23AM -0700, Yang Shi wrote:
> On 5/14/24 3:39 AM, Catalin Marinas wrote:
> > It would be good to understand why openjdk is doing this instead of a
> > plain write. Is it because it may be racing with some other threads
> > already using the heap? That would be a valid pattern.
> 
> Yes, you are right. I think I quoted the JVM justification in earlier email,
> anyway they said "permit use of memory concurrently with pretouch".

Ah, sorry, I missed that. This seems like a valid reason.

> > A point Will raised was on potential ABI changes introduced by this
> > patch. The ESR_EL1 reported to user remains the same as per the hardware
> > spec (read-only), so from a SIGSEGV we may have some slight behaviour
> > changes:
> > 
> > 1. PTE invalid:
> > 
> >     a) vma is VM_READ && !VM_WRITE permission - SIGSEGV reported with
> >        ESR_EL1.WnR == 0 in sigcontext with your patch. Without this
> >        patch, the PTE is mapped as PTE_RDONLY first and a subsequent
> >        fault will report SIGSEGV with ESR_EL1.WnR == 1.
> 
> I think I can do something like the below conceptually:
> 
> if is_el0_atomic_instr && !is_write_abort
>     force_write = true
> 
> if VM_READ && !VM_WRITE && force_write == true

Nit: write implies read, so you only need to check !write.

>     vm_flags = VM_READ
>     mm_flags ~= FAULT_FLAG_WRITE
> 
> Then we just fallback to read fault. The following write fault will trigger
> SIGSEGV with consistent ABI.

I think this should work. So instead of reporting the write fault
directly in case of a read-only vma, we let the core code handle the
read fault and first and we retry the atomic instruction.

> >     b) vma is !VM_READ && !VM_WRITE permission - SIGSEGV reported with
> >        ESR_EL1.WnR == 0, so no change from current behaviour, unless we
> >        fix the patch for (1.a) to fake the WnR bit which would change the
> >        current expectations.
> > 
> > 2. PTE valid with PTE_RDONLY - we get a normal writeable fault in
> >     hardware, no need to fix ESR_EL1 up.
> > 
> > The patch would have to address (1) above but faking the ESR_EL1.WnR bit
> > based on the vma flags looks a bit fragile.
> 
> I think we don't need to fake the ESR_EL1.WnR bit with the fallback.

I agree, with your approach above we don't need to fake WnR.

> > Similarly, we have userfaultfd that reports the fault to user. I think
> > in scenario (1) the kernel will report UFFD_PAGEFAULT_FLAG_WRITE with
> > your patch but no UFFD_PAGEFAULT_FLAG_WP. Without this patch, there are
> > indeed two faults, with the second having both UFFD_PAGEFAULT_FLAG_WP
> > and UFFD_PAGEFAULT_FLAG_WRITE set.
> 
> I don't quite get what the problem is. IIUC, uffd just needs a signal from
> kernel to tell this area will be written. It seems not break the semantic.
> Added Peter Xu in this loop, who is the uffd developer. He may shed some
> light.

Not really familiar with uffd but just looking at the code, if a handler
is registered for both MODE_MISSING and MODE_WP, currently the atomic
instruction signals a user fault without UFFD_PAGEFAULT_FLAG_WRITE (the
do_anonymous_page() path). If the page is mapped by the uffd handler as
the zero page, a restart of the instruction would signal
UFFD_PAGEFAULT_FLAG_WRITE and UFFD_PAGEFAULT_FLAG_WP (the do_wp_page()
path).

With your patch, we get the equivalent of UFFD_PAGEFAULT_FLAG_WRITE on
the first attempt, just like having a STR instruction instead of
separate LDR + STR (as the atomics behave from a fault perspective).

However, I don't think that's a problem, the uffd handler should cope
with an STR anyway, so it's not some unexpected combination of flags.

-- 
Catalin

