Return-Path: <linux-kernel+bounces-435811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A857C9E7D68
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A521885648
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8622C6D4;
	Sat,  7 Dec 2024 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgCvycJ6"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405D4C79
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530667; cv=none; b=MLuIGz6z025BMgDSy58sntc0FDaGjwiei9YL+dLWU/lsUOcxDGOdwGTYC5w6bNXQ72v4k94TQVwqZHjFvwE3b0ndqWGnShqn52ozci6hgVPp0HwuUqr6c8ZkHge6CMTkICcSChSWmfRJlqCHoZuPMrn33nIT42R0JuZgTl03ndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530667; c=relaxed/simple;
	bh=lmVtUmbXJYlwllzdAUdJf2cGRYnT83rHhiMLlga66gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USEz1JsY/tyu9qhxU2EpQB46YjKqzJZMsfWFKq5Qr50AgnGKLJXARklEgKLmCVT3ksace7p8EPv8rxp8gu2u/KRxAWcwRpXt8/pT4KDqfp4JiQWGhLu9wVVWOXLIAAXjo4HJb6aJOGEUWK4BbEN/IJBb7hS4XOhNCFRJ2CULzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgCvycJ6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fb96d3a3a8so1848011a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733530665; x=1734135465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSQV3qsl7yB+W5oK+vdpyFn0FmZ9MSGpZvpg0XcYFs=;
        b=AgCvycJ6kuR0W+NDUMfsSCfFZZ42mibqUFgAyn7AntSzf9+w+JDilan54Ue9gkYVQX
         k+dKY4fNpBXvzBEOSpEXt/hER+IyhPI7xQ/a2T35oQWjLX3WigGzZl1lhMXQyk8SnCW8
         PghGH96ssf+kcBbSJyjavHZZZYHwmNBTxTR5/uG+k5nLbPmLHGLa/u17WR7yJhKVHHn3
         JQslkeKl6wfkzytr5XirJcRkbHSEsKga5GG2CC3jjfTLSTVy2QVOx7tN0nJLjPY/Jgft
         KsH8pjbyCVl0MC9SG+uLZ7mn58VbhykPefRRjikk4q+TxbzF+EmpzEGZCb+oKEwagQyY
         5Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733530665; x=1734135465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSQV3qsl7yB+W5oK+vdpyFn0FmZ9MSGpZvpg0XcYFs=;
        b=ntsOyVdRRXXYshuIRcNcxNocgdLPy+XTY4MVDH/4A33fGzSm0UbVWY0uXHYbvrbnWO
         l9an9wKSgLnDZgxFo3BEjGulUTRJtd0g42i1frwh1TAOdLPxMw9wKzEhs7UGhF65qBdQ
         taId7yUtx7YJSg/YLt3b9kOvRrx3ypO18FfPnev6eypqaTsbcx0g6p5ikWVVEKMJwyIL
         iWQgC3TUC9iAouhHQ1CrLVrSViOq7qIfczKJhO/dTexpridKx0O1yWEtNbNAXUbVlFQD
         wVdcUuZa8FzBVg4yc1NasR89wHnRLSiegMT2LzWnkFxIKVxa92kR+Hxl5vVpALSwBPYJ
         vWuA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kf1DZhN0KtdRZzCWh5U9hhyeEBfv89gR2pj/9hwWmZpctq7ak9JEFmtsvWunlNI6cl9iAnqurTNFqug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6m+GCdtOuJKxn1KLwHk2sUoNtIf5TxcB71kryl0FGNulHg+5W
	ATWEqpf1detPmdvymvm3Z/si5sE3+WsGxfoAjzKq76Wya7CK0TyhmAXnIyxcxQ9Y7lQAgC9F0QT
	Lqg==
X-Google-Smtp-Source: AGHT+IFDHCpcba/+sH0h4Qr+MhiXt9V/2d/vXmf0Ikah2STYAzva1gFupjXJrZbsCGPyU/par5DxzhHMV0M=
X-Received: from pjbnw8.prod.google.com ([2002:a17:90b:2548:b0:2ea:29de:af10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4d:b0:2ee:ab29:1a57
 with SMTP id 98e67ed59e1d1-2ef6955f8e3mr7286524a91.2.1733530665176; Fri, 06
 Dec 2024 16:17:45 -0800 (PST)
Date: Fri, 6 Dec 2024 16:17:43 -0800
In-Reply-To: <20241130132702.1974626-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241130132702.1974626-1-kniv@yandex-team.ru>
Message-ID: <Z1OUJyni0aZQPHMG@google.com>
Subject: Re: [PATCH 6.6] KVM: x86/mmu: Ensure that kvm_release_pfn_clean()
 takes exact pfn from kvm_faultin_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"

On Sat, Nov 30, 2024, Nikolay Kuratov wrote:
> Since 5.16 and prior to 6.13 KVM can't be used with FSDAX
> guest memory (PMD pages). To reproduce the issue you need to reserve
> guest memory with `memmap=` cmdline, create and mount FS in DAX mode
> (tested both XFS and ext4), see doc link below. ndctl command for test:
> ndctl create-namespace -v -e namespace1.0 --map=dev --mode=fsdax -a 2M
> Then pass memory object to qemu like:
> -m 8G -object memory-backend-file,id=ram0,size=8G,\
> mem-path=/mnt/pmem/guestmem,share=on,prealloc=on,dump=off,align=2097152 \
> -numa node,memdev=ram0,cpus=0-1
> QEMU fails to run guest with error: kvm run failed Bad address
> and there are two warnings in dmesg:
> WARN_ON_ONCE(!page_count(page)) in kvm_is_zone_device_page() and
> WARN_ON_ONCE(folio_ref_count(folio) <= 0) in try_grab_folio() (v6.6.63)
> 
> It looks like in the past assumption was made that pfn won't change from
> faultin_pfn() to release_pfn_clean(), e.g. see
> commit 4cd071d13c5c ("KVM: x86/mmu: Move calls to thp_adjust() down a level")
> But kvm_page_fault structure made pfn part of mutable state, so
> now release_pfn_clean() can take hugepage-adjusted pfn.
> And it works for all cases (/dev/shm, hugetlb, devdax) except fsdax.
> Apparently in fsdax mode faultin-pfn and adjusted-pfn may refer to
> different folios, so we're getting get_page/put_page imbalance.

Oof.  Yeah, KVM definitely doesn't expect huge page mappings to straddle multiple
struct pages.

> To solve this preserve faultin pfn in separate kvm_page_fault
> field and pass it in kvm_release_pfn_clean(). Patch tested for all
> mentioned guest memory backends with tdp_mmu={0,1}.
> 
> No bug in upstream as it was solved fundamentally by
> commit 8dd861cc07e2 ("KVM: x86/mmu: Put refcounted pages instead of blindly releasing pfns")
> and related patch series.
> 
> Link: https://nvdimm.docs.kernel.org/2mib_fs_dax.html
> Fixes: 2f6305dd5676 ("KVM: MMU: change kvm_tdp_mmu_map() arguments to kvm_page_fault")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 5 +++--
>  arch/x86/kvm/mmu/mmu_internal.h | 2 ++
>  arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 294775b7383b..2105f3bc2e59 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4321,6 +4321,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
>  	smp_rmb();
>  
>  	ret = __kvm_faultin_pfn(vcpu, fault);
> +	fault->faultin_pfn = fault->pfn;

This fix should go to 6.12 and 6.1 as well, and so I'm leaning toward using a local
variable to snapshot the original PFN, even though (a) it's more churn and (b)
it's theoretically less robust.

6.12 has an unaffected kvm_release_pfn_clean(fault->pfn).  Using a local variable
means the same fix+code can live in all relevant LTS kernels without creating
weirdness (leaving behind the unaffected call).  For me, that's worth the churn.

As far as it potentially being less robust, if something modifies fault->pfn
between kvm_faultin_pfn() and acquiring mmu_lock, KVM has far bigger problems.

(untested)

---
 arch/x86/kvm/mmu/mmu.c         | 10 ++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8e853a5fc867..f5a7d89ea68d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4580,6 +4580,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
+	kvm_pfn_t orig_pfn;
 	int r;
 
 	/* Dummy roots are used only for shadowing bad guest roots. */
@@ -4601,6 +4602,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r != RET_PF_CONTINUE)
 		return r;
 
+	orig_pfn = fault->pfn;
+
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
@@ -4615,7 +4618,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	kvm_release_pfn_clean(orig_pfn);
 	return r;
 }
 
@@ -4675,6 +4678,7 @@ EXPORT_SYMBOL_GPL(kvm_handle_page_fault);
 static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 				  struct kvm_page_fault *fault)
 {
+	kvm_pfn_t orig_pfn;
 	int r;
 
 	if (page_fault_handle_page_track(vcpu, fault))
@@ -4692,6 +4696,8 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 	if (r != RET_PF_CONTINUE)
 		return r;
 
+	orig_pfn = fault->pfn;
+
 	r = RET_PF_RETRY;
 	read_lock(&vcpu->kvm->mmu_lock);
 
@@ -4702,7 +4708,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 
 out_unlock:
 	read_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	kvm_release_pfn_clean(orig_pfn);
 	return r;
 }
 #endif
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ae7d39ff2d07..b08017683920 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -778,6 +778,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct guest_walker walker;
+	kvm_pfn_t orig_pfn;
 	int r;
 
 	WARN_ON_ONCE(fault->is_tdp);
@@ -836,6 +837,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 
+	orig_pfn = fault->pfn;
+
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
@@ -849,7 +852,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	kvm_release_pfn_clean(orig_pfn);
 	return r;
 }
 

base-commit: adc218676eef25575469234709c2d87185ca223a
--

