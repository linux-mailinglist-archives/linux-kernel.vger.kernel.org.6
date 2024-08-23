Return-Path: <linux-kernel+bounces-298730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901B95CAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087171F26E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CCD156C69;
	Fri, 23 Aug 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZ9VvgS+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F92187336
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409908; cv=none; b=Ci+VMCSXqZFtgrE+fzVlAQNmY1J1uPD3Lh30A3U4PjLe1u09sFvQZjN6y9t/aw37norxvShZMzumt4aykctc+WHt3JXdoDY1jt9U2uabDjxB5efgniDIqSAH4E4DNof0ZTLku/m1+1K7Azwf24Ix6UrPLSt6/5VkRoqpGT2zSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409908; c=relaxed/simple;
	bh=mY7WG1BpnmaYL8oGHoYsvPIyFann+pzTX5NMGm/xcIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIE4x0pM/fgj7g7EWmfK+gD1+gMa2PfLwzlT3zb4mXZkdnPTLwylw54GIy7xvfJHCWNR0sfW3TPC7vP4XI0WiTdiCcqbtz2RJt5cig87jX+HS1jKgiYkLBPgqVpA3nlVawl+2BD7CmI7oRUp3m0hQewGpQiZWRPny7ir4whw4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZ9VvgS+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427fc9834deso63765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724409905; x=1725014705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dM4LwHl+OTfLAzGqAwV8fBwSI5CJb/Eqh34hFcM3170=;
        b=tZ9VvgS+9EnRWeSd+8rNJddVPcEYC994CcZ1RBCMTEjsIfMPoOc5Co5tS79cG/FHl2
         o/g7D2FqkCt016BHxSD0J18vqJZfX4H56RODAIaoYoAFw9wgy2twTibDdSNtg+rmhOq5
         OZPCfTPCGxrf0306sUD3dEwo+zxqK1vVJ3Arb1fQ9unJFpbdIoY0vemG01ss0hppmGSV
         a/bllHjw+I2ShtgPIK3X6qw2Muc+I+c3lxwWJmKT5R9JYIfAoJ5nKgwu/eHPjpzcKCbj
         KLlwBDL1X6Imv9taLOWWg8pxDVWUBTNvRe+auP13w1FVpyzxN9OH6M7Om2T/gGEbxLRk
         RNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409905; x=1725014705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM4LwHl+OTfLAzGqAwV8fBwSI5CJb/Eqh34hFcM3170=;
        b=BRnH6+3JhVelOkLpNO2sjdMxmCZoONtXU0orMsj3S0nGRKMoIOG/FX8aZVaBO/hUar
         +ufWCVkvKWXW9BA8wRbVDrdKnadr1bNEuwDbBpt8hHBjyLe0QpMBc8H4Jd5Lc1lvp0wh
         +1MRn2SzuRed8Ck5P89nmvaK1Au0c6Pc3Z9G3vGvRTpYrLMc+O4D1zWepkZ/U0Uf/C6E
         BnZp3DBrpTxWQZ43doeQQ7P8HrSMISCWz7pk4ItH/WC7Y2oc+r7kvd4wPxxCp8kvdNjQ
         R1Pfv3hsGoaBa4GzW+YidifPK5wY9TAwar0Z2YBPDGscxh6h80bj06PbaGFJp3DON4Ae
         pQPg==
X-Forwarded-Encrypted: i=1; AJvYcCU/XrMi1P2B7ZEWFUGktma5fdAatxgC043I6z3YAn8Ds7+qMDNrdzI24TLTbq/UD7LQrwTzFTCFTOezOW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KZzr3wiDkgN90O13g5CHr6vlyx7tfg6po9C6wXy+EeIPdf8y
	V0a53qp8ngjsQ5p3dnq9wbC2NOoWuJ/544vjZsygz58GRELL0ajm1liGu2mISg==
X-Google-Smtp-Source: AGHT+IGCq/lP92Pn/y/bVzPCgVO2MjtdDpM7iwE1zQYcrndOus0Lqjotk/0CReJDBM3G1Xwqzynk+Q==
X-Received: by 2002:a05:600c:1da7:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-42acc3a072dmr1145875e9.4.1724409904466;
        Fri, 23 Aug 2024 03:45:04 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308265ae6sm3828084f8f.109.2024.08.23.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:45:03 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:45:02 +0000
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
Message-ID: <ZshoLrEseHJZvyE_@google.com>
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

Hello Marc,

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

I will drop this.

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

Let me fix the formatting and add the other depends on rules.

> 
> More importantly, I find it very strange to expose the configuration
> option so early in the series, while the support code isn't there yet.
> You can perfectly introduce code that is conditional on a config
> option and only add it at the end.

I will move the configuration option as a separate patch in the last
part of the series.

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

Right, I think there are a few patches that should be squashed to
prevent this "empty" functionality.

Thanks for the feedback,
Seb


> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

