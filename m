Return-Path: <linux-kernel+bounces-173125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13E8BFBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2331F22D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1983CD2;
	Wed,  8 May 2024 11:20:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779F824BF;
	Wed,  8 May 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167247; cv=none; b=bHUJmnIQ9CGT2nw4KszTFtdU/46r5WmJyzk5PeTnikDk174HFvr/F4x8PNBgGtxXpnd+wQlJ+BH4a3mp9FiuDmxeHFHtv5+Uirr/ZWKTNRgBFMXZDnaImkFY2k9foIVLOVG7DFiOC489qLqgOoYHerjWYuWNwCIivfrmiy0uKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167247; c=relaxed/simple;
	bh=SOFK6vxi3GZWSiC2GhxKzkoWc9mqFMse7HMQCdT9VYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+UQ5qMNd6iPHAfCWeMMyP+9mxEsMn8E/r7+kmccBnIoem8NYAaWVn2OD3NklMzW72g9w5vnnhjRn2zU4t2tYxUe6LVjWyybac1ThN4tEXH8oHABBIDwWHz9hW0l3dustno5lCpH7q+q1sBgUJANc7dAiJU0Gc541KbASPqb8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392AFC4DDE1;
	Wed,  8 May 2024 11:20:44 +0000 (UTC)
Date: Wed, 8 May 2024 12:20:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <ZjtgCfhQDJus3dqI@arm.com>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>

On Tue, Apr 30, 2024 at 11:05:01AM -0500, Maxwell Bland wrote:
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
> index 5dcfc5d7cddf..350eea06300e 100644
> --- a/Documentation/arch/arm64/ptdump.rst
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -2,25 +2,24 @@
>  Kernel page table dump
>  ======================
>  
> -ptdump is a debugfs interface that provides a detailed dump of the
> -kernel page tables. It offers a comprehensive overview of the kernel
> -virtual memory layout as well as the attributes associated with the
> -various regions in a human-readable format. It is useful to dump the
> -kernel page tables to verify permissions and memory types. Examining the
> -page table entries and permissions helps identify potential security
> -vulnerabilities such as mappings with overly permissive access rights or
> -improper memory protections.
> +ptdump is a debugfs interface that provides a detailed dump of the kernel page
> +tables. It offers a comprehensive overview of the kernel virtual memory layout
> +as well as the attributes associated with the various regions in a
> +human-readable format. It is useful to dump the kernel page tables to verify
> +permissions and memory types. Examining the page table entries and permissions
> +helps identify potential security vulnerabilities such as mappings with overly
> +permissive access rights or improper memory protections.

Please don't re-wrap existing text unless it's a separate patch with no
content change (and with a good justification). It is hard to see
whether anything has changed in this paragraph (or the next ones).

Also, many (most?) text files are wrapped around 72 characters, no need
to re-wrap them at 80, just keep the formatting in that file when adding
new text.

> @@ -29,68 +28,101 @@ configurations and mount debugfs::
>   mount -t debugfs nodev /sys/kernel/debug
>   cat /sys/kernel/debug/kernel_page_tables
>  
> -On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables``
> -one can derive information about the virtual address range of the entry,
> -followed by size of the memory region covered by this entry, the
> -hierarchical structure of the page tables and finally the attributes
> -associated with each page. The page attributes provide information about
> -access permissions, execution capability, type of mapping such as leaf
> -level PTE or block level PGD, PMD and PUD, and access status of a page
> -within the kernel memory. Assessing these attributes can assist in
> -understanding the memory layout, access patterns and security
> -characteristics of the kernel pages.
> +On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables`` one can
> +derive information about the virtual address range of a contiguous group of
> +page table entries, followed by size of the memory region covered by this
> +group, the hierarchical structure of the page tables and finally the attributes
> +associated with each page in the group. Groups are broken up either according
> +to a change in attributes or by parent descriptor, such as a PMD. Note that the
> +set of attributes, and therefore formatting, is not equivalent between entry
> +types. For example, PMD entries have a separate set of attributes from leaf
> +level PTE entries, because they support both the UXNTable and PXNTable
> +permission bits.
> +
> +The page attributes provide information about access permissions, execution
> +capability, type of mapping such as leaf level PTE or block level PGD, PMD and
> +PUD, and access status of a page within the kernel memory. Non-PTE block or
> +page level entries are denoted with either "BLK" or "TBL", respectively.
> +Assessing these attributes can assist in understanding the memory layout,
> +access patterns and security characteristics of the kernel pages.

I presume there's some new text here.

> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 6986827e0d64..bd4f1df0c444 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -24,6 +24,7 @@
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/ptdump.h>
> +#include <asm/pgalloc.h>
>  
>  
>  #define pt_dump_seq_printf(m, fmt, args...)	\
> @@ -70,6 +71,11 @@ static const struct prot_bits pte_bits[] = {
>  		.val	= PTE_VALID,
>  		.set	= " ",
>  		.clear	= "F",
> +	}, {
> +		.mask	= PTE_TABLE_BIT,
> +		.val	= PTE_TABLE_BIT,
> +		.set	= "   ",
> +		.clear	= "BLK",
>  	}, {
>  		.mask	= PTE_USER,
>  		.val	= PTE_USER,
> @@ -105,11 +111,6 @@ static const struct prot_bits pte_bits[] = {
>  		.val	= PTE_CONT,
>  		.set	= "CON",
>  		.clear	= "   ",
> -	}, {
> -		.mask	= PTE_TABLE_BIT,
> -		.val	= PTE_TABLE_BIT,
> -		.set	= "   ",
> -		.clear	= "BLK",
>  	}, {
>  		.mask	= PTE_UXN,
>  		.val	= PTE_UXN,

Since you are adding a separate pmd_bits[] array, I think we could get
rid of the PTE_TABLE_BIT entry. It doesn't make sense for ptes anyway.
Why it works currently is that for ptes it won't show anything since we
have the bit set while for p*d entries it should have shown TBL when set
but it's not called on non-leaf entries.

> @@ -143,34 +144,208 @@ static const struct prot_bits pte_bits[] = {
>  	}
>  };
>  
> +static const struct prot_bits pmd_bits[] = {
[...]
> +};
> +
> +static const struct prot_bits pud_bits[] = {
[...]
> +};

Do we need pud_bits[] as well? Can we not just use pmd_bits[]? Call it
pxd_bits if you want, the format is the same for all p*d entries.

> +
>  struct pg_level {
>  	const struct prot_bits *bits;
>  	char name[4];
>  	int num;
>  	u64 mask;
> +	unsigned long size;
>  };
>  
>  static struct pg_level pg_level[] __ro_after_init = {
>  	{ /* pgd */
>  		.name	= "PGD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= PGD_SIZE
>  	}, { /* p4d */
>  		.name	= "P4D",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= P4D_SIZE
>  	}, { /* pud */
>  		.name	= "PUD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pud_bits,
> +		.num	= ARRAY_SIZE(pud_bits),
> +		.size	= PUD_SIZE
>  	}, { /* pmd */
>  		.name	= "PMD",
> -		.bits	= pte_bits,
> -		.num	= ARRAY_SIZE(pte_bits),
> +		.bits	= pmd_bits,
> +		.num	= ARRAY_SIZE(pmd_bits),
> +		.size	= PMD_SIZE
>  	}, { /* pte */
>  		.name	= "PTE",
>  		.bits	= pte_bits,
>  		.num	= ARRAY_SIZE(pte_bits),
> +		.size	= PAGE_SIZE
>  	},
>  };
>  
> @@ -225,8 +400,9 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>  		      u64 val)
>  {
>  	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
> -	static const char units[] = "KMGTPE";
> +	static const char units[] = "BKMGTPE";
>  	u64 prot = 0;
> +	int i = 0;
>  
>  	/* check if the current level has been folded dynamically */
>  	if ((level == 1 && mm_p4d_folded(st->mm)) ||
> @@ -241,20 +417,33 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>  		st->current_prot = prot;
>  		st->start_address = addr;
>  		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> -	} else if (prot != st->current_prot || level != st->level ||
> -		   addr >= st->marker[1].start_address) {
> +	} else if ((prot != st->current_prot || level != st->level ||
> +		   addr >= st->marker[1].start_address)) {
>  		const char *unit = units;
>  		unsigned long delta;
>  
> +		for (i = 0; i < st->level; i++)
> +			pt_dump_seq_printf(st->seq, "  ");

Please separate the alignment changes into a different patch, it makes
it easier to review what's new functionality, what's cosmetic. I'm also
not particularly keen on the new alignment. It's fine to have the
sub-ranges indented but I'd keep the bits/permissions/size/etc. aligned.

> +
>  		if (st->current_prot) {
>  			note_prot_uxn(st, addr);
>  			note_prot_wx(st, addr);
>  		}
>  
> -		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> -				   st->start_address, addr);
> +		/*
> +		 * Entries are coalesced into a single line, so non-leaf
> +		 * entries have no size relative to start_address
> +		 */
> +		if (st->start_address != addr) {
> +			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> +					   st->start_address, addr);
> +			delta = (addr - st->start_address);

What's this supposed to show? In your example, it's strange that the PGD
is shown as 128 bytes:

+ 0xffff020000000000-0xffff020000000080         128B PGD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL
+     0xffff020000000000-0xffff023080000000         194G PUD
+     0xffff023080000000-0xffff0230c0000000           1G PUD   TBL     RW               NXTbl UXNTbl    MEM/NORMAL

The table pgd entries should cover full pud ranges below. I don't know
how it ended up with 0x...80 as the end of the range for the pgd. Should
it show a PGD_SIZE * number_of_entries instead?

> +		} else {
> +			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ", addr,
> +					   addr + pg_level[st->level].size);
> +			delta = (pg_level[st->level].size);
> +		}
>  
> -		delta = (addr - st->start_address) >> 10;
>  		while (!(delta & 1023) && unit[1]) {
>  			delta >>= 10;
>  			unit++;
> @@ -301,7 +490,8 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  			.range = (struct ptdump_range[]){
>  				{info->base_addr, end},
>  				{0, 0}
> -			}
> +			},
> +			.note_non_leaf = true
>  		}
>  	};
>  
> diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
> index 8dbd51ea8626..b3e793a5c77f 100644
> --- a/include/linux/ptdump.h
> +++ b/include/linux/ptdump.h
> @@ -16,6 +16,7 @@ struct ptdump_state {
>  			  int level, u64 val);
>  	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
>  	const struct ptdump_range *range;
> +	bool note_non_leaf;
>  };
>  
>  bool ptdump_walk_pgd_level_core(struct seq_file *m,
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 106e1d66e9f9..97da7a765b22 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -41,6 +41,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>  	if (st->effective_prot)
>  		st->effective_prot(st, 0, pgd_val(val));
>  
> +	if (st->note_non_leaf && !pgd_leaf(val))
> +		st->note_page(st, addr, 0, pgd_val(val));
> +
>  	if (pgd_leaf(val)) {
>  		st->note_page(st, addr, 0, pgd_val(val));
>  		walk->action = ACTION_CONTINUE;

Is the difference between leaf and non-leaf calls only the walk->action?
We could have a single call to st->note_page() and keep the walk->action
setting separately. Do we also need to set ACTION_SUBTREE in case the
entry is a table entry? Or is it done in the caller somewhere? I could
not figure out.

An alternative would be to have an ARCH_WANT_NON_LEAF_PTDUMP Kconfig
option instead of a bool note_non_leaf in struct ptdump_state. This
option seems to be entirely static, not sure it's worth a struct member
for it. You'd use IS_ENABLED() above instead of st->note_non_leaf.

-- 
Catalin

