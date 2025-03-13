Return-Path: <linux-kernel+bounces-559501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F081A5F49F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633B616EA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CC265CC3;
	Thu, 13 Mar 2025 12:32:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE81FBC9A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869170; cv=none; b=iA/RKSGl1Cs6mHEfRVUJgldXx6PNiBb8lHkyoD9VuOxLHdgfQMCIayK4PVPykqQRjT6F+IFjZM85jrNAuq+W02BDT13NNaC0u7QKlEehzfHb8TABOT5EFX/NV1/OR18mtGRjiBBAT/PrdG4fgUscotgFWAaCFN0kAiyqqEzVoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869170; c=relaxed/simple;
	bh=SnwVDV9CjjDL6c0kCya8YFk8OXDwWqiHgTPqvxjNHw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9vNuOCyRyksnqGL8VjQFbqFtzXB1KxYX0UYuCgVPHiU/bdibzED5YR8pKafmTFmBGC8jlR9ZzQsSQS+iJKHXg8eqOPXjkS+ozUOh6ChYpHcXiy99ntmyTGOS8qwpQ4HeUQ/Qt41upKhsCDHDHf54OvejQd2K2wTf9YlOGnf1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B091C00;
	Thu, 13 Mar 2025 05:32:57 -0700 (PDT)
Received: from [10.44.160.94] (e126510-lin.lund.arm.com [10.44.160.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99EC03F673;
	Thu, 13 Mar 2025 05:32:42 -0700 (PDT)
Message-ID: <802963a0-32bd-49e8-82b1-34443acdd5ae@arm.com>
Date: Thu, 13 Mar 2025 13:32:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] pkeys-based page table hardening
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
 <a32cjyekuecoowzbitc2xykilvpu6l3jjtityp7x5hw7xbiysp@5l2lptwmqiug>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <a32cjyekuecoowzbitc2xykilvpu6l3jjtityp7x5hw7xbiysp@5l2lptwmqiug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 17:23, Maxwell Bland wrote:
> On Mon, Feb 03, 2025 at 10:18:24AM +0000, Kevin Brodsky wrote:
>> This is a proposal to leverage protection keys (pkeys) to harden
>> critical kernel data, by making it mostly read-only. The series includes
>> a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
>> as well as a page table hardening feature based on that framework
>> (kpkeys_hardened_pgtables). Both are implemented on arm64 as a proof of
>> concept, but they are designed to be compatible with any architecture
>> implementing pkeys.
> Hi Kevin,
>
> This is awesome. When working on some of these problems, I also thought
> of leveraging the POE feature, but was not sure of a good way to make
> it work.

Hi Maxwell,

I'm glad to hear about your interest!

>> Page tables were chosen as they are a popular (and critical) target for
>> attacks, but there are of course many others - this is only a starting
>> point (see section "Further use-cases"). It has become more and more
>> common for accesses to such target data to be mediated by a hypervisor
>> in vendor kernels; the hope is that kpkeys can provide much of that
>> protection in a simpler manner. No benchmarking has been performed at
>> this stage, but the runtime overhead should also be lower (though likely
>> not negligible).
> Some notes here, having implemented similar page table protections,
> albeit using stage-2 page table permissions and a fault handler.
>
> https://lore.kernel.org/all/2wf4kmoqqmod6njviaq33lbxbx6gvdqbksljxykgltwnxo6ruy@7ueumwmxxh72/
>
> I wanted to know your thoughts on associating specific policies to
> page table updates in cases where an adversary is able to corrupt
> other state associated with parameters to the page table infrastructure
> code, e.g.
>
> arch/arm64/net/bpf_jit_comp.c
> 2417:		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target),
>
> Is this something we would assume is handled via the security_* hook
> infrastructure, a shadow stack CFI method, or changing the kernel code
> to reverify the data non-modularly, some combination of the above?

This is a good question and the short answer is that I don't know what
the best approach would be. As far as kpkeys are concerned, I'm not sure
they can really help here - it seems to be about the integrity of a
generated BPF program, and surely that program is already made read-only
once generated?

>> - Pages in the linear mapping are assigned a pkey using set_memory_pkey().
>>   This is sufficient for this series, but of course higher-level
>>   interfaces can be introduced later to ask allocators to return pages
>>   marked with a given pkey. It should also be possible to extend this to
>>   vmalloc() if needed.
> One of the interesting points here, acknowledged below, was that this
> relies on having guarantees around the PC value/CFI of the function.
> Since this is the baseline assumption, it feels natural that the
> locking/unlocking would be associated into the existing CFI
> instrumentation, since (from experience) point-patching each mutable
> data structure allocation/deallocation is difficult.

Could you elaborate on this point? Are you referring to protecting
arbitrary data structures with kpkeys, rather than what this series
covers (i.e. pgtables)?

>> # Further use-cases
>>
>> It should be possible to harden various targets using kpkeys, including:
>>
>> - struct cred (enforcing a "mostly read-only" state once committed)
>>
>> - fixmap (occasionally used even after early boot, e.g.
>>   set_swapper_pgd() in arch/arm64/mm/mmu.c)
>>
>> - SELinux state (e.g. struct selinux_state::initialized)
>>
>> ... and many others.
> Be wary that it is not just struct cred but pointers to struct cred.  We
> quickly run into a problem of, for example, in updates to f_op,
> bookkeeping which f_op is OK to have in the file, e.g., in Android's
> 6.1.x:
>
> drivers/gpu/drm/i810/i810_dma.c
> 138:    file_priv->filp->f_op = &i810_buffer_fops;
> 144:    file_priv->filp->f_op = old_fops;
>
> drivers/staging/android/ashmem.c
> 436:            vmfile->f_op = &vmfile_fops;
>
> Where overwriting f_op is a "classic" bypass of protection systems like
> this one.

Indeed, this has been pointed out to me on a few occasions. On that note
I should reference the follow-up series that aims at protecting struct
cred [1].

Using kpkeys to ensure that the task->cred pointer itself is mostly
read-only is not straightforward, because there is just too much
existing code that directly writes to other fields in task_struct -
meaning we can't simply make the whole task_struct mostly read-only.
What could be done is to split out the cred fields in a separate
kpkeys-protected page, and link that page from task_struct. There is a
clear overhead associated with this approach though, and maybe more
importantly we have just displaced the issue as the pointer to that
protected page remains writeable... I'm not sure how much a page-based
technique like pkeys can help here.

[1]
https://lore.kernel.org/linux-hardening/20250203102809.1223255-1-kevin.brodsky@arm.com/

> I think this problem may be totally solvable if POE was integrated into
> something like CFI, since we can guarantee only the code that sets f_op
> to "vmfile_fops" can unlock/relock the file's page.

I'm interested to hear more about this - I don't think I'm aware of the
CFI instrumentation you're referring to.

> Maybe another approach would work better, though?
>
>> # Open questions
>>
>> A few aspects in this RFC that are debatable and/or worth discussing:
>>
>> - There is currently no restriction on how kpkeys levels map to pkeys
>>   permissions. A typical approach is to allocate one pkey per level and
>>   make it writable at that level only. As the number of levels
>>   increases, we may however run out of pkeys, especially on arm64 (just
>>   8 pkeys with POE). Depending on the use-cases, it may be acceptable to
>>   use the same pkey for the data associated to multiple levels.
> Honestly, I associate each protected virtual page in stage-2 with a
> unique tag (manually, right now, but Kees Cook has some magic that
> does the same via alloc_tag.h), and this works really well to track
> specific resources and resource modification semantics "over" a generic
> protection ring.
>
> I think, though, that the code you provided could be used to bootstrap
> such a system by using the overlay to protect a similar page tag lookup
> table, which then can provide the fine-grained protection semantics.

This sounds sensible. Considering that the size of pkeys is between 3
and 5 bits depending on the architecture, to keep the approach generic
we really don't have many keys to play with (7 excluding the default key
on arm64/POE). kpkeys approaches keys in a static way (no dynamic
allocation), so it's best to think of each key as corresponding to one
subsystem defined at compile time.

> I.e. use this baseline to isolate a secure monitor system.
>
> Hopefully that makes sense! (-:
>
>> - kpkeys_set_level() and kpkeys_restore_pkey_reg() are not symmetric:
>>   the former takes a kpkeys level and returns a pkey register value, to
>>   be consumed by the latter. It would be more intuitive to manipulate
>>   kpkeys levels only. However this assumes that there is a 1:1 mapping
>>   between kpkeys levels and pkey register values, while in principle
>>   the mapping is 1:n (certain pkeys may be used outside the kpkeys
>>   framework).
> Another issue I'm not confident in is the assumption of adversary's
> inability to manipulate system control registers. This is true in the
> context of a Heki-like system (or any well-made HVCI), but not totally
> true of a pure EL1 implementation?

This is entirely reliant on the threat model, i.e. only data-only
attacks are in scope. If the adversary successfully hijacks the control
flow to jump in the middle of a function, or achieves arbitrary code
execution, pkeys won't be of much help. Robust CFI is therefore a clear
prerequisite.

>> - An architecture that supports kpkeys is expected to select
>>   CONFIG_ARCH_HAS_KPKEYS and always enable them if available - there is
>>   no CONFIG_KPKEYS to control this behaviour. Since this creates no
>>   significant overhead (at least on arm64), it seemed better to keep it
>>   simple. Each hardening feature does have its own option and arch
>>   opt-in if needed (CONFIG_KPKEYS_HARDENED_PGTABLES,
>>   CONFIG_ARCH_HAS_KPKEYS_HARDENED_PGTABLES).
> There's so many pieces of data though/data structures! In this model,
> you'd have a separate switch for thousands of types of data! But I do
> think protecting PTs is the first step to a more complicated security
> monitor, since it allows you to have integrity for specific physical
> pages (or IPAs).

Agreed. I think this is good enough for kpkeys where we use roughly one
key per feature (meaning that the total number of features is pretty
limited), but this wouldn't scale if we had a framework to protect many
data types. In that case we'd need a different approach, probably
runtime-based. The advantage of having a CONFIG option per feature
though is that it incurs no overhead at all unless selected.

>>
>> Any comment or feedback will be highly appreciated, be it on the
>> high-level approach or implementation choices!
> Last note, I'd not totallllyyy trust the compiler to inline the
> functions.... I've met cases where functions on memory protections
> I expected to be inlined were not. I think __forceinline *may* work
> here, vs standard "static inline", but am not confident/sure.

That's a fair point, __always_inline could be used to make sure
set_pkey/restore_pkey_reg (and the helpers they call) are actually
inlined. I'll change that in v4. The guard object constructor/destructor
are defined as regular inline functions in <linux/cleanup.h> though, so
the inlining might not be complete.

> Hopefully the above is valuable at all. Thanks!

It is! Thank you for your thoughts and suggestions.

- Kevin

