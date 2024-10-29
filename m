Return-Path: <linux-kernel+bounces-387368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D359B5001
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543861C2297F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62501D3644;
	Tue, 29 Oct 2024 17:02:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798782876
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221348; cv=none; b=Vr+rO+Ur99A7FUy5sjpVtY1gwp8gVE/+trPRKLOiaUg79cHhoBavw1Fh3gFZRjh3MOWu9oAXIkf15sCdBVaIcJO2hsEMxsS4A9j3JKLrxBgp2vHWTHxkTInL9BJJCVM0IURH+4svM3kYVaBk8VQr8ddb/mkLqb92FRKF3vBDtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221348; c=relaxed/simple;
	bh=RZpUIIUZcGqeScb5e4AfR0/NMdbXqRlmZUW4n6BlugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzKpAkI9YcrjMti+yGlpv+LKrnz1FTtpgptpdVNQ/QsmkhVkHZpfvOtk4TwD5Td+Mr+1WNfbzqWFz8wOwkSDNUnoeNAAAaBWz5/DFiNmyt08VWxghBf5rRg/GGQfSdlww6i06TQeCVzFWin64Yuh6BfTK/7WFhKKCSNM8QtwKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC5C4CECD;
	Tue, 29 Oct 2024 17:02:25 +0000 (UTC)
Date: Tue, 29 Oct 2024 17:02:23 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <ZyEVHy-767RfFwh_@arm.com>
References: <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
 <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
 <ZyEL0s_qiyAYURR2@arm.com>
 <a050599e-6d43-4759-b08c-d37c0d28ce0e@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a050599e-6d43-4759-b08c-d37c0d28ce0e@lucifer.local>

On Tue, Oct 29, 2024 at 04:36:32PM +0000, Lorenzo Stoakes wrote:
> On Tue, Oct 29, 2024 at 04:22:42PM +0000, Catalin Marinas wrote:
> > On Tue, Oct 29, 2024 at 03:16:00PM +0000, Lorenzo Stoakes wrote:
> > > On Tue, Oct 29, 2024 at 03:04:41PM +0000, Catalin Marinas wrote:
> > > > On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> > > > > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > > > > MAP_ANON.
> > > > [...]
> > > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > > index 4ba1d00fabda..e87f5d6799a7 100644
> > > > > --- a/mm/shmem.c
> > > > > +++ b/mm/shmem.c
> > > > > @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >
> > > > > -	/* arm64 - allow memory tagging on RAM-based files */
> > > > > -	vm_flags_set(vma, VM_MTE_ALLOWED);
> > > >
> > > > This breaks arm64 KVM if the VMM uses shared mappings for the memory
> > > > slots (which is possible). We have kvm_vma_mte_allowed() that checks for
> > > > the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.
> > >
> > > Ugh yup missed that thanks.
> > >
> > > > I need to read this thread properly but why not pass the file argument
> > > > to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?
> > >
> > > Can't really do that as it is entangled in a bunch of other stuff,
> > > e.g. calc_vm_prot_bits() would have to pass file and that's used in a bunch
> > > of places including arch code and... etc. etc.
> >
> > Not calc_vm_prot_bits() but calc_vm_flag_bits().
> > arch_calc_vm_flag_bits() is only implemented by two architectures -
> > arm64 and parisc and calc_vm_flag_bits() is only called from do_mmap().
> >
> > Basically we want to set VM_MTE_ALLOWED early during the mmap() call
> > and, at the time, my thinking was to do it in calc_vm_flag_bits(). The
> > calc_vm_prot_bits() OTOH is also called on the mprotect() path and is
> > responsible for translating PROT_MTE into a VM_MTE flag without any
> > checks. arch_validate_flags() would check if VM_MTE comes together with
> > VM_MTE_ALLOWED. But, as in the KVM case, that's not the only function
> > checking VM_MTE_ALLOWED.
> >
> > Since calc_vm_flag_bits() did not take a file argument, the lazy
> > approach was to add the flag explicitly for shmem (and hugetlbfs in
> > -next). But I think it would be easier to just add the file argument to
> > calc_vm_flag_bits() and do the check in the arch code to return
> > VM_MTE_ALLOWED. AFAICT, this is called before mmap_region() and
> > arch_validate_flags() (unless I missed something in the recent
> > reworking).
> 
> I mean I totally get why you're suggesting it

Not sure ;)

> - it's the right _place_ but...
> It would require changes to a ton of code which is no good for a backport
> and we don't _need_ to do it.
> 
> I'd rather do the smallest delta at this point, as I am not a huge fan of
> sticking it in here (I mean your point is wholly valid - it's at a better
> place to do so and we can change flags here, it's just - it's not where you
> expect to do this obviously).
> 
> I mean for instance in arch/x86/kernel/cpu/sgx/encl.c (a file I'd _really_
> like us not to touch here by the way) we'd have to what pass NULL?

That's calc_vm_prot_bits(). I suggested calc_vm_flag_bits() (I know,
confusing names and total lack of inspiration when we added MTE
support). The latter is only called in one place - do_mmap().

That's what I meant (untested, on top of -next as it has a MAP_HUGETLB
check in there). I don't think it's much worse than your proposal,
assuming that it works:

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 1dbfb56cb313..358bbaaafd41 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -6,6 +6,8 @@

 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>

 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
@@ -31,7 +33,7 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)

-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
@@ -39,12 +41,12 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 	 * filesystem supporting MTE (RAM-based).
 	 */
 	if (system_supports_mte() &&
-	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
+	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB) || shmem_file(file)))
 		return VM_MTE_ALLOWED;

 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)

 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 89b6beeda0b8..663f587dc789 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__

+#include <linux/fs.h>
 #include <uapi/asm/mman.h>

 /* PARISC cannot allow mdwe as it needs writable stacks */
@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported

-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	/*
 	 * The stack on parisc grows upwards, so if userspace requests memory
@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)

 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)

 #endif /* __ASM_MMAN_H__ */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 8ddca62d6460..a842783ffa62 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H

+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>

@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
 #endif

 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif

 #ifndef arch_validate_prot
@@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }

 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index f102314bb500..f904b3bba962 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -344,7 +344,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

 	/* Obtain the address to map to. we verify (or select) it and ensure
diff --git a/mm/nommu.c b/mm/nommu.c
index 635d028d647b..e9b5f527ab5b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -842,7 +842,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;

-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);

 	if (!file) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index f24a0f34723e..ff194341fddb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2737,9 +2737,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;

-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)

-- 
Catalin

