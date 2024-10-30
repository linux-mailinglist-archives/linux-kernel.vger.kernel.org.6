Return-Path: <linux-kernel+bounces-389369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67AB9B6C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257E01F22486
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BA1CEE81;
	Wed, 30 Oct 2024 18:30:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FD1BD9F4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313030; cv=none; b=BNC+TFYtnyeqQOgaEBTKA068c0qv2JzAc+fptwQSfqdThTE45+1sFxzoQin7XAYbBws4HSDD51E+TO5D1p+DOyuDHSHsdradMsnnX/czPnO22VIcnDQ0NanHe1k7fUh3WjKWRY8FDMrrW71ZrRCtGZOEaE6sMQONGQwTEH6W6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313030; c=relaxed/simple;
	bh=Swj0gFvcs/Xd8ykZLvkqunCjppf0Z7xuBjg+oBLTEM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHxdaw5hefkrJt9qxTtgZZU528bePE+izGFg45i9/a+dxNFK1hKppKJGCtFIIcqb622mkxpedAielS8e6gJ4DmVtrvx+mih7BcevlTKu1cgY+SKrWWkuHnu4lTITz22Qm7LtVo27eLIHCJmhv5LeZsUt7Caevdf7kibV4mpC6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948D2C4CECE;
	Wed, 30 Oct 2024 18:30:26 +0000 (UTC)
Date: Wed, 30 Oct 2024 18:30:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <ZyJ7QNxw9_0kP-N0@arm.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
 <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>

On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
> On 10/30/24 11:58, Catalin Marinas wrote:
> > On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
> >> On 10/29/24 19:11, Lorenzo Stoakes wrote:
> >> > --- a/arch/arm64/include/asm/mman.h
> >> > +++ b/arch/arm64/include/asm/mman.h
> >> > @@ -6,6 +6,8 @@
> >> > 
> >> >  #ifndef BUILD_VDSO
> >> >  #include <linux/compiler.h>
> >> > +#include <linux/fs.h>
> >> > +#include <linux/shmem_fs.h>
> >> >  #include <linux/types.h>
> >> > 
> >> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >> > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >> >  }
> >> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> >> > 
> >> > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> >> > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> >> > +						   unsigned long flags)
> >> >  {
> >> >  	/*
> >> >  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
> >> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
> >> >  	 * filesystem supporting MTE (RAM-based).
> >> 
> >> We should also eventually remove the last sentence or even replace it with
> >> its negation, or somebody might try reintroducing the pattern that won't
> >> work anymore (wasn't there such a hugetlbfs thing in -next?).
> > 
> > I agree, we should update this comment as well though as a fix this
> > patch is fine for now.
> > 
> > There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
> > should still work after the above change but we'd need to move it over
> 
> I guess it will work after the above change, but not after 5/5?
> 
> > here (and fix the comment at the same time). We'll probably do it around
> > -rc1 or maybe earlier once this fix hits mainline.
> 
> I assume this will hopefully go to rc7.
> 
> > I don't think we have
> > an equivalent of shmem_file() for hugetlbfs, we'll need to figure
> > something out.
> 
> I've found is_file_hugepages(), could work? And while adding the hugetlbfs
> change here, the comment could be adjusted too, right?

Right, thanks for the hint.

I guess the conflict resolution in -next will be something like:

----------------8<----------------------------------
diff --cc arch/arm64/include/asm/mman.h
index 798d965760d4,65bc2b07f666..8b9b819196e5
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@@ -42,7 -39,7 +42,7 @@@ static inline unsigned long arch_calc_v
  	 * filesystem supporting MTE (RAM-based).
  	 */
  	if (system_supports_mte() &&
- 	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 -	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
++	    ((flags & (MAP_ANONYMOUS | MAP_HUGETLB)) || shmem_file(file)))
  		return VM_MTE_ALLOWED;

  	return 0;
----------------8<----------------------------------

The fix-up for hugetlbfs is something like:

----------------8<----------------------------------
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 8b9b819196e5..988eff8269a6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -6,6 +6,7 @@

 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
+#include <linux/hugetlb.h>
 #include <linux/fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/types.h>
@@ -37,12 +38,12 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
 						   unsigned long flags)
 {
 	/*
-	 * Only allow MTE on anonymous mappings as these are guaranteed to be
-	 * backed by tags-capable memory. The vm_flags may be overridden by a
-	 * filesystem supporting MTE (RAM-based).
+	 * Only allow MTE on anonymous, shmem and hugetlb mappings as these
+	 * are guaranteed to be backed by tags-capable memory.
 	 */
 	if (system_supports_mte() &&
-	    ((flags & (MAP_ANONYMOUS | MAP_HUGETLB)) || shmem_file(file)))
+	    ((flags & (MAP_ANONYMOUS | MAP_HUGETLB)) || shmem_file(file) ||
+	     (file && is_file_hugepages(file))))
 		return VM_MTE_ALLOWED;

 	return 0;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f26b3b53d7de..5cf327337e22 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
+	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;

 	ret = seal_check_write(info->seals, vma);
----------------8<----------------------------------

We still have VM_DATA_DEFAULT_FLAGS but I think this is fine, the flag
is set by the arch code. This is only to allow mprotect(PROT_MTE) on brk
ranges if any user app wants to do that.

I did not specifically require that only the arch code sets
VM_MTE_ALLOWED but I'd expect it to be the case unless we get some
obscure arm-specific driver that wants to allow MTE on mmap for on-chip
memory (very unlikely though).

That 'if' block needs to be split into multiple ones, it becomes harder
to read. shmem_file() does check for !file but is_file_hugepages()
doesn't, might as well put them under the same 'if' block. And thinking
about it, current arm64 code seems broken as it allows
mmap(MAP_ANONYMOUS | MAP_HUGETLB) but it doesn't actually work properly
prior to Yang's patch in -next.

-- 
Catalin

