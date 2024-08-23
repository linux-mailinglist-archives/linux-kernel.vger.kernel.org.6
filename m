Return-Path: <linux-kernel+bounces-298748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22395CB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4457C1F21DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64837144;
	Fri, 23 Aug 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVxIjiMc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442718733D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410421; cv=none; b=OJhWNr7LNhWEh0jisdj2SWnJYNreBM4pDfhzQ5Tgct2HFQVUxUrJ69AhtwlZbf+Ctbe7u0V4ID4U3d3O7B3MuKt1kWGnalwEchOXBe5+jtqlEe9YZov9YrFzN8PgkrFQVjQKuqWS7WqlS7AtPU/sNwpqUy1i1ZuVMwAwDZann6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410421; c=relaxed/simple;
	bh=14eI9wbxnFWRE77Aw9u75ObMAFW9V9XQKX7ZYi2n93o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Z4p23zRaumqResviAzgQouvlNQmH66ixpgJippkySGGHxMGxA57lqgbSlO+AS4S8uRcvpx7kFDVbDAhHXjsMP2kAnjKrUFSwng6M/YuroLdBwcXAmzsPcjWbkhXn39D/Q41hQDmUs1A3VH+H2JA/KAlchdrdIGmClHhxCGhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVxIjiMc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c07fb195b6so8024a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724410418; x=1725015218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97kJncKaau0XUtGqu9KlbMlq17Xy5W14fLjy+xayMp8=;
        b=OVxIjiMcHb6Uf6BPakQZUnzZDDN9afLZuU1fzrsknSOp/LBPuyfCZFoUwm02lrk3Ni
         yH4c8yoZJbPXGpvfSfzhbASbE9vMnI3Jzt1EMYbP8p64h5d1Tt6mb/yqG+dvQJnlQizO
         tP3dh0EHVzeckqRjzTe3wRCyoNhA9f1hI7pqZIXDObh85OLbtLsWd+hXNDM2p+Sa3EM0
         HGkSzDPbTu8S+vBT/UjaohiwKewHIO+pdCbJnyUnW05kmkEO88E7L+M1fLaD6ThOn7hx
         fNWW3GzH2ymWDRVLceqYa549OhUvFsgcDNe4Y2SlZew44rvPLgw4k7M3plul2GhP9AVJ
         gqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410418; x=1725015218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97kJncKaau0XUtGqu9KlbMlq17Xy5W14fLjy+xayMp8=;
        b=dGshOuyxAYgP2Pu9IIBuvNRkN8TzrTOXibgJi6fCFs0mboQTJ7cdafHgX2j1gxENoE
         zojfOr+TjT0pHK2NfH0Qt5OV6spQTr+Qzr0FVi+zZ4SWcOOi2q5/9JVtsI4zNe7JcFtb
         omwKJDbGa4enecp8N4nHz1g4YbtfKvRlrfcag2X+nIYGqJvvP8BSJk3TDSjmYPOh6faY
         T80/WMJtMvYNXcgbT3yNcW2DmYo29XChI3hCOm/jSi9LGJiwjS+KVrzFOwxHNiEP0hwC
         34QiDzpRPCPVv0KJDO9GY2KwYKGowoel1ZeItxpgKybpU+BuU7Ib6K0hggTyG0NdVNeJ
         ha8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkXTVXxf/yv+VYuCao22gffEoaqxYLtKk69ouObSHuDZEfizEXn9lkrWlEYhO29qUc6xU1e8dqLEld3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NTiKKvKlPv+bxtAY7hDLkdLFrlIsJIVjVE/nvaWCdb/uUsxG
	xAqhwqE11E4eYmn6qpEWHpKBm5qFHycgWjgZ4bfFnWo4R57h2oR4z6KdUovRTw==
X-Google-Smtp-Source: AGHT+IFG5GPViFVRlRs7iRjC5gsUhcjRYi1WRKI4026Wk+Av5lQ341JA3hRRqV2uWIfCqwSh25olAA==
X-Received: by 2002:a05:6402:3493:b0:58b:90c6:c59e with SMTP id 4fb4d7f45d1cf-5c088db8927mr94562a12.7.1724410417331;
        Fri, 23 Aug 2024 03:53:37 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm3851203f8f.75.2024.08.23.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:53:36 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:53:35 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 4/6] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZshqL23kf1GokHWt@google.com>
References: <20240816123906.3683425-1-sebastianene@google.com>
 <20240816123906.3683425-5-sebastianene@google.com>
 <86r0ajxp8q.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r0ajxp8q.wl-maz@kernel.org>

On Tue, Aug 20, 2024 at 03:06:45PM +0100, Marc Zyngier wrote:
> On Fri, 16 Aug 2024 13:39:04 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > While arch/*/mem/ptdump handles the kernel pagetable dumping code,
> > introduce KVM/ptdump which shows the guest stage-2 pagetables. The
> > separation is necessary because most of the definitions from the
> > stage-2 pagetable reside in the KVM path and we will be invoking
> > functionality **specific** to KVM.
> 
> Drop the ** emphasis.
> 
> > 
> > When a guest is created, register a new file entry under the guest
> > debugfs dir which allows userspace to show the contents of the guest
> > stage-2 pagetables when accessed.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/Kconfig      | 14 ++++++
> >  arch/arm64/kvm/Makefile     |  1 +
> >  arch/arm64/kvm/arm.c        |  2 +
> >  arch/arm64/kvm/kvm_ptdump.h | 20 ++++++++
> >  arch/arm64/kvm/ptdump.c     | 91 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 128 insertions(+)
> >  create mode 100644 arch/arm64/kvm/kvm_ptdump.h
> >  create mode 100644 arch/arm64/kvm/ptdump.c
> > 
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 8304eb342be9..fcc41e58ede6 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -66,4 +66,18 @@ config PROTECTED_NVHE_STACKTRACE
> >  
> >  	  If unsure, or not using protected nVHE (pKVM), say N.
> >  
> > +config PTDUMP_STAGE2_DEBUGFS
> > +       bool "Present the stage-2 pagetables to debugfs"
> > +       depends on KVM
> > +       select PTDUMP_CORE
> 
> This looks wrong. Looking at PTDUMP_DEBUGFS, it has the following
> constraints:
> 
>         depends on DEBUG_KERNEL
>         depends on DEBUG_FS
>         depends on GENERIC_PTDUMP
>         select PTDUMP_CORE
> 
> I don't see why the Stage-2 version should have anything different.
> 
> > +       default n
> > +       help
> > +         Say Y here if you want to show the stage-2 kernel pagetables
> > +         layout in a debugfs file. This information is only useful for kernel developers
> > +         who are working in architecture specific areas of the kernel.
> > +         It is probably not a good idea to enable this feature in a production
> > +         kernel.
> 
> nit: try to keep the formatting within 80 columns.
> 
> More importantly, I find it very strange to expose the configuration
> option so early in the series, while the support code isn't there yet.
> You can perfectly introduce code that is conditional on a config
> option and only add it at the end.
> 
> > +
> > +         If in doubt, say N.
> > +
> >  endif # VIRTUALIZATION
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index 86a629aaf0a1..e4233b323a73 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -27,6 +27,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
> >  
> >  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> >  kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
> > +kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
> >  
> >  always-y := hyp_constants.h hyp-constants.s
> >  
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 9bef7638342e..60fed2146763 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -45,6 +45,7 @@
> >  #include <kvm/arm_hypercalls.h>
> >  #include <kvm/arm_pmu.h>
> >  #include <kvm/arm_psci.h>
> > +#include <kvm_ptdump.h>
> >  
> >  static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
> >  
> > @@ -228,6 +229,7 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
> >  void kvm_arch_create_vm_debugfs(struct kvm *kvm)
> >  {
> >  	kvm_sys_regs_create_debugfs(kvm);
> > +	kvm_ptdump_guest_register(kvm);
> 
> Consider using a name that is homogeneous with what we already have
> (kvm_s2_ptdump_create_debugfs?).
> 
> >  }
> >  
> >  static void kvm_destroy_mpidr_data(struct kvm *kvm)
> > diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
> > new file mode 100644
> > index 000000000000..0a62b0e2908c
> > --- /dev/null
> > +++ b/arch/arm64/kvm/kvm_ptdump.h
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) Google, 2024
> > + * Author: Sebastian Ene <sebastianene@google.com>
> > + */
> > +
> > +#ifndef __KVM_PTDUMP_H
> > +#define __KVM_PTDUMP_H
> > +
> > +#include <linux/kvm_host.h>
> > +#include <asm/ptdump.h>
> > +
> > +
> > +#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
> > +void kvm_ptdump_guest_register(struct kvm *kvm);
> > +#else
> > +static inline void kvm_ptdump_guest_register(struct kvm *kvm) {}
> > +#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
> > +
> > +#endif /* __KVM_PTDUMP_H */
> 
> Please don't add new include files that contain so little stuff. These
> things may as well be added either to asm/kvm_host.h or asm/ptdump.h.
> 

I will drop this in this case.

> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > new file mode 100644
> > index 000000000000..52483d56be2e
> > --- /dev/null
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Debug helper used to dump the stage-2 pagetables of the system and their
> > + * associated permissions.
> > + *
> > + * Copyright (C) Google, 2024
> > + * Author: Sebastian Ene <sebastianene@google.com>
> > + */
> > +#include <linux/debugfs.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/seq_file.h>
> > +
> > +#include <asm/kvm_pgtable.h>
> > +#include <kvm_ptdump.h>
> > +
> > +
> > +static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> > +			      enum kvm_pgtable_walk_flags visit)
> > +{
> > +	struct ptdump_pg_state *st = ctx->arg;
> > +	struct ptdump_state *pt_st = &st->ptdump;
> > +
> > +	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
> > +	return 0;
> > +}
> > +
> > +static int kvm_ptdump_show_common(struct seq_file *m,
> 
> What does "common" mean here? You have exactly *one* caller, so why
> isn't that inlined in kvm_ptdump_guest_show()?
> 

Right, this first part of the series adds the support for non-protected
VM which is only one caller. The later one which I haven't sent yet adds
support for protected for both the host and the guest. I will keep it in 
kvm_ptdump_guest_show() for now.


> > +				  struct kvm_pgtable *pgtable,
> > +				  struct ptdump_pg_state *parser_state)
> > +{
> > +	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
> > +		.cb     = kvm_ptdump_visitor,
> > +		.arg	= parser_state,
> > +		.flags	= KVM_PGTABLE_WALK_LEAF,
> > +	};
> > +
> > +	parser_state->level = -1;
> > +	parser_state->start_address = 0;
> > +
> > +	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
> > +}
> > +
> > +static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
> > +{
> > +	struct kvm *kvm = m->private;
> > +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> > +	struct ptdump_pg_state parser_state = {0};
> 
> nit: the common idiom is "parser_state = {}".
> 
> > +	int ret;
> > +
> > +	write_lock(&kvm->mmu_lock);
> > +	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
> > +	write_unlock(&kvm->mmu_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> > +{
> > +	struct kvm *kvm = m->i_private;
> > +	int ret;
> > +
> > +	if (!kvm_get_kvm_safe(kvm))
> > +		return -ENOENT;
> > +
> > +	ret = single_open(file, kvm_ptdump_guest_show, m->i_private);
> > +	if (ret < 0)
> > +		kvm_put_kvm(kvm);
> > +
> > +	return ret;
> > +}
> > +
> > +static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
> > +{
> > +	struct kvm *kvm = m->i_private;
> > +
> > +	kvm_put_kvm(kvm);
> > +	return single_release(m, file);
> > +}
> > +
> > +static const struct file_operations kvm_ptdump_guest_fops = {
> > +	.open		= kvm_ptdump_guest_open,
> > +	.read		= seq_read,
> > +	.llseek		= seq_lseek,
> > +	.release	= kvm_ptdump_guest_close,
> > +};
> > +
> > +void kvm_ptdump_guest_register(struct kvm *kvm)
> > +{
> > +	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
> > +			    kvm, &kvm_ptdump_guest_fops);
> > +}
> > -- 
> > 2.46.0.184.g6999bdac58-goog
> 
> Overall, I have a hard time understanding what this does. It walks the
> page tables, but doesn't do anything useful.
> 
> I have the feeling that this patch would be better squashed together
> with patch #5, since it significantly reworks what patch #4 does.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

