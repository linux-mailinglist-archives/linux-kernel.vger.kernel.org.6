Return-Path: <linux-kernel+bounces-295335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5C9599C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DE8B23D00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40967213479;
	Wed, 21 Aug 2024 10:18:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333121346C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235526; cv=none; b=e3hlgp5yDdS63BSV93K/87vVttluqP7+Do2E0ZMYcecnzN2GmSI30beSZ6BaRJT75Fa88cUFOGNh2xocA6qcsjYmisAuYQqfzDe9V1/mbtmpoQ+Adlm/gHahZ73VIhLKZgG9QHkrmfFKBt+c8wjG0YnEPLu3hNZTqiW0ZHZ+tzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235526; c=relaxed/simple;
	bh=sBK+hYKC+mESakG2EhxKOTDKpJwSKaRhlIxsc4+kOEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AItZqCIJnTE8gkkgr0iLlOQ2RwYc8hJdfGUQos5vYl3ui0Rijn/dvILYh1f2qLLkHEPXQAaHYyBjR9H9BTOOzQ/htP2qGtPQUuJbgh1610Okujy9/Y4ru0SgH+g7gDx1ToZ2zgvjO5cq9d/RMo508F4TNZcfmlCHKdmd8Rp9YzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF1C32782;
	Wed, 21 Aug 2024 10:18:44 +0000 (UTC)
Date: Wed, 21 Aug 2024 11:18:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <ZsW_AtR-X_CqCMOW@arm.com>
References: <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
 <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
 <ZpAZ39VQhxfNepWT@arm.com>
 <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
X-TUID: q26uPWBeLWyk

On Thu, Jul 11, 2024 at 11:17:51AM -0700, Yang Shi wrote:
> On 7/11/24 10:43 AM, Catalin Marinas wrote:
> > On Wed, Jul 10, 2024 at 11:43:18AM -0700, Yang Shi wrote:
> > > On 7/10/24 2:22 AM, Catalin Marinas wrote:
> > > > > diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> > > > > index 642bdf908b22..d30265d424e4 100644
> > > > > --- a/arch/arm64/mm/mmap.c
> > > > > +++ b/arch/arm64/mm/mmap.c
> > > > > @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] __ro_after_init = {
> > > > >           [VM_WRITE]                                      = PAGE_READONLY,
> > > > >           [VM_WRITE | VM_READ]                            = PAGE_READONLY,
> > > > >           /* PAGE_EXECONLY if Enhanced PAN */
> > > > > -        [VM_EXEC]                                       = PAGE_READONLY_EXEC,
> > > > > +        [VM_EXEC]                                       = PAGE_EXECONLY,
> > > > >           [VM_EXEC | VM_READ]                             = PAGE_READONLY_EXEC,
> > > > >           [VM_EXEC | VM_WRITE]                            = PAGE_READONLY_EXEC,
> > > > >           [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_READONLY_EXEC,
> > > > In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
> > > > Otherwise it looks fine.
> > > Thanks. I just ran the same benchmark. Ran the modified page_fault1_thread
> > > (trigger read fault) in 100 iterations with 160 threads on 160 cores. This
> > > should be the worst contention case and collected the max data (worst
> > > latency). It shows the patch may incur ~30% overhead for exec-only case. The
> > > overhead should just come from the permission fault.
> > > 
> > >      N           Min           Max        Median           Avg Stddev
> > > x 100        163840        219083        184471        183262 12593.229
> > > + 100        211198        285947        233608     238819.98 15253.967
> > > Difference at 95.0% confidence
> > >      55558 +/- 3877
> > >      30.3161% +/- 2.11555%
> > > 
> > > This is a very extreme benchmark, I don't think any real life workload will
> > > spend that much time (sys vs user) in page fault, particularly read fault.
> > > 
> > > With my atomic fault benchmark (populate 1G memory with atomic instruction
> > > then manipulate the value stored in the memory in 100 iterations so the user
> > > time is much longer than sys time), I saw around 13% overhead on sys time
> > > due to the permission fault, but no noticeable change for user and real
> > > time.
> > Thanks for running these tests.
> > 
> > > So the permission fault does incur noticeable overhead for read fault on
> > > exec-only, but it may be not that bad for real life workloads.
> > So you are saying 3 faults is not that bad for real life workloads but
> > the 2 faults behaviour we have currently is problematic for OpenJDK. For
> > the OpenJDK case, I don't think the faulting is the main issue affecting
> > run-time performance but, over a longer run (or with more iterations in
> > this benchmark after the faulting in), you'd notice the breaking up of
> > the initial THP pages.
> 
> I meant the extra permission fault for exec-only should be ok since the
> current implementation can't force write fault for exec-only anyway. It does
> incur noticeable overhead for read fault, but I'm not aware of any real life
> workloads are sensitive to read fault. The benchmark is for a very extreme
> worst case.

I agree microbenchmarks like this are not realistic but I wouldn't be
surprised if we hear of some large file mmap() read or very sparse
arrays read being affected.

Sorry, I forgot the details from the previous discussions. Are there any
benchmarks that show OpenJDK performing badly _and_ what the improvement
is with this patch? We should do similar comparison with the THP kernel
fix. If the THP fix gets us close to the same level of improvement, I
don't think we should bother with this patch.

> > Do you have any OpenJDK benchmarks that show the problem? It might be
> > worth running them with this patch:
> > 
> > https://lore.kernel.org/r/rjudrmg7nkkwfgviqeqluuww6wu6fdrgdsfimtmpjee7lkz2ej@iosd2f6pk4f7
> > 
> > Or, if not, do you see any difference in the user time in your benchmark
> > with the above mm patch? In subsequent iterations, linear accesses are
> > not ideal for testing. Better to have some random accesses this 1GB of
> > memory (after the initial touching). That would mimic heap accesses a
> > bit better.
> 
> I didn't try that patch. I think we discussed this before. This patch can
> remove the THP shattering, we should be able to see some improvement, but
> TBLI is still needed and its cost should be still noticeable because the
> write protection fault still happens.

Yeah, with two faults we do need the subsequent TLBI. But if it's only
one per huge page, it might not be that bad.

> > Anyway, as it stands, I don't think we should merge this patch since it
> > does incur an additional penalty with exec-only mappings and it would
> > make things even worse for OpenJDK if distros change their default
> > toolchain flags at some point to generate exec-only ELF text sections.
> > While we could work around this by allowing the kernel to read the
> > exec-only user mapping with a new flavour of get_user() (toggling PAN as
> > well), I don't think it's worth it. Especially with the above mm change,
> > I think the benefits of this patch aren't justified. Longer term, I hope
> > that customers upgrade to OpenJDK v22 or, for proprietary tools, they
> > either follow the madvise() approach or wait for the Arm architects to
> > change the hardware behaviour.
> 
> If the overhead for exec-only is a concern, I think we can just skip
> exec-only segment for now, right? The exec-only is not that popular yet. And
> if the users prefer security, typically they may be not that sensitive to
> performance.

I don't think we should penalise something that currently works when we
already have solutions for the problematic case (madvise()) and a kernel
improvement on the THP handling. At least not without real-world numbers
to back it up. I don't want to advise people not to compile OpenJDK (or
other software) with exec-only permissions just because the in-kernel
RMW handling will get worse.

Currently exec-only binaries are not wide spread but as FEAT_EPAN (a
precondition) starts to appear in hardware, software may move in this
direction, at least for the pre-built executables (JIT'ed code may incur
additional size penalty to keep the literal pool separated).

My view (as kernel maintainer) is that there aren't strong enough
arguments for merging this patch. It does show an improvement in
specific cases but the downside is the risk of affecting other cases
(plus additional maintenance cost, though I'd expect the opcode checking
to remain the same). I do think the architecture should be changed so
that the kernel gets the right information in the fault handler but it
would be a while before such feature appears in hardware.

-- 
Catalin

