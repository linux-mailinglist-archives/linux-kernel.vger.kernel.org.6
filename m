Return-Path: <linux-kernel+bounces-308581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31410965F18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C041F26C84
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167B18FC81;
	Fri, 30 Aug 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ir8amQfI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA266190693
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013502; cv=none; b=Ha9GC/SbQ/Azre1xuRXddoLcTsxmAaQCalIjiUmmE+3dNVuu1i0r85/v8JKlWPA6RhXoCTeAT1GFehGZI4YZaROvSwJVbNwvD538RWWZYa/PfgfhROPdzaFBYS6hJnoLc9Aqz8ENje0ebhvhclkUjzKieLF9juTQX2agr3mGm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013502; c=relaxed/simple;
	bh=rETcN2jR45wVHbgxCc/thY5C1K0ssw72XbE4bEwskT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2rxVdlj4PA06P1OpgXB9WBY0XsnUWtAaF5aHX+WbotX0KVxMdP6FqRnwJ1MFNHNzUQ+Lr5WNc5s1aotiszxxCO++f7hMT42tTRI21+P+GPTQlfANAy3B97ZherWWejhIBSkGSvGpuzosWRRSNOBRrTAkx7EgNvD1LELPyKTVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ir8amQfI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b25263a3so198779f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725013499; x=1725618299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH1qUElNPeIs+ypi1Pa44gEF4kTEfMQl8bg8LHqcYoQ=;
        b=ir8amQfIQbI1xVXJLYDDDosDUx75E3K13Ix8EzNzx7BN0fYspdImm9xM2g/7t0OZGR
         2KEo4RfUiyKlIw20XObZ/ZZnTgs9e3qx+Y+3M+UYZjehIuwNdiNKxCgInQ7ZxDKuiexl
         fzeGPASgnDZCbGwRxZ5ufToSPFzcVXNyhD7RCu4U1N839xmDE1I6N74YsZoocugVbedy
         YbZNV34W8i5RP2dX+CHaAHWnWT26G8trckppnNgtRQCt/nVY9brhr+I654b9NtbtX6BD
         mZfZG7hY6tsWaCTYFjPLKideLidaRnG7hcehha5tAQB/WEQKPFBx3k/4mOrUm498+y4W
         aYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013499; x=1725618299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH1qUElNPeIs+ypi1Pa44gEF4kTEfMQl8bg8LHqcYoQ=;
        b=leSJspN5G/Xe6SkG24QZdTyH0CsCj8HYkIzRPkLEI+WgYdkMSfQ2Omxqk9VLINtuQK
         QYr/vneTe31poLbPoddVpEbacWXiIiwM5+3WPPYRaSEPhWfJHfbsWIs9i08Uju02ASBi
         yFZeO1yddueIwVuYLhBYbjMG305Mna1unNxPeqVi2UrzuD22B1ZePF7drEDa6JmKEAWC
         98psCgpxYd9ZuJmJC7xT8jdHNC/KXudcOnkoO00ByscrCEsgWwxkgbfHaSe+leZYRf8Y
         /bE/ZNiiTPXy7eZWFiYcCHh1sWLUnd+fR5G9BtxDKDSYSnOgICDcXIGp16p6Kj5Wknx8
         NeWg==
X-Forwarded-Encrypted: i=1; AJvYcCVfUzUB7yRoJ0S7wzY883YTyDDwVgeMSIb7cke8VJRbTMfGOdm2zPDXpw/c2yiS4ebANsqyeZrXU17S7Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWg5dA+I9W7sXcFhp9+odJQLyAZoDCZWlm/p/ruuBk+aiTr+0
	pW4U6TjkFv/MW+BtOCrmNGkQfIAtQk9Pi6GSa1pgERQ6DGirfKsQuD7PLAoNMA==
X-Google-Smtp-Source: AGHT+IGwxGU32w3lwDHtf90T5zi9X+mb1V/P3deq77Cg5QRsJKyTkZbGGWPX7yrzUN1+E7lZ0zMrXg==
X-Received: by 2002:a5d:5c87:0:b0:374:b683:266 with SMTP id ffacd0b85a97d-374b683056cmr412034f8f.24.1725013498501;
        Fri, 30 Aug 2024 03:24:58 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e933sm3597707f8f.87.2024.08.30.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:24:57 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:24:53 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 4/5] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZtGd9UEudn8Z0IlG@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <20240827084549.45731-5-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827084549.45731-5-sebastianene@google.com>

Hi Seb,

Thanks for the respin.

On Tue, Aug 27, 2024 at 08:45:47AM +0000, Sebastian Ene wrote:
> While arch/*/mem/ptdump handles the kernel pagetable dumping code,
> introduce KVM/ptdump to show the guest stage-2 pagetables. The
> separation is necessary because most of the definitions from the
> stage-2 pagetable reside in the KVM path and we will be invoking
> functionality specific to KVM.
> 
> When a guest is created, register a new file entry under the guest
> debugfs dir which allows userspace to show the contents of the guest
> stage-2 pagetables when accessed.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

I only have some nits, otherwise:

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/include/asm/kvm_host.h |   6 +
>  arch/arm64/kvm/Makefile           |   1 +
>  arch/arm64/kvm/arm.c              |   1 +
>  arch/arm64/kvm/ptdump.c           | 247 ++++++++++++++++++++++++++++++
>  4 files changed, 255 insertions(+)
>  create mode 100644 arch/arm64/kvm/ptdump.c
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index a33f5996ca9f..4acd589f086b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1473,4 +1473,10 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
>  		(pa + pi + pa3) == 1;					\
>  	})
>  
> +#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
> +void kvm_s2_ptdump_create_debugfs(struct kvm *kvm);
> +#else
> +static inline void kvm_s2_ptdump_create_debugfs(struct kvm *kvm) {}
> +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> +
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 86a629aaf0a1..e4233b323a73 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -27,6 +27,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>  
>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
>  kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
> +kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>  
>  always-y := hyp_constants.h hyp-constants.s
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9bef7638342e..b9fd928d3477 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -228,6 +228,7 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
>  void kvm_arch_create_vm_debugfs(struct kvm *kvm)
>  {
>  	kvm_sys_regs_create_debugfs(kvm);
> +	kvm_s2_ptdump_create_debugfs(kvm);
>  }
>  
>  static void kvm_destroy_mpidr_data(struct kvm *kvm)
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> new file mode 100644
> index 000000000000..e72a928d4445
> --- /dev/null
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Debug helper used to dump the stage-2 pagetables of the system and their
> + * associated permissions.
> + *
> + * Copyright (C) Google, 2024
> + * Author: Sebastian Ene <sebastianene@google.com>
> + */
> +#include <linux/debugfs.h>
> +#include <linux/kvm_host.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/kvm_pgtable.h>
> +#include <asm/kvm_host.h>

nit: I believe you wanted to follow the alphabetical order, if that is the case,
kvm_host.h then kvm_pgtable.h

> +#include <asm/ptdump.h>
> +
> +

nit: don't think double empty are a rule, I would remove it.

> +#define MARKERS_LEN		(2)

nit: The brackets are not necessary for MARKERS_LEN.

> +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> +
> +struct kvm_ptdump_guest_state {
> +	struct kvm		*kvm;
> +	struct ptdump_pg_state	parser_state;
> +	struct addr_marker	ipa_marker[MARKERS_LEN];
> +	struct ptdump_pg_level	level[KVM_PGTABLE_MAX_LEVELS];
> +	struct ptdump_range	range[MARKERS_LEN];
> +};
> +
> +static const struct ptdump_prot_bits stage2_pte_bits[] = {
> +	{
> +		.mask	= PTE_VALID,
> +		.val	= PTE_VALID,
> +		.set	= " ",
> +		.clear	= "F",

This is effectively never used because an invalid PTE is 0 and note_page() won't
print it. This probably can be removed?

> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> +		.set	= "R",
> +		.clear	= " ",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> +		.set	= "W",
> +		.clear	= " ",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> +		.val	= PTE_VALID,
> +		.set	= " ",
> +		.clear	= "X",
> +	}, {
> +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> +		.set	= "AF",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_TABLE_BIT | PTE_VALID,
> +		.val	= PTE_VALID,
> +		.set	= "BLK",
> +		.clear	= "   ",
> +	},
> +};
> +
> +static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> +			      enum kvm_pgtable_walk_flags visit)
> +{
> +	struct ptdump_pg_state *st = ctx->arg;
> +	struct ptdump_state *pt_st = &st->ptdump;
> +
> +	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
> +
> +	return 0;
> +}
> +
> +static int kvm_ptdump_build_levels(struct ptdump_pg_level *level, u32 start_lvl)
> +{
> +	u32 i;
> +	u64 mask;
> +
> +	if (WARN_ON_ONCE(start_lvl >= KVM_PGTABLE_LAST_LEVEL))
> +		return -EINVAL;
> +
> +	mask = 0;
> +	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
> +		mask |= stage2_pte_bits[i].mask;
> +
> +	for (i = start_lvl; i < KVM_PGTABLE_MAX_LEVELS; i++) {
> +		snprintf(level[i].name, sizeof(level[i].name), "%d", i);

%u, i being unsigned.

> +
> +		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
> +		level[i].bits	= stage2_pte_bits;
> +		level[i].mask	= mask;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct kvm_ptdump_guest_state *kvm_ptdump_parser_create(struct kvm *kvm)
> +{
> +	struct kvm_ptdump_guest_state *st;
> +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> +	struct kvm_pgtable *pgtable = mmu->pgt;
> +	int ret;
> +
> +	st = kzalloc(sizeof(struct kvm_ptdump_guest_state), GFP_KERNEL_ACCOUNT);
> +	if (!st)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
> +	if (ret) {
> +		kfree(st);
> +		return ERR_PTR(ret);
> +	}
> +
> +	st->ipa_marker[0].name		= "Guest IPA";
> +	st->ipa_marker[1].start_address = BIT(pgtable->ia_bits);
> +	st->range[0].end		= BIT(pgtable->ia_bits);
> +
> +	st->kvm				= kvm;
> +	st->parser_state = (struct ptdump_pg_state) {
> +		.marker		= &st->ipa_marker[0],
> +		.level		= -1,
> +		.pg_level	= &st->level[0],
> +		.ptdump.range	= &st->range[0],
> +		.start_address	= 0,
> +	};
> +
> +	return st;
> +}
> +
> +static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
> +{
> +	int ret;
> +	struct kvm_ptdump_guest_state *st = m->private;
> +	struct kvm *kvm = st->kvm;
> +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> +	struct ptdump_pg_state *parser_state = &st->parser_state;
> +	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
> +		.cb	= kvm_ptdump_visitor,
> +		.arg	= parser_state,
> +		.flags	= KVM_PGTABLE_WALK_LEAF,
> +	};
> +
> +	parser_state->seq = m;
> +
> +	write_lock(&kvm->mmu_lock);
> +	ret = kvm_pgtable_walk(mmu->pgt, 0, BIT(mmu->pgt->ia_bits), &walker);
> +	write_unlock(&kvm->mmu_lock);
> +
> +	return ret;
> +}
> +
> +static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +	struct kvm_ptdump_guest_state *st;
> +	int ret;
> +
> +	if (!kvm_get_kvm_safe(kvm))
> +		return -ENOENT;
> +
> +	st = kvm_ptdump_parser_create(kvm);
> +	if (IS_ERR(st)) {
> +		ret = PTR_ERR(st);
> +		goto free_with_kvm_ref;
> +	}
> +
> +	ret = single_open(file, kvm_ptdump_guest_show, st);
> +	if (!ret)
> +		return 0;
> +
> +	kfree(st);
> +free_with_kvm_ref:

nit: I believe kfree understands IS_ERR() so you could have a simple "err:"
label covering all the error path.

> +	kvm_put_kvm(kvm);
> +	return ret;
> +}
> +
> +static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +	void *st = ((struct seq_file *)file->private_data)->private;
> +
> +	kfree(st);
> +	kvm_put_kvm(kvm);
> +
> +	return single_release(m, file);
> +}
> +
> +static const struct file_operations kvm_ptdump_guest_fops = {
> +	.open		= kvm_ptdump_guest_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= kvm_ptdump_guest_close,
> +};
> +
> +static int kvm_pgtable_debugfs_show(struct seq_file *m, void *unused)
> +{
> +	const struct file *file = m->file;
> +	struct kvm_pgtable *pgtable = m->private;
> +
> +	if (!strcmp(file_dentry(file)->d_iname, "ipa_range"))
> +		seq_printf(m, "%2u\n", pgtable->ia_bits);
> +	else if (!strcmp(file_dentry(file)->d_iname, "stage2_levels"))
> +		seq_printf(m, "%1d\n", KVM_PGTABLE_LAST_LEVEL - pgtable->start_level + 1);

nit: KVM_PGTABLE_MAX_LEVELS - pgtable->start_level ?

> +	return 0;
> +}
> +
> +static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +	struct kvm_pgtable *pgtable;
> +	int ret;
> +
> +	if (!kvm_get_kvm_safe(kvm))
> +		return -ENOENT;
> +
> +	pgtable = kvm->arch.mmu.pgt;
> +
> +	ret = single_open(file, kvm_pgtable_debugfs_show, pgtable);
> +	if (ret < 0)
> +		kvm_put_kvm(kvm);
> +	return ret;
> +}
> +
> +static int kvm_pgtable_debugfs_close(struct inode *m, struct file *file)
> +{
> +	struct kvm *kvm = m->i_private;
> +
> +	kvm_put_kvm(kvm);
> +	return single_release(m, file);
> +}
> +
> +static const struct file_operations kvm_pgtable_debugfs_fops = {
> +	.open		= kvm_pgtable_debugfs_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= kvm_pgtable_debugfs_close,
> +};
> +
> +void kvm_s2_ptdump_create_debugfs(struct kvm *kvm)
> +{
> +	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
> +			    kvm, &kvm_ptdump_guest_fops);
> +	debugfs_create_file("ipa_range", 0400, kvm->debugfs_dentry, kvm,
> +			    &kvm_pgtable_debugfs_fops);
> +	debugfs_create_file("stage2_levels", 0400, kvm->debugfs_dentry,
> +			    kvm, &kvm_pgtable_debugfs_fops);
> +}
> -- 
> 2.46.0.295.g3b9ea8a38a-goog
> 

