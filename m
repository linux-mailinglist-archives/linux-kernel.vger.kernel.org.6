Return-Path: <linux-kernel+bounces-568871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7DAA69B94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E68175350
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25321A443;
	Wed, 19 Mar 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="GyD/LvRn"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3628373
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421304; cv=none; b=uRDeoIiMpHinwRN0u4/cbbqGll2EUim7y3AZMXXIdA/V9V1lFNiMIu1iUSMCjfqWt34b8XohP4Prz6hjzkvoecjodfTxcmyqp60pT43rdbceh6JEYA/cmyBawCwlpJZUTR2zI39bbZxqQ8VvTIcSP6L3+LnQNGth8o3n7p/uC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421304; c=relaxed/simple;
	bh=CtQWB2Pzzg4hfmxmIDPhIwFu/l0ZIgmoUj0ihMHAIlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxV4XE1prPwYJhBrWTtgZHCXeR0muYwZX9OC9kSiXX47guy4sGNKX6eDMs3DZKVvdZUyIPeSRAg/MAtwTUT5xyoGEV2fJ0Tghtf7Gy4XO/xoP3ScCWbCifMWrU6e1pcA/QsrPIRTqDkui833nmNfmDDiGo9/NWmXNxXkghx+mUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=GyD/LvRn; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JIDI9d002570;
	Wed, 19 Mar 2025 21:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=K5q1Tq4MUtANHCIA3p7Ne2S
	0l05egBFo8j33iTHIM5Q=; b=GyD/LvRnfEqxND9BZdGKf+iFZ4ia5ZxO0h8m88W
	5155CAs/HsV4fUXoxsOOqbW59IZcyXprsxWcMj7m7tpHDlv8ztSQqa4bOLZefKY9
	WqIAT854BrH5H5+JFflcSxPfnriYPGf7Lyxjq1gl58w5PuW5bBS7Nfm40bc/lIf9
	gmXFCX/g7KjaMGiFBYKx7u7kKh47bg+VZy8p2SvQ/UzojqgPLG7ART9zF9foe5AD
	tH/9H9ahQHo5V6OFe/u96juXwJbMkrjYtoalAqPS7+1x5vCtlfDXUOBlBPK0yJK2
	e/gFoYROTNE/bhHhPBkTydRHwymLMaqMMcsMXfEM+R4bL4A==
Received: from iadlppfpol2.lenovo.com ([104.232.228.81])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 45ft3wsjgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 21:54:10 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (unknown [10.62.176.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol2.lenovo.com (Postfix) with ESMTPS id 4ZJ2Xp2fh4zYkjdZ;
	Wed, 19 Mar 2025 21:54:02 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4ZJ2Xw3l7Kz2Vb0J;
	Wed, 19 Mar 2025 21:54:08 +0000 (UTC)
Date: Wed, 19 Mar 2025 16:54:01 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
        Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Langlois <pierre.langlois@arm.com>,
        Quentin Perret <qperret@google.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        x86@kernel.org
Subject: Re: [RFC PATCH v3 00/15] pkeys-based page table hardening
Message-ID: <epnxrdkidbrjyjzapms7dfsvjcc7ewewjue7khbuxhresy5x5n@hyhokacdi2yg>
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
 <a32cjyekuecoowzbitc2xykilvpu6l3jjtityp7x5hw7xbiysp@5l2lptwmqiug>
 <802963a0-32bd-49e8-82b1-34443acdd5ae@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802963a0-32bd-49e8-82b1-34443acdd5ae@arm.com>
X-Proofpoint-GUID: vqSm1QsRZIKgi2FI0zeUgLsG05nlBYk2
X-Proofpoint-ORIG-GUID: vqSm1QsRZIKgi2FI0zeUgLsG05nlBYk2
X-Authority-Analysis: v=2.4 cv=Au/u3P9P c=1 sm=1 tr=0 ts=67db3d02 cx=c_pps a=Bzw+04pMMuzJwu0RtP1G/Q==:117 a=Bzw+04pMMuzJwu0RtP1G/Q==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=nui44s38u5IZM_FvZ2YA:9
 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190147

On Thu, Mar 13, 2025 at 01:32:31PM +0100, Kevin Brodsky wrote:
> On 06/03/2025 17:23, Maxwell Bland wrote:
> > On Mon, Feb 03, 2025 at 10:18:24AM +0000, Kevin Brodsky wrote:
> > I wanted to know your thoughts on associating specific policies to
> > page table updates in cases where an adversary is able to corrupt
> > other state associated with parameters to the page table infrastructure
> > code, e.g.
> >
> > arch/arm64/net/bpf_jit_comp.c
> > 2417:		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target),
> >
> > Is this something we would assume is handled via the security_* hook
> > infrastructure, a shadow stack CFI method, or changing the kernel code
> > to reverify the data non-modularly, some combination of the above?
> 
> This is a good question and the short answer is that I don't know what
> the best approach would be. As far as kpkeys are concerned, I'm not sure
> they can really help here - it seems to be about the integrity of a
> generated BPF program, and surely that program is already made read-only
> once generated?

Apologies for the slight (5ish) day delay in response here!

Regarding the above discussion of attacks on the context wrapping calls
to the PT infrastructure, I will share the approach I took below, though
it is not super fun, and I don't have all the code publicly available
(yet!).

Before that, another quick example to show it is not just BPF:

There are PT update calls inside EROFS, commonly used in mobile devices
to save on memory. One of the issues I've run into during pagetable
lockdown is

https://github.com/torvalds/linux/blob/81e4f8d68c66da301bb881862735bd74c6241a19/fs/erofs/internal.h#L414

MotoChopper-style attacks could be accomplished through corruption of
the z_erofs_pcluster allocated via SLAB, since erofs has that series of
pointers for compressed_bvecs, which is parsed out into the
compressed_pages used by the EROFS backend to map ram. 

Onto the solution. In a pure-immutability approach, I ended up creating
some definitions regarding what an "expected" virtual-to-physical
mapping of kernel memory or change in page permissions is (my solution
was to treat init_mm as a ground truth structure which is only RW under
a more refined set of constraints on mapping updates and permission set
updates), for example,

if (get_tag(cur_pte & EL1_PADDR_MASK) == SECCOMP_PAGE) {
// run BPF re-verifier to avoid the Qualys 2021 CVE PoC magic

or forcing PXN for everything always unless some other check says we
absolutely have to make this PX:

if (!cur_pte && new_pte) {
  if (!(new_pte & pxn_bit)) {
    new_pte |= pxn_bit; 

And then a bunch of additional infrastructure to define what a "safe
mapping of physical memory looks like", which introduces its own set of
problems for defining how/where vmalloc allocates from, physical address
layout randomization, ...

Such an explication of the expected possible modifications to PTEs may
be needed? I don't understand whether just adding guard() around set_pte
helps this case.

> Could you elaborate on this point? Are you referring to protecting
> arbitrary data structures with kpkeys, rather than what this series
> covers (i.e. pgtables)?

Correct.

> > Where overwriting f_op is a "classic" bypass of protection systems like
> > this one.
> 
> Indeed, this has been pointed out to me on a few occasions. On that note
> I should reference the follow-up series that aims at protecting struct
> cred [1].
> 
> Using kpkeys to ensure that the task->cred pointer itself is mostly
> read-only is not straightforward, because there is just too much
> existing code that directly writes to other fields in task_struct -
> meaning we can't simply make the whole task_struct mostly read-only.
> What could be done is to split out the cred fields in a separate
> kpkeys-protected page, and link that page from task_struct. There is a
> clear overhead associated with this approach though, and maybe more
> importantly we have just displaced the issue as the pointer to that
> protected page remains writeable... I'm not sure how much a page-based
> technique like pkeys can help here.

__randomize_layout accomplished some of what is necessary here, while
accommodating contemporary hardware limitations, albeit to a finer
granularity and lesser degree. I am also not sure how well it works on
production systems (yet! It is on my TODO list in the short term), or
how much protection it really implies for an adversary with a "read
gadget" that can determine where to write (either from associated asm or
from the struct itself).

But...

(1) After thinking about this for a few hours, __randomize_layout implies
something valuable: under circumstances where this is supported, because
we assume the struct's layout itself is modifable, it becomes possible
to introduce a canary value _not_ for the modifiable portions, but just
for the non-modifiable portions, store this canary value in a strictly
read-only region of memory that also tracks pointers to the structure,
and ensure uses of the non-modifiable fields must always leverage the
canary value stored in this secondary region.

Also...

(2) Maybe the supposition that we'd not be able to go through each of
the ~300 memcpy and all the other copy operations throughout the kernel
to add an additional step which prevents a stale reference to a pointer
to a modifable part is not totally crazy, just a little crazy.

> 
> [1]
> https://lore.kernel.org/linux-hardening/20250203102809.1223255-1-kevin.brodsky@arm.com/
> 
> > I think this problem may be totally solvable if POE was integrated into
> > something like CFI, since we can guarantee only the code that sets f_op
> > to "vmfile_fops" can unlock/relock the file's page.
> 
> I'm interested to hear more about this - I don't think I'm aware of the
> CFI instrumentation you're referring to.

It may be possible to write a plugin modification to

https://github.com/gcc-mirror/gcc/blob/12b2c414b6d0e0d1b3d328b58d654c19c30bee8c/gcc/config/arm/aarch-bti-insert.cc

To also inject the POE/register set instructions conditioned upon the an
expected privilege (kpkeys) level of the executing function.

Instead of adding code to set the privilege state via a specialized
callgate function, having this function's call explicitly tied into the
GCC CFI instrumentation pass. Determination of the specific "key level",
i.e. KPKEYS_LVL_PGTABLES, could likely be determined by the file
name/path via the compiler, or many other clever mechanisms, potentially
with support for exceptions via function attribute tags.

Note this implies still correctly accounting for the key level during
allocation, which could be retrieved from the POE level register.

> >>
> >> Any comment or feedback will be highly appreciated, be it on the
> >> high-level approach or implementation choices!
> > Last note, I'd not totallllyyy trust the compiler to inline the
> > functions.... I've met cases where functions on memory protections
> > I expected to be inlined were not. I think __forceinline *may* work
> > here, vs standard "static inline", but am not confident/sure.
> 
> That's a fair point, __always_inline could be used to make sure
> set_pkey/restore_pkey_reg (and the helpers they call) are actually
> inlined. I'll change that in v4. The guard object constructor/destructor
> are defined as regular inline functions in <linux/cleanup.h> though, so
> the inlining might not be complete.

Noticed as well, just now, the reliance on the static_key for branch
unlikely ... the following data structure (at the end of this email) may
be of interest as an FYI ... it can be used to track whether the kernel
self patching API is only being used to patch expected locations.

I use this right now with additional checks that the instruction being
written for the indirect branch matches the expected offset.

Cheers,
Maxwell


/* SPDX-License-Identifier: GPL-2.0 */
/**
 * Copyright (C) 2023 Motorola Mobility, Inc.
 *
 * Author: Maxwell Bland
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * Bitwise trie data structure for storing jump label code addresses.
 * To perform a lookup, we iterate over the bits of the jump_label from MSB to
 * LSB, and use the bit as a tree traversal.
 *
 * Ideally we would just store this in the hypervisor, but we don't have enough
 * memory.  At the time of writing there are 56404 jump labels in the kernel,
 * and the hypervisor is restricted to a memory footprint of 32 KB.
 *
 * So instead what we do is allocate this data structure in the kernel module,
 * and then lock it down. Finally, we pass the pointer to the hypervisor, which
 * can then perform lookups whenever a DABT exception occurs.
 *
 * We choose not to use the kernel's radix tree for this because it is less
 * space efficient and much slower, and jump_label operations relate to
 * performance sensitive code (e.g. the networking stack).
 */

#ifndef JUMP_TABLE_LOOKUP_H
#define JUMP_TABLE_LOOKUP_H

#include <linux/of_address.h>

/* Used to determine the branch direction */
#define JUMP_TREE_BRANCH(x) ((x >> ((sizeof(x) * 8) - 1)) & 1)

union jump_tree_node {
	uint32_t je_index[2];
	uint64_t je_val;
};

static union jump_tree_node *jet; /* Start of jump table lookup */
static uint64_t jet_ind; /* Current index of jump table lookup */
static union jump_tree_node *jet_end; /* End of jump table lookup */

void init_jtn(union jump_tree_node *jtn)
{
	jtn->je_val = 0;
}

/**
 * jet_extend - extends the jump entry lookup table
 *
 * Scales up the size of the jump entry lookup table by 2 just in case our
 * initial estimate was too small. Ensures that the new size is a multiple of
 * PAGE_SIZE.
 */
void jet_extend(void)
{
	uint64_t jet_sz = jet_end - jet;
	uint64_t new_sz = jet_sz * 2;
	union jump_tree_node *new_jet;

	if (new_sz % PAGE_SIZE)
		new_sz += PAGE_SIZE - (new_sz % PAGE_SIZE);

	if (jet_ind + 1 >= jet_sz) {
		new_jet = kvmalloc(new_sz * sizeof(union jump_tree_node),
				   GFP_KERNEL);
		memcpy(new_jet, jet, jet_sz * sizeof(union jump_tree_node));
		jet_end = new_jet + new_sz;
		kvfree(jet);
		jet = new_jet;
	}

	init_jtn(jet + jet_ind);
}

/**
 * add_branch - adds a branch to the jump entry lookup tree
 *
 * Adds a branch to the current node corresponding to whether the LSB of the
 * cur_code_ptr is 1 or 0. The branch target is the index of the next node in
 * the tree or a leaf (jump entry)
 */
int add_branch(unsigned long *cur_code_ptr, union jump_tree_node *cur_node,
	       uint64_t branch_target)
{
	bool bit;

	if (!cur_code_ptr || !cur_node)
		return -EACCES;

	bit = JUMP_TREE_BRANCH(*cur_code_ptr);
	*cur_code_ptr <<= 1;

	if (bit)
		cur_node->je_index[0] = branch_target;
	else
		cur_node->je_index[1] = branch_target;

	return 0;
}

/**
 * add_trunk - adds a path of branches to the jump entry lookup tree
 *
 * Adds the series of branches to the jump entry lookup tree corresponding to
 * the bits in the cur_code_ptr value starting at LSB index i, and adds the leaf
 * node at the end.
 */
int add_trunk(union jump_tree_node *cur_node, struct jump_entry *je,
	      unsigned long cur_code_ptr, int i)
{
	if (!cur_node || !je)
		return -EACCES;

	for (; i < sizeof(cur_code_ptr) * 8; i++) {
		if (add_branch(&cur_code_ptr, cur_node, jet_ind))
			return -EACCES;
		jet_extend();
		cur_node = jet + jet_ind;
		jet_ind++;
	}

	/*
	 * GKI rips aarch64_insn_gen_branch_imm out for the illusion of security
	 * while leaving jump_labels as a whole intact, this is a partial
	 * duplicate of that function
	 */
	cur_node->je_val = (jump_entry_target(je) - jump_entry_code(je)) >> 2;

	return 0;
}

/**
 * jet_alloc - allocates a new jump entry tree for lookups
 * @jet_end_out: output parameter for the size of the jump entry tree (bytes)
 *
 * Allocates the jump entry tree with 2x the number of jump entries in the
 * kernel. This is because we need to store both the jump entry and, in the
 * worst case, a pointer to the next index in the tree. Ensures the total memory
 * allocated is a multiple of PAGE_SIZE, uses kvmalloc (the memory is
 * non-contiguous)
 *
 * Return: 0 on failure, or the pointer to the allocated jump entry tree
 */
uint64_t jet_alloc(struct jump_entry *je_start, struct jump_entry *je_end,
		   uint64_t *jet_size_out)
{
	union jump_tree_node *cur_node;
	unsigned long cur_code_ptr = -1;
	bool bit;
	int i = 0;

	if (!je_start || !je_end || !jet_size_out) {
		pr_err("%s fail: invalid parameters\n", __func__);
		return 0;
	}

	if (je_start >= je_end) {
		pr_err("%s fail: je_start >= je_end\n", __func__);
		return 0;
	}

	jet = kvmalloc(2 * (je_end - je_start) * sizeof(union jump_tree_node),
		       GFP_KERNEL);
	jet_ind = 1;
	jet_end = jet + 2 * (je_end - je_start);
	init_jtn(jet);
	init_jtn(jet + 1);

	while (je_start != je_end) {
		cur_code_ptr = __virt_to_phys(jump_entry_code(je_start));
		cur_node = jet;

		// iterate over the bits of the jump label
		for (i = 0; i < sizeof(cur_code_ptr) * 8; i++) {
			bit = JUMP_TREE_BRANCH(cur_code_ptr);

			if (bit) {
				if (cur_node->je_index[0]) {
					cur_node = jet + cur_node->je_index[0];
				} else {
					if (add_trunk(cur_node, je_start,
						      cur_code_ptr, i))
						return 0;
					break;
				}
			} else {
				if (cur_node->je_index[1]) {
					cur_node = jet + cur_node->je_index[1];
				} else {
					if (add_trunk(cur_node, je_start,
						      cur_code_ptr, i))
						return 0;
					break;
				}
			}

			cur_code_ptr <<= 1;
		}

		je_start++;
	}

	*jet_size_out = jet_end - jet;
	return (uint64_t)jet;
}

#endif

