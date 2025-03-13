Return-Path: <linux-kernel+bounces-560221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71540A5FF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719163AD7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1D1EFF83;
	Thu, 13 Mar 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6SaAMsk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488781E7C2B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891167; cv=none; b=GqzM+SYqIBqtD/KDLyyuSA0dw8kepjnssDWhJNcjbamho3bRx+5FPkBFjoAaCJPOJUmzZHVZZmonqn3mFMVYWNvlP7Ps0tUrO706Z+kLYHnffePHkxLfpEUCwlOlAqUxAQvV0hkJaF9BHJ99ii4gf3O5mSwBVvmhjm7eXo7xsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891167; c=relaxed/simple;
	bh=AKYC4Lz7/9yXJmbWMa8sYFGbqaotOq6k6wMB4Br5Nc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay7SZGFCDh0soFrK4Jw1zTDXzRgKhCg/ACnGmClqMRDRhZhmwaCnCyxaOyAymOuLwoc5QM6cw06k3s51VooXk0wILeVIQCVO1s40eV9avuxtO6Wgfnk6d8SaXGsFxaCCqUoXbkmJDJj9+t9on5lmy5UoUt0KKpi6ufrav8G70dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6SaAMsk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIXhFaXlgWKMY6E2E9lOQ4OE0U5BJyhpkmUcGXvVRHM=;
	b=A6SaAMskHGTqEf/Hg6cfBv/2hNb3C3nptTuXmZZFhY/iAaxLmYV15C3Xupom2RnHxysGrR
	CthAwyKfTJPv+lAOckOvZFoJODuVTgiRLQM3jf1kwrgS2OmF0+Kywx1/MVwEdIAOS1bQH/
	TcOyewRDRNUc5bjXqeaYj80GbqZIPLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-7fyKc7QAM6ucwhpKYuVyPg-1; Thu, 13 Mar 2025 14:39:21 -0400
X-MC-Unique: 7fyKc7QAM6ucwhpKYuVyPg-1
X-Mimecast-MFC-AGG-ID: 7fyKc7QAM6ucwhpKYuVyPg_1741891160
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso9212655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891160; x=1742495960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIXhFaXlgWKMY6E2E9lOQ4OE0U5BJyhpkmUcGXvVRHM=;
        b=mXb9vhA4gAHc2mcDTqp9NypEEsrKHEn/uX5pVY99ufTm0lGv13dwrUvEjmqSE3BY6t
         y0u5OIqtmklnolSpLBV6YRnhF1mnJiIx/bEWCJKsC1dFkeNyQaPmP03GVwc6ZycE2j4F
         G2btG8ZvwaO+QZz51786zPbxVzM6RtZMncKTVRyZFoKBDBRLs6CRsMrakCfkocj4YrOE
         zAud+BDQ6nrc4MZnJm5qfxklNX4NYNKkh/0sxHFKbFiZuwOtcPGbelxbjbr5v83QGZy2
         uv/XGmyFS/Y6C/xDNDI3VabI2R1ctFNpzgmR5bRJ4wWULsYDeXxVl9ZPvp7PnHh82AOj
         d8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0et9vNFit9hRBhBIlKo0RfcbNAad+jFqQVH2BX4ZTBzdFKhSm0I+c8HRzCwYpAVJi60ExoFSpaq0OUMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDO9/iAEZl92gGjMxXQ3bwx2eQX/Zt+x84dCWrOY03TrjemleM
	f0ByF42ned/eVznXEsdTww4CUkhx1yKERzDll8mHuwgSFHnvc17wgxqeRNT/tqsd4cT7fK2vNcR
	wVJqEkRJT0fEA2VZLya/2QRSl3+ZlywFdRPFW6jeJEb8q+r4kkVOlHtvt9z3QG65EV/fXG2qU7f
	NqhLgp+cHFSvA9uzj0ILgUGhy5jzCc6Ni5LTC1
X-Gm-Gg: ASbGncsdVuGIIKTIja9EG5PxjPHOcS2JA5DChG92O5Ac7Hj4bHT2Jokg4dlmFBTY8Rx
	2Rlvc/XbHfo1/jz7titrTvqRMV4yQGzwiXUdkORkLtD9PpW1Hft3gwi/EvjUq7N2gDKYl9ng6
X-Received: by 2002:a05:6000:4010:b0:38f:3e1c:211d with SMTP id ffacd0b85a97d-396c2010a8dmr570484f8f.14.1741891159980;
        Thu, 13 Mar 2025 11:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt7a6SuRu4fgcrchPx6ocV1zBA0o3li0YFfxZs1RsrBuYJHPTJewdPf6xpfbWFG6mFZ9aMEretZO535dDQnxs=
X-Received: by 2002:a05:6000:4010:b0:38f:3e1c:211d with SMTP id
 ffacd0b85a97d-396c2010a8dmr570460f8f.14.1741891159448; Thu, 13 Mar 2025
 11:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313181629.17764-1-adrian.hunter@intel.com>
In-Reply-To: <20250313181629.17764-1-adrian.hunter@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Mar 2025 19:39:07 +0100
X-Gm-Features: AQ5f1JoZ2w8ww1IShma0F6EgJnoOHc5m_8nR3TMD9UTGF4-bZt012DRA_G-9BeE
Message-ID: <CABgObfZYjdW_Mp3JB0z38-RoAdhr4rwjzb_AOYfrmwZZ0ERBsw@mail.gmail.com>
Subject: Re: [PATCH RFC] KVM: TDX: Defer guest memory removal to decrease
 shutdown time
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:16=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
> Improve TDX shutdown performance by adding a more efficient shutdown
> operation at the cost of adding separate branches for the TDX MMU
> operations for normal runtime and shutdown.  This more efficient method w=
as
> previously used in earlier versions of the TDX patches, but was removed t=
o
> simplify the initial upstreaming.  This is an RFC, and still needs a prop=
er
> upstream commit log. It is intended to be an eventual follow up to base
> support.

In the latest code the HKID is released in kvm_arch_pre_destroy_vm().
That is before kvm_free_memslot() calls kvm_gmem_unbind(), which
results in fput() and hence kvm_gmem_release().

So, as long as userspace doesn't remove the memslots and close the
guestmemfds, shouldn't the TD_TEARDOWN method be usable?

Paolo

> =3D=3D Background =3D=3D
>
> TDX has 2 methods for the host to reclaim guest private memory, depending
> on whether the TD (TDX VM) is in a runnable state or not.  These are
> called, respectively:
>   1. Dynamic Page Removal
>   2. Reclaiming TD Pages in TD_TEARDOWN State
>
> Dynamic Page Removal is much slower.  Reclaiming a 4K page in TD_TEARDOWN
> state can be 5 times faster, although that is just one part of TD shutdow=
n.
>
> =3D=3D Relevant TDX Architecture =3D=3D
>
> Dynamic Page Removal is slow because it has to potentially deal with a
> running TD, and so involves a number of steps:
>         Block further address translation
>         Exit each VCPU
>         Clear Secure EPT entry
>         Flush/write-back/invalidate relevant caches
>
> Reclaiming TD Pages in TD_TEARDOWN State is fast because the shutdown
> procedure (refer tdx_mmu_release_hkid()) has already performed the releva=
nt
> flushing.  For details, see TDX Module Base Spec October 2024 sections:
>
>         7.5.   TD Teardown Sequence
>         5.6.3. TD Keys Reclamation, TLB and Cache Flush
>
> Essentially all that remains then is to take each page away from the
> TDX Module and return it to the kernel.
>
> =3D=3D Problem =3D=3D
>
> Currently, Dynamic Page Removal is being used when the TD is being
> shutdown for the sake of having simpler initial code.
>
> This happens when guest_memfds are closed, refer kvm_gmem_release().
> guest_memfds hold a reference to struct kvm, so that VM destruction canno=
t
> happen until after they are released, refer kvm_gmem_release().
>
> Reclaiming TD Pages in TD_TEARDOWN State was seen to decrease the total
> reclaim time.  For example:
>
>         VCPUs   Size (GB)       Before (secs)   After (secs)
>          4       18              72              24
>         32      107             517             134
>
> Note, the V19 patch set:
>
>         https://lore.kernel.org/all/cover.1708933498.git.isaku.yamahata@i=
ntel.com/
>
> did not have this issue because the HKID was released early, something th=
at
> Sean effectively NAK'ed:
>
>         "No, the right answer is to not release the HKID until the VM is
>         destroyed."
>
>         https://lore.kernel.org/all/ZN+1QHGa6ltpQxZn@google.com/
>
> That was taken on board in the "TDX MMU Part 2" patch set.  Refer
> "Moving of tdx_mmu_release_hkid()" in:
>
>         https://lore.kernel.org/kvm/20240904030751.117579-1-rick.p.edgeco=
mbe@intel.com/
>
> =3D=3D Options =3D=3D
>
>   1. Start TD teardown earlier so that when pages are removed,
>   they can be reclaimed faster.
>   2. Defer page removal until after TD teardown has started.
>   3. A combination of 1 and 2.
>
> Option 1 is problematic because it means putting the TD into a non-runnab=
le
> state while it is potentially still active. Also, as mentioned above, Sea=
n
> effectively NAK'ed it.
>
> Option 2 is possible because the lifetime of guest memory pages is separa=
te
> from guest_memfd (struct kvm_gmem) lifetime.
>
> A reference is taken to pages when they are faulted in, refer
> kvm_gmem_get_pfn().  That reference is not released until the pages are
> removed from the mirror SEPT, refer tdx_unpin().
>
> Option 3 is not needed because TD teardown begins during VM destruction
> before pages are reclaimed.  TD_TEARDOWN state is entered by
> tdx_mmu_release_hkid(), whereas pages are reclaimed by tdp_mmu_zap_root()=
,
> as follows:
>
>     kvm_arch_destroy_vm()
>         ...
>         vt_vm_pre_destroy()
>             tdx_mmu_release_hkid()
>         ...
>         kvm_mmu_uninit_vm()
>             kvm_mmu_uninit_tdp_mmu()
>                 kvm_tdp_mmu_invalidate_roots()
>                 kvm_tdp_mmu_zap_invalidated_roots()
>                     tdp_mmu_zap_root()
>
> =3D=3D Proof of Concept for option 2 =3D=3D
>
> Assume user space never needs to close a guest_memfd except as part of VM
> shutdown.
>
> Add a callback from kvm_gmem_release() to decide whether to defer removal=
.
> For TDX, record the inode (up to a max. of 64 inodes) and pin it.
>
> Amend the release of guest_memfds to skip removing pages from the MMU
> in that case.
>
> Amend TDX private memory page removal to detect TD_TEARDOWN state, and
> reclaim the page accordingly.
>
> For TDX, finally unpin any pinned inodes.
>
> This hopefully illustrates what needs to be done, but guidance is sought
> for the best way to do it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  3 ++
>  arch/x86/kvm/Kconfig               |  1 +
>  arch/x86/kvm/vmx/main.c            | 12 +++++++-
>  arch/x86/kvm/vmx/tdx.c             | 47 +++++++++++++++++++++++++-----
>  arch/x86/kvm/vmx/tdx.h             | 14 +++++++++
>  arch/x86/kvm/vmx/x86_ops.h         |  2 ++
>  arch/x86/kvm/x86.c                 |  7 +++++
>  include/linux/kvm_host.h           |  5 ++++
>  virt/kvm/Kconfig                   |  4 +++
>  virt/kvm/guest_memfd.c             | 26 ++++++++++++-----
>  11 files changed, 107 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kv=
m-x86-ops.h
> index 79406bf07a1c..e4728f1fe646 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -148,6 +148,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
>  KVM_X86_OP_OPTIONAL(gmem_invalidate)
> +KVM_X86_OP_OPTIONAL_RET0(gmem_defer_removal)
>
>  #undef KVM_X86_OP
>  #undef KVM_X86_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 9b9dde476f3c..d1afb4e1c2ee 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1661,6 +1661,8 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest=
_mode_logical)
>         return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL=
;
>  }
>
> +struct inode;
> +
>  struct kvm_x86_ops {
>         const char *name;
>
> @@ -1888,6 +1890,7 @@ struct kvm_x86_ops {
>         int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, in=
t max_order);
>         void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>         int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
> +       int (*gmem_defer_removal)(struct kvm *kvm, struct inode *inode);
>  };
>
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 0d445a317f61..32c4b9922e7b 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -96,6 +96,7 @@ config KVM_INTEL
>         depends on KVM && IA32_FEAT_CTL
>         select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
>         select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
> +       select HAVE_KVM_ARCH_GMEM_DEFER_REMOVAL if INTEL_TDX_HOST
>         help
>           Provides support for KVM on processors equipped with Intel's VT
>           extensions, a.k.a. Virtual Machine Extensions (VMX).
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 94d5d907d37b..b835006e1282 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -888,6 +888,14 @@ static int vt_gmem_private_max_mapping_level(struct =
kvm *kvm, kvm_pfn_t pfn)
>         return 0;
>  }
>
> +static int vt_gmem_defer_removal(struct kvm *kvm, struct inode *inode)
> +{
> +       if (is_td(kvm))
> +               return tdx_gmem_defer_removal(kvm, inode);
> +
> +       return 0;
> +}
> +
>  #define VMX_REQUIRED_APICV_INHIBITS                            \
>         (BIT(APICV_INHIBIT_REASON_DISABLED) |                   \
>          BIT(APICV_INHIBIT_REASON_ABSENT) |                     \
> @@ -1046,7 +1054,9 @@ struct kvm_x86_ops vt_x86_ops __initdata =3D {
>         .mem_enc_ioctl =3D vt_mem_enc_ioctl,
>         .vcpu_mem_enc_ioctl =3D vt_vcpu_mem_enc_ioctl,
>
> -       .private_max_mapping_level =3D vt_gmem_private_max_mapping_level
> +       .private_max_mapping_level =3D vt_gmem_private_max_mapping_level,
> +
> +       .gmem_defer_removal =3D vt_gmem_defer_removal,
>  };
>
>  struct kvm_x86_init_ops vt_init_ops __initdata =3D {
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index d9eb20516c71..51bbb44ac1bd 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -5,6 +5,7 @@
>  #include <asm/fpu/xcr.h>
>  #include <linux/misc_cgroup.h>
>  #include <linux/mmu_context.h>
> +#include <linux/fs.h>
>  #include <asm/tdx.h>
>  #include "capabilities.h"
>  #include "mmu.h"
> @@ -594,10 +595,20 @@ static void tdx_reclaim_td_control_pages(struct kvm=
 *kvm)
>         kvm_tdx->td.tdr_page =3D NULL;
>  }
>
> +static void tdx_unpin_inodes(struct kvm *kvm)
> +{
> +       struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
> +
> +       for (int i =3D 0; i < kvm_tdx->nr_gmem_inodes; i++)
> +               iput(kvm_tdx->gmem_inodes[i]);
> +}
> +
>  void tdx_vm_destroy(struct kvm *kvm)
>  {
>         struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
>
> +       tdx_unpin_inodes(kvm);
> +
>         tdx_reclaim_td_control_pages(kvm);
>
>         kvm_tdx->state =3D TD_STATE_UNINITIALIZED;
> @@ -1778,19 +1789,28 @@ int tdx_sept_free_private_spt(struct kvm *kvm, gf=
n_t gfn,
>         return tdx_reclaim_page(virt_to_page(private_spt));
>  }
>
> +static int tdx_sept_teardown_private_spte(struct kvm *kvm, enum pg_level=
 level, struct page *page)
> +{
> +       int ret;
> +
> +       if (level !=3D PG_LEVEL_4K)
> +               return -EINVAL;
> +
> +       ret =3D tdx_reclaim_page(page);
> +       if (!ret)
> +               tdx_unpin(kvm, page);
> +
> +       return ret;
> +}
> +
>  int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
>                                  enum pg_level level, kvm_pfn_t pfn)
>  {
>         struct page *page =3D pfn_to_page(pfn);
>         int ret;
>
> -       /*
> -        * HKID is released after all private pages have been removed, an=
d set
> -        * before any might be populated. Warn if zapping is attempted wh=
en
> -        * there can't be anything populated in the private EPT.
> -        */
> -       if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
> -               return -EINVAL;
> +       if (!is_hkid_assigned(to_kvm_tdx(kvm)))
> +               return tdx_sept_teardown_private_spte(kvm, level, pfn_to_=
page(pfn));
>
>         ret =3D tdx_sept_zap_private_spte(kvm, gfn, level, page);
>         if (ret <=3D 0)
> @@ -3221,6 +3241,19 @@ int tdx_gmem_private_max_mapping_level(struct kvm =
*kvm, kvm_pfn_t pfn)
>         return PG_LEVEL_4K;
>  }
>
> +int tdx_gmem_defer_removal(struct kvm *kvm, struct inode *inode)
> +{
> +       struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
> +
> +       if (kvm_tdx->nr_gmem_inodes >=3D TDX_MAX_GMEM_INODES)
> +               return 0;
> +
> +       kvm_tdx->gmem_inodes[kvm_tdx->nr_gmem_inodes++] =3D inode;
> +       ihold(inode);
> +
> +       return 1;
> +}
> +
>  static int tdx_online_cpu(unsigned int cpu)
>  {
>         unsigned long flags;
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index 6b3bebebabfa..fb5c4face131 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -20,6 +20,10 @@ enum kvm_tdx_state {
>         TD_STATE_RUNNABLE,
>  };
>
> +struct inode;
> +
> +#define TDX_MAX_GMEM_INODES 64
> +
>  struct kvm_tdx {
>         struct kvm kvm;
>
> @@ -43,6 +47,16 @@ struct kvm_tdx {
>          * Set/unset is protected with kvm->mmu_lock.
>          */
>         bool wait_for_sept_zap;
> +
> +       /*
> +        * For pages that will not be removed until TD shutdown, the asso=
ciated
> +        * guest_memfd inode is pinned.  Allow for a fixed number of pinn=
ed
> +        * inodes.  If there are more, then when the guest_memfd is close=
d,
> +        * their pages will be removed safely but inefficiently prior to
> +        * shutdown.
> +        */
> +       struct inode *gmem_inodes[TDX_MAX_GMEM_INODES];
> +       int nr_gmem_inodes;
>  };
>
>  /* TDX module vCPU states */
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 4704bed033b1..4ee123289d85 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -164,6 +164,7 @@ void tdx_flush_tlb_current(struct kvm_vcpu *vcpu);
>  void tdx_flush_tlb_all(struct kvm_vcpu *vcpu);
>  void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_le=
vel);
>  int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
> +int tdx_gmem_defer_removal(struct kvm *kvm, struct inode *inode);
>  #else
>  static inline void tdx_disable_virtualization_cpu(void) {}
>  static inline int tdx_vm_init(struct kvm *kvm) { return -EOPNOTSUPP; }
> @@ -229,6 +230,7 @@ static inline void tdx_flush_tlb_current(struct kvm_v=
cpu *vcpu) {}
>  static inline void tdx_flush_tlb_all(struct kvm_vcpu *vcpu) {}
>  static inline void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hp=
a, int root_level) {}
>  static inline int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kv=
m_pfn_t pfn) { return 0; }
> +static inline int tdx_gmem_defer_removal(struct kvm *kvm, struct inode *=
inode) { return 0; }
>  #endif
>
>  #endif /* __KVM_X86_VMX_X86_OPS_H */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 03db366e794a..96ebf0303223 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13659,6 +13659,13 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, k=
vm_pfn_t end)
>  }
>  #endif
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_DEFER_REMOVAL
> +bool kvm_arch_gmem_defer_removal(struct kvm *kvm, struct inode *inode)
> +{
> +       return kvm_x86_call(gmem_defer_removal)(kvm, inode);
> +}
> +#endif
> +
>  int kvm_spec_ctrl_test_value(u64 value)
>  {
>         /*
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d72ba0a4ca0e..f5c8b1923c24 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2534,6 +2534,11 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm=
,
>  int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int=
 max_order);
>  #endif
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_DEFER_REMOVAL
> +struct inode;
> +bool kvm_arch_gmem_defer_removal(struct kvm *kvm, struct inode *inode);
> +#endif
> +
>  #ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
>  /**
>   * kvm_gmem_populate() - Populate/prepare a GPA range with guest data
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 54e959e7d68f..589111505ad0 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -124,3 +124,7 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
>  config HAVE_KVM_ARCH_GMEM_INVALIDATE
>         bool
>         depends on KVM_PRIVATE_MEM
> +
> +config HAVE_KVM_ARCH_GMEM_DEFER_REMOVAL
> +       bool
> +       depends on KVM_PRIVATE_MEM
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b2aa6bf24d3a..cd485f45fdaf 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -248,6 +248,15 @@ static long kvm_gmem_fallocate(struct file *file, in=
t mode, loff_t offset,
>         return ret;
>  }
>
> +inline bool kvm_gmem_defer_removal(struct kvm *kvm, struct inode *inode)
> +{
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_DEFER_REMOVAL
> +       return kvm_arch_gmem_defer_removal(kvm, inode);
> +#else
> +       return false;
> +#endif
> +}
> +
>  static int kvm_gmem_release(struct inode *inode, struct file *file)
>  {
>         struct kvm_gmem *gmem =3D file->private_data;
> @@ -275,13 +284,16 @@ static int kvm_gmem_release(struct inode *inode, st=
ruct file *file)
>         xa_for_each(&gmem->bindings, index, slot)
>                 WRITE_ONCE(slot->gmem.file, NULL);
>
> -       /*
> -        * All in-flight operations are gone and new bindings can be crea=
ted.
> -        * Zap all SPTEs pointed at by this file.  Do not free the backin=
g
> -        * memory, as its lifetime is associated with the inode, not the =
file.
> -        */
> -       kvm_gmem_invalidate_begin(gmem, 0, -1ul);
> -       kvm_gmem_invalidate_end(gmem, 0, -1ul);
> +       if (!kvm_gmem_defer_removal(kvm, inode)) {
> +               /*
> +                * All in-flight operations are gone and new bindings can=
 be
> +                * created.  Zap all SPTEs pointed at by this file.  Do n=
ot free
> +                * the backing memory, as its lifetime is associated with=
 the
> +                * inode, not the file.
> +                */
> +               kvm_gmem_invalidate_begin(gmem, 0, -1ul);
> +               kvm_gmem_invalidate_end(gmem, 0, -1ul);
> +       }
>
>         list_del(&gmem->entry);
>
> --
> 2.43.0
>


