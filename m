Return-Path: <linux-kernel+bounces-548728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC520A548A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E2C1895FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C620C02B;
	Thu,  6 Mar 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FENp8OQ1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1120B810
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258865; cv=none; b=f7zJloqbv80n8KfNk54TVXNhD34xDZTLFQuDFkMzeZNPiCQUkjLcD19GF5Pj4lalneS+3nZ7z2RgJj7HfiKKlyIkQdT0lvJgw3lx1N8UWgXBOIPGP/3J3kOo8iPDXr5uKsxidXeTy2JVxYRWzYT1JVkvlCMPycMw1Rv7SzztnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258865; c=relaxed/simple;
	bh=VvUXJIr2kKN2xNaqZOPY7Q821Sz9jg0B9W+Kg6n6k7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/VgWnSYUGrtHcI8WcIPbnRFYbAWQYvAeGvxeOQIHkaxq1lU//w6cDEFYmAmQfWmsAS/mt19HaYt1jhrniLzRQamiqR6B4To74ofj8fuhWoUlWF9fCEZG1G90AJVsrDHxSraDsgb1IdMMwbZHq15GhnlaE+DqNfjpvh088WfZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FENp8OQ1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bdcdf193dso2249735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258862; x=1741863662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azWhDzZbtoxtjhQWlpXB32XSGr+Msg3K3f2k/5PFntI=;
        b=FENp8OQ14PlL1v/KkxDEjArvZE0gwR5XoXpeALeSXGCemrwzVqvuLVembVHWg0WB48
         DJ0qqT16eZQseuE4TbW35xQyjQsci0TS2bH2w93W4JifnejrvFKvg8WgWoXVFknmZppb
         ppxl9yFaHexCVDhvFu+xxPoJHHJqkcEL994J96lDMPIKhAj/T7RGqWPiy2TPqAf9TY5x
         DyBM2l1ujhUFItOoXqUhKoNVlT/6FJOqr6tcqXT+EZnIsiMhnS8FCDUT0hfu1dwQSMDn
         ARhBAw9P+l+r1D7Cxl70gF//waMfn1LSqjWVmDmtHlbSt1yyzzVIQl8UINApUT5zjo6A
         Je+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258862; x=1741863662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azWhDzZbtoxtjhQWlpXB32XSGr+Msg3K3f2k/5PFntI=;
        b=v7SOvwj3Wvt/MXGtHveYUBHOzyj9US4DJF5YdYRimza3FPpbYkWnN9sE231zy1a3bg
         Q+evevfMs6cEyVmetErt0wU69yrWmWJz97Axa0bS+iIydVw8JJvItTJJ9YMQqRcE33At
         yfzjTeT7270IhLoo2SPBy6ntnMjQO9gPIAiN2wlO+XPv4qkUGKw+u9cI2gZ53n7cWze5
         uQuxR+mBW+BHYpSNoYJXoLAVBCkXOv1HwJIOJ6/sKjcJaGnc0uoEdGx4wFigDSD8c0G4
         bBWdsQLdao9ON6NFiUoVGXgMsFOWmtKe6hFqe4Q41V4eJ7QYuLbbvhfPR5Jvwd9VecAl
         ZRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsMEGpJitkHLLEP/OLr+alSf8vDa/r7/7c6BjGLJmKN6rQRzLyOa6beXU9cuH68r+vLaAA24WsjZBZToQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBRmBxN6XSYByJ0iB0cnazJNsK+PJvirxJTQfBYFmKvCFMvHt
	dWMEF22a7QYD5T4zh43Y0FXnuIgl5UZUWVwU9BFBQHxvknPrgWrwWLMClNIThxRstb/if4GUGn4
	KvmUwywUo4pEtxcvUrw==
X-Google-Smtp-Source: AGHT+IHaLhB8g0ea9IzCe71YUfuaamK20WvX24Cg501MmU1HL29IV3XbEohWkl/ds2ZX3TqbOYoDRDMXlJjEcXa3
X-Received: from wmbeb18.prod.google.com ([2002:a05:600c:6792:b0:43b:c205:3a80])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4450:b0:439:98ca:e390 with SMTP id 5b1f17b1804b1-43bd2af45eamr50778475e9.27.1741258862389;
 Thu, 06 Mar 2025 03:01:02 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:37 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-9-vdonnefort@google.com>
Subject: [PATCH v2 8/9] KVM: arm64: Stage-2 huge mappings for np-guests
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Now np-guests hypercalls with range are supported, we can let the
hypervisor to install block mappings whenever the Stage-1 allows it,
that is when backed by either Hugetlbfs or THPs. The size of those block
mappings is limited to PMD_SIZE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 61bf26a911e6..b7a995a1d70b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -167,7 +167,7 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 static bool guest_stage2_force_pte_cb(u64 addr, u64 end,
 				      enum kvm_pgtable_prot prot)
 {
-	return true;
+	return false;
 }
 
 static void *guest_s2_zalloc_pages_exact(size_t size)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1f55b0c7b11d..3143f3b52c93 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1525,7 +1525,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * logging_active is guaranteed to never be true for VM_PFNMAP
 	 * memslots.
 	 */
-	if (logging_active || is_protected_kvm_enabled()) {
+	if (logging_active) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
@@ -1535,7 +1535,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+		if (is_protected_kvm_enabled() ||
+		    fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
 			break;
 		fallthrough;
 #endif
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 9c9833f27fe3..b40bcdb1814d 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -342,7 +342,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	u64 pfn = phys >> PAGE_SHIFT;
 	int ret;
 
-	if (size != PAGE_SIZE)
+	if (size != PAGE_SIZE && size != PMD_SIZE)
 		return -EINVAL;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
-- 
2.48.1.711.g2feabab25a-goog


