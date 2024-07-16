Return-Path: <linux-kernel+bounces-254342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DED933202
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A691F24CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB21A01C6;
	Tue, 16 Jul 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVNq/fUb"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4B1CD2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158316; cv=none; b=r1hzu3BvxZCRL66Ka1BQcg/IWWYXaxsbhSUtE2gaJm15/GL15sHu642IiMUxL2XrY2AfiD7pVKbpDIjjb0zbmjJrbD4FIbM1If5In8NlKOgSKTO+W0PV4vuTAcV2KSX1jocA0QZO0gcz54hrwSifel0kmesPj416E5D0YcFegiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158316; c=relaxed/simple;
	bh=c8UzbSu94SHZlCBc7Dko7y4EM7V9wstxHkNN0vs0sHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZsWBXN2XWRVlNyI3REsjGVoinjddk+JMpWdjTuqScjK5h7yJADj+ml+e6m7r+Y8s1Y0vvhel8stRAu0N9WfYygVgie9w4aD3rP6abGsZcrDP4NrOVsg2Pc+Ic7oZ2vaCVe4Vn9wSiQCBkvG3fHUXy7n6eRJFj3dVNUAvAQwa0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVNq/fUb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70afd833ba9so3359762b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721158314; x=1721763114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJoNCYn7js3hz23PZCgEw2FtBVSDvq0l3C/wykvag0=;
        b=fVNq/fUbCqfARQX5RRKMg5ujkZJujD6Y49ym4NFhPydh+SR0RUTG5GV3XNJTyklLnN
         EVC7LsNYPU2tOFFgKhE6bSBfqvRrADQv/4NWz9ymAJsP2If2oHmUx2fpUwGdj7zIzu1B
         AYqc6tY3ELhn3Vdd4FCEVflbbepiBIZyvbMT2Qa5RjQ2DPYnkQLnkZTAPAR6iyJ046RM
         a9ZbJYyI82qbrdRqXS2kL8SO9BtLepgry5835MuprMy6PC76nI2DEvOav+fN6JQfMveK
         mLfF8l4oNvLirZqq6xcwDFRqwqRG8BRzRcZ6C6ZtkLnRrdkHwi8kmjk9vD46JFUy7ajl
         R8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721158314; x=1721763114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJoNCYn7js3hz23PZCgEw2FtBVSDvq0l3C/wykvag0=;
        b=I63CkgumUGLMbAku4pIiVrENB7JdZW3udHNU3GZrCysY65UnkF/XO90IKbo34kSQPx
         Hh98LY5fM5wPKcTm39LDUQ4vQ9GGbvBNyTHatDuAy6KQ4r8rS3yauBY5U/Hvohzzvq5G
         LZbxGpxkRtYi1oIj0fAZ9bz5Eh7P9TplRJVJhQS75nGWseNKajuh+taZMpGo4b2VXczA
         AXOUCJ0zHDfa/ICmSosYmcECN9oIy5dcOSrJm/5rJOqf4I7qU6nH7dyFTNMtR+nzO9nf
         B3YYImJUKp0lK5XnXZboDY3nRk/bWoStr5+bf+jpuPy9LCv0UTeF/ixYMjuvzlHUm8SE
         6WGA==
X-Forwarded-Encrypted: i=1; AJvYcCW4R9bEGObN+bDmXXYhks1++q+q8dY2dTzJQr/V8PQkUuxnvfE3J6RlEPZVbTYZALygDRlWxMre6/1a72T4bNenyUgSuOu9Kb/GGCc8
X-Gm-Message-State: AOJu0Ywol91XtFe6h/WzSS2P67iLXKLpWWVwq6EP1cqiemSrp+8Hz7Rd
	0NqNMhoKJ9ce3k6ca5sK7gwo+udfKVYBqtGlllHt33mhtYsTLd8CaEuVpuna5lk4Ty6AwCr1KLR
	VhA==
X-Google-Smtp-Source: AGHT+IHzKKMLIUP4x9S22RErcOWeGFNe3jUdiw80u+WvUdaciKtVUPOhD43xVzlWxPTnAmN35iApP23KZVY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1891:b0:70b:1086:cf8c with SMTP id
 d2e1a72fcca58-70c2ea732dcmr237619b3a.6.1721158313928; Tue, 16 Jul 2024
 12:31:53 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:31:52 -0700
In-Reply-To: <fdddad066c88c6cd8f2090f11e32e54f7d5c6178.1721092739.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <fdddad066c88c6cd8f2090f11e32e54f7d5c6178.1721092739.git.isaku.yamahata@intel.com>
Message-ID: <ZpbKqG_ZhCWxl-Fc@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Allow per VM kvm_mmu_max_gfn()
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 15, 2024, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Prepare for TDX support by making kvm_mmu_max_gfn() configurable.  Have
> this preparation also be useful by non-TDX changes to improve correctness
> associated with the combination of 4-level EPT and MAXPA > 48.  The issue
> is analyzed at [1].
> 
> Like other confidential computing technologies, TDX has the concept of
> private and shared memory.  For TDX, the private and shared mappings of the
> same GFN are mapped at separate GPAs, with a configurable GPA bit selecting
> between private and shared aliases of the same GFN.  This means that
> operations working with the concept of a maximum GFN should only go up to
> this configurable GPA bit instead of the existing behavior based on
> shadow_phys_bits.  Other TDX changes will handle applying the operation
> across both GFN aliases.

This is going to be confusing.  A TDX will be all but guaranteed to generate an
EPT violation on a gfn > kvm->mmu_max_gfn.

> Using the existing kvm_mmu_max_gfn() based on shadow_phys_bits would cause
> functional problems for TDX.  Specifically, because the function is used to
> restrict the range where memslots can be created.  For TDX, if a memslot is
> created at a GFN that includes the bit that selects between private/shared,
> it would confuse the logic that zaps both aliases.  It would end up zapping
> only the higher alias and missing the lower one.  In this case, freed pages
> could remain mapped in the TDX guest.

So why don't we simply disallow creating aliased memslots?

> Since this GPA bit is configurable per-VM, make kvm_mmu_max_gfn() per-VM by
> having it take a struct kvm, and keep the max GFN as a member on that
> struct.  Future TDX changes will set this member based on the configurable
> position of the private/shared bit.
> 
> Besides functional issues, it is generally more correct and easier to

No, it most definitely is not more correct.  There is absolutely no issue zapping
SPTEs that should never exist.  In fact, restricting the zapping path is far more
likely to *cause* correctness issues, e.g. see 

  524a1e4e381f ("KVM: x86/mmu: Don't leak non-leaf SPTEs when zapping all SPTEs")
  86931ff7207b ("KVM: x86/mmu: Do not create SPTEs for GFNs that exceed host.MAXPHYADDR")

Creating SPTEs is a different matter, but unless I'm missing something, the only
path that _needs_ to be updated is kvm_arch_prepare_memory_region(), to disallow
aliased memslots.

I assume TDX will strip the shared bit from fault->gfn, and shove it back in when
creating MMIO SPTEs in the shared EPT page tables.

Why can't we simply do:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 842a3a4cdfe9..5ea428dde891 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4395,6 +4395,9 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
        struct kvm_memory_slot *slot = fault->slot;
        int ret;
 
+       if (WARN_ON_ONCE(vcpu->kvm, kvm_is_gfn_alias(fault->gfn)))
+               return -EFAULT;
+
        /*
         * Note that the mmu_invalidate_seq also serves to detect a concurrent
         * change in attributes.  is_page_fault_stale() will detect an
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 994743266480..091da7607025 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12979,6 +12979,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
                if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn())
                        return -EINVAL;
 
+               if (kvm_is_gfn_alias(kvm, new->base_gfn + new->npages - 1))
+                       return -EINVAL;
+
                return kvm_alloc_memslot_metadata(kvm, new);
        }

