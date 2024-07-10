Return-Path: <linux-kernel+bounces-247333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11C92CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C859A2815B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DEA18FA02;
	Wed, 10 Jul 2024 09:22:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7517BB31
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603352; cv=none; b=aMWu0D9dkXP8W5NUuMQ1TGd/WKD3v0q/eknP6By5d8SDMElnjBIRl9ZTXzyexVSphxpSko4yHqhG2wjorEdquLgsNR10Qdh+NZk8PjZFqNxssc98izA84rGuUEHs+tFB0G2BUhP487jFM4YMBF7otxWYi+Ig8szg7mXrNKbYTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603352; c=relaxed/simple;
	bh=lm/8qfiBjHen1y6BT5w44kd55lk39t21Zsly8ioYfZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po0iArV/ITwpl7woQj3Eu/FA5GEAnHZ9rqYrpQxcjadJN1mB+gh/DeOFj8cCKRQD7X1jbI50/QL1U3tQGZcjQP4WbNWleDFBqPjBsXj9+l7nQsrC2nyqHGrKZm1VFAryHk/WSO1PaDv5TRKrTLcIH76Ozr9DrfvS1zd7qnu2vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB44C32781;
	Wed, 10 Jul 2024 09:22:30 +0000 (UTC)
Date: Wed, 10 Jul 2024 10:22:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zo5S1JE8B912SHya@arm.com>
References: <Zn7q3oL1AE8jdM-g@arm.com>
 <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>

On Tue, Jul 09, 2024 at 03:29:58PM -0700, Yang Shi wrote:
> On 7/9/24 11:35 AM, Catalin Marinas wrote:
> > On Tue, Jul 09, 2024 at 10:56:55AM -0700, Yang Shi wrote:
> > > On 7/4/24 3:03 AM, Catalin Marinas wrote:
> > > I tested exec-only on QEMU tcg, but I don't have a hardware supported EPAN.
> > > I don't think performance benchmark on QEMU tcg makes sense since it is
> > > quite slow, such small overhead is unlikely measurable on it.
> > 
> > Yeah, benchmarking under qemu is pointless. I think you can remove some
> > of the ARM64_HAS_EPAN checks (or replaced them with ARM64_HAS_PAN) just
> > for testing. For security reason, we removed this behaviour in commit
> > 24cecc377463 ("arm64: Revert support for execute-only user mappings")
> > but it's good enough for testing. This should give you PROT_EXEC-only
> > mappings on your hardware.
> 
> Thanks for the suggestion. IIUC, I still can emulate exec-only even though
> hardware doesn't support EPAN? So it means reading exec-only area in kernel
> still can trigger fault, right?

Yes, it's been supported since ARMv8.0. We limited it to EPAN only since
setting a PROT_EXEC mapping still allowed the kernel to access the
memory even if PSTATE.PAN was set.

> And 24cecc377463 ("arm64: Revert support for execute-only user mappings")
> can't be reverted cleanly by git revert, so I did it manually as below.

Yeah, I wasn't expecting that to work.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 6a8b71917e3b..0bdedd415e56 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -573,8 +573,8 @@ static int __kprobes do_page_fault(unsigned long far,
> unsigned long esr,
>                 /* Write implies read */
>                 vm_flags |= VM_WRITE;
>                 /* If EPAN is absent then exec implies read */
> -               if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
> -                       vm_flags |= VM_EXEC;
> +               //if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
> +               //      vm_flags |= VM_EXEC;
>         }
> 
>         if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs))
> {
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 642bdf908b22..d30265d424e4 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
>         [VM_WRITE]                                      = PAGE_READONLY,
>         [VM_WRITE | VM_READ]                            = PAGE_READONLY,
>         /* PAGE_EXECONLY if Enhanced PAN */
> -       [VM_EXEC]                                       = PAGE_READONLY_EXEC,
> +       [VM_EXEC]                                       = PAGE_EXECONLY,
>         [VM_EXEC | VM_READ]                             = PAGE_READONLY_EXEC,
>         [VM_EXEC | VM_WRITE]                            = PAGE_READONLY_EXEC,
>         [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_READONLY_EXEC,

In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
Otherwise it looks fine.

-- 
Catalin

